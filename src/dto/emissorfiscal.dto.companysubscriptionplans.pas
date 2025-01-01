unit emissorfiscal.dto.companysubscriptionplans;

interface

uses
  System.SysUtils, System.Classes, emissorfiscal.querybuild;

type
  [TableName('company_subscription_plans')]
  TCompanySubscriptionPlanDTO = class(TQueryBuild)
  private
    [FieldName('id')]
    FId: string;
    [FieldName('company_id')]
    FCompanyId: string;
    [FieldName('subscription_plan_id')]
    FSubscriptionPlanId: string;
    [FieldName('start_date')]
    FStartDate: TDateTime;
    [FieldName('end_date')]
    FEndDate: TDateTime;
    [FieldName('created_at')]
    FCreatedAt: TDateTime;
    [FieldName('updated_at')]
    FUpdatedAt: TDateTime;
  public
    property Id: string read FId write FId;
    property CompanyId: string read FCompanyId write FCompanyId;
    property SubscriptionPlanId: string read FSubscriptionPlanId write FSubscriptionPlanId;
    property StartDate: TDateTime read FStartDate write FStartDate;
    property EndDate: TDateTime read FEndDate write FEndDate;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.