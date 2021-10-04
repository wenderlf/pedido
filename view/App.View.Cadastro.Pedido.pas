unit App.View.Cadastro.Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.Base.View.Cadastro, Data.DB,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.WinXCalendars,
  App.Controller.ProdutoPedido;

type
  TFormCadastroPedido = class(TFormBaseCadastro)
    PanelProdutoPedido: TPanel;
    PanelButtonsProdutoPedido: TPanel;
    PanelCadastroProdutoPedido: TPanel;
    DBGridConsultaProdutoPedido: TDBGrid;
    SpeedButtonNovoProdutoPedido: TSpeedButton;
    SpeedButtonAlterarProdutoPedido: TSpeedButton;
    SpeedButtonRemoverProdutoPedido: TSpeedButton;
    CalendarPickerDataEmissao: TCalendarPicker;
    Label1: TLabel;
    Label2: TLabel;
    ComboBoxCliente: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    LabelTotalPedido: TLabel;
    DataSourceConsultaPedidoProduto: TDataSource;
    SpeedButtonSalvarProdutoPedido: TSpeedButton;
    LabeledEditCodigoProdutoPedido: TLabeledEdit;
    Label5: TLabel;
    ComboBoxProduto: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    LabelTotalProduto: TLabel;
    LabelValorUnitario: TLabel;
    LabeledEditQuantidade: TLabeledEdit;
    procedure SpeedButtonNovoProdutoPedidoClick(Sender: TObject);
    procedure SpeedButtonAlterarProdutoPedidoClick(Sender: TObject);
    procedure SpeedButtonRemoverProdutoPedidoClick(Sender: TObject);
    procedure SpeedButtonSalvarProdutoPedidoClick(Sender: TObject);
    procedure DBGridConsultaProdutoPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridConsultaProdutoPedidoKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridConsultaProdutoPedidoDblClick(Sender: TObject);
    procedure LabeledEditQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxProdutoSelect(Sender: TObject);
    procedure LabeledEditQuantidadeChange(Sender: TObject);
  private
    { Private declarations }
    FRecordDataSetProdutoPedido : Integer;
    FListRemoveProdutosPedido   : TStrings;
    FProdutoPedidoController    : TProdutoPedidoController;

    procedure ClearProdutoPedido;
    procedure ClosePanelCadastroProdutoPedido;
    procedure ActivePanelCadastroProdutoPedido;
    procedure FillProdutoPedido;
    procedure ChangeConsultaProdutoPedido;
    procedure InstanceProdutoPedidoController;
    procedure calcularTotalProduto;

    procedure LoadInfoComboCliente;
    procedure LoadInfoComboProduto;

    procedure SelectItemComboCliente(const ACodigo: Integer);
    procedure SelectItemComboProduto(const ACodigo: Integer);

  protected
    procedure SetAllImageButtons; override;
    procedure InstanceController; override;

    procedure ExecuteAfterShowTabEdicao; override;
    procedure ClearFormCadastro; override;
    procedure FillForm; override;
    procedure PostForm; override;
    function ConsistForm: Boolean; override;

  public
    { Public declarations }
  end;

var
  FormCadastroPedido: TFormCadastroPedido;

implementation

uses
  App.Controller.Pedido, System.Generics.Collections, App.Model.Cliente,
  App.Controller.Cliente, App.Base.Model, App.Model.Produto,
  App.Controller.Produto, App.Model.Pedido;

{$R *.dfm}

{ TFormCadastroPedido }

procedure TFormCadastroPedido.ActivePanelCadastroProdutoPedido;
begin
  PanelCadastroProdutoPedido.Visible := True;
  ClearProdutoPedido;

  ComboBoxProduto.SetFocus;
end;

procedure TFormCadastroPedido.calcularTotalProduto;
begin
  LabelTotalProduto.Caption := FormatFloat(',0.00',
                                 ConvertStringToDouble(LabeledEditQuantidade.Text) *
                                 ConvertStringToDouble(LabelValorUnitario.Caption));
end;

procedure TFormCadastroPedido.ChangeConsultaProdutoPedido;
begin
  try
    if Assigned(FProdutoPedidoController) then
      FreeAndNil(FProdutoPedidoController);

    InstanceProdutoPedidoController;

    FProdutoPedidoController.CodigoPedido   := StrToIntDef(LabeledEditCodigo.Text,0);
    DataSourceConsultaPedidoProduto.Enabled := False;
    DataSourceConsultaPedidoProduto.DataSet := FProdutoPedidoController.GetResultSet;
    DataSourceConsultaPedidoProduto.DataSet.First;

    DBGridConsultaProdutoPedido.DataSource  := DataSourceConsultaPedidoProduto;
  finally
    DataSourceConsultaPedidoProduto.Enabled := True;
  end;
end;

procedure TFormCadastroPedido.ClearFormCadastro;
begin
  inherited;
  FListRemoveProdutosPedido.Clear;
  closePanelCadastroProdutoPedido;

  ChangeConsultaProdutoPedido;

  CalendarPickerDataEmissao.Date := Now;
  LabelTotalPedido.Caption       := '0,00';

  if ComboBoxCliente.Items.Count > 0 then
    ComboBoxCliente.ItemIndex := 0;
