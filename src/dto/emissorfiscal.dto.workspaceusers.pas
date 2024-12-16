unit emissorfiscal.dto.workspaceusers;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TWorkspaceUserDTO = class(TQueryBuild)
  private
    FId: string;
    FWorkspaceId: string;
    FUserId: string;
    FRole: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    property Id: string read FId write FId;
    property WorkspaceId: string read FWorkspaceId write FWorkspaceId;
    property UserId: string read FUserId write FUserId;
    property Role: string read FRole write FRole;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.