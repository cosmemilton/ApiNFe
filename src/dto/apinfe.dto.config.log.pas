unit apinfe.dto.config.log;

interface

uses
  System.Classes, System.IniFiles,
  apinfe.constants;

type
  TConfigLog = class
  strict private
    FHabilitaLog: Boolean;
  protected
    class var m_instance: TConfigLog;
  public
    property HabilitaLog: Boolean read FHabilitaLog;
    class function getInstance: TConfigLog;
    constructor Create();
  end;

implementation

uses
  System.SysUtils;

{ TConfigLog }

constructor TConfigLog.Create;
var ini: TIniFile;
begin
  inherited;
  ForceDirectories(path);
  ForceDirectories(pathLog);
  ForceDirectories(pathPDF);
  try
    ini:= Tinifile.Create(iniFileNameConfigLog);
    FHabilitaLog := ini.ReadBool('Log','Habilitado', False);

  finally
    FreeAndNil(ini);
  end;
end;

class function TConfigLog.getInstance: TConfigLog;
begin
  if not Assigned(m_instance) then
    m_instance := TConfigLog.Create;

  Result := m_instance;
end;

end.
