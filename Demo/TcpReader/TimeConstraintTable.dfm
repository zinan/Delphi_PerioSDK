object frmTimeConstraintTable: TfrmTimeConstraintTable
  Left = 0
  Top = 0
  Caption = 'Time Constraint Table'
  ClientHeight = 353
  ClientWidth = 1023
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
    Width = 1023
    Height = 73
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object btnGetTcTable: TButton
      Left = 92
      Top = 6
      Width = 65
      Height = 20
      Caption = 'Getir'
      TabOrder = 1
      OnClick = btnGetTcTableClick
    end
    object btnSetTcTable: TButton
      Left = 171
      Top = 8
      Width = 65
      Height = 20
      Caption = 'G'#246'nder'
      TabOrder = 2
      OnClick = btnSetTcTableClick
    end
    object edtTableNo: TSpinEdit
      Left = 16
      Top = 5
      Width = 64
      Height = 22
      MaxValue = 65
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
  end
  object grdTCTable: TStringGrid
    Left = 0
    Top = 73
    Width = 888
    Height = 280
    Align = alClient
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    ColCount = 17
    Ctl3D = True
    DefaultColWidth = 50
    RowCount = 9
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
    Left = 888
    Top = 73
    Width = 135
    Height = 280
    Align = alRight
    ReadOnly = True
    TabOrder = 2
  end
end
