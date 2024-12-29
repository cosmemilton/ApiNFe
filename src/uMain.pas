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
  apinfe.claims,
  api.router.admin,
  api.router.client;


type
  TConsole = procedure(cmd: String);
  TFConsole = function(Req: THorseRequest; Res: THorseResponse; Next: TProc): THorseCallback;

  TApi = class
    private
      FLogFileConfig: THorseLoggerLogFileConfig;
   //   FController: TControllerApiNFe;
     // FAdapter: TAdapterApiNFeController;
      constructor Create;

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

constructor TApi.Create();
begin
//
end;


destructor TApi.Destroy;
begin
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
    .Use(HandleException);

  THorse.Get('/', procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Status(200);
    end);

  TApiRouterAdmin.getInstance.Register;
  TApiRouterClient.getInstance.Register;
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
