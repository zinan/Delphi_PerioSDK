object frmDFData: TfrmDFData
  Left = 0
  Top = 0
  Caption = 'Page'
  ClientHeight = 212
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 455
    Height = 49
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Button1: TButton
      Left = 368
      Top = 11
      Width = 75
      Height = 25
      Caption = 'De'#287'i'#351'tir Kapat'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object mmdata: TMemo
    Left = 0
    Top = 49
    Width = 455
    Height = 163
    Align = alClient
    TabOrder = 1
  end
end
