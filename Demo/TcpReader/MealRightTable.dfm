object frmMealRightTable: TfrmMealRightTable
  Left = 0
  Top = 0
  Caption = 'frmMealRightTable'
  ClientHeight = 425
  ClientWidth = 710
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
    Width = 710
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
    object btnGetMealRightTable: TButton
      Left = 165
      Top = 6
      Width = 65
      Height = 20
      Caption = 'Getir'
      TabOrder = 1
      OnClick = btnGetMealRightTableClick
    end
    object btnSetMealRightTable: TButton
      Left = 236
      Top = 6
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
      MaxValue = 47
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
  end
  object grdBellTable: TStringGrid
    Left = 0
    Top = 32
    Width = 546
    Height = 393
    Align = alClient
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    ColCount = 10
    Ctl3D = True
    DefaultColWidth = 50
    RowCount = 11
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentCtl3D = False
    TabOrder = 1
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
      24
      24
      24)
  end
  object mmLog: TMemo
    Left = 546
    Top = 32
    Width = 164
    Height = 393
    Align = alRight
    ReadOnly = True
    TabOrder = 2
  end
end
