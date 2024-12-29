unit emissorfiscal.dao.workspaceusers;

interface

uses
  System.Classes, System.SysUtils,
  System.Generics.Collections,
  FireDAC.Stan.Param, FireDAC.Comp.Client,
  emissorfiscal.databaseconnection,
  emissorFiscal.dto.workspaceusers,
  emissorfiscal.queryhelper,
  apinfe.dto.config.db,
  emissorfiscal.helper.strings;

type
  TworkspaceUserDAO = class(TDatabaseConnection)
  private
    //
  protected
    class var m_instance: TworkspaceUserDAO;
  public
    function CreateWorkspaceUser(aWorkspaceID: string; const aValue: TWorkspaceUserDTO): Boolean;
    function GetWorkspaceUserById(aWorkspaceID: string; const aId: string): TWorkspaceUserDTO;
    function GetAllWorkspaceUsers(aWorkspaceID: string): TObjectList<TWorkspaceUserDTO>;
    function UpdateWorkspaceUserById(aWorkspaceID: string; const reqUserID: string; const aId: string; const aDTO: TWorkspaceUserDTO): Integer;
    function DeleteWorkspaceUserById(aWorkspaceID: string; const aId: string): Integer;
    class function getInstance: TworkspaceUserDAO;
  end;


implementation

uses
  Data.DB, apinfe.constants;

{ TWorkspacesDAO }

function TworkspaceUserDAO.CreateWorkspaceUser(aWorkspaceID: string;
  const aValue: TWorkspaceUserDTO): Boolean;
var qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := Connection;
    qry.SQL.Add('INSERT INTO workspace_users (id, workspace_id, nome, login, ativo, email, telefone, celular, password_hash, created_at, updated_at)');

    if not(aValue.CreatedBy=GUID_NULL) then
      qry.SQL.Add(', created_by');
    if not(aValue.UpdatedBy=GUID_NULL) then
      qry.SQL.Add(', updated_by');

    qry.SQL.Add('VALUES (:id::uuid, :workspace_id::uuid, :nome, :login, :ativo, :email, :telefone, :celular, (select  crypt( (select random())::text, ''md5''))');

    if not(aValue.CreatedBy=GUID_NULL) then
      qry.SQL.Add(', :created_by::uuid');
    if not(aValue.UpdatedBy=GUID_NULL) then
      qry.SQL.Add(', :updated_by::uuid');

    qry.SQL.Add(', current_timestamp, current_timestamp)');
    qry.SQL.Add('returning id::varchar');

    qry.ParamByName('id').AsString := aValue.Id;
    qry.ParamByName('workspace_id').AsString := aValue.WorkspaceId;
    qry.ParamByName('nome').AsString := aValue.Nome;
    qry.ParamByName('login').AsString := aValue.Login;
    qry.ParamByName('ativo').AsBoolean := aValue.Ativo;
    qry.ParamByName('email').AsString := aValue.Email;
    qry.ParamByName('telefone').AsString := aValue.Telefone;
    qry.ParamByName('celular').AsString := aValue.Celular;
    if not(aValue.CreatedBy=GUID_NULL) then
      qry.ParamByName('created_by').AsString := aValue.CreatedBy;
    if not(aValue.UpdatedBy=GUID_NULL) then
      qry.ParamByName('updated_by').AsString := aValue.UpdatedBy;
    qry.OpenOrExecute;
    aValue.Id :=  qry.FieldByName('id').AsString;
    Result := True;
  finally
    FreeAndNil(qry);
  end;
end;

function TworkspaceUserDAO.DeleteWorkspaceUserById(aWorkspaceID: string;
  const aId: string): Integer;
var qry: TFDQuery;
begin
  Result := 0;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := Connection;
    qry.SQL.Text := 'DELETE FROM workspace_users WHERE id = :id::uuid AND workspace_id = :workspace_id::uuid';
    qry.ParamByName('id').AsString := aId;
    qry.ParamByName('workspace_id').AsString := aWorkspaceID;
    qry.ExecSQL;
    Result := qry.RowsAffected;
  finally
    FreeAndNil(qry);
  end;

end;

function TworkspaceUserDAO.GetAllWorkspaceUsers(
  aWorkspaceID: string): TObjectList<TWorkspaceUserDTO>;
var qry: TFDQuery;
    dto: TWorkspaceUserDTO;
begin
  Result := TObjectList<TWorkspaceUserDTO>.Create;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := Connection;
    qry.SQL.Add('SELECT id::varchar');
    qry.SQL.Add(', workspace_id::varchar'); 
    qry.SQL.Add(', nome');
    qry.SQL.Add(', login');
    qry.SQL.Add(', ativo');
    qry.SQL.Add(', email');
    qry.SQL.Add(', telefone');
    qry.SQL.Add(', celular');
    qry.SQL.Add(', created_by::varchar');
    qry.SQL.Add(', updated_by::varchar');
    qry.SQL.Add(', created_at');
    qry.SQL.Add(', updated_at');
    qry.SQL.Add('FROM workspace_users');
    qry.SQL.Add('WHERE workspace_id = :workspace_id::uuid');
    qry.ParamByName('workspace_id').AsString := aWorkspaceID;
    qry.Open;
    while not qry.Eof do
    begin
      dto := TWorkspaceUserDTO.Create;
      dto.Id := qry.FieldByName('id').AsString;
      dto.WorkspaceId := qry.FieldByName('workspace_id').AsString;
      dto.Nome := qry.FieldByName('nome').AsString;
      dto.Login := qry.FieldByName('login').AsString;
      dto.Ativo := qry.FieldByName('ativo').AsBoolean;
      dto.Email := qry.FieldByName('email').AsString;
      dto.Telefone := qry.FieldByName('telefone').AsString;
      dto.Celular := qry.FieldByName('celular').AsString;
      dto.CreatedBy := qry.FieldByName('created_by').AsString;
      dto.UpdatedBy := qry.FieldByName('updated_by').AsString;
      dto.CreatedAt := qry.FieldByName('created_at').AsDateTime;
      dto.UpdatedAt := qry.FieldByName('updated_at').AsDateTime;
      Result.Add(dto);
      qry.Next;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

