object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Perio TCP Reader (PDKS - EKS,HGS,YMK fw.) Demo 3.0'
  ClientHeight = 614
  ClientWidth = 987
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMainLeft: TPanel
    Left = 675
    Top = 0
    Width = 312
    Height = 614
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pgLog: TPageControl
      Left = 0
      Top = 0
      Width = 312
      Height = 614
      ActivePage = TabAppLog
      Align = alClient
      TabOrder = 0
      object TabAppLog: TTabSheet
        Caption = 'Uygulama Loglar'#305
        object pnlLeftTop: TPanel
          Left = 0
          Top = 0
          Width = 304
          Height = 41
          Align = alTop
          BevelInner = bvLowered
          TabOrder = 0
          object Label1: TLabel
            Left = 16
            Top = 10
            Width = 29
            Height = 13
            Caption = 'Loglar'
          end
          object bntClearLog: TButton
            Left = 83
            Top = 5
            Width = 94
            Height = 25
            Caption = 'Temizle'
            TabOrder = 0
            OnClick = bntClearLogClick
          end
        end
        object mmLog: TMemo
          Left = 0
          Top = 41
          Width = 304
          Height = 545
          Align = alClient
          ReadOnly = True
          TabOrder = 1
        end
      end
      object TabUDPLog: TTabSheet
        Caption = 'Cihaz UDP Loglar'#305
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 345
        ExplicitHeight = 711
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 304
          Height = 41
          Align = alTop
          BevelInner = bvLowered
          TabOrder = 0
          ExplicitWidth = 345
          object Label57: TLabel
            Left = 8
            Top = 10
            Width = 36
            Height = 13
            Caption = 'Port No'
          end
          object edtLogUDPPortNo: TSpinEdit
            Left = 55
            Top = 7
            Width = 53
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 2
            Value = 514
          end
          object btnLogUDPStart: TButton
            Left = 114
            Top = 5
            Width = 75
            Height = 25
            Caption = 'Ba'#351'lat'
            TabOrder = 0
            OnClick = btnLogUDPStartClick
          end
          object btnUDPLogClear: TButton
            Left = 211
            Top = 5
            Width = 75
            Height = 25
            Caption = 'Temizle'
            TabOrder = 1
            OnClick = btnUDPLogClearClick
          end
        end
        object mmUDPLog: TMemo
          Left = 0
          Top = 41
          Width = 304
          Height = 545
          Align = alClient
          ReadOnly = True
          TabOrder = 1
          ExplicitWidth = 345
          ExplicitHeight = 670
        end
      end
    end
  end
  object pnlMainClient: TPanel
    Left = 0
    Top = 0
    Width = 675
    Height = 614
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object pnlConnectReader: TPanel
      Left = 0
      Top = 0
      Width = 675
      Height = 89
      Align = alTop
      BevelInner = bvLowered
      TabOrder = 0
      object lblConnectIp: TLabel
        Left = 163
        Top = 9
        Width = 43
        Height = 13
        Caption = 'Ip Adresi'
      end
      object lblConnectPortNo: TLabel
        Left = 306
        Top = 9
        Width = 36
        Height = 13
        Caption = 'Port No'
      end
      object lblConnectReaderType: TLabel
        Left = 8
        Top = 9
        Width = 61
        Height = 13
        Caption = 'Okuyucu Tipi'
      end
      object lblConnectProtocol: TLabel
        Left = 8
        Top = 36
        Width = 39
        Height = 13
        Caption = 'Protokol'
      end
      object lblConnectKey: TLabel
        Left = 161
        Top = 36
        Width = 88
        Height = 13
        Caption = 'Haberle'#351'me '#350'ifresi'
      end
      object lblConnectTimeOut: TLabel
        Left = 12
        Top = 62
        Width = 100
        Height = 13
        Caption = 'Ba'#287'lant'#305' Zaman A'#351#305'm'#305
      end
      object lblConnectCmdRtry: TLabel
        Left = 203
        Top = 62
        Width = 66
        Height = 13
        Caption = 'Komut Tekrar'#305
      end
      object lblDfSize: TLabel
        Left = 565
        Top = 7
        Width = 35
        Height = 13
        Caption = 'DF Size'
        Visible = False
      end
      object Label75: TLabel
        Left = 424
        Top = 9
        Width = 45
        Height = 13
        Caption = 'Uyg.  Tipi'
      end
      object edtConnectIp: TEdit
        Left = 210
        Top = 6
        Width = 90
        Height = 21
        TabOrder = 2
        Text = '192.168.0.170'
      end
      object edtConnectPortNo: TSpinEdit
        Left = 350
        Top = 7
        Width = 68
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 6565
      end
      object cbConnectReaderType: TComboBox
        Left = 76
        Top = 9
        Width = 81
        Height = 21
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ItemIndex = 0
        ParentBiDiMode = False
        TabOrder = 4
        Text = 'ART63MV3'
        OnChange = cbConnectReaderTypeChange
        Items.Strings = (
          'ART63MV3'
          'ART63MV5'
          'ART26M')
      end
      object cbConnectProtocol: TComboBox
        Left = 77
        Top = 32
        Width = 70
        Height = 21
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ItemIndex = 2
        ParentBiDiMode = False
        TabOrder = 7
        Text = 'PR2'
        Items.Strings = (
          'PR0'
          'PR1'
          'PR2')
      end
      object edtConnectKey: TEdit
        Left = 260
        Top = 33
        Width = 208
        Height = 21
        MaxLength = 32
        TabOrder = 8
        Text = 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'
      end
      object btnConnect: TButton
        Left = 475
        Top = 31
        Width = 75
        Height = 25
        Action = ActionRdrConnect
        TabOrder = 5
      end
      object btnDisConnect: TButton
        Left = 581
        Top = 31
        Width = 79
        Height = 25
        Action = ActionRdrDisConnect
        TabOrder = 6
      end
      object edtConnectTimeOut: TSpinEdit
        Left = 124
        Top = 59
        Width = 61
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 9
        Value = 2000
      end
      object edtConnectCmdRtry: TSpinEdit
        Left = 279
        Top = 59
        Width = 37
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 10
        Value = 3
      end
      object cbConnectAutoConnect: TCheckBox
        Left = 324
        Top = 61
        Width = 145
        Height = 17
        Caption = 'Otomatik Yeniden Ba'#287'lan'
        Checked = True
        State = cbChecked
        TabOrder = 11
      end
      object cbConnectAutoRxEnabled: TCheckBox
        Left = 475
        Top = 62
        Width = 165
        Height = 17
        Caption = 'Cihazdan Otomatik Veri Dinle'
        Checked = True
        State = cbChecked
        TabOrder = 12
      end
      object cbDfSize: TComboBox
        Left = 606
        Top = 4
        Width = 57
        Height = 21
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ItemIndex = 0
        ParentBiDiMode = False
        TabOrder = 1
        Text = '4MB'
        Visible = False
        Items.Strings = (
          '4MB'
          '8MB')
      end
      object cbAppType: TComboBox
        Left = 476
        Top = 4
        Width = 82
        Height = 21
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ItemIndex = 0
        ParentBiDiMode = False
        TabOrder = 0
        Text = 'PDKS'
        Items.Strings = (
          'PDKS'
          'HGS'
          'YMK_KONTOR')
      end
    end
    object pgTCPReader: TPageControl
      Left = 0
      Top = 89
      Width = 675
      Height = 525
      ActivePage = tsDeviceSettings
      Align = alClient
      TabOrder = 1
      object tsDeviceSettings: TTabSheet
        Caption = 'Cihaz Genel Ayarlar'#305
        object gbDeviceİnfo: TGroupBox
          Left = 0
          Top = 0
          Width = 180
          Height = 417
          Caption = 'Cihaz Bilgileri'
          TabOrder = 0
          object lblfwVersion: TLabel
            Left = 40
            Top = 37
            Width = 108
            Height = 13
            Caption = '...........................'
          end
          object btnfwVersion: TButton
            Left = 8
            Top = 16
            Width = 158
            Height = 19
            Caption = 'Cihaz firmware Versiyon Getir'
            TabOrder = 0
            OnClick = btnfwVersionClick
          end
          object grHeadTail: TGroupBox
            Left = 6
            Top = 55
            Width = 170
            Height = 94
            Caption = 'Head - Tail - Kapasite'
            TabOrder = 1
            object lblHead: TLabel
              Left = 6
              Top = 24
              Width = 25
              Height = 13
              Caption = 'Head'
            end
            object lblTail: TLabel
              Left = 6
              Top = 51
              Width = 16
              Height = 13
              Caption = 'Tail'
            end
            object lblCapacity: TLabel
              Left = 6
              Top = 74
              Width = 48
              Height = 13
              Caption = 'Kapasite :'
            end
            object edtHead: TSpinEdit
              Left = 39
              Top = 21
              Width = 63
              Height = 22
              MaxValue = 0
              MinValue = 0
              TabOrder = 1
              Value = 0
            end
            object btnGetHead: TButton
              Left = 105
              Top = 19
              Width = 51
              Height = 23
              Caption = 'Getir'
              TabOrder = 0
              OnClick = btnGetHeadClick
            end
            object edtTail: TSpinEdit
              Left = 39
              Top = 48
              Width = 63
              Height = 22
              MaxValue = 0
              MinValue = 0
              TabOrder = 2
              Value = 0
            end
            object btnSetHead: TButton
              Left = 105
              Top = 48
              Width = 51
              Height = 23
              Caption = 'G'#246'nder'
              TabOrder = 3
              OnClick = btnSetHeadClick
            end
          end
          object GroupBox2: TGroupBox
            Left = 5
            Top = 148
            Width = 171
            Height = 69
            Caption = 'Tarih / Saat '
            TabOrder = 2
            object edtTime: TDateTimePicker
              Left = 102
              Top = 16
              Width = 66
              Height = 21
              Date = 41258.966790069450000000
              Time = 41258.966790069450000000
              DateMode = dmUpDown
              Enabled = False
              Kind = dtkTime
              TabOrder = 1
            end
            object edtDate: TDateTimePicker
              Left = 22
              Top = 16
              Width = 78
              Height = 21
              Date = 41255.969989756930000000
              Time = 41255.969989756930000000
              Enabled = False
              TabOrder = 0
            end
            object cbDtTimer: TCheckBox
              Left = 4
              Top = 17
              Width = 18
              Height = 17
              TabOrder = 2
              OnClick = cbDtTimerClick
            end
            object btnSetDateTime: TButton
              Left = 11
              Top = 45
              Width = 136
              Height = 19
              Caption = 'Tarih Saat G'#246'nder'
              TabOrder = 3
              OnClick = btnSetDateTimeClick
            end
          end
          object grDeviceStatus: TGroupBox
            Left = 6
            Top = 222
            Width = 171
            Height = 63
            Caption = ' Cihaz Durum Bilgisi '
            TabOrder = 3
            object rbDeviceEnabled: TRadioButton
              Left = 15
              Top = 17
              Width = 52
              Height = 17
              Caption = 'Aktif'
              TabOrder = 0
            end
            object rbDeviceDisabled: TRadioButton
              Left = 85
              Top = 17
              Width = 57
              Height = 17
              Caption = 'Pasif'
              Checked = True
              TabOrder = 1
              TabStop = True
            end
            object btnGetDeviceStatus: TButton
              Left = 8
              Top = 38
              Width = 65
              Height = 20
              Caption = 'Getir'
              TabOrder = 2
              OnClick = btnGetDeviceStatusClick
            end
            object btnSetDeviceStatus: TButton
              Left = 86
              Top = 38
              Width = 65
              Height = 20
              Caption = 'G'#246'nder'
              TabOrder = 3
              OnClick = btnSetDeviceStatusClick
            end
          end
          object GroupBox4: TGroupBox
            Left = 4
            Top = 330
            Width = 171
            Height = 79
            Caption = 'Cihaz Operasyonlar'#305
            TabOrder = 5
            object btnSetDeviceFactoryDefaults: TButton
              Left = 6
              Top = 50
              Width = 143
              Height = 20
              Caption = 'Fabrika Ayarlar'#305'na D'#246'n'
              TabOrder = 1
              OnClick = btnSetDeviceFactoryDefaultsClick
            end
            object cdSaveIPAddr: TCheckBox
              Left = 3
              Top = 27
              Width = 141
              Height = 17
              Caption = 'Ip Adresi De'#287'i'#351'mesin'
              Checked = True
              State = cbChecked
              TabOrder = 0
            end
          end
          object btnReboot: TButton
            Left = 13
            Top = 298
            Width = 143
            Height = 20
            Caption = 'Cihaz'#305' Yeniden Ba'#351'lat'
            TabOrder = 4
            OnClick = btnRebootClick
          end
        end
        object GroupBox1: TGroupBox
          Left = 183
          Top = 0
          Width = 273
          Height = 405
          Caption = ' Cihaz Genel Ayarlar'#305' '
          TabOrder = 1
          object lblText1: TLabel
            Left = 8
            Top = 88
            Width = 35
            Height = 13
            Caption = '1. Sat'#305'r'
          end
          object lblDefSecreenType: TLabel
            Left = 58
            Top = 44
            Width = 104
            Height = 13
            Caption = 'Varsay'#305'lan Ekran T'#252'r'#252
          end
          object lblText2: TLabel
            Left = 8
            Top = 113
            Width = 35
            Height = 13
            Caption = '2. Sat'#305'r'
          end
          object lblDeviceNo: TLabel
            Left = 8
            Top = 24
            Width = 42
            Height = 13
            Caption = 'Cihaz No'
          end
          object lblBacklight: TLabel
            Left = 8
            Top = 162
            Width = 64
            Height = 13
            Caption = 'Arkaplan I'#351#305#287#305
          end
          object lblScreenSettings: TLabel
            Left = 42
            Top = 136
            Width = 94
            Height = 13
            Caption = 'Ekran(LCD) Ayarlar'#305
          end
          object lblContrast: TLabel
            Left = 8
            Top = 190
            Width = 77
            Height = 13
            Caption = 'Renk yo'#287'unlu'#287'u'
          end
          object lblTrOut1: TLabel
            Left = 3
            Top = 214
            Width = 83
            Height = 13
            Caption = 'Transist'#246'r '#199#305'k'#305#351#305' 1'
          end
          object lblTrOut2: TLabel
            Left = 3
            Top = 238
            Width = 83
            Height = 13
            Caption = 'Transist'#246'r '#199#305'k'#305#351#305' 2'
          end
          object lblCardReadBeepTime: TLabel
            Left = 8
            Top = 288
            Width = 114
            Height = 13
            Caption = 'Kart Okutma Sesi S'#252'resi'
          end
          object Label4: TLabel
            Left = 186
            Top = 282
            Width = 70
            Height = 26
            Caption = '0..250 (x10 ms) (0=Kapal'#305')'
            WordWrap = True
          end
          object Label6: TLabel
            Left = 8
            Top = 313
            Width = 122
            Height = 13
            Caption = 'Ard'#305#351#305'k Kart Okuma Aral'#305#287#305
          end
          object Label7: TLabel
            Left = 251
            Top = 314
            Width = 17
            Height = 13
            Caption = 'ms.'
          end
          object Label8: TLabel
            Left = 8
            Top = 335
            Width = 150
            Height = 13
            Caption = 'Ayn'#305' Kart'#39#305' Ard'#305#351#305'k Okuma Aral'#305#287#305
          end
          object Label9: TLabel
            Left = 251
            Top = 336
            Width = 17
            Height = 13
            Caption = 'ms.'
          end
          object Label118: TLabel
            Left = 201
            Top = 86
            Width = 41
            Height = 13
            Caption = 'Font Tipi'
          end
          object Label101: TLabel
            Left = 8
            Top = 360
            Width = 122
            Height = 13
            Caption = 'Kart Login Bekleme S'#252'resi'
          end
          object edtText1: TEdit
            Left = 60
            Top = 85
            Width = 121
            Height = 21
            MaxLength = 15
            TabOrder = 2
          end
          object edtText2: TEdit
            Left = 60
            Top = 110
            Width = 121
            Height = 21
            MaxLength = 15
            TabOrder = 4
          end
          object edtDeviceNo: TSpinEdit
            Left = 59
            Top = 20
            Width = 68
            Height = 22
            MaxValue = 65536
            MinValue = 0
            TabOrder = 0
            Value = 6565
          end
          object edtBacklight: TSpinEdit
            Left = 92
            Top = 157
            Width = 68
            Height = 22
            MaxValue = 1000
            MinValue = 0
            TabOrder = 5
            Value = 500
          end
          object edtContrast: TSpinEdit
            Left = 92
            Top = 185
            Width = 68
            Height = 22
            MaxValue = 1000
            MinValue = 0
            TabOrder = 6
            Value = 300
          end
          object rbNrOpen2: TRadioButton
            Tag = 3
            Left = 93
            Top = 237
            Width = 84
            Height = 17
            Caption = 'Normal Open'
            Checked = True
            TabOrder = 8
            TabStop = True
          end
          object rbNrClosed2: TRadioButton
            Tag = 3
            Left = 181
            Top = 237
            Width = 90
            Height = 17
            Caption = 'Normal Closed'
            TabOrder = 9
          end
          object cbDayRebootEnabled: TCheckBox
            Left = 8
            Top = 260
            Width = 146
            Height = 17
            Caption = 'G'#252'nl'#252'k Yeniden Ba'#351'latma'
            TabOrder = 11
            OnClick = cbDayRebootEnabledClick
          end
          object edtCardReadBeepTime: TSpinEdit
            Left = 136
            Top = 283
            Width = 48
            Height = 22
            MaxValue = 250
            MinValue = 0
            TabOrder = 12
            Value = 0
          end
          object dtpRebootTime: TDateTimePicker
            Left = 155
            Top = 258
            Width = 65
            Height = 21
            Date = 41258.000000000000000000
            Time = 41258.000000000000000000
            DateMode = dmUpDown
            Enabled = False
            Kind = dtkTime
            TabOrder = 10
          end
          object Panel1: TPanel
            Left = 20
            Top = 62
            Width = 185
            Height = 18
            BevelOuter = bvNone
            TabOrder = 1
            object rbText: TRadioButton
              Tag = 1
              Left = 8
              Top = 1
              Width = 106
              Height = 17
              Caption = 'Varsay'#305'lan Mesaj'
              TabOrder = 0
            end
            object rbLogo: TRadioButton
              Tag = 1
              Left = 118
              Top = 1
              Width = 51
              Height = 17
              Caption = 'Logo'
              Checked = True
              TabOrder = 1
              TabStop = True
            end
          end
          object Panel2: TPanel
            Left = 88
            Top = 212
            Width = 183
            Height = 19
            BevelOuter = bvNone
            TabOrder = 7
            object rbNrOpen1: TRadioButton
              Tag = 2
              Left = 5
              Top = 0
              Width = 82
              Height = 17
              Caption = 'Normal Open'
              TabOrder = 0
            end
            object rbNrClosed1: TRadioButton
              Tag = 2
              Left = 93
              Top = 0
              Width = 89
              Height = 17
              Caption = 'Normal Closed'
              Checked = True
              TabOrder = 1
              TabStop = True
            end
          end
          object btnGetDeviceGeneralSettings: TButton
            Left = 0
            Top = 382
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 16
            OnClick = btnGetDeviceGeneralSettingsClick
          end
          object btnSetDeviceGeneralSettings: TButton
            Left = 73
            Top = 382
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 17
            OnClick = btnSetDeviceGeneralSettingsClick
          end
          object edtCardReadTimeOut: TSpinEdit
            Left = 167
            Top = 308
            Width = 81
            Height = 22
            MaxValue = 65000
            MinValue = 0
            TabOrder = 13
            Value = 0
          end
          object edtVariableClearTimeout: TSpinEdit
            Left = 167
            Top = 330
            Width = 81
            Height = 22
            MaxValue = 65000
            MinValue = 0
            TabOrder = 14
            Value = 0
          end
          object cbDefSecreenMsgFontType: TComboBox
            Left = 196
            Top = 103
            Width = 57
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 3
            Text = '0'
            Items.Strings = (
              '0'
              '1'
              '2')
          end
          object edtCardReadDelay: TSpinEdit
            Left = 164
            Top = 355
            Width = 81
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 15
            Value = 0
          end
        end
        object grDeviceWorkMode: TGroupBox
          Left = 458
          Top = 3
          Width = 207
          Height = 271
          Caption = '  Cihaz '#199'al'#305#351'ma Modu  '
          TabOrder = 2
          object Label2: TLabel
            Left = 7
            Top = 224
            Width = 62
            Height = 13
            Caption = 'Zaman A'#351#305'm'#305' '
          end
          object Label3: TLabel
            Left = 147
            Top = 225
            Width = 32
            Height = 13
            Caption = '(M.Sn)'
          end
          object Label94: TLabel
            Left = 38
            Top = 61
            Width = 76
            Height = 13
            Caption = 'Online Kart Mod'
          end
          object rbOfflineWhiteList: TRadioButton
            Left = 32
            Top = 18
            Width = 113
            Height = 17
            Caption = 'Offline White list'
            TabOrder = 0
          end
          object rbOnlineTCP: TRadioButton
            Left = 32
            Top = 90
            Width = 113
            Height = 17
            Caption = 'Online TCP'
            TabOrder = 3
          end
          object rbOnlineUDP: TRadioButton
            Left = 32
            Top = 113
            Width = 113
            Height = 17
            Caption = 'Online UDP'
            TabOrder = 4
          end
          object cbOnlineEnabledOffline: TCheckBox
            Left = 6
            Top = 163
            Width = 198
            Height = 51
            Caption = 
              'Online sistemde varsay'#305'lan s'#252're kadar server ile ileti'#351'im kurula' +
              'mad'#305' ise offline '#231'al'#305#351's'#305'n m'#305' ?'
            TabOrder = 6
            WordWrap = True
          end
          object edtOnlineTimeOut: TSpinEdit
            Left = 73
            Top = 221
            Width = 68
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 7
            Value = 3000
          end
          object btnGetWorkMode: TButton
            Left = 34
            Top = 248
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 8
            OnClick = btnGetWorkModeClick
          end
          object btnSetWorkMode: TButton
            Left = 105
            Top = 249
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 9
            OnClick = btnSetWorkModeClick
          end
          object rbOfflineCardBlackList: TRadioButton
            Left = 32
            Top = 35
            Width = 161
            Height = 17
            Caption = 'Offline Kart ve Blacklist'
            TabOrder = 1
          end
          object rbOnlineTCPClientMode: TRadioButton
            Left = 32
            Top = 136
            Width = 145
            Height = 17
            Caption = 'Online TCP Client Mode'
            TabOrder = 5
          end
          object cmbOnlineCardWorkMode: TComboBox
            Left = 120
            Top = 58
            Width = 73
            Height = 21
            Style = csDropDownList
            ItemIndex = 0
            TabOrder = 2
            Text = 'TCP'
            Items.Strings = (
              'TCP'
              'UDP'
              'TCP Client Mode')
          end
        end
        object grSerialNumber: TGroupBox
          Left = 459
          Top = 280
          Width = 207
          Height = 72
          Caption = ' Cihaz Seri Numaras'#305
          TabOrder = 3
          object btnGetSerialNumber: TButton
            Left = 19
            Top = 45
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 1
            OnClick = btnGetSerialNumberClick
          end
          object btnSetSerialNumber: TButton
            Left = 97
            Top = 45
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 2
            OnClick = btnSetSerialNumberClick
          end
          object edtSerialNumber: TEdit
            Left = 3
            Top = 18
            Width = 198
            Height = 21
            MaxLength = 15
            TabOrder = 0
          end
        end
        object GroupBox7: TGroupBox
          Left = 462
          Top = 356
          Width = 207
          Height = 108
          Caption = ' Seri Port Baudrate Ayarlar'#305
          TabOrder = 4
          object Label103: TLabel
            Left = 4
            Top = 55
            Width = 27
            Height = 13
            Caption = 'Seri 0'
          end
          object Label104: TLabel
            Left = 107
            Top = 57
            Width = 27
            Height = 13
            Caption = 'Seri 1'
          end
          object Label109: TLabel
            Left = 4
            Top = 24
            Width = 42
            Height = 13
            Caption = 'Uyg. Tipi'
          end
          object btnGetSerailPortBdSet: TButton
            Left = 12
            Top = 82
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 4
            OnClick = btnGetSerailPortBdSetClick
          end
          object btnSetSerailPortBdSet: TButton
            Left = 83
            Top = 82
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 5
            OnClick = btnSetSerailPortBdSetClick
          end
          object btnSerialTest: TButton
            Left = 154
            Top = 79
            Width = 47
            Height = 26
            Caption = 'Seri Port Test'
            TabOrder = 3
            Visible = False
            WordWrap = True
            OnClick = btnSerialTestClick
          end
          object cbSerailBaudrate0: TComboBox
            Left = 37
            Top = 52
            Width = 64
            Height = 21
            Style = csDropDownList
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            TabOrder = 1
            Items.Strings = (
              '2400'
              '4800'
              '7200'
              '9600'
              '14400'
              '19200'
              '28800'
              '38400'
              '57600'
              '115200'
              '230400')
          end
          object cbSerailBaudrate1: TComboBox
            Left = 137
            Top = 52
            Width = 64
            Height = 21
            Style = csDropDownList
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            TabOrder = 2
            Items.Strings = (
              '2400'
              '4800'
              '7200'
              '9600'
              '14400'
              '19200'
              '28800'
              '38400'
              '57600'
              '115200'
              '230400')
          end
          object cbSerialAppType: TComboBox
            Left = 52
            Top = 21
            Width = 152
            Height = 21
            Style = csDropDownList
            BiDiMode = bdLeftToRight
            ItemIndex = 0
            ParentBiDiMode = False
            TabOrder = 0
            Text = 'Okunulan De'#287'eri Server'#39'a g'#246'nder'
            Items.Strings = (
              'Okunulan De'#287'eri Server'#39'a g'#246'nder'
              'Card Okutulmu'#351' Gibi yap')
          end
        end
        object btnweekDays: TButton
          Left = 186
          Top = 411
          Width = 111
          Height = 25
          Caption = 'Hafta G'#252'n '#304'simleri'
          TabOrder = 5
          OnClick = btnweekDaysClick
        end
      end
      object tsCominicationSettings: TTabSheet
        Caption = 'Haberle'#351'me Ayarlar'#305
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object grIpSettings: TGroupBox
          Left = 1
          Top = 2
          Width = 232
          Height = 327
          Caption = '  TCP Ayarlar'#305'  '
          TabOrder = 0
          object lblIpAddress: TLabel
            Left = 8
            Top = 48
            Width = 43
            Height = 13
            Caption = 'Ip Adresi'
          end
          object lblSubnetmask: TLabel
            Left = 8
            Top = 74
            Width = 69
            Height = 13
            Caption = 'Alt A'#287' Maskesi'
          end
          object lblDefaultGateway: TLabel
            Left = 8
            Top = 100
            Width = 96
            Height = 13
            Caption = 'Varsay'#305'lan A'#287' Ge'#231'idi'
          end
          object lblPrimaryDNS: TLabel
            Left = 8
            Top = 125
            Width = 88
            Height = 13
            Caption = 'Birinci DNS Sunucu'
          end
          object lblSecondaryDNS: TLabel
            Left = 8
            Top = 151
            Width = 85
            Height = 13
            Caption = #304'kinci DNS Sunucu'
          end
          object lblPortNo: TLabel
            Left = 8
            Top = 177
            Width = 67
            Height = 13
            Caption = 'Port Numaras'#305
          end
          object lblServerIpAddress: TLabel
            Left = 8
            Top = 203
            Width = 78
            Height = 13
            Caption = 'Server Ip Adresi'
          end
          object lblProtocol: TLabel
            Left = 8
            Top = 23
            Width = 39
            Height = 13
            Caption = 'Protokol'
          end
          object Label105: TLabel
            Left = 7
            Top = 248
            Width = 119
            Height = 13
            Caption = 'Server Echo Zaman a'#351#305'm'#305
          end
          object Label106: TLabel
            Left = 207
            Top = 249
            Width = 15
            Height = 13
            Caption = 'dk.'
          end
          object btnGetTCPSettings: TButton
            Left = 17
            Top = 294
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 12
            OnClick = btnGetTCPSettingsClick
          end
          object btnSetTCPSettings: TButton
            Left = 105
            Top = 293
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 11
            OnClick = btnSetTCPSettingsClick
          end
          object edtIpAddress: TEdit
            Left = 114
            Top = 45
            Width = 105
            Height = 21
            TabOrder = 1
          end
          object edtSubnetMask: TEdit
            Left = 114
            Top = 71
            Width = 105
            Height = 21
            TabOrder = 2
          end
          object edtDefaultGateway: TEdit
            Left = 114
            Top = 97
            Width = 105
            Height = 21
            TabOrder = 3
          end
          object edtPrimaryDNS: TEdit
            Left = 114
            Top = 122
            Width = 105
            Height = 21
            TabOrder = 4
          end
          object edtSecondaryDNS: TEdit
            Left = 114
            Top = 147
            Width = 105
            Height = 21
            TabOrder = 5
          end
          object edtServerIPAddress: TEdit
            Left = 114
            Top = 200
            Width = 105
            Height = 21
            TabOrder = 7
          end
          object cbConnOnlyServer: TCheckBox
            Left = 7
            Top = 225
            Width = 168
            Height = 17
            Caption = 'Sadece Server ile Haberle'#351
            Checked = True
            State = cbChecked
            TabOrder = 8
          end
          object cbProtocol: TComboBox
            Left = 114
            Top = 20
            Width = 70
            Height = 21
            Style = csDropDownList
            BiDiMode = bdLeftToRight
            ItemIndex = 2
            ParentBiDiMode = False
            TabOrder = 0
            Text = 'PR2'
            Items.Strings = (
              'PR0'
              'PR1'
              'PR2')
          end
          object cbDhcpEnable: TCheckBox
            Left = 7
            Top = 271
            Width = 81
            Height = 17
            Caption = 'DHCP Aktif'
            Checked = True
            State = cbChecked
            TabOrder = 10
          end
          object edtPortNo: TSpinEdit
            Left = 114
            Top = 174
            Width = 68
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 6
            Value = 6565
          end
          object edtServerEchoTimeOut: TSpinEdit
            Left = 133
            Top = 244
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 9
            Value = 0
          end
        end
        object grDeviceCommunicationKey: TGroupBox
          Left = 437
          Top = 3
          Width = 220
          Height = 76
          Caption = ' Haberle'#351'me '#350'ifresi'
          TabOrder = 2
          object btnSetDeviceKey: TButton
            Left = 17
            Top = 46
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 1
            OnClick = btnSetDeviceKeyClick
          end
          object edtDeviceKey: TEdit
            Left = 6
            Top = 19
            Width = 208
            Height = 21
            MaxLength = 32
            TabOrder = 0
            Text = 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'
          end
        end
        object grMacAddress: TGroupBox
          Left = 439
          Top = 79
          Width = 218
          Height = 76
          Caption = ' Mac Adresi'
          TabOrder = 3
          object btnGetMacAddress: TButton
            Left = 19
            Top = 46
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 1
            OnClick = btnGetMacAddressClick
          end
          object btnSetMacAddress: TButton
            Left = 97
            Top = 46
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 2
            OnClick = btnSetMacAddressClick
          end
          object edtMacAddress: TEdit
            Left = 3
            Top = 19
            Width = 210
            Height = 21
            MaxLength = 15
            TabOrder = 0
          end
        end
        object grWebPassword: TGroupBox
          Left = 439
          Top = 160
          Width = 218
          Height = 76
          Caption = ' Web Aray'#252'z'#252' '#350'ifresi'
          TabOrder = 4
          object btnGetWebPassword: TButton
            Left = 19
            Top = 46
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 1
            OnClick = btnGetWebPasswordClick
          end
          object btnSetWebPassword: TButton
            Left = 90
            Top = 46
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 2
            OnClick = btnSetWebPasswordClick
          end
          object edtWebPassword: TEdit
            Left = 3
            Top = 19
            Width = 210
            Height = 21
            MaxLength = 15
            TabOrder = 0
          end
        end
        object grUPDSettings: TGroupBox
          Left = 235
          Top = 3
          Width = 198
          Height = 155
          Caption = '  UDP Ayarlar'#305'  '
          TabOrder = 1
          object lblUdpServerAddress: TLabel
            Left = 8
            Top = 22
            Width = 43
            Height = 13
            Caption = 'Ip Adresi'
          end
          object Label10: TLabel
            Left = 8
            Top = 49
            Width = 67
            Height = 13
            Caption = 'Port Numaras'#305
          end
          object btnGetUDPSettings: TButton
            Left = 35
            Top = 124
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 4
            OnClick = btnGetUDPSettingsClick
          end
          object btnSetUDPSettings: TButton
            Left = 122
            Top = 124
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 5
            OnClick = btnSetUDPSettingsClick
          end
          object edtUpdServerAddress: TEdit
            Left = 86
            Top = 19
            Width = 105
            Height = 21
            TabOrder = 0
          end
          object cbUPDEnable: TCheckBox
            Left = 8
            Top = 74
            Width = 73
            Height = 17
            Caption = 'UDP Aktif'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object cbUdpLogEnabled: TCheckBox
            Left = 8
            Top = 101
            Width = 145
            Height = 17
            Caption = 'UDP Log Aktif'
            Checked = True
            State = cbChecked
            TabOrder = 3
          end
          object edtUdpPorNo: TSpinEdit
            Left = 86
            Top = 46
            Width = 68
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 1
            Value = 514
          end
        end
        object gbTCPClientSettings: TGroupBox
          Left = 235
          Top = 164
          Width = 200
          Height = 117
          Caption = '  TCP Client Ayarlar'#305'  '
          TabOrder = 5
          object Label21: TLabel
            Left = 8
            Top = 22
            Width = 43
            Height = 13
            Caption = 'Ip Adresi'
          end
          object Label22: TLabel
            Left = 8
            Top = 49
            Width = 67
            Height = 13
            Caption = 'Port Numaras'#305
          end
          object btnGetTCPClientSettings: TButton
            Left = 35
            Top = 79
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 2
            OnClick = btnGetTCPClientSettingsClick
          end
          object btnSetTCPClientSettings: TButton
            Left = 122
            Top = 79
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 3
            OnClick = btnSetTCPClientSettingsClick
          end
          object edtTCPClientAddress: TEdit
            Left = 85
            Top = 19
            Width = 105
            Height = 21
            TabOrder = 0
          end
          object edTCPClientPort: TSpinEdit
            Left = 85
            Top = 46
            Width = 68
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 1
            Value = 6555
          end
        end
      end
      object tsMfrKeyTable: TTabSheet
        Caption = 'Mifare '#350'ifre Tablosu'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object grdMfrKeyList: TStringGrid
          Left = 0
          Top = 0
          Width = 321
          Height = 497
          Align = alLeft
          BevelInner = bvNone
          BevelKind = bkFlat
          BevelOuter = bvNone
          ColCount = 3
          Ctl3D = True
          DefaultColWidth = 30
          RowCount = 17
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          ParentCtl3D = False
          TabOrder = 0
          ExplicitHeight = 513
          ColWidths = (
            30
            129
            130)
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
            24)
        end
        object btnGetKeylist: TButton
          Left = 353
          Top = 20
          Width = 114
          Height = 20
          Caption = 'Getir'
          TabOrder = 1
          OnClick = btnGetKeylistClick
        end
        object btnSetKeylist: TButton
          Left = 353
          Top = 46
          Width = 114
          Height = 20
          Caption = 'G'#246'nder'
          TabOrder = 2
          OnClick = btnSetKeylistClick
        end
        object btnSetFactoryKey: TButton
          Left = 353
          Top = 80
          Width = 121
          Height = 20
          Caption = 'Factory Key'
          TabOrder = 3
          OnClick = btnSetFactoryKeyClick
        end
      end
      object tsLCDMessages: TTabSheet
        Caption = 'Ekran Mesajlar'#305
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object PageControl1: TPageControl
          Left = 0
          Top = 0
          Width = 667
          Height = 497
          ActivePage = TabSheet1
          Align = alClient
          TabOrder = 0
          ExplicitHeight = 622
          object TabSheet1: TTabSheet
            Caption = 'Online'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 594
            object GroupBox8: TGroupBox
              Left = 0
              Top = 8
              Width = 329
              Height = 407
              Caption = 'Cihaza Mesaj G'#246'nder (Online)'
              TabOrder = 0
              object lblOnlSatir1: TLabel
                Left = 10
                Top = 75
                Width = 32
                Height = 13
                Caption = '1.Sat'#305'r'
              end
              object lblOnlSatir2: TLabel
                Left = 10
                Top = 99
                Width = 32
                Height = 13
                Caption = '2.Sat'#305'r'
              end
              object lblOnlRl: TLabel
                Left = 10
                Top = 314
                Width = 89
                Height = 13
                Caption = 'Transist'#246'r S'#252'resi 1'
              end
              object lblOnlBuzzer: TLabel
                Left = 10
                Top = 362
                Width = 64
                Height = 13
                Caption = 'Buzzer S'#252'resi'
              end
              object lblOnlBlink: TLabel
                Left = 10
                Top = 387
                Width = 21
                Height = 13
                Caption = 'Blink'
              end
              object lblOnlSecreenTime: TLabel
                Left = 10
                Top = 290
                Width = 52
                Height = 13
                Caption = 'Ekran S'#252're'
              end
              object lblOnlFontType: TLabel
                Left = 10
                Top = 267
                Width = 41
                Height = 13
                Caption = 'Font Tipi'
              end
              object lblOnlFont2Alligment: TLabel
                Left = 10
                Top = 243
                Width = 52
                Height = 13
                Caption = 'Sat'#305'r Say'#305's'#305
              end
              object lblOnlSatir3: TLabel
                Left = 10
                Top = 122
                Width = 32
                Height = 13
                Caption = '3.Sat'#305'r'
              end
              object lblOnlSatir4: TLabel
                Left = 10
                Top = 146
                Width = 32
                Height = 13
                Caption = '4.Sat'#305'r'
              end
              object lblOnlCaption: TLabel
                Left = 10
                Top = 51
                Width = 26
                Height = 13
                Caption = 'Ba'#351'l'#305'k'
              end
              object Label23: TLabel
                Left = 10
                Top = 28
                Width = 64
                Height = 13
                Caption = #220'st Ba'#351'l'#305'k Tipi'
              end
              object Label24: TLabel
                Left = 10
                Top = 170
                Width = 32
                Height = 13
                Caption = '5.Sat'#305'r'
              end
              object Label25: TLabel
                Left = 10
                Top = 219
                Width = 42
                Height = 13
                Caption = 'Alt Ba'#351'l'#305'k'
              end
              object Label26: TLabel
                Left = 162
                Top = 290
                Width = 40
                Height = 13
                Caption = '*100 ms'
              end
              object Label27: TLabel
                Left = 10
                Top = 338
                Width = 89
                Height = 13
                Caption = 'Transist'#246'r S'#252'resi 2'
              end
              object Label28: TLabel
                Left = 187
                Top = 314
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object Label29: TLabel
                Left = 187
                Top = 338
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object Label30: TLabel
                Left = 162
                Top = 362
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object Label31: TLabel
                Left = 244
                Top = 49
                Width = 6
                Height = 13
                Caption = 'X'
              end
              object Label32: TLabel
                Left = 294
                Top = 49
                Width = 6
                Height = 13
                Caption = 'Y'
              end
              object Label33: TLabel
                Left = 10
                Top = 194
                Width = 61
                Height = 13
                Caption = 'Alt Ba'#351'l'#305'k Tipi'
              end
              object edtOnText1: TEdit
                Left = 80
                Top = 72
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 3
              end
              object edtOnText2: TEdit
                Left = 80
                Top = 96
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 7
              end
              object ckhOnBlink: TCheckBox
                Left = 80
                Top = 384
                Width = 19
                Height = 17
                TabOrder = 26
              end
              object seOnScreenDuration: TSpinEdit
                Left = 80
                Top = 287
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 21
                Value = 10
              end
              object cbOnFontType: TComboBox
                Left = 80
                Top = 263
                Width = 57
                Height = 21
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 20
                Text = '0'
                Items.Strings = (
                  '0'
                  '1'
                  '2')
              end
              object btnOnMsgGonder: TButton
                Left = 248
                Top = 363
                Width = 75
                Height = 25
                Caption = 'G'#246'nder'
                TabOrder = 25
                OnClick = btnOnMsgGonderClick
              end
              object edtOnText3: TEdit
                Left = 80
                Top = 120
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 10
              end
              object edtOnText4: TEdit
                Left = 80
                Top = 144
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 13
              end
              object edtCaption: TEdit
                Left = 80
                Top = 48
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 1
              end
              object cbHeaderType: TComboBox
                Left = 80
                Top = 25
                Width = 70
                Height = 21
                Style = csDropDownList
                BiDiMode = bdLeftToRight
                ParentBiDiMode = False
                TabOrder = 0
                OnChange = cbHeaderTypeChange
                Items.Strings = (
                  'Yok'
                  #220'st Bilgi'
                  'Ba'#351'l'#305'k')
              end
              object edtOnText5: TEdit
                Left = 80
                Top = 168
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 14
              end
              object edtFooter: TEdit
                Left = 80
                Top = 215
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 18
              end
              object edtLineCount: TSpinEdit
                Left = 80
                Top = 235
                Width = 57
                Height = 22
                MaxValue = 5
                MinValue = 1
                TabOrder = 19
                Value = 5
                OnChange = edtLineCountChange
              end
              object edtRlOut1: TSpinEdit
                Left = 106
                Top = 311
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 22
                Value = 10
              end
              object edtRlOut2: TSpinEdit
                Left = 106
                Top = 335
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 23
                Value = 10
              end
              object edtBuzzerTime: TSpinEdit
                Left = 80
                Top = 359
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 24
                Value = 10
              end
              object edtX1: TSpinEdit
                Left = 229
                Top = 72
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 4
                Value = 5
              end
              object edtY1: TSpinEdit
                Left = 279
                Top = 71
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 2
                Value = 15
              end
              object edtX2: TSpinEdit
                Left = 229
                Top = 95
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 5
                Value = 5
              end
              object edtY2: TSpinEdit
                Left = 279
                Top = 95
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 6
                Value = 30
              end
              object edtX3: TSpinEdit
                Left = 229
                Top = 119
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 8
                Value = 5
              end
              object edtY3: TSpinEdit
                Left = 279
                Top = 119
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 9
                Value = 45
              end
              object edtX4: TSpinEdit
                Left = 229
                Top = 143
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 11
                Value = 5
              end
              object edtY4: TSpinEdit
                Left = 279
                Top = 143
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 12
                Value = 60
              end
              object edtX5: TSpinEdit
                Left = 229
                Top = 171
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 15
                Value = 5
              end
              object edtY5: TSpinEdit
                Left = 279
                Top = 171
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 16
                Value = 75
              end
              object cbFooterType: TComboBox
                Left = 80
                Top = 192
                Width = 70
                Height = 21
                Style = csDropDownList
                ItemIndex = 0
                TabOrder = 17
                Text = 'Yok'
                OnChange = cbFooterTypeChange
                Items.Strings = (
                  'Yok'
                  'Var')
              end
            end
            object GroupBox10: TGroupBox
              Left = 333
              Top = 8
              Width = 329
              Height = 407
              Caption = 'Cihaza Input Box Mesaj'#305' G'#246'nder (Online)'
              TabOrder = 1
              object Label110: TLabel
                Left = 10
                Top = 75
                Width = 32
                Height = 13
                Caption = '1.Sat'#305'r'
              end
              object Label111: TLabel
                Left = 10
                Top = 99
                Width = 32
                Height = 13
                Caption = '2.Sat'#305'r'
              end
              object Label112: TLabel
                Left = 13
                Top = 147
                Width = 89
                Height = 13
                Caption = 'Transist'#246'r S'#252'resi 1'
              end
              object Label113: TLabel
                Left = 13
                Top = 195
                Width = 64
                Height = 13
                Caption = 'Buzzer S'#252'resi'
              end
              object Label114: TLabel
                Left = 13
                Top = 220
                Width = 21
                Height = 13
                Caption = 'Blink'
              end
              object Label115: TLabel
                Left = 13
                Top = 123
                Width = 52
                Height = 13
                Caption = 'Ekran S'#252're'
              end
              object Label120: TLabel
                Left = 10
                Top = 51
                Width = 26
                Height = 13
                Caption = 'Ba'#351'l'#305'k'
              end
              object Label121: TLabel
                Left = 10
                Top = 28
                Width = 64
                Height = 13
                Caption = #220'st Ba'#351'l'#305'k Tipi'
              end
              object Label124: TLabel
                Left = 165
                Top = 123
                Width = 40
                Height = 13
                Caption = '*100 ms'
              end
              object Label125: TLabel
                Left = 13
                Top = 171
                Width = 89
                Height = 13
                Caption = 'Transist'#246'r S'#252'resi 2'
              end
              object Label126: TLabel
                Left = 187
                Top = 147
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object Label127: TLabel
                Left = 187
                Top = 171
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object Label128: TLabel
                Left = 165
                Top = 196
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object Label129: TLabel
                Left = 244
                Top = 49
                Width = 6
                Height = 13
                Caption = 'X'
              end
              object Label130: TLabel
                Left = 294
                Top = 49
                Width = 6
                Height = 13
                Caption = 'Y'
              end
              object Label116: TLabel
                Left = 10
                Top = 243
                Width = 51
                Height = 13
                Caption = 'Klavye Tipi'
              end
              object Label117: TLabel
                Left = 172
                Top = 227
                Width = 78
                Height = 39
                Caption = '0 - K'#252#231#252'k Harf , 1- B'#252'y'#252'k Harf , 2-Say'#305
                WordWrap = True
              end
              object edtIbmOnText1: TEdit
                Left = 80
                Top = 72
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 3
              end
              object edtIbmOnText2: TEdit
                Left = 80
                Top = 96
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 7
              end
              object ckhIbmOnBlink: TCheckBox
                Left = 83
                Top = 217
                Width = 19
                Height = 17
                TabOrder = 13
              end
              object seIbmOnScreenDuration: TSpinEdit
                Left = 80
                Top = 120
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 8
                Value = 200
              end
              object btnIbmOnMsgGonder: TButton
                Left = 227
                Top = 189
                Width = 75
                Height = 25
                Caption = 'G'#246'nder'
                TabOrder = 11
                OnClick = btnIbmOnMsgGonderClick
              end
              object edtIbmCaption: TEdit
                Left = 80
                Top = 48
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 1
              end
              object cbIbmHeaderType: TComboBox
                Left = 80
                Top = 25
                Width = 70
                Height = 21
                Style = csDropDownList
                BiDiMode = bdLeftToRight
                ParentBiDiMode = False
                TabOrder = 0
                OnChange = cbHeaderTypeChange
                Items.Strings = (
                  'Yok'
                  #220'st Bilgi'
                  'Ba'#351'l'#305'k')
              end
              object edtIbmRlOut1: TSpinEdit
                Left = 109
                Top = 144
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 9
                Value = 0
              end
              object edtIbmRlOut2: TSpinEdit
                Left = 109
                Top = 168
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 10
                Value = 0
              end
              object edtIbmBuzzerTime: TSpinEdit
                Left = 83
                Top = 192
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 12
                Value = 5
              end
              object edtIbmX1: TSpinEdit
                Left = 229
                Top = 72
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 4
                Value = 5
              end
              object edtIbmY1: TSpinEdit
                Left = 279
                Top = 71
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 2
                Value = 15
              end
              object edtIbmX2: TSpinEdit
                Left = 229
                Top = 95
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 6
                Value = 5
              end
              object edtIbmY2: TSpinEdit
                Left = 279
                Top = 94
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 5
                Value = 25
              end
              object edtIbmKeyPadType: TSpinEdit
                Left = 82
                Top = 240
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 14
                Value = 1
              end
            end
          end
          object TabSheet2: TTabSheet
            Caption = 'Offline'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 594
            object GroupBox3: TGroupBox
              Left = 3
              Top = 3
              Width = 330
              Height = 435
              Caption = 'Cihaz Mesajlar'#305'  (Offline)'
              TabOrder = 0
              object Label34: TLabel
                Left = 10
                Top = 103
                Width = 32
                Height = 13
                Caption = '1.Sat'#305'r'
              end
              object Label35: TLabel
                Left = 10
                Top = 127
                Width = 32
                Height = 13
                Caption = '2.Sat'#305'r'
              end
              object Label36: TLabel
                Left = 10
                Top = 344
                Width = 89
                Height = 13
                Caption = 'Transist'#246'r S'#252'resi 1'
              end
              object Label37: TLabel
                Left = 10
                Top = 393
                Width = 64
                Height = 13
                Caption = 'Buzzer S'#252'resi'
              end
              object Label38: TLabel
                Left = 10
                Top = 417
                Width = 21
                Height = 13
                Caption = 'Blink'
              end
              object Label39: TLabel
                Left = 10
                Top = 320
                Width = 52
                Height = 13
                Caption = 'Ekran S'#252're'
              end
              object Label40: TLabel
                Left = 10
                Top = 296
                Width = 41
                Height = 13
                Caption = 'Font Tipi'
              end
              object Label41: TLabel
                Left = 10
                Top = 272
                Width = 52
                Height = 13
                Caption = 'Sat'#305'r Say'#305's'#305
              end
              object Label42: TLabel
                Left = 10
                Top = 151
                Width = 32
                Height = 13
                Caption = '3.Sat'#305'r'
              end
              object Label43: TLabel
                Left = 10
                Top = 175
                Width = 32
                Height = 13
                Caption = '4.Sat'#305'r'
              end
              object Label44: TLabel
                Left = 10
                Top = 79
                Width = 26
                Height = 13
                Caption = 'Ba'#351'l'#305'k'
              end
              object Label45: TLabel
                Left = 10
                Top = 55
                Width = 64
                Height = 13
                Caption = #220'st Ba'#351'l'#305'k Tipi'
              end
              object Label46: TLabel
                Left = 10
                Top = 199
                Width = 32
                Height = 13
                Caption = '5.Sat'#305'r'
              end
              object Label47: TLabel
                Left = 10
                Top = 248
                Width = 42
                Height = 13
                Caption = 'Alt Ba'#351'l'#305'k'
              end
              object Label48: TLabel
                Left = 162
                Top = 320
                Width = 40
                Height = 13
                Caption = '*100 ms'
              end
              object Label49: TLabel
                Left = 10
                Top = 368
                Width = 89
                Height = 13
                Caption = 'Transist'#246'r S'#252'resi 2'
              end
              object Label50: TLabel
                Left = 194
                Top = 344
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object Label51: TLabel
                Left = 194
                Top = 368
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object Label52: TLabel
                Left = 162
                Top = 392
                Width = 13
                Height = 13
                Caption = 'ms'
              end
              object Label53: TLabel
                Left = 244
                Top = 79
                Width = 6
                Height = 13
                Caption = 'X'
              end
              object Label54: TLabel
                Left = 294
                Top = 79
                Width = 6
                Height = 13
                Caption = 'Y'
              end
              object Label55: TLabel
                Left = 10
                Top = 224
                Width = 61
                Height = 13
                Caption = 'Alt Ba'#351'l'#305'k Tipi'
              end
              object Label56: TLabel
                Left = 10
                Top = 31
                Width = 47
                Height = 13
                Caption = 'Mesaj Tipi'
              end
              object edtOffText1: TEdit
                Left = 80
                Top = 101
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 5
              end
              object edtOffText2: TEdit
                Left = 80
                Top = 124
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 6
              end
              object ckhOffBlink: TCheckBox
                Left = 80
                Top = 414
                Width = 19
                Height = 17
                TabOrder = 27
              end
              object seOffScreenDuration: TSpinEdit
                Left = 80
                Top = 316
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 22
                Value = 10
              end
              object cbOffFontType: TComboBox
                Left = 80
                Top = 292
                Width = 57
                Height = 21
                Style = csDropDownList
                TabOrder = 21
                Items.Strings = (
                  '0'
                  '1'
                  '2')
              end
              object btnOffMsgGonder: TButton
                Left = 251
                Top = 397
                Width = 75
                Height = 25
                Caption = 'G'#246'nder'
                TabOrder = 26
                OnClick = btnOffMsgGonderClick
              end
              object edtOffText3: TEdit
                Left = 80
                Top = 148
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 9
              end
              object edtOffText4: TEdit
                Left = 80
                Top = 172
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 12
              end
              object edtOffCaption: TEdit
                Left = 80
                Top = 76
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 2
              end
              object cbOffHeaderType: TComboBox
                Left = 80
                Top = 52
                Width = 70
                Height = 21
                Style = csDropDownList
                BiDiMode = bdLeftToRight
                ItemIndex = 0
                ParentBiDiMode = False
                TabOrder = 1
                Text = 'Yok'
                OnChange = cbOffHeaderTypeChange
                Items.Strings = (
                  'Yok'
                  #220'st Bilgi'
                  'Ba'#351'l'#305'k')
              end
              object edtOffText5: TEdit
                Left = 80
                Top = 196
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 15
              end
              object edtOffFooter: TEdit
                Left = 80
                Top = 244
                Width = 143
                Height = 21
                MaxLength = 20
                TabOrder = 19
              end
              object edtOffLineCount: TSpinEdit
                Left = 80
                Top = 268
                Width = 57
                Height = 22
                MaxValue = 5
                MinValue = 0
                TabOrder = 20
                Value = 5
                OnChange = edtOffLineCountChange
              end
              object edtOffRlOut1: TSpinEdit
                Left = 112
                Top = 340
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 23
                Value = 10
              end
              object edtOffRlOut2: TSpinEdit
                Left = 112
                Top = 364
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 24
                Value = 10
              end
              object edtOffBuzzerTime: TSpinEdit
                Left = 80
                Top = 389
                Width = 76
                Height = 22
                MaxValue = 65535
                MinValue = 0
                TabOrder = 25
                Value = 10
              end
              object edtOffX1: TSpinEdit
                Left = 229
                Top = 100
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 3
                Value = 5
              end
              object edtOffY1: TSpinEdit
                Left = 279
                Top = 100
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 4
                Value = 5
              end
              object edtOffX2: TSpinEdit
                Left = 229
                Top = 124
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 7
                Value = 5
              end
              object edtOffY2: TSpinEdit
                Left = 279
                Top = 124
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 8
                Value = 5
              end
              object edtOffX3: TSpinEdit
                Left = 229
                Top = 148
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 10
                Value = 5
              end
              object edtOffY3: TSpinEdit
                Left = 279
                Top = 148
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 11
                Value = 5
              end
              object edtOffX4: TSpinEdit
                Left = 229
                Top = 172
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 13
                Value = 5
              end
              object edtOffY4: TSpinEdit
                Left = 279
                Top = 172
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 14
                Value = 5
              end
              object edtOffX5: TSpinEdit
                Left = 229
                Top = 196
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 16
                Value = 5
              end
              object edtOffY5: TSpinEdit
                Left = 279
                Top = 196
                Width = 44
                Height = 22
                MaxValue = 250
                MinValue = 0
                TabOrder = 17
                Value = 5
              end
              object cbOffFooterType: TComboBox
                Left = 80
                Top = 220
                Width = 70
                Height = 21
                Style = csDropDownList
                TabOrder = 18
                OnChange = cbOffFooterTypeChange
                Items.Strings = (
                  'Yok'
                  'Var')
              end
              object cbOffMsgType: TComboBox
                Left = 80
                Top = 28
                Width = 244
                Height = 21
                Style = csDropDownList
                BiDiMode = bdLeftToRight
                ItemIndex = 0
                ParentBiDiMode = False
                TabOrder = 0
                Text = 'Yok'
                OnChange = cbOffMsgTypeChange
                Items.Strings = (
                  'Yok'
                  #220'st Bilgi'
                  'Ba'#351'l'#305'k')
              end
            end
            object btnSetFactoryLCDMessages: TButton
              Left = 348
              Top = 8
              Width = 188
              Height = 25
              Caption = 'Offline Mesajlar Fabrika Ayar'#305'na d'#246'n'
              TabOrder = 1
              OnClick = btnSetFactoryLCDMessagesClick
            end
          end
        end
      end
      object tsAccessSettings: TTabSheet
        Caption = 'Uygulama Ayarlar'#305
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object grAppGeneralSettings: TGroupBox
          Left = 3
          Top = 0
          Width = 350
          Height = 164
          Caption = '  Genel Ayarlar  '
          TabOrder = 0
          object lblAccesType: TLabel
            Left = 17
            Top = 28
            Width = 44
            Height = 13
            Caption = 'Ge'#231'i'#351' Tipi'
          end
          object lblAccessPwdType: TLabel
            Left = 16
            Top = 52
            Width = 69
            Height = 13
            Caption = #350'ifre Ge'#231'i'#351' Tipi'
          end
          object lblInputType: TLabel
            Left = 17
            Top = 79
            Width = 39
            Height = 13
            Caption = 'Giri'#351' Tipi'
          end
          object lblInputDuration: TLabel
            Left = 16
            Top = 106
            Width = 57
            Height = 13
            Caption = 'Ge'#231'i'#351' S'#252'resi'
            Visible = False
          end
          object btnGetAppgeneralSettings: TButton
            Left = 16
            Top = 138
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 5
            OnClick = btnGetAppgeneralSettingsClick
          end
          object btnSetAppgeneralSettings: TButton
            Left = 103
            Top = 138
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 6
            OnClick = btnSetAppgeneralSettingsClick
          end
          object cbAccessType: TComboBox
            Left = 98
            Top = 22
            Width = 99
            Height = 21
            Style = csDropDownList
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            TabOrder = 0
            Items.Strings = (
              'Sadece Kart'
              'Kart veya '#350'ifre'
              'Kart ve '#350'ifre')
          end
          object cbAccessPwdType: TComboBox
            Left = 98
            Top = 49
            Width = 99
            Height = 21
            Style = csDropDownList
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            TabOrder = 2
            Items.Strings = (
              'Sadece '#350'ifre'
              'Ki'#351'i No +  '#350'ifre')
          end
          object cbInputType: TComboBox
            Left = 98
            Top = 76
            Width = 239
            Height = 21
            Style = csDropDownList
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            TabOrder = 3
            OnChange = cbInputTypeChange
            Items.Strings = (
              'Kapal'#305
              'Butonla Kap'#305' A'#231'mak '#304#231'in Kullan'
              'Turnike veya Kap'#305'dan D'#246'n'#252#351' Bilgisini Almak i'#231'in Kullan'
              'Kap'#305' A'#231#305'k Kald'#305' Alarm'#305)
          end
          object seInputDuration: TSpinEdit
            Left = 183
            Top = 103
            Width = 99
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 4
            Value = 0
            Visible = False
          end
          object cbATC: TCheckBox
            Left = 232
            Top = 24
            Width = 97
            Height = 24
            Caption = 'Zaman K'#305's'#305't Tablosu Etkin'
            TabOrder = 1
            WordWrap = True
          end
          object btnTCTable: TButton
            Left = 204
            Top = 141
            Width = 125
            Height = 20
            Caption = 'Zaman K'#305's'#305't Tablosu'
            TabOrder = 7
            OnClick = btnTCTableClick
          end
        end
        object grAPB: TGroupBox
          Left = 4
          Top = 171
          Width = 349
          Height = 118
          Caption = '  Anti Passback Ayarlar'#305'  '
          TabOrder = 2
          object lblAPBType: TLabel
            Left = 12
            Top = 28
            Width = 38
            Height = 13
            Caption = 'APB Tipi'
          end
          object lblAPBDuration: TLabel
            Left = 12
            Top = 95
            Width = 89
            Height = 13
            Caption = 'Ard'#305#351#305'k ge'#231'i'#351' aral'#305#287#305
          end
          object lblSecurityZoneNo: TLabel
            Left = 12
            Top = 47
            Width = 85
            Height = 13
            Caption = 'G'#252'venlik B'#246'lge No'
          end
          object lblAPBdk: TLabel
            Left = 184
            Top = 95
            Width = 15
            Height = 13
            Caption = 'dk.'
            Visible = False
          end
          object btnGetAPBSettings: TButton
            Left = 264
            Top = 51
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 2
            OnClick = btnGetAPBSettingsClick
          end
          object btnSetAPBSettings: TButton
            Left = 263
            Top = 83
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 5
            OnClick = btnSetAPBSettingsClick
          end
          object cbAPBType: TComboBox
            Left = 110
            Top = 17
            Width = 229
            Height = 21
            Style = csDropDownList
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            TabOrder = 0
            OnChange = cbAPBTypeChange
            Items.Strings = (
              'Kapal'#305
              'Anti Pass Back'
              'Giri'#351'ten S'#252're Kontrol'#252' + Anti Pass Back'
              'S'#252're Kontrol'#252' + Anti Pass Back'
              'Giri'#351'ten S'#252're Kontrol'#252
              'S'#252're Kontrol'#252)
          end
          object seAPBDuration: TSpinEdit
            Left = 110
            Top = 92
            Width = 68
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 6
            Value = 0
          end
          object seSecurityZoneNo: TSpinEdit
            Left = 110
            Top = 41
            Width = 99
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 1
            Value = 0
          end
          object rbAPBGiris: TRadioButton
            Left = 43
            Top = 69
            Width = 52
            Height = 17
            Caption = 'Giri'#351
            TabOrder = 3
          end
          object rbAPBCikis: TRadioButton
            Left = 112
            Top = 69
            Width = 57
            Height = 17
            Caption = #199#305'k'#305#351
            Checked = True
            TabOrder = 4
            TabStop = True
          end
        end
        object gbOutOfService: TGroupBox
          Left = 359
          Top = 3
          Width = 286
          Height = 178
          Caption = '  Okuyucu Hizmet D'#305#351#305' Ayarlar'#305'  '
          TabOrder = 1
          object Label12: TLabel
            Left = 16
            Top = 62
            Width = 35
            Height = 13
            Caption = '1. Sat'#305'r'
          end
          object Label13: TLabel
            Left = 16
            Top = 87
            Width = 35
            Height = 13
            Caption = '2. Sat'#305'r'
          end
          object Label14: TLabel
            Left = 96
            Top = 38
            Width = 60
            Height = 13
            Caption = 'Ekran Mesaj'#305
          end
          object Label18: TLabel
            Left = 8
            Top = 115
            Width = 77
            Height = 13
            Caption = 'Transist'#246'r '#199#305'k'#305#351#305' '
          end
          object btnGetOutOfServiceSettings: TButton
            Left = 9
            Top = 147
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 6
            OnClick = btnGetOutOfServiceSettingsClick
          end
          object btnSetOutOfServiceSettings: TButton
            Left = 89
            Top = 147
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 7
            OnClick = btnSetOutOfServiceSettingsClick
          end
          object edtOutOfServiceTxt1: TEdit
            Left = 68
            Top = 57
            Width = 121
            Height = 21
            MaxLength = 15
            TabOrder = 1
          end
          object edtOutOfServiceTxt2: TEdit
            Left = 68
            Top = 84
            Width = 121
            Height = 21
            MaxLength = 15
            TabOrder = 2
          end
          object cbOutOfServiceSettings: TCheckBox
            Left = 33
            Top = 17
            Width = 169
            Height = 21
            Caption = 'Okuyucu Hizmet D'#305#351#305' Etkin'
            TabOrder = 0
            WordWrap = True
          end
          object btnOutOfServicelTable: TButton
            Left = 165
            Top = 147
            Width = 111
            Height = 20
            Caption = 'Hizmet D'#305#351#305' Tablosu'
            TabOrder = 8
            OnClick = btnOutOfServicelTableClick
          end
          object rbOOSNoChange: TRadioButton
            Tag = 2
            Left = 92
            Top = 114
            Width = 86
            Height = 17
            Caption = 'De'#287'i'#351'iklik yok'
            TabOrder = 3
          end
          object rbOOSTrOut1: TRadioButton
            Tag = 2
            Left = 188
            Top = 114
            Width = 35
            Height = 17
            Caption = '1'
            TabOrder = 4
          end
          object rbOOSTrOut2: TRadioButton
            Tag = 2
            Left = 237
            Top = 114
            Width = 33
            Height = 17
            Caption = '2'
            TabOrder = 5
          end
        end
        object gbBell: TGroupBox
          Left = 358
          Top = 187
          Width = 286
          Height = 178
          Caption = ' Zil Tablosu Ayarlar'#305'  '
          TabOrder = 3
          object Label15: TLabel
            Left = 16
            Top = 62
            Width = 35
            Height = 13
            Caption = '1. Sat'#305'r'
          end
          object Label16: TLabel
            Left = 16
            Top = 87
            Width = 35
            Height = 13
            Caption = '2. Sat'#305'r'
          end
          object Label17: TLabel
            Left = 96
            Top = 38
            Width = 60
            Height = 13
            Caption = 'Ekran Mesaj'#305
          end
          object btnGetBellSettings: TButton
            Left = 8
            Top = 147
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 5
            OnClick = btnGetBellSettingsClick
          end
          object btnSetBellSettings: TButton
            Left = 89
            Top = 147
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 6
            OnClick = btnSetBellSettingsClick
          end
          object edtBellTxt1: TEdit
            Left = 68
            Top = 57
            Width = 121
            Height = 21
            MaxLength = 15
            TabOrder = 1
          end
          object edtBellTxt2: TEdit
            Left = 68
            Top = 84
            Width = 121
            Height = 21
            MaxLength = 15
            TabOrder = 2
          end
          object cbBellEnabled: TCheckBox
            Left = 33
            Top = 17
            Width = 169
            Height = 21
            Caption = 'Zil '#199'ald'#305'rma Etkin'
            TabOrder = 0
            WordWrap = True
          end
          object rbBellTrOut1: TRadioButton
            Tag = 2
            Left = 11
            Top = 115
            Width = 110
            Height = 17
            Caption = 'Transist'#246'r '#199#305'k'#305#351#305' 1'
            TabOrder = 3
          end
          object rbBellTrOut2: TRadioButton
            Tag = 2
            Left = 129
            Top = 115
            Width = 119
            Height = 17
            Caption = 'Transist'#246'r '#199#305'k'#305#351#305' 2'
            Checked = True
            TabOrder = 4
            TabStop = True
          end
          object btnBellTable: TButton
            Left = 170
            Top = 147
            Width = 95
            Height = 20
            Caption = 'Zil Tablosu'
            TabOrder = 7
            OnClick = btnBellTableClick
          end
        end
        object gbEksOtherSettings: TGroupBox
          Left = 3
          Top = 292
          Width = 350
          Height = 118
          Caption = '  Di'#287'er EKS Ayarlar'#305'  '
          TabOrder = 4
          object Label11: TLabel
            Left = 25
            Top = 16
            Width = 177
            Height = 13
            Caption = 'Karttan Okumada Kullan'#305'lan Sekt'#246'rler'
          end
          object Label19: TLabel
            Left = 13
            Top = 36
            Width = 43
            Height = 13
            Caption = 'Ki'#351'i Verisi'
          end
          object Label20: TLabel
            Left = 127
            Top = 36
            Width = 44
            Height = 13
            Caption = 'Eks Verisi'
          end
          object btnGetEksOtherSettings: TButton
            Left = 267
            Top = 16
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 0
            OnClick = btnGetEksOtherSettingsClick
          end
          object btnSetEksOtherSettings: TButton
            Left = 267
            Top = 42
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 3
            OnClick = btnSetEksOtherSettingsClick
          end
          object edtPersData: TSpinEdit
            Left = 61
            Top = 32
            Width = 50
            Height = 22
            MaxValue = 15
            MinValue = 0
            TabOrder = 1
            Value = 0
          end
          object edtAccessData: TSpinEdit
            Left = 175
            Top = 32
            Width = 50
            Height = 22
            MaxValue = 15
            MinValue = 0
            TabOrder = 2
            Value = 0
          end
        end
        object btnSetAppFactoryDefaults: TButton
          Left = 359
          Top = 394
          Width = 223
          Height = 23
          Caption = 'Uygulama Ayarlar'#305'n'#305' Fabrika ayarlar'#305'na getir'
          TabOrder = 6
          OnClick = btnSetAppFactoryDefaultsClick
        end
        object cbSetAppDefReboot: TCheckBox
          Left = 394
          Top = 371
          Width = 121
          Height = 17
          Caption = 'Yeniden Ba'#351'lat'
          TabOrder = 5
        end
      end
      object tsAddWhitelist: TTabSheet
        Caption = 'Ki'#351'i Ekleme'
        ImageIndex = 5
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object lblCardId: TLabel
          Left = 7
          Top = 21
          Width = 33
          Height = 13
          Caption = 'Kart Id'
        end
        object lblName: TLabel
          Left = 7
          Top = 48
          Width = 13
          Height = 13
          Caption = 'Ad'
        end
        object lblAccesMask: TLabel
          Left = 7
          Top = 91
          Width = 54
          Height = 13
          Caption = 'Zaman K'#305's'#305't'
        end
        object lblDate: TLabel
          Left = 7
          Top = 169
          Width = 103
          Height = 13
          Caption = 'Kart'#305'n Son. Kul. Tarihi'
        end
        object lblCode: TLabel
          Left = 7
          Top = 119
          Width = 18
          Height = 13
          Caption = 'Kod'
        end
        object lblPass: TLabel
          Left = 7
          Top = 144
          Width = 22
          Height = 13
          Caption = #350'ifre'
        end
        object lblTanimliKisi: TLabel
          Left = 141
          Top = 398
          Width = 12
          Height = 13
          Caption = '...'
        end
        object lblIndexNo: TLabel
          Left = 236
          Top = 21
          Width = 52
          Height = 13
          Caption = '.............'
        end
        object Label100: TLabel
          Left = 7
          Top = 196
          Width = 62
          Height = 13
          Caption = 'Do'#287'um Tarihi'
        end
        object edtCardID: TEdit
          Left = 78
          Top = 18
          Width = 147
          Height = 21
          MaxLength = 14
          TabOrder = 0
        end
        object edtName: TEdit
          Left = 78
          Top = 43
          Width = 147
          Height = 21
          MaxLength = 18
          TabOrder = 2
        end
        object seAccMask1: TSpinEdit
          Left = 78
          Top = 88
          Width = 44
          Height = 22
          MaxValue = 65
          MinValue = 0
          TabOrder = 4
          Value = 0
        end
        object edtEndDate: TDateTimePicker
          Left = 139
          Top = 166
          Width = 93
          Height = 21
          Date = 73050.416025474540000000
          Time = 73050.416025474540000000
          TabOrder = 7
        end
        object cbAccessEnabled: TCheckBox
          Left = 39
          Top = 223
          Width = 121
          Height = 17
          Caption = 'Ki'#351'i cihazda aktif mi?'
          Checked = True
          State = cbChecked
          TabOrder = 9
        end
        object cbAPBEnabled: TCheckBox
          Left = 40
          Top = 246
          Width = 180
          Height = 17
          Caption = 'AntiPassBack kontrol'#252' olsun mu?'
          Checked = True
          State = cbChecked
          TabOrder = 10
        end
        object cbATCEnabled: TCheckBox
          Left = 40
          Top = 266
          Width = 180
          Height = 17
          Caption = 'Zaman k'#305's'#305't kontrol'#252' olsun mu?'
          Checked = True
          State = cbChecked
          TabOrder = 11
        end
        object btnAddWhiteList: TButton
          Left = 4
          Top = 356
          Width = 75
          Height = 25
          Caption = 'Ekle'
          TabOrder = 15
          OnClick = btnAddWhiteListClick
        end
        object btnGetWhiteList: TButton
          Left = 259
          Top = 359
          Width = 75
          Height = 25
          Caption = 'Bul'
          TabOrder = 18
          OnClick = btnGetWhiteListClick
        end
        object btnEditWhiteList: TButton
          Left = 85
          Top = 359
          Width = 75
          Height = 25
          Caption = 'De'#287'i'#351'tir'
          TabOrder = 16
          OnClick = btnEditWhiteListClick
        end
        object btnDeleteWhiteList: TButton
          Left = 170
          Top = 359
          Width = 75
          Height = 25
          Caption = 'Sil'
          TabOrder = 17
          OnClick = btnDeleteWhiteListClick
        end
        object seCode: TSpinEdit
          Left = 78
          Top = 116
          Width = 122
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 0
        end
        object sePassword: TSpinEdit
          Left = 78
          Top = 138
          Width = 122
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
        object btnCardIDCnt: TButton
          Left = -1
          Top = 393
          Width = 122
          Height = 25
          Caption = 'Tan'#305'ml'#305' Kart Say'#305's'#305
          TabOrder = 19
          OnClick = btnCardIDCntClick
        end
        object btnClearWhiteList: TButton
          Left = 458
          Top = 21
          Width = 138
          Height = 25
          Caption = 'Tan'#305'ml'#305' T'#252'm Ki'#351'ileri Sil'
          TabOrder = 1
          OnClick = btnClearWhiteListClick
        end
        object cbAccessCardEnabled: TCheckBox
          Left = 40
          Top = 287
          Width = 196
          Height = 17
          Caption = 'Karttan Access Kontrol'#252' Yap'#305'ls'#305'n'
          TabOrder = 12
        end
        object gbYmkPerson: TGroupBox
          Left = 271
          Top = 73
          Width = 218
          Height = 135
          Caption = 'Ki'#351'i Yemekhane Ayarlar'#305
          TabOrder = 3
          Visible = False
          object Label131: TLabel
            Left = 17
            Top = 29
            Width = 64
            Height = 13
            Caption = 'Ayar Liste No'
          end
          object Label132: TLabel
            Left = 17
            Top = 53
            Width = 94
            Height = 13
            Caption = 'Toplam Haftal'#305'k Hak'
          end
          object Label133: TLabel
            Left = 17
            Top = 81
            Width = 80
            Height = 13
            Caption = 'Toplam Ayl'#305'k Hak'
          end
          object Label98: TLabel
            Left = 17
            Top = 109
            Width = 87
            Height = 13
            Caption = 'Need Cmd Control'
          end
          object edtMealListNo: TSpinEdit
            Left = 130
            Top = 25
            Width = 62
            Height = 22
            MaxValue = 15
            MinValue = 0
            TabOrder = 0
            Value = 0
          end
          object edtWeeklyMealRight: TSpinEdit
            Left = 130
            Top = 49
            Width = 62
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 1
            Value = 0
          end
          object edtMonthlyMealRight: TSpinEdit
            Left = 130
            Top = 77
            Width = 62
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 2
            Value = 0
          end
          object edtNeedCmdControl: TSpinEdit
            Left = 130
            Top = 105
            Width = 62
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 3
            Value = 0
          end
        end
        object cbIsOnlineCard: TCheckBox
          Left = 40
          Top = 309
          Width = 196
          Height = 17
          Caption = 'Kart Offline da Online M'#305' '#199'al'#305#351's'#305'n'
          TabOrder = 13
        end
        object cbPermitedInEmergency: TCheckBox
          Left = 40
          Top = 332
          Width = 196
          Height = 17
          Caption = 'Permited In emergency'
          TabOrder = 14
        end
        object edtBirthDate: TDateTimePicker
          Left = 139
          Top = 193
          Width = 93
          Height = 21
          Date = 73050.416025474540000000
          Time = 73050.416025474540000000
          TabOrder = 8
        end
      end
      object tsInOutValues: TTabSheet
        Caption = 'Giri'#351' '#199#305'k'#305#351' Bilgileri'
        ImageIndex = 6
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object grpCihazGirisCikis: TGroupBox
          Left = 17
          Top = 18
          Width = 407
          Height = 119
          Caption = 'Cihazdan G/C Bilgilerini Transfer Etme'
          TabOrder = 0
          object Label5: TLabel
            Left = 14
            Top = 32
            Width = 53
            Height = 13
            Caption = 'Dosya Yolu'
          end
          object lbl4: TLabel
            Left = 14
            Top = 56
            Width = 44
            Height = 13
            Caption = 'Ba'#351'lang'#305#231
          end
          object lbl5: TLabel
            Left = 14
            Top = 81
            Width = 20
            Height = 13
            Caption = 'Say'#305
          end
          object edtDosyaYolu: TEdit
            Left = 92
            Top = 29
            Width = 233
            Height = 21
            TabOrder = 1
          end
          object btnDosyaYolu: TButton
            Left = 333
            Top = 27
            Width = 37
            Height = 25
            Caption = '...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = btnDosyaYoluClick
          end
          object seStartFrom: TSpinEdit
            Left = 92
            Top = 53
            Width = 64
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 2
            Value = 0
          end
          object seHowMany: TSpinEdit
            Left = 92
            Top = 78
            Width = 64
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 5
            Value = 0
          end
          object btnVeriOku: TButton
            Left = 180
            Top = 76
            Width = 101
            Height = 25
            Caption = 'Verileri Oku'
            TabOrder = 3
            OnClick = btnVeriOkuClick
          end
          object btnVeriTransferEt: TButton
            Left = 288
            Top = 76
            Width = 101
            Height = 25
            Caption = 'Verileri Transfer Et'
            TabOrder = 4
            OnClick = btnVeriTransferEtClick
          end
        end
        object mmFile: TMemo
          Left = 0
          Top = 246
          Width = 667
          Height = 251
          Align = alBottom
          ScrollBars = ssVertical
          TabOrder = 2
          ExplicitTop = 371
        end
        object GroupBox9: TGroupBox
          Left = 452
          Top = 23
          Width = 184
          Height = 114
          Caption = 'Test'
          TabOrder = 1
          Visible = False
          object Label59: TLabel
            Left = 21
            Top = 24
            Width = 54
            Height = 13
            Caption = 'Kay'#305't Say'#305's'#305
          end
          object lblTestRecCnt: TLabel
            Left = 59
            Top = 81
            Width = 48
            Height = 13
            Caption = '............'
          end
          object seTestRecCnt: TSpinEdit
            Left = 98
            Top = 22
            Width = 64
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 500
          end
          object btnTestRecord: TButton
            Left = 19
            Top = 50
            Width = 142
            Height = 25
            Caption = 'Test Kay'#305'tlar'#305' Olu'#351'tur'
            TabOrder = 1
            OnClick = btnTestRecordClick
          end
        end
      end
      object tsDataFlash: TTabSheet
        Caption = 'Read - Write Block Data'
        ImageIndex = 7
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 667
          Height = 71
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label58: TLabel
            Left = 17
            Top = 16
            Width = 67
            Height = 13
            Caption = 'Start Page No'
          end
          object Label60: TLabel
            Left = 17
            Top = 44
            Width = 61
            Height = 13
            Caption = 'End Page No'
          end
          object lblCnt: TLabel
            Left = 520
            Top = 48
            Width = 16
            Height = 13
            Caption = '....'
          end
          object btnReadDfPage: TButton
            Left = 199
            Top = 7
            Width = 82
            Height = 25
            Caption = 'Read Page'
            TabOrder = 0
            OnClick = btnReadDfPageClick
          end
          object edDFStartPageNo: TSpinEdit
            Left = 93
            Top = 13
            Width = 64
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 3
            Value = 2
          end
          object btnWriteDfPage: TButton
            Left = 199
            Top = 38
            Width = 82
            Height = 25
            Caption = 'Write Page'
            TabOrder = 5
            OnClick = btnWriteDfPageClick
          end
          object edDFEndPageNo: TSpinEdit
            Left = 93
            Top = 41
            Width = 64
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 8
            Value = 2
          end
          object btnSaveDF: TButton
            Left = 415
            Top = 8
            Width = 81
            Height = 25
            Caption = 'Dosyaya Yaz'
            TabOrder = 1
            OnClick = btnSaveDFClick
          end
          object btnLoadDF: TButton
            Left = 520
            Top = 8
            Width = 89
            Height = 25
            Caption = 'Dosyadan Oku'
            TabOrder = 2
            OnClick = btnLoadDFClick
          end
          object Button1: TButton
            Left = 302
            Top = 40
            Width = 75
            Height = 25
            Caption = 'Test Ozan'
            TabOrder = 7
            OnClick = Button1Click
          end
          object Button2: TButton
            Left = 415
            Top = 39
            Width = 66
            Height = 25
            Caption = 'Erzurum Atat'#252'rk '#220'niv.'
            TabOrder = 6
            OnClick = Button2Click
          end
          object edtIP2: TEdit
            Left = 287
            Top = 13
            Width = 105
            Height = 21
            TabOrder = 4
            Text = '192.168.0.121'
          end
        end
        object mmdf: TListBox
          Left = 0
          Top = 71
          Width = 667
          Height = 426
          Align = alClient
          ItemHeight = 13
          TabOrder = 1
          OnDblClick = mmdfDblClick
        end
      end
      object tsHGSSettings: TTabSheet
        Caption = 'HGS Ayarlar'#305' - Tag Ekleme'
        ImageIndex = 8
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object Label74: TLabel
          Left = 254
          Top = 22
          Width = 31
          Height = 13
          Caption = 'Tag Id'
        end
        object lblHGSIndexNo: TLabel
          Left = 458
          Top = 24
          Width = 52
          Height = 13
          Caption = '.............'
        end
        object Label76: TLabel
          Left = 256
          Top = 51
          Width = 41
          Height = 13
          Caption = 'Plaka No'
        end
        object Label77: TLabel
          Left = 256
          Top = 75
          Width = 25
          Height = 13
          Caption = 'Daire'
        end
        object Label78: TLabel
          Left = 256
          Top = 100
          Width = 22
          Height = 13
          Caption = 'Ara'#231
        end
        object Label79: TLabel
          Left = 327
          Top = 124
          Width = 44
          Height = 13
          Caption = 'Pazartesi'
        end
        object Label80: TLabel
          Left = 387
          Top = 124
          Width = 16
          Height = 13
          Caption = 'Sal'#305
        end
        object Label81: TLabel
          Left = 418
          Top = 124
          Width = 48
          Height = 13
          Caption = #199'ar'#351'amba'
        end
        object Label82: TLabel
          Left = 468
          Top = 124
          Width = 47
          Height = 13
          Caption = 'Per'#351'embe'
        end
        object Label83: TLabel
          Left = 520
          Top = 124
          Width = 27
          Height = 13
          Caption = 'Cuma'
        end
        object Label84: TLabel
          Left = 564
          Top = 124
          Width = 48
          Height = 13
          Caption = 'Cumartesi'
        end
        object Label85: TLabel
          Left = 620
          Top = 124
          Width = 27
          Height = 13
          Caption = 'Pazar'
        end
        object Label86: TLabel
          Left = 254
          Top = 146
          Width = 54
          Height = 13
          Caption = 'Zaman K'#305's'#305't'
        end
        object Label87: TLabel
          Left = 254
          Top = 174
          Width = 103
          Height = 13
          Caption = 'Kart'#305'n Son. Kul. Tarihi'
        end
        object lblHGSTanimliKisi: TLabel
          Left = 406
          Top = 343
          Width = 12
          Height = 13
          Caption = '...'
        end
        object gbHgsStettings: TGroupBox
          Left = 1
          Top = 0
          Width = 248
          Height = 465
          Caption = ' HGS Genel Ayarlar'#305' '
          TabOrder = 0
          object Label64: TLabel
            Left = 4
            Top = 24
            Width = 75
            Height = 13
            Caption = 'Seri Paket Boyu'
          end
          object Label61: TLabel
            Left = 4
            Top = 49
            Width = 67
            Height = 13
            Caption = 'Kart Ba'#351'lang'#305#231
          end
          object Label62: TLabel
            Left = 4
            Top = 74
            Width = 69
            Height = 13
            Caption = 'Tag ID Boyutu'
          end
          object Label63: TLabel
            Left = 4
            Top = 99
            Width = 83
            Height = 13
            Caption = 'Transist'#246'r '#199#305'k'#305#351#305' 1'
          end
          object Label65: TLabel
            Left = 4
            Top = 124
            Width = 83
            Height = 13
            Caption = 'Transist'#246'r '#199#305'k'#305#351#305' 2'
          end
          object Label66: TLabel
            Left = 4
            Top = 149
            Width = 69
            Height = 13
            Caption = 'Program Modu'
          end
          object Label67: TLabel
            Left = 4
            Top = 174
            Width = 96
            Height = 13
            Caption = 'Dizi Ard'#305#351#305'k Kontrol 1'
          end
          object Label69: TLabel
            Left = 4
            Top = 229
            Width = 59
            Height = 13
            Caption = 'Anten G'#252#231' 1'
          end
          object Label70: TLabel
            Left = 4
            Top = 254
            Width = 59
            Height = 13
            Caption = 'Anten G'#252#231' 2'
          end
          object Label71: TLabel
            Left = 4
            Top = 279
            Width = 104
            Height = 13
            Caption = 'Anten G'#252#231' K. Tan'#305'tma'
          end
          object Label72: TLabel
            Left = 4
            Top = 304
            Width = 108
            Height = 13
            Caption = 'Vars. Daire Ara'#231' Say'#305's'#305
          end
          object Label73: TLabel
            Left = 4
            Top = 334
            Width = 113
            Height = 13
            Caption = 'Ard'#305#351#305'k Ge'#231'i'#351' S'#252'resi (dk)'
          end
          object Label93: TLabel
            Left = 4
            Top = 365
            Width = 46
            Height = 13
            Caption = 'App Type'
          end
          object Label68: TLabel
            Left = 196
            Top = 170
            Width = 30
            Height = 13
            Caption = 'x10Sn'
          end
          object Label107: TLabel
            Left = 192
            Top = 329
            Width = 38
            Height = 26
            Caption = '1..255 0-Kapal'#305
            WordWrap = True
          end
          object Label108: TLabel
            Left = 192
            Top = 296
            Width = 38
            Height = 26
            Caption = '1..6 0-Kapal'#305
            WordWrap = True
          end
          object edtHGSPaketBoyu: TSpinEdit
            Left = 118
            Top = 21
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 0
            Value = 14
          end
          object bntGetHGSSettings: TButton
            Left = 17
            Top = 398
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 14
            OnClick = bntGetHGSSettingsClick
          end
          object bntSetHGSSettings: TButton
            Left = 88
            Top = 398
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 15
            OnClick = bntSetHGSSettingsClick
          end
          object edtHGSKartBaslangic: TSpinEdit
            Left = 118
            Top = 45
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 1
            Value = 4
          end
          object edtHGSKartBoyu: TSpinEdit
            Left = 118
            Top = 69
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 2
            Value = 8
          end
          object edtHGSRLOut1: TSpinEdit
            Left = 118
            Top = 94
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 3
            Value = 8
          end
          object edtHGSRLOut2: TSpinEdit
            Left = 118
            Top = 118
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 4
            Value = 8
          end
          object cbProgramModu: TComboBox
            Left = 79
            Top = 146
            Width = 164
            Height = 21
            Style = csDropDownList
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            TabOrder = 5
            Items.Strings = (
              'Tek Anten'
              #199'ift Anten Tek Ge'#231'i'#351
              #199'ift Anten '#199'ift Ge'#231'i'#351)
          end
          object edtHGSDiziAyar1: TSpinEdit
            Left = 116
            Top = 167
            Width = 54
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 6
            Value = 8
          end
          object CheckBox1: TCheckBox
            Left = 44
            Top = 200
            Width = 121
            Height = 17
            Caption = 'Zaman K'#305's'#305't Etkin'
            Checked = True
            State = cbChecked
            TabOrder = 7
          end
          object edtHGSAntenGuc1: TSpinEdit
            Left = 118
            Top = 226
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 8
            Value = 14
          end
          object edtHGSAntenGuc2: TSpinEdit
            Left = 118
            Top = 250
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 9
            Value = 4
          end
          object edtHGSAntenGucKTanima: TSpinEdit
            Left = 118
            Top = 274
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 10
            Value = 8
          end
          object edtHGSVDaireAS: TSpinEdit
            Left = 118
            Top = 299
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 11
            Value = 8
          end
          object edtHGSApb: TSpinEdit
            Left = 118
            Top = 331
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 12
            Value = 8
          end
          object edtHGSAppType: TSpinEdit
            Left = 117
            Top = 361
            Width = 68
            Height = 22
            MaxValue = 255
            MinValue = 0
            TabOrder = 13
            Value = 8
          end
          object cbSetAppDefRebootHgs: TCheckBox
            Left = 49
            Top = 424
            Width = 121
            Height = 17
            Caption = 'Yeniden Ba'#351'lat'
            TabOrder = 16
          end
          object btnSetAppFactoryDefaultsHgs: TButton
            Left = 7
            Top = 442
            Width = 223
            Height = 23
            Caption = 'Uygulama Ayarlar'#305'n'#305' Fabrika ayarlar'#305'na getir'
            TabOrder = 17
            OnClick = btnSetAppFactoryDefaultsHgsClick
          end
        end
        object edtHGSCardID: TEdit
          Left = 327
          Top = 19
          Width = 147
          Height = 21
          MaxLength = 16
          TabOrder = 2
        end
        object edtHGSAdi: TEdit
          Left = 327
          Top = 46
          Width = 147
          Height = 21
          MaxLength = 18
          TabOrder = 3
        end
        object edtHGSDaireNo: TSpinEdit
          Left = 327
          Top = 71
          Width = 78
          Height = 22
          MaxValue = 3000
          MinValue = 1
          TabOrder = 4
          Value = 1
        end
        object edtHGSAracNo: TSpinEdit
          Left = 327
          Top = 97
          Width = 78
          Height = 22
          MaxValue = 15
          MinValue = 1
          TabOrder = 5
          Value = 1
        end
        object edtHGSZK1: TSpinEdit
          Left = 327
          Top = 143
          Width = 44
          Height = 22
          MaxValue = 65
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
        object edtHGSZK2: TSpinEdit
          Left = 373
          Top = 143
          Width = 44
          Height = 22
          MaxValue = 65
          MinValue = 0
          TabOrder = 7
          Value = 0
        end
        object edtHGSZK3: TSpinEdit
          Left = 418
          Top = 143
          Width = 48
          Height = 22
          MaxValue = 65
          MinValue = 0
          TabOrder = 8
          Value = 0
        end
        object edtHGSZK4: TSpinEdit
          Left = 468
          Top = 143
          Width = 47
          Height = 22
          MaxValue = 65
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
        object edtHGSZK5: TSpinEdit
          Left = 518
          Top = 143
          Width = 44
          Height = 22
          MaxValue = 65
          MinValue = 0
          TabOrder = 10
          Value = 0
        end
        object edtHGSZK6: TSpinEdit
          Left = 564
          Top = 143
          Width = 48
          Height = 22
          MaxValue = 65
          MinValue = 0
          TabOrder = 11
          Value = 0
        end
        object edtHGSZK7: TSpinEdit
          Left = 614
          Top = 143
          Width = 44
          Height = 22
          MaxValue = 255
          MinValue = 0
          TabOrder = 12
          Value = 0
        end
        object edtHGSKartSonTarih: TDateTimePicker
          Left = 372
          Top = 171
          Width = 93
          Height = 21
          Date = 73050.416025474540000000
          Time = 73050.416025474540000000
          TabOrder = 13
        end
        object cbHGSEnabled: TCheckBox
          Left = 319
          Top = 201
          Width = 121
          Height = 17
          Caption = 'Ki'#351'i cihazda aktif mi?'
          Checked = True
          State = cbChecked
          TabOrder = 14
        end
        object cbHGSAPBEnabled: TCheckBox
          Left = 319
          Top = 222
          Width = 180
          Height = 17
          Caption = 'AntiPassBack kontrol'#252' olsun mu?'
          Checked = True
          State = cbChecked
          TabOrder = 15
        end
        object cbHGSZKEnabled: TCheckBox
          Left = 319
          Top = 244
          Width = 180
          Height = 17
          Caption = 'Zaman k'#305's'#305't kontrol'#252' olsun mu?'
          Checked = True
          State = cbChecked
          TabOrder = 16
        end
        object btnHGSAddWitelist: TButton
          Left = 262
          Top = 271
          Width = 75
          Height = 25
          Caption = 'Ekle'
          TabOrder = 17
          OnClick = btnHGSAddWitelistClick
        end
        object btnHGSEditWitelist: TButton
          Left = 345
          Top = 271
          Width = 115
          Height = 25
          Caption = 'De'#287'i'#351'tir (Tag ID)'
          TabOrder = 18
          OnClick = btnHGSEditWitelistClick
        end
        object btnHGSDelWitelist: TButton
          Left = 466
          Top = 271
          Width = 91
          Height = 25
          Caption = 'Sil (Tag ID)'
          TabOrder = 19
          OnClick = btnHGSDelWitelistClick
        end
        object btnHGSFindWitelist: TButton
          Left = 564
          Top = 271
          Width = 98
          Height = 25
          Caption = 'Bul (Tag ID)'
          TabOrder = 20
          OnClick = btnHGSFindWitelistClick
        end
        object btnHgsCardIDCnt: TButton
          Left = 262
          Top = 338
          Width = 122
          Height = 25
          Caption = 'Tan'#305'ml'#305' Ara'#231' Say'#305's'#305
          TabOrder = 23
          OnClick = btnHgsCardIDCntClick
        end
        object btnHGSClearWhiteList: TButton
          Left = 539
          Top = 17
          Width = 124
          Height = 25
          Caption = 'Tan'#305'ml'#305' T'#252'm Ara'#231'lar'#305' Sil'
          TabOrder = 1
          OnClick = btnHGSClearWhiteListClick
        end
        object btnHGSDelWitelistDA: TButton
          Left = 464
          Top = 302
          Width = 92
          Height = 25
          Caption = 'Sil (Daire Ara'#231')'
          TabOrder = 21
          OnClick = btnHGSDelWitelistDAClick
        end
        object btnHGSFindWitelistDA: TButton
          Left = 563
          Top = 302
          Width = 99
          Height = 25
          Caption = 'Bul (Daire Ara'#231')'
          TabOrder = 22
          OnClick = btnHGSFindWitelistDAClick
        end
        object GroupBox5: TGroupBox
          Left = 254
          Top = 375
          Width = 411
          Height = 54
          Caption = ' Daire Ara'#231' Hakk'#305' Otopark Hakk'#305
          TabOrder = 24
          object Label91: TLabel
            Left = 7
            Top = 23
            Width = 25
            Height = 13
            Caption = 'Daire'
          end
          object Label92: TLabel
            Left = 114
            Top = 24
            Width = 67
            Height = 13
            Caption = 'Otopark Hakk'#305
          end
          object edtHGSDaireHK: TSpinEdit
            Left = 39
            Top = 20
            Width = 63
            Height = 22
            MaxValue = 3000
            MinValue = 0
            TabOrder = 2
            Value = 1
          end
          object edtHGSDaireOtoparkHak: TSpinEdit
            Left = 187
            Top = 21
            Width = 68
            Height = 22
            MaxLength = 15
            MaxValue = 0
            MinValue = 0
            TabOrder = 3
            Value = 0
          end
          object bntGetHGSDaireHak: TButton
            Left = 269
            Top = 18
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 0
            OnClick = bntGetHGSDaireHakClick
          end
          object bntSetHGSDaireHak: TButton
            Left = 340
            Top = 18
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 1
            OnClick = bntSetHGSDaireHakClick
          end
        end
        object Button3: TButton
          Left = 255
          Top = 435
          Width = 122
          Height = 25
          Caption = 'Hebele'
          TabOrder = 25
          Visible = False
          OnClick = Button3Click
        end
      end
      object tsHGSInOutValues: TTabSheet
        Caption = 'HGS Giri'#351' '#199#305'k'#305#351' Bilgileri'
        ImageIndex = 9
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object mmHGSFile: TMemo
          Left = 0
          Top = 246
          Width = 667
          Height = 251
          Align = alBottom
          ScrollBars = ssVertical
          TabOrder = 1
          ExplicitTop = 371
        end
        object grpHGSCihazGirisCikis: TGroupBox
          Left = 25
          Top = 26
          Width = 407
          Height = 119
          Caption = 'Cihazdan G/C Bilgilerini Transfer Etme'
          TabOrder = 0
          object Label88: TLabel
            Left = 14
            Top = 32
            Width = 53
            Height = 13
            Caption = 'Dosya Yolu'
          end
          object Label89: TLabel
            Left = 14
            Top = 56
            Width = 44
            Height = 13
            Caption = 'Ba'#351'lang'#305#231
          end
          object Label90: TLabel
            Left = 14
            Top = 81
            Width = 20
            Height = 13
            Caption = 'Say'#305
          end
          object edtHGSDosyaYolu: TEdit
            Left = 92
            Top = 29
            Width = 233
            Height = 21
            TabOrder = 1
          end
          object btnHGSDosyaYolu: TButton
            Left = 333
            Top = 27
            Width = 37
            Height = 25
            Caption = '...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = btnHGSDosyaYoluClick
          end
          object seHGSStartFrom: TSpinEdit
            Left = 92
            Top = 53
            Width = 64
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 2
            Value = 0
          end
          object seHGSHowMany: TSpinEdit
            Left = 92
            Top = 78
            Width = 64
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 5
            Value = 0
          end
          object btnHGSVeriOku: TButton
            Left = 180
            Top = 76
            Width = 101
            Height = 25
            Caption = 'Verileri Oku'
            TabOrder = 3
            OnClick = btnHGSVeriOkuClick
          end
          object btnHGSVeriTransferEt: TButton
            Left = 288
            Top = 76
            Width = 101
            Height = 25
            Caption = 'Verileri Transfer Et'
            TabOrder = 4
            OnClick = btnHGSVeriTransferEtClick
          end
        end
      end
      object tsYMKSettings: TTabSheet
        Caption = 'YemekHane - Kont'#246'r Ayarlar'#305
        ImageIndex = 10
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object GroupBox6: TGroupBox
          Left = 3
          Top = 6
          Width = 234
          Height = 195
          Caption = 'Ayarlar'
          TabOrder = 0
          object Label96: TLabel
            Left = 16
            Top = 43
            Width = 82
            Height = 13
            Caption = 'Se'#231'ili Fiyat Listesi'
          end
          object Label97: TLabel
            Left = 17
            Top = 67
            Width = 70
            Height = 13
            Caption = 'Kart Sekt'#246'r No'
          end
          object Label99: TLabel
            Left = 18
            Top = 91
            Width = 42
            Height = 13
            Caption = #304'stasyon'
          end
          object Label95: TLabel
            Left = 15
            Top = 115
            Width = 157
            Height = 13
            Caption = #214#287#252'n d'#305#351#305'nda Okuyucu Ne yaps'#305'n'
          end
          object btnGetYmkSettings: TButton
            Left = 14
            Top = 172
            Width = 65
            Height = 20
            Caption = 'Getir'
            TabOrder = 5
            OnClick = btnGetYmkSettingsClick
          end
          object btnSetYmkSettings: TButton
            Left = 117
            Top = 172
            Width = 65
            Height = 20
            Caption = 'G'#246'nder'
            TabOrder = 6
            OnClick = btnSetYmkSettingsClick
          end
          object edtYmkCurrPriceList: TSpinEdit
            Left = 125
            Top = 39
            Width = 64
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 1
            Value = 0
          end
          object edtYmkSectorNo: TSpinEdit
            Left = 125
            Top = 64
            Width = 64
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 2
            Value = 0
          end
          object edtYmkPlantNo: TSpinEdit
            Left = 126
            Top = 88
            Width = 64
            Height = 22
            MaxValue = 0
            MinValue = 0
            TabOrder = 3
            Value = 0
          end
          object cbMontlyRight: TCheckBox
            Left = 16
            Top = 20
            Width = 121
            Height = 17
            Caption = 'Ayl'#305'k Hak Etkin'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object cbbOutOfMealstatus: TComboBox
            Left = 14
            Top = 131
            Width = 219
            Height = 21
            Style = csDropDownList
            TabOrder = 4
            Items.Strings = (
              'Kart Okumas'#305'n'
              'Kart Okusun '#214#287#252'n d'#305#351#305' Desin'
              'Kart Okusun Access ge'#231'i'#351'ine izin versin')
          end
        end
        object btnYmkSetFactoryDefault: TButton
          Left = 22
          Top = 282
          Width = 223
          Height = 23
          Caption = 'Uygulama Ayarlar'#305'n'#305' Fabrika ayarlar'#305'na getir'
          TabOrder = 10
          OnClick = btnYmkSetFactoryDefaultClick
        end
        object cbYmkRebootEnb: TCheckBox
          Left = 57
          Top = 259
          Width = 121
          Height = 17
          Caption = 'Yeniden Ba'#351'lat'
          TabOrder = 9
        end
        object btnMealTable: TButton
          Left = 272
          Top = 21
          Width = 180
          Height = 25
          Caption = 'Yemek '#214#287#252'n Tablosu'
          TabOrder = 1
          OnClick = btnMealTableClick
        end
        object btnMealRightTable: TButton
          Left = 272
          Top = 151
          Width = 180
          Height = 25
          Caption = 'Haftal'#305'k Hak Tablosu'
          TabOrder = 5
          OnClick = btnMealRightTableClick
        end
        object btnPriceListTable: TButton
          Left = 272
          Top = 53
          Width = 180
          Height = 25
          Caption = 'Kontor Fiyat Liste Tablosu'
          TabOrder = 2
          OnClick = btnPriceListTableClick
        end
        object Button4: TButton
          Left = 272
          Top = 86
          Width = 180
          Height = 25
          Caption = 'Yemek ayar Tablosu'
          TabOrder = 3
          OnClick = Button4Click
        end
        object btnStaticMealRightTable: TButton
          Left = 272
          Top = 118
          Width = 180
          Height = 25
          Caption = 'Statik Hak Tablosu'
          TabOrder = 4
          OnClick = btnStaticMealRightTableClick
        end
        object btnMonthlyMealRightTable: TButton
          Left = 272
          Top = 184
          Width = 180
          Height = 25
          Caption = 'Ayl'#305'k Ki'#351'i Hak Tablosu'
          TabOrder = 6
          OnClick = btnMonthlyMealRightTableClick
        end
        object Button11: TButton
          Left = 22
          Top = 215
          Width = 180
          Height = 25
          Caption = #214#287#252'n '#304'simleri Tablosu'
          TabOrder = 7
          OnClick = Button11Click
        end
        object Button12: TButton
          Left = 272
          Top = 215
          Width = 180
          Height = 25
          Caption = 'Ki'#351'i Komut Listesi'
          TabOrder = 8
          OnClick = Button12Click
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Black List'
        ImageIndex = 11
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object Label119: TLabel
          Left = 15
          Top = 29
          Width = 33
          Height = 13
          Caption = 'Kart Id'
        end
        object lblIndexNoBlack: TLabel
          Left = 244
          Top = 29
          Width = 52
          Height = 13
          Caption = '.............'
        end
        object lblTanimliKisiBlack: TLabel
          Left = 163
          Top = 182
          Width = 12
          Height = 13
          Caption = '...'
        end
        object Label134: TLabel
          Left = 11
          Top = 82
          Width = 92
          Height = 13
          Caption = 'Black List Komut No'
        end
        object Label135: TLabel
          Left = 15
          Top = 56
          Width = 13
          Height = 13
          Caption = 'Ad'
        end
        object edtCardIdBlack: TEdit
          Left = 86
          Top = 26
          Width = 147
          Height = 21
          MaxLength = 14
          TabOrder = 0
        end
        object Button5: TButton
          Left = 466
          Top = 29
          Width = 138
          Height = 25
          Caption = 'Tan'#305'ml'#305' T'#252'm Ki'#351'ileri Sil'
          TabOrder = 1
          OnClick = btnClearWhiteListClick
        end
        object Button6: TButton
          Left = 20
          Top = 132
          Width = 75
          Height = 25
          Caption = 'Ekle'
          TabOrder = 4
          OnClick = Button6Click
        end
        object Button7: TButton
          Left = 101
          Top = 135
          Width = 75
          Height = 25
          Caption = 'De'#287'i'#351'tir'
          TabOrder = 5
          OnClick = Button7Click
        end
        object Button8: TButton
          Left = 186
          Top = 135
          Width = 75
          Height = 25
          Caption = 'Sil'
          TabOrder = 6
          OnClick = Button8Click
        end
        object Button9: TButton
          Left = 275
          Top = 135
          Width = 75
          Height = 25
          Caption = 'Bul'
          TabOrder = 7
          OnClick = Button9Click
        end
        object Button10: TButton
          Left = 21
          Top = 177
          Width = 122
          Height = 25
          Caption = 'Tan'#305'ml'#305' Kart Say'#305's'#305
          TabOrder = 8
          OnClick = btnCardIDCntClick
        end
        object edtBlackListCmdNo: TSpinEdit
          Left = 109
          Top = 78
          Width = 44
          Height = 22
          MaxValue = 65
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object edtBlackListCaption: TEdit
          Left = 86
          Top = 51
          Width = 147
          Height = 21
          MaxLength = 18
          TabOrder = 2
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Get / Set Node'
        ImageIndex = 12
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object Label102: TLabel
          Left = 15
          Top = 58
          Width = 26
          Height = 13
          Caption = 'Value'
        end
        object Label122: TLabel
          Left = 18
          Top = 80
          Width = 25
          Height = 13
          Caption = 'Color'
        end
        object Label123: TLabel
          Left = 15
          Top = 21
          Width = 28
          Height = 13
          Caption = 'Adres'
        end
        object Label136: TLabel
          Left = 18
          Top = 108
          Width = 19
          Height = 13
          Caption = 'Left'
        end
        object Label137: TLabel
          Left = 18
          Top = 136
          Width = 25
          Height = 13
          Caption = 'Right'
        end
        object Label138: TLabel
          Left = 18
          Top = 164
          Width = 32
          Height = 13
          Caption = 'Parent'
        end
        object edtValue: TEdit
          Left = 86
          Top = 50
          Width = 147
          Height = 21
          MaxLength = 14
          TabOrder = 2
        end
        object edtColor: TSpinEdit
          Left = 86
          Top = 77
          Width = 44
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 0
        end
        object btnGetNode: TButton
          Left = 288
          Top = 19
          Width = 65
          Height = 20
          Caption = 'Getir'
          TabOrder = 1
          OnClick = btnGetNodeClick
        end
        object btnSetNode: TButton
          Left = 287
          Top = 51
          Width = 65
          Height = 20
          Caption = 'G'#246'nder'
          TabOrder = 3
          OnClick = btnSetNodeClick
        end
        object edtAddress: TSpinEdit
          Left = 86
          Top = 18
          Width = 84
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object edtLeft: TSpinEdit
          Left = 86
          Top = 105
          Width = 84
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 5
          Value = 0
        end
        object edtRight: TSpinEdit
          Left = 86
          Top = 133
          Width = 84
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
        object edtParent: TSpinEdit
          Left = 86
          Top = 161
          Width = 84
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 7
          Value = 0
        end
      end
      object TabSheet5: TTabSheet
        Caption = 'Mifare Card Read Write'
        ImageIndex = 13
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 622
        object Label139: TLabel
          Left = 18
          Top = 14
          Width = 31
          Height = 13
          Caption = 'Sekt'#246'r'
        end
        object Label140: TLabel
          Left = 18
          Top = 42
          Width = 19
          Height = 13
          Caption = 'Blok'
        end
        object Label141: TLabel
          Left = 22
          Top = 148
          Width = 98
          Height = 13
          Caption = 'Data(Hex) (16 Byte)'
        end
        object Label142: TLabel
          Left = 73
          Top = 65
          Width = 18
          Height = 13
          Caption = 'Key'
        end
        object Button13: TButton
          Left = 18
          Top = 120
          Width = 127
          Height = 20
          Caption = 'Kart'#305' Oku'
          TabOrder = 4
          OnClick = Button13Click
        end
        object Button14: TButton
          Left = 18
          Top = 176
          Width = 127
          Height = 20
          Caption = 'Kart'#39'a Yaz'
          TabOrder = 6
          OnClick = Button14Click
        end
        object Button15: TButton
          Left = 18
          Top = 202
          Width = 127
          Height = 20
          Caption = 'Ekrana Mesaj G'#246'nder'
          TabOrder = 7
          OnClick = Button15Click
        end
        object edtSectorNo: TSpinEdit
          Left = 86
          Top = 11
          Width = 84
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 5
        end
        object edtBlockNo: TSpinEdit
          Left = 86
          Top = 39
          Width = 84
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
        end
        object edtMfrBlockData: TEdit
          Left = 132
          Top = 146
          Width = 208
          Height = 21
          MaxLength = 32
          TabOrder = 5
          Text = 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'
        end
        object rbKeyTypeA: TRadioButton
          Tag = 1
          Left = 22
          Top = 81
          Width = 45
          Height = 17
          Caption = 'A'
          Checked = True
          TabOrder = 2
          TabStop = True
        end
        object RadioButton2: TRadioButton
          Tag = 1
          Left = 73
          Top = 81
          Width = 51
          Height = 17
          Caption = 'B'
          TabOrder = 3
        end
      end
    end
  end
  object ActionList: TActionList
    Left = 804
    Top = 177
    object ActionRdrConnect: TAction
      Caption = 'Ba'#287'lan'
      OnExecute = ActionRdrConnectExecute
    end
    object ActionRdrDisConnect: TAction
      Caption = 'Ba'#287'lant'#305' Kes'
      OnExecute = ActionRdrDisConnectExecute
    end
  end
  object dtTimer: TTimer
    Enabled = False
    OnTimer = dtTimerTimer
    Left = 704
    Top = 104
  end
  object sdDF: TSaveDialog
    DefaultExt = 'dfd'
    FileName = 
      'C:\Dev_Art\CompSoft\Test_Projects\FB_Db_Designer\Database\test.d' +
      'fd'
    Filter = '*.dfd'
    Left = 388
    Top = 33
  end
  object odDF: TOpenDialog
    DefaultExt = 'dfd'
    Filter = '*.dfd'
    Left = 420
    Top = 33
  end
end
