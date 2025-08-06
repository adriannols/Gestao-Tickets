unit uovF_GestaoTickets;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask;

type
  TovF_Tickets = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    FDQ_Tickets: TFDQuery;
    DS_Tickets: TDataSource;
    Ticket: TLabel;
    ovE_Ticket: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    label4: TLabel;
    ovDBE_Quantidade: TDBEdit;
    ovDBE_DataEntrega: TDBEdit;
    ovDBC_Ativo: TDBCheckBox;
    ovDBE_DataAlteracao: TDBEdit;
    Label1: TLabel;
    ovB_Cancelar: TButton;
    ovB_Salvar: TButton;
    ovB_Novo: TButton;
    FDQ_Ticketstck_id: TIntegerField;
    FDQ_Ticketstck_quantidade: TIntegerField;
    FDQ_Ticketstck_ativo: TWideStringField;
    FDQ_Ticketsfuncionario_id: TIntegerField;
    FDQ_Ticketsupdate_at: TSQLTimeStampField;
    ovE_cpf: TEdit;
    FDQ_Ticketscreated_at: TSQLTimeStampField;
    procedure ovB_CancelarClick(Sender: TObject);
    procedure ovE_cpfExit(Sender: TObject);
    procedure ovB_NovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DS_TicketsDataChange(Sender: TObject; Field: TField);
    procedure ovB_SalvarClick(Sender: TObject);
    procedure ovE_TicketExit(Sender: TObject);
    procedure Panel2Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ovF_Tickets: TovF_Tickets;

implementation

uses
  uDataModule, uFuncoes;

{$R *.dfm}

procedure TovF_Tickets.DS_TicketsDataChange(Sender: TObject; Field: TField);
begin
   with FDQ_Tickets do
   begin
     if ( FieldByName('tck_ativo').AsString = 'A' ) then
       ovDBC_Ativo.Caption := 'Ativo'
     else if ( FieldByName('tck_ativo').AsString = 'I' ) then
       ovDBC_Ativo.Caption := 'Inativo';
   end;
end;

procedure TovF_Tickets.FormCreate(Sender: TObject);
begin
  ovB_Salvar.Enabled := False;
  ovB_Cancelar.Enabled := False;

  // Define os valores do checkbox de situação
  ovDBC_Ativo.ValueChecked := 'A';
  ovDBC_Ativo.ValueUnchecked := 'I';
  ovDBC_Ativo.Caption := 'Ativo';
end;

procedure TovF_Tickets.ovB_CancelarClick(Sender: TObject);
begin
  FDQ_Tickets.Cancel;
  ovE_cpf.Text := '';
  FDQ_Tickets.Close;
  ovE_CPF.Text := '';
  ovB_Salvar.Enabled := False;
  ovB_Cancelar.Enabled := False;
end;

procedure TovF_Tickets.ovB_NovoClick(Sender: TObject);
begin
  with FDQ_Tickets do
  begin
    if Active then Close;

    SQL.Text := 'SELECT * FROM tickets ';
    Open;

    Append;

    FieldByName('tck_ativo').AsString := 'A';

    if ovE_cpf.CanFocus then
      ovE_cpf.SetFocus;
  end;

  ovE_Ticket.Text := '';
  ovB_Salvar.Enabled := True;
  ovB_Cancelar.Enabled := True;
end;

procedure TovF_Tickets.ovB_SalvarClick(Sender: TObject);
begin
  with FDQ_Tickets do
  begin
    if (FieldByName('tck_quantidade').AsInteger) <= 0 then
      raise Exception.Create('Quantidade deve ser no mínimo 1');

    if (FieldByName('funcionario_id').AsInteger = 0 or FieldByName('funcionario_id').AsInteger = Null) then
      raise Exception.Create('É obrigatório informar o CPF do funcionário!');

    if ovDBC_Ativo.Checked = False then
      if State = dsInsert then
        raise Exception.Create('Um novo ticket não pode ser criado como inativo.');

    // Atualiza data de alteração
    FieldByName('update_at').AsDateTime := Now;
    Post;

  end;

  ovB_Salvar.Enabled := False;
  ovB_Cancelar.Enabled := False;
  ovB_CancelarClick(Nil);
end;

procedure TovF_Tickets.ovE_cpfExit(Sender: TObject);
begin
  if (Trim(ovE_cpf.Text) <> '') then
  begin
    if ( uFuncoes.ValidarCPF(ovE_cpf.Text) ) then
    begin
      try
        with ovF_DataModule.FDQuery_Temp do
        begin
          Close;
          SQL.Text := 'SELECT * FROM funcionarios WHERE fnc_cpf = :cpf';
          ParamByName('cpf').AsString := ovE_cpf.Text;
          Open;

          if ( FieldByName('fnc_cpf').asString = '' ) then
            raise Exception.Create('Funcionário não encontrado, verifique o CPF ou realize o cadastro do funcionário!')
          else
            FDQ_Tickets.FieldByName('funcionario_id').AsInteger := FieldByName('fnc_id').AsInteger;
        end;
      finally
        ovF_DataModule.FDQuery_Temp.Free;
      end;
    end;
  end;
end;

procedure TovF_Tickets.ovE_TicketExit(Sender: TObject);
begin
  if (Trim(ovE_Ticket.Text) <> '') then
  begin
    if ( uFuncoes.BuscarTicket(StrToInt(ovE_Ticket.Text)) ) then
    begin
      with FDQ_Tickets do
      begin
        Close;
        SQL.Text := 'SELECT * FROM tickets WHERE tck_id = :id';
        ParamByName('id').AsInteger := StrToInt(ovE_Ticket.Text);
        Open;
      end;
    end else
       ovB_NovoClick(Nil);
  end;
end;

procedure TovF_Tickets.Panel2Enter(Sender: TObject);
begin
  if (ovE_Ticket.Text <> '') then
  begin
    try
      with ovF_DataModule.FDQuery_Temp do
      begin
        Close;
        SQL.Text := 'SELECT fnc_cpf FROM funcionarios WHERE fnc_id = :id';
        ParamByName('id').AsInteger := FDQ_Tickets.FieldByName('funcionario_id').AsInteger;
        Open;

        ovE_cpf.Text := FieldByName('fnc_cpf').AsString;
      end;
    finally
      ovF_DataModule.FDQuery_Temp.Free;
    end;
  end;
end;

end.
