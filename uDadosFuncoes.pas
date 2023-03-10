unit uDadosFuncoes;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.UI, Vcl.Dialogs;

  procedure InsereDados(pTabela,pCampos,pValores:String;pMostrarMensagem:Boolean=True);
  procedure AtualizaDados(pTabela,pValores,pCondicao:String;pMostrarMensagem:Boolean=True);
  procedure ExcluirDados(pTabela,pCondicao:String;pMostrarMensagem:Boolean=True);
  procedure MensagensSistema(pMensagem:String);

  function  SqlTemRegistro(pTabela,pCampos,pCondicao:String):Boolean;
  function  StringSql(pValor:String):String;
  function  BuscaUltimoCodigo(pTabela,pCondicao:String):Integer;

implementation

uses
  uDados, uFormularios;

procedure InsereDados(pTabela,pCampos,pValores:String;pMostrarMensagem:Boolean=True);
var
  zqInsere:TFDQuery;
begin
  try
    zqInsere  :=  TFDQuery.Create(nil);
    with zqInsere do
    begin
      Connection  :=  DM.con1;
      if Active then
        Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO ');
      SQL.Add(pTabela);
      SQL.Add(' ( ');
      SQL.Add(pCampos);
      SQL.Add(' ) VALUES ( ');
      SQL.Add(pValores);
      SQL.Add(' ) ');
      ExecSQL;
    end;
    if pMostrarMensagem then
      MensagensSistema('Registro inserido com sucesso!');
  except
    if pMostrarMensagem then
      MensagensSistema('N?o foi poss?vel inserir o registro. Voc? deve entrar em contato com o administrado do sistema.');
    FreeAndNil(zqInsere);
  end;
  FreeAndNil(zqInsere);
end;

procedure AtualizaDados(pTabela,pValores,pCondicao:String;pMostrarMensagem:Boolean=True);
var
  zqAtualiza:TFDQuery;
begin
  try
    zqAtualiza  :=  TFDQuery.Create(nil);
    with zqAtualiza do
    begin
      Connection  :=  DM.con1;
      if Active then
        Close;
      SQL.Clear;
      SQL.Add(' UPDATE ');
      SQL.Add(pTabela);
      SQL.Add(' SET ');
      SQL.Add(pValores);
      SQL.Add(' WHERE 1=1 ');
      SQL.Add(pCondicao);
      ExecSQL;
    end;
    if pMostrarMensagem then
      MensagensSistema('Registro atualizado com sucesso!');
  except
    if pMostrarMensagem then
      MensagensSistema('N?o foi poss?vel atualizar o registro. Voc? deve entrar em contato com o administrado do sistema.');
    FreeAndNil(zqAtualiza);
  end;
  FreeAndNil(zqAtualiza);
end;

procedure ExcluirDados(pTabela,pCondicao:String;pMostrarMensagem:Boolean=True);
var
  zqApaga:TFDQuery;
begin
  try
    zqApaga  :=  TFDQuery.Create(nil);
    with zqApaga do
    begin
      Connection  :=  DM.con1;
      if Active then
        Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM ');
      SQL.Add(pTabela);
      SQL.Add(' WHERE 1=1 ');
      SQL.Add(pCondicao);
      ExecSQL;
    end;
    if pMostrarMensagem then
      MensagensSistema('Registro exclu?do com sucesso!');
  except
    if pMostrarMensagem then
      MensagensSistema('N?o foi poss?vel apagar o registro. Voc? deve entrar em contato com o administrado do sistema.');
    FreeAndNil(zqApaga);
  end;
  FreeAndNil(zqApaga);
end;

function  SqlTemRegistro(pTabela,pCampos,pCondicao:String):Boolean;
var
  zqTemOrdem:TFDQuery;
begin
  zqTemOrdem  :=  TFDQuery.Create(nil);
  try
    with zqTemOrdem do
    begin
      Connection  :=  DM.con1;
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT ' + pCampos + ' FROM '  + pTabela + ' WHERE 1=1 ' + pCondicao);
      Open; First; FetchAll;
      Result  :=  (RecordCount  >=  1);
    end;
  except
    Result  :=  False;
    FreeAndNil(zqTemOrdem);
  end;
  FreeAndNil(zqTemOrdem);
end;

procedure MensagensSistema(pMensagem:String);
begin
  ShowMessage(pMensagem);
end;

function  StringSql(pValor:String):String;
begin
  if pValor = '' then
    Result  :=  'NULL'
  else
  begin
    if Copy(pValor,Length(pValor)-1,Length(pValor)) = #$D#$A then
      pValor  :=  Copy(pValor,1,Length(pValor)-2);
    Result  :=  Chr(39) + StringReplace(pValor,Chr(39),Chr(39)+Chr(39),[rfIgnoreCase,rfReplaceAll])  + Chr(39);
    Result  :=  StringReplace(Result,'\','\\',[rfIgnoreCase,rfReplaceAll]);
  end;
end;

function  BuscaUltimoCodigo(pTabela,pCondicao:String):Integer;
var
  zqUltCod:TFDQuery;
begin
  zqUltCod  :=  TFDQuery.Create(nil);
  try
    with zqUltCod do
    begin
      Connection  :=  DM.con1;
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT MAX(ID) AS ULT FROM '  + pTabela + ' WHERE 1=1 ' + pCondicao);
      Open; First; FetchAll;
      Result  :=  FieldByName('ULT').AsInteger;
    end;
  except
    Result  :=  0;
    FreeAndNil(zqUltCod);
  end;
  FreeAndNil(zqUltCod);
end;

end.
