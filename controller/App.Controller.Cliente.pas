unit App.Controller.Cliente;

interface

uses
  App.Base.Controller;

type
  TClienteController = class(TBaseController)
  protected
    procedure InstancePersistence; override;
  end;


implementation

uses
  App.Persistence.Cliente;

{ TClienteController }

procedure TClienteController.InstancePersistence;
begin
  inherited;
  Persistence := TClientePersistence.Create;
end;

end.
