unit EmissorFiscal.QueryBuild;

interface

uses
  System.SysUtils, System.Rtti, System.TypInfo, System.Generics.Collections, System.Variants;

type
  TableNameAttribute = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(const AName: string);
    property Name: string read FName;
  end;

  FieldNameAttribute = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(const AName: string);
    property Name: string read FName;
  end;

  TQueryBuild = class
  public
    class function BuildInsert<T: class>: string;
    class function BuildUpdate<T: class>: string;
    class function BuildSelect<T: class>: string; overload;
    class function BuildSelect<T: class>(const Filters: TDictionary<string, Variant>): string; overload;
    class function BuildDelete<T: class>: string;
  end;

implementation

constructor TableNameAttribute.Create(const AName: string);
begin
  FName := AName;
end;

constructor FieldNameAttribute.Create(const AName: string);
begin
  FName := AName;
end;

class function TQueryBuild.BuildInsert<T>: string;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  Prop: TRttiProperty;
  Columns, Values, TableName: string;
  TableAttr: TableNameAttribute;
  FieldAttr: FieldNameAttribute;
begin
  Context := TRttiContext.Create;
  try
    RttiType := Context.GetType(TClass(T));
    TableAttr := RttiType.GetAttribute<TableNameAttribute> as TableNameAttribute;
    if Assigned(TableAttr) then
      TableName := TableAttr.Name
    else
      TableName := RttiType.Name;

    for Prop in RttiType.GetProperties do
    begin
      FieldAttr := Prop.GetAttribute<FieldNameAttribute> as FieldNameAttribute;
      if Assigned(FieldAttr) then
      begin
        if Columns <> '' then
        begin
          Columns := Columns + ', ';
          Values := Values + ', ';
        end;
        Columns := Columns + FieldAttr.Name;
        Values := Values + ':' + FieldAttr.Name;
      end;
    end;
    Result := Format('INSERT INTO %s (%s) VALUES (%s);', [TableName, Columns, Values]);
  finally
    Context.Free;
  end;
end;

class function TQueryBuild.BuildUpdate<T>: string;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  Prop: TRttiProperty;
  SetClause, TableName: string;
  TableAttr: TableNameAttribute;
  FieldAttr: FieldNameAttribute;
begin
  Context := TRttiContext.Create;
  try
    RttiType := Context.GetType(TClass(T));
    TableAttr := RttiType.GetAttribute<TableNameAttribute> as TableNameAttribute;
    if Assigned(TableAttr) then
      TableName := TableAttr.Name
    else
      TableName := RttiType.Name;

    for Prop in RttiType.GetProperties do
    begin
      FieldAttr := Prop.GetAttribute<FieldNameAttribute> as FieldNameAttribute;
      if Assigned(FieldAttr) then
      begin
        if SetClause <> '' then
          SetClause := SetClause + ', ';
        SetClause := SetClause + Format('%s = :%s', [FieldAttr.Name, FieldAttr.Name]);
      end;
    end;
    Result := Format('UPDATE %s SET %s WHERE Id = :Id;', [TableName, SetClause]);
  finally
    Context.Free;
  end;
end;

class function TQueryBuild.BuildSelect<T>: string;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  Prop: TRttiProperty;
  Columns, TableName: string;
  TableAttr: TableNameAttribute;
  FieldAttr: FieldNameAttribute;
begin
  Context := TRttiContext.Create;
  try
    RttiType := Context.GetType(TClass(T));
    TableAttr := RttiType.GetAttribute<TableNameAttribute> as TableNameAttribute;
    if Assigned(TableAttr) then
      TableName := TableAttr.Name
    else
      TableName := RttiType.Name;

    for Prop in RttiType.GetProperties do
    begin
      FieldAttr := Prop.GetAttribute<FieldNameAttribute> as FieldNameAttribute;
      if Assigned(FieldAttr) then
      begin
        if Columns <> '' then
          Columns := Columns + ', ';

        if (Prop.DataType.TypeKind=tkUString) then
          Columns := Columns +  FieldAttr.Name + '::text'
        else
          Columns := Columns + FieldAttr.Name;
      end;
    end;
    Result := Format('SELECT %s FROM %s;', [Columns, TableName]);
  finally
    Context.Free;
  end;
end;

class function TQueryBuild.BuildSelect<T>(const Filters: TDictionary<string, Variant>): string;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  Prop: TRttiProperty;
  Columns, WhereClause, TableName: string;
  TableAttr: TableNameAttribute;
  FieldAttr: FieldNameAttribute;
  Pair: TPair<string, Variant>;
begin
  Context := TRttiContext.Create;
  try
    RttiType := Context.GetType(TClass(T));
    TableAttr := RttiType.GetAttribute<TableNameAttribute> as TableNameAttribute;
    if Assigned(TableAttr) then
      TableName := TableAttr.Name
    else
      TableName := RttiType.Name;

    for Prop in RttiType.GetProperties do
    begin
      FieldAttr := Prop.GetAttribute<FieldNameAttribute> as FieldNameAttribute;
      if Assigned(FieldAttr) then
      begin
        if Columns <> '' then
          Columns := Columns + ', ';
        Columns := Columns + FieldAttr.Name;
      end;
    end;

    for Pair in Filters do
    begin
      if WhereClause <> '' then
        WhereClause := WhereClause + ' AND ';
      if (Pair.Key='password_hash') then
        WhereClause := WhereClause + Format('%s = crypt(''%s'' , ''md5'')', [Pair.Key, VarToStr(Pair.Value)])
      else
      if VarIsNumeric(Pair.Value) then
        WhereClause := WhereClause + Format('%s = %s', [Pair.Key, VarToStr(Pair.Value)])
      else
        WhereClause := WhereClause + Format('%s = ''%s''', [Pair.Key, VarToStr(Pair.Value)]);
    end;

    if WhereClause <> '' then
      Result := Format('SELECT %s FROM %s WHERE %s;', [Columns, TableName, WhereClause])
    else
      Result := Format('SELECT %s FROM %s;', [Columns, TableName]);
  finally
    Context.Free;
  end;
end;

class function TQueryBuild.BuildDelete<T>: string;
var
  Context: TRttiContext;
  RttiType: TRttiType;
  TableName: string;
  TableAttr: TableNameAttribute;
begin
  Context := TRttiContext.Create;
  try
    RttiType := Context.GetType(TClass(T));
    TableAttr := RttiType.GetAttribute<TableNameAttribute> as TableNameAttribute;
    if Assigned(TableAttr) then
      TableName := TableAttr.Name
    else
      TableName := RttiType.Name;

    Result := Format('DELETE FROM %s WHERE Id = :Id;', [TableName]);
  finally
    Context.Free;
  end;
end;

function VarIsNumeric(const V: Variant): Boolean;
begin
  Result := VarType(V) in [varSmallint, varInteger, varSingle, varDouble, varCurrency, varShortInt, varByte, varWord, varLongWord, varInt64, varUInt64];
end;

end.