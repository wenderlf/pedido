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
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDTransaction: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FCodeTransaction : Int64;

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

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModuleConexao.Commit;
begin
  FDConnection.Commit;
end;

procedure TDataModuleConexao.DataModuleCreate(Sender: TObject);
begin
  with FDConnection do
  try
    LoginPrompt := False;

    Close;
    Params.Clear;

    Params.AddPair('DriverID','MySQL');
    Params.AddPair('CharacterSet','utf8');
    Params.AddPair('User_Name','root');
    Params.AddPair('Password','wlf16nanny');
    Params.AddPair('Port','3306');
    Params.AddPair('Server','127.0.0.1');
    Params.AddPair('Database','controle_pedido');

    Open;
  except
    raise EFDException.Create('Ocorreu um erro com a conexão ao banco de dados.'+#13#10+
                              'A aplicação será fechada.');
  end;
end;

function TDataModuleConexao.GetConnection: TFDConnection;
begin
  Result := FDConnection;
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
