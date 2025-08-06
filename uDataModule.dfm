object ovF_DataModule: TovF_DataModule
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 404
  Width = 573
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=Tickets'
      'User_Name=postgres'
      'Password=admin'
      'DriverID=PG')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 56
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 56
    Top = 8
  end
  object FDQuery_Temp: TFDQuery
    Connection = FDConnection1
    Left = 320
    Top = 8
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 56
    Top = 104
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 56
    Top = 152
  end
end
