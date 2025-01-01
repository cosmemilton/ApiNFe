unit apinfe.dto.config.mongo;

interface

uses
  System.Classes, System.IniFiles,
  apinfe.constants;

type
  TConfigMongoDB= class
    strict private
      FPathDB: string;
      FNameDB: string;
      FUseMongo: Boolean;
    protected
      class var m_instance: TConfigMongoDB;
    public
      property PathDB: string read FPathDB;
      property NameDB: string read FNameDB;
      property UseMongo: Boolean read FUseMongo;
      class function getInstance: TConfigMongoDB;
      constructor Create;
    end;

implementation

uses
  System.SysUtils;

{ TConfigMongoDB }

constructor TConfigMongoDB.Create;
var ini: TIniFile;
begin
  inherited;
  ini:= nil;
  ForceDirectories(path);
  ForceDirectories(pathLog);
  ForceDirectories(pathPDF);
  try
    ini:= Tinifile.Create(iniFileNameConfigDB);
    FPathDB := ini.ReadString('MongoDB','PathDB', '');
    FNameDB := ini.ReadString('MongoDB','NameDB', '');
    FUseMongo:= ini.ReadBool('MongoDB','UseMongo', False);
  finally
    if Assigned(ini) then
      FreeAndNil(ini);
  end;
end;

class function TConfigMongoDB.getInstance: TConfigMongoDB;
begin
  if not Assigned(m_instance) then
    m_instance := TConfigMongoDB.Create;

  Result := m_instance;
end;

end.
