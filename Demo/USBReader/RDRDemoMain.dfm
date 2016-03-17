object frmRDRDemoMain: TfrmRDRDemoMain
  Left = 0
  Top = 0
  Caption = 'ART12U DEMO (DELPHI) '
  ClientHeight = 450
  ClientWidth = 768
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 768
    Height = 49
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object lblComRdr: TLabel
      Left = 8
      Top = 16
      Width = 49
      Height = 13
      Caption = 'Seri Port'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ComLed1: TComLed
      Left = 254
      Top = 8
      Width = 22
      Height = 27
      LedSignal = lsConn
      Kind = lkGreenLight
    end
    object Label7: TLabel
      Left = 324
      Top = 12
      Width = 43
      Height = 13
      Caption = 'Time Out'
    end
    object cbComport: TComComboBox
      Left = 70
      Top = 13
      Width = 81
      Height = 21
      ComProperty = cpPort
      AutoApply = True
      Text = ''
      Style = csDropDownList
      ItemIndex = -1
      TabOrder = 2
    end
    object btnConnect: TButton
      Left = 163
      Top = 10
      Width = 79
      Height = 25
      Action = actConnect
      TabOrder = 1
    end
    object edtReadTimeOut: TSpinEdit
      Left = 392
      Top = 8
      Width = 58
      Height = 22
      Increment = 10
      MaxValue = 500
      MinValue = 10
      TabOrder = 0
      Value = 50
    end
  end
  object pgcMain: TPageControl
    Left = 0
    Top = 49
    Width = 768
    Height = 382
    ActivePage = tsTermOperations
    Align = alClient
    TabOrder = 1
    OnChange = pgcMainChange
    object tsTermOperations: TTabSheet
      Caption = 'Terminal '#304#351'lemleri'
      object pnlM1: TPanel
        Left = 0
        Top = 0
        Width = 760
        Height = 354
        Align = alClient
        BevelInner = bvLowered
        TabOrder = 0
        DesignSize = (
          760
          354)
        object grbMasterKeyTable: TGroupBox
          Left = 210
          Top = 6
          Width = 185
          Height = 129
          Caption = 'Master Key Tablosu'
          TabOrder = 1
          object lblMastKeyTableKeyNo: TLabel
            Left = 15
            Top = 22
            Width = 34
            Height = 13
            Caption = 'Key No'
          end
          object lblMasterTableKey: TLabel
            Left = 65
            Top = 22
            Width = 54
            Height = 13
            Caption = 'Master Key'
          end
          object edtMastKeyNo: TSpinEdit
            Left = 10
            Top = 43
            Width = 49
            Height = 22
            MaxValue = 31
            MinValue = 0
            TabOrder = 0
            Value = 0
          end
          object edtMasterKey: TEdit
            Left = 65
            Top = 43
            Width = 89
            Height = 21
            MaxLength = 12
            TabOrder = 1
            Text = '1A2B3C4D5E6F'
          end
          object btnTermSetMasterKey: TButton
            Left = 34
            Top = 80
            Width = 119
            Height = 27
            Action = actSetMasterKey
            TabOrder = 2
          end
        end
        object grbTermIO: TGroupBox
          Left = 210
          Top = 140
          Width = 185
          Height = 191
          Caption = ' Terminal '#199#305'k'#305#351'lar'#305' '
          TabOrder = 3
          object lblIO: TLabel
            Left = 24
            Top = 25
            Width = 18
            Height = 13
            Caption = 'G/C'
          end
          object lblIODuration: TLabel
            Left = 16
            Top = 85
            Width = 29
            Height = 13
            Caption = 'S'#252'resi'
          end
          object lblIODurms: TLabel
            Left = 126
            Top = 85
            Width = 43
            Height = 13
            Caption = '* 100 ms'
          end
          object edtIOType: TComboBox
            Left = 17
            Top = 46
            Width = 145
            Height = 21
            ItemIndex = 0
            TabOrder = 0
            Text = 'Ye'#351'il Led'
            OnChange = cbCardTypeChange
            Items.Strings = (
              'Ye'#351'il Led'
              'K'#305'rm'#305'z'#305' Led'
              'Buzer')
          end
          object edtIODuration: TSpinEdit
            Left = 51
            Top = 82
            Width = 58
            Height = 22
            MaxValue = 255
            MinValue = 1
            TabOrder = 1
            Value = 1
          end
          object btnSetIO: TButton
            Left = 26
            Top = 147
            Width = 119
            Height = 27
            Action = actSetIO
            TabOrder = 3
          end
          object cbIOBlink: TCheckBox
            Left = 17
            Top = 117
            Width = 55
            Height = 17
            Caption = 'Blink'
            TabOrder = 2
          end
        end
        object LogTermParams: TMemo
          Left = 401
          Top = 6
          Width = 355
          Height = 326
          Anchors = [akLeft, akTop, akRight, akBottom]
          PopupMenu = PopupMenu1
          ReadOnly = True
          TabOrder = 2
        end
        object grpTermDefSettings: TGroupBox
          Left = 3
          Top = 3
          Width = 203
          Height = 328
          TabOrder = 0
          object lbldevno: TLabel
            Left = 16
            Top = 89
            Width = 56
            Height = 13
            Caption = 'Terminal No'
          end
          object lblBuzzerTime: TLabel
            Left = 16
            Top = 117
            Width = 59
            Height = 13
            Caption = 'Buzer S'#252'resi'
          end
          object lblbzrSure: TLabel
            Left = 152
            Top = 117
            Width = 43
            Height = 13
            Caption = '* 100 ms'
          end
          object lblDefCardType: TLabel
            Left = 48
            Top = 142
            Width = 75
            Height = 13
            Caption = 'Kart Okuma Tipi'
          end
          object btnTermSaveParams: TButton
            Left = 11
            Top = 15
            Width = 164
            Height = 27
            Action = actTermGetParams
            TabOrder = 0
          end
          object btnTermSetParams: TButton
            Left = 11
            Top = 49
            Width = 164
            Height = 27
            Action = actTermSetParams
            TabOrder = 1
          end
          object edtTermNo: TSpinEdit
            Left = 88
            Top = 86
            Width = 58
            Height = 22
            MaxValue = 255
            MinValue = 1
            TabOrder = 2
            Value = 1
          end
          object edtDefBuzzerTime: TSpinEdit
            Left = 88
            Top = 114
            Width = 58
            Height = 22
            MaxValue = 255
            MinValue = 1
            TabOrder = 3
            Value = 1
          end
          object cbCardType: TComboBox
            Left = 21
            Top = 164
            Width = 145
            Height = 21
            ItemIndex = 0
            TabOrder = 4
            Text = 'StandardMode'
            OnChange = cbCardTypeChange
            Items.Strings = (
              'StandardMode'
              'SendCardID'
              'SendBlock'
              'SendSector'
              'SendCardID_ASCII'
              'SendBlock_ASCII'
              'Unknown')
          end
          object grbDefKeyParam: TGroupBox
            Left = 16
            Top = 187
            Width = 164
            Height = 136
            TabOrder = 5
            Visible = False
            object lblDefKeyType: TLabel
              Left = 9
              Top = 22
              Width = 37
              Height = 13
              Caption = 'Key Tipi'
            end
            object lblDefKeyNo: TLabel
              Left = 9
              Top = 49
              Width = 34
              Height = 13
              Caption = 'Key No'
            end
            object lblDefBlockNo: TLabel
              Left = 9
              Top = 105
              Width = 35
              Height = 13
              Caption = 'Blok No'
            end
            object lblDefSectorNo: TLabel
              Left = 9
              Top = 77
              Width = 47
              Height = 13
              Caption = 'Sekt'#246'r No'
            end
            object cbDefKeyType: TComboBox
              Left = 66
              Top = 18
              Width = 73
              Height = 21
              ItemIndex = 0
              TabOrder = 0
              Text = 'KeyA'
              Items.Strings = (
                'KeyA'
                'KeyB')
            end
            object edtDefKeyNo: TSpinEdit
              Left = 66
              Top = 45
              Width = 58
              Height = 22
              MaxValue = 31
              MinValue = 0
              TabOrder = 1
              Value = 1
            end
            object edtDefSectorNo: TSpinEdit
              Left = 66
              Top = 73
              Width = 58
              Height = 22
              MaxValue = 15
              MinValue = 0
              TabOrder = 2
              Value = 1
            end
            object edtDefBlockNo: TSpinEdit
              Left = 66
              Top = 101
              Width = 58
              Height = 22
              MaxValue = 2
              MinValue = 0
              TabOrder = 3
              Value = 1
            end
          end
        end
      end
    end
    object tsCardBlockOperations: TTabSheet
      Caption = 'Kart Okuma/Yazma '#304#351'lemleri'
      ImageIndex = 1
      object pnlM2: TPanel
        Left = 0
        Top = 0
        Width = 760
        Height = 354
        Align = alClient
        BevelInner = bvLowered
        TabOrder = 0
        DesignSize = (
          760
          354)
        object grbBlockLoginType: TGroupBox
          Left = 8
          Top = 0
          Width = 309
          Height = 127
          TabOrder = 0
          object lblBlockLoginType: TLabel
            Left = 16
            Top = 16
            Width = 44
            Height = 13
            Caption = 'Login Tipi'
          end
          object lblBlockKeyNo: TLabel
            Left = 17
            Top = 75
            Width = 34
            Height = 13
            Caption = 'Key No'
          end
          object lblBlockKeyType: TLabel
            Left = 17
            Top = 44
            Width = 45
            Height = 13
            Caption = 'Key Type'
          end
          object Label1: TLabel
            Left = 13
            Top = 101
            Width = 47
            Height = 13
            Caption = 'Sekt'#246'r No'
          end
          object lblwrBlockNo: TLabel
            Left = 137
            Top = 101
            Width = 35
            Height = 13
            Caption = 'Blok No'
          end
          object cbBWRLoginType: TComboBox
            Left = 69
            Top = 13
            Width = 169
            Height = 21
            ItemIndex = 0
            TabOrder = 0
            Text = 'Philips Factory Key'
            OnChange = cbBWRLoginTypeChange
            Items.Strings = (
              'Philips Factory Key'
              'Infineon Factory Key'
              'MasterKey'
              'Se'#231'ili Key')
          end
          object edtBWRKeyno: TSpinEdit
            Left = 69
            Top = 70
            Width = 49
            Height = 22
            MaxValue = 31
            MinValue = 0
            TabOrder = 3
            Value = 0
          end
          object edtBWRKey: TEdit
            Left = 139
            Top = 41
            Width = 89
            Height = 21
            MaxLength = 12
            TabOrder = 2
            Text = 'FFFFFFFFFFFF'
          end
          object cbbBWRKeyType: TComboBox
            Left = 69
            Top = 41
            Width = 63
            Height = 21
            ItemIndex = 0
            TabOrder = 1
            Text = 'KeyA'
            Items.Strings = (
              'KeyA'
              'KeyB')
          end
          object edtBWRSectorNo: TSpinEdit
            Left = 69
            Top = 97
            Width = 50
            Height = 22
            MaxValue = 15
            MinValue = 0
            TabOrder = 5
            Value = 0
          end
          object seBWRBlockNo: TSpinEdit
            Left = 186
            Top = 96
            Width = 48
            Height = 22
            MaxValue = 2
            MinValue = 0
            TabOrder = 4
            Value = 0
          end
        end
        object LogBWR: TMemo
          Left = 323
          Top = 4
          Width = 431
          Height = 341
          Anchors = [akLeft, akTop, akRight, akBottom]
          PopupMenu = PopupMenu1
          TabOrder = 1
        end
        object pcBlockValue: TPageControl
          Left = 8
          Top = 136
          Width = 309
          Height = 208
          ActivePage = tsBlockOpts
          TabOrder = 2
          OnChange = pcBlockValueChange
          object tsBlockOpts: TTabSheet
            Caption = 'Blok Okuma Yazma '#304#351'lemleri'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Label3: TLabel
              Left = 4
              Top = 1
              Width = 75
              Height = 13
              Caption = 'Blok Data (Hex)'
            end
            object edtBWRData: TEdit
              Left = 5
              Top = 28
              Width = 243
              Height = 21
              MaxLength = 32
              TabOrder = 0
            end
            object btnBlockRead: TButton
              Left = 20
              Top = 67
              Width = 164
              Height = 27
              Action = actBlockRead
              TabOrder = 1
            end
            object btnBlockWrite: TButton
              Left = 20
              Top = 100
              Width = 164
              Height = 27
              Action = actBlockWrite
              TabOrder = 2
            end
          end
          object tsValueOpts: TTabSheet
            Caption = 'De'#287'er Okuma Yazma '#304#351'lemleri'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Label4: TLabel
              Left = 5
              Top = 16
              Width = 35
              Height = 13
              Caption = 'Blok No'
            end
            object Label5: TLabel
              Left = 129
              Top = 16
              Width = 67
              Height = 13
              Caption = 'Hedef Blok No'
            end
            object Label6: TLabel
              Left = 8
              Top = 45
              Width = 29
              Height = 13
              Caption = 'De'#287'er'
            end
            object edtSrcBlockNo: TSpinEdit
              Left = 46
              Top = 11
              Width = 48
              Height = 22
              MaxValue = 2
              MinValue = 0
              TabOrder = 0
              Value = 0
            end
            object edtDestBlockNo: TSpinEdit
              Left = 211
              Top = 11
              Width = 48
              Height = 22
              MaxValue = 2
              MinValue = 0
              TabOrder = 1
              Value = 0
            end
            object edtValue: TSpinEdit
              Left = 54
              Top = 39
              Width = 81
              Height = 22
              MaxValue = 0
              MinValue = 0
              TabOrder = 2
              Value = 0
            end
            object btnReadValue: TButton
              Left = 3
              Top = 70
              Width = 113
              Height = 27
              Action = actReadValue
              TabOrder = 3
            end
            object btnReadWrite: TButton
              Left = 3
              Top = 103
              Width = 113
              Height = 27
              Action = actWriteValue
              TabOrder = 6
            end
            object btnCopyValue: TButton
              Left = 3
              Top = 139
              Width = 113
              Height = 28
              Action = actCopyValue
              TabOrder = 8
            end
            object edtIncDecValue: TSpinEdit
              Left = 137
              Top = 94
              Width = 48
              Height = 22
              MaxValue = 0
              MinValue = 0
              TabOrder = 5
              Value = 0
            end
            object btnIncValue: TButton
              Left = 193
              Top = 75
              Width = 91
              Height = 27
              Action = actIncValue
              TabOrder = 4
            end
            object btnDecValue: TButton
              Left = 193
              Top = 108
              Width = 92
              Height = 27
              Action = actDecValue
              TabOrder = 7
            end
          end
        end
      end
    end
    object tsCardConfigrationOperations: TTabSheet
      Caption = 'Kart Konfig'#252'rasyon '#304#351'lemleri'
      ImageIndex = 3
      object pnlM4: TPanel
        Left = 0
        Top = 0
        Width = 760
        Height = 354
        Align = alClient
        BevelInner = bvLowered
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 7
          Top = 136
          Width = 309
          Height = 193
          TabOrder = 0
          object Label2: TLabel
            Left = 17
            Top = 20
            Width = 40
            Height = 13
            Caption = 'Form No'
          end
          object lblConfCardKeyA: TLabel
            Left = 17
            Top = 47
            Width = 28
            Height = 13
            Caption = 'Key A'
          end
          object lblConfCardKeyB: TLabel
            Left = 18
            Top = 77
            Width = 27
            Height = 13
            Caption = 'Key B'
          end
          object cbFormNo: TComboBox
            Left = 77
            Top = 17
            Width = 63
            Height = 21
            ItemIndex = 8
            TabOrder = 0
            Text = 'F'
            Items.Strings = (
              '0'
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              'F')
          end
          object edtConfCardKeyA: TEdit
            Left = 77
            Top = 44
            Width = 89
            Height = 21
            MaxLength = 12
            TabOrder = 1
            Text = 'FFFFFFFFFFFF'
          end
          object edtConfCardKeyB: TEdit
            Left = 77
            Top = 74
            Width = 89
            Height = 21
            MaxLength = 12
            TabOrder = 2
            Text = 'FFFFFFFFFFFF'
          end
          object btnConfSector: TButton
            Left = 17
            Top = 110
            Width = 210
            Height = 27
            Action = actConfSector
            Caption = 'Sect'#246'r Konfig'#252'rasyonu Yap'
            TabOrder = 3
          end
          object btnGetSectorConf: TButton
            Left = 18
            Top = 143
            Width = 210
            Height = 27
            Action = actGetSecTorConf
            Caption = 'Sekt'#246'r Konfig'#252'rasyon Getir'
            TabOrder = 4
          end
        end
      end
    end
    object ts1: TTabSheet
      Caption = #214'rnek Uygulama'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label8: TLabel
        Left = 207
        Top = 19
        Width = 46
        Height = 13
        Caption = 'Ad Soyad'
      end
      object Label9: TLabel
        Left = 207
        Top = 59
        Width = 73
        Height = 13
        Caption = 'Ba'#351'lang'#305#231' Tarihi'
      end
      object Label10: TLabel
        Left = 207
        Top = 86
        Width = 48
        Height = 13
        Caption = 'Biti'#351' Tarihi'
      end
      object Button1: TButton
        Left = 272
        Top = 118
        Width = 152
        Height = 25
        Caption = 'Access Datas'#305'n'#305' Yaz'
        TabOrder = 6
        OnClick = Button1Click
      end
      object Edit1: TEdit
        Left = 280
        Top = 16
        Width = 121
        Height = 21
        MaxLength = 16
        TabOrder = 1
        Text = 'Cafer Do'#287'anay'
      end
      object DateTimePicker1: TDateTimePicker
        Left = 294
        Top = 55
        Width = 97
        Height = 21
        Date = 41226.677030983800000000
        Time = 41226.677030983800000000
        TabOrder = 2
      end
      object DateTimePicker2: TDateTimePicker
        Left = 397
        Top = 55
        Width = 75
        Height = 21
        Date = 41226.677030983800000000
        Time = 41226.677030983800000000
        Kind = dtkTime
        TabOrder = 3
      end
      object DateTimePicker3: TDateTimePicker
        Left = 294
        Top = 82
        Width = 97
        Height = 21
        Date = 41226.677030983800000000
        Time = 41226.677030983800000000
        TabOrder = 4
      end
      object DateTimePicker4: TDateTimePicker
        Left = 397
        Top = 82
        Width = 75
        Height = 21
        Date = 41226.677030983800000000
        Time = 41226.677030983800000000
        Kind = dtkTime
        TabOrder = 5
      end
      object StringGrid1: TStringGrid
        Left = 3
        Top = 3
        Width = 158
        Height = 335
        ColCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
        TabOrder = 0
        ColWidths = (
          64
          64)
        RowHeights = (
          24
          24
          24
          24
          24)
      end
    end
    object tbTutar: TTabSheet
      Caption = #214'rnek Uygulama 2'
      ImageIndex = 4
      DesignSize = (
        760
        354)
      object Label11: TLabel
        Left = 9
        Top = 20
        Width = 28
        Height = 13
        Caption = 'Key A'
      end
      object Label12: TLabel
        Left = 9
        Top = 47
        Width = 27
        Height = 13
        Caption = 'Key B'
      end
      object Label13: TLabel
        Left = 10
        Top = 85
        Width = 47
        Height = 13
        Caption = 'Sekt'#246'r No'
      end
      object Label14: TLabel
        Left = 134
        Top = 85
        Width = 35
        Height = 13
        Caption = 'Blok No'
      end
      object Label15: TLabel
        Left = 3
        Top = 131
        Width = 26
        Height = 13
        Caption = 'Tutar'
      end
      object Label16: TLabel
        Left = 4
        Top = 159
        Width = 61
        Height = 13
        Caption = #214'nceki Tutar'
      end
      object edOrnKeyA: TEdit
        Left = 49
        Top = 17
        Width = 89
        Height = 21
        MaxLength = 12
        TabOrder = 1
        Text = 'AB12BC34DE56'
      end
      object edOrnKeyB: TEdit
        Left = 49
        Top = 44
        Width = 89
        Height = 21
        MaxLength = 12
        TabOrder = 2
        Text = '12AB34BC56DE'
      end
      object Memo1: TMemo
        Left = 410
        Top = 3
        Width = 355
        Height = 326
        Anchors = [akLeft, akTop, akRight, akBottom]
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 0
      end
      object edtOrnSector: TSpinEdit
        Left = 66
        Top = 81
        Width = 50
        Height = 22
        MaxValue = 15
        MinValue = 0
        TabOrder = 4
        Value = 1
      end
      object edtOrnBlok: TSpinEdit
        Left = 183
        Top = 80
        Width = 48
        Height = 22
        MaxValue = 2
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object Button2: TButton
        Left = 95
        Top = 228
        Width = 75
        Height = 25
        Caption = 'Button2'
        TabOrder = 8
        OnClick = Button2Click
      end
      object edtTutar: TSpinEdit
        Left = 70
        Top = 128
        Width = 121
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 5
        Value = 0
      end
      object edtOncekiTutar: TSpinEdit
        Left = 71
        Top = 156
        Width = 121
        Height = 22
        Color = clBtnFace
        MaxValue = 0
        MinValue = 0
        TabOrder = 6
        Value = 0
      end
      object edtDate: TDateTimePicker
        Left = 71
        Top = 184
        Width = 78
        Height = 21
        Date = 41255.969989756930000000
        Time = 41255.969989756930000000
        Enabled = False
        TabOrder = 7
      end
    end
  end
  object stsbMain: TStatusBar
    Left = 0
    Top = 431
    Width = 768
    Height = 19
    Panels = <>
  end
  object ActionList: TActionList
    Left = 624
    Top = 32
    object actConnect: TAction
      Caption = 'Ba'#287'lan'
      OnExecute = actConnectExecute
      OnUpdate = actConnectUpdate
    end
    object actTermSetParams: TAction
      Caption = 'Ayarlar'#305' Cihaza G'#246'nder'
      OnExecute = actTermSetParamsExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actTermGetParams: TAction
      Caption = 'Ayarlar'#305' Cihazdan Getir'
      OnExecute = actTermGetParamsExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actSetMasterKey: TAction
      Caption = 'Cihaza G'#246'nder'
      OnExecute = actSetMasterKeyExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actSetIO: TAction
      Caption = 'Cihaza G'#246'nder'
      OnExecute = actSetIOExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actBlockWrite: TAction
      Caption = 'Blok Data Yaz'
      OnExecute = actBlockWriteExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actBlockRead: TAction
      Caption = 'Blok Data Oku'
      OnExecute = actBlockReadExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actReadValue: TAction
      Caption = 'De'#287'er Oku'
      OnExecute = actReadValueExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actWriteValue: TAction
      Caption = 'De'#287'er Yaz'
      OnExecute = actWriteValueExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actCopyValue: TAction
      Caption = 'Hedef'#39'e Kopyala'
      OnExecute = actCopyValueExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actIncValue: TAction
      Caption = 'De'#287'eri Art'#305'r'
      OnExecute = actIncValueExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actDecValue: TAction
      Caption = 'De'#287'eri Azalt'
      OnExecute = actDecValueExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actConfSector: TAction
      Caption = 'Sect'#246'r Konfigrasyonu Yap'
      OnExecute = actConfSectorExecute
      OnUpdate = actTermSetParamsUpdate
    end
    object actGetSecTorConf: TAction
      Caption = 'Sekt'#246'r Konfigrasyon Getir'
      OnExecute = actGetSecTorConfExecute
      OnUpdate = actTermSetParamsUpdate
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 688
    Top = 32
    object LoguSil1: TMenuItem
      Caption = 'Log'#39'u Sil'
      OnClick = LoguSil1Click
    end
  end
end
