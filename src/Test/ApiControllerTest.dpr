program ApiControllerTest;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  DUnitX.MemoryLeakMonitor.FastMM4,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  {$ENDIF }
  DUnitX.TestFramework,
  uApiControllerTest in 'uApiControllerTest.pas',
  emissorfiscal.dao.clientregister in '..\dao\emissorfiscal.dao.clientregister.pas',
  emissorfiscal.controller.base in '..\controller\emissorfiscal.controller.base.pas',
  ThreadFileLog in '..\utils\ThreadFileLog.pas',
  ThreadUtilities in '..\utils\ThreadUtilities.pas',
  apinfe.adapter.mongo in '..\components\apinfe.adapter.mongo.pas',
  Nghttp2 in '..\components\DelphiRemotePushSender\Nghttp2.pas',
  PascalZMQ in '..\components\DelphiZeroMQ\PascalZMQ.pas',
  ZMQ.API in '..\components\DelphiZeroMQ\ZMQ.API.pas',
  ZMQ.BrokerProtocol in '..\components\DelphiZeroMQ\ZMQ.BrokerProtocol.pas',
  ZMQ.ClientProtocol in '..\components\DelphiZeroMQ\ZMQ.ClientProtocol.pas',
  ZMQ.Protocol in '..\components\DelphiZeroMQ\ZMQ.Protocol.pas',
  ZMQ.Shared in '..\components\DelphiZeroMQ\ZMQ.Shared.pas',
  ZMQ.WorkerProtocol in '..\components\DelphiZeroMQ\ZMQ.WorkerProtocol.pas',
  Grijjy.BinaryCoding in '..\components\GrijjyFoundation\Grijjy.BinaryCoding.pas',
  Grijjy.Bson.IO in '..\components\GrijjyFoundation\Grijjy.Bson.IO.pas',
  Grijjy.Bson in '..\components\GrijjyFoundation\Grijjy.Bson.pas',
  Grijjy.Bson.Path in '..\components\GrijjyFoundation\Grijjy.Bson.Path.pas',
  Grijjy.Bson.Serialization in '..\components\GrijjyFoundation\Grijjy.Bson.Serialization.pas',
  Grijjy.CloudLogging.InstanceTracker in '..\components\GrijjyFoundation\Grijjy.CloudLogging.InstanceTracker.pas',
  Grijjy.CloudLogging in '..\components\GrijjyFoundation\Grijjy.CloudLogging.pas',
  Grijjy.CloudLogging.Protocol in '..\components\GrijjyFoundation\Grijjy.CloudLogging.Protocol.pas',
  Grijjy.Collections in '..\components\GrijjyFoundation\Grijjy.Collections.pas',
  Grijjy.Console in '..\components\GrijjyFoundation\Grijjy.Console.pas',
  Grijjy.DateUtils in '..\components\GrijjyFoundation\Grijjy.DateUtils.pas',
  Grijjy.Hash in '..\components\GrijjyFoundation\Grijjy.Hash.pas',
  Grijjy.Hooking in '..\components\GrijjyFoundation\Grijjy.Hooking.pas',
  Grijjy.Http in '..\components\GrijjyFoundation\Grijjy.Http.pas',
  Grijjy.JWT in '..\components\GrijjyFoundation\Grijjy.JWT.pas',
  Grijjy.MemoryPool in '..\components\GrijjyFoundation\Grijjy.MemoryPool.pas',
  Grijjy.OpenSSL.API in '..\components\GrijjyFoundation\Grijjy.OpenSSL.API.pas',
  Grijjy.OpenSSL in '..\components\GrijjyFoundation\Grijjy.OpenSSL.pas',
  Grijjy.PropertyBag in '..\components\GrijjyFoundation\Grijjy.PropertyBag.pas',
  Grijjy.ProtocolBuffers in '..\components\GrijjyFoundation\Grijjy.ProtocolBuffers.pas',
  Grijjy.RemotePush.Receiver in '..\components\GrijjyFoundation\Grijjy.RemotePush.Receiver.pas',
  Grijjy.RemotePush.Sender in '..\components\GrijjyFoundation\Grijjy.RemotePush.Sender.pas',
  Grijjy.Scram in '..\components\GrijjyFoundation\Grijjy.Scram.pas',
  Grijjy.SocketPool.Win in '..\components\GrijjyFoundation\Grijjy.SocketPool.Win.pas',
  Grijjy.System.Console in '..\components\GrijjyFoundation\Grijjy.System.Console.pas',
  Grijjy.System in '..\components\GrijjyFoundation\Grijjy.System.pas',
  Grijjy.SysUtils in '..\components\GrijjyFoundation\Grijjy.SysUtils.pas',
  Grijjy.TimerQueue in '..\components\GrijjyFoundation\Grijjy.TimerQueue.pas',
  Grijjy.TimerQueue.Win in '..\components\GrijjyFoundation\Grijjy.TimerQueue.Win.pas',
  Grijjy.Uri in '..\components\GrijjyFoundation\Grijjy.Uri.pas',
  Grijjy.Winsock2 in '..\components\GrijjyFoundation\Grijjy.Winsock2.pas',
  Grijjy.MongoDB in '..\components\GrijjyMongoDB\Grijjy.MongoDB.pas',
  Grijjy.MongoDB.Protocol in '..\components\GrijjyMongoDB\Grijjy.MongoDB.Protocol.pas',
  Grijjy.MongoDB.Queries in '..\components\GrijjyMongoDB\Grijjy.MongoDB.Queries.pas',
  apinfe.constants in '..\constants\apinfe.constants.pas',
  apinfe.dto.config.db in '..\dto\apinfe.dto.config.db.pas',
  apinfe.dto.config.emailserver in '..\dto\apinfe.dto.config.emailserver.pas',
  apinfe.dto.config.jwt in '..\dto\apinfe.dto.config.jwt.pas',
  apinfe.dto.config.mongo in '..\dto\apinfe.dto.config.mongo.pas',
  emissorfiscal.dto.adminuser in '..\dto\emissorfiscal.dto.adminuser.pas',
  emissorfiscal.dto.cest in '..\dto\emissorfiscal.dto.cest.pas',
  emissorfiscal.dto.cfop in '..\dto\emissorfiscal.dto.cfop.pas',
  emissorfiscal.dto.companyaddresses in '..\dto\emissorfiscal.dto.companyaddresses.pas',
  emissorfiscal.dto.companycontacts in '..\dto\emissorfiscal.dto.companycontacts.pas',
  emissorfiscal.dto.companyinvoicesettings in '..\dto\emissorfiscal.dto.companyinvoicesettings.pas',
  emissorfiscal.dto.ncm in '..\dto\emissorfiscal.dto.ncm.pas',
  emissorfiscal.dto.participantaddresses in '..\dto\emissorfiscal.dto.participantaddresses.pas',
  emissorfiscal.dto.participants in '..\dto\emissorfiscal.dto.participants.pas',
  emissorfiscal.dto.products in '..\dto\emissorfiscal.dto.products.pas',
  emissorfiscal.dto.subscriptionplan in '..\dto\emissorfiscal.dto.subscriptionplan.pas',
  emissorfiscal.dto.workspacecompanies in '..\dto\emissorfiscal.dto.workspacecompanies.pas',
  emissorfiscal.dto.workspaces in '..\dto\emissorfiscal.dto.workspaces.pas',
  emissorfiscal.dto.workspaceusers in '..\dto\emissorfiscal.dto.workspaceusers.pas',
  emissorfiscal.querybuild in '..\dto\emissorfiscal.querybuild.pas',
  emissorfiscal.dao.adminuser in '..\dao\emissorfiscal.dao.adminuser.pas',
  emissorfiscal.dao.workspaces in '..\dao\emissorfiscal.dao.workspaces.pas',
  emissorfiscal.dao.workspaceusers in '..\dao\emissorfiscal.dao.workspaceusers.pas',
  emissorfiscal.databaseconnection in '..\dao\emissorfiscal.databaseconnection.pas',
  emissorfiscal.queryhelper in '..\utils\emissorfiscal.queryhelper.pas',
  emissorfiscal.helper.strings in '..\utils\emissorfiscal.helper.strings.pas',
  emissorfiscal.validate in '..\utils\emissorfiscal.validate.pas',
  emissorfiscal.types in '..\types\emissorfiscal.types.pas',
  apinfe.constants.errors in '..\constants\apinfe.constants.errors.pas';

{ keep comment here to protect the following conditional from being removed by the IDE when adding a unit }
{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    //tell the runner how we will log things
    //Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    //if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}
end.
