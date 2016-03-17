unit OutOfServiceTable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls,
  PerioDevice;

type
  TfrmOutOfServiceTable = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    btnGetOutOfServiceTable: TButton;
    btnSetOutOfServiceTable: TButton;
    btnGetHolidayList: TButton;
    btnSetHolidayList: TButton;
    grdOutOfService: TStringGrid;
    Panel7: TPanel;
    mmLog: TMemo;
    grdHolidayList: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnGetOutOfServiceTableClick(Sender: TObject);
    procedure btnGetHolidayListClick(Sender: TObject);
    procedure btnSetHolidayListClick(Sender: TObject);
    procedure btnSetOutOfServiceTableClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLog(str: String; SM: Boolean = False);

  end;

var
  frmOutOfServiceTable: TfrmOutOfServiceTable;

implementation

{$R *.dfm}

uses Main;

procedure TfrmOutOfServiceTable.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
//  frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmOutOfServiceTable.btnGetHolidayListClick(Sender: TObject);
Var
  Holidays: THolidays;
  i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetOutOfServiceHolidayList(Holidays) then
    Begin
      for I := 0 to 29 do
      Begin
        grdHolidayList.Cells[1, i + 1] := DateToStr(Holidays.List[i].Date);
      End;
      AddLog('Tatil Listesi getirildi.');
    End
    else
      AddLog('Tatil Listesi getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmOutOfServiceTable.btnGetOutOfServiceTableClick(Sender: TObject);
Var
  OSTable: TOSTable;
  i, j: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetOutOfServiceTable(OSTable) then
    Begin
      for I := 0 to 7 do
        for j := 0 to 3 do
        Begin
          grdOutOfService.Cells[j * 2 + 1, i + 1] :=
            Copy(TimeToStr(OSTable.Day[i].part[j].StartTime), 1, 5);
          grdOutOfService.Cells[j * 2 + 2, i + 1] :=
            Copy(TimeToStr(OSTable.Day[i].part[j].EndTime), 1, 5);
        End;
      AddLog('Hizmet Dýþý Listesi getirildi.');
    End
    else
      AddLog('Hizmet Dýþý Listesi getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmOutOfServiceTable.btnSetHolidayListClick(Sender: TObject);
Var
  Holidays: THolidays;
  i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    for I := 0 to 29 do
    Begin
      Holidays.List[i].Date := StrToDate(grdHolidayList.Cells[1, i + 1]);
    End;
    if frmMain.Rdr.SetOutOfServiceHolidayList(Holidays) then
      AddLog('Tatil Listesi gönderildi.')
    else
      AddLog('Tatil Listesi gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmOutOfServiceTable.btnSetOutOfServiceTableClick(Sender: TObject);
Var
  OSTable: TOSTable;
  i, j: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    for I := 0 to 7 do
      for j := 0 to 3 do
      Begin
        OSTable.Day[i].part[j].StartTime :=
          StrToTime(grdOutOfService.Cells[j * 2 + 1, i + 1] + ':00');
        OSTable.Day[i].part[j].EndTime :=
          StrToTime(grdOutOfService.Cells[j * 2 + 2, i + 1] + ':00');
      End;
    if frmMain.Rdr.SetOutOfServiceTable(OSTable) then
      AddLog('Hizmet Dýþý Listesi gönderildi.')
    else
      AddLog('Hizmet Dýþý Listesi gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmOutOfServiceTable.FormCreate(Sender: TObject);
Var
  i, j: Integer;
begin
  for I := 0 to 3 do
  Begin
    grdOutOfService.Cols[i * 2 + 1].Text := 'Baþ.' + IntToStr(i + 1);
    grdOutOfService.Cols[i * 2 + 2].Text := 'Bit.' + IntToStr(i + 1);
  End;
  for I := 1 to 8 do
    grdOutOfService.Rows[i].Text := IntToStr(i-1);

  for I := 1 to 8 do
    for j := 1 to 8 do
    Begin
      grdOutOfService.Cells[i, j] := '00:00';
    End;

  grdHolidayList.Cols[1].Text := ' Tarih ';
  grdHolidayList.Cols[2].Text := 'T. No';

  for j := 1 to 30 do
  Begin
    grdHolidayList.Rows[j].Text := IntToStr(j);
    grdHolidayList.Cells[1, j] := '01.01.2000';
    grdHolidayList.Cells[2, j] := '0';
  End;

end;

procedure TfrmOutOfServiceTable.FormShow(Sender: TObject);
begin
  btnGetOutOfServiceTable.Click;
  btnGetHolidayList.Click;
end;

end.
