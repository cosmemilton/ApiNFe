unit uApiControllerTest;

interface

uses
  DUnitX.TestFramework,
  emissorfiscal.controller,
  apinfe.constants.errors,
  System.JSON;

type
  [TestFixture]
  TApiControllerTest = class
    FController: TControllerApiNFe;
    FGuidAdmin: string;
    FGuidOther: string;
    FGuidWorkspace: string;
    FGuidUser: string;
  public
    [TestCase('Iniciando Controller','')]
    procedure iniciarController;
    [TestCase('Verificando se o usuário inicial foi criado','')]
    procedure TestGetAllAdminUsers;
    [TestCase('Obtendo usuário por ID','')]
    procedure TestGetUserByID;
    [TestCase('Obtendo usuário por Login','')]
    procedure TestGetUserByLogin;
    [TestCase('Obtendo usuário por ID vazio','')]
    procedure TestGetUserByIDEmpty;
    [TestCase('Adicionando um novo usuário','')]
    procedure TestCreateUser;
    [TestCase('Adicionando um novo usuário com email inválido','')]
    procedure TestCreateUserInvalidEmail;
    [TestCase('Atualizando usuário por ID','')]
    procedure TestUpdateUserByID;
    [TestCase('Atualizando usuário por ID com email inválido','')]
    procedure TestUpdateUserByIDInvalidEmail;
    [TestCase('Deletando usuário por ID','')]
    procedure TestDeleteUserByID;
    [TestCase('Testando getAllWorkspace','')]
    procedure TestGetAllWorkspace;
    [TestCase('Testando createWorkspace','')]
    procedure TestCreateWorkspace;
    [TestCase('Testando getWorkspaceById','')]
    procedure TestGetWorkspaceById;
    [TestCase('Testando updateWorkspaceByID','')]
    procedure TestUpdateWorkspaceByID;
    [TestCase('Testando getAllUsersByWorkspace','')]
    procedure TestGetAllUsersByWorkspace;
    [TestCase('Testando createUserByWorkspace','')]
    procedure TestCreateUserByWorkspace;
    [TestCase('Testando getUserByWorkspace','')]
    procedure TestGetUserByWorkspace;
    [TestCase('Testando updateUserByWorkspace','')]
    procedure TestUpdateUserByWorkspace;
    [TestCase('Testando deleteUserByWorkspace','')]
    procedure TestDeleteUserByWorkspace;
    [TestCase('Testando deleteWorkspace','')]
    procedure TestDeleteWorkspace;
    [TestCase('Destruindo Controller','')]
    procedure destruindoController;

  end;

implementation

uses
  System.SysUtils;

procedure TApiControllerTest.destruindoController;
begin
  FreeAndNil(FController);
end;

procedure TApiControllerTest.iniciarController;
begin
  FController:= TControllerApiNFe.Create;
end;

procedure TApiControllerTest.TestGetAllAdminUsers;
var
  Users: TJSONArray;
begin
  Users := FController.getAllAdminUsers;
  if Users.Count = 0 then
    Assert.Fail('Erro: O usuário inicial não foi criado.');

  FGuidOther := (Users.Items[0] as TJSONObject).GetValue('id').Value;
end;

procedure TApiControllerTest.TestGetUserByID;
var
  User: TJSONObject;
begin
  User := FController.getUserByID(FGuidOther);
  if User = nil then
    Assert.Fail('Erro: O usuário não foi encontrado.');
end;

procedure TApiControllerTest.TestGetUserByIDEmpty;
var
  User: TJSONObject;
begin
  User := FController.getUserByID('');
  if User <> nil then
    Assert.Fail('Erro: O usuário não foi encontrado.');
end;

procedure TApiControllerTest.TestGetUserByLogin;
var
  User: TJSONObject;
begin
  try
    User := FController.getUserByLogin('admin');
    if User = nil then begin
      Assert.Fail('Erro: O usuário Admin não foi encontrado.');
      Exit();
    end;
    FGuidAdmin := User.GetValue<string>('id', '');
    if FGuidAdmin = EmptyStr then begin
      Assert.Fail('Erro: O usuário Admin não tem ID.');
      Exit();
    end;
  finally
    FreeAndNil(User);
  end;

end;

procedure TApiControllerTest.TestCreateUser;
var
  NewUser: TJSONObject;
  jsoResult: TJSONObject;
  nameUser: string;
