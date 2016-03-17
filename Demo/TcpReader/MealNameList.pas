unit MealNameList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ExtCtrls,PerioDevice;

type
  TfrmMealNameList = class(TForm)
    Panel3: TPanel;
    btnGetTcTable: TButton;
    btnSetTcTable: TButton;
    mmLog: TMemo;
    grdTCTable: TStringGrid;
    procedure btnGetTcTableClick(Sender: TObject);
    procedure btnSetTcTableClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AddLog(str: String; SM: Boolean = False);

  end;

var
  frmMealNameList: TfrmMealNameList;

implementation

{$R *.dfm}

uses Main, WeekDays;

procedure TfrmMealNameList.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmMealNameList.btnGetTcTableClick(Sender: TObject);
Var
  Names : TMealNameList;
  i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetMealNameList(Names) then
    Begin
      for I := 0 to 7 do
      Begin
        grdTCTable.Cells[0, i + 1] := i.ToString();
        grdTCTable.Cells[1, i + 1] := Names.Code[i];
        grdTCTable.Cells[2, i + 1] := Names.Name[i];
      End;

      AddLog('Öðün isim getirildi.');
    End
    else
      AddLog('Öðün isim Tablosu getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMealNameList.btnSetTcTableClick(Sender: TObject);
Var
  Names : TMealNameList;
  i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    for I := 0 to 7 do
    Begin
      Names.code[i] := copy(grdTCTable.Cells[1, i + 1],1,9);
      Names.Name[i] := copy(grdTCTable.Cells[2, i + 1],1,14);
    End;
    if frmMain.Rdr.SetMealNameList(Names) Then
      AddLog('Öðün isim Tablosu gönderildi.')
    else
      AddLog('Öðün isim Tablosu gönderilmedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMealNameList.FormShow(Sender: TObject);
begin
  btnGetTcTable.Click;
end;

end.
