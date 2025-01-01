unit emissorfiscal.dao.adminuser;

interface

uses
  System.Classes, System.SysUtils,
  emissorfiscal.databaseconnection,
  emissorFiscal.dto.adminuser,
  emissorfiscal.queryhelper,
  apinfe.dto.config.db,
  System.Generics.Collections;

type
  TAdminUserDAO = class(TDatabaseConnection)
  private
    //
  protected
    class var m_instance: TAdminUserDAO;
  public
    function GetAllAdminUsers: TObjectList<TAdminUserDTO>;
    function CreateAdminUser(const aAdminUser: TAdminUserDTO): Boolean;
    function ValidateUserByUsername(const aUsername, aPassword: string): Boolean;
    function ValidateUserByEmail(const aEmail, aPassword: string): Boolean;
    function getUserByLoginByUsername(const aUsername, aPassword: string): TAdminUserDTO; overload;
    function getUserByLoginByUsername(const aLogin: string): TAdminUserDTO; overload;
    function getUserByLoginByEmail(const aEmail, aPassword: string): TAdminUserDTO;
    function getUserById(const aId: string): TAdminUserDTO;
    function getUserByEmail(const aEmail: string): TAdminUserDTO;
    function deleteAdminUser(const aId: string): Integer;
    function UpdateAdminUser(const aIdUserResp: string; const aAdminUser: TAdminUserDTO): Integer;

    class function getInstance: TAdminUserDAO;
  end;

implementation

uses
  FireDAC.Stan.Param, FireDAC.Comp.Client, Data.DB, emissorfiscal.helper.strings;

function TAdminUserDAO.GetAllAdminUsers: TObjectList<TAdminUserDTO>;
var adminUser: TAdminUserDTO;
var fdQuery: TFDQuery;
begin
  Result:= TObjectList<TAdminUserDTO>.Create;
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  try
    fdQuery.SQL.Add(TAdminUserDTO.BuildSelect<TAdminUserDTO>);
    fdQuery.Open();
    while not fdQuery.Eof do begin
      adminUser              := TAdminUserDTO.Create;
      AdminUser.Id           := fdQuery.FieldByName('id').AsString;
      AdminUser.Name         := fdQuery.FieldByName('name').AsString;
      AdminUser.Username     := fdQuery.FieldByName('username').AsString;
      AdminUser.Email        := fdQuery.FieldByName('email').AsString;
      AdminUser.PasswordHash := EmptyStr;
      AdminUser.Master       := fdQuery.FieldByName('master').AsBoolean;
      AdminUser.CreatedAt    := fdQuery.FieldByName('created_at').AsDateTime;
      AdminUser.UpdatedAt    := fdQuery.FieldByName('updated_at').AsDateTime;
      Result.Add(AdminUser);
      fdQuery.Next;
    end;
  finally
    FreeAndNil(fdQuery);
  end;
end;

function TAdminUserDAO.CreateAdminUser(const aAdminUser: TAdminUserDTO): Boolean;
var fdQuery: TFDQuery;
begin
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  try
    fdQuery.SQL.Add('INSERT INTO admin_users');
    fdQuery.SQL.Add('(id, name, username, email, password_hash, master, created_at, updated_at, created_by, updated_by)');
    fdQuery.SQL.Add('VALUES');
    fdQuery.SQL.Add('(:id::uuid, :name, :username, :email, crypt(:password_hash, ''md5'') , :master, current_timestamp, current_timestamp, :created_by::uuid, :updated_by::uuid)');
    fdQuery.SQL.Add('returning id::varchar');
    fdQuery.paramByName('id').AsString:= aAdminUser.id;
    fdQuery.paramByName('name').AsString:= aAdminUser.name;
    fdQuery.paramByName('username').AsString:= aAdminUser.username;
    fdQuery.paramByName('email').AsString:= aAdminUser.email;
    fdQuery.paramByName('password_hash').AsString:= aAdminUser.passwordHash;
    fdQuery.paramByName('master').AsBoolean:= aAdminUser.master;
    fdQuery.paramByName('created_by').AsString:= aAdminUser.CreatedBy;
    fdQuery.paramByName('updated_by').AsString:= aAdminUser.UpdatedBy;
    fdQuery.OpenOrExecute;

    aAdminUser.id := fdQuery.FieldByName('id').AsString;

    Result:= True;
  finally
    FreeAndNil(fdQuery);
  end;
end;

function TAdminUserDAO.ValidateUserByEmail(const aEmail,
  aPassword: string): Boolean;
var adminUserDTO: TAdminUserDTO;
var fdQuery: TFDQuery;
var param: TDictionary<string, variant>;
begin
  param:= TDictionary<string, variant>.Create;
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  adminUserDTO:= TAdminUserDTO.Create;
  try
    param.Add('email', aEmail);
    param.Add('password_hash', aPassword);
    fdQuery.SQL.Add(adminUserDTO.BuildSelect<TAdminUserDTO>(param));
    fdQuery.Open();
    Result:= not fdQuery.IsEmpty;
  finally
    FreeAndNil(param);
    FreeAndNil(fdQuery);
    FreeAndNil(adminUserDTO);
  end;
