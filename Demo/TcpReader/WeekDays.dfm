object frmWeekDays: TfrmWeekDays
  Left = 0
  Top = 0
  Caption = 'Hafta G'#252'n '#304'simleri'
  ClientHeight = 261
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 420
    Height = 41
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object btnGetTcTable: TButton
      Left = 20
      Top = 6
      Width = 65
      Height = 20
      Caption = 'Getir'
      TabOrder = 0
      OnClick = btnGetTcTableClick
    end
    object btnSetTcTable: TButton
      Left = 107
      Top = 6
      Width = 65
      Height = 20
      Caption = 'G'#246'nder'
      TabOrder = 1
      OnClick = btnSetTcTableClick
    end
  end
  object grdTCTable: TStringGrid
    Left = 0
    Top = 41
    Width = 184
    Height = 220
    Align = alClient
    BevelInner = bvNone
    BevelKind = bkFlat
    BevelOuter = bvNone
    ColCount = 2
    Ctl3D = True
    DefaultColWidth = 30
    RowCount = 8
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentCtl3D = False
    TabOrder = 1
    ColWidths = (
      30
      139)
    RowHeights = (
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
    Left = 184
    Top = 41
    Width = 236
    Height = 220
    Align = alRight
    ReadOnly = True
    TabOrder = 2
  end
end
