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
  apinfe.controller,
  apinfe.claims,
  apinfe.adapter.tocontroller;


type
  TConsole = procedure(cmd: String);
  TFConsole = function(Req: THorseRequest; Res: THorseResponse; Next: TProc): THorseCallback;

  TApi = class
    private
      FLogFileConfig: THorseLoggerLogFileConfig;
      FController: TControllerApi;
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


  end;
var
  Api: TApi = nil;


implementation

uses
   apinfe.constants;

{ TAPI }


function TApi.AuthenticatedAdmin: Horse.THorseCallback;
begin
Result:=  HorseJWT(FController.privateKey, THorseJWTConfig.New.SessionClass(TClaims) );
end;

function TApi.AuthenticatedClient: Horse.THorseCallback;
begin
Result:=  HorseJWT(FController.privateKey, THorseJWTConfig.New.SessionClass(TClaims) );
end;

constructor TApi.Create();
begin
  FController:= TControllerApi.Create();
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
      .Get('/admin/todos'      , Api.FAdapter.getAllClients)
    .&End
    .Group
      .Prefix(apiBase)
      .AddCallback(HorseJWT(Api.FController.privateKey, THorseJWTConfig.New.SessionClass(TClaims) ))
      .Get('/empresa/todas'      , Api.FAdapter.getAllCompany)
      .Get('/empresa/:cnpj'      , Api.FAdapter.getCompany)
      .Put('/empresa'            , Api.FAdapter.updateCompany)
      .Put('/empresa/:cnpj/ativa', Api.FAdapter.activeCompany)
      .Delete('/empresa/:cnpj'   , Api.FAdapter.suspendCompany)
      .Post('/empresa'           , Api.FAdapter.createdCompany)
      .put('/empresa/:cnpj/ambiente'     , Api.FAdapter.configIssuance)
      .Get('/empresa/:cnpj/secret/:id'   , Api.FAdapter.getSecret)
      .post('/empresa/:cnpj/secret'      , Api.FAdapter.createdSecret)
      .put('/empresa/:cnpj/secret/:id'   , Api.FAdapter.updateSecret)
      .delete('/empresa/:cnpj/secret/:id', Api.FAdapter.deleteSecret)
      .Get('/dashboard'                  , Api.FAdapter.getDashboard)
      .Get('/logs/data/:data'            , Api.FAdapter.getLogDate)
      .Get('/log/:id/completo'           , Api.FAdapter.getLogID)
      .Post('/returnJWT'                 , Api.FAdapter.getJWT)
      .AddCallback(Api.AuthenticatedClient())
      .Post('/emissao'       ,  Api.FAdapter.cretedNFe)
      .AddCallback(Api.AuthenticatedClient())
      .Post('/inutilizar'    ,  Api.FAdapter.disableNFe)
      .AddCallback(Api.AuthenticatedClient())
      .Post('/cancelar'      ,  Api.FAdapter.cancelNFe)
      .AddCallback(Api.AuthenticatedClient())
      .Get('/xml/:chave'     ,  Api.FAdapter.getXMLbyKey)
      .AddCallback(Api.AuthenticatedClient())
      .Get('/danfe/:chave'   ,  Api.FAdapter.getPDFbyKey)
      .AddCallback(Api.AuthenticatedClient())
      .Get('/retorna/todas'  ,  Api.FAdapter.getAllIssuance);


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
