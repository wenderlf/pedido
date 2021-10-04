unit App.Base.Model;

interface

type
  TBaseModel = class
  private
    FCodigo: Integer;
    procedure SetCodigo(const Value: Integer);
  public
    property Codigo: Integer read FCodigo write SetCodigo;
  end;

implementation

{ TBaseModel }

procedure TBaseModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

end.
