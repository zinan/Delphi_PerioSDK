unit PriceListTable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Samples.Spin, Vcl.ExtCtrls,
  PerioDevice;

type
  TfrmPriceListTable = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    btnGetMealRightTable: TButton;
    btnSetMealRightTable: TButton;
    edtTableNo: TSpinEdit;
    grdBellTable: TStringGrid;
    mmLog: TMemo;
    cbDays: TComboBox;
    edtFLName: TEdit;
    Label2: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGetMealRightTableClick(Sender: TObject);
    procedure cbDaysChange(Sender: TObject);
    procedure grdBellTableExit(Sender: TObject);
    procedure btnSetMealRightTableClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    gPriceList : TPriceList;
    procedure AddLog(str: String; SM: Boolean = False);
    procedure RecordToGrid(Day:Integer;Var Table: TPriceList);
    procedure GridToRecord(Day:Integer;Var Table: TPriceList);
    procedure ZeroRecord(Day:Integer;Var Table: TPriceList);

  end;

var
  frmPriceListTable: TfrmPriceListTable;

implementation

{$R *.dfm}

uses Main;

procedure TfrmPriceListTable.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmPriceListTable.RecordToGrid(Day:Integer;Var Table: TPriceList);
Var
  k,i :Integer;
Begin
  for  k := 0 to 7 do
    for I := 0 to 14 do
      grdBellTable.Cells[i+1, k + 1] := IntToStr(Table.Days[Day].Meals[k].Prices[i]);
End;

procedure TfrmPriceListTable.ZeroRecord(Day:Integer;Var Table: TPriceList);
Var
  k,i :Integer;
Begin
  for  k := 0 to 7 do
    for I := 0 to 14 do
      Table.Days[Day].Meals[k].Prices[i] := 0;
End;

procedure TfrmPriceListTable.GridToRecord(Day:Integer;Var Table: TPriceList);
Var
  k,i :Integer;
Begin
  for  k := 0 to 7 do
    for I := 0 to 14 do
      Table.Days[Day].Meals[k].Prices[i] := StrToInt(grdBellTable.Cells[i+1, k + 1]);
End;

procedure TfrmPriceListTable.btnGetMealRightTableClick(Sender: TObject);
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetPriceListTable(edtTableNo.Value,gPriceList) then
    Begin
      RecordToGrid(cbDays.ItemIndex,gPriceList);
      edtFLName.Text := gPriceList.Name;
      AddLog('Tarife Tablosu getirildi.');
    End
    else
      AddLog('Tarife Tablosu getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmPriceListTable.btnSetMealRightTableClick(Sender: TObject);
begin
 if frmMain.Rdr.Connected then
  Begin
    gPriceList.Name := edtFLName.Text;
    GridToRecord(cbDays.ItemIndex,gPriceList);
    if frmMain.Rdr.SetPriceListTable(edtTableNo.Value,gPriceList) then
      AddLog('Tarife Tablosu gönderildi.')
    else
      AddLog('Tarife Tablosu gönderilmedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmPriceListTable.Button1Click(Sender: TObject);
begin
  ZeroRecord(cbDays.ItemIndex,gPriceList);
  RecordToGrid(cbDays.ItemIndex,gPriceList);
end;

procedure TfrmPriceListTable.cbDaysChange(Sender: TObject);
begin
  RecordToGrid(cbDays.ItemIndex,gPriceList);
end;

procedure TfrmPriceListTable.FormCreate(Sender: TObject);
begin
  grdBellTable.Cols[1].Text := ' 0.Fiyat';
  grdBellTable.Cols[2].Text := ' 1.Fiyat';
  grdBellTable.Cols[3].Text := ' 2.Fiyat';
  grdBellTable.Cols[4].Text := ' 3.Fiyat';
  grdBellTable.Cols[5].Text := ' 4.Fiyat';
  grdBellTable.Cols[6].Text := ' 5.Fiyat';
  grdBellTable.Cols[7].Text := ' 6.Fiyat';
  grdBellTable.Cols[8].Text := ' 7.Fiyat';
  grdBellTable.Cols[9].Text := ' 8.Fiyat';
  grdBellTable.Cols[10].Text := ' 9.Fiyat';
  grdBellTable.Cols[11].Text := ' 10.Fiyat';
  grdBellTable.Cols[12].Text := ' 11.Fiyat';
  grdBellTable.Cols[13].Text := ' 12.Fiyat';
  grdBellTable.Cols[14].Text := ' 13.Fiyat';
  grdBellTable.Cols[15].Text := ' 14.Fiyat';

  grdBellTable.Rows[1].Text := ' 0.Ö ';
  grdBellTable.Rows[2].Text := ' 1.Ö ';
  grdBellTable.Rows[3].Text := ' 2.Ö ';
  grdBellTable.Rows[4].Text := ' 3.Ö ';
  grdBellTable.Rows[5].Text := ' 4.Ö ';
  grdBellTable.Rows[6].Text := ' 5.Ö ';
  grdBellTable.Rows[7].Text := ' 6.Ö ';
  grdBellTable.Rows[8].Text := ' 7.Ö ';

end;

procedure TfrmPriceListTable.grdBellTableExit(Sender: TObject);
begin
  GridToRecord(cbDays.ItemIndex,gPriceList);
end;

end.
