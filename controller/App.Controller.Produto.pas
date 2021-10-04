unit App.Controller.Produto;

interface

uses
  App.Base.Controller;

type
  TProdutoController = class(TBaseController)
  protected
    procedure InstancePersistence; override;
  end;


implementation

uses
  App.Persistence.Produto;

{ TProdutoController }

procedure TProdutoController.InstancePersistence;
begin
  inherited;
  Persistence := TProdutoPersistence.Create;
end;

end.

