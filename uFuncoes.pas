unit uFuncoes;

interface
  function SomenteNumeros(const Texto: string): string;
  function ValidarCPF(const pCPF : String) : Boolean;
  function BuscarTicket(const Identificador : Integer) : Boolean;

implementation

uses
  System.SysUtils, System.Variants, uDataModule;

function SomenteNumeros(const Texto: string): string;
var
  c: Char;
begin
  Result := '';
  for c in Texto do
    if CharInSet(c, ['0'..'9']) then
      Result := Result + c;
end;

function ValidarCPF(const pCPF : String) : Boolean;
var
  cpf: string;
begin
  cpf := SomenteNumeros(pCPF);
  if Length(cpf) <> 11 then
  begin
    Result := False;
    raise Exception.Create('CPF inválido: deve conter 11 dígitos!');
  end
  else
      Result := True;
end;

function BuscarTicket(const Identificador : Integer) : Boolean;
begin
  try
    with ovF_DataModule.FDQuery_Temp do
    begin
      Close;
      SQL.Text := 'SELECT tck_id FROM tickets WHERE tck_id = :id';
      ParamByName('id').AsInteger := Identificador;
      Open;

      if (FieldByName('tck_id').AsInteger = 0 or FieldByName('tck_id').AsInteger = Null) then
        Result := False
      else
        Result := True;
    end;
  finally
    ovF_DataModule.FDQuery_Temp.Free;
  end;
end;

end.
