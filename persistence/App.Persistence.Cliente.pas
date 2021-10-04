unit App.Persistence.Cliente;

interface

uses
  App.Base.Persistence, App.Base.Model, FireDAC.Comp.Client;

type
  TClientePersistence = class(TBasePersistence)
  protected
    function GetNewInstanceModel: TBaseModel; override;
  public
    function GetResultSet: TFDMemTable; override;
  end;

implementation

uses
  App.Model.Cliente;

{ TClientePersistence }

function TClientePersistence.GetNewInstanceModel: TBaseModel;
begin
  Result := TCliente.Create;
end;

function TClientePersistence.GetResultSet: TFDMemTable;
begin

end;

end.
