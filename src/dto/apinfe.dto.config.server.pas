unit apinfe.dto.config.server;

interface

uses
  System.Classes, System.IniFiles,
  System.SysUtils;
type
  TConfigServer = class
  strict private
    FModule: string;
    FHostName: string;
    FPort: Word;
    FEnableHttpSwagger: Boolean;
    FEnableHttpsSwagger: Boolean;
  protected
    class var m_instance: TConfigServer;
  public
    property Module: string read FModule;
    property HostName: string read FHostName;
    property Port: Word read FPort;
    property EnableHttpSwagger: Boolean read FEnableHttpSwagger;
    property EnableHttpsSwagger: Boolean read FEnableHttpsSwagger;
    class function getInstance: TConfigServer;
    constructor Create();
  end;

implementation

uses
  apinfe.constants, apinfe.constants.errors;

{ TConfigServer }

constructor TConfigServer.Create;
var ini: TIniFile;
begin
  inherited;
  ForceDirectories(path);
  ForceDirectories(pathLog);
  ForceDirectories(pathPDF);
  try
    ini:= Tinifile.Create(iniFileNameConfigServer);
    if not FileExists(iniFileNameConfigServer) then begin
      ini.writeString('Services','hostName', '');
      ini.writeString('Services','module', '');
      ini.writeBool('Services','EnableHttpSwagger', False);
      ini.writeBool('Services','EnableHttpsSwagger', False);
      ini.writeInteger('Services','Port', 0);
    end;
    FHostName          := ini.ReadString('Services' ,'hostName', EmptyStr);
    FModule            := ini.ReadString('Services' ,'module'  , EmptyStr);
    FEnableHttpSwagger := ini.ReadBool('Services'   ,'EnableHttpSwagger'  , False);
    FEnableHttpsSwagger:= ini.ReadBool('Services'   ,'EnableHttpsSwagger' , False);
    FPort              := ini.ReadInteger('Services','Port', 0);

    if (FHostName=emptyStr) then
      raise Exception.Create(ERROR_HOSTNAME_NOT_FOUND);
    if (FModule=emptyStr) then
      raise Exception.Create(ERROR_MODULE_NOT_FOUND);
    if (FPort=0) then
      raise Exception.Create(ERROR_PORT_NOT_FOUND);  
    

  finally
    FreeAndNil(ini);
  end;
end;

class function TConfigServer.getInstance: TConfigServer;
begin
  if not Assigned(m_instance) then
    m_instance := TConfigServer.Create;

  Result := m_instance;
end;

end.
