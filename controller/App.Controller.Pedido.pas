unit App.Controller.Pedido;

interface

uses
  App.Base.Controller, App.Model.ProdutoPedido, System.Classes,
  System.Generics.Collections, App.Base.Model;

type
  TPedidoController = class(TBaseController)
  private
    FListRemoveProdutoPedidos : TStrings;
    FListProdutoPedidos       : TList<TProdutoPedido>;

    procedure SetListProdutoPedidos(const Value: TList<TProdutoPedido>);
    procedure SetListRemoveProdutoPedidos(const Value: TStrings);

  protected
    procedure AfterPost(const AModel: TBaseModel); override;
    procedure BeforeDelete(const ACodigo: Integer); override;
    procedure AfterCreateClass; override;

    procedure InstancePersistence; override;

  public
    destructor Destroy; override;

    procedure RemoveItemsListProdutoPedidos;

    property ListRemoveProdutoPedidos : TStrings
      write SetListRemoveProdutoPedidos;
    property ListProdutoPedidos       : TList<TProdutoPedido> read FListProdutoPedidos;
  end;


implementation

uses
  App.Persistence.Pedido, App.Controller.ProdutoPedido, System.SysUtils;

{ TPedidoController }

procedure TPedidoController.AfterCreateClass;
begin
  inherited;
  FListProdutoPedidos := TList<TProdutoPedido>.Create;
end;

procedure TPedidoController.AfterPost(const AModel: TBaseModel);
var
  i              : Integer;
  LController    : TProdutoPedidoController;
  LProdutoPedido : TProdutoPedido;
begin
  try
    inherited;

    try
      LController := TProdutoPedidoController.Create;

      if FListRemoveProdutoPedidos.Count > 0 then
      begin
        for i := 0 to Pred(FListRemoveProdutoPedidos.Count) do
          LController.Delete(StrToInt(FListRemoveProdutoPedidos.Strings[i]));
      end;

      for LProdutoPedido in FListProdutoPedidos do
      begin
        LProdutoPedido.CodigoPedido := AModel.Codigo;
        LController.Post(LProdutoPedido);
      end;
    finally
      FreeAndNil(LController);
    end;
  except
    raise;
  end;
end;

procedure TPedidoController.BeforeDelete(const ACodigo: Integer);
var
  LController : TProdutoPedidoController;
begin
  try
    inherited;

    try
      LController := TProdutoPedidoController.Create;
      LController.DeleteByCodigoPedido(ACodigo);
    finally
      FreeAndNil(LController);
    end;
  except
    raise;
  end;
end;

destructor TPedidoController.Destroy;
begin
  RemoveItemsListProdutoPedidos;
  FreeAndNil(FListProdutoPedidos);

  inherited;
end;

procedure TPedidoController.InstancePersistence;
begin
  inherited;
  Persistence := TPedidoPersistence.Create;
end;

procedure TPedidoController.RemoveItemsListProdutoPedidos;
var
  LModel  : TBaseModel;
  LObject : TObject;
begin
  for LModel in FListProdutoPedidos do
  begin
    LObject := LModel;
    FreeAndNil(LObject);
  end;

  FListProdutoPedidos.Clear;
end;

procedure TPedidoController.SetListProdutoPedidos(
  const Value: TList<TProdutoPedido>);
begin
  FListProdutoPedidos := Value;
end;

procedure TPedidoController.SetListRemoveProdutoPedidos(
  const Value: TStrings);
begin
  FListRemoveProdutoPedidos := Value;
end;

end.

