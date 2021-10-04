unit App.View.ControlePedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.Base.View, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls;

type
  TFormControlePedido = class(TFormBase)
    ApplicationEvents: TApplicationEvents;
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    Movimentaes1: TMenuItem;
    Pedidos1: TMenuItem;
    Sair1: TMenuItem;
    StatusBar: TStatusBar;
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Pedidos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormControlePedido: TFormControlePedido;

implementation

uses
  App.Conexao, App.View.Cadastro.Pedido;

{$R *.dfm}

procedure TFormControlePedido.ApplicationEventsException(Sender: TObject;
  E: Exception);
begin
  inherited;
  Application.MessageBox(PChar(E.Message), PChar('Erro'), MB_OK + MB_ICONERROR);
end;

procedure TFormControlePedido.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if Application.MessageBox(PChar('Deseja finalizar o programa?'),
    PChar('Confirmação'), MB_YESNO + MB_ICONQUESTION) = ID_NO then
    CanClose := False;
end;

procedure TFormControlePedido.FormCreate(Sender: TObject);
begin
  inherited;
  DataModuleConexao := TDataModuleConexao.Create(nil);
end;

procedure TFormControlePedido.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DataModuleConexao);
  inherited;
end;

procedure TFormControlePedido.Pedidos1Click(Sender: TObject);
begin
  inherited;
  try
    FormCadastroPedido := TFormCadastroPedido.Create(nil);
    FormCadastroPedido.ShowModal;
  finally
    FreeAndNil(FormCadastroPedido);
  end;
end;

procedure TFormControlePedido.Sair1Click(Sender: TObject);
begin
  inherited;
  Self.Close
end;

end.
