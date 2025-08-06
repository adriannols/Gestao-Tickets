object ovF_Tickets: TovF_Tickets
  Left = 0
  Top = 0
  Caption = 'Gest'#227'o Tickets - Gera'#231#227'o e edi'#231#227'o de Tickets'
  ClientHeight = 236
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Calibri'
  Font.Style = [fsBold]
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 433
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 505
    object Ticket: TLabel
      Left = 24
      Top = 13
      Width = 33
      Height = 14
      Caption = 'Ticket:'
    end
    object ovE_Ticket: TEdit
      Left = 134
      Top = 13
      Width = 47
      Height = 22
      NumbersOnly = True
      TabOrder = 0
      OnExit = ovE_TicketExit
    end
    object ovB_Novo: TButton
      Left = 200
      Top = 10
      Width = 67
      Height = 25
      Caption = 'Novo'
      TabOrder = 1
      OnClick = ovB_NovoClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 433
    Height = 195
    Align = alClient
    TabOrder = 1
    OnEnter = Panel2Enter
    ExplicitTop = 38
    ExplicitWidth = 505
    ExplicitHeight = 263
    object Label2: TLabel
      Left = 24
      Top = 14
      Width = 21
      Height = 14
      Caption = 'CPF:'
    end
    object Label3: TLabel
      Left = 24
      Top = 45
      Width = 60
      Height = 14
      Caption = 'Quantidade:'
    end
    object label4: TLabel
      Left = 24
      Top = 77
      Width = 68
      Height = 14
      Caption = 'Data Entrega:'
    end
    object Label1: TLabel
      Left = 24
      Top = 135
      Width = 98
      Height = 14
      Caption = 'Data '#218'lt. Altera'#231#227'o:'
    end
    object ovDBE_Quantidade: TDBEdit
      Left = 94
      Top = 42
      Width = 87
      Height = 22
      DataField = 'tck_quantidade'
      DataSource = DS_Tickets
      TabOrder = 1
    end
    object ovDBE_DataEntrega: TDBEdit
      Left = 94
      Top = 74
      Width = 123
      Height = 22
      TabStop = False
      DataField = 'created_at'
      DataSource = DS_Tickets
      ReadOnly = True
      TabOrder = 2
    end
    object ovDBC_Ativo: TDBCheckBox
      Left = 94
      Top = 109
      Width = 87
      Height = 17
      Caption = 'Ativo'
      DataField = 'tck_ativo'
      DataSource = DS_Tickets
      TabOrder = 3
    end
    object ovDBE_DataAlteracao: TDBEdit
      Left = 128
      Top = 132
      Width = 121
      Height = 22
      TabStop = False
      DataField = 'update_at'
      DataSource = DS_Tickets
      ReadOnly = True
      TabOrder = 4
    end
    object ovB_Cancelar: TButton
      Left = 279
      Top = 166
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 6
      OnClick = ovB_CancelarClick
    end
    object ovB_Salvar: TButton
      Left = 358
      Top = 166
      Width = 67
      Height = 25
      Caption = 'Salvar'
      TabOrder = 5
      OnClick = ovB_SalvarClick
    end
    object ovE_cpf: TEdit
      Left = 94
      Top = 11
      Width = 87
      Height = 22
      NumbersOnly = True
      TabOrder = 0
      OnExit = ovE_cpfExit
    end
  end
  object FDQ_Tickets: TFDQuery
    Connection = ovF_DataModule.FDConnection1
    SQL.Strings = (
      'select * from tickets')
    Left = 328
    object FDQ_Ticketstck_id: TIntegerField
      FieldName = 'tck_id'
      Origin = 'tck_id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQ_Ticketstck_quantidade: TIntegerField
      FieldName = 'tck_quantidade'
      Origin = 'tck_quantidade'
    end
    object FDQ_Ticketstck_ativo: TWideStringField
      FieldName = 'tck_ativo'
      Origin = 'tck_ativo'
      FixedChar = True
      Size = 1
    end
    object FDQ_Ticketsfuncionario_id: TIntegerField
      FieldName = 'funcionario_id'
      Origin = 'funcionario_id'
    end
    object FDQ_Ticketsupdate_at: TSQLTimeStampField
      FieldName = 'update_at'
      Origin = 'update_at'
      ProviderFlags = [pfInUpdate]
    end
    object FDQ_Ticketscreated_at: TSQLTimeStampField
      FieldName = 'created_at'
      Origin = 'created_at'
      ProviderFlags = [pfInUpdate]
    end
  end
  object DS_Tickets: TDataSource
    DataSet = FDQ_Tickets
    OnDataChange = DS_TicketsDataChange
    Left = 384
  end
end