class function TworkspaceUserDAO.getInstance: TworkspaceUserDAO;
begin
  if Assigned(m_instance) and not m_instance.Connection.Connected  then
    FreeAndNil(m_instance);

  if not Assigned(m_instance) then
    m_instance := TworkspaceUserDAO.Create( TDBConfig.getInstance.HostName
                                      , TDBConfig.getInstance.Port.ToString
                                      , TDBConfig.getInstance.DataBase
                                      , TDBConfig.getInstance.UserName
                                      , TDBConfig.getInstance.Password
    );

  Result := m_instance;
end;

function TworkspaceUserDAO.GetWorkspaceUserById(aWorkspaceID: string;
  const aId: string): TWorkspaceUserDTO;
var qry: TFDQuery;
    dto: TWorkspaceUserDTO;
begin
  Result := nil;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := Connection;
    qry.SQL.Add('SELECT id::varchar');
    qry.SQL.Add(', workspace_id::varchar');
    qry.SQL.Add(', nome');
    qry.SQL.Add(', login');
    qry.SQL.Add(', ativo');
    qry.SQL.Add(', email');
    qry.SQL.Add(', telefone');
    qry.SQL.Add(', celular');
    qry.SQL.Add(', created_by::varchar');
    qry.SQL.Add(', updated_by::varchar');
    qry.SQL.Add(', created_at');
    qry.SQL.Add(', updated_at');
    qry.SQL.Add('FROM workspace_users');
    qry.SQL.Add('WHERE id = :id::uuid AND workspace_id = :workspace_id::uuid');
    qry.ParamByName('id').AsString := aId;
    qry.ParamByName('workspace_id').AsString := aWorkspaceID;
    qry.Open;
    if not qry.IsEmpty then
    begin
      dto := TWorkspaceUserDTO.Create;
      dto.Id := qry.FieldByName('id').AsString;
      dto.WorkspaceId := qry.FieldByName('workspace_id').AsString;
      dto.Nome := qry.FieldByName('nome').AsString;
      dto.Login := qry.FieldByName('login').AsString;
      dto.Ativo := qry.FieldByName('ativo').AsBoolean;
      dto.Email := qry.FieldByName('email').AsString;
      dto.Telefone := qry.FieldByName('telefone').AsString;
      dto.Celular := qry.FieldByName('celular').AsString;
      dto.CreatedBy := qry.FieldByName('created_by').AsString;
      dto.UpdatedBy := qry.FieldByName('updated_by').AsString;
      dto.CreatedAt := qry.FieldByName('created_at').AsDateTime;
      dto.UpdatedAt := qry.FieldByName('updated_at').AsDateTime;
      Result := dto;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TworkspaceUserDAO.UpdateWorkspaceUserById(aWorkspaceID: string;
  const reqUserID, aId: string; const aDTO: TWorkspaceUserDTO): Integer;
var qry: TFDQuery;
begin
  Result := 0;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := Connection;
    qry.SQL.Clear;
    qry.SQL.Add('UPDATE workspace_users');
    qry.SQL.Add('SET nome = :nome');
    qry.SQL.Add(', login = :login');
    qry.SQL.Add(', ativo = :ativo');
    qry.SQL.Add(', email = :email');
    qry.SQL.Add(', telefone = :telefone');
    qry.SQL.Add(', celular = :celular');
    if not(aDTO.UpdatedBy=GUID_NULL) then
      qry.SQL.Add(', updated_by = :updated_by::uuid');
    qry.SQL.Add('WHERE id = :id::uuid');
    qry.SQL.Add('AND workspace_id = :workspace_id::uuid');
    qry.ParamByName('id').AsString := aId;
    qry.ParamByName('workspace_id').AsString := aWorkspaceID;
    qry.ParamByName('nome').AsString := aDTO.Nome;
    qry.ParamByName('login').AsString := aDTO.Login;
    qry.ParamByName('ativo').AsBoolean := aDTO.Ativo;
    qry.ParamByName('email').AsString := aDTO.Email;
    qry.ParamByName('telefone').AsString := aDTO.Telefone;
    qry.ParamByName('celular').AsString := aDTO.Celular;
    if not(aDTO.UpdatedBy=GUID_NULL) then
      qry.ParamByName('updated_by').AsString := aDTO.UpdatedBy;
    qry.ExecSQL;
    Result := qry.RowsAffected;
  finally
    FreeAndNil(qry);
  end;

end;

end.
