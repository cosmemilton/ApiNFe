unit emissorfiscal.email.services.class_;

interface

uses
  System.SysUtils, System.Classes, IdSMTP, IdMessage,
  IdSSLOpenSSL, IdExplicitTLSClientServerBase,
  IdAttachmentFile, IdText,
  apinfe.dto.config.emailserver,
  emissorfiscal.email.services.template;

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

implementation

{ TEmailSender }

constructor TEmailSender.Create(AEmailServer: TEmailServerDTO);
begin
  inherited Create;  
  FEmailServer := AEmailServer;

  FSMTP := TIdSMTP.Create(nil);
  FSSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  FSMTP.IOHandler := FSSLHandler;
  FSMTP.Host := FEmailServer.Host;
  FSMTP.Username := FEmailServer.Username;
  FSMTP.Password := FEmailServer.Password;
  if FEmailServer.UseTLS then
    FSMTP.UseTLS := utUseImplicitTLS
  else
    FSMTP.UseTLS := utNoTLSSupport;

  FSMTP.AuthType := satDefault;

  FSMTP.ConnectTimeout := 10000;
  FSMTP.ReadTimeout := 10000;

  FSSLHandler.SSLOptions.Method := sslvTLSv1_2;
  FSSLHandler.SSLOptions.Mode   := sslmClient;
  FSMTP.Port := FEmailServer.Port;
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
  Body: TIdText;
begin
  Msg := TIdMessage.Create(nil);
  try
    Msg.From.Address := FEmailServer.Username;
    Msg.Recipients.EmailAddresses := ARecipient;
    Msg.Subject := 'Bem-vindo ao Emissor Fiscal';
    Msg.ContentType := 'text/html; charset=UTF-8';
    Msg.CharSet     := 'UTF-8';
    Body := TIdText.Create(Msg.MessageParts, nil);
    Body.ContentType := 'text/html; charset=UTF-8';
    Body.Body.Text   :=  TEmailTemplates.WelcomeEmail(ARecipientName, ACreatePasswordLink);

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
  Body: TIdText;
begin
  Msg := TIdMessage.Create(nil);
  try
    Msg.From.Address := FEmailServer.Username;
    Msg.Recipients.EmailAddresses := ARecipient;
    Msg.Subject := 'Recuperação de Senha - Emissor Fiscal';
    Msg.ContentType := 'text/html; charset=UTF-8';
    Msg.CharSet     := 'UTF-8';
    Body := TIdText.Create(Msg.MessageParts, nil);
    Body.ContentType := 'text/html; charset=UTF-8';
    Body.Body.Text := TEmailTemplates.RecoverPasswordEmail(ARecipientName, ARecoveryLink);
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



end.
