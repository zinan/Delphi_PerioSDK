unit DFData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmDFData = class(TForm)
    Panel1: TPanel;
    mmdata: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDFData: TfrmDFData;

implementation

{$R *.dfm}

procedure TfrmDFData.Button1Click(Sender: TObject);
begin
   ModalResult := mrOk;
end;

end.
