unit apinfe.claims;

interface

uses
  Horse, Horse.JWT, System.Classes,
  JOSE.Core.JWT, JOSE.Core.Builder, JOSE.Types.JSON;

type
  TClaims = class(TJWTClaims)
  strict private
    function GetId: string;
    procedure SetId(const Value: string);
    function GetName: string;
    procedure SetName(const Value: string);
    function GetEmail: string;
    procedure SetEmail(const Value: string);
    function GetAdmin:Boolean;
    procedure SetAdmin(const Value: Boolean);
  private
    //
  public
    property Id: string read GetId write SetId;
    property name: string read GetName write SetName;
    property Email: string read GetEmail write SetEmail;
    property admin: Boolean read GetAdmin write SetAdmin;
    class function GenerateJWT(const aId: string; aName: string; aEmail: string; const aAdmin: Boolean): string;
    class function ValidateJWT(const aToken: string): Boolean;
    class function GetClaims(const aToken: string): TClaims;
  end;

implementation

uses
  System.DateUtils, System.SysUtils, apinfe.dto.config.jwt;

{ TMyClaims }

class function TClaims.GenerateJWT(const aId: string; aName: string; aEmail: string; const aAdmin: Boolean): string;
var
    LJWT: TJWT;
    LClaims: TClaims;
    LToken: String;
begin
result:= EmptyStr;
  // Add the class
  LJWT := TJWT.Create(TClaims);
  try
    // Casting using the class
    LClaims := TClaims(LJWT.Claims);

    // Enter the payload data
    LClaims.Expiration := IncMinute(Now, TJWTConfigDTO.getInstance.ExpirationTime);
    LClaims.Id := aId;
    LClaims.Name := aName;
    LClaims.Email := aEmail;
    LClaims.admin := aAdmin;

    // Generating the token
    result := TJOSE.SHA256CompactToken(TJWTConfigDTO.getInstance.PrivateKey, LJWT);
  finally
    FreeAndNil(LJWT);
  end;
end;


function TClaims.GetEmail: string;
begin
  Result := TJSONUtils.GetJSONValue('email', FJSON).AsString;
end;

procedure TClaims.SetEmail(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('email', Value, FJSON);
end;

function TClaims.GetId: string;
begin
  Result := TJSONUtils.GetJSONValue('id', FJSON).AsString;
end;

procedure TClaims.SetId(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('id', Value, FJSON);
end;

function TClaims.GetName: string;
begin
  Result := TJSONUtils.GetJSONValue('name', FJSON).AsString;
end;

procedure TClaims.SetName(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('name', Value, FJSON);
end;

function TClaims.GetAdmin: Boolean;
begin
  Result := TJSONUtils.GetJSONValue('admin', FJSON).AsBoolean;
end;

procedure TClaims.SetAdmin(const Value: Boolean);
begin
  TJSONUtils.SetJSONValueFrom<boolean>('admin', Value, FJSON);
end;

class function TClaims.ValidateJWT(const aToken: string): Boolean;
var
  LJWT: TJWT;
begin
  LJWT := TJWT.Create(TClaims);
  try
    //
  finally
    FreeAndNil(LJWT);
  end;
end;

class function TClaims.GetClaims(const aToken: string): TClaims;
  var
    LJWT: TJWT;
begin
  LJWT := TJOSE.Verify(TJWTConfigDTO.getInstance.PrivateKey, aToken);
  if LJWT.Verified then
    Result := TClaims(LJWT.Claims)
  else
    Result := nil;
end;






end.

