unit emissorfiscal.dto.companyinvoicesettings;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TCompanyInvoiceSettingsDTO = class(TQueryBuild)
  private
    FId: string;
    FCompanyId: string;
    FDocumentType: string;
    FEnvironment: string;
    FSeries: Integer;
    FInitialNumber: Integer;
    FFinalNumber: Integer;
    FNextNumber: Integer;
    FCertificate: TBytes;
    FCertificatePassword: string;
    FCertificateExpiration: TDateTime;
    FCsc: string;
    FIdCsc: string;
    FCreatedBy: string;
    FUpdatedBy: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    property Id: string read FId write FId;
    property CompanyId: string read FCompanyId write FCompanyId;
    property DocumentType: string read FDocumentType write FDocumentType;
    property Environment: string read FEnvironment write FEnvironment;
    property Series: Integer read FSeries write FSeries;
    property InitialNumber: Integer read FInitialNumber write FInitialNumber;
    property FinalNumber: Integer read FFinalNumber write FFinalNumber;
    property NextNumber: Integer read FNextNumber write FNextNumber;
    property Certificate: TBytes read FCertificate write FCertificate;
    property CertificatePassword: string read FCertificatePassword write FCertificatePassword;
    property CertificateExpiration: TDateTime read FCertificateExpiration write FCertificateExpiration;
    property Csc: string read FCsc write FCsc;
    property IdCsc: string read FIdCsc write FIdCsc;
    property CreatedBy: string read FCreatedBy write FCreatedBy;
    property UpdatedBy: string read FUpdatedBy write FUpdatedBy;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.