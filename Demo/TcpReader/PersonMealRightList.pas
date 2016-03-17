unit PersonMealRightList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  Vcl.Samples.Spin, Vcl.ExtCtrls,PerioDevice;

type
  TfrmPersonMealRightList = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    btnGetMealRightTable: TButton;
    btnSetMealRightTable: TButton;
    edtTableNo: TSpinEdit;
    mmLog: TMemo;
    grdBellTable: TStringGrid;
    Label2: TLabel;
    edtCardID: TEdit;
    Label3: TLabel;
    procedure btnSetMealRightTableClick(Sender: TObject);
    procedure btnGetMealRightTableClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddLog(str: String; SM: Boolean = False);
  end;

var
  frmPersonMealRightList: TfrmPersonMealRightList;

implementation

{$R *.dfm}

uses Main;

procedure TfrmPersonMealRightList.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmPersonMealRightList.btnGetMealRightTableClick(Sender: TObject);
Var
  Table: TDailyMealRight;
  k,i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetMonthlyMealRightList(edtCardID.Text,edtTableNo.Value, Table) then
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

procedure TfrmPersonMealRightList.btnSetMealRightTableClick(Sender: TObject);
Var
  Table: TDailyMealRight;
  k,i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
      for I := 0 to 7 do
        Table.MealRigths[i] := StrToInt(grdBellTable.Cells[i+1,  1]) ;
      Table.TotalDayRight := StrtoInt(grdBellTable.Cells[9,1]);

    if frmMain.Rdr.SetMonthlyMealRightList(edtCardID.Text,edtTableNo.Value, Table) then
    Begin
      AddLog('Yemek Hak Tablosu gönderildi.');
    End
    else
      AddLog('Yemek Hak Tablosu gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

end.
