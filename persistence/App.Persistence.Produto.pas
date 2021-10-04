unit App.Persistence.Produto;

interface

uses
  App.Base.Persistence, App.Base.Model, FireDAC.Comp.Client;

type
  TProdutoPersistence = class(TBasePersistence)
  private
    procedure SetInfoFieldsDataSet(const ADataSet: TFDMemTable);
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
var
  LSql : String;
begin
  try
    Result := nil;

    LSql := 'select '
          + '       PRD.codigo '
          + '     , PRD.descricao '
          + '     , PRD.preco_venda '
          + '  from produto PRD '
          + ' order by '
          + '       PRD.descricao ';

    Query.Close;
    Query.SQL.Text := LSql;
    Query.Open;

    SetDataSetByQuery(Query, SetInfoFieldsDataSet);

    Result := DataSetConsulta;
  except
    raise;
  end;
end;

procedure TProdutoPersistence.SetInfoFieldsDataSet(const ADataSet: TFDMemTable);
begin
  SetNameFieldDataSet(ADataSet, 'CODIGO', 'Código', 10);
  SetNameFieldDataSet(ADataSet, 'DESCRICAO', 'Produto', 50);
  SetNameFieldDataSet(ADataSet, 'PRECO_VENDA', 'Preço Venda', 0);
end;

end.

