unit emissorfiscal.dao.workspaces;

interface

uses
  System.Classes, System.SysUtils,
  FireDAC.Stan.Param, FireDAC.Comp.Client,
  emissorfiscal.databaseconnection,
  emissorFiscal.dto.workspaces,
  emissorfiscal.queryhelper,
  apinfe.dto.config.db,
  System.Generics.Collections;

type
  TWorkspacesDAO = class(TDatabaseConnection)
  private
    //
  protected
    class var m_instance: TWorkspacesDAO;
  public
    function CreateWorkspace(const AWorkspace: TWorkspaceDTO): Boolean;
    function GetWorkspaceById(const AId: string): TWorkspaceDTO;
    function GetAllWorkspaces: TObjectList<TWorkspaceDTO>;
    function UpdateWorkspace(const aIdUserLogin: string; const AWorkspace: TWorkspaceDTO): Integer;
    function DeleteWorkspace(const AId: string): Integer;
    class function getInstance: TWorkspacesDAO;
  end;


implementation

{ TWorkspacesDAO }

function TWorkspacesDAO.CreateWorkspace(const AWorkspace: TWorkspaceDTO): Boolean;
var
  Query: TFDQuery;
begin
  Result:= False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Add( 'INSERT INTO workspaces (id, name,  created_at, updated_at) ' );
    Query.SQL.Add( 'VALUES (:id::uuid, :name, current_timestamp, current_timestamp)' );
    Query.SQL.Add( 'returning id::varchar' );
    Query.ParamByName('id').AsString := AWorkspace.Id;
    Query.ParamByName('name').AsString := AWorkspace.Name;
    Query.OpenOrExecute;
    AWorkspace.Id := Query.FieldByName('id').AsString;
    Result:= True;
  finally
    FreeAndNil(Query);
  end;
end;

function TWorkspacesDAO.GetWorkspaceById(const AId: string): TWorkspaceDTO;
var
  Query: TFDQuery;
  Workspace: TWorkspaceDTO;
begin
  Workspace := nil;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Text := 'SELECT id::varchar, name, created_at, updated_at FROM workspaces WHERE id = :id::uuid';
    Query.ParamByName('id').AsString := AId;
    Query.Open;
    if not Query.Eof then
    begin
      Workspace := TWorkspaceDTO.Create;
      Workspace.Id := Query.FieldByName('id').AsString;
      Workspace.Name := Query.FieldByName('name').AsString;
      Workspace.CreatedAt := Query.FieldByName('created_at').AsDateTime;
      Workspace.UpdatedAt := Query.FieldByName('updated_at').AsDateTime;
    end;
  finally
    FreeAndNil(Query);
  end;
  Result := Workspace;
end;

function TWorkspacesDAO.GetAllWorkspaces: TObjectList<TWorkspaceDTO>;
var
  Query: TFDQuery;
  Workspace: TWorkspaceDTO;
begin
  Result := TObjectList<TWorkspaceDTO>.Create;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Text := 'SELECT id::varchar, name,created_at,updated_at FROM workspaces';
    Query.Open;
    while not Query.Eof do
    begin
      Workspace := TWorkspaceDTO.Create;
      Workspace.Id := Query.FieldByName('id').AsString;
      Workspace.Name := Query.FieldByName('name').AsString;
      Workspace.CreatedAt := Query.FieldByName('created_at').AsDateTime;
      Workspace.UpdatedAt := Query.FieldByName('updated_at').AsDateTime;
      Result.Add(Workspace);
      Query.Next;
    end;
  finally
    FreeAndNil( Query );
  end;
end;

function TWorkspacesDAO.UpdateWorkspace(const aIdUserLogin: string;
const AWorkspace: TWorkspaceDTO): Integer;
var
  Query: TFDQuery;
begin
  Result := 0;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Add( 'UPDATE workspaces SET name = :name, ');
    Query.SQL.Add( 'updated_at = current_timestamp'  );
    Query.SQL.Add( ' WHERE id = :id::uuid' );
    Query.SQL.Add( 'returning (SELECT count(*) FROM workspaces WHERE id = :id::uuid) as rowcount ');
    Query.ParamByName('id').AsString := AWorkspace.Id;
    Query.ParamByName('name').AsString := AWorkspace.Name;
    Query.OpenOrExecute;
    Result := Query.FieldByName('rowcount').AsInteger;
  finally
    FreeAndNil( Query );
  end;
end;

function TWorkspacesDAO.DeleteWorkspace(const AId: string): Integer;
var
  Query: TFDQuery;
begin
  Result := 0;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Add( 'DELETE FROM workspaces WHERE id = :id::uuid');
    Query.SQL.Add('returning (SELECT count(*) FROM workspaces WHERE id = :id::uuid) as rowcount');
    Query.ParamByName('id').AsString := AId;
    Query.OpenOrExecute;
    Result := Query.FieldByName('rowcount').AsInteger;
  finally
    FreeAndNil( Query );
  end;
end;

class function TWorkspacesDAO.getInstance: TWorkspacesDAO;
begin
  if Assigned(m_instance) and not m_instance.Connection.Connected  then
    FreeAndNil(m_instance);

  if not Assigned(m_instance) then
    m_instance := TWorkspacesDAO.Create( TDBConfig.getInstance.HostName
                                      , TDBConfig.getInstance.Port.ToString
                                      , TDBConfig.getInstance.DataBase
                                      , TDBConfig.getInstance.UserName
                                      , TDBConfig.getInstance.Password
    );

  Result := m_instance;
end;



end.
