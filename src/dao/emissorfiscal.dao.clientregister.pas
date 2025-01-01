unit emissorfiscal.dao.clientregister;

interface

uses
  System.SysUtils, System.Generics.Collections,
  FireDAC.Stan.Param, FireDAC.Comp.Client,
  FireDAC.Stan.Option, Data.DB,
  emissorfiscal.databaseconnection, 
  emissorfiscal.dto.clientregister,
  emissorfiscal.validate,
  apinfe.dto.config.db;

type
  TClientRegisterDAO = class(TDatabaseConnection)
  protected
    class var m_instance: TClientRegisterDAO;
  public
    function RegisterClient(const ClientRegisterDTO: TClientRegisterDTO): Boolean;
    class function getInstance: TClientRegisterDAO;
  end;

implementation

function TClientRegisterDAO.RegisterClient(const ClientRegisterDTO: TClientRegisterDTO): Boolean;
var
  WorkspaceQuery: TFDQuery;
  strErroWorkspace, strErroWorkspaceUser: string;
begin
  Result := False;
  strErroWorkspace:= TCustomValidator
                      .Add('Id', ftString, False)
                      .Add('Name', ftString, False)
                      .Validate(ClientRegisterDTO.Workspace);

  strErroWorkspaceUser:= TCustomValidator
                          .Add('Id', ftString, False)
                          .Add('WorkspaceId', ftString, False)
                          .Add('Nome', ftString, False)
                          .Add('Login', ftString, False)
                          .Add('Email', ftString, True)
                          .Add('Celular', ftString, False)
                          .Add('CreatedBy', ftString, False)
                          .Add('UpdatedBy', ftString, False)
                          .Validate(ClientRegisterDTO.WorkspaceUser);

  if not (Trim(strErroWorkspace) = EmptyStr) then
    strErroWorkspace := 'Um ou mais campo de Workspace não foram preenchidos corretamente: ' + sLineBreak + strErroWorkspace;
  if not (Trim(strErroWorkspaceUser) = EmptyStr) then
    strErroWorkspaceUser := 'Um ou mais campo de WorkspaceUser não foram preenchidos corretamente: ' + sLineBreak + strErroWorkspaceUser;
  if not (Trim(strErroWorkspace) = EmptyStr) or not (Trim(strErroWorkspaceUser) = EmptyStr) then
    raise Exception.Create(strErroWorkspace + sLineBreak + strErroWorkspaceUser);

  WorkspaceQuery := TFDQuery.Create(nil);
  try
    WorkspaceQuery.Connection := Connection;
    try
      // Check if email is already in use
      WorkspaceQuery.SQL.Add('SELECT 1 FROM workspace_users WHERE email = :email;');
      WorkspaceQuery.ParamByName('email').AsString := ClientRegisterDTO.WorkspaceUser.Email;
      WorkspaceQuery.Open;

      if Not WorkspaceQuery.Isempty then
        raise Exception.Create('O email já está em uso.');

      WorkspaceQuery.Close;
      WorkspaceQuery.SQL.Clear;

      // Check if login is already in use
      WorkspaceQuery.SQL.Add('SELECT 1 FROM workspace_users WHERE login = :login;');
      WorkspaceQuery.ParamByName('login').AsString := ClientRegisterDTO.WorkspaceUser.Login;
      WorkspaceQuery.Open;
      if not WorkspaceQuery.IsEmpty then
        raise Exception.Create('O login já está em uso.');

      WorkspaceQuery.Close;
      WorkspaceQuery.SQL.Clear;

      // Insert into workspace and workspace_user
      WorkspaceQuery.SQL.Add(';with ws as (');
      WorkspaceQuery.SQL.Add('	INSERT INTO workspaces ( id, name, created_at, updated_at)');
      WorkspaceQuery.SQL.Add('	values(:workspaces_id::uuid, :workspaces_name, current_timestamp, current_timestamp)');
      WorkspaceQuery.SQL.Add('	returning id::varchar as workspace_id');
      WorkspaceQuery.SQL.Add('), ws_user as (');
      WorkspaceQuery.SQL.Add('	INSERT INTO workspace_users(id, workspace_id, nome, login, ativo, password_hash');
      WorkspaceQuery.SQL.Add(', email, telefone, celular, email_confirmado, celular_confirmado)');
      WorkspaceQuery.SQL.Add('	values(:id::uuid, :workspace_id::uuid, :nome, :login, :ativo, :password_hash');
      WorkspaceQuery.SQL.Add(', :email, :telefone, :celular, :email_confirmado, :celular_confirmado)');
      WorkspaceQuery.SQL.Add('	returning id::varchar as workspace_user_id');
      WorkspaceQuery.SQL.Add(') select * from ws, ws_user');

      WorkspaceQuery.ParamByName('workspaces_id').AsString  := ClientRegisterDTO.Workspace.Id;
      WorkspaceQuery.ParamByName('workspaces_name').AsString:= ClientRegisterDTO.Workspace.Name;
      WorkspaceQuery.ParamByName('id').AsString             := ClientRegisterDTO.WorkspaceUser.Id;
      WorkspaceQuery.ParamByName('workspace_id').AsString   := ClientRegisterDTO.WorkspaceUser.WorkspaceId;
      WorkspaceQuery.ParamByName('nome').AsString           := ClientRegisterDTO.WorkspaceUser.Nome;
      WorkspaceQuery.ParamByName('login').AsString          := ClientRegisterDTO.WorkspaceUser.Login;
      WorkspaceQuery.ParamByName('ativo').AsBoolean         := ClientRegisterDTO.WorkspaceUser.Ativo;
      WorkspaceQuery.ParamByName('password_hash').AsString  := ClientRegisterDTO.WorkspaceUser.PasswordHash;
      WorkspaceQuery.ParamByName('email').AsString          := ClientRegisterDTO.WorkspaceUser.Email;
      WorkspaceQuery.ParamByName('telefone').AsString       := ClientRegisterDTO.WorkspaceUser.Telefone;
      WorkspaceQuery.ParamByName('celular').AsString        := ClientRegisterDTO.WorkspaceUser.Celular;
      WorkspaceQuery.ParamByName('email_confirmado').AsBoolean   := False;
      WorkspaceQuery.ParamByName('celular_confirmado').AsBoolean := False;
      WorkspaceQuery.Open;
      ClientRegisterDTO.WorkspaceUser.Id := WorkspaceQuery.FieldByName('workspace_user_id').AsString;
      ClientRegisterDTO.Workspace.Id     := WorkspaceQuery.FieldByName('workspace_id').AsString;
      Result := True;
    except
      on E: Exception do
        begin
          raise Exception.Create('Erro ao registrar cliente: ' + E.Message);
        end;
    end;
  finally
    if Assigned(WorkspaceQuery) then
      FreeAndNil(WorkspaceQuery);
  end;

end;

class function TClientRegisterDAO.getInstance: TClientRegisterDAO;
begin
  if Assigned(m_instance) and not m_instance.Connection.Connected  then
    FreeAndNil(m_instance);

  if not Assigned(m_instance) then
    m_instance := TClientRegisterDAO.Create( TDBConfig.getInstance.HostName
                                      , TDBConfig.getInstance.Port.ToString
                                      , TDBConfig.getInstance.DataBase
                                      , TDBConfig.getInstance.UserName
                                      , TDBConfig.getInstance.Password
    );

  Result := m_instance;
end;

end.
