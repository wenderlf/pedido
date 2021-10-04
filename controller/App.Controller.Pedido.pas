unit App.Controller.Pedido;

interface

uses
  App.Base.Controller;

type
  TPedidoController = class(TBaseController)
  protected
    procedure InstancePersistence; override;
  end;


implementation

uses
  App.Persistence.Pedido;

{ TPedidoController }

procedure TPedidoController.InstancePersistence;
begin
  inherited;
  Persistence := TPedidoPersistence.Create;
end;

end.

