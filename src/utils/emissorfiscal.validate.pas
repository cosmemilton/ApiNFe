unit emissorfiscal.validate;

interface

uses
  System.JSON, System.SysUtils, System.Classes, System.Generics.Collections,
  System.RegularExpressions, System.Rtti, System.TypInfo,
  apinfe.constants.errors;

type
  TFieldType = (ftaNA, ftNumber, ftBoolean);
  TFieldTypeS = (ftbNA, ftString);

  TFieldValidation = record
    FieldName: string;
    FieldType: TFieldType;
    FieldTypeS: TFieldTypeS;
    IsEmail: Boolean;
  end;

  TCustomValidator = class
  private
    var FRequiredFields: TList<TFieldValidation>;
  protected
    class var FJSONValidator: TCustomValidator;
  public
    constructor Create;
    destructor Destroy; override;
    class function Add(const FieldName: string; FieldType: TFieldTypeS; IsEmail: Boolean): TCustomValidator; overload;
    class function Add(const FieldName: string; FieldType: TFieldType): TCustomValidator; overload;
    function Validate(const JSON: TJSONObject): string; overload;
    function Validate(const aValue: TObject): string; overload;
  end;

implementation

class function TCustomValidator.Add(const FieldName: string; FieldType: TFieldType): TCustomValidator;
var
  FieldValidation: TFieldValidation;
begin
  if not Assigned(FJSONValidator) then
    FJSONValidator:= TCustomValidator.Create;

  FieldValidation.FieldName := FieldName;
  FieldValidation.FieldType := FieldType;
  FieldValidation.FieldTypeS:= ftbNA;
  FieldValidation.IsEmail := False;
  FJSONValidator.FRequiredFields.Add(FieldValidation);
  Result := FJSONValidator;
end;

class function TCustomValidator.Add(const FieldName: string; FieldType: TFieldTypeS; IsEmail: Boolean): TCustomValidator;
var
  FieldValidation: TFieldValidation;
begin
  if not Assigned(FJSONValidator) then
    FJSONValidator:= TCustomValidator.Create;

  FieldValidation.FieldName := FieldName;
  FieldValidation.FieldType := ftaNA;
  FieldValidation.FieldTypeS:= FieldType;
  FieldValidation.IsEmail   := IsEmail;
  FJSONValidator.FRequiredFields.Add(FieldValidation);
  Result := FJSONValidator;
end;

constructor TCustomValidator.Create;
begin
  FRequiredFields := TList<TFieldValidation>.Create;
end;

destructor TCustomValidator.Destroy;
begin
  FreeAndNil(FRequiredFields);
  inherited;
end;

function TCustomValidator.Validate(const JSON: TJSONObject): string;
var
  Errors: TStringList;
  Field: TFieldValidation;
  Value: TJSONValue;
  FieldValue: string;
  BoolValue: Boolean;
  FloatValue: Double;
begin
  Errors := TStringList.Create;
  try
    for Field in FRequiredFields do
    begin
      if not JSON.TryGetValue(Field.FieldName, Value) then
      begin
        Errors.Add(Format(ERROR_FIELD_REQUIRED, [Field.FieldName]));
        Continue;
      end;

      FieldValue := Value.Value;
      if (Field.FieldTypeS=ftString) then begin
        if Field.IsEmail and not TRegEx.IsMatch(FieldValue, '^[\w\.-]+@[\w\.-]+\.\w+$') then
          Errors.Add(Format(ERROR_FIELD_INVALID_EMAIL, [Field.FieldName]));
      end
      else
        case Field.FieldType of
          ftNumber:
            begin
              if not TryStrToFloat(FieldValue, FloatValue) then
                Errors.Add(Format(ERROR_FIELD_INVALID_NUMBER, [Field.FieldName]));
            end;
          ftBoolean:
            begin

              if not TryStrToBool(FieldValue, BoolValue) then
                Errors.Add(Format(ERROR_FIELD_INVALID_BOOLEAN, [Field.FieldName]));
            end;
        end;
    end;
    Result := Errors.Text;
  finally
    FreeAndNil(Errors);
    FreeAndNil(FJSONValidator);
  end;
end;

function TCustomValidator.Validate(const aValue: TObject): string;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  RttiProp: TRttiProperty;
  Field: TFieldValidation;
  Errors: TStringList;
  PropValue: TValue;
  FieldValue: string;
  FloatValue: Double;
  BoolValue: Boolean;
begin
  Errors := TStringList.Create;
  try
    Context := TRttiContext.Create;
    try
      RttiType := Context.GetType(aValue.ClassType);
      for Field in FRequiredFields do
      begin
        RttiProp := RttiType.GetProperty(Field.FieldName);
        if Assigned(RttiProp) then
        begin
          PropValue := RttiProp.GetValue(aValue);
          if PropValue.IsEmpty then
          begin
            Errors.Add(Format(ERROR_FIELD_REQUIRED, [Field.FieldName]));
            Continue;
          end;

          FieldValue := PropValue.ToString;

          if (Field.FieldTypeS=ftString) then begin
            if Field.IsEmail and not TRegEx.IsMatch(FieldValue, '^[\w\.-]+@[\w\.-]+\.\w+$') then
              Errors.Add(Format(ERROR_FIELD_INVALID_EMAIL, [Field.FieldName]));
          end
          else
            case Field.FieldType of
              ftNumber:
                begin
                  if not TryStrToFloat(FieldValue, FloatValue) then
                    Errors.Add(Format(ERROR_FIELD_INVALID_NUMBER, [Field.FieldName]));
                end;
              ftBoolean:
                begin
                  if not TryStrToBool(FieldValue, BoolValue) then
                    Errors.Add(Format(ERROR_FIELD_INVALID_BOOLEAN, [Field.FieldName]));
                end;
            end;
        end
        else
        begin
          Errors.Add(Format(ERROR_FIELD_NOT_FOUND, [Field.FieldName]));
        end;
      end;
    finally
      Context.Free;
    end;
    Result := Errors.Text;
  finally
    FreeAndNil(Errors);
    FreeAndNil(FJSONValidator);
  end;
end;



end.

