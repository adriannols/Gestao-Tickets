object ovF_Relatorio: TovF_Relatorio
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Tickets Entregues'
  ClientHeight = 271
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Calibri'
  Font.Style = [fsBold]
  Position = poDesktopCenter
  OnShow = FormShow
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 535
    Height = 35
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 536
    object Label1: TLabel
      Left = 1
      Top = 10
      Width = 21
      Height = 14
      Caption = 'CPF:'
    end
    object label2: TLabel
      Left = 114
      Top = 10
      Width = 59
      Height = 14
      Caption = 'Data Inicial:'
    end
    object Label3: TLabel
      Left = 279
      Top = 10
      Width = 53
      Height = 14
      Caption = 'Data Final:'
    end
    object ovE_cpf: TEdit
      Left = 25
      Top = 7
      Width = 73
      Height = 22
      TabOrder = 0
      OnExit = ovE_cpfExit
    end
    object ovB_Carregar: TButton
      Left = 452
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Carregar'
      TabOrder = 1
      OnClick = ovB_CarregarClick
    end
    object ovDTP_DataInicial: TDateTimePicker
      Left = 176
      Top = 7
      Width = 99
      Height = 22
      Date = 45875.000000000000000000
      Time = 0.486765474539424800
      ShowCheckbox = True
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 35
    Width = 535
    Height = 236
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 536
    object Label4: TLabel
      Left = 0
      Top = 210
      Width = 128
      Height = 14
      Caption = 'Total de Tickes Entregues:'
    end
    object ovL_Total: TLabel
      Left = 137
      Top = 210
      Width = 6
      Height = 14
      Caption = '0'
    end
    object ovDBG_Dados: TDBGrid
      Left = 1
      Top = 1
      Width = 533
      Height = 203
      Align = alTop
      DataSource = DS_Relatorios
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Calibri'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'fnc_nome'
          ReadOnly = True
          Title.Caption = 'Nome'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fnc_cpf'
          ReadOnly = True
          Title.Caption = 'CPF'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tck_id'
          ReadOnly = True
          Title.Caption = 'Ticket'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tck_quantidade'
          ReadOnly = True
          Title.Caption = 'Quantidade'
          Visible = True
        end>
    end
  end
  object ovDTP_DataFinal: TDateTimePicker
    Left = 335
    Top = 7
    Width = 101
    Height = 22
    Date = 45875.000000000000000000
    Time = 0.486765474539424800
    ShowCheckbox = True
    TabOrder = 2
  end
  object FDQ_Relatorio: TFDQuery
    Connection = ovF_DataModule.FDConnection1
    SQL.Strings = (
      'select fnc_id, '
      '       fnc_cpf, '
      '       fnc_nome, '
      '       tck_id, '
      '       tck_quantidade'
      'from tickets tck'
      'inner join funcionarios fnc on fnc.fnc_id = tck.funcionario_id')
    Left = 368
    Top = 219
    object FDQ_Relatoriofnc_cpf: TWideStringField
      FieldName = 'fnc_cpf'
      Origin = 'fnc_cpf'
      Size = 11
    end
    object FDQ_Relatoriofnc_nome: TWideStringField
      FieldName = 'fnc_nome'
      Origin = 'fnc_nome'
      Size = 50
    end
    object FDQ_Relatoriotck_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'tck_id'
      Origin = 'tck_id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQ_Relatoriotck_quantidade: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'tck_quantidade'
      Origin = 'tck_quantidade'
    end
  end
  object DS_Relatorios: TDataSource
    DataSet = FDQ_Relatorio
    Left = 448
    Top = 219
  end
end
