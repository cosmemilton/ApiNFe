unit apinfe.dto.config.mongo;

interface

type
  TConfigMongoDB= class
    strict private
      FPathDB: string;
      FNameDB: string;
      FUseMongo: Boolean;
    public
      procedure SetPathDB(const Value: string);
      procedure SetNameDB(const Value: string);
      procedure SetUseMongo(const Value: Boolean);
      property PathDB: string read FPathDB;
      property NameDB: string read FNameDB;
      property UseMongo: Boolean read FUseMongo;
    end;

implementation

{ TConfigMongoDB }

procedure TConfigMongoDB.SetNameDB(const Value: string);
begin
Self.FNameDB := Value;
end;

procedure TConfigMongoDB.SetPathDB(const Value: string);
begin
  Self.FPathDB := Value;
end;

procedure TConfigMongoDB.SetUseMongo(const Value: Boolean);
begin
  Self.FUseMongo := Value;
end;


end.
