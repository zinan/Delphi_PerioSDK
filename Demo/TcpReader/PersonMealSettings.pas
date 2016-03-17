unit PersonMealSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls,PerioDevice;

type
  TfrmPersonMealSettings = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    btnGetMealRightTable: TButton;
    btnSetMealRightTable: TButton;
    edtTableNo: TSpinEdit;
    Panel1: TPanel;
    gbYmkPerson: TGroupBox;
    Label94: TLabel;
    Label95: TLabel;
    Label119: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label131: TLabel;
    Label133: TLabel;
    edtMealHakListNo: TSpinEdit;
    edtMealPriceGroup: TSpinEdit;
    cbContorEnable: TCheckBox;
    cmbMealRightMode: TComboBox;
    edtMealReReadPriceGroup: TSpinEdit;
    cmbReReadType: TComboBox;
    edtReReadCount: TSpinEdit;
    edtReReadTimeOut: TSpinEdit;
    mmLog: TMemo;
    Label2: TLabel;
    edtExtraLimit: TSpinEdit;
    procedure btnGetMealRightTableClick(Sender: TObject);
    procedure btnSetMealRightTableClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure AddLog(str: String; SM: Boolean = False);
  public
    { Public declarations }
  end;

var
  frmPersonMealSettings: TfrmPersonMealSettings;

implementation

{$R *.dfm}

uses Main;

procedure TfrmPersonMealSettings.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;


procedure TfrmPersonMealSettings.btnGetMealRightTableClick(Sender: TObject);
Var
  Settings: TPersonMealSetting;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetPersonYmkSettingList(edtTableNo.Value, Settings) then
    Begin
      cbContorEnable.Checked := Settings.ContorModeEnable;
      cmbMealRightMode.ItemIndex := Settings.MealRightWorkMode;
      edtMealHakListNo.Value := Settings.MealRightListNo;
      edtMealPriceGroup.Value := Settings.PriceGroup;
      edtMealReReadPriceGroup.Value := Settings.ReReadPriceGroup;
      cmbReReadType.ItemIndex := Settings.ReReadType;
      edtReReadCount.Value := Settings.ReReadCount;
      edtReReadTimeOut.Value := Settings.ReReadTimeOut;
      edtExtraLimit.Value :=  Settings.ExtraLimit;
      AddLog('Yemek ayarlarý getirildi.');
    End
    else
      AddLog('Yemek ayarlarý getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmPersonMealSettings.btnSetMealRightTableClick(Sender: TObject);
Var
  Settings: TPersonMealSetting;

begin
  if frmMain.Rdr.Connected then
  Begin
    Settings.ContorModeEnable := cbContorEnable.Checked;
    Settings.MealRightWorkMode := cmbMealRightMode.ItemIndex;
    Settings.MealRightListNo := edtMealHakListNo.Value;
    Settings.PriceGroup := edtMealPriceGroup.Value;
    Settings.ReReadPriceGroup := edtMealReReadPriceGroup.Value;
    Settings.ReReadType := cmbReReadType.ItemIndex;
    Settings.ReReadCount := edtReReadCount.Value;
    Settings.ReReadTimeOut := edtReReadTimeOut.Value;
    Settings.ExtraLimit := edtExtraLimit.Value ;


    if frmMain.Rdr.SetPersonYmkSettingList(edtTableNo.Value, Settings) then
    Begin
      AddLog('Yemek ayarlarý gönderildi.');
    End
    else
      AddLog('Yemek ayarlarý gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmPersonMealSettings.FormShow(Sender: TObject);
begin
  btnGetMealRightTable.Click;
end;

end.
