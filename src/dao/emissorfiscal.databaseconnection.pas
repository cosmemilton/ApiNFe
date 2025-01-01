unit emissorfiscal.databaseconnection;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Def, 
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Phys.PG, FireDAC.Phys.PGDef, 
  FireDAC.Stan.Param;

type
  TDatabaseConnection = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(const AServer, APort, ADatabase, AUsername, APassword: string);
    destructor Destroy; override;
    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;
    function InTransaction: Boolean;
    property Connection: TFDConnection read FConnection;
  end;

implementation

constructor TDatabaseConnection.Create(const AServer, APort, ADatabase, AUsername, APassword: string);
begin
  inherited Create;
  FConnection := TFDConnection.Create(nil);
  FConnection.Params.DriverID := 'PG';
  FConnection.Params.Database := ADatabase;
  FConnection.Params.UserName := AUsername;
  FConnection.Params.Password := APassword;
  FConnection.Params.Add('Server=' + AServer);
  FConnection.Params.Add('Port=' + APort);
  FConnection.UpdateOptions.LockWait := False;
  FConnection.Connected := True;
end;

destructor TDatabaseConnection.Destroy;
begin
  FreeAndNil( FConnection );
  inherited Destroy;
end;

procedure TDatabaseConnection.StartTransaction;
begin
  if not FConnection.InTransaction then
    FConnection.StartTransaction;
end;

procedure TDatabaseConnection.CommitTransaction;
begin
  if FConnection.InTransaction then
    FConnection.Commit;
end;

procedure TDatabaseConnection.RollbackTransaction;
begin
  if FConnection.InTransaction then
    FConnection.Rollback;
end;

function TDatabaseConnection.InTransaction: Boolean;
begin
  Result := FConnection.InTransaction;
end;

end.