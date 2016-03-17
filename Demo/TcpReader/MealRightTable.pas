unit MealRightTable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.Grids,
  PerioDevice;

type
  TfrmMealRightTable = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    btnGetMealRightTable: TButton;
    btnSetMealRightTable: TButton;
    edtTableNo: TSpinEdit;
    grdBellTable: TStringGrid;
    mmLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnGetMealRightTableClick(Sender: TObject);
    procedure btnSetMealRightTableClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddLog(str: String; SM: Boolean = False);
  end;

var
  frmMealRightTable: TfrmMealRightTable;

implementation

{$R *.dfm}

uses Main;

procedure TfrmMealRightTable.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmMealRightTable.btnGetMealRightTableClick(Sender: TObject);
Var
  Table: TWeaklyMealRight;
  k,i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetMealRigthTable(edtTableNo.Value, Table) then
    Begin
      for  k := 0 to 7 do
      Begin
        for I := 0 to 7 do
          grdBellTable.Cells[i+1, k + 1] := IntToStr(Table.Days[k].MealRigths[i]);
        grdBellTable.Cells[9, k + 1] := IntToStr(Table.Days[k].TotalDayRight);
      End;
      for  k := 0 to 7 do
        grdBellTable.Cells[k+1,9] := IntToStr(Table.TotalWeeklyMealRight[k]);
      for  k := 0 to 7 do
        grdBellTable.Cells[k+1,10] := IntToStr(Table.TotalMonthlyMealRight[k]);
      AddLog('Yemek Hak Tablosu getirildi.');
    End
    else
      AddLog('Yemek Hak Tablosu getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMealRightTable.btnSetMealRightTableClick(Sender: TObject);
Var
  Table: TWeaklyMealRight;
  k,i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    for  k := 0 to 7 do
    Begin
      for I := 0 to 7 do
        Table.Days[k].MealRigths[i] := StrToInt(grdBellTable.Cells[i+1, k + 1]) ;
      Table.Days[k].TotalDayRight := StrtoInt(grdBellTable.Cells[9, k + 1]);
    End;
    for  k := 0 to 7 do
      Table.TotalWeeklyMealRight[k] := StrToInt(grdBellTable.Cells[k+1,9]);
    for  k := 0 to 7 do
      Table.TotalMonthlyMealRight[k] := StrToInt(grdBellTable.Cells[k+1,10]);

    if frmMain.Rdr.SetMealRigthTable(edtTableNo.Value, Table) then
    Begin
      AddLog('Yemek Hak Tablosu gönderildi.');
    End
    else
      AddLog('Yemek Hak Tablosu gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMealRightTable.FormCreate(Sender: TObject);
begin

  grdBellTable.Cols[1].Text := ' 0.ÖH';
  grdBellTable.Cols[2].Text := ' 1.ÖH';
  grdBellTable.Cols[3].Text := ' 2.ÖH';
  grdBellTable.Cols[4].Text := ' 3.ÖH';
  grdBellTable.Cols[5].Text := ' 4.ÖH';
  grdBellTable.Cols[6].Text := ' 5.ÖH';
  grdBellTable.Cols[7].Text := ' 6.ÖH';
  grdBellTable.Cols[8].Text := ' 7.ÖH';
  grdBellTable.Cols[9].Text := ' T.ÖH';

  grdBellTable.Rows[1].Text := 'Pazartesi';
  grdBellTable.Rows[2].Text := 'Salý';
  grdBellTable.Rows[3].Text := 'Çarþamba';
  grdBellTable.Rows[4].Text := 'Perþembe';
  grdBellTable.Rows[5].Text := 'Cuma';
  grdBellTable.Rows[6].Text := 'Cumartesi';
  grdBellTable.Rows[7].Text := 'Pazar';
  grdBellTable.Rows[8].Text := 'Tatil';
  grdBellTable.Rows[9].Text := 'Hafta Ö.T.';
  grdBellTable.Rows[10].Text := 'Ay Ö.T.';
end;

end.
