inherited FormCadastroPedido: TFormCadastroPedido
  Caption = 'Movimenta'#231#245'es de Pedidos'
  ClientWidth = 743
  ExplicitWidth = 749
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControlPrincipal: TPageControl
    Width = 743
    ActivePage = TabSheetEdicao
    ExplicitWidth = 743
    inherited TabSheetConsulta: TTabSheet
      ExplicitWidth = 735
      inherited PanelButtons: TPanel
        Width = 735
        ExplicitWidth = 735
      end
      inherited DBGridConsulta: TDBGrid
        Width = 735
      end
    end
    inherited TabSheetEdicao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 27
      ExplicitWidth = 735
      ExplicitHeight = 473
      inherited PanelControlsEdicao: TPanel
        Width = 735
        ExplicitWidth = 735
        inherited SpeedButtonSalvar: TSpeedButton
          Left = 674
          ExplicitLeft = 674
        end
      end
      inherited PanelConteudo: TPanel
        Width = 735
        ExplicitWidth = 735
        object Label1: TLabel [0]
          Left = 119
          Top = 9
          Width = 79
          Height = 13
          Caption = 'Data de Emiss'#227'o'
        end
        object Label2: TLabel [1]
          Left = 246
          Top = 9
          Width = 33
          Height = 13
          Caption = 'Cliente'
        end
        object Label4: TLabel [2]
          Left = 617
          Top = 9
          Width = 74
          Height = 13
          Caption = 'Total do Pedido'
        end
        object LabelTotalPedido: TLabel [3]
          Left = 686
          Top = 22
          Width = 35
          Height = 19
          Alignment = taRightJustify
          Caption = '0,00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object PanelProdutoPedido: TPanel [4]
          Left = 0
          Top = 64
          Width = 731
          Height = 348
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object Label3: TLabel
            Left = 0
            Top = 0
            Width = 731
            Height = 25
            Align = alTop
            Alignment = taCenter
            AutoSize = False
            Caption = 'ITENS DO PEDIDO'
            Color = clBlack
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
            Transparent = False
            ExplicitWidth = 658
          end
          object PanelButtonsProdutoPedido: TPanel
            Left = 0
            Top = 25
            Width = 731
            Height = 49
            Align = alTop
            Color = clWhite
            ParentBackground = False
            TabOrder = 0
            object SpeedButtonNovoProdutoPedido: TSpeedButton
              Left = 1
              Top = 1
              Width = 45
              Height = 47
              Align = alLeft
              Flat = True
              OnClick = SpeedButtonNovoProdutoPedidoClick
              ExplicitLeft = -17
              ExplicitTop = -2
              ExplicitHeight = 45
            end
            object SpeedButtonAlterarProdutoPedido: TSpeedButton
              Left = 46
              Top = 1
              Width = 45
              Height = 47
              Align = alLeft
              Flat = True
              OnClick = SpeedButtonAlterarProdutoPedidoClick
              ExplicitLeft = 52
              ExplicitTop = -4
            end
            object SpeedButtonRemoverProdutoPedido: TSpeedButton
              Left = 91
              Top = 1
              Width = 45
              Height = 47
              Align = alLeft
              Flat = True
              OnClick = SpeedButtonRemoverProdutoPedidoClick
              ExplicitLeft = 8
              ExplicitTop = 0
              ExplicitHeight = 45
            end
          end
          object PanelCadastroProdutoPedido: TPanel
            Left = 0
            Top = 74
            Width = 731
            Height = 55
            Align = alTop
            TabOrder = 1
            DesignSize = (
              731
              55)
            object SpeedButtonSalvarProdutoPedido: TSpeedButton
              Left = 699
              Top = 23
              Width = 22
              Height = 22
              Anchors = [akTop, akRight]
              Flat = True
              OnClick = SpeedButtonSalvarProdutoPedidoClick
            end
            object Label5: TLabel
              Left = 119
              Top = 9
              Width = 38
              Height = 13
              Caption = 'Produto'
            end
            object Label7: TLabel
              Left = 505
              Top = 9
              Width = 64
              Height = 13
              Caption = 'Valor Unit'#225'rio'
            end
            object Label8: TLabel
              Left = 592
              Top = 9
              Width = 65
              Height = 13
              Caption = 'Total Produto'
            end
            object LabelTotalProduto: TLabel
              Left = 592
              Top = 24
              Width = 81
              Height = 21
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0,00'
              Color = clBlue
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Transparent = False
              Layout = tlCenter
            end
            object LabelValorUnitario: TLabel
              Left = 505
              Top = 24
              Width = 81
              Height = 21
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0,00'
              Color = clBlue
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Transparent = True
              Layout = tlCenter
            end
            object LabeledEditCodigoProdutoPedido: TLabeledEdit
              Left = 8
              Top = 24
              Width = 97
              Height = 21
              EditLabel.Width = 33
              EditLabel.Height = 13
              EditLabel.Caption = 'C'#243'digo'
              Enabled = False
              TabOrder = 0
            end
            object ComboBoxProduto: TComboBox
              Left = 119
              Top = 24
              Width = 281
              Height = 21
              Style = csDropDownList
              TabOrder = 1
            end
            object LabeledEditQuantidade: TLabeledEdit
              Left = 413
              Top = 24
              Width = 82
              Height = 21
              Alignment = taRightJustify
              EditLabel.Width = 56
              EditLabel.Height = 13
              EditLabel.Caption = 'Quantidade'
              TabOrder = 2
              OnKeyPress = LabeledEditQuantidadeKeyPress
            end
          end
          object DBGridConsultaProdutoPedido: TDBGrid
            Left = 0
            Top = 129
            Width = 731
            Height = 219
            Align = alClient
            DataSource = DataSourceConsultaPedidoProduto
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            TabOrder = 2
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDblClick = DBGridConsultaProdutoPedidoDblClick
            OnKeyDown = DBGridConsultaProdutoPedidoKeyDown
            OnKeyPress = DBGridConsultaProdutoPedidoKeyPress
          end
        end
        inherited LabeledEditCodigo: TLabeledEdit
          EditLabel.Width = 87
          EditLabel.Caption = 'N'#250'mero do Pedido'
          EditLabel.ExplicitWidth = 87
          TabOrder = 1
        end
        object CalendarPickerDataEmissao: TCalendarPicker
          Left = 119
          Top = 24
          Width = 114
          Height = 21
          CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
          CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
          CalendarHeaderInfo.DaysOfWeekFont.Height = -13
          CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
          CalendarHeaderInfo.DaysOfWeekFont.Style = []
          CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
          CalendarHeaderInfo.Font.Color = clWindowText
          CalendarHeaderInfo.Font.Height = -20
          CalendarHeaderInfo.Font.Name = 'Segoe UI'
          CalendarHeaderInfo.Font.Style = []
          Color = clWindow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          TextHint = 'select a date'
        end
        object ComboBoxCliente: TComboBox
          Left = 246
          Top = 24
          Width = 355
          Height = 21
          Style = csDropDownList
          TabOrder = 3
        end
      end
    end
  end
  inherited StatusBar1: TStatusBar
    Width = 743
    ExplicitWidth = 743
  end
  object DataSourceConsultaPedidoProduto: TDataSource
    Left = 316
    Top = 435
  end
end
