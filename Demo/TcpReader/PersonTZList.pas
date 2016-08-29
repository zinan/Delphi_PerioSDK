unit PersonTZList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,
  Vcl.StdCtrls, Vcl.ExtCtrls,PerioDevice, Vcl.Samples.Spin, Vcl.ComCtrls;

type
  TfrmPersonTZList = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    btnGetMealRightTable: TButton;
    btnSetMealRightTable: TButton;
    edtCardID: TEdit;
    Panel5: TPanel;
    Panel4: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    edtDay1: TDateTimePicker;
    edtSHour1_1: TDateTimePicker;
    edtEHour1_1: TDateTimePicker;
    edtSHour1_2: TDateTimePicker;
    edtEHour1_2: TDateTimePicker;
    edtSHour1_3: TDateTimePicker;
    edtEHour1_3: TDateTimePicker;
    edtSHour1_4: TDateTimePicker;
    edtEHour1_4: TDateTimePicker;
    edtSHour1_5: TDateTimePicker;
    edtEHour1_5: TDateTimePicker;
    edtSHour1_6: TDateTimePicker;
    edtEHour1_6: TDateTimePicker;
    edtSHour1_8: TDateTimePicker;
    edtEHour1_8: TDateTimePicker;
    edtSHour1_7: TDateTimePicker;
    edtEHour1_7: TDateTimePicker;
    Panel2: TPanel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    edtDay3: TDateTimePicker;
    edtSHour3_1: TDateTimePicker;
    edtEHour3_1: TDateTimePicker;
    edtSHour3_2: TDateTimePicker;
    edtEHour3_2: TDateTimePicker;
    edtSHour3_3: TDateTimePicker;
    edtEHour3_3: TDateTimePicker;
    edtSHour3_4: TDateTimePicker;
    edtEHour3_4: TDateTimePicker;
    edtSHour3_5: TDateTimePicker;
    edtEHour3_5: TDateTimePicker;
    edtSHour3_6: TDateTimePicker;
    edtEHour3_6: TDateTimePicker;
    edtSHour3_8: TDateTimePicker;
    edtEHour3_8: TDateTimePicker;
    edtSHour3_7: TDateTimePicker;
    edtEHour3_7: TDateTimePicker;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtDay2: TDateTimePicker;
    edtSHour2_1: TDateTimePicker;
    edtEHour2_1: TDateTimePicker;
    edtSHour2_2: TDateTimePicker;
    edtEHour2_2: TDateTimePicker;
    edtSHour2_3: TDateTimePicker;
    edtEHour2_3: TDateTimePicker;
    edtSHour2_4: TDateTimePicker;
    edtEHour2_4: TDateTimePicker;
    edtSHour2_5: TDateTimePicker;
    edtEHour2_5: TDateTimePicker;
    edtSHour2_6: TDateTimePicker;
    edtEHour2_6: TDateTimePicker;
    edtSHour2_8: TDateTimePicker;
    edtEHour2_8: TDateTimePicker;
    edtSHour2_7: TDateTimePicker;
    edtEHour2_7: TDateTimePicker;
    Panel6: TPanel;
    mmLog: TMemo;
    Panel7: TPanel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtDay4: TDateTimePicker;
    edtSHour4_1: TDateTimePicker;
    edtEHour4_1: TDateTimePicker;
    edtSHour4_2: TDateTimePicker;
    edtEHour4_2: TDateTimePicker;
    edtSHour4_3: TDateTimePicker;
    edtEHour4_3: TDateTimePicker;
    edtSHour4_4: TDateTimePicker;
    edtEHour4_4: TDateTimePicker;
    edtSHour4_5: TDateTimePicker;
    edtEHour4_5: TDateTimePicker;
    edtSHour4_6: TDateTimePicker;
    edtEHour4_6: TDateTimePicker;
    edtSHour4_8: TDateTimePicker;
    edtEHour4_8: TDateTimePicker;
    edtSHour4_7: TDateTimePicker;
    edtEHour4_7: TDateTimePicker;
    Panel8: TPanel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    edtDay5: TDateTimePicker;
    edtSHour5_1: TDateTimePicker;
    edtEHour5_1: TDateTimePicker;
    edtSHour5_2: TDateTimePicker;
    edtEHour5_2: TDateTimePicker;
    edtSHour5_3: TDateTimePicker;
    edtEHour5_3: TDateTimePicker;
    edtSHour5_4: TDateTimePicker;
    edtEHour5_4: TDateTimePicker;
    edtSHour5_5: TDateTimePicker;
    edtEHour5_5: TDateTimePicker;
    edtSHour5_6: TDateTimePicker;
    edtEHour5_6: TDateTimePicker;
    edtSHour5_8: TDateTimePicker;
    edtEHour5_8: TDateTimePicker;
    edtSHour5_7: TDateTimePicker;
    edtEHour5_7: TDateTimePicker;
    edtTZNo1: TSpinEdit;
    edtTZNo2: TSpinEdit;
    edtTZNo3: TSpinEdit;
    edtTZNo4: TSpinEdit;
    edtTZNo5: TSpinEdit;
    procedure btnGetMealRightTableClick(Sender: TObject);
    procedure btnSetMealRightTableClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLog(str: String; SM: Boolean = False);
  end;

var
  frmPersonTZList: TfrmPersonTZList;

implementation

{$R *.dfm}

uses Main;

procedure TfrmPersonTZList.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmPersonTZList.btnGetMealRightTableClick(Sender: TObject);
Var
  PersTZList : TPersTZList;
  k,i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetPersonTZList(edtCardID.Text,PersTZList) then
    Begin
      for I := 0 to 4 do
      begin
        TDateTimePicker(FindComponent('edtDay'+IntToStr(i+1))).Date := PersTZList.List[i].Day;
        TSpinEdit(FindComponent('edtTZNo'+IntToStr(i+1))).Value := PersTZList.List[i].TZListNo;
        for k := 0 to 7 do
          Begin
            TDateTimePicker(FindComponent('edtSHour'+IntToStr(i+1)+'_'+IntToStr(k+1))).Time := PersTZList.List[i].Part[k].StartTime;
            TDateTimePicker(FindComponent('edtEHour'+IntToStr(i+1)+'_'+IntToStr(k+1))).Time := PersTZList.List[i].Part[k].EndTime;
          End;
      end;
      AddLog('Personel Zaman Kýsýt Bilgisi getirildi.');
    End
    else
      AddLog('Personel Zaman Kýsýt Bilgisi getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmPersonTZList.btnSetMealRightTableClick(Sender: TObject);
Var
  PersTZList : TPersTZList;
  k,i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
      for I := 0 to 4 do
      begin
        PersTZList.List[i].Day := TDateTimePicker(FindComponent('edtDay'+IntToStr(i+1))).Date;
        PersTZList.List[i].TZListNo := TSpinEdit(FindComponent('edtTZNo'+IntToStr(i+1))).Value;
        for k := 0 to 7 do
          Begin
            PersTZList.List[i].Part[k].StartTime := TDateTimePicker(FindComponent('edtSHour'+IntToStr(i+1)+'_'+IntToStr(k+1))).Time;
            PersTZList.List[i].Part[k].EndTime := TDateTimePicker(FindComponent('edtEHour'+IntToStr(i+1)+'_'+IntToStr(k+1))).Time;
          End;
      end;
    if frmMain.Rdr.SetPersonTZList(edtCardID.Text,PersTZList) then
    Begin
      AddLog('Personel Zaman Kýsýt Bilgisi gönderildi.');
    End
    else
      AddLog('Personel Zaman Kýsýt Bilgisi  gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

end.
