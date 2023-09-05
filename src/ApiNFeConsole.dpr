program ApiNFeConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Json,
  Horse,
  uMain in 'uMain.pas',
  apinfe.dto.config in 'dto\apinfe.dto.config.pas',
  apinfe.dto.config.mongo in 'dto\apinfe.dto.config.mongo.pas',
  apinfe.controller in 'controller\apinfe.controller.pas',
  apinfe.constants in 'constants\apinfe.constants.pas',
  ThreadFileLog in 'utils\ThreadFileLog.pas',
  ThreadUtilities in 'utils\ThreadUtilities.pas',
  Grijjy.MongoDB in 'components\mongo\Grijjy.MongoDB.pas',
  Grijjy.MongoDB.Protocol in 'components\mongo\Grijjy.MongoDB.Protocol.pas',
  Grijjy.MongoDB.Queries in 'components\mongo\Grijjy.MongoDB.Queries.pas',
  apinfe.adapter.mongo in 'components\apinfe.adapter.mongo.pas',
  apinfe.adapter.tocontroller in 'utils\apinfe.adapter.tocontroller.pas',
  apinfe.claims in 'utils\apinfe.claims.pas';

procedure Console(cmd: String);
begin
  Writeln(cmd);
end;


procedure Terminal(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Writeln(DateTimeToStr(Now) );
  Writeln('Router: ' + QuotedStr( Req.RawWebRequest.PathInfo));
  Writeln('Method: ' + QuotedStr(Req.RawWebRequest.Method));
  Next;
  Writeln('Response:');
  try
    Writeln((Res.Content as TJSONObject).ToString);
  except
     Writeln('{}')
  end;
  Writeln('');
end;

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  TApi.Initialize();
  Api.Log(Terminal);
  Api.Listen(Console);
end.
