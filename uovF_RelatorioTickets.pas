unit uovF_RelatorioTickets;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls;

type
  TovF_Relatorio = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ovE_cpf: TEdit;
    ovB_Carregar: TButton;
    ovDBG_Dados: TDBGrid;
    Label1: TLabel;
    label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ovL_Total: TLabel;
    FDQ_Relatorio: TFDQuery;
    DS_Relatorios: TDataSource;
    FDQ_Relatoriofnc_cpf: TWideStringField;
    FDQ_Relatoriofnc_nome: TWideStringField;
    FDQ_Relatoriotck_id: TIntegerField;
    FDQ_Relatoriotck_quantidade: TIntegerField;
    ovDTP_DataInicial: TDateTimePicker;
    ovDTP_DataFinal: TDateTimePicker;
    procedure ovE_cpfExit(Sender: TObject);
    procedure ovB_CarregarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ovF_Relatorio: TovF_Relatorio;

implementation

uses
  uDataModule, uFuncoes;

{$R *.dfm}

procedure TovF_Relatorio.FormShow(Sender: TObject);
begin
   ovDTP_DataFinal.Checked   := False;
   ovDTP_DataInicial.Checked := False;

end;

procedure TovF_Relatorio.ovB_CarregarClick(Sender: TObject);
var
  vSQL : String;
  vFiltro : String;
  MyClass: TFDQuery;
begin
  vSQL := '';
  vFiltro := ' where 1 = 1';
  with FDQ_Relatorio do
  begin
    Close;
    vSQL := ' select fnc_id, fnc_cpf, fnc_nome, tck_id, tck_quantidade '+
            '   from tickets '+
            '  inner join funcionarios on funcionarios.fnc_id = tickets.funcionario_id ';

    if ovE_cpf.Text <> '' then
       vFiltro := vFiltro + ' and funcionarios.fnc_cpf = '+(QuotedStr(ovE_cpf.Text));

    if ovDTP_DataInicial.Checked then
       vFiltro := vFiltro + ' and tickets.created_at => '+QuotedStr(DateToStr(ovDTP_DataInicial.Date));
    if ovDTP_DataFinal.Checked then
       vFiltro := vFiltro + ' and tickets.created_at <= '+QuotedStr(DateToStr(ovDTP_DataFinal.Date));

    SQL.Text := vSQL + vFiltro;

    Open;
    try
      try
        ovF_DataModule.FDQuery_Temp.Close;
        ovF_DataModule.FDQuery_Temp.SQL.Add( ' select sum(tck_quantidade) from tickets '+
                                           ' inner join funcionarios on funcionarios.fnc_id = tickets.funcionario_id '+vFiltro);
        ovF_DataModule.FDQuery_Temp.Open;

        if ovF_DataModule.FDQuery_Temp.Fields[0].Value <> 0 then

       if ovF_DataModule.FDQuery_Temp.Fields[0].Value <> 0 then
         ovL_Total.Caption := IntToStr(ovF_DataModule.FDQuery_Temp.Fields[0].Value);
      except
        ovL_Total.Caption := '0';
      end;
    finally
      ovF_DataModule.FDQuery_Temp.Free;
    end;
  end;
end;

procedure TovF_Relatorio.ovE_cpfExit(Sender: TObject);
begin
  if (Trim(ovE_cpf.Text) <> '') then
    uFuncoes.ValidarCPF(ovE_cpf.Text);
end;

end.
