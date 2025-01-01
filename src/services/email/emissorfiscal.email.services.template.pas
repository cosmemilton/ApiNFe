unit emissorfiscal.email.services.template;

interface

uses
  System.SysUtils, System.Classes;

type
  TEmailTemplates = class
  public
    class function WelcomeEmail(const ARecipientName, ACreatePasswordLink: string): string;
    class function RecoverPasswordEmail(const ARecipientName, ARecoveryLink: string): string;
  end;

implementation


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
    '<p>Olá <b>%s</b>,</p>' +
    '<p>Estamos felizes em tê-lo conosco.</p>' +
    '<p>Para confirmar seu email e criar uma nova senha, clique no link abaixo:</p>' +
    '<p><a href="%s">Criar nova senha</a></p>' +
    '</div>' +
    '<div class="footer">' +
    '<p>Atenciosamente,<br><b>Equipe Emissor Fiscal</b></p>' +
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
    '<p>Olá <b>%s</b>,</p>' +
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
