unit emissorfiscal.helper.strings;

interface

uses
  System.JSON, System.SysUtils, System.RegularExpressions;

type
  TCustomStringHelper = record helper for string
  private type
    TSplitKind = (StringSeparatorsNoQuoted, StringSeparatorsQuoted, StringSeparatorNoQuoted,
      CharSeparatorsNoQuoted, CharSeparatorsQuoted, CharSeparatorNoQuoted);
  private
    function GetChars(Index: Integer): Char; inline;
    function GetLength: Integer; inline;
    class function CharInArray(const C: Char; const InArray: array of Char): Boolean; static;
    function InternalSplit(SplitType: TSplitKind; const SeparatorC: array of Char; const SeparatorS: array of string;
      QuoteStart, QuoteEnd: Char; Count: Integer; Options: TStringSplitOptions): TArray<string>;
    function IndexOfAny(const Values: array of string; var Index: Integer; StartIndex: Integer): Integer; overload;
    function IndexOfAnyUnquoted(const Values: array of string; StartQuote, EndQuote: Char; var Index: Integer; StartIndex: Integer): Integer; overload;
    function IndexOfQuoted(const Value: string; StartQuote, EndQuote: Char; StartIndex: Integer): Integer; overload;
    class function InternalCompare(const StrA: string; IndexA: Integer; const StrB: string;
      IndexB, LengthA, LengthB: Integer; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer;overload; static;
    class function InternalCompare(const StrA: string; IndexA: Integer; const StrB: string;
      IndexB, LengthA, LengthB: Integer; Options: TCompareOptions; LocaleID: TLocaleID): Integer; overload; static;

    class function InternalMapOptionsToFlags(AOptions: TCompareOptions): LongWord; static;
  public
    const Empty = '';
    // Methods
    class function Create(C: Char; Count: Integer): string; overload; inline; static;
    class function Create(const Value: array of Char; StartIndex: Integer; Length: Integer): string; overload; static;
    class function Create(const Value: array of Char): string; overload; static;
    class function Compare(const StrA: string; const StrB: string): Integer; overload; static; inline;
    class function Compare(const StrA: string; const StrB: string; LocaleID: TLocaleID): Integer; overload; static; inline;
    class function Compare(const StrA: string; const StrB: string; IgnoreCase: Boolean): Integer; overload; static; inline; //deprecated 'Use same with TCompareOptions';
    class function Compare(const StrA: string; const StrB: string; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer; overload; static; inline; //deprecated 'Use same with TCompareOptions';
    class function Compare(const StrA: string; const StrB: string; Options: TCompareOptions): Integer; overload; static; inline;
    class function Compare(const StrA: string; const StrB: string; Options: TCompareOptions; LocaleID: TLocaleID): Integer; overload; static; inline;
    class function Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer): Integer; overload; static; inline;
    class function Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; LocaleID: TLocaleID): Integer; overload; static; inline;
    class function Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; IgnoreCase: Boolean): Integer; overload; static; inline; //deprecated 'Use same with TCompareOptions';
    class function Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer; overload; static; inline; //deprecated 'Use same with TCompareOptions';
    class function Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; Options: TCompareOptions): Integer; overload; static; inline;
    class function Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; Options: TCompareOptions; LocaleID: TLocaleID): Integer; overload; static; inline;
    class function CompareOrdinal(const StrA: string; const StrB: string): Integer; overload; static;
    class function CompareOrdinal(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer): Integer; overload; static;
    class function CompareText(const StrA: string; const StrB: string): Integer; static; inline;
    class function Parse(const Value: Integer): string; overload; static; inline;
    class function Parse(const Value: Int64): string; overload; static; inline;
    class function Parse(const Value: Boolean): string; overload; static; inline;
    class function Parse(const Value: Extended): string; overload; static;inline;
    class function ToBoolean(const S: string): Boolean; overload; static; inline;
    class function ToInteger(const S: string): Integer; overload; static; inline;
    /// <summary>Class function to Convert a string to an Int64 value</summary>
    class function ToInt64(const S: string): Int64; overload; static; inline;
    class function ToSingle(const S: string): Single; overload; static; inline;
    class function ToDouble(const S: string): Double; overload; static; inline;
    class function ToExtended(const S: string): Extended; overload; static; inline;
    class function LowerCase(const S: string): string; overload; static; inline;
    class function LowerCase(const S: string; LocaleOptions: TLocaleOptions): string; overload; static; inline;
    class function UpperCase(const S: string): string; overload; static; inline;
    class function UpperCase(const S: string; LocaleOptions: TLocaleOptions): string; overload; static; inline;
    function CompareTo(const strB: string): Integer;
    function Contains(const Value: string): Boolean;
    class function Copy(const Str: string): string; inline; static;
    procedure CopyTo(SourceIndex: Integer; var destination: array of Char; DestinationIndex: Integer; Count: Integer);
    function CountChar(const C: Char): Integer;
    function DeQuotedString: string; overload;
    function DeQuotedString(const QuoteChar: Char): string; overload;
    class function EndsText(const ASubText, AText: string): Boolean; static;
    function EndsWith(const Value: string): Boolean; overload; inline;
    function EndsWith(const Value: string; IgnoreCase: Boolean): Boolean; overload;
    function Equals(const Value: string): Boolean; overload;
    class function Equals(const a: string; const b: string): Boolean; overload; static;
    class function Format(const Format: string; const args: array of const): string; overload; static;
    function GetHashCode: Integer;
    function IndexOf(Value: Char): Integer; overload;
    function IndexOf(const Value: string): Integer; overload; inline;
    function IndexOf(Value: Char; StartIndex: Integer): Integer; overload;
    function IndexOf(const Value: string; StartIndex: Integer): Integer; overload;
    function IndexOf(Value: Char; StartIndex: Integer; Count: Integer): Integer; overload;
    function IndexOf(const Value: string; StartIndex: Integer; Count: Integer): Integer; overload;
    function IndexOfAny(const AnyOf: array of Char): Integer; overload;
    function IndexOfAny(const AnyOf: array of Char; StartIndex: Integer): Integer; overload;
    function IndexOfAny(const AnyOf: array of Char; StartIndex: Integer; Count: Integer): Integer; overload;
    /// <summary>Index of any given chars, excluding those that are between quotes</summary>
    function IndexOfAnyUnquoted(const AnyOf: array of Char; StartQuote, EndQuote: Char): Integer; overload;
    function IndexOfAnyUnquoted(const AnyOf: array of Char; StartQuote, EndQuote: Char; StartIndex: Integer): Integer; overload;
    function IndexOfAnyUnquoted(const AnyOf: array of Char; StartQuote, EndQuote: Char; StartIndex: Integer; Count: Integer): Integer; overload;
    function Insert(StartIndex: Integer; const Value: string): string;
    function IsDelimiter(const Delimiters: string; Index: Integer): Boolean;
    function IsEmpty: Boolean; inline;
    class function IsNullOrEmpty(const Value: string): Boolean; static; inline;
    class function IsNullOrWhiteSpace(const Value: string): Boolean; static;
    class function Join(const Separator: string; const Values: array of const): string; overload; static;
    class function Join(const Separator: string; const Values: array of string): string; overload; static;
    class function Join(const Separator: string; const Values: IEnumerator<string>): string; overload; static;
    class function Join(const Separator: string; const Values: IEnumerable<string>): string; overload; static; inline;
    class function Join(const Separator: string; const Values: array of string; StartIndex: Integer; Count: Integer): string; overload; static;
    function LastDelimiter(const Delims: string): Integer; overload;
    function LastDelimiter(const Delims: TSysCharSet): Integer; overload;
    function LastIndexOf(Value: Char): Integer; overload;
    function LastIndexOf(const Value: string): Integer; overload;
    function LastIndexOf(Value: Char; StartIndex: Integer): Integer; overload;
    function LastIndexOf(const Value: string; StartIndex: Integer): Integer; overload;
    function LastIndexOf(Value: Char; StartIndex: Integer; Count: Integer): Integer; overload;
    function LastIndexOf(const Value: string; StartIndex: Integer; Count: Integer): Integer; overload;
    function LastIndexOfAny(const AnyOf: array of Char): Integer; overload;
    function LastIndexOfAny(const AnyOf: array of Char; StartIndex: Integer): Integer; overload;
    function LastIndexOfAny(const AnyOf: array of Char; StartIndex: Integer; Count: Integer): Integer; overload;
    function PadLeft(TotalWidth: Integer): string; overload; inline;
    function PadLeft(TotalWidth: Integer; PaddingChar: Char): string; overload; inline;
    function PadRight(TotalWidth: Integer): string; overload; inline;
    function PadRight(TotalWidth: Integer; PaddingChar: Char): string; overload; inline;
    function QuotedString: string; overload;
    function QuotedString(const QuoteChar: Char): string; overload;
    function Remove(StartIndex: Integer): string; overload; inline;
    function Remove(StartIndex: Integer; Count: Integer): string; overload; inline;
    function Replace(OldChar: Char; NewChar: Char): string; overload;
    function Replace(OldChar: Char; NewChar: Char; ReplaceFlags: TReplaceFlags): string; overload;
    function Replace(const OldValue: string; const NewValue: string): string; overload;
    function Replace(const OldValue: string; const NewValue: string; ReplaceFlags: TReplaceFlags): string; overload;
    function Split(const Separator: array of Char): TArray<string>; overload;
    function Split(const Separator: array of Char; Count: Integer): TArray<string>; overload;
    function Split(const Separator: array of Char; Options: TStringSplitOptions): TArray<string>; overload;
    function Split(const Separator: array of Char; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
    function Split(const Separator: array of string): TArray<string>; overload;
    function Split(const Separator: array of string; Count: Integer): TArray<string>; overload;
    function Split(const Separator: array of string; Options: TStringSplitOptions): TArray<string>; overload;
    function Split(const Separator: array of string; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
    function Split(const Separator: array of Char; Quote: Char): TArray<string>; overload;
    function Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char): TArray<string>; overload;
    function Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char; Options: TStringSplitOptions): TArray<string>; overload;
    function Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char; Count: Integer): TArray<string>; overload;
    function Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
    function Split(const Separator: array of string; Quote: Char): TArray<string>; overload;
    function Split(const Separator: array of string; QuoteStart, QuoteEnd: Char): TArray<string>; overload;
    function Split(const Separator: array of string; QuoteStart, QuoteEnd: Char; Options: TStringSplitOptions): TArray<string>; overload;
    function Split(const Separator: array of string; QuoteStart, QuoteEnd: Char; Count: Integer): TArray<string>; overload;
    function Split(const Separator: array of string; QuoteStart, QuoteEnd: Char; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
    class function StartsText(const ASubText, AText: string): Boolean; static;
    function StartsWith(const Value: string): Boolean; overload; inline;
    function StartsWith(const Value: string; IgnoreCase: Boolean): Boolean; overload;
    function Substring(StartIndex: Integer): string; overload; inline;
    function Substring(StartIndex: Integer; Length: Integer): string; overload; inline;
    function ToBoolean: Boolean; overload; inline;
    function ToInteger: Integer; overload; inline;
    /// <summary>Converts the string to an Int64 value</summary>
    function ToInt64: Int64; overload; inline;
    function ToSingle: Single; overload; inline;
    function ToDouble: Double; overload; inline;
    function ToExtended: Extended; overload; inline;
    function ToCharArray: TArray<Char>; overload;
    function ToCharArray(StartIndex: Integer; Length: Integer): TArray<Char>; overload;
    function ToLower: string; overload; inline;
    function ToLower(LocaleID: TLocaleID): string; overload;
    function ToLowerInvariant: string; {$IF Defined(USE_LIBICU) and not Defined(Linux)}inline;{$ENDIF}
    function ToUpper: string; overload; inline;
    function ToUpper(LocaleID: TLocaleID): string; overload;
    function ToUpperInvariant: string; {$IF Defined(USE_LIBICU) and not Defined(Linux)}inline;{$ENDIF}
    function Trim: string; overload;
    function TrimLeft: string; overload;
    function TrimRight: string; overload;
    function Trim(const TrimChars: array of Char): string; overload;
    function TrimLeft(const TrimChars: array of Char): string; overload;
    function TrimRight(const TrimChars: array of Char): string; overload;
    function TrimEnd(const TrimChars: array of Char): string; deprecated 'Use TrimRight';
    function TrimStart(const TrimChars: array of Char): string; deprecated 'Use TrimLeft';
    property Chars[Index: Integer]: Char read GetChars;
    property Length: Integer read GetLength;
    //Custom
    function IsGUID: Boolean; overload;
  end;


implementation

uses
  System.Types, Winapi.Windows, System.SysConst;


{ TCustomStringHelper }

function TCustomStringHelper.IsGUID: Boolean;
begin
  Result := TRegEx.IsMatch(Self, '^\{?[0-9a-fA-F]{8}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{4}-?[0-9a-fA-F]{12}\}?$');
end;

function TCustomStringHelper.GetChars(Index: Integer): Char;
begin
  Result := Self[Index];
end;

function TCustomStringHelper.GetLength: Integer;
begin
  Result := System.Length(Self);
end;

function TCustomStringHelper.Substring(StartIndex: Integer): string;
begin
  Result := System.Copy(Self, StartIndex + 1, Self.Length);
end;

function TCustomStringHelper.Substring(StartIndex, Length: Integer): string;
begin
  Result := System.Copy(Self, StartIndex + 1, Length);
end;

class function TCustomStringHelper.CharInArray(const C: Char; const InArray: array of Char): Boolean;
var
  AChar: Char;
begin
  for AChar in InArray do
    if AChar = C then Exit(True);
  Result := False;
end;

class function TCustomStringHelper.Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB,
  Length: Integer): Integer;
