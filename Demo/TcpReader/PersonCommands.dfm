object frmPersonCommands: TfrmPersonCommands
  Left = 0
  Top = 0
  Caption = 'Person Commands'
  ClientHeight = 353
  ClientWidth = 515
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
    Width = 515
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 8
      Width = 33
      Height = 13
      Caption = 'Kart Id'
    end
    object Label3: TLabel
      Left = 205
      Top = 8
      Width = 74
      Height = 13
      Caption = 'Total Command'
    end
    object btnGetMealRightTable: TButton
      Left = 357
      Top = 6
      Width = 65
      Height = 20
      Caption = 'Getir'
      TabOrder = 2
      OnClick = btnGetMealRightTableClick
    end
    object btnSetMealRightTable: TButton
      Left = 428
      Top = 6
      Width = 65
      Height = 20
      Caption = 'G'#246'nder'
      TabOrder = 3
      OnClick = btnSetMealRightTableClick
    end
    object edtCardID: TEdit
      Left = 65
      Top = 5
      Width = 134
      Height = 21
      MaxLength = 14
      TabOrder = 0
    end
    object edtTotalCommand: TSpinEdit
      Left = 286
      Top = 5
      Width = 55
      Height = 22
      MaxValue = 31
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
  object mmLog: TMemo
    Left = 351
    Top = 32
    Width = 164
    Height = 321
    Align = alRight
    ReadOnly = True
    TabOrder = 2
  end
  object grdBellTable: TStringGrid
    Left = 0
    Top = 32
    Width = 351
    Height = 321
    Align = alClient
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    ColCount = 4
    Ctl3D = True
    DefaultColWidth = 50
    RowCount = 16
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentCtl3D = False
    TabOrder = 1
    ColWidths = (
      50
      52
      66
      75)
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
      24)
  end
end
