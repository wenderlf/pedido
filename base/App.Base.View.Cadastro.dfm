inherited FormBaseCadastro: TFormBaseCadastro
  Align = alCustom
  BorderIcons = [biSystemMenu]
  Caption = 'FormBaseCadastro'
  KeyPreview = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControlPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 670
    Height = 504
    ActivePage = TabSheetConsulta
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheetConsulta: TTabSheet
      Caption = 'Consulta'
      OnShow = TabSheetConsultaShow
      object PanelButtons: TPanel
        Left = 0
        Top = 0
        Width = 662
        Height = 49
        Align = alTop
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object SpeedButtonNovo: TSpeedButton
          Left = 0
          Top = 0
          Width = 45
          Height = 45
          Align = alLeft
          Flat = True
          OnClick = SpeedButtonNovoClick
          ExplicitLeft = -17
          ExplicitTop = -2
        end
        object SpeedButtonRemover: TSpeedButton
          Left = 90
          Top = 0
          Width = 45
          Height = 45
          Align = alLeft
          Flat = True
          OnClick = SpeedButtonRemoverClick
          ExplicitLeft = 8
        end
        object SpeedButtonAlterar: TSpeedButton
          Left = 45
          Top = 0
          Width = 45
          Height = 45
          Align = alLeft
          Flat = True
          OnClick = SpeedButtonAlterarClick
          ExplicitLeft = 8
        end
      end
      object DBGridConsulta: TDBGrid
        Left = 0
        Top = 49
        Width = 662
        Height = 424
        Align = alClient
        DataSource = DataSourceConsulta
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = DBGridConsultaDblClick
        OnKeyDown = DBGridConsultaKeyDown
        OnKeyPress = DBGridConsultaKeyPress
      end
    end
    object TabSheetEdicao: TTabSheet
      Caption = 'Edi'#231#227'o'
      ImageIndex = 1
      OnShow = TabSheetEdicaoShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object PanelControlsEdicao: TPanel
        Left = 0
        Top = 416
        Width = 662
        Height = 57
        Align = alBottom
        BevelKind = bkTile
        BevelOuter = bvNone
        Padding.Top = 3
        Padding.Right = 10
        Padding.Bottom = 3
        TabOrder = 1
        object SpeedButtonSalvar: TSpeedButton
          Left = 601
          Top = 3
          Width = 47
          Height = 47
          Align = alRight
          Flat = True
          OnClick = SpeedButtonSalvarClick
          ExplicitLeft = 603
        end
      end
      object PanelConteudo: TPanel
        Left = 0
        Top = 0
        Width = 662
        Height = 416
        Align = alClient
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 0
        object LabeledEditCodigo: TLabeledEdit
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
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 504
    Width = 670
    Height = 19
    Panels = <>
  end
  object ImageListButtons: TImageList
    Left = 52
    Top = 435
    Bitmap = {
      494C010104000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD004B4B
      4B00333333003333330033333300333333003333330033333300333333003333
      33004B4B4B00BDBDBD000000000000000000717171008C8C8C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007E7E
      7E00333333003333330033333300333333003333330033333300333333003333
      33007E7E7E000000000000000000000000000000000033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330033333300000000000000000000000000333333005858
      5800000000000000000000000000000000000000000000000000000000000000
      0000585858003333330000000000000000008C8C8C0033333300333333003333
      3300333333005858580000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000333333003333
      3300000000000000000000000000000000000000000000000000000000000000
      0000333333003333330000000000000000003333330033333300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003333330000000000000000000000000033333300000000000000
      0000000000007E7E7E0033333300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000333333003333
      3300000000003333330000000000333333003333330000000000333333000000
      0000333333003333330000000000000000003333330033333300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003333330000000000000000000000000033333300000000000000
      0000B0B0B00000000000333333007E7E7E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000333333003333
      3300000000003333330000000000333333003333330000000000333333000000
      0000333333003333330000000000000000003333330033333300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003333330000000000000000000000000033333300000000007E7E
      7E00333333003333330000000000333333003333330000000000000000000000
      0000000000000000000000000000000000000000000000000000333333003333
      3300000000003333330000000000333333003333330000000000333333000000
      0000333333003333330000000000000000003333330033333300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000033333300000000000000000000000000585858007E7E7E000000
      00003333330033333300B0B0B0007E7E7E00333333007E7E7E00000000000000
      0000000000000000000000000000000000000000000000000000333333003333
      3300000000003333330000000000333333003333330000000000333333000000
      0000333333003333330000000000000000003333330033333300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003333330000000000000000000000000000000000333333003333
      3300000000007E7E7E0033333300B0B0B00000000000333333007E7E7E000000
      0000000000000000000000000000000000000000000000000000333333003333
      3300000000003333330000000000333333003333330000000000333333000000
      0000333333003333330000000000000000003333330033333300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003333330000000000000000000000000000000000000000007E7E
      7E00333333007E7E7E007E7E7E00333333003333330000000000333333003333
      3300000000000000000000000000000000000000000000000000333333003333
      3300000000003333330000000000333333003333330000000000333333000000
      0000333333003333330000000000000000003333330033333300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003333330000000000000000000000000000000000000000000000
      00003333330033333300000000003333330033333300B0B0B0007E7E7E003333
      33008C8C8C000000000000000000000000000000000000000000333333003333
      3300000000003333330000000000333333003333330000000000333333000000
      0000333333003333330000000000000000003333330033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003333330000000000000000000000000000000000000000000000
      0000000000007E7E7E0033333300000000007E7E7E0033333300B0B0B0000000
      0000B0B0B0003333330000000000000000000000000000000000333333003333
      3300000000003333330000000000333333003333330000000000333333000000
      0000333333003333330000000000000000003333330033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000989898003333330000000000000000000000000000000000000000000000
      000000000000000000007E7E7E00333333007E7E7E007E7E7E00D7D7D700B0B0
      B000333333003E3E3E00D7D7D7000000000000000000CBCBCB00333333003333
      3300CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB003333330033333300CBCBCB00000000003333330033333300333333000000
      0000000000000000000000000000000000000000000033333300333333000000
      0000333333003333330033333300333333000000000000000000333333000000
      000000000000000000000000000000000000000000003E3E3E00333333003333
      3300333333003333330000000000000000000000000000000000000000000000
      0000000000000000000000000000333333003333330000000000B0B0B0003333
      33003E3E3E00D7D7D7003E3E3E00BDBDBD000000000033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330033333300000000003333330033333300333333000000
      0000000000000000000000000000000000000000000033333300333333000000
      0000333333003333330033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000033333300333333003333
      3300333333005858580000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C8C8C00B0B0B000333333003E3E
      3E00D7D7D7003E3E3E0033333300656565000000000000000000333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330000000000000000003333330033333300333333000000
      0000000000000000000000000000000000000000000033333300333333000000
      0000333333003333330033333300333333000000000000000000333333000000
      0000000000000000000000000000000000000000000033333300333333003333
      3300585858000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000333333003E3E3E00D7D7
      D7003E3E3E003333330033333300989898000000000000000000333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      3300333333003333330000000000000000003333330033333300333333000000
      0000000000000000000000000000000000000000000033333300333333000000
      0000333333003333330033333300656565000000000000000000333333005858
      5800000000000000000000000000000000000000000033333300333333005858
      5800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D7D7D7003E3E
      3E0033333300333333007E7E7E00000000000000000000000000000000000000
      0000000000004B4B4B007E7E7E0000000000000000007E7E7E004B4B4B000000
      0000000000000000000000000000000000003333330033333300333333000000
      0000000000000000000000000000000000000000000033333300333333000000
      0000333333003333330058585800000000000000000000000000BDBDBD004B4B
      4B00333333003333330033333300333333003333330033333300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BD004B4B4B009898980000000000000000000000000000000000000000000000
      000000000000000000004B4B4B00333333003333330058585800000000000000
      0000000000000000000000000000000000000000000033333300333333003333
      3300333333003333330033333300333333003333330033333300333333003333
      330033333300656565000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C0033FFFE0078001CFF303FFCFF33FFC
      DFFBB9FFCA533FFCDFFBB4FFCA533FFCDFFBA27FCA533FFCDFFB903FCA533FFC
      DFFBC89FCA533FFCDFFBE04FCA533FFCDFFBF207CA530000DFFBF913CA530000
      DFF3FC0180011F90DF83FE4080011F90DF83FF00C0031F90DF87FF80C0031F90
      CF8FFFC1F99F1F91C03FFFE3FC3F800300000000000000000000000000000000
      000000000000}
  end
  object DataSourceConsulta: TDataSource
    Left = 164
    Top = 435
  end
end
