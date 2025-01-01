unit apinfe.adapter.mongo;

interface

uses
  System.Classes,
  Grijjy.Bson,
  Grijjy.MongoDB,
  Grijjy.MongoDB.Queries,
  system.JSON,
  System.SysUtils,
  System.DateUtils,
  apinfe.constants.errors;

type
    TtpCollections = (cdgApi, cdgEmail);
    TMongoComponent = class
      strict private
        FCollectionAPI  : IgoMongoCollection;
        FCollectionEmail: IgoMongoCollection;
        FClient    : IgoMongoClient;
        FDatabase  : IgoMongoDatabase;
        const FNameCollectionAPI  = 'api';
        const FNameCollectionEmail= 'email';
        class var FMongoComponent : TMongoComponent;
      private
        //
      public
        class function getInstance: TMongoComponent;
        function getDataLog(aGuid: TGUID): TJSONObject; overload;
        function getDataLog(aDate: TDateTime): TJSONArray; overload;
        procedure LogToMongo(const aLogString: String; const aCollection: TtpCollections);
        destructor Destroy;
        constructor Create( const aHost: string;
                            const aDatabase: string);
    end;

implementation

uses
  apinfe.constants, apinfe.dto.config.mongo;

{ TMongoComponent }

constructor TMongoComponent.Create(
  const aHost: string;
  const aDatabase: string);
var t_host: string;
var t_port: integer;
begin
t_host:= Trim( aHost.Split([':'])[0] );
t_port:= StrToIntDef( Trim( aHost.Split([':'])[1] ), 27017 );

FClient    := TgoMongoClient.Create(t_host, t_port);
FDatabase  := FClient.GetDatabase(aDatabase);
FCollectionAPI:= FDatabase.GetCollection(FNameCollectionAPI);
FCollectionEmail:= FDatabase.GetCollection(FNameCollectionEmail);
end;

destructor TMongoComponent.Destroy;
begin
 //
end;

function TMongoComponent.getDataLog(aGuid: tguid): TJSONObject;
var
  t_doc: TgoBsonDocument;
  t_collectionAPI: IgoMongoCollection;
begin
Result:= TJSONObject.Create;
t_collectionAPI:= FMongoComponent.FDatabase.GetCollection(FNameCollectionAPI);
  for t_doc in t_collectionAPI.Find(TgoMongoFilter.Eq('id', aGuid)) do
    Result.ParseJSONValue(t_doc.ToJson);
end;

function TMongoComponent.getDataLog(aDate: TDateTime): TJSONArray;
var
   t_doc: TgoBsonDocument;
   t_return: string;
   t_utc_date: TDateTime;
begin
Result:= TJSONArray.Create;
t_utc_date:=  TTimeZone.Local.ToUniversalTime(aDate);
for t_doc in FMongoComponent.FCollectionAPI.Find(
        TgoMongoFilter.gte('data', t_utc_date) AND
        TgoMongoFilter.lt('data', incDay(t_utc_date, +1)) ) do
  Result.Add( TJSONObject.ParseJSONValue(t_doc.ToJson) as TJSONObject );

end;

class function TMongoComponent.getInstance: TMongoComponent;
begin
  if not Assigned(FMongoComponent) then
    FMongoComponent:= TMongoComponent
                          .Create(
                            TConfigMongoDB.getInstance.PathDB,
                            TConfigMongoDB.getInstance.NameDB
                          );

Result:= FMongoComponent;
end;

procedure TMongoComponent.LogToMongo(
  const aLogString: String;
  const aCollection: TtpCollections );
var
  t_doc : TgoBsonDocument;
  t_erro: string;
  t_key: TDateTime;
  t_str: string;
  t_doc_find: TgoBsonDocument;
begin
t_str:= DateTimeToStr(Now);
t_str:= Copy(t_str, 1, 14) + '00:00';
t_key := StrToDateTime(t_str);
try
  case aCollection of
    cdgApi:
      begin
        for t_doc_find in FCollectionAPI.Find(TgoMongoFilter.Eq('data', t_key)) do begin
          FCollectionAPI.UpdateOne(TgoMongoFilter.Eq('data', t_key), TgoMongoUpdate.Init.&Set('msg',  t_doc_find['msg'] + sLineBreak + aLogString));
          Exit;
        end;
        t_doc := TgoBsonDocument
          .Create()
            .Add('data', t_key )
            .Add('msg' , aLogString);
        FCollectionAPI.InsertOne(t_doc);
      end;
    cdgEmail: FCollectionEmail.InsertOne(t_doc);
  end;
except
  on e: exception do
     t_erro:= e.Message;

end;
end;

end.
