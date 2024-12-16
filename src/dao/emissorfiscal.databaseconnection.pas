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
    property Connection: TFDConnection read FConnection;
  end;

implementation

constructor TDatabaseConnection.Create(const AServer, APort, ADatabase, AUsername, APassword: string);
begin
  inherited Create;
  FConnection := TFDConnection.Create(nil);
  FConnection.DriverName := 'PG';
  FConnection.Params.Add('Server=' + AServer);
  FConnection.Params.Add('Port=' + APort);
  FConnection.Params.Add('Database=' + ADatabase);
  FConnection.Params.Add('User_Name='  + AUsername);
  FConnection.Params.Add('Password=' + APassword);
  FConnection.LoginPrompt := False;
  FConnection.Connected := True;
end;

destructor TDatabaseConnection.Destroy;
begin
  FreeAndNil(FConnection);
  inherited Destroy;
end;

end.