begin
  Result := Compare(StrA, IndexA, StrB, IndexB, Length, False, SysLocale.DefaultLCID);
end;

class function TCustomStringHelper.Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB,
  Length: Integer; LocaleID: TLocaleID): Integer;
begin
  Result := Compare(StrA, IndexA, StrB, IndexB, Length, False, LocaleID);
end;

class function TCustomStringHelper.Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB, Length: Integer;
  IgnoreCase: Boolean): Integer;
begin
  Result := Compare(StrA, IndexA, StrB, IndexB, Length, IgnoreCase, SysLocale.DefaultLCID);
end;

class function TCustomStringHelper.InternalCompare(const StrA: string; IndexA: Integer; const StrB: string;
  IndexB, LengthA, LengthB: Integer; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer;
begin
  if IgnoreCase then
    Result := InternalCompare(StrA, IndexA, StrB, IndexB, LengthA, LengthB, [coIgnoreCase], LocaleID)
  else
    Result := InternalCompare(StrA, IndexA, StrB, IndexB, LengthA, LengthB, [], LocaleID);
end;

class function TCustomStringHelper.InternalCompare(const StrA: string; IndexA: Integer; const StrB: string;
  IndexB, LengthA, LengthB: Integer; Options: TCompareOptions; LocaleID: TLocaleID): Integer;
var
  Flags: DWORD;
begin
  if (StrA.Length = 0) or (StrB.Length = 0) then
  begin
    if StrA.Length > 0 then
      Result := 1
    else
      if StrB.Length > 0 then
        Result := -1
      else
        Result := 0;
  end else
  begin
    Flags := InternalMapOptionsToFlags(Options);
    Result := CompareString(LocaleID, Flags, PChar(@StrA[IndexA]), LengthA, PChar(@StrB[IndexB]), LengthB) - CSTR_EQUAL;
  end
end;

class function TCustomStringHelper.InternalMapOptionsToFlags(
  AOptions: TCompareOptions): LongWord;
const
  MapFlags: array [TCompareOption] of LongWord = (LINGUISTIC_IGNORECASE,
    LINGUISTIC_IGNOREDIACRITIC, NORM_IGNORECASE, NORM_IGNOREKANATYPE,
    NORM_IGNORENONSPACE, NORM_IGNORESYMBOLS, NORM_IGNOREWIDTH,
    NORM_LINGUISTIC_CASING, SORT_DIGITSASNUMBERS, SORT_STRINGSORT);
var  Option: TCompareOption;
begin
  Result := 0;
  for Option := Low(TCompareOption) to High(TCompareOption) do
    if Option in AOptions then
      if ((Option <> coLingIgnoreCase) or TOSVersion.Check(6,0)) and
         ((Option <> coDigitAsNumbers) or TOSVersion.Check(6,1)) then
        Result := Result or MapFlags[Option];
end;

class function TCustomStringHelper.Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB, Length: Integer;
  IgnoreCase: Boolean; LocaleID: TLocaleID): Integer;
