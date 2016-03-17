program RdrDemo;

uses
  Vcl.Forms,
  RDRDemoMain in 'RDRDemoMain.pas' {frmRDRDemoMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmRDRDemoMain, frmRDRDemoMain);
  Application.Run;

end.
