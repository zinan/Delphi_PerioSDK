object frmPersonMealSettings: TfrmPersonMealSettings
  Left = 0
  Top = 0
  Caption = 'frmPersonMealSettings'
  ClientHeight = 361
  ClientWidth = 543
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
    Width = 543
    Height = 32
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 8
      Width = 37
      Height = 13
      Caption = 'Liste no'
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
      MaxValue = 65
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 32
    Width = 379
    Height = 329
    Align = alClient
    TabOrder = 1
    object gbYmkPerson: TGroupBox
      Left = 24
      Top = 18
      Width = 325
      Height = 271
      Caption = 'Ki'#351'i Yemekhane Ayarlar'#305
      TabOrder = 0
      object Label94: TLabel
        Left = 5
        Top = 80
        Width = 87
        Height = 13
        Caption = #214#287#252'n Hak Tablosu'
      end
      object Label95: TLabel
        Left = 5
        Top = 106
        Width = 98
        Height = 13
        Caption = #220'cretlendirme Grubu'
      end
      object Label119: TLabel
        Left = 5
        Top = 51
        Width = 47
        Height = 13
        Caption = 'Hak Modu'
      end
      object Label122: TLabel
        Left = 5
        Top = 134
        Width = 108
        Height = 13
        Caption = 'Y.'#220'cretlendirme Grubu'
      end
      object Label123: TLabel
        Left = 5
        Top = 194
        Width = 149
        Height = 13
        Caption = 'Yeniden Okuma S'#305'f'#305'rlama Modu '
      end
      object Label131: TLabel
        Left = 5
        Top = 218
        Width = 108
        Height = 13
        Caption = 'Yeniden Okutma Say'#305's'#305
      end
      object Label133: TLabel
        Left = 3
        Top = 250
        Width = 103
        Height = 13
        Caption = 'Yeniden Okutma S'#252're'
      end
      object Label2: TLabel
        Left = 3
        Top = 162
        Width = 49
        Height = 13
        Caption = 'Ektra Limit'
      end
      object edtMealHakListNo: TSpinEdit
        Left = 119
        Top = 74
        Width = 62
        Height = 22
        MaxValue = 47
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object edtMealPriceGroup: TSpinEdit
        Left = 119
        Top = 102
        Width = 62
        Height = 22
        MaxValue = 14
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object cbContorEnable: TCheckBox
        Left = 13
        Top = 24
        Width = 180
        Height = 17
        Caption = 'Yemek Kont'#246'r Kontrol'#252' Olsun'
        TabOrder = 0
      end
      object cmbMealRightMode: TComboBox
        Left = 119
        Top = 47
        Width = 173
        Height = 21
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 1
        Items.Strings = (
          'Hak kontrol'#252' yok'
          'Statik Hak'
          'Haftal'#305'k Hak Modeli'
          'Ayl'#305'k Planlama Modeli'
          'Statik Hak say'#305's'#305'ndan Sonra ReRead Fiyat listesine Ge'#231
          'Haftal'#305'k Hak say'#305's'#305'ndan Sonra ReRead Fiyat listesine Ge'#231
          'Ayl'#305'k Hak say'#305's'#305'ndan Sonra ReRead Fiyat listesine Ge'#231)
      end
      object edtMealReReadPriceGroup: TSpinEdit
        Left = 119
        Top = 130
        Width = 62
        Height = 22
        MaxValue = 14
        MinValue = 0
        TabOrder = 4
        Value = 0
      end
      object cmbReReadType: TComboBox
        Left = 160
        Top = 191
        Width = 128
        Height = 21
        Style = csDropDownList
        BiDiMode = bdLeftToRight
        ItemIndex = 1
        ParentBiDiMode = False
        TabOrder = 6
        Text = #214#287#252'n'
        Items.Strings = (
          'S'#252'reli'
          #214#287#252'n'
          'G'#252'n')
      end
      object edtReReadCount: TSpinEdit
        Left = 119
        Top = 218
        Width = 62
        Height = 22
        MaxValue = 15
        MinValue = 0
        TabOrder = 7
        Value = 0
      end
      object edtReReadTimeOut: TSpinEdit
        Left = 119
        Top = 246
        Width = 62
        Height = 22
        MaxValue = 65535
        MinValue = 0
        TabOrder = 8
        Value = 0
      end
      object edtExtraLimit: TSpinEdit
        Left = 119
        Top = 158
        Width = 62
        Height = 22
        MaxValue = 65535
        MinValue = 0
        TabOrder = 5
        Value = 0
      end
    end
  end
  object mmLog: TMemo
    Left = 379
    Top = 32
    Width = 164
    Height = 329
    Align = alRight
    ReadOnly = True
    TabOrder = 2
  end
end
