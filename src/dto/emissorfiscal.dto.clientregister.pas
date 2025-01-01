unit emissorfiscal.dto.clientregister;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.dto.workspaces, emissorfiscal.dto.workspaceusers;

type
  TClientRegisterDTO = class
  private
    FWorkspace: TWorkspaceDTO;
    FWorkspaceUser: TWorkspaceUserDTO;
  public
    constructor Create;
    destructor Destroy; override;

    property Workspace: TWorkspaceDTO read FWorkspace write FWorkspace;
    property WorkspaceUser: TWorkspaceUserDTO read FWorkspaceUser write FWorkspaceUser;
  end;

implementation

constructor TClientRegisterDTO.Create;
begin
  inherited Create;
  FWorkspace := TWorkspaceDTO.Create;
  FWorkspaceUser := TWorkspaceUserDTO.Create;
end;

destructor TClientRegisterDTO.Destroy;
begin
  FreeAndNil(FWorkspace);
  FreeAndNil(FWorkspaceUser);
  inherited Destroy;
end;

end.
