@echo off
setlocal

REM Coleta as informações do usuário
set /p PGHOST="Digite o host do PostgreSQL: "
set /p PGPORT="Digite a porta do PostgreSQL: "
set /p PGUSER="Digite o usuário do PostgreSQL: "
set /p PGPASSWORD="Digite a senha do PostgreSQL: "
set /p PGDATABASE="Digite o nome do banco de dados: "

REM Exporta as variáveis de ambiente necessárias para o psql
set PGPASSWORD=%PGPASSWORD%

REM Navega até a pasta de migrations
cd /d "%~dp0migrations"

REM Executa todos os arquivos SQL na pasta ./migrations
for %%f in (*.sql) do (
    echo Executando %%f...
    psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f %%f
)

REM Limpa a variável de senha
set PGPASSWORD=

endlocal
echo Concluí­do.
pause