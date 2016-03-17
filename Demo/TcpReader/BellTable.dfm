object frmBellTable: TfrmBellTable
  Left = 0
  Top = 0
  Caption = 'Bell Table'
  ClientHeight = 430
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 663
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 8
      Width = 19
      Height = 13
      Caption = 'G'#252'n'
    end
    object btnGetBellTable: TButton
      Left = 165
      Top = 6
      Width = 65
      Height = 20
      Caption = 'Getir'
      TabOrder = 1
      OnClick = btnGetBellTableClick
    end
    object btnSetBellTable: TButton
      Left = 236
      Top = 6
      Width = 65
      Height = 20
      Caption = 'G'#246'nder'
      TabOrder = 2
      OnClick = btnSetBellTableClick
    end
    object edtDayNo: TSpinEdit
      Left = 56
      Top = 4
      Width = 55
      Height = 22
      MaxValue = 7
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
  end
  object grdBellTable: TStringGrid
    Left = 0
    Top = 32
    Width = 352
    Height = 398
    Align = alClient
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    ColCount = 3
    Ctl3D = True
    DefaultColWidth = 30
    RowCount = 25
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentCtl3D = False
    TabOrder = 1
    ColWidths = (
      30
      97
      52)
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
      24
      24
      24
      24
      24)
  end
  object mmLog: TMemo
    Left = 352
    Top = 32
    Width = 311
    Height = 398
    Align = alRight
    ReadOnly = True
    TabOrder = 2
  end
end
