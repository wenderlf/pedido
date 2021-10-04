unit App.Base.View.Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.Base.View, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, App.Base.Controller, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, App.Base.Model, Data.DB;

type
  TFormBaseCadastro = class(TFormBase)
    PageControlPrincipal: TPageControl;
    StatusBar1: TStatusBar;
    TabSheetConsulta: TTabSheet;
    TabSheetEdicao: TTabSheet;
    PanelButtons: TPanel;
    SpeedButtonNovo: TSpeedButton;
    SpeedButtonRemover: TSpeedButton;
    SpeedButtonAlterar: TSpeedButton;
    ImageListButtons: TImageList;
    DBGridConsulta: TDBGrid;
    DataSourceConsulta: TDataSource;
    PanelControlsEdicao: TPanel;
    PanelConteudo: TPanel;
    SpeedButtonSalvar: TSpeedButton;
    LabeledEditCodigo: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButtonNovoClick(Sender: TObject);
    procedure SpeedButtonRemoverClick(Sender: TObject);
    procedure SpeedButtonSalvarClick(Sender: TObject);
    procedure TabSheetEdicaoShow(Sender: TObject);
    procedure TabSheetConsultaShow(Sender: TObject);
    procedure SpeedButtonAlterarClick(Sender: TObject);
    procedure DBGridConsultaDblClick(Sender: TObject);
  private
    { Private declarations }
    FController     : TBaseController;
    FObjectPost     : TBaseModel;
    FFocusedControl : TWinControl;

    procedure SetController(const Value: TBaseController);
    procedure SetObjectPost(const Value: TBaseModel);
    procedure SetFocusedControl(const Value: TWinControl);

  protected
    procedure MessageSuccessOperation;
    function ConsistRecordsDataSet(const ADataSet: TDataSet): Boolean;
    procedure removeListObjectsCombo(const ACombo: TComboBox);
    procedure FormatterStringToDouble(const ALabeledEdit: TLabeledEdit;
      var AKey: Char);
    function ConvertStringToDouble(const Value: String): Double;

    function SelectedItemComboModel(const ACombo: TComboBox): Integer;
    procedure SelectItemComboModel(const ACodigo: Integer;
      const ACombo: TComboBox);

    procedure SetAllImageButtons; virtual;
    procedure SetImageToButton(const Button: TSpeedButton;
      const AIndexImage: Integer);

    procedure InstanceController; virtual; abstract;
    procedure InstanceObjectPost; virtual; abstract;
    procedure ChangeConsulta; virtual;

    procedure ExecuteAfterShowTabEdicao; virtual;
    procedure ClearFormCadastro; virtual;
    procedure FillForm; virtual;
    procedure PostForm; virtual;
    function ConsistForm: Boolean; virtual; abstract;

    property Controller     : TBaseController read FController write SetController;
    property ObjectPost     : TBaseModel      read FObjectPost write SetObjectPost;
    property FocusedControl : TWinControl                      write SetFocusedControl;

  public
    { Public declarations }
  end;

var
  FormBaseCadastro: TFormBaseCadastro;

implementation

{$R *.dfm}

procedure TFormBaseCadastro.ChangeConsulta;
begin
  try
    DataSourceConsulta.Enabled := False;
    DataSourceConsulta.DataSet := FController.GetResultSet;
    DataSourceConsulta.DataSet.First;

    DBGridConsulta.DataSource  := DataSourceConsulta;
  finally
    DataSourceConsulta.Enabled := True;
  end;
end;

procedure TFormBaseCadastro.ClearFormCadastro;
begin
  if Assigned(FObjectPost) then
    FreeAndNil(FObjectPost);

  LabeledEditCodigo.Clear;

  if Assigned(FFocusedControl) then
    FFocusedControl.SetFocus;
end;

function TFormBaseCadastro.ConsistRecordsDataSet(
  const ADataSet: TDataSet): Boolean;
begin
  Result := True;
  if (not ADataSet.Active) or
     (ADataSet.RecordCount = 0) then
  begin
    Result := False;

    Application.MessageBox(PChar('Não existe registro para alteração'),PChar('Aviso'),
      MB_OK + MB_ICONWARNING);
  end;
end;

function TFormBaseCadastro.ConvertStringToDouble(const Value: String): Double;
var
  LValorString : String;
begin
  LValorString := StringReplace(Value, '.', EmptyStr, [rfReplaceAll]);