begin
  NewUser := TJSONObject.Create;
  nameUser := 'testuser' + IntToStr(Random(1000));
  try
    NewUser.AddPair('name', 'Test User');
    NewUser.AddPair('username', nameUser);
    NewUser.AddPair('email', nameUser + '@test.com'); 
    NewUser.AddPair('password', 'password123');
    NewUser.AddPair('master', False);
    jsoResult  := FController.createUser(FGuidAdmin, NewUser);
    FGuidOther := jsoResult.GetValue<string>('id', '');
    if (FGuidOther=EmptyStr) then
      Assert.Fail('Novo usuário não foi criado com sucesso.');
  finally
    NewUser.Free;
  end;
end;

procedure TApiControllerTest.TestCreateUserInvalidEmail;
var
  NewUser: TJSONObject;
  nameUser: string;
begin
  NewUser := TJSONObject.Create;
  nameUser := 'testuser' + IntToStr(Random(1000));
  try
    NewUser.AddPair('name', 'Test User');
    NewUser.AddPair('username', nameUser);
    NewUser.AddPair('email', 'invalidemail'); 
    NewUser.AddPair('password', 'password123');
    NewUser.AddPair('master', true);
    try
      FController.createUser(FGuidAdmin, NewUser);
    except
      on e: Exception do begin
        Assert.AreEqual(trim(Format(ERROR_FIELD_INVALID_EMAIL, ['email'])), Trim(e.Message));
      end;
    end;
    
  finally
    NewUser.Free;
  end;
end;

procedure TApiControllerTest.TestUpdateUserByID;
var json: TJSONObject;
begin
  json:= TJSONObject.Create;
  try
    json.AddPair('name', 'NovoNome');

    FController.UpdateUserByID(FGuidAdmin, FGuidOther, json);
  finally
    FreeAndNil(json);
  end;
  try
    json :=  FController.GetUserByID(FGuidOther);
    Assert.AreEqual('NovoNome', json.GetValue('name').Value);
  finally
    if Assigned(json) then
      FreeAndNil(json);
  end;
end;

procedure TApiControllerTest.TestUpdateUserByIDInvalidEmail;
var json: TJSONObject;
begin
  json:= TJSONObject.Create;
  try
    json.AddPair('email', 'invalidemail');
    try
      FController.UpdateUserByID(FGuidAdmin, FGuidOther, json);
    except
      on e: Exception do begin
        Assert.AreEqual(trim(Format(ERROR_FIELD_INVALID_EMAIL, ['email'])), Trim(e.Message));
      end;
    end;
  finally
    FreeAndNil(json);
  end;
end;

procedure TApiControllerTest.TestDeleteUserByID;
var json: TJSONObject;
begin
json := nil;
  try
    json := FController.DeleteUserByID(FGuidAdmin, FGuidOther);
    if json.getValue<Integer>('rows', 0) <> 1 then
      Assert.Fail('Erro ao deletar usuário.');
  finally
    if Assigned(json) then
      FreeAndNil(json);
  end;
end;

procedure TApiControllerTest.TestGetAllWorkspace;
var
  Workspaces: TJSONArray;
begin
Workspaces := nil;
  try
    Workspaces := FController.getAllWorkspace;
    Assert.IsNotNull(Workspaces);
  finally
    if Assigned(Workspaces) then
      FreeAndNil(Workspaces);
  end;
end;

procedure TApiControllerTest.TestCreateWorkspace;
var
  WorkspaceJSON, ResultJSON: TJSONObject;
begin
  WorkspaceJSON := TJSONObject.Create;
  try
    WorkspaceJSON.AddPair('name', 'Grupo Tecidos');
    ResultJSON := FController.createWorkspace(FGuidAdmin, WorkspaceJSON);
    try
      Assert.IsNotNull(ResultJSON);
      FGuidWorkspace := ResultJSON.GetValue<string>('id', '');
      Assert.IsTrue(FGuidWorkspace <> '', 'ID do workspace não foi gerado.');
    finally
      ResultJSON.Free;
    end;
  finally
    WorkspaceJSON.Free;
  end;
end;

procedure TApiControllerTest.TestGetWorkspaceById;
var
  Workspace: TJSONObject;
