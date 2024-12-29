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
      procedure LoginAdmin(Req: THorseRequest; Res: THorseResponse; Next: TProc);
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
      //
      procedure getSecret(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure createdSecret(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure updateSecret(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure deleteSecret(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getDashboard(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getLogDate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getLogID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getJWT(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure cretedNFe(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure disableNFe(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure cancelNFe(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getXMLbyKey(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getPDFbyKey(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getAllIssuance(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      class function getInstance: TGatewayApiNFe;
      constructor Create(aController: TControllerApiNFe);
  end;

implementation

{ TAdapterApiNFeController }


procedure TGatewayApiNFe.cancelNFe(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

constructor TGatewayApiNFe.Create(aController: TControllerApiNFe);
begin
  FController := aController;
  FController.GenerateJWTFunction := @TClaims.GenerateJWT;
end;


procedure TGatewayApiNFe.createdSecret(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

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

procedure TGatewayApiNFe.cretedNFe(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;


procedure TGatewayApiNFe.deleteSecret(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

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

procedure TGatewayApiNFe.disableNFe(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

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

procedure TGatewayApiNFe.getAllIssuance(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

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

procedure TGatewayApiNFe.getDashboard(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TGatewayApiNFe.getJWT(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TGatewayApiNFe.getLogDate(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TGatewayApiNFe.getLogID(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TGatewayApiNFe.getPDFbyKey(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TGatewayApiNFe.getSecret(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

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

procedure TGatewayApiNFe.getXMLbyKey(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TGatewayApiNFe.LoginAdmin(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var jsoReq: TJSONValue;
var username, password, jwt: string;
begin
  jsoReq   := Req.Body<TJSONObject> as TJSONObject;
  username := jsoReq.GetValue<string>('username');
  password := jsoReq.GetValue<string>('password');
  jwt := Self.FController.ReturnJWTLoginAdmin(username,password);

  if (jwt='') then
    Res.SendBadRequest('Usuário ou senha inválidos')
  else
    Res.SendSuccess('jwt', jwt);
end;

procedure TGatewayApiNFe.updateSecret(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

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
