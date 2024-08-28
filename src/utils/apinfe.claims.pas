unit apinfe.claims;

interface

uses
  JOSE.Core.JWT, JOSE.Types.JSON;

type
  TClaims = class(TJWTClaims)
  strict private
    function GetId: string;
    procedure SetId(const Value: string);
    function GetName: string;
    procedure SetName(const Value: string);
    function GetEmail: string;
    procedure SetEmail(const Value: string);
    function GetCompany:string;
    procedure SetCompany(const Value: string);
    function GetAdmin:Boolean;
    procedure SetAdmin(const Value: Boolean);
    procedure SetCompanyId(const Value: Integer);
    function GetCompanyId: Integer;
  private
    //
  public
    property Id: string read GetId write SetId;
    property name: string read GetName write SetName;
    property Email: string read GetEmail write SetEmail;
    property company: string read GetCompany write SetCompany;
    property companyId: Integer read GetCompanyId write SetCompanyId;
    property admin: Boolean read GetAdmin write SetAdmin;
  end;

implementation

{ TMyClaims }


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

function TClaims.GetCompany: string;
begin
  Result := TJSONUtils.GetJSONValue('company', FJSON).AsString;
end;

function TClaims.GetCompanyId: Integer;
begin
  Result := TJSONUtils.GetJSONValue('companyId', FJSON).AsInteger;
end;

procedure TClaims.SetCompany(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('company', Value, FJSON);
end;

procedure TClaims.SetcompanyId(const Value: Integer);
begin
  TJSONUtils.SetJSONValueFrom<Integer>('companyId', Value, FJSON);
end;

end.

