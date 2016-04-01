unit TimeConstraintTable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.Samples.Spin, PerioDevice;

type
  TfrmTimeConstraintTable = class(TForm)
    Panel3: TPanel;
    btnGetTcTable: TButton;
    btnSetTcTable: TButton;
    grdTCTable: TStringGrid;
    mmLog: TMemo;
    edtTableNo: TSpinEdit;
    procedure btnSetTcTableClick(Sender: TObject);
    procedure btnGetTcTableClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddLog(str: String; SM: Boolean = False);
  end;

var
  frmTimeConstraintTable: TfrmTimeConstraintTable;

implementation

{$R *.dfm}

uses Main, BellTable;

procedure TfrmTimeConstraintTable.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmTimeConstraintTable.btnGetTcTableClick(Sender: TObject);
Var
  TACList: TTACList;
  i,j: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetTimeConstraintTables(edtTableNo.Value, TACList) then
    Begin
      for I := 0 to 7 do
      Begin
        for j := 0 to 7 do
        Begin
          grdTCTable.Cells[(j*2)+1, i + 1] :=copy(TimeToStr(TACList.Day[i].Part[j].StartTime), 1, 5);
          grdTCTable.Cells[(j*2)+2, i + 1] :=copy(TimeToStr(TACList.Day[i].Part[j].EndTime), 1, 5);
        End;
      End;
      AddLog('Zaman Kýsýt Tablosu getirildi.');
    End
    else
      AddLog('Zaman Kýsýt Tablosu getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmTimeConstraintTable.btnSetTcTableClick(Sender: TObject);
Var
  TACList: TTACList;
  i,j: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    for I := 0 to 7 do
    Begin
      for j := 0 to 7 do
      Begin
        TACList.Day[i].Part[j].StartTime
          := StrToTime(grdTCTable.Cells[(j*2)+1, i + 1] + ':00');

        TACList.Day[i].Part[j].EndTime
          := StrToTime(grdTCTable.Cells[(j*2)+2, i + 1] + ':00');

      End;

    End;
    if frmMain.Rdr.SetTimeConstraintTables(edtTableNo.Value, TACList) then
      AddLog('Zaman Kýsýt Tablosu gönderildi.')
    else
      AddLog('Zaman Kýsýt Tablosu gönderilmedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmTimeConstraintTable.FormCreate(Sender: TObject);
Var
  i,j: Integer;
begin

  for i := 0 to 7 do
  Begin
    grdTCTable.Cols[(i*2)+1].Text := 'Baþlangýç '+IntToStr(i+1);
    grdTCTable.Cols[(i*2)+2].Text := 'Bitiþ'+IntToStr(i+1);
  End;

  for i := 0 to 7 do
  Begin
    grdTCTable.Rows[i+1].Text := IntToStr(i+1);
    for j := 0 to 7 do
    Begin
      grdTCTable.Cells[(j*2)+1, i+1] := '00:00';
      grdTCTable.Cells[(j*2)+2, i+1] := '00:00';
      //grdTCTable.Cells[(j*2)+1, i+1] := Format('%.2d', [j+1])+':'+Format('%.2d', [i+1]);
      //grdTCTable.Cells[(j*2)+2, i+1] := Format('%.2d', [j+1])+':'+Format('%.2d', [i+1]);
    End;
  End;
end;

procedure TfrmTimeConstraintTable.FormShow(Sender: TObject);
begin
  //btnGetTcTable.Click;
end;

end.
