unit emissorfiscal.dto.workspaces;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TWorkspaceDTO = class(TQueryBuild)
  private
    FId: string;
    FName: string;
    FMasterUserId: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    property Id: string read FId write FId;
    property Name: string read FName write FName;
    property MasterUserId: string read FMasterUserId write FMasterUserId;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.