unit PersonCommands;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids,
  Vcl.StdCtrls, Vcl.ExtCtrls,PerioDevice, Vcl.Samples.Spin;

type
  TfrmPersonCommands = class(TForm)
    Panel3: TPanel;
    Label1: TLabel;
    btnGetMealRightTable: TButton;
    btnSetMealRightTable: TButton;
    mmLog: TMemo;
    grdBellTable: TStringGrid;
    edtCardID: TEdit;
    Label3: TLabel;
    edtTotalCommand: TSpinEdit;
    procedure btnGetMealRightTableClick(Sender: TObject);
    procedure btnSetMealRightTableClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddLog(str: String; SM: Boolean = False);
  end;

var
  frmPersonCommands: TfrmPersonCommands;

implementation

{$R *.dfm}

uses Main;

procedure TfrmPersonCommands.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //frmMain.PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmPersonCommands.btnGetMealRightTableClick(Sender: TObject);
Var
  CommandList: TPersonCommandList;
  k,i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
    if frmMain.Rdr.GetPersonCommands(edtCardID.Text, CommandList) then
    Begin
        for I := 0 to 14 do
        Begin
          grdBellTable.Cells[0,i+1] := i.ToString();
          grdBellTable.Cells[1,i+1] := IntToStr(CommandList.List[i].CmdType);
          grdBellTable.Cells[2,i+1] := IntToStr(CommandList.List[i].SessionID);
          grdBellTable.Cells[3,i+1] := IntToStr(CommandList.List[i].Amount);
        End;
      edtTotalCommand.Value := CommandList.TotalCommand;
      AddLog('Yemek Hak Tablosu getirildi.');
    End
    else
      AddLog('Yemek Hak Tablosu getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmPersonCommands.btnSetMealRightTableClick(Sender: TObject);
Var
  CommandList: TPersonCommandList;
  k,i: Integer;
begin
  if frmMain.Rdr.Connected then
  Begin
        for I := 0 to 14 do
        Begin
          CommandList.List[i].CmdType := strToInt(grdBellTable.Cells[1,i+1]);
          CommandList.List[i].SessionID := strToInt(grdBellTable.Cells[2,i+1]);
          CommandList.List[i].Amount := strToInt(grdBellTable.Cells[3,i+1]);
        End;
      CommandList.TotalCommand := edtTotalCommand.Value;
    if frmMain.Rdr.SetPersonCommands(edtCardID.Text, CommandList) then
    Begin
      AddLog('Yemek Hak Tablosu getirildi.');
    End
    else
      AddLog('Yemek Hak Tablosu gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmPersonCommands.FormCreate(Sender: TObject);
begin
  grdBellTable.Cells[1,0] := 'K.Tip';
  grdBellTable.Cells[2,0] := 'Session ID';
  grdBellTable.Cells[3,0] := 'Tutar';
end;

end.
