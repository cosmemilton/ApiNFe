unit apinfe.dto.config.emailserver;

interface

uses
  System.SysUtils, System.Classes;

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
    procedure setHost(const Value: string);
    procedure setPort(const Value: Integer);
    procedure setUsername(const Value: string);
    procedure setPassword(const Value: string);
    procedure setUseTLS(const Value: Boolean);
  end;

implementation

{ TEmailServerDTO }

class function TEmailServerDTO.getInstance: TEmailServerDTO;
begin
  if not Assigned(m_instance) then
    m_instance := TEmailServerDTO.Create;
  Result := m_instance;
end;

procedure TEmailServerDTO.setHost(const Value: string);
begin
  Self.FHost := Value;
end;

procedure TEmailServerDTO.setPassword(const Value: string);
begin
  Self.FPassword := Value;
end;

procedure TEmailServerDTO.setPort(const Value: Integer);
begin
  Self.FPort := Value;
end;

procedure TEmailServerDTO.setUsername(const Value: string);
begin
  Self.FUsername := Value;
end;

procedure TEmailServerDTO.setUseTLS(const Value: Boolean);
begin
  Self.FUseTLS := Value;
end;

end.
