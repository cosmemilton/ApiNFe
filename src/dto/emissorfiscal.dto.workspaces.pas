unit emissorfiscal.dto.workspaces;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  [TableName('workspaces')]
  TWorkspaceDTO = class(TQueryBuild)
  private
    FId: string;
    FName: string;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    [FieldName('id')]
    property Id: string read FId write FId;
    [FieldName('name')]
    property Name: string read FName write FName;
    [FieldName('created_at')]
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    [FieldName('updated_at')]
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.