unit apinfe.dto.config.emailserver;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles;

type
  TEmailServerDTO = class
  private
    FHost: string;
    FPort: Integer;
    FUsername: string;
    FPassword: string;
    FUseTLS: Boolean;
  protected
    class var m_instance: TEmailServerDTO;
  public
    property Host: string read FHost;
    property Port: Integer read FPort;
    property Username: string read FUsername;
    property Password: string read FPassword;
    property UseTLS: Boolean read FUseTLS;
    class function getInstance: TEmailServerDTO;
    constructor Create();
  end;

implementation

uses
  apinfe.constants, apinfe.constants.errors;

{ TEmailServerDTO }

constructor TEmailServerDTO.Create;
var ini: TIniFile;
begin
  inherited;
  ForceDirectories(path);
  ForceDirectories(pathLog);
  ForceDirectories(pathPDF);
  try
    ini:= Tinifile.Create(iniFileNameConfigMailServer);
    if not FileExists(iniFileNameConfigMailServer) then begin
      ini.writeString('EMail','Host', '');
      ini.writeInteger('EMail','Port', 0);
      ini.writeString('EMail','Username', '');
      ini.writeString('EMail','Password', '');
      ini.writeBool('EMail','UseTLS', False);
    end;
    FHost    := ini.ReadString('EMail','Host', '');
    FPort    := ini.ReadInteger('EMail','Port', 0);
    FUsername:= ini.ReadString('EMail','Username', '');
    FPassword:= ini.ReadString('EMail','Password', '');
    FUseTLS  := ini.ReadBool('EMail','UseTLS'  , False);
    if (FHost=emptyStr) then
      raise Exception.Create(ERROR_HOSTNAME_NOT_FOUND);
    if (FUsername=emptyStr) then
      raise Exception.Create(ERROR_USERNAME_NOT_FOUND);
    if (FPassword=emptyStr) then
      raise Exception.Create(ERROR_PASSWORD_NOT_FOUND);
    if (FPort=0) then
      raise Exception.Create(ERROR_PORT_NOT_FOUND);
  finally
    FreeAndNil(ini);
  end;

end;

class function TEmailServerDTO.getInstance: TEmailServerDTO;
begin
  if not Assigned(m_instance) then
    m_instance := TEmailServerDTO.Create;
  Result := m_instance;
end;

end.
