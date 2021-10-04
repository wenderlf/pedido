unit App.Model.Pedido;

interface

uses
  App.Base.Model;

type
  TPedido = class(TBaseModel)
  private
    FValorTotal: Double;
    FDataEmissao: TDateTime;
    FCodigoCliente: Integer;
    procedure SetCodigoCliente(const Value: Integer);
    procedure SetDataEmissao(const Value: TDateTime);
    procedure SetValorTotal(const Value: Double);
  public
    property DataEmissao: TDateTime read FDataEmissao write SetDataEmissao;
    property CodigoCliente: Integer read FCodigoCliente write SetCodigoCliente;
    property ValorTotal: Double read FValorTotal write SetValorTotal;
  end;

implementation

{ TPedido }

procedure TPedido.SetCodigoCliente(const Value: Integer);
begin
  FCodigoCliente := Value;
end;

procedure TPedido.SetDataEmissao(const Value: TDateTime);
begin
  FDataEmissao := Value;
end;

procedure TPedido.SetValorTotal(const Value: Double);
begin
  FValorTotal := Value;
end;

end.
