unit emissorfiscal.controller;

interface

uses
  System.Classes,
  System.JSON,
  System.SysUtils,
  System.DateUtils,
  emissorfiscal.controller.base,
  emissorfiscal.dao.adminuser,
  emissorFiscal.dto.adminuser,
  emissorfiscal.dao.workspaces,
  emissorfiscal.dto.workspaces,
  emissorfiscal.dao.workspaceusers,
  emissorfiscal.dto.workspaceusers,
  emissorfiscal.validate,
  emissorfiscal.types,
  apinfe.constants.errors;


type
  TControllerApiNFe = class(TControllerApiNFeBase)
    private
      //
    public
      GenerateJWTFunction: TGenerateJWTFunction;
      function ReturnJWTLoginAdmin(const aUser, aPassword: string): string;
      //
      function getAllAdminUsers(): TJSONArray;
      function createUser(const aIdUserLogin: string; const aValue:TJSONObject): TJSONObject;
      function getUserByID(const aIdUser: string): TJSONObject;
      function getUserByLogin(const aLogin: string): TJSONObject;
      function updateUserByID(const aIdUserLogin: string; const aIdUser: string; const aValue:TJSONObject): TJSONObject;
      function deleteUserByID(const aIdUserLogin: string; const aIdUser: string): TJSONObject;
      //
      function getAllWorkspace(): TJSONArray;
      function createWorkspace(const aIdUserLogin: string; const aValue:TJSONObject): TJSONObject;
      function getWorkspaceById(const aIdWorkspace: string): TJSONObject;
      function updateWorkspaceByID(const aIdUserLogin: string; const aIdWorkspace: string; const aValue:TJSONObject): TJSONObject;
      function deleteWorkspace(const aIdUserLogin: string; const aIdWorkspace: string): TJSONObject;
      //
      function getAllUsersByWorkspace(const aIdWorkspace: string): TJSONArray;
      function createUserByWorkspace(const aIdUserLogin: string; const aIdWorkspace: string; const aValue:TJSONObject): TJSONObject;
      function getUserByWorkspace(const aIdWorkspace: string; const aIdUser: string): TJSONObject;
      function updateUserByWorkspace(const aIdUserLogin: string; const aIdWorkspace: string; const aIdUser: string; const aValue:TJSONObject): TJSONObject;
      function deleteUserByWorkspace(const aIdUserLogin: string; const aIdWorkspace: string; const aIdUser: string): TJSONObject;
      
     

      //
      procedure getAllClients();
      procedure getAllCompany();
      procedure getCompany();
      procedure updateCompany();
      procedure activeCompany();
      procedure suspendCompany();
      procedure deleteCompany();
      procedure createdCompany();
      procedure configIssuance();
      procedure getSecret();
      procedure createdSecret();
      procedure updateSecret();
      procedure deleteSecret();
      procedure getDashboard();
      procedure getLogDate();
      procedure getLogID();
      procedure getJWT();
      procedure cretedNFe();
      procedure disableNFe();
      procedure cancelNFe();
      procedure getXMLbyKey();
      procedure getPDFbyKey();
      procedure getAllIssuance();
      constructor Create;
  end;

implementation

uses
  emissorfiscal.helper.strings, apinfe.constants;
{ TControllerApi }

procedure TControllerApiNFe.activeCompany;
begin

end;

procedure TControllerApiNFe.cancelNFe;
begin

end;

procedure TControllerApiNFe.configIssuance;
begin

end;

constructor TControllerApiNFe.Create;
begin
 inherited Create;
end;

procedure TControllerApiNFe.createdCompany;
begin

end;

procedure TControllerApiNFe.createdSecret;
begin

end;

