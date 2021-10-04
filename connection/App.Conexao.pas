unit App.Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,
  FireDAC.Comp.UI;

type
  TDataModuleConexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FCodeTransaction : Int64;

    procedure loadConnection;

  public
    { Public declarations }
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;

    function GetConnection: TFDConnection;

  end;

var
  DataModuleConexao: TDataModuleConexao;

implementation

uses
  App.Lib.Transaction, System.IniFiles;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModuleConexao.Commit;
begin
  FDConnection.Commit;
end;

procedure TDataModuleConexao.DataModuleCreate(Sender: TObject);
begin
  loadConnection;
  TTransaction.GetInstance;
end;

procedure TDataModuleConexao.DataModuleDestroy(Sender: TObject);
begin
  TTransaction.GetInstance.Free;
end;

function TDataModuleConexao.GetConnection: TFDConnection;
begin
  Result := FDConnection;
end;

procedure TDataModuleConexao.loadConnection;
const
  INI_FILE = 'conf.ini';
  SECTION  = 'DATABASE';

var
  i            : Integer;
  LIniFile     : TIniFile;
  LPathFileIni : String;
  LListParams  : TStrings;
begin
  with FDConnection do
  try
    LPathFileIni := ExtractFilePath(ParamStr(0))+INI_FILE;
    if not FileExists(LPathFileIni) then
      raise Exception.Create('O arquivo de configuração não foi localizado.');

    try
      LIniFile := TIniFile.Create(LPathFileIni);

      LListParams := TStringList.Create;
      LIniFile.ReadSection(SECTION, LListParams);

      LoginPrompt := False;

      Close;
      Params.Clear;
      Params.AddPair('DriverID','MySQL');
      Params.AddPair('CharacterSet','utf8');

      for i := 0 to LListParams.Count-1 do
        Params.AddPair(LListParams[i], LIniFile.ReadString(SECTION, LListParams[i], EmptyStr));

      Open;
    finally
      FreeAndNil(LIniFile);
      FreeAndNil(LListParams)
    end;
  except
    raise EFDException.Create('Ocorreu um erro com a conexão ao banco de dados.'+#13#10+
                              'A aplicação será fechada.');
  end;
end;

procedure TDataModuleConexao.Rollback;
begin
  FDConnection.Rollback;
end;

procedure TDataModuleConexao.StartTransaction;
begin
  FDConnection.StartTransaction;
end;

end.
