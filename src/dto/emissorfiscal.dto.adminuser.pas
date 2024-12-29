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
    FCreatedBy: string;
    FUpdatedBy: string;
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
    [FieldName('created_by')]
    property CreatedBy: string read FCreatedBy write FCreatedBy;
    [FieldName('updated_by')]
    property UpdatedBy: string read FUpdatedBy write FUpdatedBy;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TAdminUserDTO }

constructor TAdminUserDTO.Create;
begin
inherited Create;
end;

destructor TAdminUserDTO.Destroy;
begin
inherited;
end;

end.