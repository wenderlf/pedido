object DataModuleConexao: TDataModuleConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 155
  Width = 303
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=controle_pedido'
      'User_Name=root'
      'Password=wlf16nanny'
      'Server=localhost'
      'DriverID=MySQL')
    Left = 88
    Top = 16
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'libmysql.dll'
    Left = 88
    Top = 80
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 224
    Top = 16
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 216
    Top = 80
  end
end