function TControllerApiNFe.createUser(const aIdUserLogin: string; const aValue:TJSONObject): TJSONObject;
var AdminUserDTO: TAdminUserDTO;
var newGuid: TGUID;
var strErros: string;
begin
  strErros := EmptyStr;
  AdminUserDTO:= TAdminUserDTO.Create;
  CreateGUID( newGuid );
  try
    if aIdUserLogin.IsEmpty then
      raise Exception.Create(ERROR_USER_NOT_LOGGED);
    if not TAdminUserDAO.getInstance.getUserById(aIdUserLogin).Master then
      raise Exception.Create(ERROR_USER_NOT_PERMISSION);
    
    try
      strErros:= TCustomValidator
                  .Add('name'    , ftString, False)
                  .Add('username', ftString, False)
                  .Add('email'   , ftString, true)
                  .Add('master'  , ftBoolean)
                  .Validate(aValue);

      if not(Trim(strErros)=EmptyStr) then
        raise Exception.Create(strErros);

      AdminUserDTO.CreatedBy := aIdUserLogin;
      AdminUserDTO.UpdatedBy := aIdUserLogin;
      AdminUserDTO.Name      := aValue.GetValue('name').Value;
      AdminUserDTO.Username  := aValue.GetValue('username').Value;
      AdminUserDTO.Email     := aValue.GetValue('email').Value;
      AdminUserDTO.Master    := ( aValue.GetValue('master') as TJSONBool).AsBoolean;
      AdminUserDTO.Id        := newGuid.ToString;
      TAdminUserDAO.getInstance.CreateAdminUser( AdminUserDTO );
      result := TJSONObject.Create.AddPair('id', AdminUserDTO.Id );
    except
        on E: Exception do
          raise Exception.Create(E.Message);
    end;
  finally
     FreeAndNil(AdminUserDTO);
  end;

end;

function TControllerApiNFe.createUserByWorkspace(const aIdUserLogin,
  aIdWorkspace: string; const aValue: TJSONObject): TJSONObject;
var workspaceUserDTO: TWorkspaceUserDTO;
var newGuid: TGUID;
var tel: string;
var Erros: string;
begin
  Erros:= EmptyStr;
  workspaceUserDTO := TWorkspaceUserDTO.Create;
  CreateGUID( newGuid );
  try
    Erros:= TCustomValidator
              .Add('name', ftString, False)
              .Add('login', ftString, False)
              .Add('email', ftString, True)
              .Add('celular', ftString, False)
              .Validate(aValue);

    if not (Erros=EmptyStr) then
      raise Exception.Create(Erros);
    if not aIdWorkspace.IsGUID then
      raise Exception.Create(ERROR_WORKSPACE_NOT_FOUND);

    aValue.TryGetValue('telefone', tel);
    workspaceUserDTO.Id := newGuid.ToString;
    workspaceUserDTO.WorkspaceId := aIdWorkspace;
    workspaceUserDTO.Nome  := aValue.GetValue('name').Value;
    workspaceUserDTO.Login := aValue.GetValue('login').Value;
    workspaceUserDTO.Email := aValue.GetValue('email').Value;
    workspaceUserDTO.Telefone := tel;
    workspaceUserDTO.Celular  := aValue.GetValue('celular').Value;
    workspaceUserDTO.Ativo    := True;
    workspaceUserDTO.CreatedBy := GUID_NULL;
    workspaceUserDTO.UpdatedBy := GUID_NULL;
    workspaceUserDTO.CreatedAt := Now;
    workspaceUserDTO.UpdatedAt := Now;
    TworkspaceUserDAO.getInstance.CreateWorkspaceUser(aIdWorkspace, workspaceUserDTO);
    result := TJSONObject.Create;
    result.AddPair('id', workspaceUserDTO.Id);
  finally
    FreeAndNil(workspaceUserDTO);
  end;

end;

function TControllerApiNFe.createWorkspace(const aIdUserLogin: string;
  const aValue: TJSONObject): TJSONObject;
var workspace: TWorkspaceDTO;
var newGuid: TGUID;
begin
  workspace := TWorkspaceDTO.Create;
  CreateGUID( newGuid );
  try
    workspace.Id := newGuid.ToString;
    workspace.Name := aValue.GetValue('name').Value;
    workspace.CreatedAt := Now;
    workspace.UpdatedAt := Now;
    TWorkspacesDAO.getInstance.CreateWorkspace(workspace);
    result := TJSONObject.Create.AddPair('id', workspace.Id);
  finally
    FreeAndNil(workspace);
  end;
end;

procedure TControllerApiNFe.cretedNFe;
begin

end;

procedure TControllerApiNFe.deleteCompany;
begin