begin
  Workspace := FController.getWorkspaceById(FGuidWorkspace);
  try
    Assert.IsNotNull(Workspace);
    Assert.AreEqual(FGuidWorkspace, Workspace.GetValue<string>('id'), 'ID do workspace não corresponde.');
  finally
    Workspace.Free;
  end;
end;

procedure TApiControllerTest.TestUpdateWorkspaceByID;
var
  WorkspaceJSON, ResultJSON: TJSONObject;
begin
  WorkspaceJSON := TJSONObject.Create;
  try
    WorkspaceJSON.AddPair('name', 'Grupo Tecidos Globo');
    ResultJSON := FController.updateWorkspaceByID(FGuidAdmin, FGuidWorkspace, WorkspaceJSON);
    try
      Assert.IsNotNull(ResultJSON);
      Assert.AreEqual(1, ResultJSON.GetValue<Integer>('rows'), 'Workspace não foi atualizado.');
    finally
      ResultJSON.Free;
    end;
  finally
    WorkspaceJSON.Free;
  end;
end;

procedure TApiControllerTest.TestDeleteWorkspace;
var
  ResultJSON: TJSONObject;
begin
  ResultJSON := FController.deleteWorkspace(FGuidAdmin, FGuidWorkspace);
  try
    Assert.IsNotNull(ResultJSON);
    Assert.AreEqual(1, ResultJSON.GetValue<Integer>('rows'), 'Workspace não foi deletado.');
  finally
    ResultJSON.Free;
  end;
end;

procedure TApiControllerTest.TestGetAllUsersByWorkspace;
var
  Users: TJSONArray;
begin
  Users := FController.getAllUsersByWorkspace(FGuidWorkspace);
  try
    Assert.IsNotNull(Users);
  finally
    Users.Free;
  end;
end;

procedure TApiControllerTest.TestCreateUserByWorkspace;
var
  UserJSON, ResultJSON: TJSONObject;
begin
  UserJSON := TJSONObject.Create;
  try
    UserJSON.AddPair('name', 'New User');
    UserJSON.AddPair('login', 'newuser');
    UserJSON.AddPair('email', 'newuser@example.com');
    UserJSON.AddPair('celular', '1234567890');
    ResultJSON := FController.createUserByWorkspace('', FGuidWorkspace, UserJSON);
    try
      FGuidUser := ResultJSON.GetValue<string>('id', '');
      Assert.IsNotNull(ResultJSON);
      Assert.IsTrue(FGuidUser <> '', 'ID do usuário não foi gerado.');
    finally
      ResultJSON.Free;
    end;
  finally
    UserJSON.Free;
  end;
end;

procedure TApiControllerTest.TestGetUserByWorkspace;
var
  User: TJSONObject;
begin
  User := FController.getUserByWorkspace(FGuidWorkspace, FGuidUser);
  try
    Assert.IsNotNull(User);
    Assert.AreEqual(FGuidUser, User.GetValue<string>('id'), 'ID do usuário não corresponde.');
  finally
    User.Free;
  end;
end;

procedure TApiControllerTest.TestUpdateUserByWorkspace;
var
  UserJSON, ResultJSON: TJSONObject;
begin
  UserJSON := TJSONObject.Create;
  try
    UserJSON.AddPair('name', 'Updated User');
    UserJSON.AddPair('email', 'updateduser@example.com');
    UserJSON.AddPair('celular', '0987654321');
    ResultJSON := FController.updateUserByWorkspace(FGuidAdmin, FGuidWorkspace, FGuidUser, UserJSON);
    try
      Assert.IsNotNull(ResultJSON);
      Assert.AreEqual(1, ResultJSON.GetValue<Integer>('rows'), 'Usuário não foi atualizado.');
    finally
      ResultJSON.Free;
    end;
  finally
    UserJSON.Free;
  end;
end;

procedure TApiControllerTest.TestDeleteUserByWorkspace;
var
  ResultJSON: TJSONObject;
begin
  ResultJSON := FController.deleteUserByWorkspace(FGuidAdmin, FGuidWorkspace, FGuidUser);
  try
    Assert.IsNotNull(ResultJSON);
    Assert.AreEqual(1, ResultJSON.GetValue<Integer>('rows'), 'Usuário não foi deletado.');
  finally
    ResultJSON.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TApiControllerTest);

end.
