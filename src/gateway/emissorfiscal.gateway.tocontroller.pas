unit emissorfiscal.gateway.tocontroller;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Horse,
  apinfe.claims,
  emissorfiscal.controller,
  emissorfiscal.helper.horse;

type
  TGatewayApiNFe = class
    private
      FController: TControllerApiNFe;
    protected
      class var m_instance: TGatewayApiNFe;
    public
    {$REGION 'Admin'}
      procedure loginAdminByUsername(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure loginAdminByEmail(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure loginAdminByUsernameOrEmail(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getAllAdminUsers(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure createUser(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getUserById(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure updateUser(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure deleteUser(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      //
      procedure getAllWorkspace(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure createWorkspace(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getWorkspaceById(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure updateWorkspace(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure deleteWorkspace(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      //
      procedure getAllUsersByWorkspace(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure createUserByWorkspace(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getUserByWorkspace(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure updateUserByWorkspace(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure deleteUserByWorkspace(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    {$ENDREGION}
    {$REGION 'Client'}
      procedure clientRegister(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure clientRegisterSendMailWelcome(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure clientRegisterSendMailRecovery(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure loginClientByUsername(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure loginClientByEmail(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    {$ENDREGION}
      class function getInstance: TGatewayApiNFe;
      constructor Create(aController: TControllerApiNFe);
  end;

implementation

uses
  apinfe.dto.config.jwt;

{ TAdapterApiNFeController }

constructor TGatewayApiNFe.Create(aController: TControllerApiNFe);
begin
  FController := aController;
end;

procedure TGatewayApiNFe.createUser(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var userIdLogin: string;
begin
  try
    userIdLogin := TClaims(Req.Session<TClaims>).Id;
    Res.SendSuccess(
      Self.FController.createUser(
           userIdLogin
         , Req.Body<TJSONObject> as TJSONObject
      ) 
    );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;

end;

procedure TGatewayApiNFe.createUserByWorkspace(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var workspaceId: string;
var userIdLogin: string;
begin
  workspaceId := req.Params['workspace'];
  userIdLogin :=  TClaims(Req.Session<TClaims>).Id;
  try
    Res.SendSuccess( Self.FController.createUserByWorkspace(userIdLogin, workspaceId, Req.Body<TJSONObject> ) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;
end;

procedure TGatewayApiNFe.createWorkspace(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  try 
    Res.SendSuccess(
      Self.FController.createWorkspace(
         TClaims(Req.Session<TClaims>).Id,
         Req.Body<TJSONObject> as TJSONObject
      ) 
    );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;
end;

procedure TGatewayApiNFe.deleteUser(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  try
    Res.SendSuccess(
      Self.FController.deleteUserByID(
        TClaims(Req.Session<TClaims>).Id
        , Req.Params['id']
      )
    );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;

end;

procedure TGatewayApiNFe.deleteUserByWorkspace(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var workspaceId: string;
var userIdLogin: string;
var userId: string;
begin
  workspaceId := req.Params['workspace'];
  userId      := req.Params['id'];
  userIdLogin :=  TClaims(Req.Session<TClaims>).Id; 
  try
    Res.SendSuccess( Self.FController.deleteUserByWorkspace(userIdLogin, workspaceId, userId) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;

end;

procedure TGatewayApiNFe.deleteWorkspace(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  try
    Res.SendSuccess(
      Self.FController.deleteWorkspace(
        TClaims(Req.Session<TClaims>).Id
        , Req.Params['id']
      )
    );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;

end;

procedure TGatewayApiNFe.getAllAdminUsers(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  try
     Res.SendSuccess( Self.FController.getAllAdminUsers() );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;
end;

procedure TGatewayApiNFe.getAllUsersByWorkspace(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var workspaceId: string;
begin
  workspaceId := req.Params['workspace'];
  try
    Res.SendSuccess( Self.FController.getAllUsersByWorkspace(workspaceId) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;
end;

procedure TGatewayApiNFe.getAllWorkspace(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  try
     Res.SendSuccess( Self.FController.getAllWorkspace() );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;
end;

procedure TGatewayApiNFe.getUserById(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var userId: string;
begin
  userId := req.Params['id'];
  try
    Res.SendSuccess( Self.FController.getUserByID(userId) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;

end;

procedure TGatewayApiNFe.getUserByWorkspace(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var workspaceId: string;
begin
  workspaceId := req.Params['workspace'];
  try
    Res.SendSuccess( Self.FController.getUserByWorkspace(workspaceId, req.Params['id']) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;  

end;

procedure TGatewayApiNFe.getWorkspaceById(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var workspaceId: string;
begin
  workspaceId := req.Params['id'];
  try
    Res.SendSuccess( Self.FController.getWorkspaceByID(workspaceId) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;
end;

procedure TGatewayApiNFe.loginAdminByEmail(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var jsoReq: TJSONValue;
var email, password, jwt: string;
begin
  jsoReq   := Req.Body<TJSONObject> as TJSONObject;
  email := jsoReq.GetValue<string>('email');
  password := jsoReq.GetValue<string>('password');
  jwt := Self.FController.ReturnJWTLoginAdminByEmail(email,password);

  if (jwt='') then
    Res.SendBadRequest('Usuário ou senha inválidos')
  else
    Res.SendSuccess('jwt', jwt);
end;
procedure TGatewayApiNFe.loginAdminByUsername(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var jsoReq: TJSONValue;
var username, password, jwt: string;
begin
  jsoReq   := Req.Body<TJSONObject> as TJSONObject;
  username := jsoReq.GetValue<string>('username');
  password := jsoReq.GetValue<string>('password');
  jwt := Self.FController.ReturnJWTLoginAdminByUsername(username,password);

  if (jwt='') then
    Res.SendBadRequest('Usuário ou senha inválidos')
  else
    Res.SendSuccess('jwt', jwt);
end;

procedure TGatewayApiNFe.loginAdminByUsernameOrEmail(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var jsoReq: TJSONValue;
var jsoDataResp, jsoUser: TJSONObject;
var usernameOrEmail, password, jwt: string;

begin
  jsoDataResp  := nil;
  jsoUser      := nil;
  jsoReq   := Req.Body<TJSONObject> as TJSONObject;
  usernameOrEmail  := jsoReq.GetValue<string>('id');
  password := jsoReq.GetValue<string>('password');
  jwt := Self.FController.ReturnJWTLoginAdminByUsername(usernameOrEmail,password);

  if (jwt='') then begin
    jwt     := Self.FController.ReturnJWTLoginAdminByEmail(usernameOrEmail,password);
    if not (jwt=EmptyStr) then
      jsoUser := Self.FController.getUserByEmail(usernameOrEmail);
  end
  else
    jsoUser := Self.FController.getUserByLogin(usernameOrEmail);

   if ((jwt=EmptyStr) or not Assigned(jsoUser)) then begin
    Res.SendBadRequest('Usuário ou senha inválidos');
    exit;
  end;

  jsoDataResp:= TJSONObject.Create;
  jsoDataResp.AddPair('id', jsoUser.GetValue<string>('id'));
  jsoDataResp.AddPair('name', jsoUser.GetValue<string>('name'));
  jsoDataResp.AddPair('username', jsoUser.GetValue<string>('username'));
  jsoDataResp.AddPair('email', jsoUser.GetValue<string>('email'));
  jsoDataResp.AddPair('jwt', jwt);
  jsoDataResp.AddPair('surname', '');
  jsoDataResp.AddPair('position', '');
  jsoDataResp.AddPair('src', '');
  jsoDataResp.AddPair('srcSet', '');
  jsoDataResp.AddPair('isOnline', True);
  jsoDataResp.AddPair('color', 'primary');
  jsoDataResp.AddPair('fullImage', '');
  jsoDataResp.AddPair('services', TJSONArray.Create);
  jsoDataResp.AddPair('password', '');
  jsoDataResp.AddPair('isReply', false);
  Res.SendSuccess(jsoDataResp);
end;

procedure TGatewayApiNFe.loginClientByEmail(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TGatewayApiNFe.loginClientByUsername(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TGatewayApiNFe.clientRegister(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var json: TJSONObject;  
begin
  try
    json := Req.Body<TJSONObject> as TJSONObject;
    Res.SendSuccess( Self.FController.clientRegister(json) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;
end;

procedure TGatewayApiNFe.clientRegisterSendMailRecovery(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var email: string;
begin
  email := req.Params['email'];
  try
    Res.SendSuccess( Self.FController.clientRegisterSendMailRecovery(email) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;
end;

procedure TGatewayApiNFe.clientRegisterSendMailWelcome(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var workspaceId, userId: string;
begin
  workspaceId := req.Params['workspaceid'];
  userId := req.Params['userid'];
  try
    Res.SendSuccess( Self.FController.clientRegisterSendMailWelcome(workspaceId, userId) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;
end;

procedure TGatewayApiNFe.updateUser(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var userId: string;
var userIdLogin: string;
begin
  userId := req.Params['id'];
  userIdLogin :=  TClaims(Req.Session<TClaims>).Id;
  try
    Res.SendSuccess( Self.FController.updateUserByID(userIdLogin, userId, Req.Body<TJSONObject> ) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;

end;

procedure TGatewayApiNFe.updateUserByWorkspace(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var workspaceId: string;
var userIdLogin: string;
var userIdUpdate: string;
begin
  workspaceId := req.Params['workspace'];
  userIdUpdate := req.Params['id'];
  userIdLogin :=  TClaims(Req.Session<TClaims>).Id;
  try
    Res.SendSuccess( Self.FController.updateUserByWorkspace(userIdLogin, workspaceId, userIdUpdate, Req.Body<TJSONObject> ) );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;

end;

procedure TGatewayApiNFe.updateWorkspace(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var workspaceId: string;
var userIdLogin: string;
begin
  workspaceId := req.Params['id'];
  userIdLogin :=  TClaims(Req.Session<TClaims>).Id;
  try
    Res.SendSuccess( 
      Self.FController.updateWorkspaceByID(
              userIdLogin
            , workspaceId
            , Req.Body<TJSONObject> 
        ) 
    );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;

end;

class function TGatewayApiNFe.getInstance: TGatewayApiNFe;
begin
  if not Assigned(m_instance) then
    m_instance:= TGatewayApiNFe.Create(TControllerApiNFe.Create);

  Result:= m_instance;
end;

end.
