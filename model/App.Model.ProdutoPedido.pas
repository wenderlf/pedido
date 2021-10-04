unit App.Model.ProdutoPedido;

interface

uses
  App.Base.Model;

type
  TProdutoPedido = class(TBaseModel)
  private
    FCodigoProduto: Integer;
    FValorUnitario: Double;
    FValorTotal: Double;
    FCodigoPedido: Integer;
    FQuantidade: Double;
    procedure SetCodigoPedido(const Value: Integer);
    procedure SetCodigoProduto(const Value: Integer);
    procedure SetQuantidade(const Value: Double);
    procedure SetValorTotal(const Value: Double);
    procedure SetValorUnitario(const Value: Double);
  public
    property CodigoPedido: Integer read FCodigoPedido write SetCodigoPedido;
    property CodigoProduto: Integer read FCodigoProduto write SetCodigoProduto;
    property Quantidade: Double read FQuantidade write SetQuantidade;
    property ValorUnitario: Double read FValorUnitario write SetValorUnitario;
    property ValorTotal: Double read FValorTotal write SetValorTotal;
  end;

implementation

{ TProdutoPedido }

procedure TProdutoPedido.SetCodigoPedido(const Value: Integer);
begin
  FCodigoPedido := Value;
end;

procedure TProdutoPedido.SetCodigoProduto(const Value: Integer);
begin
  FCodigoProduto := Value;
end;

procedure TProdutoPedido.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TProdutoPedido.SetValorTotal(const Value: Double);
begin
  FValorTotal := Value;
end;

procedure TProdutoPedido.SetValorUnitario(const Value: Double);
begin
  FValorUnitario := Value;
end;

end.
