unit App.Persistence.Cliente;

interface

uses
  App.Base.Persistence, App.Base.Model, FireDAC.Comp.Client;

type
  TClientePersistence = class(TBasePersistence)
  private
    procedure SetInfoFieldsDataSet(const ADataSet: TFDMemTable);
  protected
    function GetNewInstanceModel: TBaseModel; override;
  public
    function GetResultSet: TFDMemTable; override;
  end;

implementation

uses
  App.Model.Cliente;

{ TClientePersistence }

function TClientePersistence.GetNewInstanceModel: TBaseModel;
begin
  Result := TCliente.Create;
end;

function TClientePersistence.GetResultSet: TFDMemTable;
var
  LSql : String;
begin
  try
    Result := nil;

    LSql := 'select '
          + '       CLI.codigo '
          + '     , CLI.nome '
          + '  from cliente CLI '
          + ' order by '
          + '       CLI.nome ';

    Query.Close;
    Query.SQL.Text := LSql;
    Query.Open;

    SetDataSetByQuery(Query, SetInfoFieldsDataSet);

    Result := DataSetConsulta;
  except
    raise;
  end;
end;

procedure TClientePersistence.SetInfoFieldsDataSet(const ADataSet: TFDMemTable);
begin
  SetNameFieldDataSet(ADataSet, 'CODIGO', 'Código', 10);
  SetNameFieldDataSet(ADataSet, 'NOME', 'Nome do Cliente', 65);
end;

end.
