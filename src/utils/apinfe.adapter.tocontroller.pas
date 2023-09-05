unit apinfe.adapter.tocontroller;

interface

uses
  System.SysUtils,
  System.Classes,
  Horse;

type
  TAdapterApiNFeController = class
    public
      procedure getAllClients(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getAllCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure getCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure updateCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure activeCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
      procedure suspendCompany(Req: THorseRequest; Res: THorseResponse; Next: TProc);
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

procedure TAdapterApiNFeController.deleteSecret(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.disableNFe(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getAllClients(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

end;

procedure TAdapterApiNFeController.getAllCompany(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin

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
