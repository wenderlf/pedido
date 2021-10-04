unit App.Base.Controller;

interface

uses
  App.Base.Model, System.Generics.Collections, App.Base.Persistence,
  FireDAC.Comp.Client, App.Lib.Transaction;

type
  TBaseController = class
  private
    FPersistence : TBasePersistence;
    FTransaction : TTransaction;

    procedure SetPersistence(const Value: TBasePersistence);

  protected
    procedure InstancePersistence; virtual; abstract;
    procedure AfterCreateClass; virtual;

    procedure AfterPost(const AModel: TBaseModel); virtual;
    procedure BeforeDelete(const ACodigo: Integer); virtual;

    property Persistence : TBasePersistence read FPersistence write SetPersistence;
    property Transaction : TTransaction     read FTransaction;

  public
    constructor Create;
    destructor Destroy; override;

    function FindById(const ACodigo: Integer): TBaseModel; virtual;
    function FindAll: TList<TBaseModel>; virtual;

    function Delete(const ACodigo: Integer): Boolean; virtual;
    function Post(const AModel: TBaseModel): Integer; virtual;

    function GetResultSet: TFDMemTable;

    procedure Clear;
  end;

implementation

uses
  System.SysUtils;

{ TBaseController }

procedure TBaseController.AfterCreateClass;
begin
//
end;

procedure TBaseController.AfterPost(const AModel: TBaseModel);
begin
//
end;

procedure TBaseController.BeforeDelete(const ACodigo: Integer);
begin
//
end;

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
  FTransaction := TTransaction.GetInstance;
  InstancePersistence;
  AfterCreateClass;
end;

function TBaseController.Delete(const ACodigo: Integer): Boolean;
var
  LUIDTransaction : Int64;
begin
  try
    LUIDTransaction := FTransaction.Start;

    BeforeDelete(ACodigo);
    Result := FPersistence.Delete(ACodigo);

    FTransaction.Comiit(LUIDTransaction);
  except
    FTransaction.Rollback(LUIDTransaction);
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

function TBaseController.FindById(const ACodigo: Integer): TBaseModel;
begin
  try
    Result := FPersistence.FindById(ACodigo);
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
var
  LUIDTransaction : Int64;
begin
  try
    LUIDTransaction := FTransaction.Start;

    Result := FPersistence.Post(AModel);

    AModel.Codigo := Result;
    AfterPost(AModel);

    FTransaction.Comiit(LUIDTransaction);
  except
    FTransaction.Rollback(LUIDTransaction);
    raise;
  end;
end;

procedure TBaseController.SetPersistence(const Value: TBasePersistence);
begin
  FPersistence := Value;
end;

end.
