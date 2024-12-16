unit emissorfiscal.dto.companyaddresses;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TCompanyAddressDTO = class(TQueryBuild)
  private
    FId: string;
    FCompanyId: string;
    FStreet: string;
    FNumber: string;
    FComplement: string;
    FNeighborhood: string;
    FCity: string;
    FState: string;
    FCountry: string;
    FPostalCode: string;
    FCreatedBy: string;
    FUpdatedBy: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    property Id: string read FId write FId;
    property CompanyId: string read FCompanyId write FCompanyId;
    property Street: string read FStreet write FStreet;
    property Number: string read FNumber write FNumber;
    property Complement: string read FComplement write FComplement;
    property Neighborhood: string read FNeighborhood write FNeighborhood;
    property City: string read FCity write FCity;
    property State: string read FState write FState;
    property Country: string read FCountry write FCountry;
    property PostalCode: string read FPostalCode write FPostalCode;
    property CreatedBy: string read FCreatedBy write FCreatedBy;
    property UpdatedBy: string read FUpdatedBy write FUpdatedBy;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.