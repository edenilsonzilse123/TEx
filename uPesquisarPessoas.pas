unit uPesquisarPessoas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmPesquisarPessoas = class(TForm)
    dbgrdListarPessoas: TDBGrid;
    pnlBotoes: TPanel;
    qryPesquisa: TFDQuery;
    fdtncfldPesquisaid: TFDAutoIncField;
    dtmfldPesquisadt_cadastro: TDateTimeField;
    dtmfldPesquisadt_atualizacao: TDateTimeField;
    cdsPesquisanome_pessoa: TStringField;
    dsPesquisa: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgrdListarPessoasDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisarPessoas: TfrmPesquisarPessoas;

implementation

uses
  uDados, uFormularios, uCadastrarPessoas;

{$R *.dfm}

procedure TfrmPesquisarPessoas.dbgrdListarPessoasDblClick(Sender: TObject);
begin
  CriarForm(TfrmCadastrarPessoas, frmCadastrarPessoas,'Cadastrar pessoas',False);
  frmCadastrarPessoas.CarregarPessoa(fdtncfldPesquisaid.AsInteger);
  frmCadastrarPessoas.ShowModal;
end;

procedure TfrmPesquisarPessoas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action              :=  TCloseAction.caFree;
  frmPesquisarPessoas :=  nil;
end;

end.