end;

procedure TControllerApiNFe.deleteSecret;
begin

end;

function TControllerApiNFe.deleteUserByID(const aIdUserLogin: string; const aIdUser: string): TJSONObject;
begin
  result := TJSONObject.Create;
  result.AddPair('rows', TAdminUserDAO.getInstance.DeleteAdminUser(aIdUser));
end;

function TControllerApiNFe.deleteUserByWorkspace(const aIdUserLogin,
  aIdWorkspace, aIdUser: string): TJSONObject;
begin
  if not aIdWorkspace.IsGUID then
    raise Exception.Create(ERROR_WORKSPACE_NOT_FOUND);
  if not aIdUser.IsGUID then
    raise Exception.Create(ERROR_USER_NOT_FOUND);
  result := TJSONObject.Create;
  result.AddPair('rows', TworkspaceUserDAO.getInstance.DeleteWorkspaceUserById(aIdWorkspace, aIdUser));
end;

function TControllerApiNFe.deleteWorkspace(const aIdUserLogin,
  aIdWorkspace: string): TJSONObject;
begin
  result := TJSONObject.Create;
  result.AddPair('rows', TWorkspacesDAO.getInstance.DeleteWorkspace(aIdWorkspace));
end;

procedure TControllerApiNFe.disableNFe;
begin

end;

function TControllerApiNFe.getAllAdminUsers: TJSONArray;
var adminUser: TAdminUserDTO;
begin
  Result:= TJSONArray.Create;
  for adminUser in TAdminUserDAO.getInstance.GetAllAdminUsers do begin
    Result.Add(TJSONObject.Create
      .AddPair('id', adminUser.Id)
      .AddPair('name', adminUser.Name)
      .AddPair('username', adminUser.Username)
      .AddPair('email', adminUser.Email)
      .AddPair('master', adminUser.Master)
      .AddPair('created_at', DateToISO8601( adminUser.CreatedAt ))
      .AddPair('updated_at', DateToISO8601( adminUser.UpdatedAt ))
    );
  end;
    

end;

procedure TControllerApiNFe.getAllClients;
begin

end;

procedure TControllerApiNFe.getAllCompany;
begin

end;

procedure TControllerApiNFe.getAllIssuance;
begin

end;

function TControllerApiNFe.getAllUsersByWorkspace(
  const aIdWorkspace: string): TJSONArray;
var workspaceUser: TWorkspaceUserDTO;
var guid: TGUID;
begin
  if not aIdWorkspace.IsGUID then
    raise Exception.Create(ERROR_WORKSPACE_NOT_FOUND);
  
  Result:= TJSONArray.Create;
  for workspaceUser in TworkspaceUserDAO.getInstance.GetAllWorkspaceUsers(aIdWorkspace) do begin
    Result.Add(TJSONObject.Create
      .AddPair('id', workspaceUser.Id)
      .AddPair('name', workspaceUser.Nome)
      .AddPair('login', workspaceUser.Login)
      .AddPair('email', workspaceUser.Email)
      .AddPair('telefone', workspaceUser.Telefone)
      .AddPair('celular', workspaceUser.Celular)
      .AddPair('ativo', workspaceUser.Ativo)
      .AddPair('created_at', DateToISO8601( workspaceUser.CreatedAt ))
      .AddPair('updated_at', DateToISO8601( workspaceUser.UpdatedAt ))
    );
  end;

end;

function TControllerApiNFe.getAllWorkspace: TJSONArray;
var workspace: TWorkspaceDTO;
begin
  Result:= TJSONArray.Create;
  for workspace in TWorkspacesDAO.getInstance.GetAllWorkspaces do begin
    Result.Add(TJSONObject.Create
      .AddPair('id', workspace.Id)
      .AddPair('name', workspace.Name)
      .AddPair('created_at', DateToISO8601( workspace.CreatedAt ))
      .AddPair('updated_at', DateToISO8601( workspace.UpdatedAt ))
    );
  end;

end;

procedure TControllerApiNFe.getCompany;
begin

end;

procedure TControllerApiNFe.getDashboard;
begin

end;

procedure TControllerApiNFe.getJWT;
begin

end;

