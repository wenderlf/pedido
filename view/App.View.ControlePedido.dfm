inherited FormControlePedido: TFormControlePedido
  Caption = 'Controle de Pedidos'
  ClientHeight = 408
  ClientWidth = 545
  Menu = MainMenu
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 551
  ExplicitHeight = 457
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 389
    Width = 545
    Height = 19
    Panels = <>
  end
  object ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    Left = 592
    Top = 464
  end
  object MainMenu: TMainMenu
    Left = 176
    Top = 96
    object Cadastros1: TMenuItem
      Caption = '&Cadastros'
      object Clientes1: TMenuItem
        Caption = '&Clientes'
        OnClick = Clientes1Click
      end
      object Produtos1: TMenuItem
        Caption = '&Produtos'
        OnClick = Produtos1Click
      end
    end
    object Movimentaes1: TMenuItem
      Caption = '&Movimenta'#231#245'es'
      object Pedidos1: TMenuItem
        Caption = '&Pedidos'
        OnClick = Pedidos1Click
      end
    end
    object Sair1: TMenuItem
      Caption = 'Sai&r'
      OnClick = Sair1Click
    end
  end
end