begin
  Result := InternalCompare(StrA, IndexA, StrB, IndexB, Length, Length, IgnoreCase, LocaleID);
end;

class function TCustomStringHelper.Compare(const StrA, StrB: string; IgnoreCase: Boolean): Integer;
begin
  Result := InternalCompare(StrA, 0, StrB, 0, StrA.Length, StrB.Length, IgnoreCase, SysLocale.DefaultLCID);
end;

class function TCustomStringHelper.Compare(const StrA, StrB: string; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer;
begin
  Result := InternalCompare(StrA, 0, StrB, 0, StrA.Length, StrB.Length, IgnoreCase, LocaleID);
end;

class function TCustomStringHelper.Compare(const StrA, StrB: string; Options: TCompareOptions; LocaleID: TLocaleID): Integer;
begin
  Result := InternalCompare(StrA, 0, StrB, 0, StrA.Length, StrB.Length, Options, LocaleID);
end;

class function TCustomStringHelper.Compare(const StrA, StrB: string; Options: TCompareOptions): Integer;
begin
  Result := InternalCompare(StrA, 0, StrB, 0, StrA.Length, StrB.Length, Options, SysLocale.DefaultLCID);
end;

class function TCustomStringHelper.Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB, Length: Integer;
  Options: TCompareOptions; LocaleID: TLocaleID): Integer;
begin
  Result := InternalCompare(StrA, IndexA, StrB, IndexB, Length, Length, Options, LocaleID);
end;

class function TCustomStringHelper.Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB, Length: Integer;
  Options: TCompareOptions): Integer;
begin
  Result := InternalCompare(StrA, IndexA, StrB, IndexB, Length, Length, Options, SysLocale.DefaultLCID);
end;

class function TCustomStringHelper.Compare(const StrA, StrB: string): Integer;
begin
  Result := InternalCompare(StrA, 0, StrB, 0, StrA.Length, StrB.Length, [], SysLocale.DefaultLCID);
end;

class function TCustomStringHelper.Compare(const StrA, StrB: string; LocaleID: TLocaleID): Integer;
begin
  Result := InternalCompare(StrA, 0, StrB, 0, StrA.Length, StrB.Length, [], LocaleID);
end;

class function TCustomStringHelper.CompareOrdinal(const StrA, StrB: string): Integer;
var
  MaxLen: Integer;
  len: Integer;
begin
  len:= 0;
  if StrA.Length > StrB.Length then
    MaxLen := StrA.Length
  else
    MaxLen := StrB.Length;
  Result := System.SysUtils.StrLComp(PChar(@StrA[len]), PChar(@StrB[len]), MaxLen);
end;

class function TCustomStringHelper.CompareOrdinal(const StrA: string; IndexA: Integer; const StrB: string; IndexB,
  Length: Integer): Integer;
begin
  Result := System.SysUtils.StrLComp(PChar(@StrA[IndexA]), PChar(@StrB[IndexB]), Length);
end;

class function TCustomStringHelper.CompareText(const StrA: string; const StrB: string): Integer;
begin
  Result := System.SysUtils.CompareText(StrA, StrB);
end;

class function TCustomStringHelper.ToBoolean(const S: string): Boolean;
begin
  Result := StrToBool(S);
end;

class function TCustomStringHelper.ToInteger(const S: string): Integer;
begin
  Result := Integer.Parse(S);
end;

class function TCustomStringHelper.ToInt64(const S: string): Int64;
begin
  Result := Int64.Parse(S);
end;

class function TCustomStringHelper.ToSingle(const S: string): Single;
begin
  Result := Single.Parse(S);
end;

class function TCustomStringHelper.ToDouble(const S: string): Double;
begin
  Result := Double.Parse(S);
end;

class function TCustomStringHelper.ToExtended(const S: string): Extended;
begin
  Result := Extended.Parse(S);
end;

class function TCustomStringHelper.Parse(const Value: Integer): string;
begin
  Result := IntToStr(Value);
end;

class function TCustomStringHelper.Parse(const Value: Int64): string;
begin
  Result := IntToStr(Value);
end;

class function TCustomStringHelper.Parse(const Value: Boolean): string;
begin
  Result := BoolToStr(Value);
end;

class function TCustomStringHelper.Parse(const Value: Extended): string;
begin
  Result := FloatToStr(Value);
end;

class function TCustomStringHelper.LowerCase(const S: string): string;
begin
  Result := System.SysUtils.LowerCase(S);
end;

class function TCustomStringHelper.LowerCase(const S: string; LocaleOptions: TLocaleOptions): string;
begin
  Result := System.SysUtils.LowerCase(S, LocaleOptions);
end;

class function TCustomStringHelper.UpperCase(const S: string): string;
begin
  Result := System.SysUtils.UpperCase(S);
end;

class function TCustomStringHelper.UpperCase(const S: string; LocaleOptions: TLocaleOptions): string;
begin
  Result := System.SysUtils.UpperCase(S, LocaleOptions);
end;

function TCustomStringHelper.CompareTo(const strB: string): Integer;
begin
  Result := System.SysUtils.StrComp(PChar(Self), PChar(strB));
end;

function TCustomStringHelper.Contains(const Value: string): Boolean;
begin
  Result := System.Pos(Value, Self) > 0;
end;

class function TCustomStringHelper.Copy(const Str: string): string;
begin
  Result := System.Copy(Str, 1, Str.Length);
