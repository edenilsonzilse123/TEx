unit uCadastrarPessoas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,JSON,
  ACBrBase, ACBrSocket, ACBrCEP, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList,
  Vcl.Buttons, MidasLib;

type
  TfrmCadastrarPessoas = class(TForm)
    lbledtNomePessoa: TLabeledEdit;
    qryEnderecos: TFDQuery;
    dsEnderecos: TDataSource;
    fdtncfldEnderecosid: TFDAutoIncField;
    dtmfldEnderecosdt_cadastro: TDateTimeField;
    dtmfldEnderecosdt_atualizacao: TDateTimeField;
    cdsEnderecosid_cliente: TIntegerField;
    cdsEnderecoscep: TStringField;
    cdsEnderecosendereco: TStringField;
    cdsEnderecoscidade: TStringField;
    cdsEnderecosuf: TStringField;
    btnAdicEndereco: TButton;
    cdsEnderecos: TClientDataSet;
    cdsEnderecosIdCliente: TIntegerField;
    cdsEnderecosCep2: TStringField;
    cdsEnderecosEndereco2: TStringField;
    cdsEnderecosCidade2: TStringField;
    cdsEnderecosUF2: TStringField;
    qryPessoa: TFDQuery;
    fdtncfldPessoaid: TFDAutoIncField;
    dtmfldPessoadt_cadastro: TDateTimeField;
    dtmfldPessoadt_atualizacao: TDateTimeField;
    cdsPessoanome_pessoa: TStringField;
    pnlLista: TPanel;
    pnlBotoes: TPanel;
    dbgrdListaEnderecos: TDBGrid;
    ilCadPess: TImageList;
    actlstCadPess: TActionList;
    actNovo: TAction;
    actSave: TAction;
    actCancel: TAction;
    actDelete: TAction;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnCancel: TBitBtn;
    btnExcluir: TBitBtn;
    cdsEnderecosId: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CarregarEnderecos;
    procedure btnAdicEnderecoClick(Sender: TObject);
    procedure CarregarPessoa(pPessoa:Integer);
    procedure actNovoExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure AddEndereco(pEditar:Boolean;vPessoa,vID:Integer);
    procedure dbgrdListaEnderecosDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastrarPessoas: TfrmCadastrarPessoas;
  vCodPessoa, vIdEndereco:Integer;
  vMarcaBook:TBookmark;

const
  cSqlBuscaEnderecos:String=' SELECT * FROM TB_ENDERECOS WHERE 1=1 ';
  cSqlBuscaPessoas:String=' SELECT * FROM TB_PESSOAS WHERE 1=1 ';

implementation

uses
  uDadosFuncoes, uDados, uAddEnd, uFormularios, uCarregaInfos;

{$R *.dfm}

procedure TfrmCadastrarPessoas.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastrarPessoas.actDeleteExecute(Sender: TObject);
begin
  if Application.MessageBox('Deseja mesmo incluir este registro?', PChar(Application.Title),
    MB_YESNO + MB_ICONQUESTION) = IDYES then
    ExcluirDados('TB_ENDERECOS',' AND ID = '      +
                 cdsEnderecosId.AsString);
  CarregarEnderecos;
end;

procedure TfrmCadastrarPessoas.actNovoExecute(Sender: TObject);
begin
  vCodPessoa  :=  0;
  lbledtNomePessoa.Clear;
  cdsEnderecos.EmptyDataSet;
end;

procedure TfrmCadastrarPessoas.actSaveExecute(Sender: TObject);
var
  vCampos,vValores:String;
begin
  vCampos     :=  EmptyStr;
  vValores    :=  EmptyStr;
  if vCodPessoa = 0 then
  begin
    vCampos     :=  vCampos   + 'NOME_PESSOA';
    vValores    :=  vValores  + StringSql(lbledtNomePessoa.Text);
    InsereDados('TB_PESSOAS',vCampos,vValores,False);
    vCodPessoa  :=  BuscaUltimoCodigo('TB_PESSOAS','');
  end
  else
  begin
    vValores  :=  vValores  + 'NOME_PESSOA = '  + StringSql(lbledtNomePessoa.Text);
    AtualizaDados('TB_PESSOAS',vValores,' AND ID = '  + IntToStr(vCodPessoa),False);
  end;
  cdsEnderecos.First;
  if cdsEnderecos.RecordCount >= 1 then
  begin
    while not cdsEnderecos.Eof do
    begin
      vCampos     :=  EmptyStr;
      vValores    :=  EmptyStr;
      if (cdsEnderecosId.AsInteger = 0) then
      begin
        vCampos   :=  vCampos   + 'ID_CLIENTE,CEP,ENDERECO,CIDADE,UF';
        vValores  :=  vValores  + IntToStr(vCodPessoa)                      + ',';
        vValores  :=  vValores  + StringSql(cdsEnderecosCep2.AsString)      + ',';
        vValores  :=  vValores  + StringSql(cdsEnderecosEndereco2.AsString) + ',';
        vValores  :=  vValores  + StringSql(cdsEnderecosCidade2.AsString)   + ',';
        vValores  :=  vValores  + StringSql(cdsEnderecosUF2.AsString)            ;
        InsereDados('TB_ENDERECOS',vCampos,vValores,False);
      end
      else
      begin
        vValores  :=  vValores  + 'ID_CLIENTE = '               +
                      StringSql(cdsEnderecosIdCliente.AsString) + ',' ;
        vValores  :=  vValores  + 'CEP = '                      +
                      StringSql(cdsEnderecosCep2.AsString)      + ',' ;
        vValores  :=  vValores  + 'ENDERECO = '                 +
                      StringSql(cdsEnderecosEndereco2.AsString) + ',' ;
        vValores  :=  vValores  + 'CIDADE = '                   +
                      StringSql(cdsEnderecosCidade2.AsString)   + ',' ;
        vValores  :=  vValores  + 'UF = '                       +
                      StringSql(cdsEnderecosUF2.AsString)             ;
        AtualizaDados('TB_ENDERECOS',vValores,' AND ID = '      +
                      cdsEnderecosId.AsString,False);
      end;
      cdsEnderecos.Next;
    end;
  end;
  CarregarEnderecos;
  MensagensSistema('Cadastros inseridos/atualizados com sucesso!');
