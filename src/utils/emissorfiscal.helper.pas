unit emissorfiscal.helper;

interface

uses
  Horse, System.JSON, System.SysUtils;

type
  THorseResponseHelper = class helper for THorseResponse
  public
    procedure SendSuccess(const aData: TJSONObject); overload;
    procedure SendSuccess(const aData: TJSONArray); overload;
    procedure SendSuccess(const aField, aValue: string); overload;
    procedure SendBadRequest(const aMessage: string); overload;
    procedure SendBadRequest(const aError: Exception); overload;
    procedure SendForbidden(const aMessage: string);
    procedure SendInternalServerError(const aMessage: string);
  end;

implementation

procedure THorseResponseHelper.SendSuccess(const AData: TJSONObject);
begin
  Self
    .Status(200)
    .Send<TJSONObject>(AData);
end;

procedure THorseResponseHelper.SendBadRequest(const AMessage: string);
begin
  Self
    .Status(400)
    .Send<TJSONObject>(
      TJSONObject
        .Create
          .AddPair('result', TJSONBool.Create(False))
          .AddPair('erro', trim(AMessage))
    );

end;

procedure THorseResponseHelper.SendBadRequest(const aError: Exception);
begin
  Self
    .Status(400)
    .Send<TJSONObject>(
      TJSONObject
        .Create
          .AddPair('result', TJSONBool.Create(False))
          .AddPair('erro', trim(aError.Message))
    );
end;

procedure THorseResponseHelper.SendForbidden(const AMessage: string);
var
  LJSON: TJSONObject;
begin
  LJSON := TJSONObject.Create;
  try
    LJSON.AddPair('error', AMessage);
    Self.Status(403);
    Self.Send<TJSONObject>(LJSON);
  finally
    LJSON.Free;
  end;
end;

procedure THorseResponseHelper.SendInternalServerError(const AMessage: string);
var
  LJSON: TJSONObject;
begin
  LJSON := TJSONObject.Create;
  try
    LJSON.AddPair('error', AMessage);
    Self.Status(500);
    Self.Send<TJSONObject>(LJSON);
  finally
    LJSON.Free;
  end;
end;

procedure THorseResponseHelper.SendSuccess(const aData: TJSONArray);
begin
  Self.Status(200).Send<TJSONObject>(
    TJSONObject
      .Create
        .AddPair('result', TJSONBool.Create(True))
        .AddPair('data',  TJSONObject.Create.AddPair('users', aData))
  );
end;

procedure THorseResponseHelper.SendSuccess(const aField, aValue: string);
begin
Self.Status(200).Send<TJSONObject>(
  TJSONObject
    .Create
      .AddPair('result', TJSONBool.Create(True))
      .AddPair('data',  TJSONObject.Create.AddPair(aField, aValue)));
end;

end.