//  LValorString := StringReplace(LValorString, ',', '.', [rfReplaceAll]);

  Result := StrToFloatDef(LValorString, 0);
end;

procedure TFormBaseCadastro.DBGridConsultaDblClick(Sender: TObject);
begin
  inherited;
  SpeedButtonAlterar.Click;
end;

procedure TFormBaseCadastro.DBGridConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_INSERT then
  begin
    Key := 0;
    SpeedButtonNovo.Click;
  end
  else
  if Key = VK_DELETE then
  begin
    Key := 0;
    SpeedButtonRemover.Click;
  end;
end;

procedure TFormBaseCadastro.DBGridConsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = Chr(VK_RETURN) then
  begin
    Key := #0;
    SpeedButtonAlterar.Click;
  end;
end;

procedure TFormBaseCadastro.ExecuteAfterShowTabEdicao;
begin
//
end;

procedure TFormBaseCadastro.FillForm;
begin
  LabeledEditCodigo.Text := FObjectPost.Codigo.ToString;
end;

//procedure TFormBaseCadastro.FormClose(Sender: TObject;
//  var Action: TCloseAction);
//begin
//  inherited;
//  Action := caFree;
//  Release;
//  Self := nil;
//end;

procedure TFormBaseCadastro.FormatterStringToDouble(
  const ALabeledEdit: TLabeledEdit; var AKey: Char);
var
  LValorString : String;
  LValorDouble : Double;
