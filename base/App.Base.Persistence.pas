unit App.Base.Persistence;

interface

uses
  App.Base.Model, System.Generics.Collections, FireDAC.Comp.Client, Data.DB,
  System.Rtti, FireDAC.DApt;

type
  TProcFieldDataSet = procedure (const ADataSet: TFDMemTable) of object;

  TBasePersistence = class
  private
    FQuery           : TFDQuery;
    FQueryAux        : TFDQuery;
    FTableName       : String;
    FDataSetConsulta : TFDMemTable;
    FOrderBy         : String;

    function GetLastCodigo: Integer;
    function GetModelByDataSet(const AQuery: TFDQuery): TBaseModel; virtual;

    procedure CreateFieldsDataSet(const AQuery: TFDQuery);
    procedure SetInfoDataSet(const AQuery: TFDQuery);
    procedure SetOrderBy(const Value: String);

  protected
    function convertClassPropToTableField(Value: String): String;
      virtual; final;
    function convertTableFieldToClassProp(Value: String): String;
      virtual; final;

    function Insert(const AModel: TBaseModel): Integer; virtual;
    function Update(const AModel: TBaseModel): Integer; virtual;

    function GetNewInstanceModel: TBaseModel; virtual; abstract;

    procedure SetValueParamsByModel(const AQuery: TFDQuery;
      const AModel: TBaseModel; const AProperty: TRttiProperty);

    procedure SetDataSetByQuery(const AQuery: TFDQuery;
      const AProc: TProcFieldDataSet);
    procedure SetNameFieldDataSet(const ADataSet: TFDMemTable;
      const AFieldName, ADisplayLabel: String; const ASize: Integer=0;
      const AVisible: Boolean=True);

    procedure AfterCreateClass; virtual;

    property Query           : TFDQuery    read FQuery;
    property QueryAux        : TFDQuery    read FQueryAux;
    property TableName       : String      read FTableName;
    property DataSetConsulta : TFDMemTable read FDataSetConsulta;
    property OrderBy         : String                            write SetOrderBy;

  public
    constructor Create;
    destructor Destroy; override;

    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;

    function FindById(const ACodigo: Integer): TBaseModel; virtual;
    function FindAll: TList<TBaseModel>; virtual;

    function Delete(const ACodigo: Integer): Boolean; virtual;
    function Post(const AModel: TBaseModel): Integer;

    function GetResultSet: TFDMemTable; virtual; abstract;
    procedure ClearDataSetConsulta;
  end;

implementation

uses
  App.Conexao, System.SysUtils, App.Lib.Constants;

{ TBasePersistence }

procedure TBasePersistence.AfterCreateClass;
begin
//
end;

procedure TBasePersistence.ClearDataSetConsulta;
begin
  if (Assigned(FDataSetConsulta)) and
     (FDataSetConsulta.Active) then
    FDataSetConsulta.EmptyDataSet;
end;

procedure TBasePersistence.Commit;
begin
  DataModuleConexao.Commit;
end;

function TBasePersistence.convertClassPropToTableField(
  Value: String): String;
var
  i : Integer;
begin
  Result := LowerCase(Value[1]);

  for i := 2 to Value.Trim.Length do
  begin
    if (Ord(Value[i]) >= 65) and
       (Ord(Value[i]) <= 90) then
    begin
      Result := Result
              + '_'
              + LowerCase(Value[i]);
    end
    else
    begin
      Result := Result
              + LowerCase(Value[i]);
    end;
  end;
end;

function TBasePersistence.convertTableFieldToClassProp(
  Value: String): String;
var
  i        : Integer;
  LIsUpper : Boolean;
begin
  Value  := StringReplace(Value,'"',EmptyStr,[rfReplaceAll]);
  Result := UpperCase(Value[1]);

  LIsUpper := False;
  for i := 2 to Value.Trim.Length do
  begin
    if Value[i] = '_' then
      LIsUpper := True
    else
    begin
      if LIsUpper then
      begin
        Result := Result
                + UpperCase(Value[i]);

        LIsUpper := False;
      end
      else
        Result := Result
                + LowerCase(Value[i]);
    end;
  end;
