unit emissorfiscal.dao.sendmail;

interface

uses
  System.SysUtils, System.Classes, 
  emissorfiscal.email.services,
  apinfe.dto.config.emailserver;

type
  TSendMailDAO = class
  private
    //
  protected
    class var m_instance: TSendMailDAO;
  public
    constructor Create(AEmailServer: TEmailServerDTO);
    destructor Destroy; override;
    procedure SendWelcomeEmail(const ARecipient, ARecipientName, ACreatePasswordLink: string);
    procedure SendRecoverPasswordEmail(const ARecipient, ARecipientName, ARecoveryLink: string);
    class function getInstance: TSendMailDAO;
  end;

implementation

constructor TSendMailDAO.Create(AEmailServer: TEmailServerDTO);
begin
  inherited Create;
end;

destructor TSendMailDAO.Destroy;
begin
  inherited Destroy;
end;

class function TSendMailDAO.getInstance: TSendMailDAO;
begin
  if not Assigned(m_instance) then
    m_instance := TSendMailDAO.Create(TEmailServerDTO.getInstance);
  Result := m_instance;
end;

procedure TSendMailDAO.SendWelcomeEmail(const ARecipient, ARecipientName, ACreatePasswordLink: string);
var EmailSender: TEmailThreadWelcomeEmail;
begin
  EmailSender := TEmailThreadWelcomeEmail.Create();
  EmailSender.Recipient := ARecipient;
  EmailSender.RecipientName := ARecipientName;
  EmailSender.CreatePasswordLink := ACreatePasswordLink;
  EmailSender.FreeOnTerminate:= True;
  EmailSender.Resume;
end;

procedure TSendMailDAO.SendRecoverPasswordEmail(const ARecipient, ARecipientName, ARecoveryLink: string);
var EmailSender: TEmailThreadRecoverPassword;
begin
  EmailSender := TEmailThreadRecoverPassword.Create();
  EmailSender.Recipient     := ARecipient;
  EmailSender.RecipientName := ARecipientName;
  EmailSender.RecoverLink   := ARecoveryLink;
  EmailSender.FreeOnTerminate:= True;
  EmailSender.Resume;
end;

end.
