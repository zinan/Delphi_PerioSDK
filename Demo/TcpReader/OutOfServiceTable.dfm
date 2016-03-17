object frmOutOfServiceTable: TfrmOutOfServiceTable
  Left = 0
  Top = 0
  Caption = 'Hizmet D'#305#351#305' - Tatil '
  ClientHeight = 471
  ClientWidth = 868
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
  object Panel1: TPanel
    Left = 440
    Top = 0
    Width = 428
    Height = 471
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 428
      Height = 25
      Align = alTop
      BevelInner = bvLowered
      Caption = 'Tatil Listesi'
      TabOrder = 0
    end
    object Panel6: TPanel
      Left = 0
      Top = 25
      Width = 428
      Height = 32
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 1
      object btnGetHolidayList: TButton
        Left = 61
        Top = 6
        Width = 65
        Height = 20
        Caption = 'Getir'
        TabOrder = 0
        OnClick = btnGetHolidayListClick
      end
      object btnSetHolidayList: TButton
        Left = 148
        Top = 6
        Width = 65
        Height = 20
        Caption = 'G'#246'nder'
        TabOrder = 1
        OnClick = btnSetHolidayListClick
      end
    end
    object grdHolidayList: TStringGrid
      Left = 0
      Top = 57
      Width = 428
      Height = 414
      Align = alClient
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      ColCount = 3
      Ctl3D = True
      DefaultColWidth = 30
      RowCount = 31
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      ParentCtl3D = False
      TabOrder = 2
      ColWidths = (
        30
        137
        45)
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
        24
        24
        24
        24
        24
        24
        24)
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 440
    Height = 471
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 0
    object Panel3: TPanel
      Left = 0
      Top = 25
      Width = 440
      Height = 32
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 1
      object btnGetOutOfServiceTable: TButton
        Left = 53
        Top = 6
        Width = 65
        Height = 20
        Caption = 'Getir'
        TabOrder = 0
        OnClick = btnGetOutOfServiceTableClick
      end
      object btnSetOutOfServiceTable: TButton
        Left = 140
        Top = 6
        Width = 65
        Height = 20
        Caption = 'G'#246'nder'
        TabOrder = 1
        OnClick = btnSetOutOfServiceTableClick
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 440
      Height = 25
      Align = alTop
      BevelInner = bvLowered
      Caption = 'Hizmet D'#305#351#305' Tablosu'
      TabOrder = 0
    end
    object grdOutOfService: TStringGrid
      Left = 0
      Top = 57
      Width = 440
      Height = 296
      Align = alTop
      BevelInner = bvNone
      BevelKind = bkFlat
      BevelOuter = bvNone
      ColCount = 9
      Ctl3D = True
      DefaultColWidth = 30
      RowCount = 9
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      ParentCtl3D = False
      TabOrder = 2
      ColWidths = (
        30
        44
        42
        44
        43
        46
        46
        51
        49)
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
    object Panel7: TPanel
      Left = 0
      Top = 353
      Width = 440
      Height = 118
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel7'
      TabOrder = 3
      object mmLog: TMemo
        Left = 0
        Top = 0
        Width = 440
        Height = 118
        Align = alClient
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
end