end;

procedure TCustomStringHelper.CopyTo(SourceIndex: Integer; var Destination: array of Char; DestinationIndex, Count: Integer);
begin
  Move(PChar(PChar(Self)+SourceIndex)^, Destination[DestinationIndex], Count * SizeOf(Char));
end;

function TCustomStringHelper.CountChar(const C: Char): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I:= Low(Self) to High(Self) do
    if Self[I] = C then
      Inc(Result);
end;

class function TCustomStringHelper.Create(C: Char; Count: Integer): string;
begin
  Result := StringOfChar(C, Count);
end;

class function TCustomStringHelper.Create(const Value: array of Char; StartIndex, Length: Integer): string;
begin
  SetLength(Result, Length);
  Move(Value[StartIndex], PChar(PChar(Result))^, Length * SizeOf(Char));
end;

class function TCustomStringHelper.Create(const Value: array of Char): string;
begin
  SetLength(Result, System.Length(Value));
  Move(Value[0], PChar(PChar(Result))^, System.Length(Value) * SizeOf(Char));
end;

function TCustomStringHelper.DeQuotedString(const QuoteChar: Char): string;
var
  I:Integer;
  LastQuoted: Boolean;
  LPosDest: Integer;
  LResult: array of Char;
begin
  if (Self.Length >= 2) and (Self[Low(Self)] = QuoteChar) and (Self[High(Self)] = QuoteChar) then
  begin
    LastQuoted := False;
    LPosDest := 0;
    SetLength(LResult, Self.Length - 2);
    For I := Low(Self) + 1 to High(Self) - 1 do
    begin
      if (Self[I] = QuoteChar) then
      begin
        if LastQuoted then
        begin
          LastQuoted := False;
          LResult[LPosDest] := Self[I];
          Inc(LPosDest);
        end
        else LastQuoted := True;
      end
      else begin
        if LastQuoted then
        begin
          LastQuoted := false;
          // The quoted char is not doubled, should we put in the resulting string?
        end;
        LResult[LPosDest] := Self[I];
        Inc(LPosDest);
      end;
    end;
    Result := string.Create(LResult, 0, LPosDest)
  end
  else
    Result := Self;
end;

