unit uAddEnd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrBase, ACBrSocket, ACBrCEP,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmAddEnd = class(TForm)
    acbrcp1: TACBrCEP;
    lbledtCep: TLabeledEdit;
    btnBuscar: TButton;
    lbledtLograd: TLabeledEdit;
    lbledtCidade: TLabeledEdit;
    lbledtUF: TLabeledEdit;
    btnAdicionar: TButton;
    procedure CarregarCep;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CarregarEndereco;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddEnd: TfrmAddEnd;

implementation

uses
  uCarregaInfos;

{$R *.dfm}

procedure TfrmAddEnd.btnAdicionarClick(Sender: TObject);
begin
  SetarCep(lbledtCep.Text);
  SetarLogradouro(lbledtLograd.Text);
  SetarCidade(lbledtCidade.Text);
  SetarUF(lbledtUF.Text);
  Close;
end;

procedure TfrmAddEnd.btnBuscarClick(Sender: TObject);
begin
  CarregarCep;
end;

procedure TfrmAddEnd.CarregarCep;
var
  x:Integer;
begin
  acbrcp1.WebService  :=  wsViaCep;
  for x := 0 to acbrcp1.BuscarPorCEP(lbledtCep.Text) - 1 do
  begin
    lbledtLograd.Text :=  acbrcp1.Enderecos[x].Logradouro;
    lbledtCidade.Text :=  acbrcp1.Enderecos[x].Municipio;
    lbledtUF.Text     :=  acbrcp1.Enderecos[x].UF;
  end;
end;

procedure TfrmAddEnd.CarregarEndereco;
begin
  lbledtCep.Text    :=  GetCep;
  lbledtLograd.Text :=  GetLograd;
  lbledtCidade.Text :=  GetCidade;
  lbledtUF.Text     :=  GetUF;
end;

procedure TfrmAddEnd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action    :=  TCloseAction.caFree;
  frmAddEnd :=  nil;
end;

end.