end;

constructor TBasePersistence.Create;
begin
  FTableName := convertClassPropToTableField(
                  StringReplace(
                    Copy(Self.ClassName,2, Self.ClassName.Length),
                    'Persistence',
                    EmptyStr,
                    [rfReplaceAll]));

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := DataModuleConexao.GetConnection;

  FQueryAux := TFDQuery.Create(nil);
  FQueryAux.Connection := DataModuleConexao.GetConnection;

  FDataSetConsulta := TFDMemTable.Create(nil);

  AfterCreateClass;
end;

procedure TBasePersistence.CreateFieldsDataSet(const AQuery: TFDQuery);
var
  LField    : TField;
  LNewField : TField;
begin
  try
    for LField in AQuery.Fields do
    begin
      if Assigned(FDataSetConsulta.FindField(LField.FieldName)) then
        Continue;

      if (LField.DataType = ftInteger) or
         (LField.DataType = ftAutoInc) then
      begin
        LNewField := TIntegerField.Create(FDataSetConsulta);
        LNewField.FieldName := LField.FieldName;
        LNewField.DataSet   := FDataSetConsulta;
      end
      else
      if (LField.DataType = ftFloat) or
         (LField.DataType = ftCurrency) or
         (LField.DataType = ftExtended) then
      begin
        LNewField := TFloatField.Create(FDataSetConsulta);
        LNewField.FieldName                  := LField.FieldName;
        TFloatField(LNewField).DisplayFormat := ',0.00';
        LNewField.DataSet                    := FDataSetConsulta;
      end
      else
      if (LField.DataType = ftDateTime) or
         (LField.DataType = ftTimeStamp) then
      begin
        LNewField := TDateTimeField.Create(FDataSetConsulta);
        LNewField.FieldName                     := LField.FieldName;
        TDateTimeField(LNewField).DisplayFormat := 'dd/mm/yyyy';
        LNewField.DataSet                       := FDataSetConsulta;
      end
      else
      begin
        LNewField := TStringField.Create(FDataSetConsulta);
        LNewField.FieldName := LField.FieldName;
        LNewField.DataSet   := FDataSetConsulta;
      end
    end;
  except
    raise;
  end;
end;

function TBasePersistence.Delete(const ACodigo: Integer): Boolean;
var
  LSql : String;
begin
  try
    Result := False;

    LSql := 'delete from '+FTableName
          + ' where codigo = '+ACodigo.ToString;

    FQuery.Close;
    FQuery.SQL.Text := LSql;
    FQuery.ExecSQL;

    Result := True;
  except
    raise;
  end;
end;

destructor TBasePersistence.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FQueryAux);

  FreeAndNil(FDataSetConsulta);

  inherited;
end;

function TBasePersistence.FindAll: TList<TBaseModel>;
var
  LSql : String;
begin
  try
    Result := TList<TBaseModel>.Create;

    LSql := 'select * from '+FTableName;

    if not FOrderBy.IsEmpty then
      LSql := LSql
            + ' order by '
            + FOrderBy;

    FQuery.Close;
    FQuery.SQL.Text := LSql;
    FQuery.Open;

    FQuery.First;
    while not FQuery.Eof do
    begin
      Result.Add(GetModelByDataSet(FQuery));
      FQuery.Next;
    end;
  except
    raise;
  end;
end;

function TBasePersistence.FindById(const ACodigo: Integer): TBaseModel;
var
  LSql : String;
begin
  try
    Result := nil;

    LSql := 'select * from '+FTableName
          + ' where codigo = '+ACodigo.ToString;

    FQuery.Close;
    FQuery.SQL.Text := LSql;
    FQuery.Open;

    if not FQuery.IsEmpty then
      Result := GetModelByDataSet(FQuery);
  except
    raise;
  end;
end;

function TBasePersistence.GetLastCodigo: Integer;
var
  LSql : String;
