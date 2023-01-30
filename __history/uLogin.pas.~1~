unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg;

type
  TfrmLogin = class(TForm)
    lbledtLogin: TLabeledEdit;
    imgLogin: TImage;
    lbledtSenha: TLabeledEdit;
    chkMostrarSenha: TCheckBox;
    btnLogin: TButton;
    btnCancelar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure chkMostrarSenhaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  uFormularios;

var
  vFechaSistema:Boolean;

{$R *.dfm}

procedure TfrmLogin.btnCancelarClick(Sender: TObject);
begin
  vFechaSistema :=  True;
  Close;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  if Logado(lbledtLogin.Text,lbledtSenha.Text) then
  begin
    vFechaSistema :=  False;
    Close;
  end;
end;

procedure TfrmLogin.chkMostrarSenhaClick(Sender: TObject);
begin
  lbledtSenha.PasswordChar  :=  GetMostrarSenha(chkMostrarSenha.Checked,#0,'*');
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  vFechaSistema :=  True;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if vFechaSistema then
    Application.Terminate;
  Action    :=  TCloseAction.caFree;
  frmLogin  :=  nil;
end;

end.
