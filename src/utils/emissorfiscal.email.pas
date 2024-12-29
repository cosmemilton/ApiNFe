unit emissorfiscal.email;

interface

uses
  System.SysUtils, System.Classes, IdSMTP, IdMessage,
  IdSSLOpenSSL, IdExplicitTLSClientServerBase, IdAttachmentFile,
  apinfe.dto.config.emailserver;

type
  TEmailSender = class
  private
    FSMTP: TIdSMTP;
    FSSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    FEmailServer: TEmailServerDTO;
  public
    constructor Create(AEmailServer: TEmailServerDTO);
    destructor Destroy; override;
    procedure SendEmailWelcome(const ARecipient, ARecipientName, ACreatePasswordLink: string);
    procedure SendEmailRecoverPassword(const ARecipient, ARecipientName, ARecoveryLink: string);
  end;

  TEmailThread = class(TThread)
  private
    FEmailSender: TEmailSender;
    FRecipient: string;
    FSubject: string;
    FBody: string;
    FCreatePasswordLink: string;
    FAttachments: TArray<string>;
  protected
    procedure Execute; override;
  public
    constructor Create(AEmailSender: TEmailSender; const ARecipient, ASubject, ABody, ACreatePasswordLink: string; const AAttachments: TArray<string> = []);
  end;

  TEmailTemplates = class
  public
    class function WelcomeEmail(const ARecipientName, ACreatePasswordLink: string): string;
    class function RecoverPasswordEmail(const ARecipientName, ARecoveryLink: string): string;
  end;

implementation

{ TEmailSender }

constructor TEmailSender.Create(AEmailServer: TEmailServerDTO);
begin
  FEmailServer := AEmailServer;
  FSMTP := TIdSMTP.Create(nil);
  FSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FSMTP.IOHandler := FSSLHandler;
  FSMTP.Host := FEmailServer.Host;
  FSMTP.Port := FEmailServer.Port;
  FSMTP.Username := FEmailServer.Username;
  FSMTP.Password := FEmailServer.Password;
  FSMTP.UseTLS := utUseExplicitTLS;
  FSSLHandler.SSLOptions.Method := sslvTLSv1_2;
end;

destructor TEmailSender.Destroy;
begin
  FSMTP.Free;
  FSSLHandler.Free;
  inherited;
end;

procedure TEmailSender.SendEmailWelcome(const ARecipient, ARecipientName, ACreatePasswordLink: string);
var
  Msg: TIdMessage;
  Body: string;
begin
  Body := TEmailTemplates.WelcomeEmail(ARecipientName, ACreatePasswordLink);
  Msg := TIdMessage.Create(nil);
  try
    Msg.From.Address := FEmailServer.Username;
    Msg.Recipients.EmailAddresses := ARecipient;
    Msg.Subject := 'Bem-vindo ao Emissor Fiscal';
    Msg.ContentType := 'text/html';
    Msg.Body.Text := Body;

    FSMTP.Connect;
    try
      FSMTP.Send(Msg);
    finally
      FSMTP.Disconnect;
    end;
  finally
    Msg.Free;
  end;
end;

procedure TEmailSender.SendEmailRecoverPassword(const ARecipient, ARecipientName, ARecoveryLink: string);
var
  Msg: TIdMessage;
  Body: string;
begin
  Body := TEmailTemplates.RecoverPasswordEmail(ARecipientName, ARecoveryLink);
  Msg := TIdMessage.Create(nil);
  try
    Msg.From.Address := FEmailServer.Username;
    Msg.Recipients.EmailAddresses := ARecipient;
    Msg.Subject := 'Recuperação de Senha - Emissor Fiscal';
    Msg.ContentType := 'text/html';
    Msg.Body.Text := Body;

    FSMTP.Connect;
    try
      FSMTP.Send(Msg);
    finally
      FSMTP.Disconnect;
    end;
  finally
    Msg.Free;
  end;
end;

{ TEmailThread }

constructor TEmailThread.Create(AEmailSender: TEmailSender; const ARecipient, ASubject, ABody, ACreatePasswordLink: string; const AAttachments: TArray<string> = []);
begin
  inherited Create(True);
  FEmailSender := AEmailSender;
  FRecipient := ARecipient;
  FSubject := ASubject;
  FBody := ABody;
  FCreatePasswordLink := ACreatePasswordLink;
  FAttachments := AAttachments;
  FreeOnTerminate := True;
  Resume;
end;

procedure TEmailThread.Execute;
begin
  FEmailSender.SendEmailWelcome(FRecipient, FBody, FCreatePasswordLink);
end;

{ TEmailTemplates }

class function TEmailTemplates.WelcomeEmail(const ARecipientName, ACreatePasswordLink: string): string;
begin
  Result := Format(
    '<html>' +
    '<head>' +
    '<style>' +
    'body { font-family: Arial, sans-serif; }' +
    '.container { max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; }' +
    '.header { background-color: #4CAF50; color: white; padding: 10px 0; text-align: center; border-radius: 10px 10px 0 0; }' +
    '.content { padding: 20px; }' +
    '.footer { background-color: #f1f1f1; padding: 10px; text-align: center; border-radius: 0 0 10px 10px; }' +
    'a { color: #4CAF50; text-decoration: none; }' +
    '</style>' +
    '</head>' +
    '<body>' +
    '<div class="container">' +
    '<div class="header">' +
    '<h1>Bem-vindo ao Emissor Fiscal</h1>' +
    '</div>' +
    '<div class="content">' +
    '<p>Olá %s,</p>' +
    '<p>Estamos felizes em tê-lo conosco.</p>' +
    '<p>Para confirmar seu email e criar uma nova senha, clique no link abaixo:</p>' +
    '<p><a href="%s">Criar nova senha</a></p>' +
    '</div>' +
    '<div class="footer">' +
    '<p>Atenciosamente,<br>Equipe Emissor Fiscal</p>' +
    '</div>' +
    '</div>' +
    '</body>' +
    '</html>', [ARecipientName, ACreatePasswordLink]);
end;

class function TEmailTemplates.RecoverPasswordEmail(const ARecipientName, ARecoveryLink: string): string;
begin
  Result := Format(
    '<html>' +
    '<head>' +
    '<style>' +
    'body { font-family: Arial, sans-serif; }' +
    '.container { max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; }' +
    '.header { background-color: #f44336; color: white; padding: 10px 0; text-align: center; border-radius: 10px 10px 0 0; }' +
    '.content { padding: 20px; }' +
    '.footer { background-color: #f1f1f1; padding: 10px; text-align: center; border-radius: 0 0 10px 10px; }' +
    'a { color: #f44336; text-decoration: none; }' +
    '</style>' +
    '</head>' +
    '<body>' +
    '<div class="container">' +
    '<div class="header">' +
    '<h1>Recuperação de Senha</h1>' +
    '</div>' +
    '<div class="content">' +
    '<p>Olá %s,</p>' +
    '<p>Recebemos uma solicitação para redefinir sua senha.</p>' +
    '<p>Para redefinir sua senha, clique no link abaixo:</p>' +
    '<p><a href="%s">Redefinir senha</a></p>' +
    '<p>Se você não solicitou a redefinição de senha, por favor ignore este e-mail.</p>' +
    '</div>' +
    '<div class="footer">' +
    '<p>Atenciosamente,<br>Equipe Emissor Fiscal</p>' +
    '</div>' +
    '</div>' +
    '</body>' +
    '</html>', [ARecipientName, ARecoveryLink]);
end;

end.
