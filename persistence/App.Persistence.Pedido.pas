unit App.Persistence.Pedido;

interface

uses
  App.Base.Persistence, App.Base.Model, FireDAC.Comp.Client;

type
  TPedidoPersistence = class(TBasePersistence)
  private
    procedure SetInfoFieldsDataSet(const ADataSet: TFDMemTable);
  protected
    function GetNewInstanceModel: TBaseModel; override;
  public
    function GetResultSet: TFDMemTable; override;
  end;

implementation

uses
  App.Model.Pedido;

{ TPedidoPersistence }

function TPedidoPersistence.GetNewInstanceModel: TBaseModel;
begin
  Result := TPedido.Create;
end;

function TPedidoPersistence.GetResultSet: TFDMemTable;
var
  LSql : String;
begin
  try
    Result := nil;

    LSql := 'select '
          + '       PED.codigo '
          + '     , CLI.nome           as CLIENTE '
          + '     , PED.data_emissao '
          + '     , PED.valor_total '
          + '  from pedido PED '
          + ' inner join cliente CLI on CLI.codigo = PED.codigo_cliente '
          + ' order by '
          + '       PED.data_emissao '
          + '     , PED.codigo ';

    Query.Close;
    Query.SQL.Text := LSql;
    Query.Open;

    SetDataSetByQuery(Query, SetInfoFieldsDataSet);

    Result := DataSetConsulta;
  except
    raise;
  end;
end;

procedure TPedidoPersistence.SetInfoFieldsDataSet(const ADataSet: TFDMemTable);
begin
  SetNameFieldDataSet(ADataSet, 'CODIGO', 'Número Pedido');
  SetNameFieldDataSet(ADataSet, 'DATA_EMISSAO', 'Data Emissão');
  SetNameFieldDataSet(ADataSet, 'VALOR_TOTAL', 'Valor Total');
  SetNameFieldDataSet(ADataSet, 'CLIENTE', 'Cliente', 50, True);
end;

end.

