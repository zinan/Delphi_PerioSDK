object frmMealTable: TfrmMealTable
  Left = 0
  Top = 0
  Caption = #214#287#252'n Tablosu'
  ClientHeight = 438
  ClientWidth = 727
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 727
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object btnGetMealTable: TButton
      Left = 420
      Top = 6
      Width = 65
      Height = 20
      Caption = 'Getir'
      TabOrder = 1
      OnClick = btnGetMealTableClick
    end
    object btnSetMealTable: TButton
      Left = 490
      Top = 7
      Width = 65
      Height = 20
      Caption = 'G'#246'nder'
      TabOrder = 2
      OnClick = btnSetMealTableClick
    end
    object cbDays: TComboBox
      Left = 48
      Top = 5
      Width = 113
      Height = 21
      Style = csDropDownList
      BiDiMode = bdLeftToRight
      ItemIndex = 0
      ParentBiDiMode = False
      TabOrder = 0
      Text = 'Pazatesi'
      OnChange = cbDaysChange
      Items.Strings = (
        'Pazatesi'
        'Sal'#305
        #199'ar'#351'amba'
        'Per'#351'embe'
        'Cuma'
        'Cumartesi'
        'Pazar'
        'Tatil')
    end
  end
  object grdBellTable: TStringGrid
    Left = 0
    Top = 41
    Width = 563
    Height = 397
    Align = alClient
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    ColCount = 7
    Ctl3D = True
    DefaultColWidth = 30
    RowCount = 9
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentCtl3D = False
    TabOrder = 1
    OnExit = grdBellTableExit
    ColWidths = (
      30
      38
      70
      42
      72
      38
      40)
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
  object mmLog: TMemo
    Left = 563
    Top = 41
    Width = 164
    Height = 397
    Align = alRight
    ReadOnly = True
    TabOrder = 2
  end
end
