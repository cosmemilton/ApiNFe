unit emissorfiscal.email.services;

interface

uses
  System.SysUtils, System.Classes,
  apinfe.dto.config.emailserver,
  emissorfiscal.email.services.class_;

type
  TEmailThreadWelcomeEmail = class(TThread)
  private
    FEmailSender: TEmailSender;
    FRecipient: string;
    FRecipientName: string;
    FCreatePasswordLink: string;
  protected
    procedure Execute; override;
  public
    constructor Create();
    property Recipient:string read FRecipient write FRecipient;
    property CreatePasswordLink : string read FCreatePasswordLink write FCreatePasswordLink;
    property RecipientName : string read FRecipientName write FRecipientName;
    destructor Destroy; override;
  end;

  TEmailThreadRecoverPassword = class(TThread)
  private
    FEmailSender: TEmailSender;
    FRecipient: string;
    FRecipientName: string;
    FRecoverLink: string;
  protected
    procedure Execute; override;
  public
    constructor Create();
    property Recipient:string read FRecipient write FRecipient;
    property RecipientName : string read FRecipientName write FRecipientName;
    property RecoverLink : string read FRecoverLink write FRecoverLink;
    destructor Destroy; override;
  end;



implementation

{ TEmailThread }

constructor TEmailThreadWelcomeEmail.Create();
begin
  inherited Create(True);
  FEmailSender    := TEmailSender.Create(TEmailServerDTO.getInstance);
end;

procedure TEmailThreadWelcomeEmail.Execute;
begin
  FEmailSender.SendEmailWelcome(FRecipient, FRecipientName, FCreatePasswordLink);
end;

destructor TEmailThreadWelcomeEmail.Destroy;
begin
  FreeAndNil(FEmailSender);
  inherited;
end;

{ TEmailThreadRecoverPassword }

constructor TEmailThreadRecoverPassword.Create;
begin
  inherited Create(True);
  FEmailSender    := TEmailSender.Create(TEmailServerDTO.getInstance);
end;

destructor TEmailThreadRecoverPassword.Destroy;
begin
  FreeAndNil(FEmailSender);
  inherited;
end;

procedure TEmailThreadRecoverPassword.Execute;
begin
  FEmailSender.SendEmailRecoverPassword(FRecipient, FRecipientName, FRecoverLink);
end;

end.
