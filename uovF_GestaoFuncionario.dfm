object ovF_GestaoFuncionario: TovF_GestaoFuncionario
  Left = 0
  Top = 0
  Caption = 'Gest'#227'o de Colaborador - Manuten'#231#227'o e Cadastro'
  ClientHeight = 222
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Calibri'
  Font.Style = [fsBold]
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 14
  object ovP_Chave: TPanel
    Left = 0
    Top = 0
    Width = 432
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 13
      Width = 21
      Height = 14
      Caption = 'CPF:'
    end
    object ovB_Novo: TButton
      Left = 200
      Top = 9
      Width = 67
      Height = 25
      Caption = 'Novo'
      TabOrder = 0
      OnClick = ovB_NovoClick
    end
    object ovE_cpf: TEdit
      Left = 67
      Top = 10
      Width = 121
      Height = 22
      NumbersOnly = True
      TabOrder = 1
      OnExit = ovE_cpfExit
    end
  end
  object ovP_Principal: TPanel
    Left = 0
    Top = 41
    Width = 432
    Height = 181
    Align = alClient
    TabOrder = 1
    object Label2: TLabel
      Left = 40
      Top = 29
      Width = 33
      Height = 14
      Caption = 'Nome:'
    end
    object Label3: TLabel
      Left = 40
      Top = 61
      Width = 21
      Height = 14
      Caption = 'CPF:'
    end
    object Label4: TLabel
      Left = 40
      Top = 120
      Width = 98
      Height = 14
      Caption = 'Data '#218'lt. Altera'#231#227'o:'
    end
    object ovB_Salvar: TButton
      Left = 358
      Top = 150
      Width = 67
      Height = 25
      Caption = 'Salvar'
      TabOrder = 4
      OnClick = ovB_SalvarClick
    end
    object ovDBE_Nome: TDBEdit
      Left = 79
      Top = 26
      Width = 346
      Height = 22
      DataField = 'fnc_nome'
      DataSource = DS_Funcionarios
      TabOrder = 0
    end
    object ovDBE_CPF: TDBEdit
      Left = 79
      Top = 58
      Width = 121
      Height = 22
      DataField = 'fnc_cpf'
      DataSource = DS_Funcionarios
      TabOrder = 1
      OnExit = ovDBE_CPFExit
    end
    object ovDBC_Ativo: TDBCheckBox
      Left = 79
      Top = 92
      Width = 50
      Height = 17
      Caption = 'Ativo'
      DataField = 'fnc_ativo'
      DataSource = DS_Funcionarios
      TabOrder = 2
      ValueChecked = 'A'
      ValueUnchecked = 'I'
    end
    object ovB_Cancelar: TButton
      Left = 279
      Top = 150
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 5
      OnClick = ovB_CancelarClick
    end
    object ovDBE_DataAlteracao: TDBEdit
      Left = 144
      Top = 117
      Width = 121
      Height = 22
      TabStop = False
      DataField = 'update_at'
      DataSource = DS_Funcionarios
      ReadOnly = True
      TabOrder = 3
    end
  end
  object FDQ_Funcionarios: TFDQuery
    Connection = ovF_DataModule.FDConnection1
    SQL.Strings = (
      'select * from funcionarios'
      '')
    Left = 296
    Top = 8
    object FDQ_Funcionariosfnc_id: TIntegerField
      FieldName = 'fnc_id'
      Origin = 'fnc_id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDQ_Funcionariosfnc_cpf: TWideStringField
      FieldName = 'fnc_cpf'
      Origin = 'fnc_cpf'
      Size = 11
    end
    object FDQ_Funcionariosfnc_nome: TWideStringField
      FieldName = 'fnc_nome'
      Origin = 'fnc_nome'
      Size = 50
    end
    object FDQ_Funcionariosfnc_ativo: TWideStringField
      FieldName = 'fnc_ativo'
      Origin = 'fnc_ativo'
      FixedChar = True
      Size = 1
    end
    object FDQ_Funcionariosupdate_at: TSQLTimeStampField
      FieldName = 'update_at'
      Origin = 'update_at'
      ProviderFlags = [pfInUpdate]
    end
  end
  object DS_Funcionarios: TDataSource
    DataSet = FDQ_Funcionarios
    OnDataChange = DS_FuncionariosDataChange
    Left = 360
    Top = 8
  end
end
