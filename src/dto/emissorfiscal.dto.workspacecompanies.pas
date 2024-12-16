unit emissorfiscal.dto.workspacecompanies;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TWorkspaceCompanyDTO = class(TQueryBuild)
  private
    FId: string;
    FWorkspaceId: string;
    FCnpj: string;
    FInscricaoEstadual: string;
    FInscricaoMunicipal: string;
    FName: string;
    FAlias: string;
    FCnae: string;
    FCreatedBy: string;
    FUpdatedBy: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    property Id: string read FId write FId;
    property WorkspaceId: string read FWorkspaceId write FWorkspaceId;
    property Cnpj: string read FCnpj write FCnpj;
    property InscricaoEstadual: string read FInscricaoEstadual write FInscricaoEstadual;
    property InscricaoMunicipal: string read FInscricaoMunicipal write FInscricaoMunicipal;
    property Name: string read FName write FName;
    property Alias: string read FAlias write FAlias;
    property Cnae: string read FCnae write FCnae;
    property CreatedBy: string read FCreatedBy write FCreatedBy;
    property UpdatedBy: string read FUpdatedBy write FUpdatedBy;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.