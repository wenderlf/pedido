unit App.Persistence.Produto;

interface

uses
  App.Base.Persistence, App.Base.Model, FireDAC.Comp.Client;

type
  TProdutoPersistence = class(TBasePersistence)
  protected
    function GetNewInstanceModel: TBaseModel; override;
  public
    function GetResultSet: TFDMemTable; override;
  end;

implementation

uses
  App.Model.Produto;

{ TProdutoPersistence }

function TProdutoPersistence.GetNewInstanceModel: TBaseModel;
begin
  Result := TProduto.Create;
end;

function TProdutoPersistence.GetResultSet: TFDMemTable;
begin

end;

end.

