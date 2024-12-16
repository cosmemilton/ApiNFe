unit apinfe.dto.config.jwt;

interface


uses
  System.Classes, apinfe.constants;

type
  TJWTConfigDTO = class
  strict private
    FExpirationTime: integer;
    FPrivateKey: string;
  protected
    class var m_instance: TJWTConfigDTO;
  public
    procedure SetExpirationTime(const Value: integer);
    property ExpirationTime: Integer read FExpirationTime;
    property PrivateKey: string read FPrivateKey;
    class function getInstance: TJWTConfigDTO;
    constructor Create;
  end;

implementation

uses
  System.SysUtils;


{ TDBConfig }

constructor TJWTConfigDTO.Create;
var
  tKeyMD5: TStringList;
begin
  try
    if FileExists(PathPrivateKey) then
      begin
        tKeyMD5:= TStringList.Create;
        tKeyMD5.LoadFromFile(PathPrivateKey);
        FPrivateKey:= tKeyMD5.Text.Trim;
      end
    else
      raise Exception.Create('Chave de segurança não implementada.');
      
    if not (FPrivateKey.Length=32) then
      raise Exception.Create('Chave de segurança inválida.');
  finally
    if Assigned(tKeyMD5) then
      FreeAndNil(tKeyMD5);
  end;
end;

procedure TJWTConfigDTO.SetExpirationTime(const Value: integer);
begin
  FExpirationTime := Value;
end;

class function TJWTConfigDTO.getInstance: TJWTConfigDTO;
begin
  if not Assigned(m_instance) then
    m_instance := TJWTConfigDTO.Create;
  
  Result := m_instance;  
end;

end.
