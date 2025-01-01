unit api.router.client;

interface

uses
  System.Classes,
  Horse,
  Horse.CORS,
  Horse.JWT,
  apinfe.constants,
  emissorfiscal.gateway.tocontroller;

type
    TApiRouterClient = class
    protected
        class var m_instance: TApiRouterClient;
    public
        constructor Create;
        destructor Destroy; override;
        class function getInstance: TApiRouterClient;
        procedure Register;
        function AuthenticatedClient(): Horse.THorseCallback;
    end;


implementation

uses
  apinfe.dto.config.jwt, apinfe.claims;

{ TApiRouterClient }

function TApiRouterClient.AuthenticatedClient: Horse.THorseCallback;
begin
Result:=  HorseJWT(TJWTConfigDTO.getInstance.PrivateKey, THorseJWTConfig.New.SessionClass(TClaims) );
end;

constructor TApiRouterClient.Create;
begin
  //
end;

destructor TApiRouterClient.Destroy;
begin
//
  inherited;
end;

class function TApiRouterClient.getInstance: TApiRouterClient;
begin
  if not Assigned(m_instance) then
    m_instance:= TApiRouterClient.Create;
  Result:= m_instance;
end;

procedure TApiRouterClient.Register;
begin
THorse
    .Group
      .Prefix(apiBaseClient)
      .Post('/register'   ,  TGatewayApiNFe.getInstance.clientRegister)
      .Post('/register/sendmail/welcome/:workspaceid/:userid', TGatewayApiNFe.getInstance.clientRegisterSendMailWelcome)
      .Post('/register/sendmail/recovery/:email', TGatewayApiNFe.getInstance.clientRegisterSendMailRecovery)
      .Post('/login'      ,  TGatewayApiNFe.getInstance.loginClientByUsername)
      .Post('/login/email',  TGatewayApiNFe.getInstance.loginClientByEmail);
end;

end.
