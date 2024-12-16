unit emissorfiscal.dto.subscriptionplan;

interface

uses
  System.Classes, System.SysUtils, emissorfiscal.querybuild;

type
  TSubscriptionPlanDTO = class(TQueryBuild)
  private
    FId: string;
    FName: string;
    FPrice: Currency;
    FNotesPerMonth: Integer;
    FExcessCost: Currency;
    FExcessNotes: Integer;
    FUnlisted: Boolean;
    FCreatedAt: TDateTime;
    FUpdatedAt: TDateTime;
  public
    property Id: string read FId write FId;
    property Name: string read FName write FName;
    property Price: Currency read FPrice write FPrice;
    property NotesPerMonth: Integer read FNotesPerMonth write FNotesPerMonth;
    property ExcessCost: Currency read FExcessCost write FExcessCost;
    property ExcessNotes: Integer read FExcessNotes write FExcessNotes;
    property Unlisted: Boolean read FUnlisted write FUnlisted;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.