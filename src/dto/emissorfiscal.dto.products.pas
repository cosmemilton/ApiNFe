unit emissorfiscal.dto.products;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TProductDTO = class(TQueryBuild)
  private
    FId: string;
    FWorkspaceId: string;
    FName: string;
    FDescription: string;
    FPrice: Currency;
    FSku: string;
    FNcmId: string;
    FCestId: string;
    FCreatedBy: string;
    FUpdatedBy: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    property Id: string read FId write FId;
    property WorkspaceId: string read FWorkspaceId write FWorkspaceId;
    property Name: string read FName write FName;
    property Description: string read FDescription write FDescription;
    property Price: Currency read FPrice write FPrice;
    property Sku: string read FSku write FSku;
    property NcmId: string read FNcmId write FNcmId;
    property CestId: string read FCestId write FCestId;
    property CreatedBy: string read FCreatedBy write FCreatedBy;
    property UpdatedBy: string read FUpdatedBy write FUpdatedBy;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.