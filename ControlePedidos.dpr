program ControlePedidos;

uses
  Vcl.Forms,
  App.Base.View in 'base\App.Base.View.pas' {FormBase},
  App.View.ControlePedido in 'view\App.View.ControlePedido.pas' {FormControlePedido},
  App.Conexao in 'connection\App.Conexao.pas' {DataModuleConexao: TDataModule},
  App.Base.Model in 'base\App.Base.Model.pas',
  App.Model.Cliente in 'model\App.Model.Cliente.pas',
  App.Model.Produto in 'model\App.Model.Produto.pas',
  App.Model.Pedido in 'model\App.Model.Pedido.pas',
  App.Model.ProdutoPedido in 'model\App.Model.ProdutoPedido.pas',
  App.Base.Persistence in 'base\App.Base.Persistence.pas',
  App.Lib.Constants in 'lib\App.Lib.Constants.pas',
  App.Persistence.Cliente in 'persistence\App.Persistence.Cliente.pas',
  App.Persistence.Produto in 'persistence\App.Persistence.Produto.pas',
  App.Persistence.Pedido in 'persistence\App.Persistence.Pedido.pas',
  App.Persistence.ProdutoPedido in 'persistence\App.Persistence.ProdutoPedido.pas',
  App.Base.Controller in 'base\App.Base.Controller.pas',
  App.Controller.Cliente in 'controller\App.Controller.Cliente.pas',
  App.Controller.Produto in 'controller\App.Controller.Produto.pas',
  App.Controller.ProdutoPedido in 'controller\App.Controller.ProdutoPedido.pas',
  App.Controller.Pedido in 'controller\App.Controller.Pedido.pas',
  App.Base.View.Cadastro in 'base\App.Base.View.Cadastro.pas' {FormBaseCadastro},
  App.View.Cadastro.Pedido in 'view\App.View.Cadastro.Pedido.pas' {FormCadastroPedido},
  App.View.Cadastro.Cliente in 'view\App.View.Cadastro.Cliente.pas' {FormCadastroCliente},
  App.View.Cadastro.Produto in 'view\App.View.Cadastro.Produto.pas' {FormCadastroProduto};

{$R *.res}

begin
  Application.Initialize;

  {$IFDEF DEBUG}
     ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormControlePedido, FormControlePedido);
  Application.Run;
end.