end;

procedure TfrmCadastrarPessoas.AddEndereco(pEditar: Boolean; vPessoa,
  vID: Integer);
begin
  with cdsEnderecos do
  begin
    if (not pEditar) then
      Append
    else
      Edit;
    cdsEnderecosIdCliente.AsInteger :=  vPessoa;
    cdsEnderecosCep2.AsString       :=  GetCep;
    cdsEnderecosEndereco2.AsString  :=  GetLograd;
    cdsEnderecosCidade2.AsString    :=  GetCidade;
    cdsEnderecosUF2.AsString        :=  GetUF;
    cdsEnderecosId.AsInteger        :=  vID;
    Post;
  end;
end;

procedure TfrmCadastrarPessoas.btnAdicEnderecoClick(Sender: TObject);
begin
  CriarForm(TfrmAddEnd, frmAddEnd,'Cadastrar enderešos');
  if (not (cdsEnderecos.Active)) then
    CriarDataSetClient(cdsEnderecos);
  AddEndereco(False,vCodPessoa,0);
end;

procedure TfrmCadastrarPessoas.CarregarEnderecos;
begin
  with qryEnderecos do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(cSqlBuscaEnderecos  + ' AND ID_CLIENTE = '  + IntToStr(vCodPessoa));
    Open; First; FetchAll;
    CriarDataSetClient(cdsEnderecos);
    while not Eof do
    begin
      cdsEnderecos.Append;
      cdsEnderecosIdCliente.AsInteger :=  vCodPessoa;
      cdsEnderecosCep2.AsString       :=  FieldByName('cep').AsString;
      cdsEnderecosEndereco2.AsString  :=  FieldByName('endereco').AsString;;
      cdsEnderecosCidade2.AsString    :=  FieldByName('cidade').AsString;;
      cdsEnderecosUF2.AsString        :=  FieldByName('uf').AsString;;
      cdsEnderecosId.AsInteger        :=  FieldByName('id').AsInteger;
      cdsEnderecos.Post;
      Next;
    end;
  end;
end;

procedure TfrmCadastrarPessoas.CarregarPessoa(pPessoa: Integer);
begin
  with qryPessoa do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add(cSqlBuscaPessoas  + ' AND ID = '  + IntToStr(pPessoa));
    Open; First; FetchAll;
    lbledtNomePessoa.Text :=  FieldByName('NOME_PESSOA').AsString;
    vCodPessoa            :=  FieldByName('ID').AsInteger;
    CarregarEnderecos;
  end;
end;

procedure TfrmCadastrarPessoas.dbgrdListaEnderecosDblClick(Sender: TObject);
begin
  CriarForm(TfrmAddEnd, frmAddEnd,'Cadastrar enderešos',False);
  vIdEndereco :=  cdsEnderecosId.AsInteger;
  vMarcaBook  :=  cdsEnderecos.GetBookmark;
  SetarCep(cdsEnderecosCep2.AsString);
  SetarLogradouro(cdsEnderecosEndereco2.AsString);
  SetarCidade(cdsEnderecosCidade2.AsString);
  SetarUF(cdsEnderecosUF2.AsString);
  frmAddEnd.CarregarEndereco;
  frmAddEnd.ShowModal;
  cdsEnderecos.First;
  while not cdsEnderecos.Eof do
  begin
    if (cdsEnderecosId.AsInteger = vIdEndereco) then
      AddEndereco(True,vCodPessoa,vIdEndereco);
    cdsEnderecos.Next;
  end;
  cdsEnderecos.GotoBookmark(vMarcaBook);
end;

procedure TfrmCadastrarPessoas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action              :=  TCloseAction.caFree;
  frmCadastrarPessoas :=  nil;
end;

end.
