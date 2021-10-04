object DataModuleConexao: TDataModuleConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 155
  Width = 197
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=controle_pedido'
      'User_Name=root'
      'Password=wlf16nanny'
      'Server=localhost'
      'DriverID=MySQL')
    TxOptions.AutoStop = False
    TxOptions.DisconnectAction = xdRollback
    Left = 88
    Top = 16
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'libmysql.dll'
    Left = 88
    Top = 80
  end
end
