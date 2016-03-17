unit BellTable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,
  PerioDevice,
  Vcl.Samples.Spin;

type
  TfrmBellTable = class(TForm)
    Panel3: TPanel;
    btnGetBellTable: TButton;
    btnSetBellTable: TButton;
    grdBellTable: TStringGrid;
    mmLog: TMemo;
    edtDayNo: TSpinEdit;
    Label1: TLabel;
    procedure btnGetBellTableClick(Sender: TObject);
    procedure btnSetBellTableClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLog(str: String; SM: Boolean = False);
  end;

var
  frmBellTable: TfrmBellTable;

implementation

{$R *.dfm}

uses Main;

procedure TfrmBellTable.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmBellTable.btnGetBellTableClick(Sender: TObject);
Var
  BellTable: TBellTable;
  i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetBellTable(edtDayNo.Value, BellTable) then
    Begin
      for I := 0 to 23 do
      Begin
        grdBellTable.Cells[1, i + 1] :=
          Copy(TimeToStr(BellTable.List[i].StartTime), 1, 5);
        grdBellTable.Cells[2, i + 1] := IntToStr(BellTable.List[i].Duration);
      End;
      AddLog('Zil Tablosu getirildi.');
    End
    else
      AddLog('Zil Tablosu getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmBellTable.btnSetBellTableClick(Sender: TObject);
Var
  BellTable: TBellTable;
  i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    for I := 0 to 23 do
    Begin
      BellTable.List[i].StartTime :=
        StrToTime(grdBellTable.Cells[1, i + 1] + ':00');;
      BellTable.List[i].Duration := StrToInt(grdBellTable.Cells[2, i + 1]);
    End;

    if frmMain.Rdr.SetBellTable(edtDayNo.Value, BellTable) then
      AddLog('Zil Tablosu gönderildi.')
    else
      AddLog('Zil Tablosu gönderilmedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmBellTable.FormCreate(Sender: TObject);
Var
  i: Integer;
begin
  grdBellTable.Cols[1].Text := ' Saat ';
  grdBellTable.Cols[2].Text := ' Süre ';
  for i := 1 to 24 do
  Begin
    grdBellTable.Rows[i].Text := IntToStr(i);
    grdBellTable.Cells[1, i] := '00:00';
    grdBellTable.Cells[2, i] := '0';
  End;

end;

procedure TfrmBellTable.FormShow(Sender: TObject);
begin
  btnGetBellTable.Click;
end;

end.