end;

procedure TFormCadastroPedido.ClearProdutoPedido;
begin
  FRecordDataSetProdutoPedido := 0;

  LabeledEditQuantidade.Clear;
  LabeledEditCodigoProdutoPedido.Clear;

  LabelValorUnitario.Caption := '0,00';
  LabelTotalProduto.Caption  := '0,00';

  if ComboBoxProduto.Items.Count > 0 then
    ComboBoxProduto.ItemIndex := 0;
end;

procedure TFormCadastroPedido.ClosePanelCadastroProdutoPedido;
begin
  ClearProdutoPedido;
  PanelCadastroProdutoPedido.Visible := False;
end;

procedure TFormCadastroPedido.ComboBoxProdutoSelect(Sender: TObject);
var
  LValor : Double;
begin
  inherited;
  try
    LValor := 0;

    if ComboBoxProduto.ItemIndex <= 0 then
      Exit;

    LValor := TProduto(ComboBoxProduto.Items.Objects[ComboBoxProduto.ItemIndex]).PrecoVenda;
  finally
    LabelValorUnitario.Caption := FormatFloat(',0.00', LValor);
    calcularTotalProduto;
  end;
end;

function TFormCadastroPedido.ConsistForm: Boolean;
begin
  Result := False;

  if CalendarPickerDataEmissao.Date = 0 then
  begin
    Application.MessageBox(PChar('Preencha da data de emiss�o.'),PChar('Aviso'),
      MB_OK + MB_ICONWARNING);

    Exit;
  end;

  if ComboBoxCliente.ItemIndex < 1 then
  begin
    Application.MessageBox(PChar('Selecione um cliente.'),PChar('Aviso'),
      MB_OK + MB_ICONWARNING);

    Exit;
  end;

  with DataSourceConsultaPedidoProduto do
  begin
    if (not Assigned(DataSet)) or
       (not DataSet.Active) or
       (DataSet.RecordCount = 0) then
    begin
      Application.MessageBox(PChar('Inclua produtos no pedido.'),PChar('Aviso'),
        MB_OK + MB_ICONWARNING);

      Exit;
    end;

    if PanelCadastroProdutoPedido.Visible then
    begin
      Application.MessageBox(PChar('Salve o produto do pedido antes de gravar o pedido.'),PChar('Aviso'),
        MB_OK + MB_ICONWARNING);

      Exit;
    end;
  end;

  Result := True;
end;

procedure TFormCadastroPedido.DBGridConsultaProdutoPedidoDblClick(
  Sender: TObject);
begin
  inherited;
  SpeedButtonAlterarProdutoPedido.Click;
end;

procedure TFormCadastroPedido.DBGridConsultaProdutoPedidoKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_INSERT then
  begin
    Key := 0;
    SpeedButtonNovoProdutoPedido.Click;
  end
  else
  if Key = VK_DELETE then
  begin
    Key := 0;
    SpeedButtonRemoverProdutoPedido.Click;
  end;
end;

procedure TFormCadastroPedido.DBGridConsultaProdutoPedidoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = Chr(VK_RETURN) then
  begin
    Key := #0;
    SpeedButtonAlterarProdutoPedido.Click;
  end;
end;

procedure TFormCadastroPedido.ExecuteAfterShowTabEdicao;
begin
  inherited;
  LoadInfoComboCliente;
  LoadInfoComboProduto;
end;

procedure TFormCadastroPedido.FillForm;
var
  LPedido : TPedido;
begin
  try
    inherited;

    LPedido := ObjectPost as TPedido;
    CalendarPickerDataEmissao.Date := LPedido.DataEmissao;
    LabelTotalPedido.Caption       := FormatFloat(',0.00', LPedido.ValorTotal);

    SelectItemComboCliente(LPedido.CodigoCliente);
    ChangeConsultaProdutoPedido;
  except
    raise;
  end;
end;

procedure TFormCadastroPedido.FillProdutoPedido;
begin
  with DataSourceConsultaPedidoProduto do
  begin
    SelectItemComboProduto(DataSet.FieldByName('CODIGO_PRODUTO').AsInteger);

    FRecordDataSetProdutoPedido         := DataSet.RecNo;
    LabeledEditCodigoProdutoPedido.Text := DataSet.FieldByName('CODIGO').AsString;
    LabeledEditQuantidade.Text          := DataSet.FieldByName('QUANTIDADE').AsString;
    LabelValorUnitario.Caption          := FormatFloat(',0.00', DataSet.FieldByName('VALOR_UNITARIO').AsFloat);
    LabelTotalProduto.Caption           := FormatFloat(',0.00', DataSet.FieldByName('VALOR_TOTAL').AsFloat);
  end;
end;

procedure TFormCadastroPedido.FormCreate(Sender: TObject);
begin
  inherited;
  FListRemoveProdutosPedido := TStringList.Create;
  FocusedControl := CalendarPickerDataEmissao;

end;

procedure TFormCadastroPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  removeListObjectsCombo(ComboBoxCliente);
  removeListObjectsCombo(ComboBoxProduto);

  FreeAndNil(FListRemoveProdutosPedido);

  if Assigned(FProdutoPedidoController) then
    FreeAndNil(FProdutoPedidoController)
