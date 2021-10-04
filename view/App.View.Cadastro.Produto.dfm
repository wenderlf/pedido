inherited FormCadastroProduto: TFormCadastroProduto
  Caption = 'Cadastro de Produtos'
  ClientWidth = 491
  ExplicitWidth = 497
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControlPrincipal: TPageControl
    Width = 491
    inherited TabSheetConsulta: TTabSheet
      inherited PanelButtons: TPanel
        Width = 483
      end
      inherited DBGridConsulta: TDBGrid
        Width = 483
      end
    end
    inherited TabSheetEdicao: TTabSheet
      inherited PanelControlsEdicao: TPanel
        Width = 483
        inherited SpeedButtonSalvar: TSpeedButton
          Left = 422
        end
      end
      inherited PanelConteudo: TPanel
        Width = 483
        object LabeledEditDescricao: TLabeledEdit
          Left = 8
          Top = 72
          Width = 457
          Height = 21
          CharCase = ecUpperCase
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Descri'#231#227'o'
          MaxLength = 100
          TabOrder = 1
        end
        object LabeledEditPrecoVenda: TLabeledEdit
          Left = 8
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 75
          EditLabel.Height = 13
          EditLabel.Caption = 'Pre'#231'o de Venda'
          MaxLength = 20
          TabOrder = 2
          OnKeyPress = LabeledEditPrecoVendaKeyPress
        end
      end
    end
  end
  inherited StatusBar1: TStatusBar
    Width = 491
  end
end
