unit uDadosFuncoes;

interface

uses
  System.SysUtils, System.Classes, ZAbstractConnection, ZConnection, ZDataset,
  Data.DB;

  procedure InsereDados(pTabela,pCampos,pValores:String;pMostrarMensagem:Boolean=True);
  procedure AtualizaDados(pTabela,pValores,pCondicao:String;pMostrarMensagem:Boolean=True);
  procedure ExcluirDados(pTabela,pCondicao:String;pMostrarMensagem:Boolean=True);

  function  SqlTemRegistro(pTabela,pCampos,pCondicao:String):Boolean;
  function  ObtemUltimoCodigo(pTabela,pCondicao:String):Integer;

implementation

uses
  uDados, uFormularios;

procedure InsereDados(pTabela,pCampos,pValores:String;pMostrarMensagem:Boolean=True);
var
  zqInsere:TZQuery;
begin
  try
    zqInsere  :=  TZQuery.Create(nil);
    with zqInsere do
    begin
      Connection  :=  DM.conDados;
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
      MensagensSistema(2,'Registro inserido com sucesso!');
  except
    if pMostrarMensagem then
      MensagensSistema(2,'Não foi possível inserir o registro. Você deve entrar em contato com o administrado do sistema.');
    FreeAndNil(zqInsere);
  end;
  FreeAndNil(zqInsere);
end;

procedure AtualizaDados(pTabela,pValores,pCondicao:String;pMostrarMensagem:Boolean=True);
var
  zqAtualiza:TZQuery;
begin
  try
    zqAtualiza  :=  TZQuery.Create(nil);
    with zqAtualiza do
    begin
      Connection  :=  DM.conDados;
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
      MensagensSistema(2,'Registro atualizado com sucesso!');
  except
    if pMostrarMensagem then
      MensagensSistema(2,'Não foi possível atualizar o registro. Você deve entrar em contato com o administrado do sistema.');
    FreeAndNil(zqAtualiza);
  end;
  FreeAndNil(zqAtualiza);
end;

procedure ExcluirDados(pTabela,pCondicao:String;pMostrarMensagem:Boolean=True);
var
  zqApaga:TZQuery;
begin
  try
    zqApaga  :=  TZQuery.Create(nil);
    with zqApaga do
    begin
      Connection  :=  DM.conDados;
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
      MensagensSistema(2,'Registro excluído com sucesso!');
  except
    if pMostrarMensagem then
      MensagensSistema(2,'Não foi possível apagar o registro. Você deve entrar em contato com o administrado do sistema.');
    FreeAndNil(zqApaga);
  end;
  FreeAndNil(zqApaga);
end;

function  SqlTemRegistro(pTabela,pCampos,pCondicao:String):Boolean;
var
  zqTemOrdem:TZQuery;
begin
  zqTemOrdem  :=  TZQuery.Create(nil);
  try
    with zqTemOrdem do
    begin
      Connection  :=  DM.conDados;
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

function  ObtemUltimoCodigo(pTabela,pCondicao:String):Integer;
var
  zqCodigo:TZQuery;
begin
  Result    :=  0;
  zqCodigo  :=  TZQuery.Create(nil);
  try
    with zqCodigo do
    begin
      Connection  :=  DM.conDados;
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT MAX(ID) AS MAXIMO FROM '  + pTabela + ' WHERE 1=1 ' + pCondicao);
      Open; First; FetchAll;
      Result  :=  FieldByName('MAXIMO').AsInteger;
    end;
  except
    FreeAndNil(zqCodigo);
  end;
  FreeAndNil(zqCodigo);
end;

end.
