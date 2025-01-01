unit apinfe.dto.config.jwt;

interface


uses
  System.Classes, System.SysUtils, System.IniFiles;

type
  TJWTConfigDTO = class
  strict private
    FExpirationTime: integer;
    FPrivateKey: string;
  protected
    class var m_instance: TJWTConfigDTO;
  public
    property ExpirationTime: Integer read FExpirationTime;
    property PrivateKey: string read FPrivateKey;
    class function getInstance: TJWTConfigDTO;
    constructor Create;
  end;

implementation

uses
  apinfe.constants, apinfe.constants.errors;

{ TDBConfig }

constructor TJWTConfigDTO.Create;
var
  ini: TIniFile;
begin
inherited;
ini:= nil;
  try
    ForceDirectories(path);
    ForceDirectories(pathLog);
    ForceDirectories(pathPDF);
    ini:= Tinifile.Create(iniFileNameConfigToken);
    if not FileExists(iniFileNameConfigToken) then begin
      ini.writeString('Token','TempoDeVidaEmMinutos', '5');
      ini.writeString('Token','PathDB', '');
    end;

    FExpirationTime:= ini.ReadInteger('Token','TempoDeVidaEmMinutos', 5);
    FPrivateKey    := ini.ReadString('Token','PathDB', EmptyStr);

    if (FPrivateKey=EmptyStr) then
      raise Exception.Create(ERROR_PRIVATE_KEY_NOT_IMPLEMENTED);
      
    if not (FPrivateKey.Length=32) then
      raise Exception.Create(ERROR_INVALID_PRIVATE_KEY);
  finally
    if Assigned(ini) then
      FreeAndNil(ini);
  end;
end;


class function TJWTConfigDTO.getInstance: TJWTConfigDTO;
begin
  if not Assigned(m_instance) then
    m_instance := TJWTConfigDTO.Create;
  
  Result := m_instance;  
end;

end.
