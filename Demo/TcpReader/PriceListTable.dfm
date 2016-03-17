object frmPriceListTable: TfrmPriceListTable
  Left = 0
  Top = 0
  Caption = 'frmPriceListTable'
  ClientHeight = 396
  ClientWidth = 734
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
    Width = 734
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 8
      Width = 41
      Height = 13
      Caption = 'Tablo no'
    end
    object Label2: TLabel
      Left = 327
      Top = 5
      Width = 40
      Height = 13
      Caption = 'Liste Ad'#305
    end
    object btnGetMealRightTable: TButton
      Left = 130
      Top = 4
      Width = 65
      Height = 20
      Caption = 'Getir'
      TabOrder = 3
      OnClick = btnGetMealRightTableClick
    end
    object btnSetMealRightTable: TButton
      Left = 569
      Top = 3
      Width = 65
      Height = 20
      Caption = 'G'#246'nder'
      TabOrder = 2
      OnClick = btnSetMealRightTableClick
    end
    object edtTableNo: TSpinEdit
      Left = 71
      Top = 5
      Width = 55
      Height = 22
      MaxValue = 15
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
    object cbDays: TComboBox
      Left = 208
      Top = 3
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
    object edtFLName: TEdit
      Left = 373
      Top = 3
      Width = 185
      Height = 21
      TabOrder = 1
    end
    object Button1: TButton
      Left = 650
      Top = 6
      Width = 65
      Height = 20
      Caption = 'Zero'
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  object grdBellTable: TStringGrid
    Left = 0
    Top = 32
    Width = 570
    Height = 364
    Align = alClient
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    ColCount = 16
    Ctl3D = True
    DefaultColWidth = 50
    RowCount = 9
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentCtl3D = False
    TabOrder = 1
    OnExit = grdBellTableExit
    ColWidths = (
      50
      50
      50
      50
      50
      50
      50
      50
      50
      50
      50
      50
      50
      50
      50
      50)
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
    Left = 570
    Top = 32
    Width = 164
    Height = 364
    Align = alRight
    ReadOnly = True
    TabOrder = 2
  end
end
