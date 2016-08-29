object frmPersonTZList: TfrmPersonTZList
  Left = 0
  Top = 0
  Caption = 'Person Time Zone List'
  ClientHeight = 559
  ClientWidth = 611
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
    Width = 611
    Height = 41
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
    object btnGetMealRightTable: TButton
      Left = 205
      Top = 6
      Width = 65
      Height = 20
      Caption = 'Getir'
      TabOrder = 1
      OnClick = btnGetMealRightTableClick
    end
    object btnSetMealRightTable: TButton
      Left = 276
      Top = 7
      Width = 65
      Height = 20
      Caption = 'G'#246'nder'
      TabOrder = 2
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
  end
  object Panel5: TPanel
    Left = 0
    Top = 41
    Width = 611
    Height = 256
    Align = alTop
    Caption = 'Panel5'
    TabOrder = 1
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 202
      Height = 254
      Align = alLeft
      TabOrder = 0
      object Label32: TLabel
        Left = 20
        Top = 10
        Width = 24
        Height = 13
        Caption = 'Tarih'
      end
      object Label33: TLabel
        Left = 5
        Top = 39
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label34: TLabel
        Left = 8
        Top = 11
        Width = 6
        Height = 13
        Caption = '1'
      end
      object Label35: TLabel
        Left = 5
        Top = 66
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label36: TLabel
        Left = 5
        Top = 93
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label37: TLabel
        Left = 5
        Top = 120
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label38: TLabel
        Left = 5
        Top = 147
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label39: TLabel
        Left = 5
        Top = 174
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label40: TLabel
        Left = 5
        Top = 228
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label41: TLabel
        Left = 5
        Top = 201
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object edtDay1: TDateTimePicker
        Left = 48
        Top = 6
        Width = 92
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        TabOrder = 0
      end
      object edtSHour1_1: TDateTimePicker
        Left = 49
        Top = 33
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 1
      end
      object edtEHour1_1: TDateTimePicker
        Left = 124
        Top = 33
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 2
      end
      object edtSHour1_2: TDateTimePicker
        Left = 49
        Top = 60
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 3
      end
      object edtEHour1_2: TDateTimePicker
        Left = 124
        Top = 60
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 4
      end
      object edtSHour1_3: TDateTimePicker
        Left = 49
        Top = 87
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 5
      end
      object edtEHour1_3: TDateTimePicker
        Left = 124
        Top = 87
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 6
      end
      object edtSHour1_4: TDateTimePicker
        Left = 49
        Top = 114
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 7
      end
      object edtEHour1_4: TDateTimePicker
        Left = 124
        Top = 114
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 8
      end
      object edtSHour1_5: TDateTimePicker
        Left = 49
        Top = 141
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 9
      end
      object edtEHour1_5: TDateTimePicker
        Left = 124
        Top = 141
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 10
      end
      object edtSHour1_6: TDateTimePicker
        Left = 49
        Top = 168
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 11
      end
      object edtEHour1_6: TDateTimePicker
        Left = 124
        Top = 168
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 12
      end
      object edtSHour1_8: TDateTimePicker
        Left = 49
        Top = 222
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 13
      end
      object edtEHour1_8: TDateTimePicker
        Left = 124
        Top = 222
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 14
      end
      object edtSHour1_7: TDateTimePicker
        Left = 49
        Top = 195
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 15
      end
      object edtEHour1_7: TDateTimePicker
        Left = 124
        Top = 195
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 16
      end
      object edtTZNo1: TSpinEdit
        Left = 148
        Top = 5
        Width = 43
        Height = 22
        MaxValue = 65
        MinValue = 0
        TabOrder = 17
        Value = 0
      end
    end
    object Panel2: TPanel
      Left = 405
      Top = 1
      Width = 202
      Height = 254
      Align = alLeft
      TabOrder = 1
      object Label22: TLabel
        Left = 16
        Top = 10
        Width = 24
        Height = 13
        Caption = 'Tarih'
      end
      object Label23: TLabel
        Left = 5
        Top = 39
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label24: TLabel
        Left = 6
        Top = 10
        Width = 6
        Height = 13
        Caption = '3'
      end
      object Label25: TLabel
        Left = 5
        Top = 66
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label26: TLabel
        Left = 5
        Top = 93
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label27: TLabel
        Left = 5
        Top = 120
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label28: TLabel
        Left = 5
        Top = 147
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label29: TLabel
        Left = 5
        Top = 174
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label30: TLabel
        Left = 5
        Top = 228
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label31: TLabel
        Left = 5
        Top = 201
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object edtDay3: TDateTimePicker
        Left = 49
        Top = 6
        Width = 92
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        TabOrder = 0
      end
      object edtSHour3_1: TDateTimePicker
        Left = 49
        Top = 33
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 1
      end
      object edtEHour3_1: TDateTimePicker
        Left = 124
        Top = 33
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 2
      end
      object edtSHour3_2: TDateTimePicker
        Left = 49
        Top = 60
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 3
      end
      object edtEHour3_2: TDateTimePicker
        Left = 124
        Top = 60
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 4
      end
      object edtSHour3_3: TDateTimePicker
        Left = 49
        Top = 87
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 5
      end
      object edtEHour3_3: TDateTimePicker
        Left = 124
        Top = 87
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 6
      end
      object edtSHour3_4: TDateTimePicker
        Left = 49
        Top = 114
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 7
      end
      object edtEHour3_4: TDateTimePicker
        Left = 124
        Top = 114
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 8
      end
      object edtSHour3_5: TDateTimePicker
        Left = 49
        Top = 141
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 9
      end
      object edtEHour3_5: TDateTimePicker
        Left = 124
        Top = 141
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 10
      end
      object edtSHour3_6: TDateTimePicker
        Left = 49
        Top = 168
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 11
      end
      object edtEHour3_6: TDateTimePicker
        Left = 124
        Top = 168
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 12
      end
      object edtSHour3_8: TDateTimePicker
        Left = 49
        Top = 222
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 13
      end
      object edtEHour3_8: TDateTimePicker
        Left = 124
        Top = 222
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 14
      end
      object edtSHour3_7: TDateTimePicker
        Left = 49
        Top = 195
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 15
      end
      object edtEHour3_7: TDateTimePicker
        Left = 124
        Top = 195
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 16
      end
      object edtTZNo3: TSpinEdit
        Left = 147
        Top = 5
        Width = 43
        Height = 22
        MaxValue = 65
        MinValue = 0
        TabOrder = 17
        Value = 0
      end
    end
    object Panel1: TPanel
      Left = 203
      Top = 1
      Width = 202
      Height = 254
      Align = alLeft
      TabOrder = 2
      object Label3: TLabel
        Left = 21
        Top = 11
        Width = 24
        Height = 13
        Caption = 'Tarih'
      end
      object Label4: TLabel
        Left = 5
        Top = 39
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label5: TLabel
        Left = 8
        Top = 11
        Width = 6
        Height = 13
        Caption = '2'
      end
      object Label6: TLabel
        Left = 5
        Top = 66
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label16: TLabel
        Left = 5
        Top = 93
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label17: TLabel
        Left = 5
        Top = 120
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label18: TLabel
        Left = 5
        Top = 147
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label19: TLabel
        Left = 5
        Top = 174
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label20: TLabel
        Left = 5
        Top = 228
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label21: TLabel
        Left = 5
        Top = 201
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object edtDay2: TDateTimePicker
        Left = 52
        Top = 6
        Width = 88
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        TabOrder = 0
      end
      object edtSHour2_1: TDateTimePicker
        Left = 49
        Top = 33
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 1
      end
      object edtEHour2_1: TDateTimePicker
        Left = 124
        Top = 33
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 2
      end
      object edtSHour2_2: TDateTimePicker
        Left = 49
        Top = 60
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 3
      end
      object edtEHour2_2: TDateTimePicker
        Left = 124
        Top = 60
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 4
      end
      object edtSHour2_3: TDateTimePicker
        Left = 50
        Top = 87
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 5
      end
      object edtEHour2_3: TDateTimePicker
        Left = 124
        Top = 87
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 6
      end
      object edtSHour2_4: TDateTimePicker
        Left = 49
        Top = 114
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 7
      end
      object edtEHour2_4: TDateTimePicker
        Left = 124
        Top = 114
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 8
      end
      object edtSHour2_5: TDateTimePicker
        Left = 49
        Top = 141
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 9
      end
      object edtEHour2_5: TDateTimePicker
        Left = 124
        Top = 141
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 10
      end
      object edtSHour2_6: TDateTimePicker
        Left = 49
        Top = 168
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 11
      end
      object edtEHour2_6: TDateTimePicker
        Left = 124
        Top = 168
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 12
      end
      object edtSHour2_8: TDateTimePicker
        Left = 49
        Top = 222
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 13
      end
      object edtEHour2_8: TDateTimePicker
        Left = 124
        Top = 222
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 14
      end
      object edtSHour2_7: TDateTimePicker
        Left = 49
        Top = 195
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 15
      end
      object edtEHour2_7: TDateTimePicker
        Left = 124
        Top = 195
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 16
      end
      object edtTZNo2: TSpinEdit
        Left = 146
        Top = 5
        Width = 43
        Height = 22
        MaxValue = 65
        MinValue = 0
        TabOrder = 17
        Value = 0
      end
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 297
    Width = 611
    Height = 262
    Align = alClient
    Caption = 'Panel6'
    TabOrder = 2
    object mmLog: TMemo
      Left = 405
      Top = 1
      Width = 205
      Height = 260
      Align = alClient
      ReadOnly = True
      TabOrder = 0
    end
    object Panel7: TPanel
      Left = 1
      Top = 1
      Width = 202
      Height = 260
      Align = alLeft
      TabOrder = 1
      object Label2: TLabel
        Left = 20
        Top = 11
        Width = 24
        Height = 13
        Caption = 'Tarih'
      end
      object Label7: TLabel
        Left = 5
        Top = 39
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label8: TLabel
        Left = 8
        Top = 11
        Width = 6
        Height = 13
        Caption = '4'
      end
      object Label9: TLabel
        Left = 5
        Top = 66
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label10: TLabel
        Left = 5
        Top = 93
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label11: TLabel
        Left = 5
        Top = 120
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label12: TLabel
        Left = 5
        Top = 147
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label13: TLabel
        Left = 5
        Top = 174
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label14: TLabel
        Left = 5
        Top = 228
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label15: TLabel
        Left = 5
        Top = 201
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object edtDay4: TDateTimePicker
        Left = 49
        Top = 6
        Width = 89
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        TabOrder = 0
      end
      object edtSHour4_1: TDateTimePicker
        Left = 49
        Top = 33
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 1
      end
      object edtEHour4_1: TDateTimePicker
        Left = 124
        Top = 33
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 2
      end
      object edtSHour4_2: TDateTimePicker
        Left = 49
        Top = 60
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 3
      end
      object edtEHour4_2: TDateTimePicker
        Left = 124
        Top = 60
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 4
      end
      object edtSHour4_3: TDateTimePicker
        Left = 49
        Top = 87
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 5
      end
      object edtEHour4_3: TDateTimePicker
        Left = 124
        Top = 87
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 6
      end
      object edtSHour4_4: TDateTimePicker
        Left = 49
        Top = 114
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 7
      end
      object edtEHour4_4: TDateTimePicker
        Left = 124
        Top = 114
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 8
      end
      object edtSHour4_5: TDateTimePicker
        Left = 49
        Top = 141
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 9
      end
      object edtEHour4_5: TDateTimePicker
        Left = 124
        Top = 141
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 10
      end
      object edtSHour4_6: TDateTimePicker
        Left = 49
        Top = 168
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 11
      end
      object edtEHour4_6: TDateTimePicker
        Left = 124
        Top = 168
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 12
      end
      object edtSHour4_8: TDateTimePicker
        Left = 49
        Top = 222
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 13
      end
      object edtEHour4_8: TDateTimePicker
        Left = 124
        Top = 222
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 14
      end
      object edtSHour4_7: TDateTimePicker
        Left = 49
        Top = 195
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 15
      end
      object edtEHour4_7: TDateTimePicker
        Left = 124
        Top = 195
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 16
      end
      object edtTZNo4: TSpinEdit
        Left = 144
        Top = 5
        Width = 43
        Height = 22
        MaxValue = 65
        MinValue = 0
        TabOrder = 17
        Value = 0
      end
    end
    object Panel8: TPanel
      Left = 203
      Top = 1
      Width = 202
      Height = 260
      Align = alLeft
      TabOrder = 2
      object Label42: TLabel
        Left = 18
        Top = 11
        Width = 24
        Height = 13
        Caption = 'Tarih'
      end
      object Label43: TLabel
        Left = 5
        Top = 39
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label44: TLabel
        Left = 8
        Top = 11
        Width = 6
        Height = 13
        Caption = '5'
      end
      object Label45: TLabel
        Left = 5
        Top = 66
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label46: TLabel
        Left = 5
        Top = 93
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label47: TLabel
        Left = 5
        Top = 120
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label48: TLabel
        Left = 5
        Top = 147
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label49: TLabel
        Left = 5
        Top = 174
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label50: TLabel
        Left = 5
        Top = 228
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object Label51: TLabel
        Left = 5
        Top = 201
        Width = 39
        Height = 13
        Caption = 'Ba'#351' / Bit'
      end
      object edtDay5: TDateTimePicker
        Left = 49
        Top = 6
        Width = 88
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        TabOrder = 0
      end
      object edtSHour5_1: TDateTimePicker
        Left = 49
        Top = 33
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 1
      end
      object edtEHour5_1: TDateTimePicker
        Left = 124
        Top = 33
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 2
      end
      object edtSHour5_2: TDateTimePicker
        Left = 49
        Top = 60
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 3
      end
      object edtEHour5_2: TDateTimePicker
        Left = 124
        Top = 60
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 4
      end
      object edtSHour5_3: TDateTimePicker
        Left = 49
        Top = 87
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 5
      end
      object edtEHour5_3: TDateTimePicker
        Left = 124
        Top = 87
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 6
      end
      object edtSHour5_4: TDateTimePicker
        Left = 49
        Top = 114
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 7
      end
      object edtEHour5_4: TDateTimePicker
        Left = 124
        Top = 114
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 8
      end
      object edtSHour5_5: TDateTimePicker
        Left = 49
        Top = 141
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 9
      end
      object edtEHour5_5: TDateTimePicker
        Left = 124
        Top = 141
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 10
      end
      object edtSHour5_6: TDateTimePicker
        Left = 49
        Top = 168
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 11
      end
      object edtEHour5_6: TDateTimePicker
        Left = 124
        Top = 168
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 12
      end
      object edtSHour5_8: TDateTimePicker
        Left = 49
        Top = 222
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 13
      end
      object edtEHour5_8: TDateTimePicker
        Left = 124
        Top = 222
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 14
      end
      object edtSHour5_7: TDateTimePicker
        Left = 49
        Top = 195
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 15
      end
      object edtEHour5_7: TDateTimePicker
        Left = 124
        Top = 195
        Width = 69
        Height = 21
        Date = 42605.559553576390000000
        Time = 42605.559553576390000000
        Kind = dtkTime
        TabOrder = 16
      end
      object edtTZNo5: TSpinEdit
        Left = 153
        Top = 5
        Width = 43
        Height = 22
        MaxValue = 65
        MinValue = 0
        TabOrder = 17
        Value = 0
      end
    end
  end
end
