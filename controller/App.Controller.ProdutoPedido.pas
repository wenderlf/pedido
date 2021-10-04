unit App.Controller.ProdutoPedido;

interface

uses
  App.Base.Controller;

type
  TProdutoPedidoController = class(TBaseController)
  private
    procedure SetCodigoPedido(const Value: Integer);

  protected
    procedure InstancePersistence; override;

  public
    procedure DeleteByCodigoPedido(ACodigoPedido: Integer);

    property CodigoPedido: Integer write SetCodigoPedido;

  end;


implementation

uses
  App.Persistence.ProdutoPedido;

{ TProdutoPedidoController }

procedure TProdutoPedidoController.DeleteByCodigoPedido(ACodigoPedido: Integer);
var
  LUIDTransaction : Int64;
begin
  try
    LUIDTransaction := Transaction.Start;

    TProdutoPedidoPersistence(Persistence).DeleteByCodigoPedido(ACodigoPedido);

    Transaction.Comiit(LUIDTransaction);
  except
    Transaction.Rollback(LUIDTransaction);
    raise;
  end;
end;

procedure TProdutoPedidoController.InstancePersistence;
begin
  inherited;
  Persistence := TProdutoPedidoPersistence.Create;
end;

procedure TProdutoPedidoController.SetCodigoPedido(const Value: Integer);
begin
  TProdutoPedidoPersistence(Persistence).CodigoPedido := Value;
end;

end.

