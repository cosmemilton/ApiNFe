unit emissorfiscal.dto.participants;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TRegistrationType = (rtAmbos, rtCliente, rtFornecedor);
  TPersonType = (ptFisica, ptJuridica);

  TParticipantDTO = class(TQueryBuild)
  private
    FId: string;
    FWorkspaceId: string;
    FRegistrationType: string;
    FPersonType: string;
    FName: string;
    FDocument: string;
    FEmail: string;
    FPhone: string;
    FMobile: string;
    FCreatedBy: string;
    FUpdatedBy: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
    function GetRegistrationType: TRegistrationType;
    procedure SetRegistrationType(const Value: TRegistrationType);
    function GetPersonType: TPersonType;
    procedure SetPersonType(const Value: TPersonType);
  public
    property Id: string read FId write FId;
    property WorkspaceId: string read FWorkspaceId write FWorkspaceId;
    property RegistrationType: TRegistrationType read GetRegistrationType write SetRegistrationType;
    property PersonType: TPersonType read GetPersonType write SetPersonType;
    property Name: string read FName write FName;
    property Document: string read FDocument write FDocument;
    property Email: string read FEmail write FEmail;
    property Phone: string read FPhone write FPhone;
    property Mobile: string read FMobile write FMobile;
    property CreatedBy: string read FCreatedBy write FCreatedBy;
    property UpdatedBy: string read FUpdatedBy write FUpdatedBy;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

function TParticipantDTO.GetRegistrationType: TRegistrationType;
begin
  if FRegistrationType = 'ambos' then
    Result := rtAmbos
  else if FRegistrationType = 'cliente' then
    Result := rtCliente
  else if FRegistrationType = 'fornecedor' then
    Result := rtFornecedor
  else
    raise Exception.Create('Invalid RegistrationType value');
end;

procedure TParticipantDTO.SetRegistrationType(const Value: TRegistrationType);
begin
  case Value of
    rtAmbos: FRegistrationType := 'ambos';
    rtCliente: FRegistrationType := 'cliente';
    rtFornecedor: FRegistrationType := 'fornecedor';
  else
    raise Exception.Create('Invalid RegistrationType value');
  end;
end;

function TParticipantDTO.GetPersonType: TPersonType;
begin
  if FPersonType = 'fisica' then
    Result := ptFisica
  else if FPersonType = 'juridica' then
    Result := ptJuridica
  else
    raise Exception.Create('Invalid PersonType value');
end;

procedure TParticipantDTO.SetPersonType(const Value: TPersonType);
begin
  case Value of
    ptFisica: FPersonType := 'fisica';
    ptJuridica: FPersonType := 'juridica';
  else
    raise Exception.Create('Invalid PersonType value');
  end;
end;

end.