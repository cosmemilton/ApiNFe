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
    function ValidateUser(const Username, Password: string): Boolean;
    function getUserByLogin(const Username, Password: string): TAdminUserDTO;
    class function getInstance: TAdminUserDAO;
  end;

implementation

uses
  FireDAC.Stan.Param, FireDAC.Comp.Client;

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

function TAdminUserDAO.ValidateUser(const Username, Password: string): Boolean;
var adminUserDTO: TAdminUserDTO;
var fdQuery: TFDQuery;
var param: TDictionary<string, variant>;
begin
  param:= TDictionary<string, variant>.Create;
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  adminUserDTO:= TAdminUserDTO.Create;
  try
    param.Add('username', Username);
    param.Add('password_hash', Password);
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

function TAdminUserDAO.getUserByLogin(const Username,
  Password: string): TAdminUserDTO;
var adminUserDTO: TAdminUserDTO;
var fdQuery: TFDQuery;
var param: TDictionary<string, variant>;
begin
  Result:= TAdminUserDTO.Create;
  param:= TDictionary<string, variant>.Create;
  fdQuery:=TFDQuery.CreateAndConnect(Self.Connection);
  adminUserDTO:= TAdminUserDTO.Create;
  try
    param.Add('username', Username);
    param.Add('password_hash', Password);
    fdQuery.SQL.Add(adminUserDTO.BuildSelect<TAdminUserDTO>(param));
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
    FreeAndNil(param);
    FreeAndNil(fdQuery);
    FreeAndNil(adminUserDTO);
  end;
end;

end.