function TCustomStringHelper.DeQuotedString: string;
begin
  Result := Self.DeQuotedString('''');
end;

class function TCustomStringHelper.EndsText(const ASubText, AText: string): Boolean;
begin
  Result := AText.EndsWith(ASubText, True);
end;

function TCustomStringHelper.EndsWith(const Value: string): Boolean;
begin
  Result := EndsWith(Value, False);
end;

function TCustomStringHelper.EndsWith(const Value: string; IgnoreCase: Boolean): Boolean;
var
  LSubTextLocation: Integer;
  LOptions: TCompareOptions;
begin
  if Value = Empty then
    Result := True
  else
  begin
    LSubTextLocation := Self.Length - Value.Length;
    if (LSubTextLocation >= 0) and (ByteType(Self, LSubTextLocation) <> mbLeadByte) then
    begin
      if IgnoreCase then
        LOptions := [coIgnoreCase]
      else
        LOptions := [];
      Result := string.Compare(Value, 0, Self, LSubTextLocation, Value.Length, LOptions) = 0;
    end
    else
      Result := False;
  end;
end;

class function TCustomStringHelper.Equals(const a, b: string): Boolean;
begin
  Result := a = b;
end;

function TCustomStringHelper.Equals(const Value: string): Boolean;
begin
  Result := Self = Value;
end;

class function TCustomStringHelper.Format(const Format: string; const args: array of const): string;
begin
  Result := System.SysUtils.Format(Format, args);
end;

function TCustomStringHelper.IndexOf(Value: Char; StartIndex, Count: Integer): Integer;
begin
  Result := System.Pos(Value, Self, StartIndex + 1) - 1;
  if (Result + 1) > (StartIndex + Count) then
    Result := -1;
end;

function TCustomStringHelper.IndexOf(const Value: string; StartIndex, Count: Integer): Integer;
begin
  Result := System.Pos(Value, Self, StartIndex + 1) - 1;
  if (Result + Value.Length) > (StartIndex + Count) then
    Result := -1;
end;

function TCustomStringHelper.IndexOf(const Value: string; StartIndex: Integer): Integer;
begin
  Result := System.Pos(Value, Self, StartIndex + 1) - 1;
end;

function TCustomStringHelper.IndexOf(const Value: string): Integer;
begin
  Result := System.Pos(Value, Self) - 1;
end;

function TCustomStringHelper.IndexOf(Value: Char): Integer;
var
  P: PChar;
  I: Integer;
begin
  P := Pointer(Self);
  for I := 0 to System.Length(Self) - 1 do
    if P[I] = Value then Exit(I);
  Result := -1;
end;

function TCustomStringHelper.IndexOf(Value: Char; StartIndex: Integer): Integer;
var
  P: PChar;
  I: Integer;
begin
  P := Pointer(Self);
  if StartIndex >= 0 then
    for I := StartIndex to System.Length(Self) - 1 do
      if P[I] = Value then Exit(I);
  Result := -1;
end;

function TCustomStringHelper.IndexOfAny(const AnyOf: array of Char; StartIndex, Count: Integer): Integer;
var
  I: Integer;
  C: Char;
  Max: Integer;
begin
  if (StartIndex + Count) >= Self.Length then
    Max := Self.Length
  else
    Max := StartIndex + Count;

  I := StartIndex;
  while I < Max do
  begin
    for C in AnyOf do
      if Self[I] = C then
        Exit(I);
    Inc(I);
  end;
  Result := -1;
end;

function TCustomStringHelper.IndexOfAny(const AnyOf: array of Char; StartIndex: Integer): Integer;
begin
  Result := IndexOfAny(AnyOf, StartIndex, Self.Length);
end;

function TCustomStringHelper.IndexOfAny(const AnyOf: array of Char): Integer;
begin
  Result := IndexOfAny(AnyOf, 0, Self.Length);
end;

function TCustomStringHelper.IndexOfAnyUnquoted(const AnyOf: array of Char; StartQuote, EndQuote: Char): Integer;
begin
  Result := IndexOfAnyUnquoted(AnyOf, StartQuote, EndQuote, 0, Self.Length);
end;

function TCustomStringHelper.IndexOfAnyUnquoted(const AnyOf: array of Char; StartQuote, EndQuote: Char;
  StartIndex: Integer): Integer;
begin
  Result := IndexOfAnyUnquoted(AnyOf, StartQuote, EndQuote, StartIndex, Self.Length);
end;

function TCustomStringHelper.IndexOfAnyUnquoted(const AnyOf: array of Char; StartQuote, EndQuote: Char; StartIndex,
  Count: Integer): Integer;
var
  I: Integer;
  C: Char;
  Max: Integer;
  LInQuote: Integer;
  LInQuoteBool: Boolean;
begin
  if (StartIndex + Count) >= Length then
    Max := Length
  else
    Max := StartIndex + Count;

  I := StartIndex;
  if StartQuote <> EndQuote then
  begin
    LInQuote := 0;
    while I < Max do
    begin
      if Self[I] = StartQuote then
        Inc(LInQuote)
      else
        if (Self[I] = EndQuote) and (LInQuote > 0) then
          Dec(LInQuote);

      if LInQuote = 0 then
        for C in AnyOf do
          if Self[I] = C then
            Exit(I);
      Inc(I);
    end;
  end
  else
  begin
    LInQuoteBool := False;
    while I < Max do
    begin
      if Self[I] = StartQuote then
        LInQuoteBool := not LInQuoteBool;

      if not LInQuoteBool then
        for C in AnyOf do
          if Self[I] = C then
            Exit(I);
      Inc(I);
    end;
  end;
  Result := -1;
end;

function TCustomStringHelper.Insert(StartIndex: Integer; const Value: string): string;
begin
  System.Insert(Value, Self, StartIndex + 1);
  Result := Self;
end;

function TCustomStringHelper.IsDelimiter(const Delimiters: string; Index: Integer): Boolean;
begin
  Result := False;
  if (Index < Low(string)) or (Index > High(Self)) or (ByteType(Self, Index) <> mbSingleByte) then exit;
  Result := StrScan(PChar(Delimiters), Self[Index]) <> nil;
end;

function TCustomStringHelper.IsEmpty: Boolean;
begin
  Result := Self = Empty;
end;

class function TCustomStringHelper.IsNullOrEmpty(const Value: string): Boolean;
begin
  Result := Value = Empty;
end;

class function TCustomStringHelper.IsNullOrWhiteSpace(const Value: string): Boolean;
begin
  Result := Value.Trim.Length = 0;
end;

class function TCustomStringHelper.Join(const Separator: string; const Values: array of string): string;
begin
  Result := Join(Separator, Values, 0, System.Length(Values));
end;

class function TCustomStringHelper.Join(const Separator: string; const Values: IEnumerable<string>): string;
begin
  if Values <> nil then
    Result := Join(Separator, Values.GetEnumerator)
  else
    Result := '';
end;

class function TCustomStringHelper.Join(const Separator: string; const Values: IEnumerator<string>): string;
begin
  if (Values <> nil) and Values.MoveNext then
  begin
    Result := Values.Current;
    while Values.MoveNext do
      Result := Result + Separator + Values.Current;
  end
  else
    Result := '';
end;

class function TCustomStringHelper.Join(const Separator: string; const Values: array of string; StartIndex,
  Count: Integer): string;
var
  I: Integer;
  Max: Integer;
begin
  if (Count = 0) or ((System.Length(Values) = 0) and (StartIndex = 0)) then
    Result := ''
  else
  begin
    if (Count < 0) or (StartIndex >= System.Length(Values)) then
      raise ERangeError.CreateRes(@SRangeError);

    if (StartIndex + Count) > System.Length(Values) then
      Max := System.Length(Values)
    else
      Max := StartIndex + Count;

    Result := Values[StartIndex];
    for I:= StartIndex + 1 to Max - 1 do
      Result := Result + Separator + Values[I];
  end;
end;

class function TCustomStringHelper.Join(const Separator: string; const Values: array of const): string;
var
  I: Integer;
  len: Integer;
  function ValueToString(const val: TVarRec):string;
  begin
    case val.VType of
      vtInteger    :
        Result := IntToStr(val.VInteger);
      vtBoolean    :
        Result := BoolToStr(val.VBoolean, True);
      vtChar       :
        Result := Char(val.VChar);
      vtPChar      :
        Result := string(val.VPChar);
      vtExtended   :
        Result := FloatToStr(val.VExtended^);
      vtObject     :
        Result := TObject(val.VObject).Classname;
      vtClass      :
        Result := val.VClass.Classname;
      vtCurrency   :
        Result := CurrToStr(val.VCurrency^);
      vtInt64    :
        Result := IntToStr(PInt64(val.VInt64)^);
      vtUnicodeString :
        Result := string(val.VUnicodeString);
    else
        Result := Format('(Unknown) : %d',[val.VType]);
    end;
  end;
begin
  len := System.Length(Values);
  if len = 0 then
    Result := ''
  else begin
    Result := ValueToString(Values[0]);
    for I := 1 to len-1 do
      Result := Result + Separator + ValueToString(Values[I]);
  end;
end;

function TCustomStringHelper.LastIndexOf(const Value: string; StartIndex: Integer): Integer;
begin
  Result := LastIndexOf(Value, StartIndex, StartIndex + 1);
end;

function TCustomStringHelper.LastIndexOf(Value: Char; StartIndex: Integer): Integer;
begin
  Result := LastIndexOf(Value, StartIndex, StartIndex + 1);
end;

function TCustomStringHelper.LastIndexOf(Value: Char): Integer;
begin
  Result := LastIndexOf(Value, Self.Length - 1, Self.Length);
end;

function TCustomStringHelper.LastIndexOf(const Value: string): Integer;
begin
  Result := LastIndexOf(Value, Self.Length - 1, Self.Length);
end;

function TCustomStringHelper.LastDelimiter(const Delims: string): Integer;
var
  I, J: Integer;
begin
  I := High(Self);
  while I >= Low(string) do
  begin
    for J := Low(string) to High(Delims) do
      if Self.Chars[I] = Delims.Chars[J] then
        Exit(I);
    Dec(I);
  end;
  Result := -1;
end;

function TCustomStringHelper.LastDelimiter(const Delims: TSysCharSet): Integer;
var
  PSt, P: PChar;
begin
  PSt := Pointer(Self);
  if PSt <> nil then
  begin
    P := PSt + Length - 1;
    while P >= PSt do
    begin
      if P^ in Delims then
        Exit(P - PSt);
      Dec(P);
    end;
  end;
  Result := -1;
end;

function TCustomStringHelper.LastIndexOf(const Value: string; StartIndex, Count: Integer): Integer;
var
  I: Integer;
  Min: Integer;
begin
  if (Value.Length = 0) then
    Exit(-1);
  if StartIndex < Self.Length then
    I := StartIndex - Value.Length + 1
  else
    I := Self.Length - Value.Length;
  if (StartIndex - Count) < 0 then
    Min := 0
  else
    Min := StartIndex - Count + 1;
  while I >= Min do
  begin
    if (StrLComp(@PChar(Self)[I], PChar(Value), Value.Length) = 0) then
      Exit(I);
    Dec(I);
  end;
  Result := -1;
end;

function TCustomStringHelper.LastIndexOf(Value: Char; StartIndex, Count: Integer): Integer;
var
  I: Integer;
  Min: Integer;
begin
  if StartIndex < Self.Length then
    I := StartIndex
  else
    I := Self.Length - 1;
  if (StartIndex - Count) < 0 then
    Min := 0
  else
    Min := StartIndex - Count + 1;
  while I >= Min do
  begin
    if Self[I] = Value then
      Exit(I);
    Dec(I);
  end;
  Result := -1;
end;

function TCustomStringHelper.LastIndexOfAny(const AnyOf: array of Char): Integer;
begin
  Result := LastIndexOfAny(AnyOf, Self.Length - 1, Self.Length);
end;

function TCustomStringHelper.LastIndexOfAny(const AnyOf: array of Char; StartIndex, Count: Integer): Integer;
var
  I: Integer;
  Min: Integer;
  C: Char;
begin
  if StartIndex < Self.Length then
    I := StartIndex
  else
    I := Self.Length - 1;
  if (StartIndex - Count) < 0 then
    Min := 0
  else
    Min := StartIndex - Count + 1;
  while I >= Min do
  begin
    for C in AnyOf do
      if Self[I] = C then
        Exit(I);
    Dec(I);
  end;
  Result := -1;
end;

function TCustomStringHelper.LastIndexOfAny(const AnyOf: array of Char; StartIndex: Integer): Integer;
begin
  Result := LastIndexOfAny(AnyOf, StartIndex, Self.Length);
end;

function TCustomStringHelper.PadLeft(TotalWidth: Integer; PaddingChar: Char): string;
begin
  TotalWidth := TotalWidth - Length;
  if TotalWidth > 0 then
    Result := System.StringOfChar(PaddingChar, TotalWidth) + Self
  else
    Result := Self;
end;

function TCustomStringHelper.PadLeft(TotalWidth: Integer): string;
begin
  Result := PadLeft(TotalWidth, ' ');
end;

function TCustomStringHelper.PadRight(TotalWidth: Integer; PaddingChar: Char): string;
begin
  TotalWidth := TotalWidth - Length;
  if TotalWidth > 0 then
    Result := Self + System.StringOfChar(PaddingChar, TotalWidth)
  else
    Result := Self;
end;

function TCustomStringHelper.PadRight(TotalWidth: Integer): string;
begin
  Result := PadRight(TotalWidth, ' ');
end;

function TCustomStringHelper.QuotedString(const QuoteChar: Char): string;
var
  I: Integer;
begin
  Result := Self.Substring(0);
  for I := Result.Length - 1 downto 0 do
    if Result.Chars[I] = QuoteChar then Result := Result.Insert(I, QuoteChar);
  Result := QuoteChar + Result + QuoteChar;
end;

function TCustomStringHelper.QuotedString: string;
var
  I: Integer;
begin
  Result := Self.Substring(0);
  for I := Result.Length - 1 downto 0 do
    if Result.Chars[I] = '''' then Result := Result.Insert(I, '''');
  Result := '''' + Result + '''';
end;

function TCustomStringHelper.Remove(StartIndex, Count: Integer): string;
begin
  Result := Self;
  System.Delete(Result, StartIndex + 1, Count);
end;

function TCustomStringHelper.Remove(StartIndex: Integer): string;
begin
  Result := Self;
  System.Delete(Result, StartIndex + 1, Result.Length);
end;

function TCustomStringHelper.Replace(OldChar, NewChar: Char): string;
begin
  Result := System.SysUtils.StringReplace(Self, OldChar, NewChar, [rfReplaceAll]);
end;

function TCustomStringHelper.Replace(OldChar: Char; NewChar: Char; ReplaceFlags: TReplaceFlags): string;
begin
  Result := System.SysUtils.StringReplace(Self, OldChar, NewChar, ReplaceFlags);
end;

function TCustomStringHelper.Replace(const OldValue, NewValue: string): string;
begin
  Result := System.SysUtils.StringReplace(Self, OldValue, NewValue, [rfReplaceAll]);
end;

function TCustomStringHelper.Replace(const OldValue: string; const NewValue: string; ReplaceFlags: TReplaceFlags): string;
begin
  Result := System.SysUtils.StringReplace(Self, OldValue, NewValue, ReplaceFlags);
end;

function TCustomStringHelper.Split(const Separator: array of Char; Options: TStringSplitOptions): TArray<string>;
begin
  Result := Split(Separator, MaxInt, Options);
end;

function TCustomStringHelper.Split(const Separator: array of Char; Count: Integer): TArray<string>;
begin
  Result := Split(Separator, Count, TStringSplitOptions.None);
end;

function TCustomStringHelper.Split(const Separator: array of Char): TArray<string>;
begin
  Result := Split(Separator, MaxInt, TStringSplitOptions.None);
end;


function TCustomStringHelper.IndexOfAny(const Values: array of string; var Index: Integer; StartIndex: Integer): Integer;
var
  C, P, IoA: Integer;
begin
  IoA := -1;
  for C := 0 to High(Values) do
  begin
    P := IndexOf(Values[C], StartIndex);
    if (P >= 0) and((P < IoA) or (IoA = -1)) then
    begin
      IoA := P;
      Index := C;
    end;
  end;
  Result := IoA;
end;

function TCustomStringHelper.IndexOfAnyUnquoted(const Values: array of string; StartQuote, EndQuote: Char; var Index: Integer; StartIndex: Integer): Integer;
var
  C, P, IoA: Integer;
begin
  IoA := -1;
  for C := 0 to High(Values) do
  begin
    P := IndexOfQuoted(Values[C], StartQuote, EndQuote, StartIndex);
    if (P >= 0) and((P < IoA) or (IoA = -1)) then
    begin
      IoA := P;
      Index := C;
    end;
  end;
  Result := IoA;
end;

function Posx(const SubStr, Str: UnicodeString; Offset: Integer): Integer; overload;
var
  I, LIterCnt, L, J: Integer;
  PSubStr, PS: PWideChar;
begin
  L := Length(SubStr);
  LIterCnt := Length(Str) - Offset - L + 1;

  if (Offset > 0) and (LIterCnt >= 0) and (L > 0) then
  begin
    PSubStr := PWideChar(SubStr);
    PS := PWideChar(Str);
    Inc(PS, Offset);

    for I := 0 to LIterCnt do
    begin
      J := 0;
      while (J >= 0) and (J < L) do
      begin
        if PS[I + J] = PSubStr[J] then
          Inc(J)
        else
          J := -1;
      end;
      if J >= L then
        Exit(I + Offset);
    end;
  end;

  Result := 0;
end;

function TCustomStringHelper.IndexOfQuoted(const Value: string; StartQuote, EndQuote: Char; StartIndex: Integer): Integer;
var
  I, LIterCnt, L, J: Integer;
  PSubStr, PS: PWideChar;
  LInQuote: Integer;
  LInQuoteBool: Boolean;
begin
  L := Value.Length;
  LIterCnt := Self.Length - StartIndex - L + 1;

  if (StartIndex >= 0) and (LIterCnt >= 0) and (L > 0) then
  begin
    PSubStr := PWideChar(Value);
    PS := PWideChar(Self);
    Inc(PS, StartIndex);

    if StartQuote <> EndQuote then
    begin
      LInQuote := 0;

      for I := 0 to LIterCnt do
      begin
        J := 0;
        while (J >= 0) and (J < L) do
        begin
          if PS[I + J] = StartQuote then
            Inc(LInQuote)
          else
            if PS[I + J] = EndQuote then
              Dec(LInQuote);

          if LInQuote > 0 then
            J := -1
          else
          begin
            if PS[I + J] = PSubStr[J] then
              Inc(J)
            else
              J := -1;
          end;
        end;
        if J >= L then
          Exit(I + StartIndex);
      end;
    end
    else
    begin
      LInQuoteBool := False;
      for I := 0 to LIterCnt do
      begin
        J := 0;
        while (J >= 0) and (J < L) do
        begin
          if PS[I + J] = StartQuote then
            LInQuoteBool := not LInQuoteBool;

          if LInQuoteBool then
            J := -1
          else
          begin
            if PS[I + J] = PSubStr[J] then
              Inc(J)
            else
              J := -1;
          end;
        end;
        if J >= L then
          Exit(I + StartIndex);
      end;
    end;
  end;

  Result := -1;
end;

function TCustomStringHelper.InternalSplit(SplitType: TSplitKind; const SeparatorC: array of Char; const SeparatorS: array of string;
  QuoteStart, QuoteEnd: Char; Count: Integer; Options: TStringSplitOptions): TArray<string>;
const
  DeltaGrow = 32;
var
  NextSeparator, LastIndex, L: Integer;
  Total: Integer;
  CurrentLength: Integer;
  SeparatorIndex: Integer;
begin
  if IsEmpty then
    Exit(nil);

  Total := 0;
  LastIndex := 0;
  CurrentLength := 0;
  SeparatorIndex := 0;
  case SplitType of
    TSplitKind.StringSeparatorsNoQuoted,
    TSplitKind.StringSeparatorNoQuoted:
      if High(SeparatorS) = 0 then
      begin
        SplitType := TSplitKind.StringSeparatorNoQuoted;
        NextSeparator := IndexOf(SeparatorS[0], LastIndex);
      end
      else
        NextSeparator := IndexOfAny(SeparatorS, SeparatorIndex, LastIndex);
    TSplitKind.StringSeparatorsQuoted:
      NextSeparator := IndexOfAnyUnquoted(SeparatorS, QuoteStart, QuoteEnd, SeparatorIndex, LastIndex);
    TSplitKind.CharSeparatorsNoQuoted,
    TSplitKind.CharSeparatorNoQuoted:
      if High(SeparatorC) = 0 then
      begin
        SplitType := TSplitKind.CharSeparatorNoQuoted;
        NextSeparator := IndexOf(SeparatorC[0], LastIndex);
      end
      else
        NextSeparator := IndexOfAny(SeparatorC, LastIndex);
    TSplitKind.CharSeparatorsQuoted:
      NextSeparator := IndexOfAnyUnquoted(SeparatorC, QuoteStart, QuoteEnd, LastIndex);
  else
    NextSeparator := -1;
  end;
  while (NextSeparator >= 0) and (Total < Count) do
  begin
    L := NextSeparator - LastIndex;
    if (L > 0) or (Options <> TStringSplitOptions.ExcludeEmpty) then
    begin
      Inc(Total);
      if CurrentLength < Total then
      begin
        CurrentLength := Total + DeltaGrow;
        SetLength(Result, CurrentLength);
      end;
      Result[Total - 1] := System.Copy(Self, LastIndex + 1, L);
    end;

    case SplitType of
      TSplitKind.StringSeparatorsNoQuoted:
      begin
        LastIndex := NextSeparator + SeparatorS[SeparatorIndex].Length;
        NextSeparator := IndexOfAny(SeparatorS, SeparatorIndex, LastIndex);
      end;
      TSplitKind.StringSeparatorsQuoted:
      begin
        LastIndex := NextSeparator + SeparatorS[SeparatorIndex].Length;
        NextSeparator := IndexOfAnyUnquoted(SeparatorS, QuoteStart, QuoteEnd, SeparatorIndex, LastIndex);
      end;
      TSplitKind.StringSeparatorNoQuoted:
      begin
        LastIndex := NextSeparator + SeparatorS[0].Length;
        NextSeparator := IndexOf(SeparatorS[0], LastIndex);
      end;
      TSplitKind.CharSeparatorsNoQuoted:
      begin
        LastIndex := NextSeparator + 1;
        NextSeparator := IndexOfAny(SeparatorC, LastIndex);
      end;
      TSplitKind.CharSeparatorsQuoted:
      begin
        LastIndex := NextSeparator + 1;
        NextSeparator := IndexOfAnyUnquoted(SeparatorC, QuoteStart, QuoteEnd, LastIndex);
      end;
      TSplitKind.CharSeparatorNoQuoted:
      begin
        LastIndex := NextSeparator + 1;
        NextSeparator := IndexOf(SeparatorC[0], LastIndex);
      end;
    end;
  end;

  L := Self.Length - LastIndex;
  if (L >= 0) and (Total < Count) then
  begin
    if (L > 0) or not (Options in [TStringSplitOptions.ExcludeEmpty, TStringSplitOptions.ExcludeLastEmpty]) then
    begin
      Inc(Total);
      SetLength(Result, Total);
      Result[Total - 1] := System.Copy(Self, LastIndex + 1, L);
    end
    else
      SetLength(Result, Total);
  end
  else
    SetLength(Result, Total);
end;

function TCustomStringHelper.Split(const Separator: array of string; Count: Integer;
  Options: TStringSplitOptions): TArray<string>;
begin
  Result := InternalSplit(TSplitKind.StringSeparatorsNoQuoted, [], Separator, Char(0), Char(0), Count, Options);
end;

function TCustomStringHelper.Split(const Separator: array of string; QuoteStart, QuoteEnd: Char;
  Count: Integer; Options: TStringSplitOptions): TArray<string>;
begin
  Result := InternalSplit(TSplitKind.StringSeparatorsQuoted, [], Separator, QuoteStart, QuoteEnd, Count, Options);
end;

function TCustomStringHelper.Split(const Separator: array of Char; Count: Integer;
  Options: TStringSplitOptions): TArray<string>;
begin
  Result := InternalSplit(TSplitKind.CharSeparatorsNoQuoted, Separator, [], Char(0), Char(0), Count, Options);
end;

function TCustomStringHelper.Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char; Count: Integer;
  Options: TStringSplitOptions): TArray<string>;
begin
  Result := InternalSplit(TSplitKind.CharSeparatorsQuoted, Separator, [], QuoteStart, QuoteEnd, Count, Options);
end;

function TCustomStringHelper.Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char): TArray<string>;
begin
  Result := Split(Separator, QuoteStart, QuoteEnd, MaxInt, TStringSplitOptions.None);
end;

function TCustomStringHelper.Split(const Separator: array of Char; Quote: Char): TArray<string>;
begin
  Result := Split(Separator, Quote, Quote, MaxInt, TStringSplitOptions.None);
end;

function TCustomStringHelper.Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char;
  Count: Integer): TArray<string>;
begin
  Result := Split(Separator, QuoteStart, QuoteEnd, Count, TStringSplitOptions.None);
end;

function TCustomStringHelper.Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char;
  Options: TStringSplitOptions): TArray<string>;
begin
  Result := Split(Separator, QuoteStart, QuoteEnd, MaxInt, Options);
end;

function TCustomStringHelper.Split(const Separator: array of string): TArray<string>;
begin
  Result := Split(Separator, MaxInt, TStringSplitOptions.None);
end;

function TCustomStringHelper.Split(const Separator: array of string; Count: Integer): TArray<string>;
begin
  Result := Split(Separator, Count, TStringSplitOptions.None);
end;

function TCustomStringHelper.Split(const Separator: array of string; Options: TStringSplitOptions): TArray<string>;
begin
  Result := Split(Separator, MaxInt, Options);
end;

function TCustomStringHelper.Split(const Separator: array of string; Quote: Char): TArray<string>;
begin
  Result := Split(Separator, Quote, Quote, MaxInt, TStringSplitOptions.None);
end;

function TCustomStringHelper.Split(const Separator: array of string; QuoteStart, QuoteEnd: Char): TArray<string>;
begin
  Result := Split(Separator, QuoteStart, QuoteEnd, MaxInt, TStringSplitOptions.None);
end;

function TCustomStringHelper.Split(const Separator: array of string; QuoteStart, QuoteEnd: Char; Options: TStringSplitOptions): TArray<string>;
begin
  Result := Split(Separator, QuoteStart, QuoteEnd, MaxInt, Options);
end;

function TCustomStringHelper.Split(const Separator: array of string; QuoteStart, QuoteEnd: Char; Count: Integer): TArray<string>;
begin
  Result := Split(Separator, QuoteStart, QuoteEnd, Count, TStringSplitOptions.None);
end;

class function TCustomStringHelper.StartsText(const ASubText, AText: string): Boolean;
begin
  if ASubText = Empty then
    Result := True
  else
  begin
    if (AText.Length >= ASubText.Length) then
      Result := AnsiStrLIComp(PChar(ASubText), PChar(AText), ASubText.Length) = 0
    else
      Result := False;
  end;
end;

function TCustomStringHelper.StartsWith(const Value: string): Boolean;
begin
  Result := StartsWith(Value, False);
end;

function TCustomStringHelper.StartsWith(const Value: string; IgnoreCase: Boolean): Boolean;
begin
  if Value = Empty then
    Result := True
  else if IgnoreCase then
    Result := StartsText(Value, Self)
  else
    Result := IndexOf(Value) = 0;
end;

function TCustomStringHelper.ToBoolean: Boolean;
begin
  Result := StrToBool(Self);
end;

function TCustomStringHelper.ToInteger: Integer;
begin
  Result := Integer.Parse(Self);
end;

function TCustomStringHelper.ToInt64: Int64;
begin
  Result := Int64.Parse(Self);
end;

function TCustomStringHelper.ToSingle: Single;
begin
  Result := Single.Parse(Self);
end;

function TCustomStringHelper.ToDouble: Double;
begin
  Result := Double.Parse(Self);
end;

function TCustomStringHelper.ToExtended: Extended;
begin
  Result := Extended.Parse(Self);
end;

function TCustomStringHelper.ToCharArray: TArray<Char>;
begin
  Result := ToCharArray(0, Self.Length);
end;

function TCustomStringHelper.ToCharArray(StartIndex, Length: Integer): TArray<Char>;
begin
  SetLength(Result, Length);
  Move(PChar(PChar(Self) + StartIndex)^, Result[0], Length * SizeOf(Char));
end;

function TCustomStringHelper.ToLower: string;
begin
  Result := ToLower(SysLocale.DefaultLCID);
end;

function TCustomStringHelper.ToLower(LocaleID: TLocaleID): string;
begin
  Result := Self;
  if Result <> '' then
  begin
    UniqueString(Result);

    if LCMapString(LocaleID, LCMAP_LOWERCASE or LCMAP_LINGUISTIC_CASING, PChar(Self), Self.Length,
       PChar(Result), Result.Length) = 0 then
      RaiseLastOSError;
  end;
end;

function TCustomStringHelper.ToLowerInvariant: string;
var
  MapLocale: LCID;
begin
  Result := Self;
  if Result <> '' then
  begin
    UniqueString(Result);
    if TOSVersion.Check(5, 1) then
      MapLocale := LOCALE_INVARIANT
    else
      MapLocale := LOCALE_SYSTEM_DEFAULT;
    if LCMapString(MapLocale, LCMAP_LOWERCASE {or LCMAP_LINGUISTIC_CASING}, PChar(Self), Self.Length,
       PChar(Result), Result.Length) = 0 then
      RaiseLastOSError;
  end;
end;

function TCustomStringHelper.ToUpper: string;
begin
  Result := ToUpper(SysLocale.DefaultLCID);
end;

function TCustomStringHelper.ToUpper(LocaleID: TLocaleID): string;
begin
  Result := Self;
  if Result <> '' then
  begin
    UniqueString(Result);

    if LCMapString(LocaleID, LCMAP_UPPERCASE or LCMAP_LINGUISTIC_CASING, PChar(Self), Self.Length,
       PChar(Result), Result.Length) = 0 then
      RaiseLastOSError;
  end;
end;

function TCustomStringHelper.ToUpperInvariant: string;
var
  MapLocale: LCID;
begin
  Result := Self;
  if Result <> '' then
  begin
    UniqueString(Result);
    if TOSVersion.Check(5, 1) then
      MapLocale := LOCALE_INVARIANT
    else
      MapLocale := LOCALE_SYSTEM_DEFAULT;
    if LCMapString(MapLocale, LCMAP_UPPERCASE {or LCMAP_LINGUISTIC_CASING}, PChar(Self), Self.Length,
      PChar(Result), Result.Length) = 0 then
      RaiseLastOSError;
  end;
end;

function TCustomStringHelper.GetHashCode: Integer;
var
  LResult: UInt32;
  I: Integer;
begin
  LResult := 0;
  for I := 0 to System.Length(Self) - 1 do
  begin
    LResult := (LResult shl 5) or (LResult shr 27); //ROL Result, 5
    LResult := LResult xor UInt32(Self[I]);
  end;
  Result := Int32(LResult);
end;

function TCustomStringHelper.Trim: string;
var
  I, L: Integer;
begin
  L := Self.Length - 1;
  I := 0;
  if (L = -1) or (Self[I] > ' ') and (Self[L] > ' ') then Exit(Self);
  while (I <= L) and (Self[I] <= ' ') do Inc(I);
  if I > L then Exit('');
  while Self[L] <= ' ' do Dec(L);
  Result := Self.SubString(I, L - I + 1);
end;

function TCustomStringHelper.TrimLeft: string;
var
  I, L: Integer;
begin
  L := Self.Length - 1;
  I := 0;
  while (I <= L) and (Self[I] <= ' ') do Inc(I);
  if I > 0 then
    Result := Self.SubString(I)
  else
    Result := Self;
end;

function TCustomStringHelper.TrimRight: string;
var
  I: Integer;
begin
  I := Self.Length - 1;
  if (I >= 0) and (Self[I] > ' ') then Result := Self
  else begin
    while (I >= 0) and (Self.Chars[I] <= ' ') do Dec(I);
    Result := Self.SubString(0, I + 1);
  end;
end;

function TCustomStringHelper.Trim(const TrimChars: array of Char): string;
var
  I, L: Integer;
begin
  L := Self.Length - 1;
  I := 0;
  if (L > 0) and (not CharInArray(Self[I], TrimChars)) and (not CharInArray(Self[L], TrimChars)) then
    Exit(Self);
  while (I <= L) and (CharInArray(Self[I], TrimChars)) do
    Inc(I);
  if I > L then Exit('');
  while CharInArray(Self[L], TrimChars) do
    Dec(L);
  Result := Self.Substring( I, L - I + 1);
end;

function TCustomStringHelper.TrimLeft(const TrimChars: array of Char): string;
var
  I, L: Integer;
begin
  L := Self.Length;
  I := 0;
  while (I < L) and (CharInArray(Self[I], TrimChars)) do
    Inc(I);
  if I > 0 then
    Result := Self.SubString(I)
  else
    Result := Self;
end;

function TCustomStringHelper.TrimRight(const TrimChars: array of Char): string;
var
  I: Integer;
begin
  I := Self.Length-1;
  if (I >= 0) and (not CharInArray(Self[I], TrimChars)) then
    Exit(Self);
  Dec(I);
  while (I >= 0) and (CharInArray(Self[I], TrimChars)) do
    Dec(I);
  Result := Self.SubString(0, I+1);
end;

function TCustomStringHelper.TrimEnd(const TrimChars: array of Char): string;
begin
  Result := Self.TrimRight(TrimChars);
end;

function TCustomStringHelper.TrimStart(const TrimChars: array of Char): string;
begin
  Result := Self.TrimLeft(TrimChars);
end;


end.