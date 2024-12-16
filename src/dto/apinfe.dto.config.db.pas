unit apinfe.dto.config.db;

interface

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
    procedure SetHostName(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetPort(const Value: Word);
    procedure SetUserName(const Value: string);
    procedure SetDatabase(const Value: string);
    property DataBase: string read FDataBase;
    property HostName: string read FHostName;
    property UserName: string read FUserName;
    property Password: string read FPassword;
    property Port: Word read FPort;
    class function getInstance: TDBConfig;
  end;

implementation

{ TDBConfig }

procedure TDBConfig.SetHostName(const Value: string);
begin
  FHostName := Value;
end;

procedure TDBConfig.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TDBConfig.SetPort(const Value: Word);
begin
  FPort := Value;
end;

procedure TDBConfig.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

procedure TDBConfig.SetDatabase(const Value: string);
begin
  FDatabase := Value;
end;

class function TDBConfig.getInstance: TDBConfig;
begin
  if not Assigned(m_instance) then
    m_instance := TDBConfig.Create;
  
  Result := m_instance;  
end;

end.
