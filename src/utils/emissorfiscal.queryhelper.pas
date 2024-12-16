unit emissorfiscal.queryhelper;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TFDQueryHelper = class helper for TFDQuery
  public
    constructor CreateAndConnect(AConnection: TFDConnection);
  end;

implementation

constructor TFDQueryHelper.CreateAndConnect(AConnection: TFDConnection);
begin
  inherited Create(nil);
  SQL.Clear;
  Close;
  Connection := AConnection;
end;

end.