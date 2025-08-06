unit uovF_GestaoFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TovF_GestaoFuncionario = class(TForm)
    ovP_Chave: TPanel;
    ovP_Principal: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ovB_Novo: TButton;
    ovB_Salvar: TButton;
    ovDBE_Nome: TDBEdit;
    ovDBE_CPF: TDBEdit;
    ovDBC_Ativo: TDBCheckBox;
    ovB_Cancelar: TButton;
    ovDBE_DataAlteracao: TDBEdit;
    Label4: TLabel;
    ovE_cpf: TEdit;
    FDQ_Funcionarios: TFDQuery;
    DS_Funcionarios: TDataSource;
    FDQ_Funcionariosfnc_id: TIntegerField;
    FDQ_Funcionariosfnc_cpf: TWideStringField;
    FDQ_Funcionariosfnc_nome: TWideStringField;
    FDQ_Funcionariosfnc_ativo: TWideStringField;
    FDQ_Funcionariosupdate_at: TSQLTimeStampField;
    procedure ovB_SalvarClick(Sender: TObject);
    procedure ovB_CancelarClick(Sender: TObject);
    procedure ovB_NovoClick(Sender: TObject);
    procedure ovE_cpfExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ovDBE_CPFExit(Sender: TObject);
    procedure DS_FuncionariosDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ovF_GestaoFuncionario: TovF_GestaoFuncionario;

implementation

uses
   uDataModule, uFuncoes;
{$R *.dfm}


procedure TovF_GestaoFuncionario.DS_FuncionariosDataChange(Sender: TObject;
  Field: TField);
begin
   with FDQ_Funcionarios do
   begin
     if ( FieldByName('fnc_ativo').AsString = 'A' ) then
       ovDBC_Ativo.Caption := 'Ativo'
     else if ( FieldByName('fnc_ativo').AsString = 'I' ) then
       ovDBC_Ativo.Caption := 'Inativo';
   end;
end;

procedure TovF_GestaoFuncionario.FormCreate(Sender: TObject);
begin
  ovB_Salvar.Enabled := False;
  ovB_Cancelar.Enabled := False;

  // Define os valores do checkbox de situação
  ovDBC_Ativo.ValueChecked := 'A';
  ovDBC_Ativo.ValueUnchecked := 'I';
  ovDBC_Ativo.Caption := 'Ativo';
end;

procedure TovF_GestaoFuncionario.ovB_CancelarClick(Sender: TObject);
begin
  FDQ_Funcionarios.Cancel;
  ovE_cpf.Text := '';
  FDQ_Funcionarios.Close;
  ovB_Salvar.Enabled := False;
  ovB_Cancelar.Enabled := False;
end;

procedure TovF_GestaoFuncionario.ovB_NovoClick(Sender: TObject);
begin
  with FDQ_Funcionarios do
  begin
    if Active then Close;

    SQL.Text := 'SELECT * FROM funcionarios ';
    Open;

    Append;

    FieldByName('fnc_ativo').AsString := 'A';

    if ovDBE_Nome.CanFocus then
      ovDBE_Nome.SetFocus;
  end;

  ovE_cpf.Text := '';
  ovB_Salvar.Enabled := True;
  ovB_Cancelar.Enabled := True;
end;

procedure TovF_GestaoFuncionario.ovB_SalvarClick(Sender: TObject);
var
  CPF: string;
begin
  CPF := uFuncoes.SomenteNumeros(ovDBE_CPF.Text);

  if Trim(ovDBE_Nome.Text) = '' then
    raise Exception.Create('Nome é obrigatório.');

  if CPF = '' then
    raise Exception.Create('CPF é obrigatório.');

  if ovDBC_Ativo.Checked = False then
    if FDQ_Funcionarios.State = dsInsert then
      raise Exception.Create('Um novo funcionário não pode ser criado como inativo.');

  // Verifica se já existe o CPF no banco (somente em inserção)
  try
    if FDQ_Funcionarios.State = dsInsert then
    begin
      with ovF_DataModule.FDQuery_Temp do
      begin
        Close;
        SQL.Text := 'SELECT COUNT(*) AS total FROM funcionarios WHERE fnc_cpf = :cpf';
        ParamByName('cpf').AsString := CPF;
        Open;
        if FieldByName('total').AsInteger > 0 then
          raise Exception.Create('Já existe um funcionário com este CPF.');
      end;
    end;
  finally
    ovF_DataModule.FDQuery_Temp.Free;
  end;

  // Atualiza data de alteração
  FDQ_Funcionarios.FieldByName('update_at').AsDateTime := Now;

  FDQ_Funcionarios.Post;

  ovB_Salvar.Enabled := False;
  ovB_Cancelar.Enabled := False;
  ovB_CancelarClick(Nil);
end;

procedure TovF_GestaoFuncionario.ovDBE_CPFExit(Sender: TObject);
begin
  if (Trim(FDQ_Funcionarios.FieldByName('fnc_cpf').asString) <> '') then
    uFuncoes.ValidarCPF((FDQ_Funcionarios.FieldByName('fnc_cpf').asString));

end;

procedure TovF_GestaoFuncionario.ovE_cpfExit(Sender: TObject);
begin
  if (Trim(ovE_cpf.Text) <> '') then
  begin
    if ( uFuncoes.ValidarCPF(ovE_cpf.Text) ) then
    begin
      with FDQ_Funcionarios do
      begin
        Close;
        SQL.Text := 'SELECT * FROM funcionarios WHERE fnc_cpf = :cpf';
        ParamByName('cpf').AsString := ovE_cpf.Text;
        Open;

        if FieldByName('fnc_cpf').asString = '' then
          ovB_NovoClick(Nil);
      end;
    end;
  end;
end;

end.
