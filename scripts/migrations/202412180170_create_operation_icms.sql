CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS operation_icms (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo VARCHAR(60) NOT NULL, -- Código da figura icms
    descricao VARCHAR(255) NOT NULL, -- Descrição da figura icms
    operation_id UUID NOT NULL,
    orig VARCHAR(50) NOT NULL CHECK (orig IN (
        'Nacional',
        'EstrangeiraImportacaoDireta',
        'EstrangeiraAdquiridaBrasil',
        'NacionalConteudoImportacaoSuperior40',
        'NacionalProcessosBasicos',
        'NacionalConteudoImportacaoInferiorIgual40',
        'EstrangeiraImportacaoDiretaSemSimilar',
        'EstrangeiraAdquiridaBrasilSemSimilar',
        'NacionalConteudoImportacaoSuperior70'
    )), -- Origem da mercadoria
    CST VARCHAR(50) NOT NULL CHECK (CST IN (
        'cst00', 'cst10', 'cst20', 'cst30', 'cst40', 'cst41', 'cst45', 'cst50', 'cst51',
        'cst60', 'cst70', 'cst80', 'cst81', 'cst90', 'cstPart10', 'cstPart90',
        'cstRep41', 'cstVazio', 'cstICMSOutraUF', 'cstICMSSN', 'cstRep60',
        'cst02', 'cst15', 'cst53', 'cst61', 'cst01', 'cst12', 'cst13', 'cst14', 'cst21', 'cst72', 'cst73', 'cst74'
    )), -- Código da Situação Tributária
    CSOSN VARCHAR(50) CHECK (CSOSN IN (
        'csosnVazio', 'csosn101', 'csosn102', 'csosn103', 'csosn201', 'csosn202', 'csosn203', 'csosn300', 'csosn400', 'csosn500', 'csosn900'
    )), -- Código de Situação da Operação - Simples Nacional
    modBC VARCHAR(50) CHECK (modBC IN (
        'MargemValorAgregado', 'Pauta', 'PrecoTabelado', 'ValorOperacao', 'Nenhum'
    )), -- Modalidade de determinação da BC do ICMS
    pRedBC NUMERIC(5, 2), -- Percentual de redução da BC
    vBC NUMERIC(15, 2), -- Valor da BC do ICMS
    pICMS NUMERIC(5, 2), -- Alíquota do ICMS
    vICMS NUMERIC(15, 2), -- Valor do ICMS
    modBCST VARCHAR(50) CHECK (modBCST IN (
        'PrecoTabelado', 'ListaNegativa', 'ListaPositiva', 'ListaNeutra', 'MargemValorAgregado', 'Pauta', 'ValordaOperacao'
    )), -- Modalidade de determinação da BC do ICMS ST
    pMVAST NUMERIC(5, 2), -- Percentual da Margem de Valor Adicionado ICMS ST
    pRedBCST NUMERIC(5, 2), -- Percentual de redução da BC ICMS ST
    vBCST NUMERIC(15, 2), -- Valor da BC do ICMS ST
    pICMSST NUMERIC(5, 2), -- Alíquota do ICMS ST
    vICMSST NUMERIC(15, 2), -- Valor do ICMS ST
    UFST VARCHAR(2) CHECK (UFST IN (
        'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
    )), -- UF para qual é devido o ICMS ST
    pBCOp NUMERIC(5, 2), -- Percentual da BC operação própria
    vBCSTRet NUMERIC(15, 2), -- Valor da BC do ICMS ST retido
    vICMSSTRet NUMERIC(15, 2), -- Valor do ICMS ST retido
    motDesICMS VARCHAR(50) CHECK (motDesICMS IN (
        'Taxi', 'DeficienteFisico', 'ProdutorAgropecuario', 'FrotistaLocadora', 'DiplomaticoConsular',
        'AmazoniaLivreComercio', 'Suframa', 'VendaOrgaosPublicos', 'Outros', 'DeficienteCondutor',
        'DeficienteNaoCondutor', 'OrgaoFomento', 'OlimpiadaRio2016', 'SolicitadoFisco'
    )), -- Motivo da desoneração do ICMS
    pCredSN NUMERIC(5, 2), -- Percentual de crédito do ICMS SN
    vCredICMSSN NUMERIC(15, 2), -- Valor de crédito do ICMS SN
    vBCSTDest NUMERIC(15, 2), -- Valor da BC do ICMS ST da UF de destino
    vICMSSTDest NUMERIC(15, 2), -- Valor do ICMS ST da UF de destino
    vICMSDeson NUMERIC(15, 2), -- Valor do ICMS desonerado
    vICMSOp NUMERIC(15, 2), -- Valor do ICMS da operação
    pDif NUMERIC(5, 2), -- Percentual da diferença de alíquota
    vICMSDif NUMERIC(15, 2), -- Valor da diferença de alíquota
    vBCFCP NUMERIC(15, 2), -- Valor da base de cálculo do FCP
    pFCP NUMERIC(5, 2), -- Percentual do FCP
    vFCP NUMERIC(15, 2), -- Valor do FCP
    vBCFCPST NUMERIC(15, 2), -- Valor da base de cálculo do FCP ST
    pFCPST NUMERIC(5, 2), -- Percentual do FCP ST
    vFCPST NUMERIC(15, 2), -- Valor do FCP ST
    vBCFCPSTRet NUMERIC(15, 2), -- Valor da base de cálculo do FCP ST retido
    pFCPSTRet NUMERIC(5, 2), -- Percentual do FCP ST retido
    vFCPSTRet NUMERIC(15, 2), -- Valor do FCP ST retido
    pST NUMERIC(5, 2), -- Percentual do ICMS ST
    pRedBCEfet NUMERIC(5, 2), -- Percentual de redução da base de cálculo efetiva
    vBCEfet NUMERIC(15, 2), -- Valor da base de cálculo efetiva
    pICMSEfet NUMERIC(5, 2), -- Percentual do ICMS efetivo
    vICMSEfet NUMERIC(15, 2), -- Valor do ICMS efetivo
    vICMSSubstituto NUMERIC(15, 2), -- Valor do ICMS substituto
    vICMSSTDeson NUMERIC(15, 2), -- Valor do ICMS ST desonerado
    motDesICMSST VARCHAR(50) CHECK (motDesICMSST IN (
        'Taxi', 'DeficienteFisico', 'ProdutorAgropecuario', 'FrotistaLocadora', 'DiplomaticoConsular',
        'AmazoniaLivreComercio', 'Suframa', 'VendaOrgaosPublicos', 'Outros', 'DeficienteCondutor',
        'DeficienteNaoCondutor', 'OrgaoFomento', 'OlimpiadaRio2016', 'SolicitadoFisco'
    )), -- Motivo da desoneração do ICMS ST
    pFCPDif NUMERIC(5, 2), -- Percentual do FCP diferencial
    vFCPDif NUMERIC(15, 2), -- Valor do FCP diferencial
    vFCPEfet NUMERIC(15, 2), -- Valor do FCP efetivo
    adRemICMS NUMERIC(15, 2), -- Adicional de remessa do ICMS
    vICMSMono NUMERIC(15, 2), -- Valor do ICMS monofásico
    qBCMono NUMERIC(15, 2), -- Quantidade da base de cálculo monofásica
    adRemICMSReten NUMERIC(15, 2), -- Adicional de remessa do ICMS retido
    vICMSMonoReten NUMERIC(15, 2), -- Valor do ICMS monofásico retido
    qBCMonoReten NUMERIC(15, 2), -- Quantidade da base de cálculo monofásica retida
    pRedAdRem NUMERIC(5, 2), -- Percentual de redução do adicional de remessa
    motRedAdRem VARCHAR(50) CHECK (motRedAdRem IN ( 'TranspColetivo', 'Outros')), -- Motivo da redução do adicional de remessa
    vICMSMonoOp NUMERIC(15, 2), -- Valor do ICMS monofásico da operação
    vICMSMonoDif NUMERIC(15, 2), -- Valor do ICMS monofásico diferencial
    adRemICMSRet NUMERIC(15, 2), -- Adicional de remessa do ICMS retido
    vICMSMonoRet NUMERIC(15, 2), -- Valor do ICMS monofásico retido
    qBCMonoRet NUMERIC(15, 2), -- Quantidade da base de cálculo monofásica retida
    indDeduzDeson VARCHAR(50) CHECK (indDeduzDeson IN ( 'Nenhum', 'Sim', 'Nao')), -- Indicador de dedução da desoneração
    cBenefRBC VARCHAR(50), -- Código do benefício da redução da base de cálculo
    created_by UUID NOT NULL,
    updated_by UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (operation_id) REFERENCES operations(id),
    FOREIGN KEY (created_by) REFERENCES workspace_users(id),
    FOREIGN KEY (updated_by) REFERENCES workspace_users(id)
);

-- Adiciona um índice para a coluna operation_id
CREATE INDEX IF NOT EXISTS idx_operation_icms_operation_id ON operation_icms(operation_id);