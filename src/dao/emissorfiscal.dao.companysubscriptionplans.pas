unit emissorfiscal.dao.companysubscriptionplans;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, FireDAC.Stan.Param,
  System.Generics.Collections, Data.DB,
  emissorfiscal.databaseconnection, emissorfiscal.dto.companysubscriptionplans;

type
  TCompanySubscriptionPlansDAO = class(TDatabaseConnection)
  public
    function GetById(const AId: string): TCompanySubscriptionPlanDTO;
    function GetAll: TList<TCompanySubscriptionPlanDTO>;
    function Create(const APlan: TCompanySubscriptionPlanDTO): Boolean;
    function UpdateById(const AId: string; const APlan: TCompanySubscriptionPlanDTO): Boolean;
    function DeleteById(const AId: string): Boolean;
  end;

implementation

function TCompanySubscriptionPlansDAO.GetById(const AId: string): TCompanySubscriptionPlanDTO;
var
  Query: TFDQuery;
  Plan: TCompanySubscriptionPlanDTO;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Text := 'SELECT * FROM company_subscription_plans WHERE id = :id';
    Query.ParamByName('id').AsString := AId;
    Query.Open;

    if not Query.IsEmpty then
    begin
      Plan := TCompanySubscriptionPlanDTO.Create;
      Plan.Id := Query.FieldByName('id').AsString;
      Plan.CompanyId := Query.FieldByName('company_id').AsString;
      Plan.SubscriptionPlanId := Query.FieldByName('subscription_plan_id').AsString;
      Plan.StartDate := Query.FieldByName('start_date').AsDateTime;
      Plan.EndDate := Query.FieldByName('end_date').AsDateTime;
      Plan.CreatedAt := Query.FieldByName('created_at').AsDateTime;
      Plan.UpdatedAt := Query.FieldByName('updated_at').AsDateTime;
      Result := Plan;
    end
    else
      Result := nil;
  finally
    Query.Free;
  end;
end;

function TCompanySubscriptionPlansDAO.GetAll: TList<TCompanySubscriptionPlanDTO>;
var
  Query: TFDQuery;
  Plans: TList<TCompanySubscriptionPlanDTO>;
  Plan: TCompanySubscriptionPlanDTO;
begin
  Plans := TList<TCompanySubscriptionPlanDTO>.Create;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Text := 'SELECT * FROM company_subscription_plans';
    Query.Open;

    while not Query.Eof do
    begin
      Plan := TCompanySubscriptionPlanDTO.Create;
      Plan.Id := Query.FieldByName('id').AsString;
      Plan.CompanyId := Query.FieldByName('company_id').AsString;
      Plan.SubscriptionPlanId := Query.FieldByName('subscription_plan_id').AsString;
      Plan.StartDate := Query.FieldByName('start_date').AsDateTime;
      Plan.EndDate := Query.FieldByName('end_date').AsDateTime;
      Plan.CreatedAt := Query.FieldByName('created_at').AsDateTime;
      Plan.UpdatedAt := Query.FieldByName('updated_at').AsDateTime;
      Plans.Add(Plan);
      Query.Next;
    end;
    Result := Plans;
  finally
    Query.Free;
  end;
end;

function TCompanySubscriptionPlansDAO.Create(const APlan: TCompanySubscriptionPlanDTO): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Text := 'INSERT INTO company_subscription_plans (id, company_id, subscription_plan_id, start_date, end_date, created_at, updated_at) ' +
                      'VALUES (:id, :company_id, :subscription_plan_id, :start_date, :end_date, :created_at, :updated_at)';
    Query.ParamByName('id').AsString := APlan.Id;
    Query.ParamByName('company_id').AsString := APlan.CompanyId;
    Query.ParamByName('subscription_plan_id').AsString := APlan.SubscriptionPlanId;
    Query.ParamByName('start_date').AsDateTime := APlan.StartDate;
    Query.ParamByName('end_date').AsDateTime := APlan.EndDate;
    Query.ParamByName('created_at').AsDateTime := APlan.CreatedAt;
    Query.ParamByName('updated_at').AsDateTime := APlan.UpdatedAt;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TCompanySubscriptionPlansDAO.UpdateById(const AId: string; const APlan: TCompanySubscriptionPlanDTO): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Text := 'UPDATE company_subscription_plans SET company_id = :company_id, subscription_plan_id = :subscription_plan_id, ' +
                      'start_date = :start_date, end_date = :end_date, created_at = :created_at, updated_at = :updated_at ' +
                      'WHERE id = :id';
    Query.ParamByName('id').AsString := AId;
    Query.ParamByName('company_id').AsString := APlan.CompanyId;
    Query.ParamByName('subscription_plan_id').AsString := APlan.SubscriptionPlanId;
    Query.ParamByName('start_date').AsDateTime := APlan.StartDate;
    Query.ParamByName('end_date').AsDateTime := APlan.EndDate;
    Query.ParamByName('created_at').AsDateTime := APlan.CreatedAt;
    Query.ParamByName('updated_at').AsDateTime := APlan.UpdatedAt;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TCompanySubscriptionPlansDAO.DeleteById(const AId: string): Boolean;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;
    Query.SQL.Text := 'DELETE FROM company_subscription_plans WHERE id = :id';
    Query.ParamByName('id').AsString := AId;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

end.
