unit MealTable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,PerioDevice;

type
  TfrmMealTable = class(TForm)
    Panel3: TPanel;
    btnGetMealTable: TButton;
    btnSetMealTable: TButton;
    cbDays: TComboBox;
    grdBellTable: TStringGrid;
    mmLog: TMemo;
    procedure btnGetMealTableClick(Sender: TObject);
    procedure cbDaysChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdBellTableExit(Sender: TObject);
    procedure btnSetMealTableClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    gMealTable: TMealTable;

    procedure AddLog(str: String; SM: Boolean = False);
    procedure RecordToGrid(Day:Integer;Var MealTable: TMealTable);
    procedure GridToRecord(Day:Integer;Var MealTable: TMealTable);

  end;

var
  frmMealTable: TfrmMealTable;

implementation

{$R *.dfm}

uses Main;

procedure TfrmMealTable.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmMealTable.RecordToGrid(Day:Integer;Var MealTable: TMealTable);
Var
  i: Integer;
Begin
  for I := 0 to 7 do
  Begin
    grdBellTable.Cells[1, i + 1] := i.ToString();
    grdBellTable.Cells[2, i + 1] :=
       Copy(TimeToStr(MealTable.Days[Day].list[i].StartTime), 1, 5);
    grdBellTable.Cells[3, i + 1] :=
       IntToStr(MealTable.Days[Day].list[i].StartDBY);
    grdBellTable.Cells[4, i + 1] :=
       Copy(TimeToStr(MealTable.Days[Day].list[i].EndTime), 1, 5);
    grdBellTable.Cells[5, i + 1] :=
       IntToStr(MealTable.Days[Day].list[i].EndDBY);
    if MealTable.Days[Day].list[i].Active then
       grdBellTable.Cells[6, i + 1] := '1'
    else
       grdBellTable.Cells[6, i + 1] := '0';

  End;
End;

procedure TfrmMealTable.GridToRecord(Day:Integer;Var MealTable: TMealTable);
Var
  i: Integer;
Begin
  for I := 0 to 7 do
  Begin
    MealTable.Days[Day].list[i].StartTime :=
      StrToTime(grdBellTable.Cells[2, i + 1] + ':00');
    MealTable.Days[Day].list[i].StartDBY :=
      StrToInt(grdBellTable.Cells[3, i + 1] );
    MealTable.Days[Day].list[i].EndTime :=
      StrToTime(grdBellTable.Cells[4, i + 1] + ':00');
    MealTable.Days[Day].list[i].EndDBY :=
      StrToInt(grdBellTable.Cells[5, i + 1] );
    If StrToInt(grdBellTable.Cells[6, i + 1] )= 0 Then
      MealTable.Days[Day].list[i].Active := False
    else
      MealTable.Days[Day].list[i].Active := True;

  End;
End;
procedure TfrmMealTable.btnGetMealTableClick(Sender: TObject);
//Var
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetMealTable(gMealTable) then
    Begin
      RecordToGrid(cbDays.ItemIndex,gMealTable);
      AddLog('Yemek Tablosu getirildi.');
    End
    else
      AddLog('Yemek Tablosu getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMealTable.btnSetMealTableClick(Sender: TObject);
begin
 if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.SetMealTable(gMealTable) then
      AddLog('Yemek Tablosu gönderildi.')
    else
      AddLog('Yemek Tablosu gönderilmedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMealTable.cbDaysChange(Sender: TObject);
begin
  RecordToGrid(cbDays.ItemIndex,gMealTable);
end;

procedure TfrmMealTable.FormCreate(Sender: TObject);
begin
 grdBellTable.Cells[1, 0] := 'Sýra ';
 grdBellTable.Cells[2, 0] := 'Baþlangýç Z.';
 grdBellTable.Cells[3, 0] := 'B. DBY';
 grdBellTable.Cells[4, 0] := 'Bitiþ Z.';
 grdBellTable.Cells[5, 0] := 'B. DBY';
 grdBellTable.Cells[6, 0] := 'Aktif';

end;

procedure TfrmMealTable.grdBellTableExit(Sender: TObject);
begin
  GridToRecord(cbDays.ItemIndex,gMealTable);
end;

end.
