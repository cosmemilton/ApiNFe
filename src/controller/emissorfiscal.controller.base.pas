unit emissorfiscal.controller.base;

interface

uses
  System.SysUtils,
  System.Classes,
  ThreadFileLog,
  ThreadUtilities,
  apinfe.dto.config.db,
  apinfe.dto.config.jwt,
  apinfe.dto.config.emailserver,
  apinfe.adapter.mongo,
  apinfe.dto.config.mongo,
  apinfe.constants;

type
  TControllerApiNFeBase = class
    private
      FTThreadFileLog: TThreadFileLog;
    public
      procedure FileLog(const aLog: string);
      constructor Create;
  end;

implementation

uses
  apinfe.dto.config.log;

{ TControllerApi }

constructor TControllerApiNFeBase.Create;
begin
//
end;

procedure TControllerApiNFeBase.FileLog(const aLog: string);
begin
  if TConfigLog.getInstance.HabilitaLog then
    begin
      if not Assigned(FTThreadFileLog) then
        begin
          if TConfigMongoDB.getInstance.UseMongo then
            FTThreadFileLog:= TThreadFileLog.Create(
              TConfigMongoDB.getInstance.PathDB
              , TConfigMongoDB.getInstance.NameDB
            )
          else
            FTThreadFileLog:= TThreadFileLog.Create;
        end;
      FTThreadFileLog.Log(FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) + ' ' + aLog, True);
    end;
end;



end.
