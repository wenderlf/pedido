unit App.Lib.Transaction;

interface

type
  TTransaction = class sealed
  strict private
    class var FInstance       : TTransaction;
    class var FUIDTransaction : Int64;

  private
    constructor Create;

    class procedure ReleaseInstance;

    function GenerateUIDTransaction: Int64;
  public
    class function GetInstance: TTransaction;

    function Start: Int64;
    procedure Comiit(const AUIDTransaction: Int64);
    procedure Rollback(const AUIDTransaction: Int64);

  end;

implementation

uses
  App.Conexao, System.SysUtils;

{ TTransaction }

procedure TTransaction.Comiit(const AUIDTransaction: Int64);
begin
  if AUIDTransaction = FUIDTransaction then
  begin
    DataModuleConexao.Commit;
    FUIDTransaction := 0;
  end;
end;

constructor TTransaction.Create;
begin
//Apenas retirando o construtor do método público e deixando ele private
//para que use o GetInstance.
end;

function TTransaction.GenerateUIDTransaction: Int64;
var
  LRandomNumber : Integer;
begin
  LRandomNumber := Random(9);
  Result := StrToInt64(FormatDateTime('yyyymmddhhnnsszzz', Now)+LRandomNumber.ToString);
end;

class function TTransaction.GetInstance: TTransaction;
begin
  if not Assigned(FInstance) then
  begin
    FInstance       := TTransaction.Create;
    FUIDTransaction := 0;
  end;

  Result := Self.FInstance;
end;

class procedure TTransaction.ReleaseInstance;
begin
  if not Assigned(FInstance) then
    Exit;
end;

procedure TTransaction.Rollback(const AUIDTransaction: Int64);
begin
  if AUIDTransaction = FUIDTransaction then
  begin
    FUIDTransaction := 0;
    DataModuleConexao.Rollback;
  end;
end;

function TTransaction.Start: Int64;
begin
  Result := GenerateUIDTransaction;

  if FUIDTransaction = 0 then
  begin
    FUIDTransaction := Result;
    DataModuleConexao.StartTransaction;
  end;
end;

initialization

finalization
  TTransaction.ReleaseInstance;

end.