begin
  if not (AKey in ['0'..'9', #8, #9]) then
  begin
    AKey := #0;
    Exit;
  end;

  if (AKey in ['0'..'9', #8, #9]) then
  begin
    LValorString := ALabeledEdit.Text;

    if LValorString = EmptyStr then
      LValorString := '0,00' ;

    if AKey in ['0'..'9'] then
      LValorString := Concat(LValorString, AKey);

    LValorString := Trim(StringReplace(LValorString, '.', EmptyStr, [rfReplaceAll, rfIgnoreCase]));
    LValorString := Trim(StringReplace(LValorString, ',', EmptyStr, [rfReplaceAll, rfIgnoreCase]));

    LValorDouble := StrToFloat(LValorString);
    LValorDouble := (LValorDouble / 100);

    ALabeledEdit.SelStart := Length(ALabeledEdit.Text);
    ALabeledEdit.Text     := FormatFloat(',0.00', LValorDouble);
  end;

  if not(AKey in [#8, #9]) then
    AKey := #0;
end;

procedure TFormBaseCadastro.FormCreate(Sender: TObject);
begin
  Self.Visible := False;

  inherited;

  PageControlPrincipal.ActivePage := TabSheetConsulta;
  SetAllImageButtons;

  InstanceController;
//  changeConsulta;
end;

procedure TFormBaseCadastro.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FController) then
    FreeAndNil(FController);

  if Assigned(FObjectPost) then
    FreeAndNil(FObjectPost);
end;

procedure TFormBaseCadastro.MessageSuccessOperation;
begin
  Application.MessageBox(PChar('Operação realizada com sucesso.'),
          PChar('Informação'), MB_OK + MB_ICONINFORMATION)
end;

procedure TFormBaseCadastro.PostForm;
begin
  FObjectPost.Codigo := StrToIntDef(LabeledEditCodigo.Text, 0);
end;

procedure TFormBaseCadastro.removeListObjectsCombo(const ACombo: TComboBox);
var
  i      : Integer;
  LModel : TObject;
begin
  for i := Pred(ACombo.Items.Count) downto 1 do
  begin
    LModel := ACombo.Items.Objects[i];
    FreeAndNil(LModel);
  end;

  ACombo.Clear;
end;

function TFormBaseCadastro.SelectedItemComboModel(
  const ACombo: TComboBox): Integer;
var
  LModel : TBaseModel;
begin
  Result := 0;

  if ACombo.ItemIndex <= 0 then
  begin
    Application.MessageBox(PChar('Selecione um item válido'),PChar('Aviso'),
      MB_OK + MB_ICONWARNING);

    Exit;
  end;

  Result := (ACombo.Items.Objects[ACombo.ItemIndex] as TBaseModel).Codigo;
end;

procedure TFormBaseCadastro.SelectItemComboModel(const ACodigo: Integer;
  const ACombo: TComboBox);
var
  i      : Integer;
  LModel : TBaseModel;
begin
  if ACombo.Items.Count <= 1 then
  begin
    Application.MessageBox(PChar('Não existe itens para seleção'),PChar('Aviso'),
      MB_OK + MB_ICONWARNING);

    Exit;
  end;

  for i := 1 to Pred(ACombo.Items.Count) do
  begin
    LModel := ACombo.Items.Objects[i] as TBaseModel;
    if LModel.Codigo = ACodigo then
    begin
      ACombo.ItemIndex := i;
      Break;
    end;
  end;
end;

procedure TFormBaseCadastro.SetAllImageButtons;
begin
  SetImageToButton(SpeedButtonNovo,0);
  SetImageToButton(SpeedButtonAlterar,1);
  SetImageToButton(SpeedButtonRemover,2);
  SetImageToButton(SpeedButtonSalvar,3);
end;

procedure TFormBaseCadastro.SetController(const Value: TBaseController);
begin
  FController := Value;
end;

procedure TFormBaseCadastro.SetFocusedControl(const Value: TWinControl);
begin
  FFocusedControl := Value;
end;

procedure TFormBaseCadastro.SetImageToButton(const Button: TSpeedButton;
  const AIndexImage: Integer);
var
  LImage : TBitmap;
begin
  try
    LImage := TBitmap.Create;

    ImageListButtons.GetBitmap(AIndexImage, LImage);
    Button.Glyph.Assign(LImage);
  finally
    FreeAndNil(LImage);
  end;
end;

procedure TFormBaseCadastro.SetObjectPost(const Value: TBaseModel);
begin
  FObjectPost := Value;
end;

procedure TFormBaseCadastro.SpeedButtonAlterarClick(Sender: TObject);
begin
  inherited;
  with DataSourceConsulta do
  begin
    if not ConsistRecordsDataSet(DataSet) then
      Exit;

    PageControlPrincipal.ActivePage := TabSheetEdicao;
    FObjectPost := FController.FindById(DataSet.FieldByName('CODIGO').AsInteger);

    if not Assigned(FObjectPost) then
    begin
      Application.MessageBox(PChar('Registro não encontrato'),PChar('Aviso'),
        MB_OK + MB_ICONWARNING);
      Exit;
    end;

    FillForm;
  end;
end;

procedure TFormBaseCadastro.SpeedButtonNovoClick(Sender: TObject);
begin
  inherited;
  PageControlPrincipal.ActivePage := TabSheetEdicao;
end;

procedure TFormBaseCadastro.SpeedButtonRemoverClick(Sender: TObject);
var
  LRecordPosition : Integer;
begin
  inherited;
  with DataSourceConsulta do
  try
    if (not DataSet.Active) or
       (DataSet.RecordCount = 0) then
      raise Exception.Create('Não existem informações para realizar a operação.');

    if Application.MessageBox(PChar('Deseja remover o registro?'),
        PChar('Confirmação'), MB_YESNO + MB_ICONQUESTION) = IDNO then
      Exit;

    LRecordPosition := DataSet.RecNo;
    FController.Delete(DataSet.FieldByName('CODIGO').AsInteger);
    MessageSuccessOperation;

    ChangeConsulta;
    if LRecordPosition <= DataSet.RecordCount then
      DataSet.RecNo := LRecordPosition
    else
    if DataSet.RecordCount > 0 then
      DataSet.RecNo := DataSet.RecordCount;
  except
    raise;
  end;
end;

procedure TFormBaseCadastro.SpeedButtonSalvarClick(Sender: TObject);
var
  LCodigo : Integer;
begin
  inherited;
  if not ConsistForm then
    Exit;

  try
    try
      LCodigo := StrToIntDef(LabeledEditCodigo.Text, 0);
      InstanceObjectPost;
      PostForm;

      FController.Post(FObjectPost);
    finally
      FreeAndNil(FObjectPost);
    end;

    MessageSuccessOperation;
    TabSheetEdicaoShow(Sender);

    if LCodigo > 0 then
    begin
      PageControlPrincipal.ActivePage := TabSheetConsulta;
      TabSheetEdicaoShow(Sender);
      DataSourceConsulta.DataSet.Locate('CODIGO', LCodigo, []);
    end;
  except
    raise;
  end;
end;

procedure TFormBaseCadastro.TabSheetConsultaShow(Sender: TObject);
begin
  inherited;
  ChangeConsulta;
  DBGridConsulta.SetFocus;
end;

procedure TFormBaseCadastro.TabSheetEdicaoShow(Sender: TObject);
begin
  inherited;
  ExecuteAfterShowTabEdicao;
  ClearFormCadastro;
end;

end.