begin
  try
    Result := 0;

    LSql := 'select max(codigo) as CODIGO from '+FTableName;

    FQuery.Close;
    FQuery.SQL.Text := LSql;
    FQuery.Open;

    if not FQuery.IsEmpty then
      Result := FQuery.FieldByName('CODIGO').AsInteger;
  except
    raise;
  end;
end;

function TBasePersistence.GetModelByDataSet(
  const AQuery: TFDQuery): TBaseModel;
var
  LContext  : TRttiContext;
  LType     : TRttiType;
  LProperty : TRttiProperty;
begin
  try
    try
      Result := GetNewInstanceModel;

      LContext := TRttiContext.Create;
      LType := LContext.GetType(Result.ClassInfo);

      for LProperty in LType.GetProperties do
      begin
        if AQuery.FieldByName(convertClassPropToTableField(LProperty.Name)).DataType in [ftDateTime, ftTimeStamp, ftDate] then
        begin
          LProperty.SetValue(
                      Result,
                      TValue.FromVariant(
                               AQuery.FieldByName(convertClassPropToTableField(LProperty.Name)).AsDateTime))
        end
        else
        begin
          LProperty.SetValue(
                      Result,
                      TValue.FromVariant(
                               AQuery.FieldByName(convertClassPropToTableField(LProperty.Name)).Value));
        end;
      end;
    finally
      LContext.Free;
    end;
  except
    raise;
  end;
end;

function TBasePersistence.Insert(const AModel: TBaseModel): Integer;
var
  LContext  : TRttiContext;
  LType     : TRttiType;
  LProperty : TRttiProperty;
  LSql      : String;
  LFields   : String;
  LParams   : String;
begin
  try
    try
      LContext := TRttiContext.Create;
      LType := LContext.GetType(AModel.ClassInfo);

      LFields := EmptyStr;
      LParams := EmptyStr;

      for LProperty in LType.GetProperties do
      begin
        if LProperty.Name.ToUpper = CODIGO then
          Continue;

        if not LFields.IsEmpty then
        begin
          LFields := LFields
                   + ', ';

          LParams := LParams
                   + ', ';
        end;

        LFields := LFields
                 + convertClassPropToTableField(LProperty.Name);

        LParams := LParams
                 + ':'
                 + convertClassPropToTableField(LProperty.Name)
      end;

      LSql := 'insert into '+FTableName+'('
            + LFields
            + ') values ('
            + LParams
            + ') ';

      FQuery.Close;
      FQuery.SQL.Text := LSql;

      for LProperty in LType.GetProperties do
      begin
        if LProperty.Name.ToUpper = CODIGO then
          Continue;

        SetValueParamsByModel(FQuery, AModel, LProperty);
      end;

      FQuery.ExecSQL;

      Result := GetLastCodigo;
    finally
      LContext.Free;
    end;
  except
    raise;
  end;
end;

function TBasePersistence.Post(const AModel: TBaseModel): Integer;
begin
  try
    Result := 0;

    if not Assigned(AModel) then
      raise Exception.Create('Não existe informações para a gravação dos dados.');

    if AModel.Codigo = 0 then
      Result := Insert(AModel)
    else
      Result := Update(AModel);
  except
    raise;
  end;
end;

procedure TBasePersistence.Rollback;
begin
  DataModuleConexao.Rollback;
end;

procedure TBasePersistence.SetDataSetByQuery(const AQuery: TFDQuery;
  const AProc: TProcFieldDataSet);
begin
  try
    if (not Assigned(AQuery)) then
      raise Exception.Create('Não foi possível efetuar a consulta dos dados');

    CreateFieldsDataSet(AQuery);

    if (Assigned(AProc)) and
       (not FDataSetConsulta.Active) then
    begin
      AProc(FDataSetConsulta);
    end;

    SetInfoDataSet(AQuery);

    AQuery.Close;
  except
    raise;
  end;
end;

procedure TBasePersistence.SetInfoDataSet(const AQuery: TFDQuery);
var
  LField : TField;
