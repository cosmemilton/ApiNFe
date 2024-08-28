unit apinfe.controller.base;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,
  apinfe.controller;

type
  TControllerApi = class
    private
      FModule: string;
      FHostName: string;
      FEnableHTTPS: Boolean;
      FEnableHTTP: Boolean;
      FDataBase: TDBConfig;

      FtokenLifeTime: Integer;
      FPrivateKey: string;
      FHabilitaLog: Boolean;
      FTThreadFileLog: TThreadFileLog;
      FConfigMongoDB: TConfigMongoDB;
      procedure SetHostName(const Value: string);
      procedure SetModule(const Value: string);
      procedure SetEnableHTTP(const Value: Boolean);
      procedure SetEnableHTTPS(const Value: Boolean);
      procedure SetDataBase(const Value: TDBConfig);
      procedure SetTokenLifeTime(const Value: Integer);
      procedure SetPrivateKey(const Value: string);
      procedure SetHabilitaLog(const Value: Boolean);
      procedure SetConfigMongoDB(const Value: TConfigMongoDB);
    public
      property DataBase: TDBConfig read FDataBase write SetDataBase;
      property HostName: string read FHostName write SetHostName;
      property Module: string read FModule write SetModule;
      property EnableHTTP: Boolean read FEnableHTTP default False;
      property EnableHTTPS: Boolean read FEnableHTTPS default True;
      property tokenLifeTime: Integer read FtokenLifeTime;
      property privateKey: string read FPrivateKey;
      property HabilitaLog: Boolean read FHabilitaLog default False;
      property ConfigMongoDB: TConfigMongoDB read FConfigMongoDB write setConfigMongoDB;
      procedure FileLog(const aLog: string);

    published
      constructor Create;
  end;

implementation

{ TControllerApi }

constructor TControllerApi.Create;
var ini: Tinifile;
begin
  FDataBase:= TDBConfig.Create;
  FConfigMongoDB:= TConfigMongoDB.Create;
  ForceDirectories(path);
  ForceDirectories(pathLog);
  ForceDirectories(pathPDF);
  ini:= Tinifile.Create(iniFileName);
  if FileExists(iniFileName) then
    begin
      Self.DataBase.SetHostName(ini.ReadString('DB','hostname', localhost));
      Self.DataBase.SetUserName(ini.ReadString('DB','username', 'UserNameDB'));
      Self.DataBase.SetPassword(ini.ReadString('DB','password', 'PasswordDB'));
      Self.DataBase.SetPort(ini.ReadInteger('DB','port', 5432));
      Self.SetHostName(ini.ReadString('IIS','hostName','localhost/mobile.dll'));
      Self.SetModule(ini.ReadString('IIS','module', 'mobile.dll'));
      Self.SetEnableHTTP(ini.ReadBool('IIS','EnableHttpSwagger'  , False));
      Self.SetEnableHTTPS(ini.ReadBool('IIS','EnableHttpsSwagger'  , True));
      Self.SetTokenLifeTime(ini.ReadInteger('Token','TempoDeVidaEmMinutos', 5));
      Self.SetHabilitaLog(ini.ReadBool('Geral','HabilitaLog', False));
      Self.ConfigMongoDB.SetPathDB(ini.ReadString('MongoDB','PathDB', ''));
      Self.ConfigMongoDB.SetNameDB(ini.ReadString('MongoDB','NameDB', ''));
      Self.ConfigMongoDB.SetUseMongo(ini.ReadBool('MongoDB','UseMongo', False));
    end
  else
    begin
      Self.DataBase.SetHostName(localhost);
      Self.DataBase.SetUserName('UserNameDB');
      Self.DataBase.SetPassword('PasswordDB');
      Self.DataBase.SetPort(5432);
      Self.SetHostName('localhost/ApiNFeIsapi.dll');
      Self.SetModule('ApiNFeIsapi.dll');
      Self.SetEnableHTTP(False);
      Self.SetEnableHTTPS(True);
      Self.SetTokenLifeTime(5);
      Self.SetHabilitaLog(False);
      //
      ini.WriteString('DB'  ,'hostname', Self.DataBase.HostName);
      ini.WriteString('DB'  ,'username', Self.DataBase.UserName);
      ini.WriteString('DB'  ,'password', Self.DataBase.Password);
      ini.WriteInteger('DB' ,'port'    , Self.DataBase.Port);
      //
      ini.WriteString('IIS','hostName', Self.HostName);
      ini.WriteString('IIS','module'  , Self.Module);
      ini.WriteBool('IIS','EnableHttpSwagger'  , Self.EnableHTTP);
      ini.WriteBool('IIS','EnableHttpsSwagger'  , Self.EnableHTTPS);
      //
      ini.WriteInteger('Token','TempoDeVidaEmMinutos', Self.tokenLifeTime);
      //
      ini.WriteBool('Geral','HabilitaLog', Self.HabilitaLog);
      //
      ini.WriteBool('MongoDB','UseMongo', Self.ConfigMongoDB.UseMongo);
      ini.WriteString('MongoDB','PathDB', Self.ConfigMongoDB.PathDB);
      ini.WriteString('MongoDB','NameDB', Self.ConfigMongoDB.NameDB);
    end;
  FreeAndNil(ini);

end;

procedure TControllerApi.FileLog(const aLog: string);
begin
  if Self.FHabilitaLog then
    begin
      if not Assigned(FTThreadFileLog) then
        begin
          if ConfigMongoDB.UseMongo then
            FTThreadFileLog:= TThreadFileLog.Create(ConfigMongoDB.PathDB, ConfigMongoDB.NameDB)
          else
            FTThreadFileLog:= TThreadFileLog.Create;
        end;
      FTThreadFileLog.Log(FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) + ' ' + aLog, True);
    end;
end;

procedure TControllerApi.SetConfigMongoDB(const Value: TConfigMongoDB);
begin

end;

procedure TControllerApi.SetDataBase(const Value: TDBConfig);
begin

end;

procedure TControllerApi.SetEnableHTTP(const Value: Boolean);
begin

end;

procedure TControllerApi.SetEnableHTTPS(const Value: Boolean);
begin

end;

procedure TControllerApi.SetHabilitaLog(const Value: Boolean);
begin

end;

procedure TControllerApi.SetHostName(const Value: string);
begin

end;

procedure TControllerApi.SetModule(const Value: string);
begin

end;

procedure TControllerApi.SetPrivateKey(const Value: string);
begin

end;

procedure TControllerApi.SetTokenLifeTime(const Value: Integer);
begin

end;

end.
