unit emissorfiscal.routertocontroller;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Horse,
  emissorfiscal.controller,
  emissorfiscal.helper;

type
  TAdapterApiNFeController = class
    private
      FController: TControllerApiNFe;
    public
      procedure LoginAdmin(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getAllAdminUsers(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getAllClients(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getAllCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure updateCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure activeCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure suspendCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure deleteCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure createdCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure configIssuance(Req: THorseRequest; Res: THorseResponse; Next: TProc);
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
    published
      constructor Create(aController: TControllerApiNFe);
  end;

implementation


{ TAdapterApiNFeController }

procedure TAdapterApiNFeController.activeCompany(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.cancelNFe(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.configIssuance(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

constructor TAdapterApiNFeController.Create(aController: TControllerApiNFe);
begin
  FController := aController;
end;

procedure TAdapterApiNFeController.createdCompany(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.createdSecret(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.cretedNFe(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.deleteCompany(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.deleteSecret(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.disableNFe(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getAllAdminUsers(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  Self.FController.getAllAdminUsers();
  try
     Res.SendSuccess( Self.FController.getAllAdminUsers() );
  except
    on e: Exception do
      Res.SendBadRequest(e);
  end;
end;

procedure TAdapterApiNFeController.getAllClients(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getAllCompany(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FController.getAllClients;
end;

procedure TAdapterApiNFeController.getAllIssuance(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getCompany(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getDashboard(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getJWT(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getLogDate(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getLogID(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getPDFbyKey(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getSecret(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getXMLbyKey(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.LoginAdmin(Req: THorseRequest;
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

procedure TAdapterApiNFeController.suspendCompany(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.updateCompany(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.updateSecret(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

end.
