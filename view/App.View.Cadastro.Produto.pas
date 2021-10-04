unit App.View.Cadastro.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.Base.View.Cadastro, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFormCadastroProduto = class(TFormBaseCadastro)
    LabeledEditDescricao: TLabeledEdit;
    LabeledEditPrecoVenda: TLabeledEdit;
    procedure LabeledEditPrecoVendaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InstanceController; override;
    procedure InstanceObjectPost; override;

    procedure ClearFormCadastro; override;
    procedure FillForm; override;
    procedure PostForm; override;
    function ConsistForm: Boolean; override;
  public
    { Public declarations }
  end;

var
  FormCadastroProduto: TFormCadastroProduto;

implementation

uses
  App.Controller.Produto, App.Model.Produto;

{$R *.dfm}

{ TFormCadastroProduto }

procedure TFormCadastroProduto.ClearFormCadastro;
begin
  inherited;
  LabeledEditDescricao.Clear;
  LabeledEditPrecoVenda.Clear;
end;

function TFormCadastroProduto.ConsistForm: Boolean;
begin
  Result := False;

  if Trim(LabeledEditDescricao.Text) = EmptyStr then
  begin
    Application.MessageBox(PChar('Preencha a descrição do produto.'),PChar('Aviso'),
      MB_OK + MB_ICONWARNING);

    Exit;
  end;

  if ConvertStringToDouble(LabeledEditPrecoVenda.Text) = 0 then
  begin
    Application.MessageBox(PChar('Preencha o preço de venda.'),PChar('Aviso'),
      MB_OK + MB_ICONWARNING);

    Exit;
  end;

  Result := True;
end;

procedure TFormCadastroProduto.FillForm;
var
  LProduto : TProduto;
begin
  try
    inherited;

    LProduto := ObjectPost as TProduto;
    LabeledEditDescricao.Text  := LProduto.Descricao;
    LabeledEditPrecoVenda.Text := FormatFloat(',0.00', LProduto.PrecoVenda);
  except
    raise;
  end;
end;

procedure TFormCadastroProduto.FormCreate(Sender: TObject);
begin
  inherited;
  FocusedControl := LabeledEditDescricao;
end;

procedure TFormCadastroProduto.InstanceController;
begin
  inherited;
  Controller := TProdutoController.Create;
end;

procedure TFormCadastroProduto.InstanceObjectPost;
begin
  inherited;
  ObjectPost := TProduto.Create;
end;

procedure TFormCadastroProduto.LabeledEditPrecoVendaKeyPress(Sender: TObject;
  var Key: Char);
begin
  FormatterStringToDouble(TLabeledEdit(Sender), Key);
end;

procedure TFormCadastroProduto.PostForm;
var
  LProduto : TProduto;
begin
  try
    inherited;

    LProduto := ObjectPost as TProduto;
    LProduto.Descricao  := LabeledEditDescricao.Text;
    LProduto.PrecoVenda := ConvertStringToDouble(LabeledEditPrecoVenda.Text);
  except
    raise;
  end;
end;

end.
