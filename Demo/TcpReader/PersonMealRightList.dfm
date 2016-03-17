object frmPersonMealRightList: TfrmPersonMealRightList
  Left = 0
  Top = 0
  Caption = 'frmPersonMealRightList'
  ClientHeight = 387
  ClientWidth = 701
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 701
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 147
      Top = 8
      Width = 35
      Height = 13
      Caption = 'Day No'
    end
    object Label2: TLabel
      Left = 11
      Top = 6
      Width = 34
      Height = 13
      Caption = 'Kart ID'
    end
    object Label3: TLabel
      Left = 191
      Top = 6
      Width = 49
      Height = 13
      Caption = 'Ay'#305'n G'#252'n'#252
    end
    object btnGetMealRightTable: TButton
      Left = 310
      Top = 5
      Width = 65
      Height = 20
      Caption = 'Getir'
      TabOrder = 2
      OnClick = btnGetMealRightTableClick
    end
    object btnSetMealRightTable: TButton
      Left = 381
      Top = 5
      Width = 65
      Height = 20
      Caption = 'G'#246'nder'
      TabOrder = 3
      OnClick = btnSetMealRightTableClick
    end
    object edtTableNo: TSpinEdit
      Left = 246
      Top = 3
      Width = 55
      Height = 22
      MaxValue = 31
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object edtCardID: TEdit
      Left = 51
      Top = 3
      Width = 134
      Height = 21
      MaxLength = 14
      TabOrder = 0
    end
  end
  object mmLog: TMemo
    Left = 537
    Top = 32
    Width = 164
    Height = 355
    Align = alRight
    ReadOnly = True
    TabOrder = 2
  end
  object grdBellTable: TStringGrid
    Left = 0
    Top = 32
    Width = 537
    Height = 355
    Align = alClient
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    ColCount = 10
    Ctl3D = True
    DefaultColWidth = 50
    RowCount = 2
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
      24)
  end
end
