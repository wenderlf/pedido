unit App.Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.PGDef, FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client;

type
  TDataModuleConexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
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

    Params.AddPair('DriverID','PG');
    Params.AddPair('User_Name','postgres');
    Params.AddPair('Password','Protec@Master5509');
    Params.AddPair('Port','5498');
    Params.AddPair('Server','localhost');
    Params.AddPair('Database','controle_pedido');

    Open;
  except
    raise Exception.Create('Ocorreu um erro com a conexão ao banco de dados');
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
