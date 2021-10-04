unit App.Persistence.ProdutoPedido;

interface

uses
  App.Base.Persistence, App.Base.Model, FireDAC.Comp.Client;

type
  TProdutoPedidoPersistence = class(TBasePersistence)
  private
    FCodigoPedido: Integer;
    procedure SetCodigoPedido(const Value: Integer);

    procedure SetInfoFieldsDataSet(const ADataSet: TFDMemTable);
  protected
    function GetNewInstanceModel: TBaseModel; override;
  public
    function GetResultSet: TFDMemTable; override;
    procedure DeleteByCodigoPedido(const ACodigoPedido: Integer);

    property CodigoPedido: Integer write SetCodigoPedido;
  end;

implementation

uses
  App.Model.ProdutoPedido, System.Classes, System.SysUtils;

{ TProdutoPedidoPersistence }

procedure TProdutoPedidoPersistence.DeleteByCodigoPedido(
  const ACodigoPedido: Integer);
var
  LSql : String;
begin
  try
    LSql := 'delete from produto_pedido '
          + ' where codigo_pedido = '+ACodigoPedido.ToString;

    Query.Close;
    Query.SQL.Text := LSql;
    Query.ExecSQL;
  except
    raise;
  end;
end;

function TProdutoPedidoPersistence.GetNewInstanceModel: TBaseModel;
begin
  Result := TProdutoPedido.Create;
end;

function TProdutoPedidoPersistence.GetResultSet: TFDMemTable;
var
  LSql : String;
begin
  try
    Result := nil;

    LSql := 'select '
          + '       PPD.codigo_produto '
          + '     , PRD.descricao        as PRODUTO '
          + '     , PPD.quantidade '
          + '     , PPD.valor_unitario '
          + '     , PPD.valor_total '
          + '     , PPD.codigo '
          + '     , PPD.codigo_pedido '
          + '  from produto_pedido PPD '
          + ' inner join produto PRD on PRD.codigo = PPD.codigo_produto '
          + ' where PPD.codigo_pedido = '+FCodigoPedido.ToString
          + ' order by '
          + '       PPD.codigo ';

    Query.Close;
    Query.SQL.Text := LSql;
    Query.Open;

    SetDataSetByQuery(Query, SetInfoFieldsDataSet);

    Result := DataSetConsulta;
  except
    raise;
  end;
end;

procedure TProdutoPedidoPersistence.SetCodigoPedido(const Value: Integer);
begin
  FCodigoPedido := Value;
end;

procedure TProdutoPedidoPersistence.SetInfoFieldsDataSet(
  const ADataSet: TFDMemTable);
begin
  SetNameFieldDataSet(ADataSet, 'CODIGO_PRODUTO', 'Código Produto', 10);
  SetNameFieldDataSet(ADataSet, 'PRODUTO', 'Produto', 45);
  SetNameFieldDataSet(ADataSet, 'QUANTIDADE', 'Quantidade', 15);
  SetNameFieldDataSet(ADataSet, 'VALOR_UNITARIO', 'Valor Unitário', 15);
  SetNameFieldDataSet(ADataSet, 'VALOR_TOTAL', 'Valor Total', 15);
  SetNameFieldDataSet(ADataSet, 'CODIGO', 'Código', 10, False);
  SetNameFieldDataSet(ADataSet, 'CODIGO_PEDIDO', 'Código Pedido', 10, False);
end;

end.

