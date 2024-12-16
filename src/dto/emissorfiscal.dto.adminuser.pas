unit emissorfiscal.dto.adminuser;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  [TableName('admin_users')]
  TAdminUserDTO = class(TQueryBuild)
  private
    FId: string;
    FName: string;
    FUsername: string;
    FEmail: string;
    FPasswordHash: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
    FMaster: Boolean;
  public
    [FieldName('id')]
    property Id: string read FId write FId;
    [FieldName('name')]
    property Name: string read FName write FName;
    [FieldName('username')]
    property Username: string read FUsername write FUsername;
    [FieldName('email')]
    property Email: string read FEmail write FEmail;
    [FieldName('password_hash')]
    property PasswordHash: string read FPasswordHash write FPasswordHash;
    [FieldName('master')]
    property Master: Boolean read FMaster write FMaster;
    [FieldName('created_at')]
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    [FieldName('updated_at')]
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
    constructor Create;
  end;

implementation

{ TAdminUserDTO }

constructor TAdminUserDTO.Create;
begin
inherited Create;
end;

end.