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
    property CodigoPedido: Integer write SetCodigoPedido;

  end;


implementation

uses
  App.Persistence.ProdutoPedido;

{ TProdutoPedidoController }

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

