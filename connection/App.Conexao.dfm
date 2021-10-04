object DataModuleConexao: TDataModuleConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object FDConnection: TFDConnection
    Left = 88
    Top = 16
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = 'libpq.dll'
    Left = 88
    Top = 72
  end
end
