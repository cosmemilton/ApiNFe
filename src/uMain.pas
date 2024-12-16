unit uMain;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Horse.OctetStream,
  Horse.HandleException,
  Horse.Logger,
  Horse.JWT,
  Horse.Logger.Provider.LogFile,
  Horse.Callback,
  emissorfiscal.controller,
  apinfe.claims,
  emissorfiscal.routertocontroller;


type
  TConsole = procedure(cmd: String);
  TFConsole = function(Req: THorseRequest; Res: THorseResponse; Next: TProc): THorseCallback;

  TApi = class
    private
      FLogFileConfig: THorseLoggerLogFileConfig;
      FController: TControllerApiNFe;
      FAdapter: TAdapterApiNFeController;
      constructor Create;
      function AuthenticatedClient(): Horse.THorseCallback;
      function AuthenticatedAdmin() : Horse.THorseCallback;
    public
      class procedure Initialize();
      {$IFDEF HORSE_ISAPI}
        procedure Listen;
      {$ENDIF}
      {$IFDEF HORSE_CONSOLE}
        procedure Listen(CallBack: TConsole);
        procedure Log(CallBack: THorseCallback);
      {$ENDIF}
      destructor Destroy; override;


  end;
var
  Api: TApi = nil;


implementation

uses
   apinfe.constants, apinfe.dto.config.jwt;

{ TAPI }


function TApi.AuthenticatedAdmin: Horse.THorseCallback;
begin
Result:=  HorseJWT(TJWTConfigDTO.getInstance.PrivateKey, THorseJWTConfig.New.SessionClass(TClaims) );
end;

function TApi.AuthenticatedClient: Horse.THorseCallback;
begin
Result:=  HorseJWT(TJWTConfigDTO.getInstance.PrivateKey, THorseJWTConfig.New.SessionClass(TClaims) );
end;

constructor TApi.Create();
begin
  FController:= TControllerApiNFe.Create();
  FAdapter   := TAdapterApiNFeController.Create(FController);
end;


destructor TApi.Destroy;
begin
  FController.Free;
  FAdapter.Free;
  inherited;
end;

class procedure TApi.Initialize;

begin
  Api:= TApi.Create();

  Api.FLogFileConfig := THorseLoggerLogFileConfig.New
      .SetLogFormat(
        '[${time}] - Method: ${request_method}. Path: ${request_path_info}. ResponseCode: ${response_status}')
      .SetDir(path+'log\');
  THorseLoggerManager.RegisterProvider( THorseLoggerProviderLogFile.New(Api.FLogFileConfig) );


  THorse
    .Use(Jhonson('UTF-8'))
    .Use(CORS)
    .Use(OctetStream)
    .Use(HandleException)
    .Group
      .Prefix(apiBaseAdmin)
      .Post('/login'      , Api.FAdapter.LoginAdmin)
      .Prefix(apiBaseAdmin)
      .AddCallback(Api.AuthenticatedAdmin())
      .Get('/user/all'      , Api.FAdapter.getAllAdminUsers)
      .Prefix(apiBaseAdmin)
      .AddCallback(Api.AuthenticatedAdmin())
      .Get('/company/all'      , Api.FAdapter.getAllCompany)
      .AddCallback(Api.AuthenticatedAdmin())
      .Get('/company/:document'      , Api.FAdapter.getCompany)
      .AddCallback(Api.AuthenticatedAdmin())
      .Put('/company'            , Api.FAdapter.updateCompany)
      .AddCallback(Api.AuthenticatedAdmin())
      .Patch('/company/:document/active', Api.FAdapter.activeCompany)
      .AddCallback(Api.AuthenticatedAdmin())
      .Delete('/company/:document'   , Api.FAdapter.deleteCompany)
      .AddCallback(Api.AuthenticatedAdmin())
      .Post('/company'           , Api.FAdapter.createdCompany)
      .AddCallback(Api.AuthenticatedAdmin())
      .put('/company/:document/environment'  , Api.FAdapter.configIssuance)
      .AddCallback(Api.AuthenticatedAdmin())
      .Get('/company/:document/secret/:id'   , Api.FAdapter.getSecret)
      .AddCallback(Api.AuthenticatedAdmin())
      .post('/company/:document/secret'      , Api.FAdapter.createdSecret)
      .AddCallback(Api.AuthenticatedAdmin())
      .put('/company/:document/secret/:id'   , Api.FAdapter.updateSecret)
      .AddCallback(Api.AuthenticatedAdmin())
      .delete('/company/:document/secret/:id', Api.FAdapter.deleteSecret)
      .AddCallback(Api.AuthenticatedAdmin())
      .Get('/dashboard'                  , Api.FAdapter.getDashboard)
    .&End
    .Group
      .Prefix(apiBase)
      .AddCallback(Api.AuthenticatedClient())
      .Post('/getJWT'                 , Api.FAdapter.getJWT)
      .AddCallback(Api.AuthenticatedClient())
      .Post('/send'       ,  Api.FAdapter.cretedNFe)
      .AddCallback(Api.AuthenticatedClient())
      .Post('/disable'    ,  Api.FAdapter.disableNFe)
      .AddCallback(Api.AuthenticatedClient())
      .Post('/cancel'      ,  Api.FAdapter.cancelNFe)
      .AddCallback(Api.AuthenticatedClient())
      .Get('/xml/:chave'     ,  Api.FAdapter.getXMLbyKey)
      .AddCallback(Api.AuthenticatedClient())
      .Get('/danfe/:chave'   ,  Api.FAdapter.getPDFbyKey)
      .AddCallback(Api.AuthenticatedClient())
      .Get('/getAll'  ,  Api.FAdapter.getAllIssuance);

  THorse.Get('/', procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
            begin
              Res.Status(200);
            end);


end;

{$IFDEF HORSE_CONSOLE}
procedure TApi.Listen(CallBack: TConsole);
begin
  CallBack('Escutando na porta 9000');
  THorse.Listen(9000);
end;

procedure TApi.Log(CallBack: THorseCallback);
begin
 THorse.Use(CallBack);
end;

{$ENDIF}

{$IFDEF HORSE_ISAPI}
procedure TApi.Listen;
begin
  THorse.Listen();
end;
{$ENDIF}




end.
