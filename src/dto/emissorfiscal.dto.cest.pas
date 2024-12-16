unit emissorfiscal.dto.cest;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TCestDTO = class(TQueryBuild)
  private
    FId: string;
    FCode: string;
    FDescription: string;
    FCreatedBy: string;
    FUpdatedBy: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    property Id: string read FId write FId;
    property Code: string read FCode write FCode;
    property Description: string read FDescription write FDescription;
    property CreatedBy: string read FCreatedBy write FCreatedBy;
    property UpdatedBy: string read FUpdatedBy write FUpdatedBy;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.