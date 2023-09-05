unit ThreadFileLog;

interface

uses
  Windows,
  ThreadUtilities,
  System.Classes,
  apinfe.adapter.mongo;

type
    PLogRequest = ^TLogRequest;
    TLogRequest = record
        LogText  : String;
        FileName : String;
        tpCollections: TtpCollections;
    end;

    TThreadFileLog = class(TObject)
    private
        FThreadPool: TThreadPool;
        FMongoComponent: TMongoComponent;
        procedure HandleLogRequest(Data: Pointer; AThread: TThread);
    public
        constructor Create(); overload;
        constructor Create(const aHost: string;
                           const aDatabase: string); overload;
        destructor Destroy; override;
        procedure Log( LogText: string; isAPI: Boolean= False);
    end;

 var
   doSaveLog: TThreadFileLog;



implementation

uses
  System.SysUtils, apinfe.constants, System.DateUtils, System.IniFiles;

(* Simple reuse of a logtofile function for example *)
procedure LogToFile(const FileName, LogString: String);
var
    F: TextFile;
begin

  AssignFile(F, PathLog + FileName);
  if not FileExists( PathLog + FileName) then
    Rewrite(F)
  else
    Append(F);

    try
        Writeln(F, FormatDateTime('dd/mm/yyyy  hh:nn:ss:zzz: ', Now) + LogString);
    finally
        CloseFile(F);
    end;
end;

constructor TThreadFileLog.Create();
begin
  FMongoComponent:= nil;
  ForceDirectories(PathLog);
  FThreadPool := TThreadPool.Create(HandleLogRequest, 1);
end;

constructor TThreadFileLog.Create(const aHost, aDatabase: string);
begin
   Create;
   FMongoComponent:= TMongoComponent.Create(aHost, aDatabase);
end;

destructor TThreadFileLog.Destroy;
begin
    FThreadPool.Free;
    inherited;
    FreeAndNil(FMongoComponent);
end;

procedure TThreadFileLog.HandleLogRequest(Data: Pointer; AThread: TThread);
var
    Request: PLogRequest;
begin
    Request := Data;
    try
      if Assigned(FMongoComponent) then
        FMongoComponent.LogToMongo(Request^.LogText, Request^.tpCollections)
      else
        LogToFile(Request^.FileName, Request^.LogText);
    finally
      Dispose(Request);
    end;
end;

procedure TThreadFileLog.Log( LogText: string;  IsAPI: Boolean);
var
  Request: PLogRequest;
  sNomearq: string;
  sNomearqComp: string;
begin
  New(Request);
  if (IsAPI) then
    begin
      sNomearq:= 'ApiNFe_' + FormatDateTime('yyyymmdd_hh', Now) + '.Log';
      Request^.tpCollections:= cdgApi;
    end
  else
    begin
      sNomearq:= 'AutDanfe_' + FormatDateTime('yyyymmdd_hh', Now) + '.Log';
      Request^.tpCollections:= cdgEmail;
    end;
  Request^.LogText  := LogText;
  Request^.FileName := sNomearq;
  FThreadPool.Add(Request);
end;

{ TMongoComponent }



end.
