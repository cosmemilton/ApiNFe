unit emissorfiscal.dto.companycontacts;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TCompanyContactDTO = class(TQueryBuild)
  private
    FId: string;
    FCompanyId: string;
    FName: string;
    FEmail: string;
    FPhone: string;
    FMobile: string;
    FPosition: string;
    FCreatedBy: string;
    FUpdatedBy: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    property Id: string read FId write FId;
    property CompanyId: string read FCompanyId write FCompanyId;
    property Name: string read FName write FName;
    property Email: string read FEmail write FEmail;
    property Phone: string read FPhone write FPhone;
    property Mobile: string read FMobile write FMobile;
    property Position: string read FPosition write FPosition;
    property CreatedBy: string read FCreatedBy write FCreatedBy;
    property UpdatedBy: string read FUpdatedBy write FUpdatedBy;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.