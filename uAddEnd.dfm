object frmAddEnd: TfrmAddEnd
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'frmAddEnd'
  ClientHeight = 159
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbledtCep: TLabeledEdit
    Left = 8
    Top = 19
    Width = 65
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'CEP'
    MaxLength = 9
    TabOrder = 0
  end
  object btnBuscar: TButton
    Left = 79
    Top = 17
    Width = 50
    Height = 25
    Caption = 'Buscar'
    TabOrder = 1
    OnClick = btnBuscarClick
  end
  object lbledtLograd: TLabeledEdit
    Left = 8
    Top = 58
    Width = 473
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 13
    EditLabel.Caption = 'Logradouro'
    TabOrder = 2
  end
  object lbledtCidade: TLabeledEdit
    Left = 8
    Top = 98
    Width = 377
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Cidade'
    TabOrder = 3
  end
  object lbledtUF: TLabeledEdit
    Left = 391
    Top = 98
    Width = 90
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'UF'
    TabOrder = 4
  end
  object btnAdicionar: TButton
    Left = 8
    Top = 126
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 5
    OnClick = btnAdicionarClick
  end
  object acbrcp1: TACBrCEP
    ProxyPort = '8080'
    PesquisarIBGE = True
    Left = 448
    Top = 8
  end
end