procedure TControllerApiNFe.getLogDate;
begin

end;

procedure TControllerApiNFe.getLogID;
begin

end;

procedure TControllerApiNFe.getPDFbyKey;
begin

end;

procedure TControllerApiNFe.getSecret;
begin

end;

function TControllerApiNFe.getUserByID(const aIdUser: string): TJSONObject;
var adminUser: TAdminUserDTO;
begin
  adminUser := nil;
  try
    if (aIdUser=EmptyStr) then
      exit(nil);
    adminUser := TAdminUserDAO.getInstance.getUserById(aIdUser);

    if not Assigned(adminUser) or adminUser.Id.IsEmpty then
      raise Exception.Create(ERROR_USER_NOT_FOUND);

    result := TJSONObject.Create
      .AddPair('id', adminUser.Id)
      .AddPair('name', adminUser.Name)
      .AddPair('username', adminUser.Username)
      .AddPair('email', adminUser.Email)
      .AddPair('master', adminUser.Master)
      .AddPair('created_at', DateToISO8601( adminUser.CreatedAt ))
      .AddPair('updated_at', DateToISO8601( adminUser.UpdatedAt ));
  finally
    if Assigned(adminUser) then
      FreeAndNil(adminUser);
  end;
end;

function TControllerApiNFe.getUserByLogin(const aLogin: string): TJSONObject;
var adminUser: TAdminUserDTO;
begin
  adminUser := nil;
  try
    if (aLogin=EmptyStr) then
      exit(nil);
    adminUser := TAdminUserDAO.getInstance.getUserByLogin(aLogin);

    if not Assigned(adminUser) or adminUser.Id.IsEmpty then
      raise Exception.Create(ERROR_USER_NOT_FOUND);

    result := TJSONObject.Create
      .AddPair('id', adminUser.Id)
      .AddPair('name', adminUser.Name)
      .AddPair('username', adminUser.Username)
      .AddPair('email', adminUser.Email)
      .AddPair('master', adminUser.Master)
      .AddPair('created_at', DateToISO8601( adminUser.CreatedAt ))
      .AddPair('updated_at', DateToISO8601( adminUser.UpdatedAt ));
  finally
    if Assigned(adminUser) then
      FreeAndNil(adminUser);
  end;
end;

function TControllerApiNFe.getUserByWorkspace(const aIdWorkspace,
  aIdUser: string): TJSONObject;
var workspaceUser: TWorkspaceUserDTO;
begin
  try
    workspaceUser := TworkspaceUserDAO.getInstance.GetWorkspaceUserById(aIdWorkspace, aIdUser);
    result := TJSONObject.Create
      .AddPair('id', workspaceUser.Id)
      .AddPair('name', workspaceUser.Nome)
      .AddPair('login', workspaceUser.Login)
      .AddPair('email', workspaceUser.Email)
      .AddPair('telefone', workspaceUser.Telefone)
      .AddPair('celular', workspaceUser.Celular)
      .AddPair('ativo', workspaceUser.Ativo)
      .AddPair('created_at', DateToISO8601( workspaceUser.CreatedAt ))
      .AddPair('updated_at', DateToISO8601( workspaceUser.UpdatedAt ));
  finally
    FreeAndNil(workspaceUser);
  end;

end;

function TControllerApiNFe.getWorkspaceById(
  const aIdWorkspace: string): TJSONObject;
var workspace: TWorkspaceDTO;
begin
  workspace := TWorkspacesDAO.getInstance.getWorkspaceById(aIdWorkspace);
  try
    result := TJSONObject.Create
      .AddPair('id', workspace.Id)
      .AddPair('name', workspace.Name)
      .AddPair('created_at', DateToISO8601( workspace.CreatedAt ))
      .AddPair('updated_at', DateToISO8601( workspace.UpdatedAt ));
  finally
    FreeAndNil(workspace);
  end;

end;

procedure TControllerApiNFe.getXMLbyKey;
begin

end;

function TControllerApiNFe.ReturnJWTLoginAdmin(const aUser, aPassword: string): string;
begin
  Result:= '';

  if TAdminUserDAO.getInstance.ValidateUser(aUser, aPassword) then begin
    with TAdminUserDAO.getInstance.getUserByLogin(aUser, aPassword) do begin
      if Assigned(GenerateJWTFunction) then
        Result := GenerateJWTFunction(Id,Name,Email,Master);
    end;
  end;

