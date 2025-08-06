program Tickets;

uses
  Vcl.Forms,
  uovF_Principal in 'uovF_Principal.pas' {ovF_Principal},
  uovF_GestaoFuncionario in 'uovF_GestaoFuncionario.pas' {ovF_GestaoFuncionario},
  uDataModule in 'uDataModule.pas' {ovF_DataModule: TDataModule},
  uovF_GestaoTickets in 'uovF_GestaoTickets.pas' {ovF_Tickets},
  uFuncoes in 'uFuncoes.pas',
  uovF_RelatorioTickets in 'uovF_RelatorioTickets.pas' {ovF_Relatorio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TovF_Principal, ovF_Principal);
  Application.CreateForm(TovF_GestaoFuncionario, ovF_GestaoFuncionario);
  Application.CreateForm(TovF_DataModule, ovF_DataModule);
  Application.CreateForm(TovF_Tickets, ovF_Tickets);
  Application.CreateForm(TovF_Relatorio, ovF_Relatorio);
  Application.Run;
end.
