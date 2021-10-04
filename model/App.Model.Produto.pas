unit App.Model.Produto;

interface

uses
  App.Base.Model;

type
  TProduto = class(TBaseModel)
  private
    FDescricao: String;
    FPrecoVenda: Double;
    procedure SetDescricao(const Value: String);
    procedure SetPrecoVenda(const Value: Double);
  public
    property Descricao: String read FDescricao write SetDescricao;
    property PrecoVenda: Double read FPrecoVenda write SetPrecoVenda;
  end;

implementation

{ TProduto }

procedure TProduto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProduto.SetPrecoVenda(const Value: Double);
begin
  FPrecoVenda := Value;
end;

end.
