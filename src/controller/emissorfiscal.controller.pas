unit emissorfiscal.controller;

interface

uses
  System.Classes,
  System.JSON,
  System.SysUtils,
  emissorfiscal.controller.base,
  emissorfiscal.dao.adminuser,
  emissorFiscal.dto.adminuser,
  apinfe.claims;

type
  TControllerApiNFe = class(TControllerApiNFeBase)
    private
       //
    public
      function ReturnJWTLoginAdmin(const aUser, aPassword: string): string;
      function getAllAdminUsers(): TJSONArray;
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
    published
      constructor Create;
  end;

implementation

uses
  System.DateUtils;

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

procedure TControllerApiNFe.cretedNFe;
begin

end;

procedure TControllerApiNFe.deleteCompany;
begin

end;

procedure TControllerApiNFe.deleteSecret;
begin

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

procedure TControllerApiNFe.getXMLbyKey;
begin

end;

function TControllerApiNFe.ReturnJWTLoginAdmin(const aUser, aPassword: string): string;
begin
  Result:= '';

  if TAdminUserDAO.getInstance.ValidateUser(aUser, aPassword) then begin
    with TAdminUserDAO.getInstance.getUserByLogin(aUser, aPassword) do begin
      Result := TClaims.GenerateJWT(Id,Name,Email,Master);
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

end.