end;

function TAdminUserDAO.ValidateUserByUsername(const aUsername, aPassword: string): Boolean;
var adminUserDTO: TAdminUserDTO;
var fdQuery: TFDQuery;
var param: TDictionary<string, variant>;
begin
  param:= TDictionary<string, variant>.Create;
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  adminUserDTO:= TAdminUserDTO.Create;
  try
    param.Add('username', aUsername);
    param.Add('password_hash', aPassword);
    fdQuery.SQL.Add(adminUserDTO.BuildSelect<TAdminUserDTO>(param));
    fdQuery.Open();
    Result:= not fdQuery.IsEmpty;
  finally
    FreeAndNil(param);
    FreeAndNil(fdQuery);
    FreeAndNil(adminUserDTO);
  end;
end;

class function TAdminUserDAO.getInstance: TAdminUserDAO;
begin
  if Assigned(m_instance) and not m_instance.Connection.Connected  then
    FreeAndNil(m_instance);

  if not Assigned(m_instance) then
    m_instance := TAdminUserDAO.Create( TDBConfig.getInstance.HostName
                                      , TDBConfig.getInstance.Port.ToString
                                      , TDBConfig.getInstance.DataBase
                                      , TDBConfig.getInstance.UserName
                                      , TDBConfig.getInstance.Password
    );
  
  Result := m_instance;  
end;

function TAdminUserDAO.getUserByEmail(const aEmail: string): TAdminUserDTO;
var adminUserDTO: TAdminUserDTO;
var fdQuery: TFDQuery;
begin
  Result:= TAdminUserDTO.Create;
  Result.Master:= False;
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  try
    fdQuery.SQL.Add('SELECT id::varchar, name, username, email, password_hash, master, created_at, updated_at, created_by::varchar, updated_by::varchar ');
    fdQuery.SQL.Add(' FROM admin_users WHERE email = :email');
    fdQuery.ParamByName('email').AsString:= aEmail;
    fdQuery.Open();
    with Result do begin
      id:= fdQuery.FieldByName('id').AsString;
      name:= fdQuery.FieldByName('name').AsString;
      username:= fdQuery.FieldByName('username').AsString;
      email:= fdQuery.FieldByName('email').AsString;
      passwordHash:= EmptyStr;
      master:= fdQuery.FieldByName('master').AsBoolean;
      createdAt:= fdQuery.FieldByName('created_at').AsDateTime;
      updatedAt:= fdQuery.FieldByName('updated_at').AsDateTime;
    end;
  finally
    FreeAndNil(fdQuery);
  end;
end;

function TAdminUserDAO.getUserById(const aId: string): TAdminUserDTO;
var adminUserDTO: TAdminUserDTO;
var fdQuery: TFDQuery;
begin
  Result:= TAdminUserDTO.Create;
  Result.Master:= False;
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  try
    fdQuery.SQL.Add('SELECT id::varchar, name, username, email, password_hash, master, created_at, updated_at, created_by::varchar, updated_by::varchar ');
    fdQuery.SQL.Add(' FROM admin_users WHERE id = :id::uuid');
    fdQuery.ParamByName('id').AsString:= aId;
    fdQuery.Open();
    with Result do begin
      id:= fdQuery.FieldByName('id').AsString;
      name:= fdQuery.FieldByName('name').AsString;
      username:= fdQuery.FieldByName('username').AsString;
      email:= fdQuery.FieldByName('email').AsString;
      passwordHash:= EmptyStr;
      master:= fdQuery.FieldByName('master').AsBoolean;
      createdAt:= fdQuery.FieldByName('created_at').AsDateTime;
      updatedAt:= fdQuery.FieldByName('updated_at').AsDateTime;
    end;
  finally
    FreeAndNil(fdQuery);
  end;
end;

function TAdminUserDAO.getUserByLoginByUsername(const aLogin: string): TAdminUserDTO;
var fdQuery: TFDQuery;
begin
  Result:= nil;
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  try
    fdQuery.SQL.Add('SELECT id::varchar');
    fdQuery.SQL.Add(', name');
    fdQuery.SQL.Add(', username');
    fdQuery.SQL.Add(', email');
    fdQuery.SQL.Add(', master');
    fdQuery.SQL.Add(', created_at');
    fdQuery.SQL.Add(', updated_at');
    fdQuery.SQL.Add(', created_by::varchar');
    fdQuery.SQL.Add(', updated_by::varchar');
    fdQuery.SQL.Add(' FROM admin_users WHERE username = :username ');
    fdQuery.ParamByName('username').AsString        :=  aLogin;
    fdQuery.Open();
    if fdQuery.IsEmpty then
      Exit();

    Result:= TAdminUserDTO.Create;
    with Result do begin
      id:= fdQuery.FieldByName('id').AsString;
      name:= fdQuery.FieldByName('name').AsString;
      username:= fdQuery.FieldByName('username').AsString;
      email:= fdQuery.FieldByName('email').AsString;
      passwordHash:= EmptyStr;
      master:= fdQuery.FieldByName('master').AsBoolean;
      createdAt:= fdQuery.FieldByName('created_at').AsDateTime;
      updatedAt:= fdQuery.FieldByName('updated_at').AsDateTime;
    end;
  finally
    FreeAndNil(fdQuery);
  end;
