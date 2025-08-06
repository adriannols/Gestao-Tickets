object ovF_Principal: TovF_Principal
  Left = 0
  Top = 0
  Caption = 'Menu Inicial'
  ClientHeight = 231
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Calibri'
  Font.Style = [fsBold]
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 14
  object ovP_Principal: TPanel
    Left = 0
    Top = 0
    Width = 355
    Height = 231
    Align = alClient
    Caption = 'ovP_Principal'
    TabOrder = 0
    object ovB_CadastroFuncionario: TButton
      Left = 64
      Top = 24
      Width = 233
      Height = 49
      Caption = 'Gest'#227'o de Funcion'#225'rios'
      TabOrder = 0
      OnClick = ovB_CadastroFuncionarioClick
    end
    object ovB_CadastroTicket: TButton
      Left = 64
      Top = 92
      Width = 233
      Height = 49
      Caption = 'Gest'#227'o de Tickets'
      TabOrder = 1
      OnClick = ovB_CadastroTicketClick
    end
    object ovB_Relatorio: TButton
      Left = 64
      Top = 160
      Width = 233
      Height = 49
      Caption = 'Rel'#225't'#243'rio de tickets entregues'
      TabOrder = 2
      OnClick = ovB_RelatorioClick
    end
  end
end
