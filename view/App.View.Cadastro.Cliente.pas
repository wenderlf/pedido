unit App.View.Cadastro.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.Base.View.Cadastro, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TFormCadastroCliente = class(TFormBaseCadastro)
    LabeledEditNome: TLabeledEdit;
    LabeledEditCidade: TLabeledEdit;
    LabeledEditUf: TLabeledEdit;
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
  FormCadastroCliente: TFormCadastroCliente;

implementation

uses
  App.Controller.Cliente, App.Model.Cliente;

{$R *.dfm}

{ TFormCadastroCliente }

procedure TFormCadastroCliente.ClearFormCadastro;
begin
  inherited;
  LabeledEditNome.Clear;
  LabeledEditCidade.Clear;
  LabeledEditUf.Clear;
end;

function TFormCadastroCliente.ConsistForm: Boolean;
begin
  Result := False;

  if Trim(LabeledEditNome.Text) = EmptyStr then
  begin
    Application.MessageBox(PChar('Preencha o nome do cliente.'),PChar('Aviso'),
      MB_OK + MB_ICONWARNING);

    Exit;
  end;

  if Trim(LabeledEditCidade.Text) = EmptyStr then
  begin
    Application.MessageBox(PChar('Preencha a cidade.'),PChar('Aviso'),
      MB_OK + MB_ICONWARNING);

    Exit;
  end;

  if Trim(LabeledEditUf.Text) = EmptyStr then
  begin
    Application.MessageBox(PChar('Preencha a UF.'),PChar('Aviso'),
      MB_OK + MB_ICONWARNING);

    Exit;
  end;

  Result := True;
end;

procedure TFormCadastroCliente.FillForm;
var
  LCliente : TCliente;
begin
  try
    inherited;

    LCliente := ObjectPost as TCliente;
    LabeledEditNome.Text   := LCliente.Nome;
    LabeledEditCidade.Text := LCliente.Cidade;
    LabeledEditUf.Text     := LCliente.Uf;
  except
    raise;
  end;
end;

procedure TFormCadastroCliente.FormCreate(Sender: TObject);
begin
  inherited;
  FocusedControl := LabeledEditNome;
end;

procedure TFormCadastroCliente.InstanceController;
begin
  inherited;
  Controller := TClienteController.Create;
end;

procedure TFormCadastroCliente.InstanceObjectPost;
begin
  inherited;
  ObjectPost := TCliente.Create;
end;

procedure TFormCadastroCliente.PostForm;
var
  LCliente : TCliente;
begin
  try
    inherited;

    LCliente := ObjectPost as TCliente;
    LCliente.Nome   := LabeledEditNome.Text;
    LCliente.Cidade := LabeledEditCidade.Text;
    LCliente.Uf     := LabeledEditUf.Text;
  except
    raise;
  end;
end;

end.
