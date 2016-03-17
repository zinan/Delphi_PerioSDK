program TCPReader;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  OutOfServiceTable in 'OutOfServiceTable.pas' {frmOutOfServiceTable},
  BellTable in 'BellTable.pas' {frmBellTable},
  TimeConstraintTable in 'TimeConstraintTable.pas' {frmTimeConstraintTable},
  WeekDays in 'WeekDays.pas' {frmWeekDays},
  DFData in 'DFData.pas' {frmDFData},
  MealTable in 'MealTable.pas' {frmMealTable},
  MealRightTable in 'MealRightTable.pas' {frmMealRightTable},
  PriceListTable in 'PriceListTable.pas' {frmPriceListTable},
  Vcl.Themes,
  Vcl.Styles,
  PersonMealSettings in 'PersonMealSettings.pas' {frmPersonMealSettings},
  StaticMealRightTable in 'StaticMealRightTable.pas' {frmStaticMealRightTable},
  PersonMealRightList in 'PersonMealRightList.pas' {frmPersonMealRightList},
  MealNameList in 'MealNameList.pas' {frmMealNameList},
  PersonCommands in 'PersonCommands.pas' {frmPersonCommands};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
