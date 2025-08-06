unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.PGDef, FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client, Vcl.Dialogs,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

type
  TovF_DataModule = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDQuery_Temp: TFDQuery;
    FDTransaction1: TFDTransaction;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ovF_DataModule: TovF_DataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TovF_DataModule.DataModuleCreate(Sender: TObject);
begin
   FDConnection1.Params.DriverID := 'PG';
   FDConnection1.Params.Database := 'Tickets';
   FDConnection1.Params.UserName := 'postgres';
   FDConnection1.Params.Password := 'admin';
   FDConnection1.Params.Add('Server=localhost');
   FDConnection1.Params.Add('Port=5432');

   try
      FDConnection1.Connected := True;
   except
      ShowMessage('Não foi possível conectar ao banco de dados: ');
   end;

end;

procedure TovF_DataModule.DataModuleDestroy(Sender: TObject);
begin
   if ( FDConnection1.Connected ) then
      FDConnection1.Connected := False;

   FDConnection1.Params.Clear;   
end;

end.
