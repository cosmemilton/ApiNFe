unit apinfe.dto.config.db;

interface

uses
  System.Classes, System.IniFiles,
  System.SysUtils;

type
  TDBConfig = class
  strict private
    FPort: Word;
    FPassword: string;
    FHostName: string;
    FUserName: string;
    FDataBase: string;
  protected
    class var m_instance: TDBConfig;
  public
    property DataBase: string read FDataBase;
    property HostName: string read FHostName;
    property UserName: string read FUserName;
    property Password: string read FPassword;
    property Port: Word read FPort;
    class function getInstance: TDBConfig;
    constructor Create();
  end;

implementation

uses
  apinfe.constants, apinfe.constants.errors;

{ TDBConfig }

constructor TDBConfig.Create();
var ini: TIniFile;
begin
  inherited;
  ForceDirectories(path);
  ForceDirectories(pathLog);
  ForceDirectories(pathPDF);
  try
    ini:= Tinifile.Create(iniFileNameConfigDB);
    if not FileExists(iniFileNameConfigDB) then begin
      ini.writeString('DB','hostname', '');
      ini.writeString('DB','username', '');
      ini.writeString('DB','password', '');
      ini.writeInteger('DB','port', 0);
      ini.writeString('DB','database', '');
    end;

    FHostName := ini.ReadString('DB','hostname', '');
    FUserName := ini.ReadString('DB','username', '');
    FPassword := ini.ReadString('DB','password', '');
    FPort     := ini.ReadInteger('DB','port', 0);
    FDatabase := ini.ReadString('DB','database', '');

    if (FHostName=emptyStr) then
      raise Exception.Create(ERROR_HOSTNAME_NOT_FOUND);
    if (FUserName=emptyStr) then
      raise Exception.Create(ERROR_USERNAME_NOT_FOUND);
    if (FPassword=emptyStr) then
      raise Exception.Create(ERROR_PASSWORD_NOT_FOUND);
    if (FDatabase=emptyStr) then
      raise Exception.Create(ERROR_DATABASE_NOT_FOUND);
    if (FPort=0) then
      raise Exception.Create(ERROR_PORT_NOT_FOUND);

  finally
    FreeAndNil(ini);
  end;
end;

class function TDBConfig.getInstance: TDBConfig;
begin
  if not Assigned(m_instance) then
    m_instance := TDBConfig.Create;
  
  Result := m_instance;  
end;

end.
