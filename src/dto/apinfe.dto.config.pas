unit apinfe.dto.config;

interface

type
  TDBConfig = class
  strict private
    FPort: Word;
    FPassword: string;
    FHostName: string;
    FUserName: string;
  public
    procedure SetHostName(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetPort(const Value: Word);
    procedure SetUserName(const Value: string);
    property HostName: string read FHostName;
    property UserName: string read FUserName;
    property Password: string read FPassword;
    property Port: Word read FPort write SetPort;
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



end.
