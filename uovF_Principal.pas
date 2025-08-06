unit uovF_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uDataModule, uovF_GestaoFuncionario, uovF_GestaoTickets,
  uovF_RelatorioTickets;

type
  TovF_Principal = class(TForm)
    ovB_CadastroFuncionario: TButton;
    ovB_CadastroTicket: TButton;
    ovB_Relatorio: TButton;
    ovP_Principal: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ovB_CadastroFuncionarioClick(Sender: TObject);
    procedure ovB_CadastroTicketClick(Sender: TObject);
    procedure ovB_RelatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ovF_Principal: TovF_Principal;

implementation

{$R *.dfm}

procedure TovF_Principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   ovF_DataModule.Free;
end;

procedure TovF_Principal.FormCreate(Sender: TObject);
begin
   ovF_DataModule := TovF_DataModule.Create(Nil);
end;

procedure TovF_Principal.ovB_CadastroFuncionarioClick(Sender: TObject);
var
   FormFuncionario: TovF_GestaoFuncionario;
begin
   FormFuncionario := TovF_GestaoFuncionario.Create(Self);
   try
      FormFuncionario.ShowModal;
   finally
      FormFuncionario.Free;
   end;
end;

procedure TovF_Principal.ovB_CadastroTicketClick(Sender: TObject);
var
   FormTickets: TovF_Tickets;
begin
   FormTickets := TovF_Tickets.Create(Self);
   try
      FormTickets.ShowModal;
   finally
      FormTickets.Free;
   end;
end;

procedure TovF_Principal.ovB_RelatorioClick(Sender: TObject);
var
   FormRelatorio: TovF_Relatorio;
begin
   FormRelatorio := TovF_Relatorio.Create(Self);
   try
      FormRelatorio.ShowModal;
   finally
      FormRelatorio.Free;
   end;
end;

end.
