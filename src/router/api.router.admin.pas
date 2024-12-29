unit api.router.admin;

interface

uses
  System.Classes,
  Horse,
  Horse.CORS,
  Horse.JWT,
  apinfe.constants,
  emissorfiscal.controller,
  emissorfiscal.gateway.tocontroller;

type
    TApiRouterAdmin = class
    protected
        class var m_instance: TApiRouterAdmin;
    public
        constructor Create;
        destructor Destroy; override;
        class function getInstance: TApiRouterAdmin;
        procedure Register;
      function AuthenticatedAdmin() : Horse.THorseCallback;
    end;

implementation

uses
  apinfe.dto.config.jwt, apinfe.claims;

{ TApiRouterAdmin }

function TApiRouterAdmin.AuthenticatedAdmin: Horse.THorseCallback;
begin
Result:=  HorseJWT(TJWTConfigDTO.getInstance.PrivateKey, THorseJWTConfig.New.SessionClass(TClaims) );
end;

constructor TApiRouterAdmin.Create;
begin
  //
end;

destructor TApiRouterAdmin.Destroy;
begin

  inherited;
end;

class function TApiRouterAdmin.getInstance: TApiRouterAdmin;
begin
  if not Assigned(m_instance) then
    m_instance:= TApiRouterAdmin.Create;
  Result:= m_instance;
end;

procedure TApiRouterAdmin.Register;
begin
  THorse
    .Group
      .Prefix(apiBaseAdmin)
      .Post('/login'      , TGatewayApiNFe.getInstance.LoginAdmin )
      {$REGION 'Admin Users'}
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Get('/user/all'      , TGatewayApiNFe.getInstance.getAllAdminUsers )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Post('/user'      , TGatewayApiNFe.getInstance.createUser )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Get('/user/:id'   , TGatewayApiNFe.getInstance.getUserById )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Put('/user/:id'   , TGatewayApiNFe.getInstance.updateUser )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Delete('/user/:id', TGatewayApiNFe.getInstance.deleteUser )
      {$ENDREGION}
      {$REGION 'Workspace'}
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Get('/workspace/all'   , TGatewayApiNFe.getInstance.getAllWorkspace )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Post('/workspace'      , TGatewayApiNFe.getInstance.createWorkspace )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Get('/workspace/:id'   , TGatewayApiNFe.getInstance.getWorkspaceById )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Put('/workspace/:id'   , TGatewayApiNFe.getInstance.updateWorkspace )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Delete('/workspace/:id', TGatewayApiNFe.getInstance.deleteWorkspace )
      {$ENDREGION}
      {$REGION 'workspace user'}
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Get('/workspace/:workspace/user/all'   , TGatewayApiNFe.getInstance.getAllUsersByWorkspace )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Post('/workspace/:workspace/user'      , TGatewayApiNFe.getInstance.createUserByWorkspace )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Get('/workspace/:workspace/user/:id'   , TGatewayApiNFe.getInstance.getUserByWorkspace )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Put('/workspace/:workspace/user/:id'   , TGatewayApiNFe.getInstance.updateUserByWorkspace )
      .Prefix(apiBaseAdmin)
      .AddCallback( AuthenticatedAdmin() )
      .Delete('/workspace/:workspace/user/:id', TGatewayApiNFe.getInstance.deleteUserByWorkspace )
      {$ENDREGION}
      {$REGION 'Secret'}
      {$ENDREGION}


end;

end.
