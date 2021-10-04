unit App.Base.Controller;

interface

uses
  App.Base.Model, System.Generics.Collections, App.Base.Persistence,
  FireDAC.Comp.Client;

type
  TBaseController = class
  private
    FPersistence : TBasePersistence;
    procedure SetPersistence(const Value: TBasePersistence);
  protected
    procedure InstancePersistence; virtual; abstract;

    property Persistence : TBasePersistence read FPersistence write SetPersistence;
  public
    constructor Create;
    destructor Destroy; override;

    function FindById(const AID: Integer): TBaseModel; virtual;
    function FindAll: TList<TBaseModel>; virtual;

    function Delete(const AID: Integer): Boolean; virtual;
    function Post(const AModel: TBaseModel): Integer;

    function GetResultSet: TFDMemTable;

    procedure Clear;
  end;

implementation

uses
  System.SysUtils;

{ TBaseController }

procedure TBaseController.Clear;
begin
  try
    FPersistence.ClearDataSetConsulta;
  except
    raise;
  end;
end;

constructor TBaseController.Create;
begin
  InstancePersistence;
end;

function TBaseController.Delete(const AID: Integer): Boolean;
begin
  try
    Result := FPersistence.Delete(AID);
  except
    raise;
  end;
end;

destructor TBaseController.Destroy;
begin
  if Assigned(FPersistence) then
    FreeAndNil(FPersistence);

  inherited;
end;

function TBaseController.FindAll: TList<TBaseModel>;
begin
  try
    Result := FPersistence.FindAll;
  except
    raise;
  end;
end;

function TBaseController.FindById(const AID: Integer): TBaseModel;
begin
  try
    Result := FPersistence.FindById(AID);
  except
    raise;
  end;
end;

function TBaseController.GetResultSet: TFDMemTable;
begin
  try
    Result := FPersistence.GetResultSet;
  except
    raise;
  end;
end;

function TBaseController.Post(const AModel: TBaseModel): Integer;
begin
  try
    Result := FPersistence.Post(AModel);
  except
    raise;
  end;
end;

procedure TBaseController.SetPersistence(const Value: TBasePersistence);
begin
  FPersistence := Value;
end;

end.
