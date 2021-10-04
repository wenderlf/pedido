inherited FormCadastroCliente: TFormCadastroCliente
  Caption = 'Cadastro de Clientes'
  ClientWidth = 547
  ExplicitWidth = 553
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControlPrincipal: TPageControl
    Width = 547
    ActivePage = TabSheetEdicao
    inherited TabSheetConsulta: TTabSheet
      inherited PanelButtons: TPanel
        Width = 539
      end
      inherited DBGridConsulta: TDBGrid
        Width = 539
      end
    end
    inherited TabSheetEdicao: TTabSheet
      inherited PanelControlsEdicao: TPanel
        Width = 539
        inherited SpeedButtonSalvar: TSpeedButton
          Left = 478
        end
      end
      inherited PanelConteudo: TPanel
        Width = 539
        object LabeledEditNome: TLabeledEdit
          Left = 8
          Top = 72
          Width = 513
          Height = 21
          CharCase = ecUpperCase
          EditLabel.Width = 78
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome do Cliente'
          MaxLength = 100
          TabOrder = 1
        end
        object LabeledEditCidade: TLabeledEdit
          Left = 8
          Top = 120
          Width = 513
          Height = 21
          CharCase = ecUpperCase
          EditLabel.Width = 33
          EditLabel.Height = 13
          EditLabel.Caption = 'Cidade'
          MaxLength = 50
          TabOrder = 2
        end
        object LabeledEditUf: TLabeledEdit
          Left = 8
          Top = 168
          Width = 34
          Height = 21
          CharCase = ecUpperCase
          EditLabel.Width = 13
          EditLabel.Height = 13
          EditLabel.Caption = 'UF'
          MaxLength = 2
          TabOrder = 3
        end
      end
    end
  end
  inherited StatusBar1: TStatusBar
    Width = 547
  end
end
