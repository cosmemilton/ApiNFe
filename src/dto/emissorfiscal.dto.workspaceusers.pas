unit emissorfiscal.dto.workspaceusers;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  [TableName('workspace_users')]
  TWorkspaceUserDTO = class(TQueryBuild)
  private
    FId: string;
    FWorkspaceId: string;
    FNome: string;
    FLogin: string;
    FAtivo: Boolean;
    FPasswordHash: string;
    FEmail: string;
    FTelefone: string;
    FCelular: string;
    FEmailConfirmado: Boolean;
    FCelularConfirmado: Boolean;
    FCreatedBy: string;
    FUpdatedBy: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    [FieldName('id')]
    property Id: string read FId write FId;
    [FieldName('workspace_id')]
    property WorkspaceId: string read FWorkspaceId write FWorkspaceId;
    [FieldName('nome')]
    property Nome: string read FNome write FNome;
    [FieldName('login')]
    property Login: string read FLogin write FLogin;
    [FieldName('ativo')]
    property Ativo: Boolean read FAtivo write FAtivo;
    [FieldName('password_hash')]
    property PasswordHash: string read FPasswordHash write FPasswordHash;
    [FieldName('email')]
    property Email: string read FEmail write FEmail;
    [FieldName('telefone')]
    property Telefone: string read FTelefone write FTelefone;
    [FieldName('celular')]
    property Celular: string read FCelular write FCelular;
    [FieldName('email_confirmado')]
    property EmailConfirmado: Boolean read FEmailConfirmado write FEmailConfirmado;
    [FieldName('celular_confirmado')]
    property CelularConfirmado: Boolean read FCelularConfirmado write FCelularConfirmado;
    [FieldName('created_by')]
    property CreatedBy: string read FCreatedBy write FCreatedBy;
    [FieldName('updated_by')]
    property UpdatedBy: string read FUpdatedBy write FUpdatedBy;
    [FieldName('created_at')]
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    [FieldName('updated_at')]
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.