end;

function TAdminUserDAO.getUserByLoginByUsername(const aUsername,
  aPassword: string): TAdminUserDTO;
var fdQuery: TFDQuery;
begin
  Result:= TAdminUserDTO.Create;
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  try
    fdQuery.SQL.Add('SELECT id::varchar, name, username, email, password_hash, master, created_at, updated_at, created_by::varchar, updated_by::varchar ');
    fdQuery.SQL.Add(' FROM admin_users WHERE username = :username AND password_hash = crypt(:password_hash , ''md5'')');
    fdQuery.ParamByName('username').AsString        :=  aUsername;
    fdQuery.ParamByName('password_hash').AsString   :=  aPassword;
    fdQuery.Open();
    with Result do begin
      id:= fdQuery.FieldByName('id').AsString;
      name:= fdQuery.FieldByName('name').AsString;
      username:= fdQuery.FieldByName('username').AsString;
      email:= fdQuery.FieldByName('email').AsString;
      passwordHash:= EmptyStr;
      master:= fdQuery.FieldByName('master').AsBoolean;
      createdAt:= fdQuery.FieldByName('created_at').AsDateTime;
      updatedAt:= fdQuery.FieldByName('updated_at').AsDateTime;
    end;
  finally
    FreeAndNil(fdQuery);
  end;
end;

function TAdminUserDAO.getUserByLoginByEmail(const aEmail,
  aPassword: string): TAdminUserDTO;
var fdQuery: TFDQuery;
begin
  Result:= TAdminUserDTO.Create;
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  try
    fdQuery.SQL.Add('SELECT id::varchar, name, username, email, password_hash, master, created_at, updated_at, created_by::varchar, updated_by::varchar ');
    fdQuery.SQL.Add(' FROM admin_users WHERE email = :email AND password_hash = crypt(:password_hash , ''md5'')');
    fdQuery.ParamByName('email').AsString         :=  aEmail;
    fdQuery.ParamByName('password_hash').AsString :=  aPassword;
    fdQuery.Open();
    with Result do begin
      id:= fdQuery.FieldByName('id').AsString;
      name:= fdQuery.FieldByName('name').AsString;
      username:= fdQuery.FieldByName('username').AsString;
      email:= fdQuery.FieldByName('email').AsString;
      passwordHash:= EmptyStr;
      master:= fdQuery.FieldByName('master').AsBoolean;
      createdAt:= fdQuery.FieldByName('created_at').AsDateTime;
      updatedAt:= fdQuery.FieldByName('updated_at').AsDateTime;
    end;
  finally
    FreeAndNil(fdQuery);
  end;
end;

function TAdminUserDAO.UpdateAdminUser(const aIdUserResp: string;
  const aAdminUser: TAdminUserDTO): Integer;
var fdQuery: TFDQuery;
begin
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  try
    fdQuery.SQL.Add('UPDATE admin_users SET');
    fdQuery.SQL.Add('name = :name, username = :username, email = :email,');
    fdQuery.SQL.Add('master = :master, updated_at = :updated_at, updated_by = :updated_by::uuid');
    fdQuery.SQL.Add('WHERE id = :id::uuid');
    fdQuery.SQL.Add('returning (SELECT count(*) FROM admin_users WHERE id = :id::uuid) as rowcount');
    fdQuery.ParamByName('id').AsString:= aAdminUser.id;
    fdQuery.ParamByName('name').AsString:= aAdminUser.name;
    fdQuery.ParamByName('username').AsString:= aAdminUser.username;
    fdQuery.ParamByName('email').AsString:= aAdminUser.email;
    fdQuery.ParamByName('master').AsBoolean:= aAdminUser.master;
    fdQuery.ParamByName('updated_at').AsDateTime:= now;
    fdQuery.ParamByName('updated_by').AsString:= aIdUserResp;
    fdQuery.OpenOrExecute;
    Result:= fdQuery.FieldByName('rowcount').AsInteger;
  finally
    FreeAndNil(fdQuery);
  end;

end;

function TAdminUserDAO.deleteAdminUser(const aId: string): Integer;
var fdQuery: TFDQuery;
begin
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  try
    fdQuery.SQL.Add('DELETE FROM admin_users WHERE id = :id::uuid');
    fdQuery.SQL.Add('returning (SELECT count(*) FROM admin_users WHERE id = :id::uuid) as rowcount');
    fdQuery.ParamByName('id').AsString:= aId;
    fdQuery.OpenOrExecute;
    Result:= fdQuery.FieldByName('rowcount').AsInteger;
  finally
    FreeAndNil(fdQuery);
  end;
end;

end.