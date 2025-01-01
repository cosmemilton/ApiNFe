unit apinfe.constants;

interface

uses
  Generics.Collections;

const
  csDBApiNFe        = 'DBApiNFe';
  csPG              = 'PG';
  apiBase           = '/api/v1';
  apiBaseV2         = '/api/v2';
  apiBaseAdmin      = apiBase + '/admin';
  apiBaseClient     = apiBase + '/client';
  path              = 'C:\SERVICES\ApiNfe\';
  pathNFeBase       = path + 'NFe\';
  pathNFeBaseXML    = pathNFeBase + 'XMLs\';
  pathNFeSalvar     = pathNFeBase + 'Salvar\';
  pathNFeInut       = pathNFeBase + 'Inutilizar\';
  pathNFeEvento     = pathNFeBase + 'Evento\';
  pathLog           = path + 'Log\';
  pathPDF           = path + 'PDF\';
  error             = 'internal error';
  iniFileNameConfigDB        = path + 'ApiNfeConfigDB.ini';
  iniFileNameConfigLog       = path + 'ApiNfeConfigLog.ini';
  iniFileNameConfigLogDb     = path + 'ApiNfeConfigLogDb.ini';
  iniFileNameConfigToken     = path + 'ApiNfeConfigToken.ini';
  iniFileNameConfigServer    = path + 'ApiNfeConfigServer.ini';
  iniFileNameConfigMailServer= path + 'ApiNfeConfigMailServer.ini';
  localhost         = 'localhost';
  pathSchemasBase   = pathNFeBase + 'schemas\';
  versaoServ        = 'API_NFe 1.00';

  GUID_NULL = '00000000-0000-0000-0000-000000000000';

  {$REGION 'Responsavel Tecnico (Fake - https://www.4devs.com.br/gerador_de_cpf)'}
  infRespTecCNPJ    = '43427626849';
  infRespTecContato = 'Lucas Mateus Pedro Ribeiro';
  infRespTecEmail   = 'lucas-ribeiro95@planicoop.com.br';
  infRespTecFone    = '83992096841';
  {$ENDREGION}

  DefaultNamePrint = 'Microsoft Print to PDF';

  ufAC = 'AC';
  ufAL = 'AL';
  ufAP = 'AP';
  ufAM = 'AM';
  ufBA = 'BA';
  ufCE = 'CE';
  ufDF = 'DF';
  ufES = 'ES';
  ufGO = 'GO';
  ufMT = 'MT';
  ufMA = 'MA';
  ufMS = 'MS';
  ufMG = 'MG';
  ufPA = 'PA';
  ufPB = 'PB';
  ufPR = 'PR';
  ufPE = 'PE';
  ufPI = 'PI';
  ufRJ = 'RJ';
  ufRN = 'RN';
  ufRS = 'RS';
  ufRO = 'RO';
  ufRR = 'RR';
  ufSC = 'SC';
  ufSP = 'SP';
  ufSE = 'SE';
  ufTO = 'TO';

  arrUFs: TArray<String> = [ ufAC, ufAL, ufAP, ufAM,
                             ufBA, ufCE, ufDF, ufES,
                             ufGO, ufMT, ufMA, ufMS,
                             ufMG, ufPA, ufPB, ufPR,
                             ufPE, ufPI, ufRJ, ufRN,
                             ufRS, ufRO, ufRR, ufSC,
                             ufSP, ufSE, ufTO ];
  csPathReturnJWT    = '/api/v1/returnJWT';
  csPathEmissao      = '/api/v1/emissao';
  csPathEmissaoID    = '/api/v1/emissao/:id';
  csPathInutilizar   = '/api/v1/inutilizar';
  csPathCancelar     = '/api/v1/cancelar';
  csPathRetornaTodas = '/retorna/todas';
  csPathXmlChave     = '/api/v1/xml/:chave';
  csPathDanfeChave   = '/api/v1/danfe/:chave';
  csPathPostLogs     = '/api/v1/logs';

  arrSkipRoutes: TArray<String> = [
    csPathReturnJWT,
    csPathEmissao,
    csPathInutilizar,
    csPathCancelar,
    csPathRetornaTodas,
    csPathXmlChave,
    csPathEmissaoID,
    csPathDanfeChave,
    csPathPostLogs
  ];
  cString         = 'STRING';
  cInteger        = 'INTEGER';
  cDouble         = 'DOUBLE';
  cISO8601String  = 'ISO8601String';
  cJSONArray      = 'JSONArray';
  cJSONObject     = 'JSONObject';
  stAmProducao    = 'Produção';
  stAmHomologacao = 'Homologação';

type
  TUFs = TDictionary<string, string>;



implementation



end.