end;

procedure TFormCadastroPedido.InstanceController;
begin
  inherited;
  Controller := TPedidoController.Create;
end;

procedure TFormCadastroPedido.InstanceProdutoPedidoController;
begin
  FProdutoPedidoController := TProdutoPedidoController.Create;
end;

procedure TFormCadastroPedido.LabeledEditQuantidadeChange(Sender: TObject);
begin
  inherited;
  calcularTotalProduto;
end;

procedure TFormCadastroPedido.LabeledEditQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  FormatterStringToDouble(TLabeledEdit(Sender), Key);
end;

procedure TFormCadastroPedido.LoadInfoComboCliente;
var
  LListCliente : TList<TBaseModel>;
  LModel       : TBaseModel;
  LCliente     : TCliente;
  LController  : TClienteController;
begin
  try
    removeListObjectsCombo(ComboBoxCliente);

    LController := TClienteController.Create;
    LListCliente := LController.FindAll;

    ComboBoxCliente.Clear;
    for LModel in LListCliente do
    begin
      LCliente := LModel as TCliente;
      ComboBoxCliente.Items.AddObject(LCliente.Nome, LCliente);
    end;

    ComboBoxCliente.Items.Insert(0, '-- SELECIONE UM CLIENTE --');
    ComboBoxCliente.ItemIndex := 0;
  finally
    FreeAndNil(LListCliente);
    FreeAndNil(LController)
  end;
end;

procedure TFormCadastroPedido.LoadInfoComboProduto;
var
  LListProduto : TList<TBaseModel>;
  LModel       : TBaseModel;
  LProduto     : TProduto;
  LController  : TProdutoController;
begin
  try
    removeListObjectsCombo(ComboBoxProduto);

    LController  := TProdutoController.Create;
    LListProduto := LController.FindAll;

    ComboBoxProduto.Clear;
    for LModel in LListProduto do
    begin
      LProduto := LModel as TProduto;
      ComboBoxProduto.Items.AddObject(LProduto.Descricao, LProduto);
    end;

    ComboBoxProduto.Items.Insert(0, '-- SELECIONE UM PRODUTO --');
    ComboBoxProduto.ItemIndex := 0;
  finally
    FreeAndNil(LListProduto);
    FreeAndNil(LController)
  end;
end;

procedure TFormCadastroPedido.PostForm;
var
  LPedido : TPedido;
begin
  try
    inherited;

    LPedido := ObjectPost as TPedido;
    LPedido.DataEmissao   := CalendarPickerDataEmissao.Date;
    LPedido.CodigoCliente := SelectedItemComboModel(ComboBoxCliente);
    LPedido.ValorTotal    := ConvertStringToDouble(LabelTotalPedido.Caption);
   except
    raise;
  end;
end;

procedure TFormCadastroPedido.SelectItemComboCliente(const ACodigo: Integer);
begin
  SelectItemComboModel(ACodigo, ComboBoxCliente);
end;

procedure TFormCadastroPedido.SelectItemComboProduto(const ACodigo: Integer);
begin
  SelectItemComboModel(ACodigo, ComboBoxProduto);
end;

procedure TFormCadastroPedido.SetAllImageButtons;
begin
  inherited;
  SetImageToButton(SpeedButtonNovoProdutoPedido,0);
  SetImageToButton(SpeedButtonAlterarProdutoPedido,1);
  SetImageToButton(SpeedButtonRemoverProdutoPedido,2);
  SetImageToButton(SpeedButtonSalvarProdutoPedido,3);
end;

procedure TFormCadastroPedido.SpeedButtonSalvarProdutoPedidoClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TFormCadastroPedido.SpeedButtonAlterarProdutoPedidoClick(
  Sender: TObject);
begin
  inherited;
  with DataSourceConsultaPedidoProduto do
  begin
    if not ConsistRecordsDataSet(DataSet) then
      Exit;

    ActivePanelCadastroProdutoPedido;
    FillProdutoPedido;
  end;
end;

procedure TFormCadastroPedido.SpeedButtonNovoProdutoPedidoClick(
  Sender: TObject);
begin
  inherited;
  ActivePanelCadastroProdutoPedido;
end;

procedure TFormCadastroPedido.SpeedButtonRemoverProdutoPedidoClick(
  Sender: TObject);
begin
  inherited;
  try
    with DataSourceConsultaPedidoProduto do
    begin
      if (not DataSet.Active) or
         (DataSet.RecordCount = 0) then
        raise Exception.Create('N�o existem informa��es para realizar a opera��o.');

      if Application.MessageBox(PChar('Deseja remover o registro?'),
          PChar('Confirma��o'), MB_YESNO + MB_ICONQUESTION) = IDNO then
        Exit;

      if DataSet.FieldByName('CODIGO').AsInteger > 0 then
        FListRemoveProdutosPedido.Add(DataSet.FieldByName('CODIGO').AsString);

      DataSet.Delete;
    end;

    MessageSuccessOperation;
  except
    raise;
  end;
end;

end.