end;

procedure TControllerApiNFe.suspendCompany;
begin

end;

procedure TControllerApiNFe.updateCompany;
begin

end;

procedure TControllerApiNFe.updateSecret;
begin

end;

function TControllerApiNFe.updateUserByID(const aIdUserLogin: string;
  const aIdUser: string; const aValue:TJSONObject): TJSONObject;
var AdminUserDTO: TAdminUserDTO;
var strErros: string;
begin
  strErros := EmptyStr;
  result   := TJSONObject.Create;  
  try
    AdminUserDTO:= TAdminUserDAO.getInstance.getUserById(aIdUser);
    AdminUserDTO.Id          := aIdUser;
    AdminUserDTO.Name        := aValue.GetValue<string>('name', AdminUserDTO.Name );
    AdminUserDTO.Username    := aValue.GetValue<string>('username', AdminUserDTO.Username );
    AdminUserDTO.Email       := aValue.GetValue<string>('email', AdminUserDTO.Email );
    AdminUserDTO.Master      := aValue.GetValue<Boolean>('master', AdminUserDTO.Master );

    strErros:= TCustomValidator
                .Add('name',ftString, False)
                .Add('username',ftString, False)
                .Add('email',ftString, True)
                .Validate(AdminUserDTO);
    if not (strErros=EmptyStr) then
      raise Exception.Create(strErros);

    result.AddPair('rows', TAdminUserDAO.getInstance.UpdateAdminUser(aIdUserLogin, AdminUserDTO));
  finally
    FreeAndNil(AdminUserDTO);
  end;
end;

function TControllerApiNFe.updateUserByWorkspace(const aIdUserLogin,
  aIdWorkspace, aIdUser: string; const aValue: TJSONObject): TJSONObject;
var workspaceUserDTO: TWorkspaceUserDTO;
begin
  try
    if not aIdWorkspace.IsGUID then
      raise Exception.Create(ERROR_WORKSPACE_NOT_FOUND);
    if not aIdUser.IsGUID then
      raise Exception.Create(ERROR_USER_NOT_FOUND);
    workspaceUserDTO := TworkspaceUserDAO.getInstance.GetWorkspaceUserById(aIdWorkspace, aIdUser);
    if not Assigned(workspaceUserDTO) then
      raise Exception.Create(ERROR_USER_NOT_FOUND);

    workspaceUserDTO.Nome     := aValue.GetValue<string>('name'    , workspaceUserDTO.Nome);
    workspaceUserDTO.Email    := aValue.GetValue<string>('email'   , workspaceUserDTO.Email);
    workspaceUserDTO.Telefone := aValue.GetValue<string>('telefone', workspaceUserDTO.Telefone);
    workspaceUserDTO.Celular  := aValue.GetValue<string>('celular' , workspaceUserDTO.Celular);
    workspaceUserDTO.Ativo    := aValue.GetValue<Boolean>('ativo'  , workspaceUserDTO.Ativo);

    workspaceUserDTO.UpdatedBy := GUID_NULL;
    result := TJSONObject.Create;
    result.AddPair('rows', TworkspaceUserDAO.getInstance.UpdateWorkspaceUserById(aIdWorkspace, aIdUserLogin, aIdUser, workspaceUserDTO));
  finally
    FreeAndNil(workspaceUserDTO);
  end;

end;

function TControllerApiNFe.updateWorkspaceByID(const aIdUserLogin,
  aIdWorkspace: string; const aValue: TJSONObject): TJSONObject;
var workspace: TWorkspaceDTO;
begin
  workspace := TWorkspaceDTO.Create;
  try
    workspace.Id := aIdWorkspace;
    workspace.Name := aValue.GetValue('name').Value;
    workspace.UpdatedAt := Now;
    result := TJSONObject.Create;
    result.AddPair('rows', TWorkspacesDAO.getInstance.UpdateWorkspace(aIdUserLogin, workspace));
  finally
    FreeAndNil(workspace);
  end;

end;

end.
