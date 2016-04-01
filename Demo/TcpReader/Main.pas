unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Samples.Spin,
  System.Actions, Vcl.ActnList,
  DateUtils,
  Vcl.Grids, Vcl.FileCtrl, IdSocketHandle, IdBaseComponent, IdComponent,
  IdUDPBase, IdUDPServer, IdGlobal,
  Perio.Global,
  Perio.Log,
  PerioDevice,
  PerioDevice.TCPReaderBase,
  PerioDevice.TCPReader;

Type
  TMsg = record
    MsgID: word;
    MsgName: String;
  end;

type
  TfrmMain = class(TForm)
    pnlMainLeft: TPanel;
    pnlMainClient: TPanel;
    pnlConnectReader: TPanel;
    pgTCPReader: TPageControl;
    tsDeviceSettings: TTabSheet;
    lblConnectIp: TLabel;
    edtConnectIp: TEdit;
    lblConnectPortNo: TLabel;
    edtConnectPortNo: TSpinEdit;
    lblConnectReaderType: TLabel;
    cbConnectReaderType: TComboBox;
    lblConnectProtocol: TLabel;
    cbConnectProtocol: TComboBox;
    lblConnectKey: TLabel;
    edtConnectKey: TEdit;
    btnConnect: TButton;
    btnDisConnect: TButton;
    ActionList: TActionList;
    ActionRdrConnect: TAction;
    ActionRdrDisConnect: TAction;
    lblConnectTimeOut: TLabel;
    edtConnectTimeOut: TSpinEdit;
    lblConnectCmdRtry: TLabel;
    edtConnectCmdRtry: TSpinEdit;
    cbConnectAutoConnect: TCheckBox;
    cbConnectAutoRxEnabled: TCheckBox;
    gbDeviceÝnfo: TGroupBox;
    btnfwVersion: TButton;
    lblfwVersion: TLabel;
    grHeadTail: TGroupBox;
    lblHead: TLabel;
    lblTail: TLabel;
    lblCapacity: TLabel;
    edtHead: TSpinEdit;
    btnGetHead: TButton;
    edtTail: TSpinEdit;
    btnSetHead: TButton;
    GroupBox2: TGroupBox;
    edtTime: TDateTimePicker;
    edtDate: TDateTimePicker;
    cbDtTimer: TCheckBox;
    btnSetDateTime: TButton;
    dtTimer: TTimer;
    grDeviceStatus: TGroupBox;
    rbDeviceEnabled: TRadioButton;
    rbDeviceDisabled: TRadioButton;
    btnGetDeviceStatus: TButton;
    btnSetDeviceStatus: TButton;
    GroupBox1: TGroupBox;
    edtText1: TEdit;
    edtText2: TEdit;
    lblText1: TLabel;
    lblDefSecreenType: TLabel;
    lblText2: TLabel;
    lblDeviceNo: TLabel;
    edtDeviceNo: TSpinEdit;
    lblBacklight: TLabel;
    edtBacklight: TSpinEdit;
    lblScreenSettings: TLabel;
    lblContrast: TLabel;
    edtContrast: TSpinEdit;
    lblTrOut1: TLabel;
    lblTrOut2: TLabel;
    rbNrOpen2: TRadioButton;
    rbNrClosed2: TRadioButton;
    cbDayRebootEnabled: TCheckBox;
    lblCardReadBeepTime: TLabel;
    edtCardReadBeepTime: TSpinEdit;
    dtpRebootTime: TDateTimePicker;
    grDeviceWorkMode: TGroupBox;
    Panel1: TPanel;
    rbText: TRadioButton;
    rbLogo: TRadioButton;
    Panel2: TPanel;
    rbNrOpen1: TRadioButton;
    rbNrClosed1: TRadioButton;
    rbOfflineWhiteList: TRadioButton;
    rbOnlineTCP: TRadioButton;
    rbOnlineUDP: TRadioButton;
    cbOnlineEnabledOffline: TCheckBox;
    Label2: TLabel;
    edtOnlineTimeOut: TSpinEdit;
    Label3: TLabel;
    tsCominicationSettings: TTabSheet;
    tsMfrKeyTable: TTabSheet;
    grSerialNumber: TGroupBox;
    btnGetSerialNumber: TButton;
    btnSetSerialNumber: TButton;
    btnGetDeviceGeneralSettings: TButton;
    btnSetDeviceGeneralSettings: TButton;
    edtSerialNumber: TEdit;
    GroupBox4: TGroupBox;
    btnSetDeviceFactoryDefaults: TButton;
    cdSaveIPAddr: TCheckBox;
    btnGetWorkMode: TButton;
    btnSetWorkMode: TButton;
    Label4: TLabel;
    tsLCDMessages: TTabSheet;
    grIpSettings: TGroupBox;
    btnGetTCPSettings: TButton;
    btnSetTCPSettings: TButton;
    lblIpAddress: TLabel;
    edtIpAddress: TEdit;
    lblSubnetmask: TLabel;
    edtSubnetMask: TEdit;
    lblDefaultGateway: TLabel;
    edtDefaultGateway: TEdit;
    lblPrimaryDNS: TLabel;
    edtPrimaryDNS: TEdit;
    lblSecondaryDNS: TLabel;
    edtSecondaryDNS: TEdit;
    lblPortNo: TLabel;
    lblServerIpAddress: TLabel;
    edtServerIPAddress: TEdit;
    cbConnOnlyServer: TCheckBox;
    lblProtocol: TLabel;
    cbProtocol: TComboBox;
    cbDhcpEnable: TCheckBox;
    edtPortNo: TSpinEdit;
    grDeviceCommunicationKey: TGroupBox;
    btnSetDeviceKey: TButton;
    edtDeviceKey: TEdit;
    grMacAddress: TGroupBox;
    btnGetMacAddress: TButton;
    btnSetMacAddress: TButton;
    edtMacAddress: TEdit;
    grWebPassword: TGroupBox;
    btnGetWebPassword: TButton;
    btnSetWebPassword: TButton;
    edtWebPassword: TEdit;
    grUPDSettings: TGroupBox;
    lblUdpServerAddress: TLabel;
    Label10: TLabel;
    btnGetUDPSettings: TButton;
    btnSetUDPSettings: TButton;
    edtUpdServerAddress: TEdit;
    cbUPDEnable: TCheckBox;
    cbUdpLogEnabled: TCheckBox;
    edtUdpPorNo: TSpinEdit;
    grdMfrKeyList: TStringGrid;
    btnGetKeylist: TButton;
    btnSetKeylist: TButton;
    btnSetFactoryKey: TButton;
    tsAccessSettings: TTabSheet;
    tsAddWhitelist: TTabSheet;
    lblCardId: TLabel;
    edtCardID: TEdit;
    lblName: TLabel;
    edtName: TEdit;
    lblAccesMask: TLabel;
    seAccMask1: TSpinEdit;
    lblDate: TLabel;
    edtEndDate: TDateTimePicker;
    cbAccessEnabled: TCheckBox;
    cbAPBEnabled: TCheckBox;
    cbATCEnabled: TCheckBox;
    btnAddWhiteList: TButton;
    btnGetWhiteList: TButton;
    btnEditWhiteList: TButton;
    btnDeleteWhiteList: TButton;
    lblCode: TLabel;
    lblPass: TLabel;
    seCode: TSpinEdit;
    sePassword: TSpinEdit;
    btnCardIDCnt: TButton;
    lblTanimliKisi: TLabel;
    btnClearWhiteList: TButton;
    tsInOutValues: TTabSheet;
    grpCihazGirisCikis: TGroupBox;
    Label5: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    edtDosyaYolu: TEdit;
    btnDosyaYolu: TButton;
    seStartFrom: TSpinEdit;
    seHowMany: TSpinEdit;
    btnVeriOku: TButton;
    btnVeriTransferEt: TButton;
    mmFile: TMemo;
    grAppGeneralSettings: TGroupBox;
    btnGetAppgeneralSettings: TButton;
    btnSetAppgeneralSettings: TButton;
    lblAccesType: TLabel;
    cbAccessType: TComboBox;
    lblAccessPwdType: TLabel;
    cbAccessPwdType: TComboBox;
    lblInputType: TLabel;
    cbInputType: TComboBox;
    lblInputDuration: TLabel;
    seInputDuration: TSpinEdit;
    cbATC: TCheckBox;
    grAPB: TGroupBox;
    lblAPBType: TLabel;
    lblAPBDuration: TLabel;
    btnGetAPBSettings: TButton;
    btnSetAPBSettings: TButton;
    cbAPBType: TComboBox;
    seAPBDuration: TSpinEdit;
    lblSecurityZoneNo: TLabel;
    seSecurityZoneNo: TSpinEdit;
    rbAPBGiris: TRadioButton;
    rbAPBCikis: TRadioButton;
    Label6: TLabel;
    edtCardReadTimeOut: TSpinEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtVariableClearTimeout: TSpinEdit;
    Label9: TLabel;
    rbOfflineCardBlackList: TRadioButton;
    lblAPBdk: TLabel;
    gbOutOfService: TGroupBox;
    btnGetOutOfServiceSettings: TButton;
    btnSetOutOfServiceSettings: TButton;
    Label12: TLabel;
    Label13: TLabel;
    edtOutOfServiceTxt1: TEdit;
    edtOutOfServiceTxt2: TEdit;
    cbOutOfServiceSettings: TCheckBox;
    Label14: TLabel;
    gbBell: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    btnGetBellSettings: TButton;
    btnSetBellSettings: TButton;
    edtBellTxt1: TEdit;
    edtBellTxt2: TEdit;
    cbBellEnabled: TCheckBox;
    rbBellTrOut1: TRadioButton;
    rbBellTrOut2: TRadioButton;
    btnTCTable: TButton;
    btnOutOfServicelTable: TButton;
    btnBellTable: TButton;
    Label18: TLabel;
    rbOOSNoChange: TRadioButton;
    rbOOSTrOut1: TRadioButton;
    rbOOSTrOut2: TRadioButton;
    cbAccessCardEnabled: TCheckBox;
    gbEksOtherSettings: TGroupBox;
    Label11: TLabel;
    btnGetEksOtherSettings: TButton;
    btnSetEksOtherSettings: TButton;
    edtPersData: TSpinEdit;
    Label19: TLabel;
    Label20: TLabel;
    edtAccessData: TSpinEdit;
    gbTCPClientSettings: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    btnGetTCPClientSettings: TButton;
    btnSetTCPClientSettings: TButton;
    edtTCPClientAddress: TEdit;
    edTCPClientPort: TSpinEdit;
    pgLog: TPageControl;
    TabAppLog: TTabSheet;
    TabUDPLog: TTabSheet;
    pnlLeftTop: TPanel;
    Label1: TLabel;
    bntClearLog: TButton;
    mmLog: TMemo;
    Panel3: TPanel;
    Label57: TLabel;
    edtLogUDPPortNo: TSpinEdit;
    btnLogUDPStart: TButton;
    btnUDPLogClear: TButton;
    mmUDPLog: TMemo;
    lblIndexNo: TLabel;
    tsDataFlash: TTabSheet;
    Panel4: TPanel;
    btnReadDfPage: TButton;
    Label58: TLabel;
    edDFStartPageNo: TSpinEdit;
    btnWriteDfPage: TButton;
    Label60: TLabel;
    edDFEndPageNo: TSpinEdit;
    sdDF: TSaveDialog;
    odDF: TOpenDialog;
    btnSaveDF: TButton;
    btnLoadDF: TButton;
    mmdf: TListBox;
    lblDfSize: TLabel;
    cbDfSize: TComboBox;
    lblCnt: TLabel;
    btnSetAppFactoryDefaults: TButton;
    cbSetAppDefReboot: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    tsHGSSettings: TTabSheet;
    gbHgsStettings: TGroupBox;
    Label64: TLabel;
    edtHGSPaketBoyu: TSpinEdit;
    bntGetHGSSettings: TButton;
    bntSetHGSSettings: TButton;
    Label61: TLabel;
    edtHGSKartBaslangic: TSpinEdit;
    Label62: TLabel;
    edtHGSKartBoyu: TSpinEdit;
    Label63: TLabel;
    Label65: TLabel;
    edtHGSRLOut1: TSpinEdit;
    edtHGSRLOut2: TSpinEdit;
    Label66: TLabel;
    cbProgramModu: TComboBox;
    Label67: TLabel;
    edtHGSDiziAyar1: TSpinEdit;
    CheckBox1: TCheckBox;
    Label69: TLabel;
    edtHGSAntenGuc1: TSpinEdit;
    Label70: TLabel;
    edtHGSAntenGuc2: TSpinEdit;
    Label71: TLabel;
    edtHGSAntenGucKTanima: TSpinEdit;
    Label72: TLabel;
    edtHGSVDaireAS: TSpinEdit;
    Label73: TLabel;
    edtHGSApb: TSpinEdit;
    Label74: TLabel;
    edtHGSCardID: TEdit;
    lblHGSIndexNo: TLabel;
    Label76: TLabel;
    edtHGSAdi: TEdit;
    Label77: TLabel;
    Label78: TLabel;
    edtHGSDaireNo: TSpinEdit;
    edtHGSAracNo: TSpinEdit;
    Label79: TLabel;
    edtHGSZK1: TSpinEdit;
    Label80: TLabel;
    edtHGSZK2: TSpinEdit;
    Label81: TLabel;
    edtHGSZK3: TSpinEdit;
    Label82: TLabel;
    edtHGSZK4: TSpinEdit;
    Label83: TLabel;
    edtHGSZK5: TSpinEdit;
    Label84: TLabel;
    edtHGSZK6: TSpinEdit;
    Label85: TLabel;
    edtHGSZK7: TSpinEdit;
    Label86: TLabel;
    Label87: TLabel;
    edtHGSKartSonTarih: TDateTimePicker;
    cbHGSEnabled: TCheckBox;
    cbHGSAPBEnabled: TCheckBox;
    cbHGSZKEnabled: TCheckBox;
    btnHGSAddWitelist: TButton;
    btnHGSEditWitelist: TButton;
    btnHGSDelWitelist: TButton;
    btnHGSFindWitelist: TButton;
    lblHGSTanimliKisi: TLabel;
    btnHgsCardIDCnt: TButton;
    btnHGSClearWhiteList: TButton;
    tsHGSInOutValues: TTabSheet;
    mmHGSFile: TMemo;
    grpHGSCihazGirisCikis: TGroupBox;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    edtHGSDosyaYolu: TEdit;
    btnHGSDosyaYolu: TButton;
    seHGSStartFrom: TSpinEdit;
    seHGSHowMany: TSpinEdit;
    btnHGSVeriOku: TButton;
    btnHGSVeriTransferEt: TButton;
    edtIP2: TEdit;
    btnHGSDelWitelistDA: TButton;
    btnHGSFindWitelistDA: TButton;
    GroupBox5: TGroupBox;
    Label91: TLabel;
    edtHGSDaireHK: TSpinEdit;
    Label92: TLabel;
    edtHGSDaireOtoparkHak: TSpinEdit;
    bntGetHGSDaireHak: TButton;
    bntSetHGSDaireHak: TButton;
    Label75: TLabel;
    cbAppType: TComboBox;
    Label93: TLabel;
    edtHGSAppType: TSpinEdit;
    gbYmkPerson: TGroupBox;
    tsYMKSettings: TTabSheet;
    GroupBox6: TGroupBox;
    btnGetYmkSettings: TButton;
    btnSetYmkSettings: TButton;
    Label96: TLabel;
    edtYmkCurrPriceList: TSpinEdit;
    edtYmkSectorNo: TSpinEdit;
    Label97: TLabel;
    Label99: TLabel;
    edtYmkPlantNo: TSpinEdit;
    btnYmkSetFactoryDefault: TButton;
    cbYmkRebootEnb: TCheckBox;
    btnMealTable: TButton;
    btnMealRightTable: TButton;
    btnPriceListTable: TButton;
    GroupBox7: TGroupBox;
    btnGetSerailPortBdSet: TButton;
    btnSetSerailPortBdSet: TButton;
    btnSerialTest: TButton;
    Label103: TLabel;
    cbSerailBaudrate0: TComboBox;
    Label104: TLabel;
    cbSerailBaudrate1: TComboBox;
    Label105: TLabel;
    edtServerEchoTimeOut: TSpinEdit;
    Label106: TLabel;
    btnReboot: TButton;
    btnweekDays: TButton;
    GroupBox9: TGroupBox;
    Label59: TLabel;
    seTestRecCnt: TSpinEdit;
    btnTestRecord: TButton;
    lblTestRecCnt: TLabel;
    Label68: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    cbSerialAppType: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox8: TGroupBox;
    lblOnlSatir1: TLabel;
    lblOnlSatir2: TLabel;
    lblOnlRl: TLabel;
    lblOnlBuzzer: TLabel;
    lblOnlBlink: TLabel;
    lblOnlSecreenTime: TLabel;
    lblOnlFontType: TLabel;
    lblOnlFont2Alligment: TLabel;
    lblOnlSatir3: TLabel;
    lblOnlSatir4: TLabel;
    lblOnlCaption: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    edtOnText1: TEdit;
    edtOnText2: TEdit;
    ckhOnBlink: TCheckBox;
    seOnScreenDuration: TSpinEdit;
    cbOnFontType: TComboBox;
    btnOnMsgGonder: TButton;
    edtOnText3: TEdit;
    edtOnText4: TEdit;
    edtCaption: TEdit;
    cbHeaderType: TComboBox;
    edtOnText5: TEdit;
    edtFooter: TEdit;
    edtLineCount: TSpinEdit;
    edtRlOut1: TSpinEdit;
    edtRlOut2: TSpinEdit;
    edtBuzzerTime: TSpinEdit;
    edtX1: TSpinEdit;
    edtY1: TSpinEdit;
    edtX2: TSpinEdit;
    edtY2: TSpinEdit;
    edtX3: TSpinEdit;
    edtY3: TSpinEdit;
    edtX4: TSpinEdit;
    edtY4: TSpinEdit;
    edtX5: TSpinEdit;
    edtY5: TSpinEdit;
    cbFooterType: TComboBox;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    edtOffText1: TEdit;
    edtOffText2: TEdit;
    ckhOffBlink: TCheckBox;
    seOffScreenDuration: TSpinEdit;
    cbOffFontType: TComboBox;
    btnOffMsgGonder: TButton;
    edtOffText3: TEdit;
    edtOffText4: TEdit;
    edtOffCaption: TEdit;
    cbOffHeaderType: TComboBox;
    edtOffText5: TEdit;
    edtOffFooter: TEdit;
    edtOffLineCount: TSpinEdit;
    edtOffRlOut1: TSpinEdit;
    edtOffRlOut2: TSpinEdit;
    edtOffBuzzerTime: TSpinEdit;
    edtOffX1: TSpinEdit;
    edtOffY1: TSpinEdit;
    edtOffX2: TSpinEdit;
    edtOffY2: TSpinEdit;
    edtOffX3: TSpinEdit;
    edtOffY3: TSpinEdit;
    edtOffX4: TSpinEdit;
    edtOffY4: TSpinEdit;
    edtOffX5: TSpinEdit;
    edtOffY5: TSpinEdit;
    cbOffFooterType: TComboBox;
    cbOffMsgType: TComboBox;
    btnSetFactoryLCDMessages: TButton;
    GroupBox10: TGroupBox;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    edtIbmOnText1: TEdit;
    edtIbmOnText2: TEdit;
    ckhIbmOnBlink: TCheckBox;
    seIbmOnScreenDuration: TSpinEdit;
    btnIbmOnMsgGonder: TButton;
    edtIbmCaption: TEdit;
    cbIbmHeaderType: TComboBox;
    edtIbmRlOut1: TSpinEdit;
    edtIbmRlOut2: TSpinEdit;
    edtIbmBuzzerTime: TSpinEdit;
    edtIbmX1: TSpinEdit;
    edtIbmY1: TSpinEdit;
    edtIbmX2: TSpinEdit;
    edtIbmY2: TSpinEdit;
    cbSetAppDefRebootHgs: TCheckBox;
    btnSetAppFactoryDefaultsHgs: TButton;
    Label116: TLabel;
    edtIbmKeyPadType: TSpinEdit;
    Label117: TLabel;
    Button3: TButton;
    Label118: TLabel;
    cbDefSecreenMsgFontType: TComboBox;
    cbIsOnlineCard: TCheckBox;
    Label131: TLabel;
    edtMealListNo: TSpinEdit;
    Label132: TLabel;
    edtWeeklyMealRight: TSpinEdit;
    edtMonthlyMealRight: TSpinEdit;
    Label133: TLabel;
    Button4: TButton;
    rbOnlineTCPClientMode: TRadioButton;
    Label94: TLabel;
    cmbOnlineCardWorkMode: TComboBox;
    TabSheet3: TTabSheet;
    Label119: TLabel;
    edtCardIdBlack: TEdit;
    lblIndexNoBlack: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    lblTanimliKisiBlack: TLabel;
    Label134: TLabel;
    edtBlackListCmdNo: TSpinEdit;
    Label135: TLabel;
    edtBlackListCaption: TEdit;
    btnStaticMealRightTable: TButton;
    btnMonthlyMealRightTable: TButton;
    cbMontlyRight: TCheckBox;
    Button11: TButton;
    Label95: TLabel;
    cbbOutOfMealstatus: TComboBox;
    Label98: TLabel;
    edtNeedCmdControl: TSpinEdit;
    Button12: TButton;
    cbPermitedInEmergency: TCheckBox;
    Label100: TLabel;
    edtBirthDate: TDateTimePicker;
    Label101: TLabel;
    edtCardReadDelay: TSpinEdit;
    TabSheet4: TTabSheet;
    Label102: TLabel;
    edtValue: TEdit;
    Label122: TLabel;
    edtColor: TSpinEdit;
    btnGetNode: TButton;
    btnSetNode: TButton;
    Label123: TLabel;
    edtAddress: TSpinEdit;
    Label136: TLabel;
    edtLeft: TSpinEdit;
    Label137: TLabel;
    edtRight: TSpinEdit;
    Label138: TLabel;
    edtParent: TSpinEdit;
    TabSheet5: TTabSheet;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Label139: TLabel;
    Label140: TLabel;
    edtSectorNo: TSpinEdit;
    edtBlockNo: TSpinEdit;
    Label141: TLabel;
    edtMfrBlockData: TEdit;
    rbKeyTypeA: TRadioButton;
    RadioButton2: TRadioButton;
    Label142: TLabel;
    procedure ActionRdrConnectExecute(Sender: TObject);
    procedure RdrConnected(Sender: TObject);
    procedure RdrDisConnected(Sender: TObject);
    procedure ActionRdrDisConnectExecute(Sender: TObject);
    procedure btnfwVersionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtTimerTimer(Sender: TObject);
    procedure btnSetDateTimeClick(Sender: TObject);
    procedure btnRebootClick(Sender: TObject);
    procedure btnGetHeadClick(Sender: TObject);
    procedure btnSetHeadClick(Sender: TObject);
    procedure btnSetDeviceFactoryDefaultsClick(Sender: TObject);
    procedure bntClearLogClick(Sender: TObject);
    procedure btnGetDeviceGeneralSettingsClick(Sender: TObject);
    procedure btnSetDeviceGeneralSettingsClick(Sender: TObject);
    procedure cbDayRebootEnabledClick(Sender: TObject);
    procedure btnGetWorkModeClick(Sender: TObject);
    procedure btnSetWorkModeClick(Sender: TObject);
    procedure btnGetSerialNumberClick(Sender: TObject);
    procedure btnSetSerialNumberClick(Sender: TObject);
    procedure btnGetWebPasswordClick(Sender: TObject);
    procedure btnSetWebPasswordClick(Sender: TObject);
    procedure btnGetMacAddressClick(Sender: TObject);
    procedure btnSetMacAddressClick(Sender: TObject);
    procedure btnGetUDPSettingsClick(Sender: TObject);
    procedure btnSetUDPSettingsClick(Sender: TObject);
    procedure btnGetTCPSettingsClick(Sender: TObject);
    procedure btnSetTCPSettingsClick(Sender: TObject);
    procedure btnSetDeviceKeyClick(Sender: TObject);
    procedure btnSetFactoryKeyClick(Sender: TObject);
    procedure btnGetKeylistClick(Sender: TObject);
    procedure btnSetKeylistClick(Sender: TObject);
    procedure btnGetDeviceStatusClick(Sender: TObject);
    procedure btnSetDeviceStatusClick(Sender: TObject);
    procedure btnOnMsgGonderClick(Sender: TObject);
    procedure btnAddWhiteListClick(Sender: TObject);
    procedure btnEditWhiteListClick(Sender: TObject);
    procedure btnDeleteWhiteListClick(Sender: TObject);
    procedure btnGetWhiteListClick(Sender: TObject);
    procedure btnCardIDCntClick(Sender: TObject);
    procedure btnClearWhiteListClick(Sender: TObject);
    procedure btnDosyaYoluClick(Sender: TObject);
    procedure btnVeriOkuClick(Sender: TObject);
    procedure btnVeriTransferEtClick(Sender: TObject);
    procedure btnGetAppgeneralSettingsClick(Sender: TObject);
    procedure btnSetAppgeneralSettingsClick(Sender: TObject);
    procedure btnGetAPBSettingsClick(Sender: TObject);
    procedure btnSetAPBSettingsClick(Sender: TObject);
    procedure cbInputTypeChange(Sender: TObject);
    procedure cbAPBTypeChange(Sender: TObject);
    procedure btnGetOutOfServiceSettingsClick(Sender: TObject);
    procedure btnGetBellSettingsClick(Sender: TObject);
    procedure btnSetOutOfServiceSettingsClick(Sender: TObject);
    procedure btnSetBellSettingsClick(Sender: TObject);
    procedure btnOutOfServicelTableClick(Sender: TObject);
    procedure btnBellTableClick(Sender: TObject);
    procedure btnTCTableClick(Sender: TObject);
    procedure btnGetEksOtherSettingsClick(Sender: TObject);
    procedure btnSetEksOtherSettingsClick(Sender: TObject);
    procedure btnGetTCPClientSettingsClick(Sender: TObject);
    procedure btnSetTCPClientSettingsClick(Sender: TObject);
    procedure cbOffMsgTypeChange(Sender: TObject);
    procedure btnOffMsgGonderClick(Sender: TObject);
    procedure btnLogUDPStartClick(Sender: TObject);
    procedure btnUDPLogClearClick(Sender: TObject);
    procedure cbHeaderTypeChange(Sender: TObject);
    procedure cbFooterTypeChange(Sender: TObject);
    procedure edtLineCountChange(Sender: TObject);
    procedure cbOffHeaderTypeChange(Sender: TObject);
    procedure cbOffFooterTypeChange(Sender: TObject);
    procedure edtOffLineCountChange(Sender: TObject);
    procedure btnweekDaysClick(Sender: TObject);
    procedure cbDtTimerClick(Sender: TObject);
    procedure RdrCardRead(Sender: TObject; const CardID: string);
    procedure btnReadDfPageClick(Sender: TObject);
    procedure btnWriteDfPageClick(Sender: TObject);
    procedure btnSaveDFClick(Sender: TObject);
    procedure btnLoadDFClick(Sender: TObject);
    procedure mmdfDblClick(Sender: TObject);
    procedure btnSerialTestClick(Sender: TObject);
    procedure btnSetFactoryLCDMessagesClick(Sender: TObject);
    procedure btnTestRecordClick(Sender: TObject);
    procedure btnSetAppFactoryDefaultsClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure bntGetHGSSettingsClick(Sender: TObject);
    procedure bntSetHGSSettingsClick(Sender: TObject);
    procedure btnHGSClearWhiteListClick(Sender: TObject);
    procedure btnHgsCardIDCntClick(Sender: TObject);
    procedure btnHGSAddWitelistClick(Sender: TObject);
    procedure btnHGSDosyaYoluClick(Sender: TObject);
    procedure btnHGSVeriOkuClick(Sender: TObject);
    procedure btnHGSVeriTransferEtClick(Sender: TObject);
    procedure btnHGSDelWitelistClick(Sender: TObject);
    procedure btnHGSEditWitelistClick(Sender: TObject);
    procedure btnHGSFindWitelistClick(Sender: TObject);
    procedure bntGetHGSDaireHakClick(Sender: TObject);
    procedure bntSetHGSDaireHakClick(Sender: TObject);
    procedure btnHGSFindWitelistDAClick(Sender: TObject);
    procedure btnHGSDelWitelistDAClick(Sender: TObject);
    procedure RdrTurnstileTurn(Sender: TObject; const Succes: Boolean; const CardID: string);
    procedure RdrTagRead(Sender: TObject; const IO: Byte; const TagID: string);
    procedure RdrDoorOpenAlarm(Sender: TObject; const DoorOpen: Boolean; const OpenTime: Cardinal);
    procedure btnGetYmkSettingsClick(Sender: TObject);
    procedure btnSetYmkSettingsClick(Sender: TObject);
    procedure btnYmkSetFactoryDefaultClick(Sender: TObject);
    procedure btnMealTableClick(Sender: TObject);
    procedure btnMealRightTableClick(Sender: TObject);
    procedure btnPriceListTableClick(Sender: TObject);
    procedure RdrSerialReadStr(Sender: TObject; const SerialPortNo: Byte; const Data: string);
    procedure btnGetSerailPortBdSetClick(Sender: TObject);
    procedure btnSetSerailPortBdSetClick(Sender: TObject);
    procedure RdrPasswordRead(Sender: TObject; const PassType: Byte; const Password: Word;
      const Code: Cardinal);
    procedure cbConnectReaderTypeChange(Sender: TObject);
    procedure btnIbmOnMsgGonderClick(Sender: TObject);
    procedure btnSetAppFactoryDefaultsHgsClick(Sender: TObject);
    procedure RdrInputText(Sender: TObject; const ConfirmationType: TInputConfirmationType;
      const InputText: string);
    procedure Button3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btnAddBlackListClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure btnStaticMealRightTableClick(Sender: TObject);
    procedure btnMonthlyMealRightTableClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure btnGetNodeClick(Sender: TObject);
    procedure btnSetNodeClick(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
  private
    { Private declarations }
    OffflineMsg: array  of TMsg;
    procedure rdrLog(Sender: TObject;const LogLevel : TprLogLevel;const Log: string);
    procedure UDPServerUDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
  public
    ReadDataBlock : Boolean;
    Rdr : TPerioTCPRdr;
    UDPServer: TIdUDPServer;

    procedure AddLog(str: String; SM: Boolean = False);
    procedure OfflineMsgLoad;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses OutOfServiceTable, BellTable, TimeConstraintTable, WeekDays, DFData, MealTable, MealRightTable,
  PriceListTable, PersonMealSettings, StaticMealRightTable, PersonMealRightList,
  MealNameList, PersonCommands;

procedure TfrmMain.ActionRdrDisConnectExecute(Sender: TObject);
begin
  Rdr.DisConnect;
end;

procedure TfrmMain.AddLog(str: String; SM: Boolean = False);
begin
  mmLog.Lines.Insert(0, TimeToStr(time) + ' > ' + str);
  //PerioLog.LogDebug('Log', str);
  if SM then
    ShowMessage(str);
end;

procedure TfrmMain.bntClearLogClick(Sender: TObject);
begin
  mmLog.Lines.clear;
end;

procedure TfrmMain.bntGetHGSDaireHakClick(Sender: TObject);
Var
  Hak:Byte;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    if Rdr.GetHGSDaireParkHak(edtHGSDaireHK.Value,Hak) then
    Begin
      edtHGSDaireOtoparkHak.Value := Hak;
      AddLog('Daire Otopark Hakký getirildi.');
    End
    else
      AddLog('Daire Otopark Hakký getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.bntGetHGSSettingsClick(Sender: TObject);
Var
  rSettings: THGS_Settings;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    if Rdr.GetHGSSettings(rSettings) then
    Begin
      edtHGSPaketBoyu.Value := rSettings.PaketBoyu;
      edtHGSKartBaslangic.Value := rSettings.CardBaslangic;
      edtHGSKartBoyu.Value := rSettings.CardBoyu;
      edtHGSRLOut1.Value := rSettings.TrCikisSure1;
      edtHGSRLOut2.Value := rSettings.TrCikisSure2;
      cbProgramModu.ItemIndex :=  rSettings.ProgramMode-1;
      edtHGSDiziAyar1.Value := rSettings.DiziEklemeSure1;
      //edtHGSDiziAyar2.Value := rSettings.DiziEklemeSure2;
      edtHGSAntenGuc1.Value := rSettings.AntenPower1;
      edtHGSAntenGuc2.Value := rSettings.AntenPower2;
      edtHGSAntenGucKTanima.Value := rSettings.AntenTanitim;
      edtHGSVDaireAS.Value := rSettings.DefMaksimumArac;
      edtHGSApb.Value := rSettings.DefAntiPassPack;
      edtHGSAppType.Value := rSettings.AppType;
      AddLog('HGS genel Ayarlarý getirildi..');
    End
    else
      AddLog('HGS genel Ayarlarý getirilemedi..');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.bntSetHGSDaireHakClick(Sender: TObject);
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    if Rdr.SetHGSDaireParkHak(edtHGSDaireHK.Value,edtHGSDaireOtoparkHak.Value) then
      AddLog('Daire Otopark Hakký gönderildi.')
    else
      AddLog('Daire Otopark Hakký gönderilmedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.bntSetHGSSettingsClick(Sender: TObject);
Var
  rSettings: THGS_Settings;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
      rSettings.PaketBoyu := edtHGSPaketBoyu.Value;
      rSettings.CardBaslangic := edtHGSKartBaslangic.Value ;
      rSettings.CardBoyu := edtHGSKartBoyu.Value;
      rSettings.TrCikisSure1 := edtHGSRLOut1.Value;
      rSettings.TrCikisSure2 := edtHGSRLOut2.Value;
      rSettings.ProgramMode := cbProgramModu.ItemIndex+1;
      rSettings.DiziEklemeSure1 := edtHGSDiziAyar1.Value;
      //rSettings.DiziEklemeSure2 := edtHGSDiziAyar2.Value;
      rSettings.AntenPower1 := edtHGSAntenGuc1.Value;
      rSettings.AntenPower2 := edtHGSAntenGuc2.Value;
      rSettings.AntenTanitim := edtHGSAntenGucKTanima.Value;
      rSettings.DefMaksimumArac := edtHGSVDaireAS.Value;
      rSettings.DefAntiPassPack := edtHGSApb.Value;
      rSettings.AppType := edtHGSAppType.Value;
    if Rdr.SetHGSSettings(rSettings) then
    Begin
      AddLog('HGS genel Ayarlarý gönderildi..');
    End
    else
      AddLog('HGS genel Ayarlarý gönderilemedi..');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnAddBlackListClick(Sender: TObject);
Var
  Person: TBlackList;
  iErr, InxNm: Integer;
  CardID: String;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS ve YMK fw ile çalýþýr.');
    abort;
  End;

  lblIndexNo.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtCardID.Text;
    if (IsHex(CardID) and (Length(CardID) = 14)) then
    begin
      Person.CardID := CardID;
      Person.Caption := Copy(edtName.Text, 1, 18);
      //
//      Person.ContorModeEnable := cbContorEnable.Checked;
//      Person.MealRightWorkMode := cmbMealRightMode.ItemIndex;
//      Person.MealRightListNo := edtMealHakListNo.Value;
//      Person.PriceGroup := edtMealPriceGroup.Value;
//      Person.ReReadPriceGroup := edtMealReReadPriceGroup.Value;
//      Person.ReReadType := cmbReReadType.ItemIndex;
//      Person.ReReadCount := edtReReadCount.Value;
      Person.BlackListCmdNo := edtBlackListCmdNo.Value;
      iErr := Rdr.AddBlacklist(Person, InxNm);
      case iErr of
        0:
          Begin
            AddLog('Kiþi eklendi.');
            lblIndexNo.Caption := IntToStr(InxNm);
          End;
        1:
          AddLog('Daha önce eklenmiþ.');
        20:
          AddLog('Þifre kapasitesi aþýldý.');
        51:
          AddLog('Bu Kart ID daha önce tanýmlanmýþ.');
        52:
          AddLog('Bu þifre daha önce tanýmlanmýþ.');
      else
        AddLog('Kiþi eklenemedi!');
      end;
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnAddWhiteListClick(Sender: TObject);
Var
  Person: TPerson;
  iErr, InxNm: Integer;
  CardID: String;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS ve YMK fw ile çalýþýr.');
    abort;
  End;

  lblIndexNo.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtCardID.Text;
    if (IsHex(CardID) and (Length(CardID) = 14)) then
    begin
      Person.CardID := CardID;
      Person.Name := Copy(edtName.Text, 1, 18);
      Person.TimeZoneListNo := seAccMask1.Value;
      Person.Code := seCode.Value;
      Person.Password := sePassword.Value;
      Person.EndDate := edtEndDate.Date;
      Person.AccessDevice := cbAccessEnabled.Checked;
      Person.APBEnabled := cbAPBEnabled.Checked;
      Person.TZEnabled := cbATCEnabled.Checked;
      Person.AccessCardEnabled := cbAccessCardEnabled.Checked;
      Person.isOnlineCard := cbIsOnlineCard.Checked;
      Person.PermitedInEmergency := cbPermitedInEmergency.Checked;
      Person.MealSettingListNo := edtMealListNo.Value;
      Person.WeeklyTotalMealCount := edtWeeklyMealRight.Value;
      Person.MonthlyTotalMealCount := edtMonthlyMealRight.Value;
      Person.BlackListCmdNo := 0;
      Person.NeedCmdControl := edtNeedCmdControl.Value;
      Person.BirthDate := edtBirthDate.Date;
      iErr := Rdr.AddWhitelist(Person, InxNm);
      case iErr of
        0:
          Begin
            AddLog('Kiþi eklendi.');
            lblIndexNo.Caption := IntToStr(InxNm);
          End;
        1:
          AddLog('Daha önce eklenmiþ.');
        20:
          AddLog('Þifre kapasitesi aþýldý.');
        51:
          AddLog('Bu Kart ID daha önce tanýmlanmýþ.');
        52:
          AddLog('Bu þifre daha önce tanýmlanmýþ.');
      else
        AddLog('Kiþi eklenemedi!');
      end;
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnBellTableClick(Sender: TObject);
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS ve YMK fw ile çalýþýr.');
    abort;
  End;

  frmBellTable := TfrmBellTable.create(self);
  try
    frmBellTable.ShowModal;
  finally
    frmBellTable.Free;
  end;
end;

procedure TfrmMain.btnCardIDCntClick(Sender: TObject);
Var
  cnt: Integer;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS ve YMK fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    cnt := Rdr.GetWhitelistCardIDCount;
    if cnt <> -1 Then
      lblTanimliKisi.Caption := 'Tanýmlý Kiþi Sayýsý : ' + IntToStr(cnt)
    else
      lblTanimliKisi.Caption := 'Kiþi sayýsý getirilemedi.';
    lblTanimliKisiBlack.Caption := lblTanimliKisi.Caption;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnClearWhiteListClick(Sender: TObject);
Var
  cnt: Integer;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS ve YMK fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    try
      btnClearWhiteList.Enabled := False;
      Rdr.ClearWhitelist;
      Rdr.DisConnect;
      Sleep(100);
      Rdr.Connect;
    finally
      btnClearWhiteList.Enabled := True;
      if Rdr.Connected then
        btnCardIDCnt.Click;
    end;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetFactoryLCDMessagesClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    rdr.SetLCDMessagesFactoryDefault;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnDeleteWhiteListClick(Sender: TObject);
Var
  CardID: String;
  InxNm: Integer;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS ve YMK fw ile çalýþýr.');
    abort;
  End;

  lblIndexNo.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtCardID.Text;
    if (IsHex(CardID) and (Length(CardID) = 14)) then
    begin
      if Rdr.DeleteWhitelistWithCardID(CardID, InxNm) = 0 Then
      Begin
        AddLog('Kiþi silindi.');
        lblIndexNo.Caption := IntToStr(InxNm);
      End
      else
        AddLog('Kiþi silinemedi.');
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnDosyaYoluClick(Sender: TObject);
var
  DirSelected: string;
begin
  try
    DirSelected := 'Select a folder';
    if SelectDirectory(DirSelected, '', DirSelected) then
    begin
      edtDosyaYolu.Text := DirSelected;
    end;
    if edtDosyaYolu.Text = '-' then
      exit;
    if not DirectoryExists(edtDosyaYolu.Text) then
      CreateDir(edtDosyaYolu.Text);
  except
    AddLog('Dosya yolu seçilemedi!');
  end;
end;

procedure TfrmMain.btnEditWhiteListClick(Sender: TObject);
var
  Person: TPerson;
  iErr, i, cnt, InxNm: Integer;
  CardID: String;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS ve YMK fw ile çalýþýr.');
    abort;
  End;

  lblIndexNo.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtCardID.Text;
    if (IsHex(CardID) and (Length(CardID) = 14)) then
    begin
      Person.CardID := CardID;
      Person.Name := Copy(edtName.Text, 1, 18);
      Person.TimeZoneListNo := seAccMask1.Value;
      Person.Code := seCode.Value;
      Person.Password := sePassword.Value;
      Person.EndDate := edtEndDate.Date;
      Person.AccessDevice := cbAccessEnabled.Checked;
      Person.APBEnabled := cbAPBEnabled.Checked;
      Person.TZEnabled := cbATCEnabled.Checked;
      Person.AccessCardEnabled := cbAccessCardEnabled.Checked;
      Person.isOnlineCard := cbIsOnlineCard.Checked;
      Person.PermitedInEmergency := cbPermitedInEmergency.Checked;
      Person.MealSettingListNo := edtMealListNo.Value;
      Person.WeeklyTotalMealCount := edtWeeklyMealRight.Value;
      Person.MonthlyTotalMealCount := edtMonthlyMealRight.Value;
      //
      Person.BlackListCmdNo := 0;
      Person.NeedCmdControl := edtNeedCmdControl.Value;
      Person.BirthDate := edtBirthDate.Date;

      iErr := Rdr.EditWhitelistWithCardID(Person, InxNm);
      case iErr of
        0:
          Begin
            AddLog('Kiþi deðiþtirildi.');
            lblIndexNo.Caption := IntToStr(InxNm);
          End;
        1:
          AddLog('Daha önce eklenmiþ.');
        20:
          AddLog('Þifre kapasitesi aþýldý.');
        52:
          AddLog('Bu þifre daha önce tanýmlanmýþ.');
      else
        AddLog('Kiþi deðiþtirilemedi!');
      end;
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnfwVersionClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    lblfwVersion.Caption := Rdr.GetFwVwersion;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetAPBSettingsClick(Sender: TObject);
Var
  Settings: TAPBSettings;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    if Rdr.GetAntiPassbackSettings(Settings) then
    begin
      cbAPBType.ItemIndex := Settings.APBType;
      cbAPBTypeChange(self);
      seAPBDuration.Value := Settings.SequentialTransitionTime;
      seSecurityZoneNo.Value := Settings.SecurityZone;
      rbAPBGiris.Checked := (Settings.ApbInOut = 0);

      AddLog('APB Ayarlarý getirildi.');
    end
    else
      AddLog('APB Ayarlarý getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnGetAppgeneralSettingsClick(Sender: TObject);
var
  Settings: TAccessGeneralSettings;
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetAppGeneralSettings(Settings) then
    begin
      cbAccessType.ItemIndex := Settings.AccessMode.AccessType;
      cbAccessPwdType.ItemIndex := Settings.AccessMode.PasswordType;
      cbInputType.ItemIndex := Settings.InputSettings.InputType;
      cbInputTypeChange(self);
      seInputDuration.Value := Settings.InputSettings.InputDurationTimeout;
      cbATC.Checked := Settings.TimeAccessConstraintEnabled;
      AddLog('Uygulama genel bilgileri getirildi.');
    end
    else
      AddLog('Uygulama genel bilgileri getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetBellSettingsClick(Sender: TObject);
Var
  Settings: TBellSettings;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS fw ile çalýþýr.');
    abort;
  End;
  if Rdr.Connected then
  Begin
    if Rdr.GetBellSettings(Settings) then
    begin
      cbBellEnabled.Checked := Settings.Enabled;
      edtBellTxt1.Text := Settings.ScreenText1;
      edtBellTxt2.Text := Settings.ScreenText2;
      case Settings.OutType of
        1:
          rbBellTrOut1.Checked := True;
        2:
          rbBellTrOut2.Checked := True;
      end;
      AddLog('Zil Çaldýrma bilgileri getirildi.');
    end
    else
      AddLog('Zil Çaldýrma bilgileri getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetDeviceGeneralSettingsClick(Sender: TObject);
Var
  rSettings: TGeneralDeviceSettings;
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetDeviceGeneralSettings(rSettings) then
    Begin
      edtDeviceNo.Value := rSettings.DevNo;
      case rSettings.IdleScreenType of
        stText:
          rbText.Checked := True;
        stLogo:
          rbLogo.Checked := True;
      end;
      edtText1.Text := rSettings.DefaultScreenTxt1;
      edtText2.Text := rSettings.DefaultScreenTxt2;
      edtBacklight.Value := rSettings.Backlight;
      edtContrast.Value := rSettings.Contrast;
      case rSettings.TrOut1Type of
        NrOpen:
          rbNrOpen1.Checked := True;
        NrClosed:
          rbNrClosed1.Checked := True;
      end;
      case rSettings.TrOut2Type of
        NrOpen:
          rbNrOpen2.Checked := True;
        NrClosed:
          rbNrClosed2.Checked := True;
      end;
      cbDayRebootEnabled.Checked := rSettings.DailyRebootEnb;
      dtpRebootTime.time := rSettings.RebootTime;
      edtCardReadBeepTime.Value := rSettings.CardReadBeepTime;
      edtCardReadTimeOut.Value := rSettings.CardReadTimeOut;
      edtVariableClearTimeout.Value := rSettings.VariableClearTimeout;
      cbDefSecreenMsgFontType.ItemIndex := rSettings.DefaultScreenFontType;
      edtCardReadDelay.Value := rSettings.CardReadDelay;
      AddLog('Cihaz genel bilgileri getirildi..');
    End
    else
      AddLog('Cihaz genel bilgileri getirilemedi..');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetDeviceStatusClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetDeviceStatus then
      rbDeviceEnabled.Checked := True
    else
      rbDeviceDisabled.Checked := True;
    AddLog('Cihaz durumu getirildi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetEksOtherSettingsClick(Sender: TObject);
Var
  EksOtherSettings: TEksOtherSettings;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS fw ile çalýþýr.');
    abort;
  End;
  if Rdr.Connected then
  Begin
    if Rdr.GetEksOtherSettings(EksOtherSettings) then
    Begin
      edtPersData.Value := EksOtherSettings.PersDataCardSector;
      edtAccessData.Value := EksOtherSettings.AccessDataCardSector;
      AddLog('Eks Diðer Bilgileri getirildi.');
    End
    else
      AddLog('Eks Diðer Bilgileri getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetHeadClick(Sender: TObject);
Var
  Head, Tail, Capacity: LongWord;
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetHeadTailCapacity(Head, Tail, Capacity) then
    Begin
      edtHead.Value := Head;
      edtTail.Value := Tail;
      lblCapacity.Caption := 'Kapasite : ' + IntToStr(Capacity);
      AddLog('Head -Tail Bilgisi getirildi.');
    End
    else
      AddLog('Head -Tail Bilgisi getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetKeylistClick(Sender: TObject);
Var
  KeyList: TMfrKeyListStr;
  i: Integer;
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetMfrKeyList(KeyList) then
    Begin
      for I := 0 to 15 do
      Begin
        grdMfrKeyList.Cells[1, i + 1] := KeyList.Sector[i].KeyA;
        grdMfrKeyList.Cells[2, i + 1] := KeyList.Sector[i].KeyB;
      End;
      AddLog('Mifare Key Listesi getirildi.');
    End
    else
      AddLog('Mifare Key Listesi getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnGetMacAddressClick(Sender: TObject);
Var
  MACAddress: String;
begin
  if Rdr.Connected then
  Begin
    MACAddress := Rdr.GetMACAddress;
    if MACAddress <> '*' then
    Begin
      edtMacAddress.Text := MACAddress;
      AddLog('Mac adresi getirildi.');
    End
    else
      AddLog('Mac adresi getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetOutOfServiceSettingsClick(Sender: TObject);
Var
  Settings: TOutOfServiceSettings;
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetOutOfServiceSettings(Settings) then
    begin
      cbOutOfServiceSettings.Checked := Settings.Enabled;
      edtOutOfServiceTxt1.Text := Settings.ScreenText1;
      edtOutOfServiceTxt2.Text := Settings.ScreenText2;
      case Settings.OutType of
        0:
          rbOOSNoChange.Checked := True;
        1:
          rbOOSTrOut1.Checked := True;
        2:
          rbOOSTrOut2.Checked := True;
      end;
      AddLog('Hizmet dýþý bilgileri getirildi.');
    end
    else
      AddLog('Hizmet dýþý bilgileri getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetSerailPortBdSetClick(Sender: TObject);
Var
 SerailAppType,s0,S1:byte;
begin
   if Rdr.Connected then
  Begin

    if rdr.GetSerialPortSettings(SerailAppType,S0,S1) then
    Begin
      cbSerailBaudrate0.ItemIndex := s0;
      cbSerailBaudrate1.ItemIndex := s1;
      cbSerialAppType.ItemIndex := SerailAppType;
      AddLog('Seri Port Baudrate ayarlarý getirildi.');
    End
    else
      AddLog('Seri Port Baudrate ayarlarý getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetSerialNumberClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    edtSerialNumber.Text := Rdr.GetSerialNumber;
    if edtSerialNumber.Text <> 'XXX' then
    Begin
      AddLog('Cihaz Seri Numarasý getirildi.');
    End
    else
      AddLog('Cihaz Seri Numarasý getirilemedi.');

  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetTCPSettingsClick(Sender: TObject);
Var
  rSettings: TTCPSettings;
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetDeviceTCPSettings(rSettings) then
    Begin
      case rSettings.ProtocolType of
        PR0:
          cbProtocol.ItemIndex := 0;
        PR1:
          cbProtocol.ItemIndex := 1;
        PR2:
          cbProtocol.ItemIndex := 2;
        PR3:
          cbProtocol.ItemIndex := 3;
      end;
      edtIpAddress.Text := rSettings.IPAdress;
      edtSubnetMask.Text := rSettings.NetMask;
      edtDefaultGateway.Text := rSettings.DefGetway;
      edtPrimaryDNS.Text := rSettings.PriDNS;
      edtSecondaryDNS.Text := rSettings.SecDNS;
      edtPortNo.Value := rSettings.Port;
      edtServerIPAddress.Text := rSettings.RemIpAdress;
      cbConnOnlyServer.Checked := rSettings.ConnectOnlyRemIpAdress;
      cbDhcpEnable.Checked := rSettings.DHCP;
      edtServerEchoTimeOut.Value := rSettings.ServerEchoTimeOut;
      AddLog('TCP Ayarlarý getirildi.');
    End
    else
      AddLog('TCP Ayarlarý getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetUDPSettingsClick(Sender: TObject);
Var
  rSettings: TUDPSettings;
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetDeviceUDPSettings(rSettings) then
    Begin
      edtUpdServerAddress.Text := rSettings.RemUDPAdress;
      edtUdpPorNo.Value := rSettings.UDPPort;
      cbUPDEnable.Checked := rSettings.UDPIsActive;
      cbUdpLogEnabled.Checked := rSettings.UDPLogIsActive;
      AddLog('UDP Ayarlarý getirildi.');
    End
    else
      AddLog('UDP Ayarlarý getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetWebPasswordClick(Sender: TObject);
Var
  pwd: String;
begin
  if Rdr.Connected then
  Begin
    pwd := Rdr.GetWebPassword;
    if pwd <> '*' then
    Begin
      edtWebPassword.Text := pwd;
      AddLog('Web þifresi getirildi.');
    End
    else
      AddLog('Web þifresi getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetWhiteListClick(Sender: TObject);
var
  Person: TPerson;
  iErr, i, cnt, InxNm: Integer;
  CardID: String;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS fw ile çalýþýr.');
    abort;
  End;

  lblIndexNo.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtCardID.Text;
    if (IsHex(CardID) and (Length(CardID) = 14)) then
    begin
      iErr := Rdr.GetWhitelistWithCardID(CardID, Person, InxNm);
      if (iErr = 0) Then
      Begin
        edtName.Text := Trim(Person.Name);
        seAccMask1.Value := Person.TimeZoneListNo;
        seCode.Value := Person.Code;
        sePassword.Value := Person.Password;
        edtEndDate.Date := Person.EndDate;
        cbAccessEnabled.Checked := Person.AccessDevice;
        cbAPBEnabled.Checked := Person.APBEnabled;
        cbATCEnabled.Checked := Person.TZEnabled;
        cbAccessCardEnabled.Checked := Person.AccessCardEnabled;
        cbIsOnlineCard.Checked := Person.isOnlineCard;
        cbPermitedInEmergency.Checked := Person.PermitedInEmergency;
        edtMealListNo.Value := Person.MealSettingListNo;

        edtWeeklyMealRight.Value := Person.WeeklyTotalMealCount;
        edtMonthlyMealRight.Value := Person.MonthlyTotalMealCount;
        edtBlackListCmdNo.Value := Person.BlackListCmdNo;
        edtNeedCmdControl.Value := Person.NeedCmdControl;
        edtBirthDate.Date := Person.BirthDate;
        lblIndexNo.Caption := IntToStr(InxNm);
        AddLog('Kiþi getirildi.');
      End
      else
        AddLog('Kiþi getirilemedi.(' + IntToStr(iErr) + ')');
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');

  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetWorkModeClick(Sender: TObject);
Var
  rSettings: TWorkModeSettings;
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetDeviceWorkModeSettings(rSettings) then
    Begin
      case rSettings.WorkingMode of
        wmOffline:
          rbOfflineWhiteList.Checked := True;
        wmOfflineCard:
          rbOfflineCardBlackList.Checked := True;
        wmTCPOnline:
          rbOnlineTCP.Checked := True;
        wmUDPOnline:
          rbOnlineUDP.Checked := True;
        wmTCPOnlineClientMode :
          rbOnlineTCPClientMode.Checked := True;
      end;
      cmbOnlineCardWorkMode.ItemIndex := Integer(rSettings.OfflineOnlineMode);
      cbOnlineEnabledOffline.Checked := rSettings.OfflineModePermission;
      edtOnlineTimeOut.Value := rSettings.ServerAnswerTimeOut;
      AddLog('Cihaz çalýþma modu getirildi.');
    End
    else
      AddLog('Cihaz çalýþma modu getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetYmkSettingsClick(Sender: TObject);
Var
  Settings : TYmkSettings;
begin
  if Rdr.Connected then
  Begin
    if rdr.GetYmkSettings(Settings) then
    Begin
      cbMontlyRight.Checked := Settings.UseMonthlyRight;
      edtYmkCurrPriceList.Value := Settings.CurrPriceList ;
      edtYmkSectorNo.Value := Settings.YmkSectorNo;
      edtYmkPlantNo.Value := Settings.PlantNo;
      cbbOutOfMealstatus.ItemIndex := Settings.OutOfMealstatus;
      AddLog('Yemek Ayarlarý getirildi.');
    End
    else
      AddLog('Yemek Ayarlarý getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnHGSAddWitelistClick(Sender: TObject);
Var
  Arac: THGSArac;
  iErr, InxNm: Integer;
  CardID: String;
  Devam : Boolean;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  lblHGSIndexNo.Caption := '-1';
  Devam := False;
  if Rdr.Connected then
  Begin
    CardID := edtHGSCardID.Text;
    Devam := (IsHex(CardID) and (Length(CardID) = 16));
    if not Devam then
      ShowMessage('Uygun Tag ID girilmemiþ.');
    if Devam then
    begin
      Arac.CardID := CardID;
      Arac.Name := Copy(edtHGSAdi.Text, 1, 18);
      Arac.TimeAccessMask[0] := edtHGSZK1.Value;
      Arac.TimeAccessMask[1] := edtHGSZK2.Value;
      Arac.TimeAccessMask[2] := edtHGSZK3.Value;
      Arac.TimeAccessMask[3] := edtHGSZK4.Value;
      Arac.TimeAccessMask[4] := edtHGSZK5.Value;
      Arac.TimeAccessMask[5] := edtHGSZK6.Value;
      Arac.TimeAccessMask[6] := edtHGSZK7.Value;
      Arac.Daire := edtHGSDaireNo.Value;
      Arac.AracNo := edtHGSAracNo.Value;
      Arac.EndDate := edtHGSKartSonTarih.Date;
      Arac.AccessDevice := cbHGSEnabled.Checked;
      Arac.APBEnabled := cbHGSAPBEnabled.Checked;
      Arac.ATCEnabled := cbHGSZKEnabled.Checked;
      iErr := Rdr.AddHGSWhitelist(Arac,InxNm);
      case iErr of
        0:
          Begin
            AddLog('Araç eklendi.');
            lblHGSIndexNo.Caption := IntToStr(InxNm);
          End;
        26:
          AddLog('Bu Daire- Araç daha önce tanýmlanmýþ.');
        24:
          AddLog('Tag ID var Daire yok.');
        25:
          AddLog('Daire var Tag ID yok.');
        52:
          AddLog('Sonra ');
      else
        AddLog('Araç eklenemedi!');
      end;
    end
    else
      AddLog('Uygun Kart ID veya Daire araç Girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnHGSClearWhiteListClick(Sender: TObject);
Var
  cnt: Integer;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    try
      btnHgsClearWhiteList.Enabled := False;
      Rdr.ClearWhitelist;
      Rdr.DisConnect;
      Sleep(100);
      Rdr.Connect;
    finally
      btnHgsClearWhiteList.Enabled := True;
      if Rdr.Connected then
        btnHgsCardIDCnt.Click;
    end;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnHGSDelWitelistClick(Sender: TObject);
Var
  CardID: String;
  InxNm: Integer;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  lblIndexNo.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtHGSCardID.Text;
    if (IsHex(CardID) and (Length(CardID) = 16)) then
    begin
      if Rdr.DeleteHGSWhitelistWithCardID(CardID, InxNm) = 0 Then
      Begin
        AddLog('Araç silindi.');
        lblHGSIndexNo.Caption := IntToStr(InxNm);
      End
      else
        AddLog('Araç silinemedi.');
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnHGSDelWitelistDAClick(Sender: TObject);
Var
  InxNm: Integer;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  lblIndexNo.Caption := '-1';
  if Rdr.Connected then
  Begin
    if ( (edtHGSDaireNo.Value <> 0 ) and (edtHGSAracNo.Value <> 0) ) then
    begin
      if Rdr.DeleteHGSWhitelistWithDaireArac(edtHGSDaireNo.Value,edtHGSAracNo.Value,InxNm) = 0 Then
      Begin
        AddLog('Araç silindi.');
        lblHGSIndexNo.Caption := IntToStr(InxNm);
      End
      else
        AddLog('Araç silinemedi.');
    end
    else
      AddLog('Uygun Daire Araç girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnHGSDosyaYoluClick(Sender: TObject);
var
  DirSelected: string;
begin
  try
    DirSelected := 'Select a folder';
    if SelectDirectory(DirSelected, '', DirSelected) then
    begin
      edtHGSDosyaYolu.Text := DirSelected;
    end;
    if edtHGSDosyaYolu.Text = '-' then
      exit;
    if not DirectoryExists(edtHGSDosyaYolu.Text) then
      CreateDir(edtHGSDosyaYolu.Text);
  except
    AddLog('Dosya yolu seçilemedi!');
  end;
end;

procedure TfrmMain.btnHGSEditWitelistClick(Sender: TObject);
var
  Arac: THGSArac;
  iErr, i, cnt, InxNm: Integer;
  CardID: String;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  lblIndexNo.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtHGSCardID.Text;
    if (IsHex(CardID) and (Length(CardID) = 16)) then
    begin
      Arac.CardID := CardID;
      Arac.Name := Copy(edtHGSAdi.Text, 1, 18);
      Arac.TimeAccessMask[0] := edtHGSZK1.Value;
      Arac.TimeAccessMask[1] := edtHGSZK2.Value;
      Arac.TimeAccessMask[2] := edtHGSZK3.Value;
      Arac.TimeAccessMask[3] := edtHGSZK4.Value;
      Arac.TimeAccessMask[4] := edtHGSZK5.Value;
      Arac.TimeAccessMask[5] := edtHGSZK6.Value;
      Arac.TimeAccessMask[6] := edtHGSZK7.Value;
      Arac.Daire := edtHGSDaireNo.Value;
      Arac.AracNo := edtHGSAracNo.Value;
      Arac.EndDate := edtHGSKartSonTarih.Date;
      Arac.AccessDevice := cbHGSEnabled.Checked;
      Arac.APBEnabled := cbHGSAPBEnabled.Checked;
      Arac.ATCEnabled := cbHGSZKEnabled.Checked;
      iErr := Rdr.EditHGSWhitelistWithCardID(Arac, InxNm);
      case iErr of
        0:
          Begin
            AddLog('Araç deðiþtirildi.');
            lblHGSIndexNo.Caption := IntToStr(InxNm);
          End;
        1:
          AddLog('Daha önce eklenmiþ.');
        20:
          AddLog('Araç kapasitesi aþýldý.');
        52:
          AddLog('Bu Araç-Daire daha önce tanýmlanmýþ.');
      else
        AddLog('Araç deðiþtirilemedi!');
      end;
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnHGSFindWitelistClick(Sender: TObject);
var
  Arac: THGSArac;
  iErr, i, cnt, InxNm: Integer;
  CardID: String;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  lblHGSIndexNo.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtHGSCardID.Text;
    if (IsHex(CardID) and (Length(CardID) = 16)) then
    begin
      iErr := Rdr.GetHGSWhitelistWithCardID(CardID, Arac, InxNm);
      if (iErr = 0) Then
      Begin
        edtHGSAdi.Text := Trim(Arac.Name);
        edtHGSZK1.Value := Arac.TimeAccessMask[0];
        edtHGSZK2.Value := Arac.TimeAccessMask[1];
        edtHGSZK3.Value := Arac.TimeAccessMask[2];
        edtHGSZK4.Value := Arac.TimeAccessMask[3];
        edtHGSZK5.Value := Arac.TimeAccessMask[4];
        edtHGSZK6.Value := Arac.TimeAccessMask[5];
        edtHGSZK7.Value := Arac.TimeAccessMask[6];
        edtHGSDaireNo.Value := Arac.Daire;
        edtHGSAracNo.Value := Arac.AracNo;
        edtHGSKartSonTarih.Date := Arac.EndDate;
        cbHGSEnabled.Checked := Arac.AccessDevice;
        cbHGSAPBEnabled.Checked := Arac.APBEnabled;
        cbHGSZKEnabled.Checked := Arac.ATCEnabled;
        lblHGSIndexNo.Caption := IntToStr(InxNm);
        AddLog('Araç getirildi.');
      End
      else
        AddLog('Araç getirilemedi.(' + IntToStr(iErr) + ')');
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');

  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnHGSFindWitelistDAClick(Sender: TObject);
var
  Arac: THGSArac;
  iErr, i, cnt, InxNm: Integer;
  CardID: String;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  lblHGSIndexNo.Caption := '-1';
  if Rdr.Connected then
  Begin
    if ( (edtHGSDaireNo.Value <> 0 ) and (edtHGSAracNo.Value <> 0) ) then
    begin
      iErr := Rdr.GetHGSWhitelistWithDaireArac(edtHGSDaireNo.Value,edtHGSAracNo.Value, Arac, InxNm);
      if (iErr = 0) Then
      Begin
        edtHGSCardID.Text := Arac.CardID;
        edtHGSAdi.Text := Trim(Arac.Name);
        edtHGSZK1.Value := Arac.TimeAccessMask[0];
        edtHGSZK2.Value := Arac.TimeAccessMask[1];
        edtHGSZK3.Value := Arac.TimeAccessMask[2];
        edtHGSZK4.Value := Arac.TimeAccessMask[3];
        edtHGSZK5.Value := Arac.TimeAccessMask[4];
        edtHGSZK6.Value := Arac.TimeAccessMask[5];
        edtHGSZK7.Value := Arac.TimeAccessMask[6];
        edtHGSDaireNo.Value := Arac.Daire;
        edtHGSAracNo.Value := Arac.AracNo;
        edtHGSKartSonTarih.Date := Arac.EndDate;
        cbHGSEnabled.Checked := Arac.AccessDevice;
        cbHGSAPBEnabled.Checked := Arac.APBEnabled;
        cbHGSZKEnabled.Checked := Arac.ATCEnabled;
        lblHGSIndexNo.Caption := IntToStr(InxNm);
        AddLog('Araç getirildi.');
      End
      else
        AddLog('Araç getirilemedi.(' + IntToStr(iErr) + ')');
    end
    else
      AddLog('Uygun Daire Araç girilmemiþ.');

  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnHGSVeriOkuClick(Sender: TObject);
var
  tempRecs: THGSRecords;
  i: Integer;
  strCardId: String;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    mmHGSFile.Lines.clear;
    if Rdr.ReadHGSRecords(seHGSStartFrom.Value, seHGSHowMany.Value, tempRecs) Then
    begin
      mmHGSFile.Lines.Add('Baþlangýç  : ' + DateTimeToStr(now) + ' Baþlangýç : ' +
        IntToStr(seHGSStartFrom.Value) + '  Sayý : ' + IntToStr(seHGSHowMany.Value));
      for i := 0 to tempRecs.Count - 1 do
      begin
        strCardId := tempRecs.raDeviceRecs[i].CardID;
        mmHGSFile.Lines.Add('Card ID: ' + strCardId + ' ' + ' Door No: ' +
          IntToStr(tempRecs.raDeviceRecs[i].DoorNo) + ' ' + ' Rec. Type: ' +
          IntToStr(tempRecs.raDeviceRecs[i].RecordType) + ' ' + ' Time Date: ' +
          DateTimeToStr(tempRecs.raDeviceRecs[i].TimeDate));
      end;
      if edtHGSDosyaYolu.Text = '-' then
        mmHGSFile.Lines.SaveToFile(Format('RecsReaded_%s.txt',
          [FormatDateTime('yyyyMMdd', now)]))
      else
      begin
        if Copy(edtHGSDosyaYolu.Text, Length(edtHGSDosyaYolu.Text), 1) = '\' then
          mmHGSFile.Lines.SaveToFile(edtHGSDosyaYolu.Text +
            Format('RecsReaded_%s.txt', [FormatDateTime('yyyyMMdd', now)]))
        else
          mmHGSFile.Lines.SaveToFile(edtHGSDosyaYolu.Text +
            Format('\RecsReaded_%s.txt', [FormatDateTime('yyyyMMdd', now)]))
      end;
      AddLog('Veriler okundu');
    end
    else
      AddLog('Veriler okunamadý!');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnHGSVeriTransferEtClick(Sender: TObject);
var
  tempRecs: THGSRecords;
  i: Integer;
  strCardId: String;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    mmHGSFile.Lines.clear;
    if Rdr.TransferHGSRecords(tempRecs) Then
    begin
      mmHGSFile.Lines.Add('Baþlangýç  : ' + DateTimeToStr(now));
      for i := 0 to tempRecs.Count - 1 do
      begin
        strCardId := tempRecs.raDeviceRecs[i].CardID;
        mmHGSFile.Lines.Add('Card ID: ' + strCardId + ' ' + 'Door No: ' +
          IntToStr(tempRecs.raDeviceRecs[i].DoorNo) + ' ' + 'Record Type: ' +
          IntToStr(tempRecs.raDeviceRecs[i].RecordType) + ' ' + 'Time Date : ' +
          DateTimeToStr(tempRecs.raDeviceRecs[i].TimeDate));
      end;
      if edtHGSDosyaYolu.Text = '-' then
        mmHGSFile.Lines.SaveToFile(Format('RecsTransfered_%s',
          [FormatDateTime('yyyyMMdd', now)]))
      else
      begin
        if Copy(edtHGSDosyaYolu.Text, Length(edtHGSDosyaYolu.Text), 1) = '\' then
          mmHGSFile.Lines.SaveToFile(edtHGSDosyaYolu.Text +
            Format('RecsTransfered%s.txt', [FormatDateTime('yyyyMMdd', now)]))
        else
          mmHGSFile.Lines.SaveToFile(edtHGSDosyaYolu.Text +
            Format('\RecsTransfered%s.txt', [FormatDateTime('yyyyMMdd', now)]))
      end;
      AddLog('Veriler transfer edildi.');
    end
    else
      AddLog('Veriler transfer edilemedi!');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnIbmOnMsgGonderClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    if rdr.ReaderType = rdr26M then
    Begin
        AddLog('63M için Geçerlidir!');
    End
    else
    Begin
      if Rdr.SetBeepRelayAndInboxMessage(cbIbmHeaderType.ItemIndex,
          edtIbmCaption.Text,edtIbmOnText1.Text,edtIbmOnText2.Text,
          edtIbmX1.Value, edtIbmY1.Value, 0, edtIbmX2.Value, edtIbmY2.Value, 0,
          seIbmOnScreenDuration.Value,
          edtIbmRlOut1.Value, edtIbmRlOut2.Value, edtIbmBuzzerTime.Value,
          ckhIbmOnBlink.Checked,edtIbmKeyPadType.Value) Then
        AddLog('Bilgiler  gönderildi!')
      else
        AddLog('Bilgiler  gönderilemedi!');
    End;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnLoadDFClick(Sender: TObject);
begin
  odDF.InitialDir := GetCurrentDir;
  if odDF.Execute then
  Begin
    mmdf.Items.LoadFromFile(odDF.FileName);
    //mmdf.Lines.LoadFromFile(odDF.FileName);
  End
  else
    ShowMessage('Dosya Seçilmedi.');
end;

procedure TfrmMain.btnLogUDPStartClick(Sender: TObject);
begin
  UDPServer.Active := False;
  UDPServer.DefaultPort := edtLogUDPPortNo.Value;
  UDPServer.Active := True;
end;

procedure TfrmMain.btnMealRightTableClick(Sender: TObject);
begin
  frmMealRightTable := TfrmMealRightTable.create(self);
  try
    frmMealRightTable.ShowModal;
  finally
    frmMealRightTable.Free;
  end;
end;

procedure TfrmMain.btnMealTableClick(Sender: TObject);
begin
  frmMealTable := TfrmMealTable.create(self);
  try
    frmMealTable.ShowModal;
  finally
    frmMealTable.Free;
  end;

end;

procedure TfrmMain.btnOffMsgGonderClick(Sender: TObject);
Var
  LcdScreenMsg: TLcdScreen;
begin
  if Rdr.Connected then
  Begin
    LcdScreenMsg.ID := OffflineMsg[cbOffMsgType.ItemIndex].MsgID;
    LcdScreenMsg.HeaderType := cbOffHeaderType.ItemIndex;
    LcdScreenMsg.Caption := edtOffCaption.Text;
    LcdScreenMsg.Line[0].Text := edtOffText1.Text;
    LcdScreenMsg.Line[1].Text := edtOffText2.Text;
    LcdScreenMsg.Line[2].Text := edtOffText3.Text;
    LcdScreenMsg.Line[3].Text := edtOffText4.Text;
    LcdScreenMsg.Line[4].Text := edtOffText5.Text;
    LcdScreenMsg.Line[0].X := edtOffX1.Value;
    LcdScreenMsg.Line[1].X := edtOffX2.Value;
    LcdScreenMsg.Line[2].X := edtOffX3.Value;
    LcdScreenMsg.Line[3].X := edtOffX4.Value;
    LcdScreenMsg.Line[4].X := edtOffX5.Value;
    LcdScreenMsg.Line[0].Y := edtOffY1.Value;
    LcdScreenMsg.Line[1].Y := edtOffY2.Value;
    LcdScreenMsg.Line[2].Y := edtOffY3.Value;
    LcdScreenMsg.Line[3].Y := edtOffY4.Value;
    LcdScreenMsg.Line[4].Y := edtOffY5.Value;
    LcdScreenMsg.FooterType := cbOffFooterType.ItemIndex;
    LcdScreenMsg.Footer := edtOffFooter.Text;
    LcdScreenMsg.LineCount := edtOffLineCount.Value;
    LcdScreenMsg.FontType := cbOffFontType.ItemIndex;
    LcdScreenMsg.ScreenDuration := seOffScreenDuration.Value;
    LcdScreenMsg.RL_Time1 := edtOffRlOut1.Value;
    LcdScreenMsg.RL_Time2 := edtOffRlOut2.Value;
    LcdScreenMsg.BZR_time := edtOffBuzzerTime.Value;
    LcdScreenMsg.IsBlink := ckhOffBlink.Checked;

    if Rdr.SetLCDMessages(LcdScreenMsg) then
      AddLog('Bilgiler  gönderildi!')
    else
      AddLog('Bilgiler  gönderilemedi!');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnOnMsgGonderClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    if rdr.ReaderType = rdr26M then
    Begin
      if Rdr.SetBeepRelayAndSecreenMessage(
       edtOnText1.Text,edtOnText2.Text,seOnScreenDuration.Value,edtRlOut1.Value,
       edtBuzzerTime.Value,ckhOnBlink.Checked)  Then
        AddLog('Bilgiler  gönderildi!')
      else
        AddLog('Bilgiler  gönderilemedi!');
    End
    else
    Begin
      if Rdr.SetBeepRelayAndSecreenMessage(cbHeaderType.ItemIndex,
        cbFooterType.ItemIndex, edtCaption.Text, edtOnText1.Text, edtOnText2.Text,
        edtOnText3.Text, edtOnText4.Text, edtOnText5.Text, edtFooter.Text,
        edtX1.Value, edtY1.Value, 0, edtX2.Value, edtY2.Value, 0, edtX3.Value,
        edtY3.Value, 0, edtX4.Value, edtY4.Value, 0, edtX5.Value, edtY5.Value, 0,
        edtLineCount.Value, cbOnFontType.ItemIndex, seOnScreenDuration.Value,
        edtRlOut1.Value, edtRlOut2.Value, edtBuzzerTime.Value,
        ckhOnBlink.Checked) Then
        AddLog('Bilgiler  gönderildi!')
      else
        AddLog('Bilgiler  gönderilemedi!');

    End;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnOutOfServicelTableClick(Sender: TObject);
begin
  frmOutOfServiceTable := TfrmOutOfServiceTable.create(self);
  try
    frmOutOfServiceTable.ShowModal;
  finally
    frmOutOfServiceTable.Free;
  end;
end;

procedure TfrmMain.btnPriceListTableClick(Sender: TObject);
begin
  frmPriceListTable := TfrmPriceListTable.create(self);
  try
    frmPriceListTable.ShowModal;
  finally
    frmPriceListTable.Free;
  end;

end;

procedure TfrmMain.btnRebootClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    try
      btnReboot.Enabled := False;
      Rdr.Reboot;
      Rdr.DisConnect;
      Sleep(100);
      Rdr.Connect;
    finally
      btnReboot.Enabled := True;
    end;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSaveDFClick(Sender: TObject);
begin
  sdDF.InitialDir := GetCurrentDir;
  if sdDF.Execute then
  Begin
    mmdf.Items.SaveToFile(sdDF.FileName);
    //mmdf.Lines.SaveToFile(sdDF.FileName);
  End
  else
    ShowMessage('Dosya Seçilmedi.');
end;

procedure TfrmMain.btnSerialTestClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    rdr.SerialTestFunction;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetAPBSettingsClick(Sender: TObject);
Var
  Settings: TAPBSettings;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    Settings.APBType := cbAPBType.ItemIndex;
    Settings.SequentialTransitionTime := seAPBDuration.Value;
    Settings.SecurityZone := seSecurityZoneNo.Value;
    if rbAPBGiris.Checked then
      Settings.ApbInOut := 0
    else
      Settings.ApbInOut := 1;
    if Rdr.SetAntiPassbackSettings(Settings) then
      AddLog('APB Ayarlarý gönderildi.')
    else
      AddLog('APB Ayarlarý gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetAppgeneralSettingsClick(Sender: TObject);
var
  Settings: TAccessGeneralSettings;
begin
  if Rdr.Connected then
  Begin
    Settings.AccessMode.AccessType := cbAccessType.ItemIndex;
    Settings.AccessMode.PasswordType := cbAccessPwdType.ItemIndex;
    Settings.InputSettings.InputType := cbInputType.ItemIndex;
    Settings.InputSettings.InputDurationTimeout := seInputDuration.Value;
    Settings.TimeAccessConstraintEnabled := cbATC.Checked;
    if Rdr.SetAppGeneralSettings(Settings) then
      AddLog('Uygulama genel bilgileri gönderildi.')
    else
      AddLog('Uygulama genel bilgileri gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetBellSettingsClick(Sender: TObject);
Var
  Settings: TBellSettings;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS fw ile çalýþýr.');
    abort;
  End;
  if Rdr.Connected then
  Begin
    Settings.Enabled := cbBellEnabled.Checked;
    Settings.ScreenText1 := edtBellTxt1.Text;
    Settings.ScreenText2 := edtBellTxt2.Text;
    if rbBellTrOut1.Checked then
      Settings.OutType := 1
    else if rbBellTrOut2.Checked then
      Settings.OutType := 2;
    if Rdr.SetBellSettings(Settings) then
      AddLog('Zil Çaldýrma bilgileri gönderildi.')
    else
      AddLog('Zil Çaldýrma bilgileri gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetDateTimeClick(Sender: TObject);
Var
  DT: TDateTime;
begin
  if Rdr.Connected then
  Begin
    DT := DateOf(edtDate.Date) + TimeOf(edtTime.time);
    if Rdr.SetDateTime(DT) then
      AddLog('Tarih saat bilgisi gönderildi.')
    else
      AddLog('Tarih saat bilgisi gönderilemedi!');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetDeviceFactoryDefaultsClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    try
      btnSetDeviceFactoryDefaults.Enabled := False;
      if cdSaveIPAddr.Checked then
        Rdr.SetDeviceFactoryDefault(False)
      else
        Rdr.SetDeviceFactoryDefault(True);
      Rdr.DisConnect;
      Sleep(100);
      Rdr.Connect;
    finally
      btnSetDeviceFactoryDefaults.Enabled := True;
    end;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetDeviceGeneralSettingsClick(Sender: TObject);
Var
  rSettings: TGeneralDeviceSettings;
begin
  if Rdr.Connected then
  Begin
    rSettings.DevNo := edtDeviceNo.Value;
    if rbText.Checked then
      rSettings.IdleScreenType := stText
    else
      rSettings.IdleScreenType := stLogo;
    rSettings.DefaultScreenTxt1 := edtText1.Text;
    rSettings.DefaultScreenTxt2 := edtText2.Text;
    rSettings.Backlight := edtBacklight.Value;
    rSettings.Contrast := edtContrast.Value;
    if rbNrOpen1.Checked then
      rSettings.TrOut1Type := NrOpen
    else
      rSettings.TrOut1Type := NrClosed;
    if rbNrOpen2.Checked then
      rSettings.TrOut2Type := NrOpen
    else
      rSettings.TrOut2Type := NrClosed;
    rSettings.DailyRebootEnb := cbDayRebootEnabled.Checked;
    rSettings.RebootTime := dtpRebootTime.time;
    rSettings.CardReadBeepTime := edtCardReadBeepTime.Value;
    rSettings.CardReadTimeOut := edtCardReadTimeOut.Value;
    rSettings.VariableClearTimeout := edtVariableClearTimeout.Value;
    rSettings.DefaultScreenFontType:= cbDefSecreenMsgFontType.ItemIndex;
    rSettings.CardReadDelay := edtCardReadDelay.Value;
    if Rdr.SetDeviceGeneralSettings(rSettings) then
      AddLog('Cihaz genel bilgileri gönderildi..')
    else
      AddLog('Cihaz genel bilgileri gönderilemedi..');

  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetDeviceKeyClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    if Rdr.SetDeviceLoginKey(edtDeviceKey.Text) then
    Begin
      AddLog('Haberleþme þifresi gönderildi.');
    End
    else
      AddLog('Haberleþme þifresi gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnSetDeviceStatusClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    if Rdr.SetDeviceStatus(rbDeviceEnabled.Checked) then
      AddLog('Cihaz durumu gönderildi.')
    else
      AddLog('Cihaz durumu gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetEksOtherSettingsClick(Sender: TObject);
Var
  EksOtherSettings: TEksOtherSettings;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS fw ile çalýþýr.');
    abort;
  End;
  if Rdr.Connected then
  Begin
    EksOtherSettings.PersDataCardSector := edtPersData.Value;
    EksOtherSettings.AccessDataCardSector := edtAccessData.Value;
    if Rdr.SetEksOtherSettings(EksOtherSettings) then
      AddLog('Eks Diðer Bilgileri gönderildi.')
    else
      AddLog('Eks Diðer Bilgileri gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetHeadClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    if Rdr.SetHeadTail(edtHead.Value, edtTail.Value) then
    Begin
      AddLog('Head -Tail Bilgisi Gönderildi.');
    End
    else
      AddLog('Head -Tail Bilgisi Gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetKeylistClick(Sender: TObject);
Var
  KeyList: TMfrKeyListStr;
  i: Integer;
begin
  if Rdr.Connected then
  Begin
    for I := 0 to 15 do
    Begin
      KeyList.Sector[i].KeyA := grdMfrKeyList.Cells[1, i + 1];
      KeyList.Sector[i].KeyB := grdMfrKeyList.Cells[2, i + 1];
    End;

    if Rdr.SetMfrKeyList(KeyList) then
    Begin
      AddLog('Mifare Key Listesi gönderildi.');
    End
    else
      AddLog('Mifare Key Listesi gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnSetMacAddressClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    if Rdr.SetMACAddress(edtMacAddress.Text) then
    Begin
      AddLog('Mac adresi gönderildi.');
    End
    else
      AddLog('Mac adresi gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetOutOfServiceSettingsClick(Sender: TObject);
Var
  Settings: TOutOfServiceSettings;
begin
  if Rdr.Connected then
  Begin
    Settings.Enabled := cbOutOfServiceSettings.Checked;
    Settings.ScreenText1 := edtOutOfServiceTxt1.Text;
    Settings.ScreenText2 := edtOutOfServiceTxt2.Text;
    if rbOOSTrOut1.Checked then
      Settings.OutType := 1
    else if rbOOSTrOut2.Checked then
      Settings.OutType := 2
    else
      Settings.OutType := 0;
    if Rdr.SetOutOfServiceSettings(Settings) then
      AddLog('Uygulama genel bilgileri gönderildi.')
    else
      AddLog('Uygulama genel bilgileri gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetSerailPortBdSetClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    if rdr.SetSerialPortSettings(cbSerialAppType.ItemIndex,cbSerailBaudrate0.ItemIndex,cbSerailBaudrate1.ItemIndex) then
      AddLog('Seri Port Baudrate ayarlarý gönderildi.')
    else
      AddLog('Seri Port Baudrate ayarlarý gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetSerialNumberClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    if Rdr.SetSerialNumber(edtSerialNumber.Text) then
    Begin
      AddLog('Cihaz Seri Numarasý gönderildi.');
    End
    else
      AddLog('Cihaz Seri Numarasý gönderilemedi.');

  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetTCPSettingsClick(Sender: TObject);
Var
  rSettings: TTCPSettings;
begin
  if Rdr.Connected then
  Begin
    case cbProtocol.ItemIndex of
      0:
        rSettings.ProtocolType := PR0;
      1:
        rSettings.ProtocolType := PR1;
      2:
        rSettings.ProtocolType := PR2;
      3:
        rSettings.ProtocolType := PR3;
    end;
    rSettings.IPAdress := edtIpAddress.Text;
    rSettings.NetMask := edtSubnetMask.Text;
    rSettings.DefGetway := edtDefaultGateway.Text;
    rSettings.PriDNS := edtPrimaryDNS.Text;
    rSettings.SecDNS := edtSecondaryDNS.Text;
    rSettings.Port := edtPortNo.Value;
    rSettings.RemIpAdress := edtServerIPAddress.Text;
    rSettings.ConnectOnlyRemIpAdress := cbConnOnlyServer.Checked;
    rSettings.DHCP := cbDhcpEnable.Checked;
    rSettings.ServerEchoTimeOut := edtServerEchoTimeOut.Value;
    if Rdr.SetDeviceTCPSettings(rSettings) then
    Begin
      AddLog('TCP ayarlarý gönderildi.');
    End
    else
      AddLog('TCP ayarlarý gönderilemedi.');
  End;
end;

procedure TfrmMain.btnSetUDPSettingsClick(Sender: TObject);
Var
  rSettings: TUDPSettings;
begin
  if Rdr.Connected then
  Begin
    rSettings.RemUDPAdress := edtUpdServerAddress.Text;
    rSettings.UDPPort := edtUdpPorNo.Value;
    rSettings.UDPIsActive := cbUPDEnable.Checked;
    rSettings.UDPLogIsActive := cbUdpLogEnabled.Checked;
    if Rdr.SetDeviceUDPSettings(rSettings) then
    Begin
      AddLog('UDP ayarlarý gönderildi.');
    End
    else
      AddLog('UDP ayarlarý gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetWebPasswordClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    if Rdr.SetWebPassword(edtWebPassword.Text) Then
      AddLog('Web þifresi gönderildi.')
    else
      AddLog('Web þifresi gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetWorkModeClick(Sender: TObject);
Var
  rSettings: TWorkModeSettings;
begin
  if Rdr.Connected then
  Begin
    if rbOfflineWhiteList.Checked then
      rSettings.WorkingMode := wmOffline
    else if rbOfflineCardBlackList.Checked Then
      rSettings.WorkingMode := wmOfflineCard
    else if rbOnlineTCP.Checked Then
      rSettings.WorkingMode := wmTCPOnline
    else if rbOnlineUDP.Checked then
      rSettings.WorkingMode := wmUDPOnline
    else
      rSettings.WorkingMode := wmTCPOnlineClientMode;

    rSettings.OfflineModePermission := cbOnlineEnabledOffline.Checked;
    rSettings.ServerAnswerTimeOut := edtOnlineTimeOut.Value;
    rSettings.OfflineOnlineMode := TOnlineCardWorkMode(cmbOnlineCardWorkMode.ItemIndex);

    if Rdr.SetDeviceWorkModeSettings(rSettings) then
      AddLog('Cihaz çalýþma modu gönderildi.')
    else
      AddLog('Cihaz çalýþma modu gönderilmedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetYmkSettingsClick(Sender: TObject);
Var
  Settings : TYmkSettings;
begin
  if Rdr.Connected then
  Begin
      Settings.UseMonthlyRight := cbMontlyRight.Checked ;
      Settings.CurrPriceList := edtYmkCurrPriceList.Value ;
      Settings.YmkSectorNo := edtYmkSectorNo.Value;
      Settings.PlantNo := edtYmkPlantNo.Value;
      Settings.OutOfMealstatus := cbbOutOfMealstatus.ItemIndex;
    if rdr.SetYmkSettings(Settings) then
      AddLog('Yemek Ayarlarý gönderildi.')
    else
      AddLog('Yemek Ayarlarý gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnTCTableClick(Sender: TObject);
begin
  frmTimeConstraintTable := TfrmTimeConstraintTable.create(self);
  try
    frmTimeConstraintTable.ShowModal;
  finally
    frmTimeConstraintTable.Free;
  end;
end;

procedure TfrmMain.btnUDPLogClearClick(Sender: TObject);
begin
  mmUDPLog.Lines.clear;
end;

procedure TfrmMain.btnVeriOkuClick(Sender: TObject);
var
  tempRecs: TAccessRecords;
  i: Integer;
  strCardId: String;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    mmFile.Lines.clear;
    if Rdr.ReadRecords(seStartFrom.Value, seHowMany.Value, tempRecs) Then
    begin
      mmFile.Lines.Add('Baþlangýç  : ' + DateTimeToStr(now) + ' Baþlangýç : ' +
        IntToStr(seStartFrom.Value) + '  Sayý : ' + IntToStr(seHowMany.Value));
      for i := 0 to tempRecs.Count - 1 do
      begin
        strCardId := tempRecs.raDeviceRecs[i].CardID;
        mmFile.Lines.Add('Card ID: ' + strCardId + ' ' + ' Door No: ' +
          IntToStr(tempRecs.raDeviceRecs[i].DoorNo) + ' ' + ' Rec. Type: ' +
          IntToStr(tempRecs.raDeviceRecs[i].RecordType) + ' ' + ' RFU[0]: ' +
          IntToStr(tempRecs.raDeviceRecs[i].RFU[0]) + ' ' + ' RFU[1]: ' +
          IntToStr(tempRecs.raDeviceRecs[i].RFU[1]) + ' ' + ' Time Date: ' +
          DateTimeToStr(tempRecs.raDeviceRecs[i].TimeDate));
      end;
      if edtDosyaYolu.Text = '-' then
        mmFile.Lines.SaveToFile(Format('RecsReaded_%s.txt',
          [FormatDateTime('yyyyMMdd', now)]))
      else
      begin
        if Copy(edtDosyaYolu.Text, Length(edtDosyaYolu.Text), 1) = '\' then
          mmFile.Lines.SaveToFile(edtDosyaYolu.Text +
            Format('RecsReaded_%s.txt', [FormatDateTime('yyyyMMdd', now)]))
        else
          mmFile.Lines.SaveToFile(edtDosyaYolu.Text +
            Format('\RecsReaded_%s.txt', [FormatDateTime('yyyyMMdd', now)]))
      end;
      AddLog('Veriler okundu');
    end
    else
      AddLog('Veriler okunamadý!');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnVeriTransferEtClick(Sender: TObject);
var
  tempRecs: TAccessRecords;
  i: Integer;
  strCardId: String;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    mmFile.Lines.clear;
    if Rdr.TransferRecords(tempRecs) Then
    begin
      mmFile.Lines.Add('Baþlangýç  : ' + DateTimeToStr(now));
      for i := 0 to tempRecs.Count - 1 do
      begin
        strCardId := tempRecs.raDeviceRecs[i].CardID;
        mmFile.Lines.Add('Card ID: ' + strCardId + ' ' + 'Door No: ' +
          IntToStr(tempRecs.raDeviceRecs[i].DoorNo) + ' ' + 'Record Type: ' +
          IntToStr(tempRecs.raDeviceRecs[i].RecordType) + ' ' + 'RFU[0]: ' +
          IntToStr(tempRecs.raDeviceRecs[i].RFU[0]) + ' ' + 'RFU[1]: ' +
          IntToStr(tempRecs.raDeviceRecs[i].RFU[1]) + ' ' + 'Time Date : ' +
          DateTimeToStr(tempRecs.raDeviceRecs[i].TimeDate));
      end;
      if edtDosyaYolu.Text = '-' then
        mmFile.Lines.SaveToFile(Format('RecsTransfered_%s',
          [FormatDateTime('yyyyMMdd', now)]))
      else
      begin
        if Copy(edtDosyaYolu.Text, Length(edtDosyaYolu.Text), 1) = '\' then
          mmFile.Lines.SaveToFile(edtDosyaYolu.Text +
            Format('RecsTransfered%s.txt', [FormatDateTime('yyyyMMdd', now)]))
        else
          mmFile.Lines.SaveToFile(edtDosyaYolu.Text +
            Format('\RecsTransfered%s.txt', [FormatDateTime('yyyyMMdd', now)]))
      end;
      AddLog('Veriler transfer edildi.');
    end
    else
      AddLog('Veriler transfer edilemedi!');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnweekDaysClick(Sender: TObject);
begin
  frmWeekDays := TfrmWeekDays.create(self);
  try
    frmWeekDays.ShowModal;
  finally
    frmWeekDays.Free;
  end;
end;

procedure TfrmMain.btnWriteDfPageClick(Sender: TObject);
Var
  HexStr: String;
  i: Integer;
begin
  if Rdr.Connected then
  Begin
    if edDFStartPageNo.Value <= edDFEndPageNo.Value then
    begin
      for I := edDFStartPageNo.Value to edDFEndPageNo.Value do
      Begin
        HexStr := Trim(mmdf.Items[i-edDFStartPageNo.Value]);
        if Rdr.WritePageData(i, HexStr) then
        Begin
          lblCnt.Caption := IntToStr(i);
          //AddLog('Yzaýlan Sayfa (' + IntToStr(i) + ')' );
        End
        else
          AddLog('Sayfa Yazýlamadý. (' + IntToStr(i) + ')');
        Application.ProcessMessages;
      End;
    end
    else
      AddLog('Baþlangýç Page büyük olamaz Okunamadý.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnYmkSetFactoryDefaultClick(Sender: TObject);
Begin
  if Rdr.Connected then
  Begin
    rdr.SetYmkFactoryDefaults(cbYmkRebootEnb.Checked);
    if cbYmkRebootEnb.Checked then
    Begin
      try
        btnYmkSetFactoryDefault.Enabled := False;
        Rdr.DisConnect;
        Sleep(100);
        Rdr.Connect;
      finally
        btnYmkSetFactoryDefault.Enabled := True;
      end;
    End;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnStaticMealRightTableClick(Sender: TObject);
begin
  frmStaticMealRightTable := TfrmStaticMealRightTable.create(self);
  try
    frmStaticMealRightTable.ShowModal;
  finally
    frmStaticMealRightTable.Free;
  end;
end;

procedure TfrmMain.btnMonthlyMealRightTableClick(Sender: TObject);
begin
  frmPersonMealRightList := TfrmPersonMealRightList.create(self);
  try
    frmPersonMealRightList.ShowModal;
  finally
    frmPersonMealRightList.Free;
  end;
end;

procedure TfrmMain.Button11Click(Sender: TObject);
begin
  frmMealNameList := TfrmMealNameList.create(self);
  try
    frmMealNameList.ShowModal;
  finally
    frmMealNameList.Free;
  end;
end;

procedure TfrmMain.Button12Click(Sender: TObject);
begin
  frmPersonCommands := TfrmPersonCommands.create(self);
  try
    frmPersonCommands.ShowModal;
  finally
    frmPersonCommands.Free;
  end;
end;

procedure TfrmMain.Button13Click(Sender: TObject);
Var
  i:Integer;
  DataValue : array [0..15] of byte;
  str : String;
  KeyType : Integer;
begin
  if rbKeyTypeA.Checked then
    KeyType := 0
  else
    KeyType := 1;
  if Rdr.ReadCardBlockData(edtSectorNo.Value,edtBlockNo.Value,KeyType,DataValue) Then
  Begin
    str := '';
    for I := 0 to 15 do
    Begin
      if str ='' then
        str := IntToStr(DataValue[i] )
      else
        str := str +'-'+IntToStr(DataValue[i] );
    End;
    AddLog('Okunulan Deðer 1 [' + str + '].');
  End else
    AddLog('Kart Okumanamý.');

end;

procedure TfrmMain.Button14Click(Sender: TObject);
Var
  i:Integer;
  DataValue : array [0..15] of byte;
  str : String;
  KeyType : Integer;
begin
  if rbKeyTypeA.Checked then
    KeyType := 0
  else
    KeyType := 1;
  ToPrBytesFromHex(edtMfrBlockData.Text,DataValue);
  if Rdr.WriteCardBlockData(edtSectorNo.Value,edtBlockNo.Value,KeyType,DataValue) then
     AddLog('Data Yazýldý.')
  else
     AddLog('Data Yazýlamadý.');
end;

procedure TfrmMain.Button15Click(Sender: TObject);
begin
  Rdr.SetBeepRelayAndSecreenMessage(0, 0, '', 'Online ', 'Test', '', '', '', '',
    5, 15, 0, 5, 35, 0, edtX3.Value, edtY3.Value, 0, edtX4.Value, edtY4.Value,
    0, edtX5.Value, edtY5.Value, 0, 2, 2, 5, 5, 0, 10, False);
end;

procedure TfrmMain.btnGetNodeClick(Sender: TObject);
Var
  Node : Ttree_Node;
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetTreeNode(edtAddress.Value,Node) then
    Begin
      edtAddress.Value:=Node.Adress;
      edtValue.Text :=prBytesToHex(Node.Value,0,7);
      edtColor.Value := Node.Color;
      edtLeft.Value := Node.Left;
      edtRight.Value := Node.Right;
      edtParent.Value := Node.Parent;
      ShowMessage('Baþarýlý');
    end
    else
      ShowMessage('Hatalý');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetNodeClick(Sender: TObject);
Var
  Node : Ttree_Node;
begin
  if Rdr.Connected then
  Begin
    Node.Adress := edtAddress.Value;;
    ToPrBytesFromHex(edtValue.Text,Node.Value);
    Node.Color := edtColor.Value;
    Node.Left := edtLeft.Value;
    Node.Right := edtRight.Value;
    Node.Parent := edtParent.Value;
    if Rdr.SetTreeNode(Node) then
      ShowMessage('Baþarýlý')
    else
      ShowMessage('Hatalý');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.Button1Click(Sender: TObject);
Var
  WhiteListStatus:TWhiteListStatus;
begin
  if Rdr.Connected then
  Begin
      if Rdr.GetWhitelisStatus(WhiteListStatus)then
      Begin

        AddLog('WhiteListStatus.PersCnt : ' + IntToStr(WhiteListStatus.PersCnt));
        AddLog('WhiteListStatus.rb_ins_tree_root : ' + IntToStr(WhiteListStatus.rb_ins_tree_root));
        AddLog('WhiteListStatus.rb_Del_tree_root : ' + IntToStr(WhiteListStatus.rb_Del_tree_root));

        //AddLog('WhiteListStatus.Perscnt_Psw : ' + IntToStr(WhiteListStatus.Perscnt_Psw));
        //AddLog('WhiteListStatus.rb_ins_tree_Psw_root : ' + IntToStr(WhiteListStatus.rb_ins_tree_Psw_root));
        //AddLog('WhiteListStatus.rb_Del_tree_Psw_root: ' + IntToStr(WhiteListStatus.rb_Del_tree_Psw_root));

        AddLog('WhiteListStatus.InsNode.Adress : ' + IntToStr(WhiteListStatus.InsNode.Adress));
        AddLog('WhiteListStatus.InsNode.Value[0] : ' + IntToStr(WhiteListStatus.InsNode.Value[0]));
        AddLog('WhiteListStatus.InsNode.Value[1] : ' + IntToStr(WhiteListStatus.InsNode.Value[1]));
        AddLog('WhiteListStatus.InsNode.Value[2] : ' + IntToStr(WhiteListStatus.InsNode.Value[2]));
        AddLog('WhiteListStatus.InsNode.Value[3] : ' + IntToStr(WhiteListStatus.InsNode.Value[3]));
        AddLog('WhiteListStatus.InsNode.Value[4] : ' + IntToStr(WhiteListStatus.InsNode.Value[4]));
        AddLog('WhiteListStatus.InsNode.Value[5] : ' + IntToStr(WhiteListStatus.InsNode.Value[5]));
        AddLog('WhiteListStatus.InsNode.Value[6] : ' + IntToStr(WhiteListStatus.InsNode.Value[6]));
        AddLog('WhiteListStatus.InsNode.Color : ' + IntToStr(WhiteListStatus.InsNode.Color));

        AddLog('WhiteListStatus.InsNode.Left : ' + IntToStr(WhiteListStatus.InsNode.Left));
        AddLog('WhiteListStatus.InsNode.Right : ' + IntToStr(WhiteListStatus.InsNode.Right));
        AddLog('WhiteListStatus.InsNode.Parent : ' + IntToStr(WhiteListStatus.InsNode.Parent));

//        Rdr2.IP := '192.168.0.124';
//        Rdr2.Port := edtConnectPortNo.Text;
//        Rdr2.TimeOut := edtConnectTimeOut.Value;
//        Rdr2.DeviceLoginKey := edtConnectKey.Text;
//        Rdr2.CommandRetry := edtConnectCmdRtry.Value;
//        Rdr2.AutoConnect := cbConnectAutoConnect.Checked;
//        Rdr2.AutoRxEnabled := cbConnectAutoRxEnabled.Checked;
//        Rdr2.Connect;
        //if Rdr2.Connected then
        //begin
        //  Rdr2.SetWhitelisStatus(WhiteListStatus);
        //End;

      End;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.Button2Click(Sender: TObject);
Var
  WhiteListStatus:TWhiteListStatus;
begin
  if Rdr.Connected then
  Begin
    WhiteListStatus.PersCnt := 8946;
    WhiteListStatus.rb_ins_tree_root := 10;
    WhiteListStatus.rb_Del_tree_root := 0;
    //WhiteListStatus.Perscnt_Psw := 0;
    //WhiteListStatus.rb_ins_tree_Psw_root := 0;
    //WhiteListStatus.rb_Del_tree_Psw_root := 0;
    WhiteListStatus.InsNode.Adress := 10;
    WhiteListStatus.InsNode.Value[0] := 4;
    WhiteListStatus.InsNode.Value[1] := 90;
    WhiteListStatus.InsNode.Value[2] := 109;
    WhiteListStatus.InsNode.Value[3] := 74;
    WhiteListStatus.InsNode.Value[4] := 126;
    WhiteListStatus.InsNode.Value[5] := 38;
    WhiteListStatus.InsNode.Value[6] := 128;
    WhiteListStatus.InsNode.Color := 1;
    WhiteListStatus.InsNode.Left := 21;
    WhiteListStatus.InsNode.Right := 26;
    WhiteListStatus.InsNode.Parent := 0;

    WhiteListStatus.DelNode.Adress := 0;
    WhiteListStatus.DelNode.Value[0] := 0;
    WhiteListStatus.DelNode.Value[1] := 0;
    WhiteListStatus.DelNode.Value[2] := 0;
    WhiteListStatus.DelNode.Value[3] := 0;
    WhiteListStatus.DelNode.Value[4] := 0;
    WhiteListStatus.DelNode.Value[5] := 0;
    WhiteListStatus.DelNode.Value[6] := 0;
    WhiteListStatus.DelNode.Color := 0;
    WhiteListStatus.DelNode.Left := 0;
    WhiteListStatus.DelNode.Right := 0;
    WhiteListStatus.DelNode.Parent := 0;
    if Rdr.SetWhitelisStatus(WhiteListStatus) then
      AddLog('Whitelist Bilgileri Aktarýldý.')
    else
      AddLog('iþlem sýrasýnda hata Bilgiler Aktarýlamadý.')
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    Rdr.SetTumAralarDisarda;
    //if cnt <> -1 Then
    //  lblHGSTanimliKisi.Caption := 'Tanýmlý Kiþi Sayýsý : ' + IntToStr(cnt)
    //else
    //  lblHGSTanimliKisi.Caption := 'Kiþi sayýsý getirilemedi.';
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  frmPersonMealSettings := TfrmPersonMealSettings.create(self);
  try
    frmPersonMealSettings.ShowModal;
  finally
    frmPersonMealSettings.Free;
  end;
end;

procedure TfrmMain.Button6Click(Sender: TObject);
Var
  Person: TBlackList;
  iErr, InxNm: Integer;
  CardID: String;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS ve YMK fw ile çalýþýr.');
    abort;
  End;

  lblIndexNoBlack.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtCardIdBlack.Text;
    if (IsHex(CardID) and (Length(CardID) = 14)) then
    begin
      Person.CardID := CardID;
      Person.Caption := Copy(edtBlackListCaption.Text, 1, 18);
      //
//      Person.ContorModeEnable := cbContorEnable.Checked;
//      Person.MealRightWorkMode := cmbMealRightMode.ItemIndex;
//      Person.MealRightListNo := edtMealHakListNo.Value;
//      Person.PriceGroup := edtMealPriceGroup.Value;
//      Person.ReReadPriceGroup := edtMealReReadPriceGroup.Value;
//      Person.ReReadType := cmbReReadType.ItemIndex;
//      Person.ReReadCount := edtReReadCount.Value;
      Person.BlackListCmdNo := edtBlackListCmdNo.Value;
      iErr := Rdr.AddBlacklist(Person, InxNm);
      case iErr of
        0:
          Begin
            AddLog('Kiþi eklendi.');
            lblIndexNoBlack.Caption := IntToStr(InxNm);
          End;
        1:
          AddLog('Daha önce eklenmiþ.');
        20:
          AddLog('Þifre kapasitesi aþýldý.');
        51:
          AddLog('Bu Kart ID daha önce tanýmlanmýþ.');
        52:
          AddLog('Bu þifre daha önce tanýmlanmýþ.');
      else
        AddLog('Kiþi eklenemedi!');
      end;
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.Button7Click(Sender: TObject);
var
  Person: TBlackList;
  iErr, i, cnt, InxNm: Integer;
  CardID: String;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS ve YMK fw ile çalýþýr.');
    abort;
  End;

  lblIndexNoBlack.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtCardIdBlack.Text;
    if (IsHex(CardID) and (Length(CardID) = 14)) then
    begin
      Person.CardID := CardID;
      Person.Caption := Copy(edtBlackListCaption.Text, 1, 18);
      Person.BlackListCmdNo := edtBlackListCmdNo.Value;

      iErr := Rdr.EditBlacklistWithCardID(Person, InxNm);
      case iErr of
        0:
          Begin
            AddLog('Kiþi deðiþtirildi.');
            lblIndexNoBlack.Caption := IntToStr(InxNm);
          End;
        1:
          AddLog('Daha önce eklenmiþ.');
        20:
          AddLog('Þifre kapasitesi aþýldý.');
        52:
          AddLog('Bu þifre daha önce tanýmlanmýþ.');
      else
        AddLog('Kiþi deðiþtirilemedi!');
      end;
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.Button8Click(Sender: TObject);
Var
  CardID: String;
  InxNm: Integer;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS ve YMK fw ile çalýþýr.');
    abort;
  End;

  lblIndexNoBlack.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtCardIdBlack.Text;
    if (IsHex(CardID) and (Length(CardID) = 14)) then
    begin
      if Rdr.DeleteBlacklistWithCardID(CardID, InxNm) = 0 Then
      Begin
        AddLog('Kiþi silindi.');
        lblIndexNoBlack.Caption := IntToStr(InxNm);
      End
      else
        AddLog('Kiþi silinemedi.');
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.Button9Click(Sender: TObject);
var
  Person: TBlackList;
  iErr, i, cnt, InxNm: Integer;
  CardID: String;
begin
  if not (rdr.fwAppType in [fwPDKS,fwYMK]) then
  Begin
    ShowMessage('Sadece PDKS fw ile çalýþýr.');
    abort;
  End;

  lblIndexNoBlack.Caption := '-1';
  if Rdr.Connected then
  Begin
    CardID := edtCardIdBlack.Text;
    if (IsHex(CardID) and (Length(CardID) = 14)) then
    begin
      iErr := Rdr.GetBlacklistWithCardID(CardID, Person, InxNm);
      if (iErr = 0) Then
      Begin
        edtBlackListCaption.Text := Trim(Person.Caption);
        edtBlackListCmdNo.Value := Person.BlackListCmdNo;
        lblIndexNoBlack.Caption := IntToStr(InxNm);
        AddLog('Kiþi getirildi.');
      End
      else
        AddLog('Kiþi getirilemedi.(' + IntToStr(iErr) + ')');
    end
    else
      AddLog('Uygun Kart ID girilmemiþ.');

  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnHgsCardIDCntClick(Sender: TObject);
Var
  cnt: Integer;
begin
  if (rdr.fwAppType <> fwHGS) then
  Begin
    ShowMessage('Sadece HGS fw ile çalýþýr.');
    abort;
  End;

  if Rdr.Connected then
  Begin
    cnt := Rdr.GetWhitelistCardIDCount;
    if cnt <> -1 Then
      lblHGSTanimliKisi.Caption := 'Tanýmlý Kiþi Sayýsý : ' + IntToStr(cnt)
    else
      lblHGSTanimliKisi.Caption := 'Kiþi sayýsý getirilemedi.';
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetAppFactoryDefaultsClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    rdr.SetAppFactoryDefault(cbSetAppDefReboot.Checked);
    if cbSetAppDefReboot.Checked then
    Begin
      try
        btnSetAppFactoryDefaults.Enabled := False;
        Rdr.DisConnect;
        Sleep(100);
        Rdr.Connect;
      finally
        btnSetAppFactoryDefaults.Enabled := True;
      end;
    End;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetAppFactoryDefaultsHgsClick(Sender: TObject);
begin
  if Rdr.Connected then
  Begin
    rdr.SetAppFactoryDefault(cbSetAppDefRebootHgs.Checked);
    if cbSetAppDefRebootHgs.Checked then
    Begin
      try
        btnSetAppFactoryDefaultsHgs.Enabled := False;
        Rdr.DisConnect;
        Sleep(100);
        Rdr.Connect;
      finally
        btnSetAppFactoryDefaultsHgs.Enabled := True;
      end;
    End;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnTestRecordClick(Sender: TObject);
Var
  i,Cnt:Integer;
begin
  if Rdr.Connected then
  Begin
    cnt := seTestRecCnt.Value;
    for I := 0 to cnt-1 do
    Begin
      rdr.TestCreateRecordFunction;
      Sleep(10);
      lblTestRecCnt.Caption := IntToStr(i+1);
      Application.ProcessMessages;
    End;
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnReadDfPageClick(Sender: TObject);
Var
  HexStr: String;
  i: Integer;
begin
  if Rdr.Connected then
  Begin
    if edDFStartPageNo.Value <= edDFEndPageNo.Value then
    begin
      mmdf.Items.clear;
      for I := edDFStartPageNo.Value to edDFEndPageNo.Value do
      Begin
        if Rdr.ReadPageData(i, HexStr) then
        Begin
          mmdf.Items.Add(HexStr);
        End
        else
          AddLog('Okunamadý. (' + IntToStr(i) + ')');

        lblCnt.Caption := IntToStr(i);
        Application.ProcessMessages;
      End;
      Application.ProcessMessages;
    end
    else
      AddLog('Baþlangýç Page büyük olamaz Okunamadý.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnGetTCPClientSettingsClick(Sender: TObject);
Var
  rSettings: TClientTCPSettings;
begin
  if Rdr.Connected then
  Begin
    if Rdr.GetDeviceClientTCPSettings(rSettings) then
    Begin
      edtTCPClientAddress.Text := rSettings.IPAdress;
      edTCPClientPort.Value := rSettings.Port;
      AddLog('TCP Client Ayarlarý getirildi.');
    End
    else
      AddLog('TCP Client Ayarlarý getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');

end;

procedure TfrmMain.btnSetTCPClientSettingsClick(Sender: TObject);
Var
  rSettings: TClientTCPSettings;
begin
  if Rdr.Connected then
  Begin
    rSettings.IPAdress := edtTCPClientAddress.Text;
    rSettings.Port := edTCPClientPort.Value;
    if Rdr.SetDeviceClientTCPSettings(rSettings) then
    Begin
      AddLog('TCP Client ayarlarý gönderildi.');
    End
    else
      AddLog('TCP Client ayarlarý gönderilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
end;

procedure TfrmMain.btnSetFactoryKeyClick(Sender: TObject);
Var
  i: Integer;
begin
  for I := 1 to 16 do
  Begin
    grdMfrKeyList.Cells[1, i] := 'FFFFFFFFFFFF';
    grdMfrKeyList.Cells[2, i] := 'FFFFFFFFFFFF';
  End;
end;

procedure TfrmMain.cbAPBTypeChange(Sender: TObject);
begin
  case cbAPBType.ItemIndex of
    0:
      Begin
        lblAPBDuration.Visible := False;
        seAPBDuration.Visible := False;
        lblSecurityZoneNo.Visible := False;
        seSecurityZoneNo.Visible := False;
        rbAPBGiris.Visible := False;
        rbAPBCikis.Visible := False;
        lblAPBdk.Visible := False;
      End;
    1:
      Begin
        lblAPBDuration.Visible := False;
        seAPBDuration.Visible := False;
        lblSecurityZoneNo.Visible := True;
        seSecurityZoneNo.Visible := True;
        rbAPBGiris.Visible := True;
        rbAPBCikis.Visible := True;
        lblAPBdk.Visible := False;
      End;
    2:
      Begin
        lblAPBDuration.Visible := True;
        seAPBDuration.Visible := True;
        lblSecurityZoneNo.Visible := True;
        seSecurityZoneNo.Visible := True;
        rbAPBGiris.Visible := True;
        rbAPBCikis.Visible := True;
        lblAPBdk.Visible := True;
      End;
    3:
      Begin
        lblAPBDuration.Visible := True;
        seAPBDuration.Visible := True;
        lblSecurityZoneNo.Visible := True;
        seSecurityZoneNo.Visible := True;
        rbAPBGiris.Visible := True;
        rbAPBCikis.Visible := True;
        lblAPBdk.Visible := True;
      End;
    4:
      Begin
        lblAPBDuration.Visible := True;
        seAPBDuration.Visible := True;
        lblSecurityZoneNo.Visible := True;
        seSecurityZoneNo.Visible := True;
        rbAPBGiris.Visible := True;
        rbAPBCikis.Visible := True;
        lblAPBdk.Visible := True;
      End;
    5:
      Begin
        lblAPBDuration.Visible := True;
        seAPBDuration.Visible := True;
        lblSecurityZoneNo.Visible := True;
        seSecurityZoneNo.Visible := True;
        rbAPBGiris.Visible := True;
        rbAPBCikis.Visible := True;
        lblAPBdk.Visible := True;
      End;

  end;
end;


procedure connectionType();
begin
    case frmMain.cbConnectReaderType.ItemIndex of
      2: begin
        frmMain.cbHeaderType.Enabled := false;
        frmMain.edtCaption.Enabled := false;
        frmMain.edtX1.Enabled := False;
        frmMain.edtX2.Enabled := false;
        frmMain.edtX3.Enabled := false;
        frmMain.edtX4.Enabled := false;
        frmMain.edtX5.Enabled := false;
        frmMain.edtY1.Enabled := false;
        frmMain.edtY2.Enabled := false;
        frmMain.edtY3.Enabled := false;
        frmMain.edtY4.Enabled := false;
        frmMain.edtY5.Enabled := false;
        frmMain.edtOnText3.Enabled := false;
        frmMain.edtOnText4.Enabled := False;
        frmMain.edtOnText5.Enabled := False;
        frmMain.cbFooterType.Enabled := False;
        frmMain.edtFooter.Enabled := False;
        frmMain.edtLineCount.Enabled := False;
        frmMain.cbOnFontType.Enabled := false;
        frmMain.edtRlOut2.Enabled := false;
        frmMain.edtOnText1.MaxLength :=16;
        frmMain.edtOnText2.MaxLength :=16;
        frmMain.edtOffText1.MaxLength :=16;
        frmMain.edtOffText2.MaxLength :=16;

        frmMain.edtOffText3.Enabled :=false;
        frmMain.edtOffText4.Enabled :=false;
        frmMain.edtOffText5.Enabled :=false;
        frmMain.edtOffCaption.Enabled :=false;
        frmMain.cbOffHeaderType.Enabled :=false;
        frmMain.cbOffMsgType.Enabled :=True;
        frmMain.edtOffX1.Enabled := false;
        frmMain.edtOffX2.Enabled := False;
        frmMain.edtOffX3.Enabled := False;
        frmMain.edtOffX4.Enabled := False;
        frmMain.edtOffX5.Enabled := false;
        frmMain.edtOffY1.Enabled := false;
        frmMain.edtOffY2.Enabled := false;
        frmMain.edtOffY3.Enabled := false;
        frmMain.edtOffY4.Enabled := false;
        frmMain.edtOffY5.Enabled := false;
        frmMain.cbOffFooterType.Enabled := false;
        frmMain.edtOffFooter.Enabled := false;
        frmMain.edtOffLineCount.Enabled :=False;
        frmMain.cbOffFontType.Enabled := false;
        frmMain.edtOffRlOut2.Enabled := false;


      end;

      0..1 : begin
        frmMain.cbHeaderType.Enabled := True;
        frmMain.edtCaption.Enabled := True;
        frmMain.edtX1.Enabled := True;
        frmMain.edtX2.Enabled := True;
        frmMain.edtX3.Enabled := True;
        frmMain.edtX4.Enabled := True;
        frmMain.edtX5.Enabled := True;
        frmMain.edtY1.Enabled := True;
        frmMain.edtY2.Enabled := True;
        frmMain.edtY3.Enabled := True;
        frmMain.edtY4.Enabled := True;
        frmMain.edtY5.Enabled := True;
        frmMain.edtOnText3.Enabled := True;
        frmMain.edtOnText4.Enabled := True;
        frmMain.edtOnText5.Enabled := True;
        frmMain.cbFooterType.Enabled := True;
        frmMain.edtFooter.Enabled := True;
        frmMain.edtLineCount.Enabled := True;
        frmMain.cbOnFontType.Enabled := True;
        frmMain.edtRlOut2.Enabled := True;
        frmMain.edtOnText1.MaxLength :=20;
        frmMain.edtOnText2.MaxLength :=20;
        frmMain.edtOffText1.MaxLength :=20;
        frmMain.edtOffText2.MaxLength :=20;
        frmMain.edtOffText3.Enabled :=true;
        frmMain.edtOffText4.Enabled :=true;
        frmMain.edtOffText5.Enabled :=true;
        frmMain.edtOffCaption.Enabled :=true;
        frmMain.cbOffHeaderType.Enabled :=true;
        frmMain.cbOffMsgType.Enabled :=true;
        frmMain.edtOffX1.Enabled := true;
        frmMain.edtOffX2.Enabled := true;
        frmMain.edtOffX3.Enabled := true;
        frmMain.edtOffX4.Enabled := true;
        frmMain.edtOffX5.Enabled := true;
        frmMain.edtOffY1.Enabled := true;
        frmMain.edtOffY2.Enabled := true;
        frmMain.edtOffY3.Enabled := true;
        frmMain.edtOffY4.Enabled := true;
        frmMain.edtOffY5.Enabled := true;
        frmMain.cbOffFooterType.Enabled := true;
        frmMain.edtOffFooter.Enabled := true;
        frmMain.edtOffLineCount.Enabled :=true;
        frmMain.cbOffFontType.Enabled := true;
        frmMain.edtOffRlOut2.Enabled := true;
      end;

    end;
end;


procedure TfrmMain.cbConnectReaderTypeChange(Sender: TObject);
begin

connectionType();


end;

procedure TfrmMain.cbDayRebootEnabledClick(Sender: TObject);
begin
  dtpRebootTime.Enabled := cbDayRebootEnabled.Checked;
end;

procedure TfrmMain.cbDtTimerClick(Sender: TObject);
begin
  dtTimer.Enabled := not cbDtTimer.Checked;
  edtDate.Enabled := cbDtTimer.Checked;
  edtTime.Enabled := cbDtTimer.Checked;
end;

procedure TfrmMain.cbFooterTypeChange(Sender: TObject);
begin
  case cbFooterType.ItemIndex of
    0:
      Begin
        edtFooter.Text := '';
        edtFooter.Enabled := False;
      End;
    1:
      Begin
        edtFooter.Enabled := True;
      End;
  end;
end;

procedure TfrmMain.cbHeaderTypeChange(Sender: TObject);
begin
  case cbHeaderType.ItemIndex of
    0:
      Begin
        edtCaption.Text := '';
        edtCaption.Enabled := False;
      End;
    1:
      Begin
        edtCaption.Text := '';
        edtCaption.Enabled := False;
      End;
    2:
      Begin
        edtCaption.Enabled := True;
      End;
  end;

end;

procedure TfrmMain.cbInputTypeChange(Sender: TObject);
begin
  case cbInputType.ItemIndex of
    0:
      Begin
        lblInputDuration.Visible := False;
        seInputDuration.Visible := False;
      End;
    1:
      Begin
        lblInputDuration.Caption := 'Buton Basma Süresi';
        lblInputDuration.Visible := True;
        seInputDuration.Visible := True;
      End;
    2:
      Begin
        lblInputDuration.Caption := 'Turnike dönüþ bekleme Süresi';
        lblInputDuration.Visible := True;
        seInputDuration.Visible := True;
      End;
    3:
      Begin
        lblInputDuration.Caption := 'Kapý açýk kalma bekleme Süresi';
        lblInputDuration.Visible := True;
        seInputDuration.Visible := True;
      End;
  end;
end;

procedure TfrmMain.cbOffFooterTypeChange(Sender: TObject);
begin
  case cbOffFooterType.ItemIndex of
    0:
      Begin
        edtOffFooter.Text := '';
        edtOffFooter.Enabled := False;
      End;
    1:
      Begin
        edtOffFooter.Enabled := True;
      End;
  end;

end;

procedure TfrmMain.cbOffHeaderTypeChange(Sender: TObject);
begin
  case cbOffHeaderType.ItemIndex of
    0:
      Begin
        edtOffCaption.Text := '';
        edtOffCaption.Enabled := False;
      End;
    1:
      Begin
        edtOffCaption.Text := '';
        edtOffCaption.Enabled := False;
      End;
    2:
      Begin
        edtOffCaption.Enabled := True;
      End;
  end;
end;

procedure TfrmMain.cbOffMsgTypeChange(Sender: TObject);
Var
  ID: Integer;
  LcdScreenMsg: TLcdScreen;
begin
  ID := OffflineMsg[cbOffMsgType.ItemIndex].MsgID;
  if Rdr.Connected then
  Begin

    if Rdr.GetLCDMessages(ID, LcdScreenMsg) then
    Begin
      cbOffHeaderType.ItemIndex := LcdScreenMsg.HeaderType;
      edtOffCaption.Text := LcdScreenMsg.Caption;
      edtOffText1.Text := LcdScreenMsg.Line[0].Text;
      edtOffText2.Text := LcdScreenMsg.Line[1].Text;
      edtOffText3.Text := LcdScreenMsg.Line[2].Text;
      edtOffText4.Text := LcdScreenMsg.Line[3].Text;
      edtOffText5.Text := LcdScreenMsg.Line[4].Text;
      edtOffX1.Value := LcdScreenMsg.Line[0].X;
      edtOffX2.Value := LcdScreenMsg.Line[1].X;
      edtOffX3.Value := LcdScreenMsg.Line[2].X;
      edtOffX4.Value := LcdScreenMsg.Line[3].X;
      edtOffX5.Value := LcdScreenMsg.Line[4].X;
      edtOffY1.Value := LcdScreenMsg.Line[0].Y;
      edtOffY2.Value := LcdScreenMsg.Line[1].Y;
      edtOffY3.Value := LcdScreenMsg.Line[2].Y;
      edtOffY4.Value := LcdScreenMsg.Line[3].Y;
      edtOffY5.Value := LcdScreenMsg.Line[4].Y;
      cbOffFooterType.ItemIndex := LcdScreenMsg.FooterType;
      edtOffFooter.Text := LcdScreenMsg.Footer;
      edtOffLineCount.Value := LcdScreenMsg.LineCount;
      cbOffFontType.ItemIndex := LcdScreenMsg.FontType;
      seOffScreenDuration.Value := LcdScreenMsg.ScreenDuration;
      edtOffRlOut1.Value := LcdScreenMsg.RL_Time1;
      edtOffRlOut2.Value := LcdScreenMsg.RL_Time2;
      edtOffBuzzerTime.Value := LcdScreenMsg.BZR_time;
      ckhOffBlink.Checked := LcdScreenMsg.IsBlink;
      cbOffHeaderType.OnChange(self);
      cbOffFooterType.OnChange(self);
      edtOffLineCount.OnChange(self);

      AddLog('Mesaj Kaydý getirildi.');
    End
    else
      AddLog('Mesaj Kaydý getirilemedi.');
  End
  else
    AddLog('Cihaz Baðlantýsý Yok.');
  //
end;

procedure TfrmMain.OfflineMsgLoad;
Var
  i: Integer;
  Msgcnt : Integer;
Begin
  if Rdr.fwAppType = fwHGS Then
  Begin
    Msgcnt := 78;
    SetLength(OffflineMsg,Msgcnt);
    OffflineMsg[0].MsgID := 1;
    OffflineMsg[0].MsgName := 'Açýlýþ Ekraný [1]';
    OffflineMsg[1].MsgID := 2;
    OffflineMsg[1].MsgName := 'Açýlýþ Ekraný [2]';
    OffflineMsg[2].MsgID := 7;
    OffflineMsg[2].MsgName := 'Kart Okuma Ekraný';
    OffflineMsg[3].MsgID := 11;
    OffflineMsg[3].MsgName := 'Geçersiz Kart Ekraný';
    OffflineMsg[4].MsgID := 12;
    OffflineMsg[4].MsgName := 'Kart Okuma Hatasý Ekraný';
    OffflineMsg[5].MsgID := 8;
    OffflineMsg[5].MsgName := 'Þifre Giriþ Ekraný';
    OffflineMsg[6].MsgID := 9;
    OffflineMsg[6].MsgName := 'Geçersiz Þifre Ekraný';
    OffflineMsg[7].MsgID := 10;
    OffflineMsg[7].MsgName := 'Yanlýþ Þifre Ekraný';
    OffflineMsg[8].MsgID := 100;
    OffflineMsg[8].MsgName := 'Ana Menü';
    OffflineMsg[9].MsgID := 101;
    OffflineMsg[9].MsgName := 'Cihaz Ayarlarý Menüsü';
    OffflineMsg[10].MsgID := 110;
    OffflineMsg[10].MsgName := 'Tarih Saat Ayarý Ekraný';
    OffflineMsg[11].MsgID := 13;
    OffflineMsg[11].MsgName := 'Tarhsaat Deðiþtirildi Ekraný';
    OffflineMsg[12].MsgID := 14;
    OffflineMsg[12].MsgName := 'Geçersiz Tarihsaat Ekraný';
    OffflineMsg[13].MsgID := 111;
    OffflineMsg[13].MsgName := 'Að Ayarý Ekraný';
    OffflineMsg[14].MsgID := 112;
    OffflineMsg[14].MsgName := 'Cihaz Aktif/Pasif Ekraný';
    OffflineMsg[15].MsgID := 15;
    OffflineMsg[15].MsgName := 'Cihaz Aktif Duruma Geldi';
    OffflineMsg[16].MsgID := 16;
    OffflineMsg[16].MsgName := 'Cihaz Pasif Duruma Geldi';
    OffflineMsg[17].MsgID := 113;
    OffflineMsg[17].MsgName := 'Gelen Paket Ayarý';
    OffflineMsg[18].MsgID := 17;
    OffflineMsg[18].MsgName := 'Gelen Paket Ayarlarý Kaydedildi Ekraný';
    OffflineMsg[19].MsgID := 114;
    OffflineMsg[19].MsgName := 'Röle Çýkýþ Ayarý Ekraný';
    OffflineMsg[20].MsgID := 18;
    OffflineMsg[20].MsgName := 'Role Çýkýþ Süresi Deðiþtirildi Ekraný';
    OffflineMsg[21].MsgID := 102;
    OffflineMsg[21].MsgName := 'Çalýþma Ayarlarý';
    OffflineMsg[22].MsgID := 120;
    OffflineMsg[22].MsgName := 'Çalýþma Modu Ayarlarý';
    OffflineMsg[23].MsgID := 19;
    OffflineMsg[23].MsgName := 'Çalýþma Modu Deðiþtirildi Ekraný';
    OffflineMsg[24].MsgID := 121;
    OffflineMsg[24].MsgName := 'Þifre Deðiþtirme ekraný';
    OffflineMsg[25].MsgID := 22;
    OffflineMsg[25].MsgName := 'Geçersiz Þifre Ekraný';
    OffflineMsg[26].MsgID := 23;
    OffflineMsg[26].MsgName := 'Þifre Uyþmazlýðý Ekraný';
    OffflineMsg[27].MsgID := 24;
    OffflineMsg[27].MsgName := 'Lütfen Kartýnýzý Okutunuz Ekraný';
    OffflineMsg[28].MsgID := 26;
    OffflineMsg[28].MsgName := 'Kart Yazma Hatasý Ekraný';
    OffflineMsg[29].MsgID := 25;
    OffflineMsg[29].MsgName := 'Þifreniz Kaydedildi';
    OffflineMsg[30].MsgID := 122;
    OffflineMsg[30].MsgName := 'Ardýþýk Tag Okuma Ayar Ekraný';
    OffflineMsg[31].MsgID := 21;
    OffflineMsg[31].MsgName := 'Ardýþýk Okuma Ayarlarý Deðiþtirildi Ekraný';
    OffflineMsg[32].MsgID := 123;
    OffflineMsg[32].MsgName := 'Zaman Kýsýt Tablosu Ekraný';
    OffflineMsg[33].MsgID := 27;
    OffflineMsg[33].MsgName := 'Zaman Kýsýt Tablosu Deðiþtirildi Ekraný';
    OffflineMsg[34].MsgID := 124;
    OffflineMsg[34].MsgName := 'Anten Güç Ayarý Ekraný';
    OffflineMsg[35].MsgID := 38;
    OffflineMsg[35].MsgName := 'Anten Güç Ayarlarý Kaydedildi Ekraný';
    OffflineMsg[36].MsgID := 103;
    OffflineMsg[36].MsgName := 'Tag Ýþlemleri Ekraný';
    OffflineMsg[37].MsgID := 130;
    OffflineMsg[37].MsgName := 'Tag Ekleme Ekraný [1]';
    OffflineMsg[38].MsgID := 145;
    OffflineMsg[38].MsgName := 'Tag Ekleme Ekraný [2]';
    OffflineMsg[39].MsgID := 39;
    OffflineMsg[39].MsgName := 'Bu Daire Ýçin Limiti Aþtýnýz Ekraný';
    OffflineMsg[40].MsgID := 28;
    OffflineMsg[40].MsgName := 'Lütfen Tagý Okutunuz Ekraný';
    OffflineMsg[41].MsgID := 29;
    OffflineMsg[41].MsgName := 'Bu Tag Cihazda Tanýmlý Öncelikle Silmeniz Gerekli';
    OffflineMsg[42].MsgID := 30;
    OffflineMsg[42].MsgName := 'Tagýnýz Kaydedildi';
    OffflineMsg[43].MsgID := 131;
    OffflineMsg[43].MsgName := 'Tag Silme Ekraný';
    OffflineMsg[44].MsgID := 32;
    OffflineMsg[44].MsgName := 'Tag Bulunamadý Ekraný';
    OffflineMsg[45].MsgID := 31;
    OffflineMsg[45].MsgName := 'Tag Silindi Ekraný';
    OffflineMsg[46].MsgID := 132;
    OffflineMsg[46].MsgName := 'Tag Aktif Pasif Ekraný [1]';
    OffflineMsg[47].MsgID := 40;
    OffflineMsg[47].MsgName := 'Tag Bulunamadý Ekraný';
    OffflineMsg[48].MsgID := 33;
    OffflineMsg[48].MsgName := 'Tag Aktif Pasif Ekraný [2]';
    OffflineMsg[49].MsgID := 34;
    OffflineMsg[49].MsgName := 'Tag Aktif Duruma Ayarlandý Ekraný';
    OffflineMsg[50].MsgID := 35;
    OffflineMsg[50].MsgName := 'Tag Pasif Duruma Ayarlandý Ekraný';
    OffflineMsg[51].MsgID := 133;
    OffflineMsg[51].MsgName := 'Hýzlý Tag ekleme Ekraný';
    OffflineMsg[52].MsgID := 42;
    OffflineMsg[52].MsgName := 'Lütfen Tagý Okutunuz Ekraný';
    OffflineMsg[53].MsgID := 43;
    OffflineMsg[53].MsgName := 'Bu Tag Cihazda Tanýmlý Öncelikle Silmeniz Gerekli';
    OffflineMsg[54].MsgID := 44;
    OffflineMsg[54].MsgName := 'Tagýnýz Kaydedildi';
    OffflineMsg[55].MsgID := 134;
    OffflineMsg[55].MsgName := 'Hýzlý Tag Silme Ekraný';
    OffflineMsg[56].MsgID := 135;
    OffflineMsg[56].MsgName := 'Bu Dairenin Tüm Taglarý Silindi Ekraný';
    OffflineMsg[57].MsgID := 104;
    OffflineMsg[57].MsgName := 'Raporlar Ekraný';
    OffflineMsg[58].MsgID := 140;
    OffflineMsg[58].MsgName := 'Tarih Bazýnda Rapor Ekraný';
    OffflineMsg[59].MsgID := 141;
    OffflineMsg[59].MsgName := 'Daire Bazýnda Rapor Ekraný';
    OffflineMsg[60].MsgID := 142;
    OffflineMsg[60].MsgName := 'Daire Durum Raporu Ekraný [1]';
    OffflineMsg[61].MsgID := 146;
    OffflineMsg[61].MsgName := 'Daire Durum Raporu Ekraný [2]';
    OffflineMsg[62].MsgID := 143;
    OffflineMsg[62].MsgName := 'Ýçeride Raporu Ekraný';
    OffflineMsg[63].MsgID := 105;
    OffflineMsg[63].MsgName := 'Bakým Ekraný';
    OffflineMsg[64].MsgID := 150;
    OffflineMsg[64].MsgName := 'Araç Sayýsýný Sýfýrlama Ekraný';
    OffflineMsg[65].MsgID := 41;
    OffflineMsg[65].MsgName := 'Ýþlem Tamamlandý Ekraný';
    OffflineMsg[66].MsgID := 151;
    OffflineMsg[66].MsgName := 'Tüm Araçlarý Silme Ekraný';
    OffflineMsg[67].MsgID := 152;
    OffflineMsg[67].MsgName := 'Daire Sayý Sýfýrla Ekraný';
    OffflineMsg[68].MsgID := 155;
    OffflineMsg[68].MsgName := 'Bu Dairenin Ýçerideki araç bilgileri Sýfýrlandý Ekraný';
    OffflineMsg[69].MsgID := 156;
    OffflineMsg[69].MsgName := 'Bu Aracýn Ýçerideki Bilgileri Sýfýrlandý Ekraný';
    OffflineMsg[70].MsgID := 153;
    OffflineMsg[70].MsgName := 'Araç Sýfýrlama Ekraný';
    OffflineMsg[71].MsgID := 80;
    OffflineMsg[71].MsgName := 'Tanýmsýz Araç Ekraný';
    OffflineMsg[72].MsgID := 81;
    OffflineMsg[72].MsgName := 'Baþarýlý Geçiþ Ekraný';
    OffflineMsg[73].MsgID := 82;
    OffflineMsg[73].MsgName := 'Geçiþ Yetkiniz Yok Ekraný';
    OffflineMsg[74].MsgID := 83;
    OffflineMsg[74].MsgName := 'Tag Geçerlilik Süresi Dolmuþ Ekraný';
    OffflineMsg[75].MsgID := 84;
    OffflineMsg[75].MsgName := 'Geçersiz Zamanaralýðý Ekraný';
    OffflineMsg[76].MsgID := 85;
    OffflineMsg[76].MsgName := 'Otopark Hakkýnýz Dolmuþtur Ekraný';
    OffflineMsg[77].MsgID := 86;
    OffflineMsg[77].MsgName := 'Önce Çýkýþ Yapmalýsýnýz Ekraný';

    cbOffMsgType.Items.clear;
    for I := 0 to Msgcnt-1 do
      cbOffMsgType.Items.Add(OffflineMsg[i].MsgName);
  End
  Else
  Begin
    Msgcnt := 40;
    SetLength(OffflineMsg,Msgcnt);
    OffflineMsg[0].MsgID := 1;
    OffflineMsg[0].MsgName := 'Cihaz Açýlýþ Ekraný [1]';
    OffflineMsg[1].MsgID := 2;
    OffflineMsg[1].MsgName := 'Cihaz Açýlýþ Ekraný [2]';
    OffflineMsg[2].MsgID := 4;
    OffflineMsg[2].MsgName := 'Sifre Giris Ekrani';
    OffflineMsg[3].MsgID := 5;
    OffflineMsg[3].MsgName := 'Gecersiz Sifre Ekrani';
    OffflineMsg[4].MsgID := 6;
    OffflineMsg[4].MsgName := 'Yanlis Sifre Ekrani';
    OffflineMsg[5].MsgID := 7;
    OffflineMsg[5].MsgName := 'Önce Þifre Girmelisiniz Ekraný';
    OffflineMsg[6].MsgID := 8;
    OffflineMsg[6].MsgName := 'Sifreden Sonra kart1n1z1 okutun Ekrani';
    OffflineMsg[7].MsgID := 50;
    OffflineMsg[7].MsgName := 'Tanýmsýz Kart Ekraný';
    OffflineMsg[8].MsgID := 51;
    OffflineMsg[8].MsgName := 'Baþarýlý Geçiþ Ekraný';
    OffflineMsg[9].MsgID := 52;
    OffflineMsg[9].MsgName := 'Yetkisiz Terminal Ekraný';
    OffflineMsg[10].MsgID := 53;
    OffflineMsg[10].MsgName := 'Kart Sifre Uyumsuzlugu Ekrani';
    OffflineMsg[11].MsgID := 54;
    OffflineMsg[11].MsgName := 'Kart Gecerlilik suresi bitmis Ekrani';
    OffflineMsg[12].MsgID := 55;
    OffflineMsg[12].MsgName := 'Zaman K1s1t tablosu hata Ekrani';
    OffflineMsg[13].MsgID := 56;
    OffflineMsg[13].MsgName := 'Butonla Kap1 Acildiginde Ekrani';
    OffflineMsg[14].MsgID := 57;
    OffflineMsg[14].MsgName := 'Anti Passback Ihlali Ekrani';
    OffflineMsg[15].MsgID := 58;
    OffflineMsg[15].MsgName := 'Ardisik gecis hatasi Ekrani';
    OffflineMsg[16].MsgID := 59;
    OffflineMsg[16].MsgName := 'KArt Login Olunamad1 Ekrani';
    OffflineMsg[17].MsgID := 60;
    OffflineMsg[17].MsgName := 'Kart Okunamadi Ekrani';
    OffflineMsg[18].MsgID := 61;
    OffflineMsg[18].MsgName := 'Kart Yazilamadi Ekrani';
    OffflineMsg[19].MsgID := 62;
    OffflineMsg[19].MsgName := 'Yanlis Sifre Ekrani';
    OffflineMsg[20].MsgID := 63;
    OffflineMsg[20].MsgName := 'Online Server Baglanti Hatasi Ekrani';
    OffflineMsg[21].MsgID := 64;
    OffflineMsg[21].MsgName := 'Kapý açýk kaldý.';
    OffflineMsg[22].MsgID := 65;
    OffflineMsg[22].MsgName := 'Full YemekHakký ile geçiþ';
    OffflineMsg[23].MsgID := 66;
    OffflineMsg[23].MsgName := 'Öðün Yemek Hakkký dolu';
    OffflineMsg[24].MsgID := 67;
    OffflineMsg[24].MsgName := 'Gun yemek hakký dolu';
    OffflineMsg[25].MsgID := 68;
    OffflineMsg[25].MsgName := 'Yetersiz Bakiye';
    OffflineMsg[26].MsgID := 69;
    OffflineMsg[26].MsgName := 'Öðün Dýþý';

    OffflineMsg[27].MsgID := 70;
    OffflineMsg[27].MsgName := 'Cihaz Bilgi ekraný';
    OffflineMsg[28].MsgID := 71;
    OffflineMsg[28].MsgName := 'Ýnput Box';
    OffflineMsg[29].MsgID := 72;
    OffflineMsg[29].MsgName := 'Black List Uyarýsý';
    OffflineMsg[30].MsgID := 73;
    OffflineMsg[30].MsgName := 'Sadece Kontör baþarýlý geçiþ';
    OffflineMsg[31].MsgID := 74;
    OffflineMsg[31].MsgName := 'Sadece Haklý baþarýlý geçiþ';
    OffflineMsg[32].MsgID := 75;
    OffflineMsg[32].MsgName := 'Hak + Kontor baþarýlý geçiþ';
    OffflineMsg[33].MsgID := 76;
    OffflineMsg[33].MsgName := 'Hak bittikten sora kontöre geçerek baþarýlý geçiþ';
    OffflineMsg[34].MsgID := 77;
    OffflineMsg[34].MsgName := 'Hafta Yemek Hakký dolu';
    OffflineMsg[35].MsgID := 78;
    OffflineMsg[35].MsgName := 'Ay Yemek Hakký dolu';
    OffflineMsg[36].MsgID := 79;
    OffflineMsg[36].MsgName := 'Yuklenen + düþülen Kontur miktarý toplamý kontor den küçük';
    OffflineMsg[37].MsgID := 80;
    OffflineMsg[37].MsgName := 'Kartýnýzý Çekmeyiniz.';
    OffflineMsg[38].MsgID := 81;
    OffflineMsg[38].MsgName := 'Kart Bakiyesi düzeltildi.';
    OffflineMsg[39].MsgID := 82;
    OffflineMsg[39].MsgName := 'Kart Bakiyesi düzeltme hatalý.';

    cbOffMsgType.Items.clear;
    for I := 0 to Msgcnt-1 do
      cbOffMsgType.Items.Add(OffflineMsg[i].MsgName);

  End;
  //
  cbHeaderType.OnChange(self);
  cbFooterType.OnChange(self);
  edtLineCount.OnChange(self);
  cbOffHeaderType.OnChange(self);
  cbOffFooterType.OnChange(self);
  edtOffLineCount.OnChange(self);

End;

procedure TfrmMain.FormCreate(Sender: TObject);
Var
  i: Integer;
begin
  Rdr := TPerioTCPRdr.Create;
  Rdr.OnConnected := RdrConnected;
  Rdr.OnDisConnected := RdrDisConnected;;
  Rdr.OnCardRead := RdrCardRead;
  Rdr.OnPasswordRead := RdrPasswordRead;
  Rdr.OnInputText := RdrInputText;
  Rdr.OnTurnstileTurn := RdrTurnstileTurn;
  Rdr.OnTagRead := RdrTagRead;
  Rdr.OnDoorOpenAlarm := RdrDoorOpenAlarm;
  Rdr.OnSerialReadStr := RdrSerialReadStr;
  Rdr.Onlog := rdrLog;
  UDPServer := TIdUDPServer.Create(Self);
  UDPServer.OnUDPRead := UDPServerUDPRead;

  tsMfrKeyTable.TabVisible := false;
  tsDataFlash.TabVisible := True;
  tsHGSSettings.TabVisible := false;
  tsHGSInOutValues.TabVisible := false;
  tsYMKSettings.TabVisible := False;

  pgTCPReader.ActivePageIndex := 0;
  pgTCPReader.Enabled := False;
  dtTimer.Enabled := True;
  mmUDPLog.Lines.clear;

  grdMfrKeyList.Cols[1].Text := '  Key A';
  grdMfrKeyList.Cols[2].Text := '  Key B';
  for I := 1 to 16 do
    grdMfrKeyList.Rows[i].Text := IntToStr(i - 1);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned(Rdr) then
  Begin
    rdr.DisConnect;
    Rdr.Free;
  End;
  UDPServer.Free;
end;

procedure TfrmMain.UDPServerUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
Var
  str: String;
begin
  str := BytesToString(AData);
  mmUDPLog.Lines.Add(DateTimeToStr(now)+' > '+str);
  //PerioLog.LogDebug('UDP_Log_' + ABinding.PeerIP, str);
end;
procedure TfrmMain.mmdfDblClick(Sender: TObject);
begin
  //mmdf.Selected
  frmDFData := TfrmDFData.create(self);
  try
    frmDFData.mmdata.Text := mmdf.Items.Strings[mmdf.ItemIndex];
    if frmDFData.ShowModal = mrOk then
    Begin
      mmdf.Items.Strings[mmdf.ItemIndex] := frmDFData.mmdata.Text;
    End;
  finally
    frmDFData.Free;
  end;
end;

procedure TfrmMain.RdrCardRead(Sender: TObject; const CardID: string);
Var
  i:Integer;
  DataValue : array [0..15] of byte;
  str : String;
begin
  AddLog('Okunulan Kart ID [' + CardID + '].');
  // Sleep(800);
  {
  if ReadDataBlock then
  Begin
    if Rdr.ReadCardBlockData(5,1,0,DataValue) Then
    Begin
      str := '';
      for I := 0 to 15 do
      Begin
        if str ='' then
          str := IntToStr(DataValue[i] )
        else
          str := str +'-'+IntToStr(DataValue[i] );
      End;
      AddLog('Okunulan Deðer 1 [' + str + '].');

      for I := 0 to 15 do
        DataValue[i] := i+2;

      if Rdr.WriteCardBlockData(5,1,0,DataValue) then
         AddLog('Data Yazýldý.');

    End;
  End;
  Rdr.SetBeepRelayAndSecreenMessage(0, 0, '', 'Online ', 'Test', '', '', '', '',
    5, 15, 0, 5, 35, 0, edtX3.Value, edtY3.Value, 0, edtX4.Value, edtY4.Value,
    0, edtX5.Value, edtY5.Value, 0, 2, 2, 5, 5, 0, 10, False);
  if ReadDataBlock then
  Begin
    if Rdr.ReadCardBlockData(5,1,0,DataValue) Then
    Begin
      str := '';
      for I := 0 to 15 do
      Begin
        if str ='' then
          str := IntToStr(DataValue[i] )
        else
          str := str +'-'+IntToStr(DataValue[i] );
      End;
      AddLog('Okunulan Deðer 2 [' + str + '].');
    End;
  End;
  }
end;

procedure TfrmMain.RdrConnected(Sender: TObject);
begin
  btnConnect.Enabled := False;
  btnDisConnect.Enabled := True;
  pgTCPReader.Enabled := True;
  AddLog('IP [' + Rdr.IP + '] Baðlantý Kuruldu.');
end;

procedure TfrmMain.RdrDisConnected(Sender: TObject);
begin
  pgTCPReader.Enabled := False;
  btnConnect.Enabled := True;
  btnDisConnect.Enabled := False;
  AddLog('IP [' + Rdr.IP + '] Baðlantý Kesildi.');
end;

procedure TfrmMain.RdrDoorOpenAlarm(Sender: TObject; const DoorOpen: Boolean;
  const OpenTime: Cardinal);
begin
  if DoorOpen then
    AddLog('Kapý Açýk Kaldý. ')
  else
    AddLog('Kapý kapandý. Açýk kalan süre [' +IntToStr(OpenTime)+'].');
end;

procedure TfrmMain.RdrInputText(Sender: TObject; const ConfirmationType: TInputConfirmationType;
  const InputText: string);
begin
  if ConfirmationType = ctOk then
  Begin
    AddLog('Onay Tipi : [OK] - InputText [' + InputText + ']');
    Rdr.SetBeepRelayAndSecreenMessage(0, 0, '', 'Ýþlem ', 'Tamam', '', '', '', '',
      5, 15, 0, 5, 35, 0, edtX3.Value, edtY3.Value, 0, edtX4.Value, edtY4.Value,
      0, edtX5.Value, edtY5.Value, 0, 2, 2, 5, 5, 0, 10, False);

  End
  else
    AddLog('Onay Tipi : [Cancel] - InputText [' + InputText + ']');
end;

procedure TfrmMain.rdrLog(Sender: TObject; const LogLevel: TprLogLevel;
  const Log: string);
begin
   AddLog('['+GetLogLevelText(LogLevel)+'] '+Log);
end;

procedure TfrmMain.RdrPasswordRead(Sender: TObject; const PassType: Byte; const Password: Word;
  const Code: Cardinal);
begin
  AddLog('Girilen Þifre Tipi : [' + IntToStr(PassType) + '] - Þifre : ['
     + IntToStr(Password)+ '] Personel Kodu [' +IntToStr(Code) + '].');
  Rdr.SetBeepRelayAndSecreenMessage(0, 0, '', 'Online Þifre', 'Þifre', '', '', '', '',
    5, 15, 0, 5, 35, 0, edtX3.Value, edtY3.Value, 0, edtX4.Value, edtY4.Value,
    0, edtX5.Value, edtY5.Value, 0, 2, 2, 5, 5, 0, 10, False);
end;

procedure TfrmMain.RdrSerialReadStr(Sender: TObject; const SerialPortNo: Byte; const Data: string);
begin
  AddLog('Okunulan Data [' + Data +' - SerialPortNo : '+IntToStr(SerialPortNo)+'].');
end;

procedure TfrmMain.RdrTagRead(Sender: TObject; const IO: Byte; const TagID: string);
begin
  AddLog('Okunulan Tag ID [' + TagID +' - IO : '+IntToStr(IO)+'].');
end;

procedure TfrmMain.RdrTurnstileTurn(Sender: TObject; const Succes: Boolean; const CardID: string);
begin
  if Succes then
    AddLog('Turnike Dönüþ baþarýlý Kart ID [' + CardID + '].')
  else
    AddLog('Turnike Dönüþ baþarýsýz Kart ID [' + CardID + '].');
end;

procedure TfrmMain.dtTimerTimer(Sender: TObject);
begin
  edtDate.Date := Date;
  edtTime.time := time;
end;

procedure TfrmMain.edtLineCountChange(Sender: TObject);
begin
  case edtLineCount.Value of
    1:
      Begin
        // edtOnText1.Text := '';
        edtOnText1.Enabled := True;
        edtX1.Enabled := True;
        edtY1.Enabled := True;
        edtOnText2.Text := '';
        edtOnText2.Enabled := False;
        edtX2.Enabled := False;
        edtY2.Enabled := False;
        edtOnText3.Text := '';
        edtOnText3.Enabled := False;
        edtX3.Enabled := False;
        edtY3.Enabled := False;
        edtOnText4.Text := '';
        edtOnText4.Enabled := False;
        edtX4.Enabled := False;
        edtY4.Enabled := False;
        edtOnText5.Text := '';
        edtOnText5.Enabled := False;
        edtX5.Enabled := False;
        edtY5.Enabled := False;
      End;
    2:
      Begin
        // edtOnText1.Text := '';
        edtOnText1.Enabled := True;
        edtX1.Enabled := True;
        edtY1.Enabled := True;
        // edtOnText2.Text := '';
        edtOnText2.Enabled := True;
        edtX2.Enabled := True;
        edtY2.Enabled := True;
        edtOnText3.Text := '';
        edtOnText3.Enabled := False;
        edtX3.Enabled := False;
        edtY3.Enabled := False;
        edtOnText4.Text := '';
        edtOnText4.Enabled := False;
        edtX4.Enabled := False;
        edtY4.Enabled := False;
        edtOnText5.Text := '';
        edtOnText5.Enabled := False;
        edtX5.Enabled := False;
        edtY5.Enabled := False;
      End;
    3:
      Begin
        // edtOnText1.Text := '';
        edtOnText1.Enabled := True;
        edtX1.Enabled := True;
        edtY1.Enabled := True;
        // edtOnText2.Text := '';
        edtOnText2.Enabled := True;
        edtX2.Enabled := True;
        edtY2.Enabled := True;
        // edtOnText3.Text := '';
        edtOnText3.Enabled := True;
        edtX3.Enabled := True;
        edtY3.Enabled := True;
        edtOnText4.Text := '';
        edtOnText4.Enabled := False;
        edtX4.Enabled := False;
        edtY4.Enabled := False;
        edtOnText5.Text := '';
        edtOnText5.Enabled := False;
        edtX5.Enabled := False;
        edtY5.Enabled := False;
      End;
    4:
      Begin
        // edtOnText1.Text := '';
        edtOnText1.Enabled := True;
        edtX1.Enabled := True;
        edtY1.Enabled := True;
        // edtOnText2.Text := '';
        edtOnText2.Enabled := True;
        edtX2.Enabled := True;
        edtY2.Enabled := True;
        // edtOnText3.Text := '';
        edtOnText3.Enabled := True;
        edtX3.Enabled := True;
        edtY3.Enabled := True;
        // edtOnText4.Text := '';
        edtOnText4.Enabled := True;
        edtX4.Enabled := True;
        edtY4.Enabled := True;
        edtOnText5.Text := '';
        edtOnText5.Enabled := False;
        edtX5.Enabled := False;
        edtY5.Enabled := False;
      End;
    5:
      Begin
        // edtOnText1.Text := '';
        edtOnText1.Enabled := True;
        edtX1.Enabled := True;
        edtY1.Enabled := True;
        // edtOnText2.Text := '';
        edtOnText2.Enabled := True;
        edtX2.Enabled := True;
        edtY2.Enabled := True;
        // edtOnText3.Text := '';
        edtOnText3.Enabled := True;
        edtX3.Enabled := True;
        edtY3.Enabled := True;
        // edtOnText4.Text := '';
        edtOnText4.Enabled := True;
        edtX4.Enabled := True;
        edtY4.Enabled := True;
        // edtOnText5.Text := '';
        edtOnText5.Enabled := True;
        edtX5.Enabled := True;
        edtY5.Enabled := True;
      End;
  end;
end;

procedure TfrmMain.edtOffLineCountChange(Sender: TObject);
begin
  case edtOffLineCount.Value of
    1:
      Begin
        // edtOffText1.Text := '';
        edtOffText1.Enabled := True;
        edtOffX1.Enabled := True;
        edtOffY1.Enabled := True;
        edtOffText2.Text := '';
        edtOffText2.Enabled := False;
        edtOffX2.Enabled := False;
        edtOffY2.Enabled := False;
        edtOffText3.Text := '';
        edtOffText3.Enabled := False;
        edtOffX3.Enabled := False;
        edtOffY3.Enabled := False;
        edtOffText4.Text := '';
        edtOffText4.Enabled := False;
        edtOffX4.Enabled := False;
        edtOffY4.Enabled := False;
        edtOffText5.Text := '';
        edtOffText5.Enabled := False;
        edtOffX5.Enabled := False;
        edtOffY5.Enabled := False;
      End;
    2:
      Begin
        // edtOffText1.Text := '';
        edtOffText1.Enabled := True;
        edtOffX1.Enabled := True;
        edtOffY1.Enabled := True;
        // edtOffText2.Text := '';
        edtOffText2.Enabled := True;
        edtOffX2.Enabled := True;
        edtOffY2.Enabled := True;
        edtOffText3.Text := '';
        edtOffText3.Enabled := False;
        edtOffX3.Enabled := False;
        edtOffY3.Enabled := False;
        edtOffText4.Text := '';
        edtOffText4.Enabled := False;
        edtOffX4.Enabled := False;
        edtOffY4.Enabled := False;
        edtOffText5.Text := '';
        edtOffText5.Enabled := False;
        edtOffX5.Enabled := False;
        edtOffY5.Enabled := False;
      End;
    3:
      Begin
        // edtOffText1.Text := '';
        edtOffText1.Enabled := True;
        edtOffX1.Enabled := True;
        edtOffY1.Enabled := True;
        // edtOffText2.Text := '';
        edtOffText2.Enabled := True;
        edtOffX2.Enabled := True;
        edtOffY2.Enabled := True;
        // edtOffText3.Text := '';
        edtOffText3.Enabled := True;
        edtOffX3.Enabled := True;
        edtOffY3.Enabled := True;
        edtOffText4.Text := '';
        edtOffText4.Enabled := False;
        edtOffX4.Enabled := False;
        edtOffY4.Enabled := False;
        edtOffText5.Text := '';
        edtOffText5.Enabled := False;
        edtOffX5.Enabled := False;
        edtOffY5.Enabled := False;
      End;
    4:
      Begin
        // edtOffText1.Text := '';
        edtOffText1.Enabled := True;
        edtOffX1.Enabled := True;
        edtOffY1.Enabled := True;
        // edtOffText2.Text := '';
        edtOffText2.Enabled := True;
        edtOffX2.Enabled := True;
        edtOffY2.Enabled := True;
        // edtOffText3.Text := '';
        edtOffText3.Enabled := True;
        edtOffX3.Enabled := True;
        edtOffY3.Enabled := True;
        // edtOffText4.Text := '';
        edtOffText4.Enabled := True;
        edtOffX4.Enabled := True;
        edtOffY4.Enabled := True;
        edtOffText5.Text := '';
        edtOffText5.Enabled := False;
        edtOffX5.Enabled := False;
        edtOffY5.Enabled := False;
      End;
    5:
      Begin
        // edtOffText1.Text := '';
        edtOffText1.Enabled := True;
        edtOffX1.Enabled := True;
        edtOffY1.Enabled := True;
        // edtOffText2.Text := '';
        edtOffText2.Enabled := True;
        edtOffX2.Enabled := True;
        edtOffY2.Enabled := True;
        // edtOffText3.Text := '';
        edtOffText3.Enabled := True;
        edtOffX3.Enabled := True;
        edtOffY3.Enabled := True;
        // edtOffText4.Text := '';
        edtOffText4.Enabled := True;
        edtOffX4.Enabled := True;
        edtOffY4.Enabled := True;
        // edtOffText5.Text := '';
        edtOffText5.Enabled := True;
        edtOffX5.Enabled := True;
        edtOffY5.Enabled := True;
      End;
  end;

end;

procedure TfrmMain.ActionRdrConnectExecute(Sender: TObject);
begin
  // Mifare Read Write Operasyonalýný dene
  ReadDataBlock := false;

  try
    btnLogUDPStart.Click;
  except
  end;

   connectionType;

  case cbAppType.ItemIndex of
    0:
      Rdr.fwAppType := fwPDKS;
    1:
      Rdr.fwAppType := fwHGS;
    2:
      Rdr.fwAppType := fwYMK;
  end;

  case cbConnectReaderType.ItemIndex of
    0:
      Rdr.ReaderType := rdr63M_V3;
    1:
      Rdr.ReaderType := rdr63M_V5;
    2:
      Rdr.ReaderType := rdr26M;
  end;

  case cbConnectProtocol.ItemIndex of
    0:
      Rdr.ProtocolType := PR0;
    1:
      Rdr.ProtocolType := PR1;
    2:
      Rdr.ProtocolType := PR2;
    3:
      Rdr.ProtocolType := PR3;
  end;

  case cbDfSize.ItemIndex of
    0:
      Rdr.DFType := df4MB;
    1:
      Rdr.DFType := df8MB;
  end;

  if isIP(edtConnectIp.Text) then
  Begin
    Rdr.IP := edtConnectIp.Text;
    Rdr.Port := edtConnectPortNo.Text;
    Rdr.TimeOut := edtConnectTimeOut.Value;
    Rdr.DeviceLoginKey := edtConnectKey.Text;
    Rdr.CommandRetry := edtConnectCmdRtry.Value;
    Rdr.AutoConnect := cbConnectAutoConnect.Checked;
    Rdr.AutoRxEnabled := cbConnectAutoRxEnabled.Checked;
    //Rdr.ConnectionAliveEnabled := Rdr.AutoRxEnabled;
    Rdr.Connect;
    if Rdr.Connected then
    Begin
      OfflineMsgLoad;

      btnfwVersion.Click;
      btnGetHead.Click;
      btnGetDeviceStatus.Click;
      btnGetDeviceGeneralSettings.Click;
      btnGetWorkMode.Click;
      btnGetSerialNumber.Click;
      btnGetTCPSettings.Click;
      btnGetTCPClientSettings.Click;
      btnGetUDPSettings.Click;
      btnGetMacAddress.Click;
      btnGetWebPassword.Click;
      btnGetKeylist.Click;
      // Uygulama Ayarlarý
      btnGetAppgeneralSettings.Click;
      btnGetOutOfServiceSettings.Click;
      btnGetSerailPortBdSet.Click;
      if (rdr.fwAppType in [fwPDKS,fwYMK]) then
      Begin
        tsMfrKeyTable.TabVisible := True;
        tsAddWhitelist.TabVisible := True;
        tsInOutValues.TabVisible := True;
        tsHGSSettings.TabVisible := false;
        tsHGSInOutValues.TabVisible := false;
        if rdr.fwAppType  = fwYMK then
        Begin
          tsYMKSettings.TabVisible := True;
          gbYmkPerson.Visible := True;
        End;
        btnGetAPBSettings.Click;
        btnGetBellSettings.Click;
        btnGetEksOtherSettings.Click;

      End;
      if (rdr.fwAppType = fwHGS) then
      Begin
        tsHGSSettings.TabVisible := True;
        tsHGSInOutValues.TabVisible := True;
        tsMfrKeyTable.TabVisible := false;
        tsAddWhitelist.TabVisible := false;
        tsInOutValues.TabVisible := false;
        bntGetHGSSettings.Click;
      End;

    End
    else
      AddLog('Ip Adresi :' + edtConnectIp.Text +
        ' baðlantý saðlanamadý.', True);
    // if not Rdr.Connected then AddLog('Baðlantý Saðlanamadý!');
  End
  else
  Begin
    AddLog('Ip Adresi Hatalý', True);
  End;

end;

end.