begin
  try
    if not FDataSetConsulta.Active then
      FDataSetConsulta.CreateDataSet;

    FDataSetConsulta.EmptyDataSet;

    AQuery.First;
    while not AQuery.Eof do
    begin
      FDataSetConsulta.Append;

      for LField in AQuery.Fields do
        FDataSetConsulta.FieldByName(LField.FieldName).Value := LField.Value;

      FDataSetConsulta.Post;
      AQuery.Next;
    end;
  except
    raise;
  end;
end;

procedure TBasePersistence.SetNameFieldDataSet(const ADataSet: TFDMemTable;
  const AFieldName, ADisplayLabel: String; const ASize: Integer;
  const AVisible: Boolean);
begin
  ADataSet.FieldByName(AFieldName).DisplayWidth := ASize;
  ADataSet.FieldByName(AFieldName).DisplayLabel := ADisplayLabel.Trim;
  ADataSet.FieldByName(AFieldName).Visible      := AVisible;
end;

procedure TBasePersistence.SetOrderBy(const Value: String);
begin
  FOrderBy := Value;
end;

procedure TBasePersistence.SetValueParamsByModel(const AQuery: TFDQuery;
  const AModel: TBaseModel; const AProperty: TRttiProperty);
begin
  try
    if (AProperty.PropertyType.Name.ToUpper = TYPE_INTEGER) then
      AQuery.ParamByName(convertClassPropToTableField(AProperty.Name)).AsInteger := AProperty.GetValue(AModel).ToString.ToInteger
    else
    if (AProperty.PropertyType.Name.ToUpper = TYPE_FLOAT) or
       (AProperty.PropertyType.Name.ToUpper = TYPE_DOUBLE) or
       (AProperty.PropertyType.Name.ToUpper = TYPE_EXTEND) then
      AQuery.ParamByName(convertClassPropToTableField(AProperty.Name)).AsFloat := AProperty.GetValue(AModel).ToString.ToDouble
    else
    if (AProperty.PropertyType.Name.ToUpper = TYPE_TDATETIME) then
      AQuery.ParamByName(convertClassPropToTableField(AProperty.Name)).AsDateTime := StrToDateTime(AProperty.GetValue(AModel).ToString)
    else
      AQuery.ParamByName(convertClassPropToTableField(AProperty.Name)).AsString := AProperty.GetValue(AModel).ToString;
  except
    raise;
  end;
end;

procedure TBasePersistence.StartTransaction;
begin
  DataModuleConexao.StartTransaction;
end;

function TBasePersistence.Update(const AModel: TBaseModel): Integer;
var
  LContext      : TRttiContext;
  LType         : TRttiType;
  LProperty     : TRttiProperty;
  LSql          : String;
  LFieldsParams : String;
begin
  try
    try
      LContext := TRttiContext.Create;
      LType := LContext.GetType(AModel.ClassInfo);

      LFieldsParams := EmptyStr;

      for LProperty in LType.GetProperties do
      begin
        if LProperty.Name.ToUpper = CODIGO then
          Continue;

        if not LFieldsParams.IsEmpty then
        begin
          LFieldsParams := LFieldsParams
                   + ', ';
        end;

        LFieldsParams := LFieldsParams
                 + convertClassPropToTableField(LProperty.Name)
                 + ' = :'
                 + convertClassPropToTableField(LProperty.Name);
      end;

      LSql := 'update '+FTableName
            + '   set '+LFieldsParams
            + ' where codigo = '+AModel.Codigo.ToString;

      FQuery.Close;
      FQuery.SQL.Text := LSql;

      for LProperty in LType.GetProperties do
      begin
        if LProperty.Name.ToUpper = CODIGO then
          Continue;

        SetValueParamsByModel(FQuery, AModel, LProperty);
      end;

      FQuery.ExecSQL;

      Result := AModel.Codigo;
    finally
      LContext.Free;
    end;
  except
    raise;
  end;
end;

end.
