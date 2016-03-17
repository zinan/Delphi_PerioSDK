unit WeekDays;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,
  PerioDevice;

type
  TfrmWeekDays = class(TForm)
    Panel3: TPanel;
    btnGetTcTable: TButton;
    btnSetTcTable: TButton;
    grdTCTable: TStringGrid;
    mmLog: TMemo;
    procedure btnGetTcTableClick(Sender: TObject);
    procedure btnSetTcTableClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddLog(str: String; SM: Boolean = False);
    { Public declarations }
  end;

var
  frmWeekDays: TfrmWeekDays;

implementation

{$R *.dfm}

uses Main;

procedure TfrmWeekDays.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmWeekDays.btnGetTcTableClick(Sender: TObject);
Var
  WeekDays: TWeekDays;
  i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetWeekDayNames(WeekDays) then
    Begin
      for I := 0 to 6 do
        grdTCTable.Cells[1, i + 1] := WeekDays.Names[i];
      AddLog('Günler Tablosu getirildi.');
    End
    else
      AddLog('Günler Tablosu getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmWeekDays.btnSetTcTableClick(Sender: TObject);
Var
  WeekDays: TWeekDays;
  i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    for I := 0 to 6 do
      WeekDays.Names[i] := grdTCTable.Cells[1, i + 1];
    if frmMain.Rdr.SetWeekDayNames(WeekDays) Then
      AddLog('Günler Tablosu gönderildi.')
    else
      AddLog('Günler Tablosu gönderilmedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmWeekDays.FormShow(Sender: TObject);
begin
  btnGetTcTable.Click;
end;

end.
