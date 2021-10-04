unit App.Model.Cliente;

interface

uses
  App.Base.Model;

type
  TCliente = class(TBaseModel)
  private
    FUf: String;
    FNome: String;
    FCidade: String;
    procedure SetCidade(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetUf(const Value: String);
  public
    property Nome: String read FNome write SetNome;
    property Cidade: String read FCidade write SetCidade;
    property Uf: String read FUf write SetUf;
  end;

implementation

{ TCliente }

procedure TCliente.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TCliente.SetUf(const Value: String);
begin
  FUf := Value;
end;

end.
