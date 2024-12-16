unit emissorfiscal.dto.cfop;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TCFOPType = (Incoming, Outgoing);

  TCFOPDTO = class(TQueryBuild)
  private
    FId: string;
    FCode: string;
    FDescription: string;
    FTypeMov: string;
    FActive: Boolean;
    FCreatedBy: string;
    FUpdatedBy: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
    function GetTypeMov: TCFOPType;
    procedure SetTypeMov(const Value: TCFOPType);
  public
    property Id: string read FId write FId;
    property Code: string read FCode write FCode;
    property Description: string read FDescription write FDescription;
    property TypeMov: TCFOPType read GetTypeMov write SetTypeMov;
    property Active: Boolean read FActive write FActive;
    property CreatedBy: string read FCreatedBy write FCreatedBy;
    property UpdatedBy: string read FUpdatedBy write FUpdatedBy;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

function TCFOPDTO.GetTypeMov: TCFOPType;
begin
  if FTypeMov = 'entrada' then
    Result := Incoming
  else if FTypeMov = 'saida' then
    Result := Outgoing
  else
    raise Exception.Create('Invalid TypeMov value');
end;

procedure TCFOPDTO.SetTypeMov(const Value: TCFOPType);
begin
  case Value of
    Incoming: FTypeMov := 'entrada';
    Outgoing: FTypeMov := 'saida';
  else
    raise Exception.Create('Invalid TypeMov value');
  end;
end;

end.