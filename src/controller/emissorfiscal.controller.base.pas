unit emissorfiscal.controller.base;

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles,

  ThreadFileLog,
  ThreadUtilities,
  apinfe.dto.config.db,
  apinfe.dto.config.jwt,
  apinfe.dto.config.emailserver,
  apinfe.adapter.mongo,
  apinfe.dto.config.mongo,
  apinfe.constants;

type
  TControllerApiNFeBase = class
    private
      FModule: string;
      FHostName: string;
      FEnableHTTPS: Boolean;
      FEnableHTTP: Boolean;
      FHabilitaLog: Boolean;
      FTThreadFileLog: TThreadFileLog;
      FConfigMongoDB: TConfigMongoDB;
      procedure SetHostName(const Value: string);
      procedure SetModule(const Value: string);
      procedure SetEnableHTTP(const Value: Boolean);
      procedure SetEnableHTTPS(const Value: Boolean);
      procedure SetHabilitaLog(const Value: Boolean);
      procedure SetConfigMongoDB(const Value: TConfigMongoDB);
    public
      property HostName: string read FHostName write SetHostName;
      property Module: string read FModule write SetModule;
      property EnableHTTP: Boolean read FEnableHTTP default False;
      property EnableHTTPS: Boolean read FEnableHTTPS default True;
      property HabilitaLog: Boolean read FHabilitaLog default False;
      property ConfigMongoDB: TConfigMongoDB read FConfigMongoDB write setConfigMongoDB;
      procedure FileLog(const aLog: string);
      
      constructor Create;
  end;

implementation

{ TControllerApi }

constructor TControllerApiNFeBase.Create;
var ini: Tinifile;
begin
  FConfigMongoDB:= TConfigMongoDB.Create;
  ForceDirectories(path);
  ForceDirectories(pathLog);
  ForceDirectories(pathPDF);
  ini:= Tinifile.Create(iniFileName);
  if FileExists(iniFileName) then
    begin
      TDBConfig.getInstance().SetHostName(ini.ReadString('DB','hostname', localhost));
      TDBConfig.getInstance().SetUserName(ini.ReadString('DB','username', 'UserNameDB'));
      TDBConfig.getInstance().SetPassword(ini.ReadString('DB','password', 'PasswordDB'));
      TDBConfig.getInstance().SetPort(ini.ReadInteger('DB','port', 5432));
      TDBConfig.getInstance().SetDatabase(ini.ReadString('DB','database', 'emissorfiscal'));
      TEmailServerDTO.getInstance().setHost(ini.ReadString('Email','host', 'smtp.gmail.com'));
      TEmailServerDTO.getInstance().setPort(ini.ReadInteger('Email','port', 587));
      TEmailServerDTO.getInstance().setUsername(ini.ReadString('Email','username', ''));
      TEmailServerDTO.getInstance().setPassword(ini.ReadString('Email','password', ''));
      TEmailServerDTO.getInstance().setUseTLS(ini.ReadBool('Email','useTLS', True));
      TJWTConfigDTO.getInstance.SetExpirationTime(ini.ReadInteger('Token','TempoDeVidaEmMinutos', 5));
      Self.SetHostName(ini.ReadString('IIS','hostName','localhost/mobile.dll'));
      Self.SetModule(ini.ReadString('IIS','module', 'mobile.dll'));
      Self.SetEnableHTTP(ini.ReadBool('IIS','EnableHttpSwagger'  , False));
      Self.SetEnableHTTPS(ini.ReadBool('IIS','EnableHttpsSwagger'  , True));

      Self.SetHabilitaLog(ini.ReadBool('Geral','HabilitaLog', False));
      Self.ConfigMongoDB.SetPathDB(ini.ReadString('MongoDB','PathDB', ''));
      Self.ConfigMongoDB.SetNameDB(ini.ReadString('MongoDB','NameDB', ''));
      Self.ConfigMongoDB.SetUseMongo(ini.ReadBool('MongoDB','UseMongo', False));
    end
  else
    begin
      TDBConfig.getInstance().SetHostName(localhost);
      TDBConfig.getInstance().SetUserName('UserNameDB');
      TDBConfig.getInstance().SetPassword('PasswordDB');
      TDBConfig.getInstance().SetPort( 5432);
      TDBConfig.getInstance().SetDatabase('emissorfiscal');
      TEmailServerDTO.getInstance().setHost('smtp.gmail.com');
      TEmailServerDTO.getInstance().setPort(587);
      TEmailServerDTO.getInstance().setUsername('');
      TEmailServerDTO.getInstance().setPassword('');
      TEmailServerDTO.getInstance().setUseTLS(True);
      TJWTConfigDTO.getInstance().SetExpirationTime( 5 );
      Self.SetHostName('localhost/ApiNFeIsapi.dll');
      Self.SetModule('ApiNFeIsapi.dll');
      Self.SetEnableHTTP(False);
      Self.SetEnableHTTPS(True);
      Self.SetHabilitaLog(False);
      //
      ini.WriteString('DB'  ,'hostname', TDBConfig.getInstance().HostName);
      ini.WriteString('DB'  ,'username', TDBConfig.getInstance().UserName);
      ini.WriteString('DB'  ,'password', TDBConfig.getInstance().Password);
      ini.WriteInteger('DB' ,'port'    , TDBConfig.getInstance().Port);
      ini.WriteString('DB' ,'database' , TDBConfig.getInstance().Database);
      //
      ini.WriteString('Email' ,'host', TEmailServerDTO.getInstance().Host);
      ini.WriteInteger('Email','port', TEmailServerDTO.getInstance().Port);
      ini.WriteString('Email' ,'username', TEmailServerDTO.getInstance().Username);
      ini.WriteString('Email' ,'password', TEmailServerDTO.getInstance().Password);
      ini.WriteBool('Email'   ,'useTLS', TEmailServerDTO.getInstance().UseTLS);
      //
      ini.WriteString('IIS','hostName', Self.HostName);
      ini.WriteString('IIS','module'  , Self.Module);
      ini.WriteBool('IIS','EnableHttpSwagger'  , Self.EnableHTTP);
      ini.WriteBool('IIS','EnableHttpsSwagger'  , Self.EnableHTTPS);
      //
      ini.WriteInteger('Token','TempoDeVidaEmMinutos', TJWTConfigDTO.getInstance().ExpirationTime);
      //
      ini.WriteBool('Geral','HabilitaLog', Self.HabilitaLog);
      //
      ini.WriteBool('MongoDB','UseMongo', Self.ConfigMongoDB.UseMongo);
      ini.WriteString('MongoDB','PathDB', Self.ConfigMongoDB.PathDB);
      ini.WriteString('MongoDB','NameDB', Self.ConfigMongoDB.NameDB);
    end;
  FreeAndNil(ini);

end;

procedure TControllerApiNFeBase.FileLog(const aLog: string);
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

procedure TControllerApiNFeBase.SetConfigMongoDB(const Value: TConfigMongoDB);
begin
  FConfigMongoDB:= Value;
end;


procedure TControllerApiNFeBase.SetEnableHTTP(const Value: Boolean);
begin
  FEnableHTTP:= Value;
end;

procedure TControllerApiNFeBase.SetEnableHTTPS(const Value: Boolean);
begin
  FEnableHTTPS:= Value;
end;

procedure TControllerApiNFeBase.SetHabilitaLog(const Value: Boolean);
begin
  FHabilitaLog:= Value;
end;

procedure TControllerApiNFeBase.SetHostName(const Value: string);
begin
  FHostName:= Value;
end;

procedure TControllerApiNFeBase.SetModule(const Value: string);
begin
  FModule:= Value;
end;


end.
