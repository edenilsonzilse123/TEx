unit uCarregaInfos;

interface

  procedure SetarCep(pCep:String);
  procedure SetarLogradouro(pLograd:String);
  procedure SetarCidade(pCidade:String);
  procedure SetarUF(pUF:String);

  function  GetCep:String;
  function  GetLograd:String;
  function  GetCidade:String;
  function  GetUF:String;

var
 vCEP, vLogradouro, vCidade, vUF:String;

implementation

procedure SetarCep(pCep:String);
begin
  vCEP  :=  pCep;
end;

procedure SetarLogradouro(pLograd:String);
begin
  vLogradouro :=  pLograd;
end;

procedure SetarCidade(pCidade:String);
begin
  vCidade :=  pCidade;
end;

procedure SetarUF(pUF:String);
begin
  vUF :=  pUF;
end;

function  GetCep:String;
begin
  Result  :=  vCEP;
end;

function  GetLograd:String;
begin
  Result  :=  vLogradouro;
end;

function  GetCidade:String;
begin
  Result  :=  vCidade;
end;

function  GetUF:String;
begin
  Result  :=  vUF;
end;

end.
