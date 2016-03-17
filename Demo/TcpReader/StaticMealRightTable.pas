unit StaticMealRightTable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.ExtCtrls,PerioDevice;

type
  TfrmStaticMealRightTable = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    btnGetMealRightTable: TButton;
    btnSetMealRightTable: TButton;
    edtTableNo: TSpinEdit;
    mmLog: TMemo;
    grdBellTable: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnGetMealRightTableClick(Sender: TObject);
    procedure btnSetMealRightTableClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLog(str: String; SM: Boolean = False);
  end;

var
  frmStaticMealRightTable: TfrmStaticMealRightTable;

implementation

{$R *.dfm}

uses Main;

procedure TfrmStaticMealRightTable.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmStaticMealRightTable.btnGetMealRightTableClick(Sender: TObject);
Var
  Table: TDailyMealRight;
  k,i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetStaticMealRightList(edtTableNo.Value, Table) then
    Begin
        for I := 0 to 7 do
          grdBellTable.Cells[i+1,  1] := IntToStr(Table.MealRigths[i]);
        grdBellTable.Cells[9,  1] := IntToStr(Table.TotalDayRight);
      AddLog('Yemek Hak Tablosu getirildi.');
    End
    else
      AddLog('Yemek Hak Tablosu getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmStaticMealRightTable.btnSetMealRightTableClick(Sender: TObject);
Var
  Table: TDailyMealRight;
  k,i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
      for I := 0 to 7 do
        Table.MealRigths[i] := StrToInt(grdBellTable.Cells[i+1,  1]) ;
      Table.TotalDayRight := StrtoInt(grdBellTable.Cells[9,1]);

    if frmMain.Rdr.SetStaticMealRightList(edtTableNo.Value, Table) then
    Begin
      AddLog('Yemek Hak Tablosu gönderildi.');
    End
    else
      AddLog('Yemek Hak Tablosu gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmStaticMealRightTable.FormCreate(Sender: TObject);
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

end;

end.
