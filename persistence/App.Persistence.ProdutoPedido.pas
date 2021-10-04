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

    property CodigoPedido: Integer write SetCodigoPedido;
  end;

implementation

uses
  App.Model.ProdutoPedido, System.Classes, System.SysUtils;

{ TProdutoPedidoPersistence }

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
  SetNameFieldDataSet(ADataSet, 'CODIGO_PRODUTO', 'Código Produto');
  SetNameFieldDataSet(ADataSet, 'PRODUTO', 'Produto', 60);
  SetNameFieldDataSet(ADataSet, 'QUANTIDADE', 'Quantidade');
  SetNameFieldDataSet(ADataSet, 'VALOR_UNITARIO', 'Valor Unitário');
  SetNameFieldDataSet(ADataSet, 'VALOR_TOTAL', 'Valor Total');
  SetNameFieldDataSet(ADataSet, 'CODIGO', 'Código', 0, False);
  SetNameFieldDataSet(ADataSet, 'CODIGO_PEDIDO', 'Código Pedido', 0, False);
end;

end.

