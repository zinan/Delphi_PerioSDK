unit RDRDemoMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, CPort,
  Vcl.StdCtrls, CPortCtl, Vcl.ActnList, Vcl.Samples.Spin, Vcl.Menus,
  Vcl.Grids, System.Actions,PerioDevice.UsbReader;

type
  TfrmRDRDemoMain = class(TForm)
    pnlTop: TPanel;
    pgcMain: TPageControl;
    tsTermOperations: TTabSheet;
    tsCardBlockOperations: TTabSheet;
    tsCardConfigrationOperations: TTabSheet;
    stsbMain: TStatusBar;
    lblComRdr: TLabel;
    cbComport: TComComboBox;
    btnConnect: TButton;
    ComLed1: TComLed;
    ActionList: TActionList;
    actConnect: TAction;
    pnlM1: TPanel;
    pnlM2: TPanel;
    pnlM4: TPanel;
    actTermSetParams: TAction;
    actTermGetParams: TAction;
    grbMasterKeyTable: TGroupBox;
    lblMastKeyTableKeyNo: TLabel;
    edtMastKeyNo: TSpinEdit;
    edtMasterKey: TEdit;
    lblMasterTableKey: TLabel;
    btnTermSetMasterKey: TButton;
    actSetMasterKey: TAction;
    grbTermIO: TGroupBox;
    lblIO: TLabel;
    edtIOType: TComboBox;
    lblIODuration: TLabel;
    edtIODuration: TSpinEdit;
    lblIODurms: TLabel;
    btnSetIO: TButton;
    actSetIO: TAction;
    LogTermParams: TMemo;
    grpTermDefSettings: TGroupBox;
    btnTermSaveParams: TButton;
    btnTermSetParams: TButton;
    lbldevno: TLabel;
    edtTermNo: TSpinEdit;
    lblBuzzerTime: TLabel;
    edtDefBuzzerTime: TSpinEdit;
    lblbzrSure: TLabel;
    lblDefCardType: TLabel;
    cbCardType: TComboBox;
    grbDefKeyParam: TGroupBox;
    lblDefKeyType: TLabel;
    lblDefKeyNo: TLabel;
    lblDefBlockNo: TLabel;
    lblDefSectorNo: TLabel;
    cbDefKeyType: TComboBox;
    edtDefKeyNo: TSpinEdit;
    edtDefSectorNo: TSpinEdit;
    edtDefBlockNo: TSpinEdit;
    cbIOBlink: TCheckBox;
    grbBlockLoginType: TGroupBox;
    lblBlockLoginType: TLabel;
    cbBWRLoginType: TComboBox;
    lblBlockKeyNo: TLabel;
    edtBWRKeyno: TSpinEdit;
    edtBWRKey: TEdit;
    cbbBWRKeyType: TComboBox;
    actBlockWrite: TAction;
    actBlockRead: TAction;
    LogBWR: TMemo;
    lblBlockKeyType: TLabel;
    pcBlockValue: TPageControl;
    tsBlockOpts: TTabSheet;
    tsValueOpts: TTabSheet;
    Label1: TLabel;
    edtBWRSectorNo: TSpinEdit;
    lblwrBlockNo: TLabel;
    seBWRBlockNo: TSpinEdit;
    Label3: TLabel;
    edtBWRData: TEdit;
    btnBlockRead: TButton;
    btnBlockWrite: TButton;
    Label4: TLabel;
    edtSrcBlockNo: TSpinEdit;
    Label5: TLabel;
    edtDestBlockNo: TSpinEdit;
    Label6: TLabel;
    edtValue: TSpinEdit;
    btnReadValue: TButton;
    btnReadWrite: TButton;
    btnCopyValue: TButton;
    edtIncDecValue: TSpinEdit;
    btnIncValue: TButton;
    btnDecValue: TButton;
    actReadValue: TAction;
    actWriteValue: TAction;
    actCopyValue: TAction;
    actIncValue: TAction;
    actDecValue: TAction;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    cbFormNo: TComboBox;
    edtConfCardKeyA: TEdit;
    edtConfCardKeyB: TEdit;
    lblConfCardKeyA: TLabel;
    lblConfCardKeyB: TLabel;
    btnConfSector: TButton;
    btnGetSectorConf: TButton;
    actConfSector: TAction;
    actGetSecTorConf: TAction;
    PopupMenu1: TPopupMenu;
    LoguSil1: TMenuItem;
    Label7: TLabel;
    edtReadTimeOut: TSpinEdit;
    ts1: TTabSheet;
    Button1: TButton;
    Edit1: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label10: TLabel;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    StringGrid1: TStringGrid;
    tbTutar: TTabSheet;
    Label11: TLabel;
    edOrnKeyA: TEdit;
    Label12: TLabel;
    edOrnKeyB: TEdit;
    Memo1: TMemo;
    Label13: TLabel;
    edtOrnSector: TSpinEdit;
    Label14: TLabel;
    edtOrnBlok: TSpinEdit;
    Button2: TButton;
    edtTutar: TSpinEdit;
    Label15: TLabel;
    Label16: TLabel;
    edtOncekiTutar: TSpinEdit;
    edtDate: TDateTimePicker;
    procedure actConnectExecute(Sender: TObject);
    procedure actConnectUpdate(Sender: TObject);
    procedure actTermSetParamsUpdate(Sender: TObject);
    procedure cbCardTypeChange(Sender: TObject);
    procedure actTermGetParamsExecute(Sender: TObject);
    procedure actTermSetParamsExecute(Sender: TObject);
    procedure actSetIOExecute(Sender: TObject);
    procedure actSetMasterKeyExecute(Sender: TObject);
    procedure cbBWRLoginTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actBlockReadExecute(Sender: TObject);
    procedure actBlockWriteExecute(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure actReadValueExecute(Sender: TObject);
    procedure actWriteValueExecute(Sender: TObject);
    procedure actCopyValueExecute(Sender: TObject);
    procedure actIncValueExecute(Sender: TObject);
    procedure actDecValueExecute(Sender: TObject);
    procedure pcBlockValueChange(Sender: TObject);
    procedure actConfSectorExecute(Sender: TObject);
    procedure actGetSecTorConfExecute(Sender: TObject);
    procedure ComRdrRxCardID(Sender: TObject; const TermNo: Integer;
      const CardID: string);
    procedure LoguSil1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure ComRdrRxChar(Sender: TObject; Count: Integer);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    ComRdr : TPerioUsbReader;
    CurrentDevParams: TDeviceParams;
    procedure AddTermParamsLog(str: String);
    procedure AddBWRLog(str: String);
    //procedure WriteAccesData(Name:String;StartDate,EndDate:TDateTime;
    //    DoorAccess:T128Byte;Var  Buf0,Buf1,Buf2:array of byte);

    function LoginAndRead
        (strKeyA,strKeyB:String;SektorNo,BlokNo:Integer;out Tutar,OncekiTutar:Integer;out SonTarih:TDatetime):Integer;

    function WriteCard(
        strKeyB:String;SektorNo,BlokNo:Integer;Tutar,OncekiTutar:Integer;SonTarih:TDatetime):Integer;

  end;

var
  frmRDRDemoMain: TfrmRDRDemoMain;

implementation

{$R *.dfm}

procedure TfrmRDRDemoMain.AddTermParamsLog(str: String);
begin
  LogTermParams.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
end;

{
procedure TfrmRDRDemoMain.WriteAccesData(Name:String;StartDate,EndDate:TDateTime;DoorAccess:T128Byte;Var  Buf0,Buf1,Buf2:array of byte);
Var
 i,Len,BytNum:Integer;
 StrName:String[16];
 StDt,EndDt:TDtByte;
 BytVal,ReadVal,TempVal:Byte;
Begin
  for I := 0 to 15 do
  Begin
    Buf0[i] := 20;
    Buf1[i] := 0;
    Buf2[i] := 0;
  End;

  StrName := Name;
  Len := Length(StrName);
  if len>16 then Len := 16;

  for I := 0 to Len-1 do
  Begin
    Buf0[i] := ord(StrName[i+1]);
  End;

  Comrdr.EncodeDTSISDateTime(StartDate,StDt);
  Comrdr.EncodeDTSISDateTime(EndDate,EndDt);

  Buf2[0] := StDt[0];
  Buf2[1] := StDt[1];
  Buf2[2] := StDt[2];
  Buf2[3] := StDt[3];
  Buf2[4] := EndDt[0];
  Buf2[5] := EndDt[1];
  Buf2[6] := EndDt[2];
  Buf2[7] := EndDt[3];

  for BytNum := 0 to 15 do
  Begin
    BytVal := 0;
    for I := 0 to 7 do
    Begin
      ReadVal := DoorAccess[(8*BytNum)+(i)];
      if i=0 Then
        TempVal:=ReadVal
      Else
      Begin
       TempVal:= ReadVal shl i;
      End;
      BytVal:= TempVal or BytVal;
    End;
    Buf1[BytNum]:=BytVal;
  End;
End;
}

procedure TfrmRDRDemoMain.Button1Click(Sender: TObject);
Var
  WBuff0,WBuff1,WBuff2: array [0..15] of byte;
  D1,D2:TDateTime;
  //DoorAccess:T128Byte;
  i,iErr:Integer;
  CardID:String;
begin

  D1:=DateTimePicker1.Date;//+DateTimePicker2.Time;
  D2:=DateTimePicker3.Date;//+DateTimePicker4.Time;

//  for i := 0 to 127 do
//    DoorAccess[i] := StrToInt(StringGrid1.Cells[1,(i+1)]);

//  WriteAccesData(Edit1.Text,D1,D2,DoorAccess,WBuff0,WBuff1,WBuff2);

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    iErr := ComRdr.SectorLogin_withFKey_Philips(15);
    iErr := ComRdr.WriteBlock(WBuff0, 0);
    if iErr = 0 then
    Begin
      ShowMessage('OK');
    End
  End;

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    iErr := ComRdr.SectorLogin_withFKey_Philips(15);
    iErr := ComRdr.WriteBlock(WBuff1, 1);
    if iErr = 0 then
    Begin
      ShowMessage('OK');
    End
  End;

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    iErr := ComRdr.SectorLogin_withFKey_Philips(15);
    iErr := ComRdr.WriteBlock(WBuff2, 2);
    if iErr = 0 then
    Begin
      ShowMessage('OK');
    End
  End;

end;

procedure TfrmRDRDemoMain.Button2Click(Sender: TObject);
begin

  WriteCard(edOrnKeyB.Text,edtOrnSector.Value,edtOrnBlok.Value,
   edtTutar.Value,edtOncekiTutar.Value,edtDate.Date);

//LoginAndRead();
end;

procedure TfrmRDRDemoMain.AddBWRLog(str: String);
begin
  LogBWR.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
end;

function TfrmRDRDemoMain.WriteCard(
  strKeyB:String;SektorNo,BlokNo:Integer;Tutar,OncekiTutar:Integer;SonTarih:TDatetime):Integer;
Var
  iErr: Integer;
  WBuff: array [0..15] of byte;
  CardID, HexStr: String;
//  Key: T6Byte;
//  Dt:TDtByte;
Begin
  WBuff[0] :=  (Tutar) and $FF;
  WBuff[1] :=  (Tutar shr 8) and $FF;
  WBuff[2] :=  (Tutar shr 16) and $FF;
  WBuff[3] :=  (Tutar shr 24) and $FF;
//  Comrdr.EncodeDTSISDateTime(SonTarih,Dt);
//  WBuff[4] :=  dt[0];
//  WBuff[5] :=  dt[1];
//  WBuff[6] :=  dt[2];
//  WBuff[7] :=  dt[3];
  WBuff[8] :=  (Tutar) and $FF;
  WBuff[9] :=  (Tutar shr 8) and $FF;
  WBuff[10] :=  (Tutar shr 16) and $FF;
  WBuff[11] :=  (Tutar shr 24) and $FF;
//  ComRdr.HexStrToT6Byte(strKeyB, Key);
  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
//    iErr := ComRdr.SectorLogin_withKey(ktKeyB, Key, SektorNo);
    if (iErr = 0) then
    Begin
       iErr := ComRdr.WriteBlock(WBuff, BlokNo);
    End;
  End;
  Result := iErr;
End;


function TfrmRDRDemoMain.LoginAndRead
  (strKeyA,strKeyB:String;SektorNo,BlokNo:Integer;out Tutar,OncekiTutar:Integer;out SonTarih:TDatetime):Integer;
Var
  iErr: Integer;
  RBuff: array [0..15] of byte;
  CardID, HexStr: String;
  Key, KeyA, KeyB: array [0..5] of byte;
  Dt:array [0..3] of byte;
Begin
  ComRdr.HexStrToT6Byte(strKeyB, Key);
  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    iErr := ComRdr.SectorLogin_withKey(ktKeyB, Key, SektorNo);
    if (iErr = 0) then
    Begin
      iErr := ComRdr.ReadBlock(RBuff, BlokNo);
      if (iErr = 0) then
      Begin
        Tutar := RBuff[0]+RBuff[1]*256+RBuff[2]*256*256+RBuff[3]*256*256*256;
        OncekiTutar := RBuff[8]+RBuff[9]*256+RBuff[10]*256*256+RBuff[11]*256*256*256;;
        Dt[0] := RBuff[4];
        Dt[1] := RBuff[5];
        Dt[2] := RBuff[6];
        Dt[3] := RBuff[7];
        ComRdr.DecodeDTSISDateTime(Dt,SonTarih);
      End;
    End
    else //Login olamadým Kartý Formatlamayý deneyeyim
    Begin
      iErr := ComRdr.SelectCard(CardID);
      iErr := ComRdr.SectorLogin_withFKey_Philips(SektorNo);
      if (iErr = 0) then
      Begin
        ComRdr.HexStrToT6Byte(strKeyA, KeyA);
        ComRdr.HexStrToT6Byte(strKeyB, KeyB);
        iErr := ComRdr.ConfigSector('7', KeyA, KeyB);
      End;
    End;
  End;
  result := iErr;
End;

procedure TfrmRDRDemoMain.actBlockReadExecute(Sender: TObject);
Var
  iErr: Integer;
  CardID, HexStr: String;
  RBuff: array [0..15] of byte;
  KeyType: TKeyType;
  Key: array [0..5] of byte;
begin
  FillChar(RBuff, 16, 0);
  if cbbBWRKeyType.ItemIndex = 0 then
    KeyType := ktKeyA
  else
    KeyType := ktKeyB;

  ComRdr.HexStrToT6Byte(edtBWRKey.Text, Key);

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    AddBWRLog('Kart Select oldu.');
    case cbBWRLoginType.ItemIndex of
      0:
        iErr := ComRdr.SectorLogin_withFKey_Philips(edtBWRSectorNo.Value);
      1:
        iErr := ComRdr.SectorLogin_withFKey_Infineon(KeyType,
          edtBWRSectorNo.Value);
      2:
        iErr := ComRdr.SectorLogin_withMasterKey(KeyType, edtBWRSectorNo.Value,
          edtBWRKeyno.Value);
      3:
        iErr := ComRdr.SectorLogin_withKey(KeyType, Key, edtBWRSectorNo.Value);
    end;

    if iErr = 0 then
    Begin
      AddBWRLog('Login oldu.');
      iErr := ComRdr.ReadBlock(RBuff, seBWRBlockNo.Value);
      if iErr = 0 then
      Begin
        AddBWRLog('Blok Okundu.');
        ComRdr.T16ByteToHexStr(RBuff, HexStr);
        edtBWRData.Text := HexStr;
      End
      else
        AddBWRLog('Blok Okunamadý - ' + ComRdr.GetErrMessage(iErr));
    End
    else
      AddBWRLog('Blok Okunamadý. (Login) - ' + ComRdr.GetErrMessage(iErr));
  End
  else
    AddBWRLog('Blok Okunamadý. (SelectCard) - ' + ComRdr.GetErrMessage(iErr));
end;

procedure TfrmRDRDemoMain.actBlockWriteExecute(Sender: TObject);
Var
  iErr: Integer;
  CardID: String;
  WBuff: array [0..15] of byte;
  KeyType: TKeyType;
  Key: array [0..5] of byte;
begin
  FillChar(WBuff, 16, 0);

  if cbbBWRKeyType.ItemIndex = 0 then
    KeyType := ktKeyA
  else
    KeyType := ktKeyB;

  ComRdr.HexStrToT6Byte(edtBWRKey.Text, Key);

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    AddBWRLog('Kart Select oldu.');
    case cbBWRLoginType.ItemIndex of
      0:
        iErr := ComRdr.SectorLogin_withFKey_Philips(edtBWRSectorNo.Value);
      1:
        iErr := ComRdr.SectorLogin_withFKey_Infineon(KeyType,
          edtBWRSectorNo.Value);
      2:
        iErr := ComRdr.SectorLogin_withMasterKey(KeyType, edtBWRSectorNo.Value,
          edtBWRKeyno.Value);
      3:
        iErr := ComRdr.SectorLogin_withKey(KeyType, Key, edtBWRSectorNo.Value);
    end;
    if iErr = 0 then
    Begin
      AddBWRLog('Login oldu.');
      iErr := ComRdr.HexStrToT16Byte(edtBWRData.Text, WBuff);
      if iErr = 0 then
      Begin
        iErr := ComRdr.WriteBlock(WBuff, seBWRBlockNo.Value);
        if iErr = 0 then
        Begin
          AddBWRLog('Blok Yazýldý.');
        End
        else
          AddBWRLog('Blok Yazýlamadý - ' + ComRdr.GetErrMessage(iErr));
      End
      else
        AddBWRLog('Blok bufer Eksik.');
    End
    else
      AddBWRLog('Blok Yazýlamadý. (Login) - ' + ComRdr.GetErrMessage(iErr));
  End
  else
    AddBWRLog('Blok Yazýlamadý. (SelectCard) - ' + ComRdr.GetErrMessage(iErr));

end;

procedure TfrmRDRDemoMain.actConfSectorExecute(Sender: TObject);
Var
  iErr: Integer;
  CardID, FormNo: String;
  KeyType: TKeyType;
  Key, KeyA, KeyB: array [0..5] of byte;
begin
  if cbbBWRKeyType.ItemIndex = 0 then
    KeyType := ktKeyA
  else
    KeyType := ktKeyB;

  ComRdr.HexStrToT6Byte(edtBWRKey.Text, Key);
  ComRdr.HexStrToT6Byte(edtConfCardKeyA.Text, KeyA);
  ComRdr.HexStrToT6Byte(edtConfCardKeyB.Text, KeyB);
  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    AddBWRLog('Kart Select oldu.');
    case cbBWRLoginType.ItemIndex of
      0:
        iErr := ComRdr.SectorLogin_withFKey_Philips(edtBWRSectorNo.Value);
      1:
        iErr := ComRdr.SectorLogin_withFKey_Infineon(KeyType,
          edtBWRSectorNo.Value);
      2:
        iErr := ComRdr.SectorLogin_withMasterKey(KeyType, edtBWRSectorNo.Value,
          edtBWRKeyno.Value);
      3:
        iErr := ComRdr.SectorLogin_withKey(KeyType, Key, edtBWRSectorNo.Value);
    end;
    if iErr = 0 then
    Begin
      AddBWRLog('Login oldu.');
      if cbFormNo.ItemIndex = 8 then
        FormNo := 'F'
      else
        FormNo := IntToStr(cbFormNo.ItemIndex);
      iErr := ComRdr.ConfigSector(FormNo, KeyA, KeyB);
      if iErr = 0 then
      Begin
        AddBWRLog('Konfigürasyon Yapýldý.');
      End
      else
        AddBWRLog('Konfigürasyon Yapýlamadý - ' + ComRdr.GetErrMessage(iErr));
    End
    else
      AddBWRLog('Konfigürasyon Yapýlamadý. (Login) - ' +
        ComRdr.GetErrMessage(iErr));
  End
  else
    AddBWRLog('Konfigürasyon Yapýlamadý. (SelectCard) - ' +
      ComRdr.GetErrMessage(iErr));

end;

procedure TfrmRDRDemoMain.actConnectExecute(Sender: TObject);
begin
  ComRdr.Port := cbComport.Text;
  ComRdr.ArtReadTimeOut := edtReadTimeOut.Value;
  if not ComRdr.Connected then
    ComRdr.Open
  else
    ComRdr.Close;

  if ComRdr.Connected Then
  Begin
    actConnect.Caption := 'Baðlantý Kes';
  End
  else
    actConnect.Caption := 'Baðlan';
end;

procedure TfrmRDRDemoMain.actConnectUpdate(Sender: TObject);
begin
  if ComRdr.Connected Then
    actConnect.Caption := 'Baðlantý Kes'
  else
    actConnect.Caption := 'Baðlan';
end;

procedure TfrmRDRDemoMain.actCopyValueExecute(Sender: TObject);
Var
  iErr: Integer;
  CardID: String;
  KeyType: TKeyType;
  Key: array [0..5] of byte;
begin
  if cbbBWRKeyType.ItemIndex = 0 then
    KeyType := ktKeyA
  else
    KeyType := ktKeyB;

  ComRdr.HexStrToT6Byte(edtBWRKey.Text, Key);

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    AddBWRLog('Kart Select oldu.');
    case cbBWRLoginType.ItemIndex of
      0:
        iErr := ComRdr.SectorLogin_withFKey_Philips(edtBWRSectorNo.Value);
      1:
        iErr := ComRdr.SectorLogin_withFKey_Infineon(KeyType,
          edtBWRSectorNo.Value);
      2:
        iErr := ComRdr.SectorLogin_withMasterKey(KeyType, edtBWRSectorNo.Value,
          edtBWRKeyno.Value);
      3:
        iErr := ComRdr.SectorLogin_withKey(KeyType, Key, edtBWRSectorNo.Value);
    end;
    if iErr = 0 then
    Begin
      AddBWRLog('Login oldu.');
      iErr := ComRdr.CopyValue(edtSrcBlockNo.Value, edtDestBlockNo.Value);
      if iErr = 0 then
      Begin
        AddBWRLog('Deðer Kopyalandý.');
      End
      else
        AddBWRLog('Deðer Kopyalanamadý - ' + ComRdr.GetErrMessage(iErr));
    End
    else
      AddBWRLog('Deðer Kopyalanamadý. (Login) - ' + ComRdr.GetErrMessage(iErr));
  End
  else
    AddBWRLog('Deðer Kopyalanamadý. (SelectCard) - ' +
      ComRdr.GetErrMessage(iErr));

end;

procedure TfrmRDRDemoMain.actDecValueExecute(Sender: TObject);
Var
  iErr: Integer;
  CardID: String;
  KeyType: TKeyType;
  Key: array [0..5] of byte;
begin
  if cbbBWRKeyType.ItemIndex = 0 then
    KeyType := ktKeyA
  else
    KeyType := ktKeyB;

  ComRdr.HexStrToT6Byte(edtBWRKey.Text, Key);

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    AddBWRLog('Kart Select oldu.');
    case cbBWRLoginType.ItemIndex of
      0:
        iErr := ComRdr.SectorLogin_withFKey_Philips(edtBWRSectorNo.Value);
      1:
        iErr := ComRdr.SectorLogin_withFKey_Infineon(KeyType,
          edtBWRSectorNo.Value);
      2:
        iErr := ComRdr.SectorLogin_withMasterKey(KeyType, edtBWRSectorNo.Value,
          edtBWRKeyno.Value);
      3:
        iErr := ComRdr.SectorLogin_withKey(KeyType, Key, edtBWRSectorNo.Value);
    end;
    if iErr = 0 then
    Begin
      AddBWRLog('Login oldu.');
      iErr := ComRdr.DecValue(edtIncDecValue.Value, edtSrcBlockNo.Value);
      if iErr = 0 then
      Begin
        AddBWRLog('Deðer Azaltýldý.');
      End
      else
        AddBWRLog('Deðer Azaltýlamadý - ' + ComRdr.GetErrMessage(iErr));
    End
    else
      AddBWRLog('Deðer Azaltýlamadý. (Login) - ' + ComRdr.GetErrMessage(iErr));
  End
  else
    AddBWRLog('Deðer Azaltýlamadý. (SelectCard) - ' +
      ComRdr.GetErrMessage(iErr));

end;

procedure TfrmRDRDemoMain.actGetSecTorConfExecute(Sender: TObject);
Var
  iErr: Integer;
  CardID, FormNo: String;
  KeyType: TKeyType;
  Key: array [0..5] of byte;
begin
  if cbbBWRKeyType.ItemIndex = 0 then
    KeyType := ktKeyA
  else
    KeyType := ktKeyB;
  ComRdr.HexStrToT6Byte(edtBWRKey.Text, Key);

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    AddBWRLog('Kart Select oldu.');
    case cbBWRLoginType.ItemIndex of
      0:
        iErr := ComRdr.SectorLogin_withFKey_Philips(edtBWRSectorNo.Value);
      1:
        iErr := ComRdr.SectorLogin_withFKey_Infineon(KeyType,
          edtBWRSectorNo.Value);
      2:
        iErr := ComRdr.SectorLogin_withMasterKey(KeyType, edtBWRSectorNo.Value,
          edtBWRKeyno.Value);
      3:
        iErr := ComRdr.SectorLogin_withKey(KeyType, Key, edtBWRSectorNo.Value);
    end;
    if iErr = 0 then
    Begin
      AddBWRLog('Login oldu.');
      iErr := ComRdr.ReadSectorForm(FormNo);
      if iErr = 0 then
      Begin

        if FormNo = 'F' then
          cbFormNo.ItemIndex := 8
        else
          cbFormNo.ItemIndex := StrToInt(FormNo);

        AddBWRLog('Konfigürasyon Bilgisi Getirildi.');
      End
      else
        AddBWRLog('Konfigürasyon Bilgisi Getirilemedi - ' +
          ComRdr.GetErrMessage(iErr));
    End
    else
      AddBWRLog('Konfigürasyon Bilgisi Getirilemedi. (Login) - ' +
        ComRdr.GetErrMessage(iErr));
  End
  else
    AddBWRLog('Konfigürasyon Bilgisi Getirilemedi. (SelectCard) - ' +
      ComRdr.GetErrMessage(iErr));

end;

procedure TfrmRDRDemoMain.actIncValueExecute(Sender: TObject);
Var
  iErr: Integer;
  CardID: String;
  KeyType: TKeyType;
  Key: array [0..5] of byte;

begin
  if cbbBWRKeyType.ItemIndex = 0 then
    KeyType := ktKeyA
  else
    KeyType := ktKeyB;

  ComRdr.HexStrToT6Byte(edtBWRKey.Text, Key);

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    AddBWRLog('Kart Select oldu.');
    case cbBWRLoginType.ItemIndex of
      0:
        iErr := ComRdr.SectorLogin_withFKey_Philips(edtBWRSectorNo.Value);
      1:
        iErr := ComRdr.SectorLogin_withFKey_Infineon(KeyType,
          edtBWRSectorNo.Value);
      2:
        iErr := ComRdr.SectorLogin_withMasterKey(KeyType, edtBWRSectorNo.Value,
          edtBWRKeyno.Value);
      3:
        iErr := ComRdr.SectorLogin_withKey(KeyType, Key, edtBWRSectorNo.Value);
    end;
    if iErr = 0 then
    Begin
      AddBWRLog('Login oldu.');
      iErr := ComRdr.IncValue(edtIncDecValue.Value, edtSrcBlockNo.Value);
      if iErr = 0 then
      Begin
        AddBWRLog('Deðer Artýrýldý.');
      End
      else
        AddBWRLog('Deðer Artýrýlamadý - ' + ComRdr.GetErrMessage(iErr));
    End
    else
      AddBWRLog('Deðer Artýrýlamada. (Login) - ' + ComRdr.GetErrMessage(iErr));
  End
  else
    AddBWRLog('Deðer Artýrýlamadý. (SelectCard) - ' +
      ComRdr.GetErrMessage(iErr));

end;

procedure TfrmRDRDemoMain.actReadValueExecute(Sender: TObject);
Var
  iErr: Integer;
  CardID: String;
  KeyType: TKeyType;
  Key: array [0..5] of byte;
  rValue: Cardinal;
begin

  if cbbBWRKeyType.ItemIndex = 0 then
    KeyType := ktKeyA
  else
    KeyType := ktKeyB;

  ComRdr.HexStrToT6Byte(edtBWRKey.Text, Key);

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    AddBWRLog('Kart Select oldu.');
    case cbBWRLoginType.ItemIndex of
      0:
        iErr := ComRdr.SectorLogin_withFKey_Philips(edtBWRSectorNo.Value);
      1:
        iErr := ComRdr.SectorLogin_withFKey_Infineon(KeyType,
          edtBWRSectorNo.Value);
      2:
        iErr := ComRdr.SectorLogin_withMasterKey(KeyType, edtBWRSectorNo.Value,
          edtBWRKeyno.Value);
      3:
        iErr := ComRdr.SectorLogin_withKey(KeyType, Key, edtBWRSectorNo.Value);
    end;

    if iErr = 0 then
    Begin
      AddBWRLog('Login oldu.');
      iErr := ComRdr.ReadValue(rValue, edtSrcBlockNo.Value);
      if iErr = 0 then
      Begin
        AddBWRLog('Deðer Okundu.');
        edtValue.Value := rValue;
      End
      else
        AddBWRLog('Deðer Okunamadý - ' + ComRdr.GetErrMessage(iErr));
    End
    else
      AddBWRLog('Deðer Okunamadý. (Login) - ' + ComRdr.GetErrMessage(iErr));
  End
  else
    AddBWRLog('Deðer Okunamadý. (SelectCard) - ' + ComRdr.GetErrMessage(iErr));

end;

procedure TfrmRDRDemoMain.actSetIOExecute(Sender: TObject);
begin
  if edtIOType.ItemIndex = 0 then
    ComRdr.SetIOGreenLed(edtIODuration.Value, cbIOBlink.Checked)
  else if edtIOType.ItemIndex = 1 then
    ComRdr.SetIORedLed(edtIODuration.Value, cbIOBlink.Checked)
  else if edtIOType.ItemIndex = 2 then
    ComRdr.SetIOBuzzer(edtIODuration.Value, cbIOBlink.Checked);
end;

procedure TfrmRDRDemoMain.actSetMasterKeyExecute(Sender: TObject);
Var
  iErr: Integer;
  Key: array [0..5] of byte;
begin
  ComRdr.HexStrToT6Byte(edtMasterKey.Text, Key);
  iErr := ComRdr.WriteMasterKey(edtMastKeyNo.Value, Key);
  if (iErr = 0) Then
  Begin
    AddTermParamsLog('Key Tablosu Gönderildi.');
  End
  else
    AddTermParamsLog('Key Tablosu Gönderilemedi.(' + ComRdr.GetErrMessage
      (iErr) + ')');

end;

procedure TfrmRDRDemoMain.actTermGetParamsExecute(Sender: TObject);
Var
  iErr: Integer;
  DeviceParams: TDeviceParams;
begin
  iErr := ComRdr.ReadTerminalSetup(DeviceParams);
  if (iErr = 0) Then
  Begin
    AddTermParamsLog('Terminal Ayarlarý Getirildi.');
    edtTermNo.Value := DeviceParams.u2DevNum;
    edtDefBuzzerTime.Value := DeviceParams.uBuzzBeepTime;
    case DeviceParams.rCardReadMode of
      crmStandardMode:
        cbCardType.ItemIndex := 0;
      crmSendCardID:
        cbCardType.ItemIndex := 1;
      crmSendBlock:
        cbCardType.ItemIndex := 2;
      crmSendSector:
        cbCardType.ItemIndex := 3;
      crmSendCardID_ASCII:
        cbCardType.ItemIndex := 4;
      crmSendBlock_ASCII:
        cbCardType.ItemIndex := 5;
      crmUnknown:
        cbCardType.ItemIndex := 6;
    end;
    if DeviceParams.rMasterKeyType = ktKeyA then
      cbDefKeyType.ItemIndex := 0
    else
      cbDefKeyType.ItemIndex := 1;
    edtDefKeyNo.Value := DeviceParams.uMasterKeynum;
    edtDefSectorNo.Value := DeviceParams.uDfltSectorNum;
    edtDefBlockNo.Value := DeviceParams.uDfltBlockNum;
    CurrentDevParams := DeviceParams;
  End
  else
    AddTermParamsLog('Terminal Ayarlarý Getirilemedi.(' +
      ComRdr.GetErrMessage(iErr) + ')');
end;

procedure TfrmRDRDemoMain.actTermSetParamsExecute(Sender: TObject);
Var
  iErr: Integer;
  DeviceParams: TDeviceParams;
begin
  DeviceParams.u2DevNum := edtTermNo.Value;
  DeviceParams.uBuzzBeepTime := edtDefBuzzerTime.Value;
  case cbCardType.ItemIndex of
    0:
      DeviceParams.rCardReadMode := crmStandardMode;
    1:
      DeviceParams.rCardReadMode := crmSendCardID;
    2:
      DeviceParams.rCardReadMode := crmSendBlock;
    3:
      DeviceParams.rCardReadMode := crmSendSector;
    4:
      DeviceParams.rCardReadMode := crmSendCardID_ASCII;
    5:
      DeviceParams.rCardReadMode := crmSendBlock_ASCII;
    6:
      DeviceParams.rCardReadMode := crmUnknown;
  end;
  if (cbDefKeyType.ItemIndex = 0) then
    DeviceParams.rMasterKeyType := ktKeyA
  else
    DeviceParams.rMasterKeyType := ktKeyB;
  DeviceParams.uMasterKeynum := edtDefKeyNo.Value;

  DeviceParams.uDfltSectorNum := edtDefSectorNo.Value;
  DeviceParams.uDfltBlockNum := edtDefBlockNo.Value;
  iErr := ComRdr.WriteTerminalSetup(DeviceParams);
  if (iErr = 0) Then
  Begin
    AddTermParamsLog('Terminal Ayarlarý Gönderildi.');
  End
  else
    AddTermParamsLog('Terminal Ayarlarý Gönderilemedi.(' +
      ComRdr.GetErrMessage(iErr) + ')');

end;

procedure TfrmRDRDemoMain.actTermSetParamsUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := ComRdr.Connected;
end;

procedure TfrmRDRDemoMain.actWriteValueExecute(Sender: TObject);
Var
  iErr: Integer;
  CardID: String;
  KeyType: TKeyType;
  Key: array [0..5] of byte;
begin
  if cbbBWRKeyType.ItemIndex = 0 then
    KeyType := ktKeyA
  else
    KeyType := ktKeyB;

  ComRdr.HexStrToT6Byte(edtBWRKey.Text, Key);

  iErr := ComRdr.SelectCard(CardID);
  if iErr = 0 then
  Begin
    AddBWRLog('Kart Select oldu.');
    case cbBWRLoginType.ItemIndex of
      0:
        iErr := ComRdr.SectorLogin_withFKey_Philips(edtBWRSectorNo.Value);
      1:
        iErr := ComRdr.SectorLogin_withFKey_Infineon(KeyType,
          edtBWRSectorNo.Value);
      2:
        iErr := ComRdr.SectorLogin_withMasterKey(KeyType, edtBWRSectorNo.Value,
          edtBWRKeyno.Value);
      3:
        iErr := ComRdr.SectorLogin_withKey(KeyType, Key, edtBWRSectorNo.Value);
    end;
    if iErr = 0 then
    Begin
      AddBWRLog('Login oldu.');
      iErr := ComRdr.WriteValue(edtValue.Value, edtSrcBlockNo.Value);
      if iErr = 0 then
      Begin
        AddBWRLog('Deðer Yazýldý.');
      End
      else
        AddBWRLog('Deðer Yazýlamadý - ' + ComRdr.GetErrMessage(iErr));
    End
    else
      AddBWRLog('Deðer Yazýlamada. (Login) - ' + ComRdr.GetErrMessage(iErr));
  End
  else
    AddBWRLog('Deðer Yazýlamadý. (SelectCard) - ' + ComRdr.GetErrMessage(iErr));

end;

procedure TfrmRDRDemoMain.cbCardTypeChange(Sender: TObject);
begin
  grbDefKeyParam.Visible := (cbCardType.ItemIndex in [2, 3, 5]);
  lblDefBlockNo.Enabled := not(cbCardType.ItemIndex = 3);
  edtDefBlockNo.Enabled := not(cbCardType.ItemIndex = 3);
end;

procedure TfrmRDRDemoMain.ComRdrRxCardID(Sender: TObject; const TermNo: Integer;
  const CardID: string);
  Var
  Tutar,OncekiTutar:Integer;
  SonTarih:TDatetime;
begin
    AddTermParamsLog('Kart ID - ' + CardID);

    LoginAndRead(edOrnKeyA.Text,edOrnKeyB.Text,edtOrnSector.Value,edtOrnBlok.Value,
    Tutar,OncekiTutar,SonTarih);



  { Ýleride Yapýlacak
    if pgcMain.TabIndex=0 then
    Begin
    case CurrentDevParams.rCardReadMode of
    crmStandardMode :
    Begin

    End;
    crmSendCardID :
    Begin

    End;
    crmSendBlock :
    Begin

    End;
    crmSendSector :
    Begin

    End;
    crmSendCardID_ASCII :
    Begin

    End;
    crmSendBlock_ASCII :
    Begin

    End;
    crmUnknown :
    Begin

    End;
    end;

    End;
  }
end;

procedure TfrmRDRDemoMain.ComRdrRxChar(Sender: TObject; Count: Integer);
var
  str:string;
begin
  ComRdr.ReadStr(str,Count);
  ShowMessage(str);
end;

procedure TfrmRDRDemoMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    ComRdr.Close;
  except
  end;
end;

procedure TfrmRDRDemoMain.FormCreate(Sender: TObject);
Var
 i:Integer;
begin
   ComRdr := TPerioUsbReader.Create(Self);
   ComRdr.BaudRate := br19200;
   ComRdr.OnRxCardID := ComRdrRxCardID;

  try
    ComRdr.Close;
  except
  end;
//  cbComport.
  if cbComport.ItemIndex > 0 Then
    cbComport.ItemIndex := 0;
  lblBlockKeyNo.Visible := False;
  lblBlockKeyType.Visible := False;
  cbbBWRKeyType.Visible := False;
  edtBWRKey.Visible := False;
  edtBWRKeyno.Visible := False;
  pcBlockValue.TabIndex := 0;
  pgcMain.TabIndex := 0;


  StringGrid1.RowCount:=129;
  for I := 0 to 128 do
  Begin
    if I>0 then
    Begin
      StringGrid1.Rows[i].Append(IntToStr(i-1));
      StringGrid1.Cells[1,i]:='0';
    End;
  End;

end;

procedure TfrmRDRDemoMain.FormDestroy(Sender: TObject);
begin
   if Assigned(ComRdr) then ComRdr.Free;   
end;

procedure TfrmRDRDemoMain.LoguSil1Click(Sender: TObject);
begin
  if pgcMain.TabIndex = 0 then
  Begin
    LogTermParams.Lines.Clear;
  End
  else
  Begin
    LogBWR.Lines.Clear;
  End;

end;

procedure TfrmRDRDemoMain.pcBlockValueChange(Sender: TObject);
begin
  lblwrBlockNo.Visible := (pcBlockValue.TabIndex = 0);
  seBWRBlockNo.Visible := (pcBlockValue.TabIndex = 0);
end;

procedure TfrmRDRDemoMain.pgcMainChange(Sender: TObject);
begin
  if pgcMain.TabIndex = 2 then
  Begin
    grbBlockLoginType.Parent := pnlM4;
    LogBWR.Parent := pnlM4;
    LogBWR.Lines.Clear;
    lblwrBlockNo.Visible := False;
    seBWRBlockNo.Visible := False;
  End
  else
  Begin
    grbBlockLoginType.Parent := pnlM2;
    LogBWR.Parent := pnlM2;
    LogBWR.Lines.Clear;
    lblwrBlockNo.Visible := True;
    seBWRBlockNo.Visible := True;
  End;
end;

procedure TfrmRDRDemoMain.cbBWRLoginTypeChange(Sender: TObject);
begin
  if cbBWRLoginType.ItemIndex = 0 Then
  Begin
    lblBlockKeyNo.Visible := False;
    lblBlockKeyType.Visible := False;
    cbbBWRKeyType.Visible := False;
    edtBWRKey.Visible := False;
    edtBWRKeyno.Visible := False;
  End
  else if cbBWRLoginType.ItemIndex = 1 then
  Begin
    lblBlockKeyType.Visible := True;
    cbbBWRKeyType.Visible := True;
    lblBlockKeyNo.Visible := False;
    edtBWRKey.Visible := False;
    edtBWRKeyno.Visible := False;
  End
  else if cbBWRLoginType.ItemIndex = 2 then
  Begin
    lblBlockKeyType.Visible := True;
    cbbBWRKeyType.Visible := True;
    lblBlockKeyNo.Visible := True;
    edtBWRKeyno.Visible := True;
    cbbBWRKeyType.Visible := True;
    edtBWRKey.Visible := False;
  End
  else if cbBWRLoginType.ItemIndex = 3 then
  Begin
    lblBlockKeyType.Visible := True;
    cbbBWRKeyType.Visible := True;
    lblBlockKeyNo.Visible := False;
    edtBWRKeyno.Visible := False;
    cbbBWRKeyType.Visible := True;
    edtBWRKey.Visible := True;
  End;
end;

end.
