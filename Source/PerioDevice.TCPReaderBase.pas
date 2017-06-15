{ **************************************************************************
  * Perio TCP Reader Library ver. 1.01                                    *
  *   Reader Model  : ART26M,ART63M                                       *
  *   for Delphi 2010..XE5                                                *
  *                                                                       *
  *  http://www.perio.com.tr                                              *
  *                                                                       *
  *                                                                       *
  ************************************************************************* }
unit PerioDevice.TCPReaderBase;
/// ////////////////////////////////////////////////////////////////////////
///
/// (+) Eklendi
/// (-) Silindi
/// (*) Bug, düzeltme veya Uyarý
/// (/) Deðiþiklik Yapýldý
///
/// ////////////////////////////////////////////////////////////////////////
///
/// (*) 2014_02_05 Ozan Güçlü
///    Ýlk sürüm Bu dosyada base haberleþme componenti ve cihaz
///    genel ayarlarý ile ilgili fonksiyonlar bulunmaktatýr.
/// ////////////////////////////////////////////////////////////////////////
interface

uses
  Classes,
  SysUtils,
  DateUtils,
  StrUtils,
 {$IFDEF MSWINDOWS}
  Windows,
  IdLogEvent,
 {$ENDIF}
  Perio.Global,
  PerioDevice,
  PerioDevice.Encryption,
  IdTCPClient,
  IdGlobal,
  IdSocketHandle,
  IdComponent,
  IdStack,
  IdException;

type

  TTCPBuffer = record
    u2Len: word;
    uaBuff: array [0..TCP_IO_BUFF_CAP-1] of Byte;
    CmdNo: byte;
    SubCmdNo: byte;
    Tx_Acknowledge: byte;
    Tx_DataLen: byte;
    Tx_SessionId: byte;
    Tx_XORSessionId: byte;
    Rx_Acknowledge: byte;
    Rx_DataLen: byte;
    Rx_Return_Valuse: byte;
    Rx_SessionId: byte;
    Rx_XORSessionId: byte;
    SelectTimeOut: Integer;
  end;

  TCardReadEvent = procedure(Sender: TObject; const CardID: string) of object;

  THGSReadEvent = procedure(Sender: TObject;const IO:byte ; const TagID: string) of object;

  TSerialReadStrEvent = procedure(Sender: TObject;const SerialPortNo:byte ; const Data: string) of object;

  TTurnstileTurnEvent = procedure(Sender: TObject;Const Succes :Boolean ;const CardID: string) of object;

  TDoorOpenAlarmEvent = procedure(Sender: TObject;const DoorOpen :Boolean ;const OpenTime:LongWord) of object;

  TPasswordReadEvent = procedure(Sender: TObject;const PassType :byte ;const Password :word ;const Code:LongWord) of object;

  TInputTextEvent = procedure(Sender: TObject;const ConfirmationType :TInputConfirmationType ;const InputText :String) of object;

  TRdrNotifyEvent = procedure(Sender: TObject) of object;

  TCheckOnlineThread = class;

  TTcpRdrBase = class(TObject)
  private
    fIdTCPClient: TIdTCPClient; // TcpClient Component
    fCheckOnlineThread : TCheckOnlineThread; // Online Modda Receive Kontrolü bu thread de yapýlýr
    fReaderType: TReaderType; // Reader Tipi (63MV2,63MV5,26M)
    fProtocolType: TProtocolType; //Haberþeþme Protokol seçimi
    fDFType     : TDFType; //Dataflash Tipi (4MB,8MB)
    fDFPageSize : Word; //Dataflash Tipine göre dataflash boyu
    fIP: String;           // Cihaz IP Adresi
    fPort: String;         // Cihaz Port No
    fTimeOut: Integer;     // Cihaza PC haberleþme zaman aþýmý süresü (ms)
    fDeviceID: Integer;    // Cihaz ID
    fDeviceName : String;  // Cihaz Adý veya Kodu
    fEncDeviceLoginKey: array [0 .. 15] of byte;  //Cihaz Baðlantý Þifresi
    fDeviceLoginKey: String; //Cihaz Baðlantý Þifresi
    fSessionID: word; //Baðlantý session ID
    fAutoConnect: boolean; // Baðlantý koptuðunda otomatik baðlan
    fDefcmdRetry: Integer; // Komut baþarýsýz olmuþ ise tekrar sayýsý
    fAutoRxEnabled: boolean; // Online mod için TCP den cihazý dinleme
    fDefSelectTimeout: Cardinal;    // Receive Sýrasýnda varsayýlan bekleme süresi (ms)
                                    // Komut türüne göre deðiþkenlik gösterebilir diye bekleme süresini bu deðiþken ile set ediyoruz.
    fConnected: boolean; // Cihaz ile baðlýmý
    fLogined: boolean;   //Login Oldumu
    fAbort: boolean; // Ýþlemi Sonlandýrmak için
    fOnCmd: boolean; // Þu an cihazla bir iþlem yürütüyor mu (fOnCmd True ise cihazdan online iþlemlerini iþlem bitene kadar yapamaz.)
    fNextDeviceConnTime : TDateTime;
    fOnlineReConnectTimeOut : Integer;
    fOnlineThreadWaitTime : Integer;
    fOnlineEnabled : Boolean;

    fSyncServerEnabled : Boolean;

    fUdpPort : Integer;

    fLogSessionName: String;

    TxBuffer: TTCPBuffer; // TCP Client ile gönderielecek paket
    RxBuffer: TTCPBuffer; // TCP Client dan gelen paket

    fTx_Protocol_Len: Integer;
    fTx_TCP_Header_Pos: Integer;
    fTx_TCP_Len_Pos: Integer;
    fTx_Serial_Header_Pos: Integer;
    fTx_Serial_Len_Pos: Integer;
    fTx_SessionID_Pos: Integer;
    fTx_Command_Pos: Integer;
    fTx_SubCommand_Pos: Integer;
    fTx_Data_Start_Pos: Integer;

    fRx_Protocol_Len: Integer;
    fRx_TCP_Header_Pos: Integer;
    fRx_TCP_Len_Pos: Integer;
    fRx_Serial_Header_Pos: Integer;
    fRx_Serial_Len_Pos: Integer;
    fRx_SessionID_Pos: Integer;
    fRx_Acknowledge_Pos: Integer;
    fRx_Return_Value_Pos: Integer;
    fRx_Command_Pos: Integer;
    fRx_SubCommand_Pos: Integer;
    fRx_Data_Start_Pos: Integer;

    fOnCardRead : TCardReadEvent;
    fOnLog : TprLogEvent;
    fOnTurnstileTurn : TTurnstileTurnEvent;
    fOnConnected : TRdrNotifyEvent;
    fOnDisConnected : TRdrNotifyEvent;
    fOnTagRead : THGSReadEvent;
    fOnSerialReadStr : TSerialReadStrEvent;
    fOnDoorOpenAlarm : TDoorOpenAlarmEvent;
    fOnPasswordReadEvent : TPasswordReadEvent;
    fOnInputTextEvent : TInputTextEvent;
  protected
    procedure DoLog(LogLevel: TprLogLevel; const aMethodName, aMsg: string;
      ErrorID: Integer = 0);

    procedure DoOnCardRead(const CardID: string);
    //procedure DoOnLog(const Msg: string);
    procedure DoOnTurnstileTurn(Const Success: Boolean;const CardID: string);
    procedure DoOnTagRead(const IO:byte;const TagID: string);
    procedure DoOnSerialReadStr(const SerialPortNo:byte;const Data:String);
    procedure DoOnConnected;
    procedure DoOnDisConnected;
    procedure DoOnDoorOpenAlarm(const DoorOpen :Boolean ;const OpenTime:LongWord);
    procedure DoOnPasswordRead(const PassType :byte ;const Password :word ;const Code:LongWord);
    procedure DoOnInputText(const ConfirmationType :TInputConfirmationType ;const InputText :String);

    // Propery Procs
    Procedure SetReaderType(Const Value: TReaderType);
    Procedure SetProtocolType(Const Value: TProtocolType);
    procedure SetDFType(Const Value : TDFType);

    Procedure SetLoginKey(Const Value: String);
    Procedure SetConnected(Const Value: boolean);
    procedure SetDeviceName(Const Value: String);

    function lTimeToMs(dt: TDateTime): Cardinal;
    procedure ByteCrc(data: byte; var crc: word);

    Procedure ResetTxBuffer;
    Procedure ResetRxBuffer;

    function SetProtocol: Integer;
    function SetProtocolPR0: Integer;
    function SetProtocolPR1: Integer;
    function SetProtocolPR2: Integer;

    function CheckProtocol: integer;
    function CheckProtocolPR0: integer;
    function CheckProtocolPR1: integer;
    function CheckProtocolPR2: integer;

    function ExecuteCmd(CmdNo, SubCmdNo, Acknowledge, DataLen: Integer;
      SendData: TDataByte; Out RecData: TDataByte;
      SelectTimeOut: Integer = 0;CmdRetry:Integer=0): Integer;
    function Send: integer;
    function Receive(const OprStartTime: Cardinal): integer;

    Function LoginDevice: Integer;
    Function LoginDevicePr0: Integer;
    Function LoginDevicePr1: Integer;
    Function LoginDevicePr2: Integer;

    function DoConnect: Integer;
    function CheckConnection: Integer;
    function ReConnect: Integer;
    function ReConnectOnline: Integer;
    function DoDisConnect(DisableOnline : Boolean): Integer;
    // ClientType Procs Indy
    procedure IdTCPClientStatus(ASender: TObject; const AStatus: TIdStatus;
       const AStatusText: string);
    function ConnectIndy: Integer;
    function CheckConnectionIndy: Integer;
    function ReConnectIndy: Integer;
    function tryDisconnectIndy:Boolean;
    function DisConnectIndy(DisableOnline : Boolean): Integer;
    function SendIndy: integer;
    function ReceiveIndy(const OprStartTime: Cardinal): integer;
    /////////////////////////////////////////////////////////////////////////////////
    procedure CheckOnlineData;

    procedure SyncServer;virtual;
    function GetSyncServerEnabled:Boolean;
    procedure SetSyncServerEnabled(value : Boolean);

  public
    //constructor Create(AOwner: TComponent); override;
    constructor Create;virtual;
    destructor Destroy; override;

  published
    property ReaderType: TReaderType read fReaderType write SetReaderType;
    property ProtocolType: TProtocolType read fProtocolType
      write SetProtocolType;
    property DFType : TDFType read fDFType write SetDFType;
    property IP: String read fIP Write fIP;
    property Port: String read fPort write fPort;
    property TimeOut: Integer read fTimeOut write fTimeOut;
    property ReadTimeOut: Cardinal read fDefSelectTimeout
      write fDefSelectTimeout;
    property DeviceID: Integer read fDeviceID write fDeviceID;
    property DeviceName : String read fDeviceName write SetDeviceName;
    property DeviceLoginKey: string Read fDeviceLoginKey
      write SetLoginKey;
    property CommandRetry: Integer read fDefcmdRetry write fDefcmdRetry default 3;
    property AutoConnect: boolean read fAutoConnect write fAutoConnect;
    property Connected: boolean read fConnected write SetConnected;
    property AutoRxEnabled: boolean read fAutoRxEnabled write fAutoRxEnabled;
    property OnCardRead: TCardReadEvent read fOnCardRead write fOnCardRead;
    property Onlog : TprLogEvent read fOnlog write fOnlog;
    property OnPasswordRead: TPasswordReadEvent read fOnPasswordReadEvent write fOnPasswordReadEvent;
    property OnInputText: TInputTextEvent read fOnInputTextEvent write fOnInputTextEvent;
    property OnConnected : TRdrNotifyEvent read fOnConnected write fOnConnected;
    property OnDisConnected : TRdrNotifyEvent read fOnDisConnected write fOnDisConnected;
    property OnTurnstileTurn : TTurnstileTurnEvent read fOnTurnstileTurn write fOnTurnstileTurn;
    property OnTagRead : THGSReadEvent read fOnTagRead write fOnTagRead;
    property OnDoorOpenAlarm : TDoorOpenAlarmEvent read fOnDoorOpenAlarm write fOnDoorOpenAlarm;
    property OnSerialReadStr : TSerialReadStrEvent read fOnSerialReadStr write fOnSerialReadStr;
    property OnlineReConnectTimeOut : Integer read fOnlineReConnectTimeOut write  fOnlineReConnectTimeOut;
    property OnlineThreadWaitTime : Integer read fOnlineThreadWaitTime write fOnlineThreadWaitTime;
    property SyncServerEnabled : Boolean read GetSyncServerEnabled write SetSyncServerEnabled;
  end;

  TCustomTcpRdr = class(TTcpRdrBase)
  private
  protected
    // General Device Functions
    function tcpSetDeviceLoginKey(Key: array of Byte): Integer;  // CMD 2.1
    function tcpGetDeviceGeneralSettings(out rSettings : TGeneralDeviceSettings) : Integer; // CMD 2.2
    function tcpSetDeviceGeneralSettings(rSettings:TGeneralDeviceSettings) : Integer; // CMD 2.3
    function tcpGetDeviceTCPSettings(out rSettings : TTCPSettings) : Integer; // CMD 2.4
    function tcpSetDeviceTCPSettings(rSettings:TTCPSettings) : Integer; // CMD 2.5
    function tcpGetDeviceUDPSettings(out rSettings:TUDPSettings) : Integer; // CMD 2.6
    function tcpSetDeviceUDPSettings(rSettings:TUDPSettings) : Integer; // CMD 2.7
    function tcpGetMACAddress(out MacAddr:String) : Integer; // CMD 2.8
    function tcpSetMACAddress(MacAddr:String) : Integer; // CMD 2.9
    function tcpGetDeviceWorkModeSettings(out rSettings : TWorkModeSettings) : Integer; // CMD 2.10
    function tcpSetDeviceWorkModeSettings(rSettings : TWorkModeSettings) : Integer; // CMD 2.11
    function tcpGetWebPassword(Out WebPassword:string):Integer; // CMD 2.12
    function tcpSetWebPassword(WebPassword:string):Integer; // CMD 2.13
    function tcpSetDeviceFactoryDefault(ResetIP:Boolean) : Integer; // CMD 2.14
    function tcpGetSerialNumber(out SerialArr : array of byte) : Integer; // CMD 2.15
    function tcpSetSerialNumber(SerialArr : array of byte) : Integer; // CMD 2.16
    function tcpReboot: Integer; // CMD 2.17
    function tcpGetFwVwersion(out fWVersion:string):Integer; // CMD 2.18
    function tcpSetDateTime(dt:TDateTime): Integer; // CMD 2.19
    function tcpGetMfrKeyList(out KeyList : TMfrKeyList) : Integer; // CMD 2.20
    function tcpSetMfrKeyList(KeyList : TMfrKeyList) : Integer; // CMD 2.21
    function tcpGetHeadTailCapacity(Out Head,Tail,Capacity:LongWord) : Integer; // CMD 2.22
    function tcpSetHeadTail(Head,Tail:Cardinal) : Integer; // CMD 2.23
    function tcpGetDeviceStatus(out StatusEnb:Boolean) : Integer; // CMD 2.24
    function tcpSetDeviceStatus(StatusEnb:Boolean) : Integer; // CMD 2.25
    function tcpGetLCDMessages(ID : longword;out LcdScreenMsg : TLcdScreen) : Integer; // CMD 2.26
    function tcpSetLCDMessages(LcdScreenMsg : TLcdScreen) : Integer; // CMD 2.27
    function tcpSetBeepRelayAndSecreenMessage(LcdScreenMsg : TLcdScreen) : Integer; // CMD 2.28
    function tcpGetDeviceClientTCPSettings(out rSettings : TClientTCPSettings) : Integer; // CMD 2.29
    function tcpSetDeviceClientTCPSettings(rSettings:TClientTCPSettings) : Integer; // CMD 2.30
    function tcpGetWeekDayNames(out WeekDays : TWeekDays) : Integer; // CMD 2.31
    function tcpSetWeekDayNames(WeekDays : TWeekDays) : Integer; // CMD 2.32
    function tcpReadPageData(PageNo: word;out HexValue :String) : Integer; // CMD 2.33
    function tcpWritePageData(PageNo: word; HexValue :String) : Integer; // CMD 2.34
    function tcpSerialTestFunction : Integer; // CMD 2.35
    function tcpSetLCDMessagesFactoryDefault : Integer; // CMD 2.36
    function tcpTestCreateRecordFunction : Integer; // CMD 2.37
    function tcpGetSerialPortSettings(out SerailAppType,Serial0,Serial1 :Byte ): Integer; // CMD 2.38
    function tcpSetSerialPortSettings(SerailAppType,Serial0,Serial1 :Byte ): Integer; // CMD 2.39
    function tcpReadCardBlockData(SectorNo,BlockNo,KeyType:Byte;Out ValueBuff : array of byte ): Integer; // CMD 2.40
    function tcpWriteCardBlockData(SectorNo,BlockNo,KeyType:Byte;ValueBuff : array of byte ): Integer; // CMD 2.41
    function tcpSetBeepRelayAndInboxMessage(LcdScreenMsg : TLcdScreen):Integer; // CMD 2.42
    //function tcp : Integer; // CMD 2.43
    function tcpGetReaderServiceStatus(out StatusEnb:Boolean;out TimeOut : word) : Integer; // CMD 2.44
    function tcpSetReaderServiceStatus(StatusEnb:Boolean;TimeOut : word) : Integer; // CMD 2.45
    //function tcp : Integer; // CMD 2.46

  public
    function Connect: Boolean;
    function DisConnect: Boolean;

    function SetDeviceLoginKey(Key: array of Byte): Boolean;overload;
    function SetDeviceLoginKey(Key: String): Boolean;overload;
    function GetDeviceGeneralSettings(out rSettings : TGeneralDeviceSettings) : Boolean;
    function SetDeviceGeneralSettings(rSettings:TGeneralDeviceSettings) : Boolean;
    function GetDeviceTCPSettings(out rSettings : TTCPSettings) : Boolean;
    function SetDeviceTCPSettings(rSettings:TTCPSettings) : Boolean;
    function GetDeviceUDPSettings(out rSettings:TUDPSettings) : Boolean;
    function SetDeviceUDPSettings(rSettings:TUDPSettings) : Boolean;
    function GetMACAddress(out MacAddr:String):Boolean;overload;
    function GetMACAddress:String;overload;
    function SetMACAddress(MacAddr:String):Boolean;
    function GetDeviceWorkModeSettings(out rSettings : TWorkModeSettings) : Boolean;
    function SetDeviceWorkModeSettings(rSettings : TWorkModeSettings) : Boolean;
    function GetWebPassword(Out WebPassword:string):Boolean;overload;
    function GetWebPassword:String;overload;
    function SetWebPassword(WebPassword:string):Boolean;
    function SetDeviceFactoryDefault(ResetIP:Boolean=False) : Boolean;
    function GetSerialNumber(out SerialArr : array of byte) : Boolean;overload;
    function SetSerialNumber(SerialArr : array of byte) : Boolean;overload;
    function GetSerialNumber : String ;overload;
    function SetSerialNumber(SerialStr : String) : Boolean;overload;
    procedure Reboot;
    function GetFwVwersion(out fWVersion:string):Boolean;overload;
    function GetFwVwersion:String;overload;
    function SetDateTime(dt:TDateTime): Boolean;
    function GetMfrKeyList(out KeyList : TMfrKeyList) : Boolean;overload;
    function SetMfrKeyList(KeyList : TMfrKeyList) : Boolean;overload;
    function GetMfrKeyList(out KeyList : TMfrKeyListStr) : Boolean;overload;
    function SetMfrKeyList(KeyList : TMfrKeyListStr) : Boolean;overload;
    function GetHeadTailCapacity(Out Head,Tail,Capacity:LongWord): Boolean;
    function GetHead: Integer;
    function GetTail: Integer;
    function GetCapacity: Integer;
    function SetHeadTail(Head,Tail:LongWord): Boolean;
    function GetDeviceStatus : Boolean;
    function SetDeviceStatus(StatusEnb:Boolean) : Boolean;
    function GetLCDMessages(ID : Integer;out LcdScreenMsg : TLcdScreen) : Boolean;
    function SetLCDMessages(LcdScreenMsg : TLcdScreen) : Boolean;
    function SetBeepRelayAndSecreenMessage(
        HeaderType,FooterType:Integer;
        Caption,Text1,Text2,Text3,Text4,Text5,Footer:String;
        X1,Y1,Alligment1,X2,Y2,Alligment2,X3,Y3,Alligment3,
        X4,Y4,Alligment4,X5,Y5,Alligment5:Byte;
        LineCount,FontType:Byte;
        ScreenDuration,RL_Time1,RL_Time2,BZR_time : word;
        IsBlink : Boolean) : Boolean;overload;
    function SetBeepRelayAndSecreenMessage(
       Text1,Text2:String;ScreenDuration,RL_Time1,BZR_time : word;
        IsBlink : Boolean) : Boolean;overload;
    function SetBeepRelayAndInboxMessage(HeaderType:Integer;
        Caption,Text1,Text2:String;X1,Y1,Alligment1,X2,Y2,Alligment2:Byte;
        ScreenDuration,RL_Time1,RL_Time2,BZR_time : word;IsBlink : Boolean;KeyPadType:Byte) : Boolean;
    function GetDeviceClientTCPSettings(out rSettings : TClientTCPSettings) : Boolean;
    function SetDeviceClientTCPSettings(rSettings:TClientTCPSettings) : Boolean;
    function GetWeekDayNames(out WeekDays : TWeekDays) : Boolean;
    function SetWeekDayNames(WeekDays : TWeekDays) : Boolean;
    function ReadPageData(PageNo: word;out HexValue :String) : Boolean;
    function WritePageData(PageNo: word; HexValue :String) : Boolean;
    function SerialTestFunction : Boolean;
    function SetLCDMessagesFactoryDefault : Boolean;
    function TestCreateRecordFunction : Boolean;
    function GetSerialPortSettings(out SerailAppType,Serial0,Serial1 :Byte ): Boolean;
    function SetSerialPortSettings(SerailAppType,Serial0,Serial1 :Byte ): Boolean;
    function ReadCardBlockData(SectorNo,BlockNo:Byte;KeyType : byte;Out ValueBuff : array of byte ):Boolean;
    function WriteCardBlockData(SectorNo,BlockNo:Byte;KeyType : byte;ValueBuff : array of byte ):Boolean;
    function GetReaderServiceStatus(out StatusEnb:Boolean;out TimeOut : word) : Boolean;
    function SetReaderServiceStatusEnable : Boolean;
    function SetReaderServiceStatusDisable(TimeOut : word) : Boolean;
  published

  end;

  TCheckOnlineThread = class(TThread)
  private
    fEnabled : Boolean;
    fInterval : Integer;
    fRdr      : TTcpRdrBase;
  public
    { Public declarations }
    constructor Create(const Interval:Integer;Rdr: TTcpRdrBase);
    procedure Execute; override;
    procedure SetEnable;
    procedure SetDisable;
    function  Enabled:Boolean;
    procedure ReadOnlineData;
  end;

implementation

Var
  CSRdr: TRTLCriticalSection;

constructor TCheckOnlineThread.Create(const Interval:Integer;Rdr: TTcpRdrBase);
Begin
  inherited Create(false);
  Priority := tpTimeCritical;
  if Interval > 5 then
    fInterval := Interval
  else
    fInterval := 5;
  fEnabled := false;
  fRdr := Rdr;
  InitializeCriticalSection(CSRdr);
End;

procedure TCheckOnlineThread.Execute;
Begin
  inherited;
  try
    while (not Terminated)   do
    begin
      sleep(fInterval);
      if fEnabled then
        ReadOnlineData;
    end;
  except
    on E: Exception do
    begin
    {
       Synchronize( procedure
                  begin frdr.LogError('TCheckOnlineThread.Execute Error :',E.Message);
                  End  );
                  }
    end;
  end; // try
End;

procedure TCheckOnlineThread.SetEnable;
Begin
  InitializeCriticalSection(CSRdr);
  try
    EnterCriticalSection(CSRdr);
    fEnabled := True;
  finally
    LeaveCriticalSection(CSRdr);
  end;
End;

procedure TCheckOnlineThread.SetDisable;
Begin
  InitializeCriticalSection(CSRdr);
  try
    EnterCriticalSection(CSRdr);
    fEnabled := false;
  finally
    LeaveCriticalSection(CSRdr);
  end;
End;
function TCheckOnlineThread.Enabled:Boolean;
Begin
  InitializeCriticalSection(CSRdr);
  try
     result := fEnabled;
  finally
    LeaveCriticalSection(CSRdr);
  end;
End;

procedure TCheckOnlineThread.ReadOnlineData;
Begin
  InitializeCriticalSection(CSRdr);
  try
     Synchronize(fRdr.CheckOnlineData);
  finally
    LeaveCriticalSection(CSRdr);
  end;
End;

function TTcpRdrBase.lTimeToMs(dt: TDateTime): Cardinal;
var
  AHour, AMinute, ASecond, AMilliSecond: word;
begin
  DecodeTime(dt, AHour, AMinute, ASecond, AMilliSecond);
  Result := (AHour * 60 * 60 * 1000) + (AMinute * 60 * 1000) + (ASecond * 1000)
    + AMilliSecond;
end;

procedure TTcpRdrBase.ByteCrc(data: byte; var crc: word);
Var
  i: byte;
Begin
  for I := 0 to 7 do
  Begin
    if ((data and $01) xor (crc and $0001) <> 0) then
    begin
      crc := crc shr 1;
      crc := crc xor $A001;
    end
    else
      crc := crc shr 1;

    data := data shr 1; // this line is not ELSE and executed anyway.
  end;
end;


Procedure TTcpRdrBase.SetReaderType(Const Value: TReaderType);
Begin
  fReaderType := Value;
End;

Procedure TTcpRdrBase.SetProtocolType(Const Value: TProtocolType);
Begin
  fProtocolType := Value;
  case fProtocolType of
    PR0:
      Begin
        fTx_Protocol_Len := 17;
        fTx_TCP_Header_Pos := 0; // TCP_Header 2 byte 0..1
        fTx_TCP_Len_Pos := 2; // TCP_Len 2 byte 2..3
        fTx_Serial_Header_Pos := 4; // TCP_Header 2 byte 4..5
        fTx_Serial_Len_Pos := 6; // TCP_Len 2 byte 6..7
        fTx_Command_Pos := 8;
        fTx_SubCommand_Pos := 9;
        fTx_SessionID_Pos := 10; // SeeeionID 2
        fTx_Data_Start_Pos := 11;

        fRx_Protocol_Len := 19;
        fRx_TCP_Header_Pos := 0;
        fRx_TCP_Len_Pos := 2;
        fRx_Serial_Header_Pos := 4;
        fRx_Serial_Len_Pos := 6;
        fRx_Command_Pos := 8;
        fRx_SubCommand_Pos := 9;
        fRx_SessionID_Pos := 10;
        fRx_Acknowledge_Pos := 11;
        fRx_Return_Value_Pos := 12;
        fRx_Data_Start_Pos := 13;
      End;
    PR1:
      Begin
        fTx_Protocol_Len := 14;
        fTx_TCP_Header_Pos := 0; // TCP_Header 2 byte 0..1
        fTx_TCP_Len_Pos := 2; // TCP_Len 2 byte 2..3
        fTx_Serial_Header_Pos := 4; // TCP_Header 2 byte 4..5
        fTx_Serial_Len_Pos := 6; // TCP_Len 2 byte 6..7
        fTx_Command_Pos := 8;
        fTx_SubCommand_Pos := 9;
        fTx_Data_Start_Pos := 10;

        fRx_Protocol_Len := 16;
        fRx_TCP_Header_Pos := 0;
        fRx_TCP_Len_Pos := 2;
        fRx_Serial_Header_Pos := 4;
        fRx_Serial_Len_Pos := 6;
        fRx_Command_Pos := 8;
        fRx_SubCommand_Pos := 9;
        fRx_Acknowledge_Pos := 10;
        fRx_Return_Value_Pos := 11;
        fRx_Data_Start_Pos := 12;
      End;
    PR2:
      Begin
        fTx_Protocol_Len := 14;
        fTx_TCP_Header_Pos := 0; // TCP_Header 2 byte 0..1
        fTx_TCP_Len_Pos := 2; // TCP_Len 2 byte 2..3
        fTx_Serial_Header_Pos := 4; // TCP_Header 2 byte 4..5
        fTx_Serial_Len_Pos := 6; // TCP_Len 2 byte 6..7
        fTx_Command_Pos := 8;
        fTx_SubCommand_Pos := 9;
        fTx_Data_Start_Pos := 10;

        fRx_Protocol_Len := 16;
        fRx_TCP_Header_Pos := 0;
        fRx_TCP_Len_Pos := 2;
        fRx_Serial_Header_Pos := 4;
        fRx_Serial_Len_Pos := 6;
        fRx_Command_Pos := 8;
        fRx_SubCommand_Pos := 9;
        fRx_Acknowledge_Pos := 10;
        fRx_Return_Value_Pos := 11;
        fRx_Data_Start_Pos := 12;
      End;
  end;
  if fDeviceLoginKey <> '' then
    SetLoginKey(fDeviceLoginKey);
End;

Procedure TTcpRdrBase.SetLoginKey(Const Value: String);
Var
  iErr, i: Integer;
  KeyData : array[0..15] of byte;
Begin
  iErr := 0;
  fDeviceLoginKey := Value;
  if fDeviceLoginKey <> '' then
  Begin
    case fProtocolType of
      PR0:
        Begin
          if ToPrBytesFromHex(fDeviceLoginKey,KeyData,0,32) Then
            EncryptDeviceKeyX(fIP,KeyData,fEncDeviceLoginKey)
          else
           iErr := TErrors.INVALID_COMN_KEY;
        End;
      PR1:
        Begin
          if ToPrBytesFromHex(fDeviceLoginKey,KeyData,0,32) Then
            EncryptDeviceKeyx(fIP,KeyData,fEncDeviceLoginKey)
          else
           iErr := TErrors.INVALID_COMN_KEY;
        End;
      PR2:
        Begin
          if ToPrBytesFromHex(fDeviceLoginKey,KeyData,0,32) Then
          Begin
            for I := 0 to 15 do
              fEncDeviceLoginKey[i] := KeyData[i];
          End
          else
           iErr := TErrors.INVALID_COMN_KEY;
         End;
    end;
    if iErr <> 0 then
      DoLog(lgError,'SetDeviceLoginKey', ' SetDeviceLoginKey Error No : ' + IntToStr(iErr));
  End
  else
    DoLog(lgWarning,'SetDeviceLoginKey', ' SetDeviceLoginKey Not Set ');

End;

Procedure TTcpRdrBase.SetConnected(Const Value: boolean);
Begin
  CheckConnection;
  if fConnected <> Value then
  Begin
    if Value then
      DoConnect
    else
      DoDisConnect(True);
  End;
End;

procedure TTcpRdrBase.SetDeviceName(Const Value: String);
Begin
  if Value <> '' then
  Begin
    fDeviceName := Value;
    fLogSessionName := Value;
  End;
End;

procedure TTcpRdrBase.SetDFType(Const Value : TDFType);
Begin
  fDFType := Value;
  if fDFType = df8MB then
    fDFPageSize := 1056
  else
    fDFPageSize := 528;
End;

Procedure TTcpRdrBase.ResetTxBuffer;
Begin
  TxBuffer.u2Len := 0;
  TxBuffer.CmdNo := 0;
  TxBuffer.SubCmdNo := 0;
  TxBuffer.Tx_Acknowledge := 0;
  TxBuffer.Tx_DataLen := 0;
  TxBuffer.Tx_SessionId := 0;
  TxBuffer.Tx_XORSessionId := 0;
  TxBuffer.Rx_Acknowledge := 0;
  TxBuffer.Rx_DataLen := 0;
  TxBuffer.Rx_Return_Valuse := 0;
  TxBuffer.Rx_SessionId := 0;
  TxBuffer.Rx_XORSessionId := 0;
  TxBuffer.SelectTimeOut := 0;
  FillChar(TxBuffer.uaBuff, TCP_IO_BUFF_CAP-1, 0);
End;

Procedure TTcpRdrBase.ResetRxBuffer;
Begin
  RxBuffer.u2Len := 0;
  RxBuffer.CmdNo := 0;
  RxBuffer.SubCmdNo := 0;
  RxBuffer.Tx_Acknowledge := 0;
  RxBuffer.Tx_DataLen := 0;
  RxBuffer.Tx_SessionId := 0;
  RxBuffer.Tx_XORSessionId := 0;
  RxBuffer.Rx_Acknowledge := 0;
  RxBuffer.Rx_DataLen := 0;
  RxBuffer.Rx_Return_Valuse := 0;
  RxBuffer.Rx_SessionId := 0;
  RxBuffer.Rx_XORSessionId := 0;
  RxBuffer.SelectTimeOut := 0;
  FillChar(RxBuffer.uaBuff, TCP_IO_BUFF_CAP-1, 0);
End;

constructor TTcpRdrBase.Create;
begin
  inherited Create;
  fReaderType := rdr63M_V3;
  fProtocolType := PR2;
  fOnCmd := False;
  fDefcmdRetry := 3;
  fIP := '192.168.0.101';
  fPort := '6565';
  fTimeOut := 2000;
  fDefSelectTimeout := 1000;
  fLogSessionName := 'PerioTcpRdr';
  fDFType := df4MB;
  SetDFType(fDFType);
  SetProtocolType(fProtocolType);
  fOnlineReConnectTimeOut := 15000;
  fOnlineThreadWaitTime := 50;
  fSyncServerEnabled := False;
  fIdTCPClient := TIdTCPClient.Create(nil);
end;

destructor TTcpRdrBase.Destroy;
begin
  DoDisConnect(True);
  if Assigned(fCheckOnlineThread) then
  Begin
    fCheckOnlineThread.SetDisable;
    fCheckOnlineThread.Terminate;
    fCheckOnlineThread.WaitFor;
    FreeAndNil(fCheckOnlineThread);
  End;
  if Assigned(fIdTCPClient) then
    freeandnil(fIdTCPClient);
  inherited Destroy;
end;

Function TTcpRdrBase.LoginDevicePr0: Integer;
Var
  iErr, i: Integer;
  rSessionID: word;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := PrepareLoginDataPR0(fencDeviceLoginKey, fSessionID, SendData);
    if (iErr = 0) then
    Begin
      iErr := ExecuteCmd(1, // CmdNo
        0, // SubCmdNo
        1, // Acknowledge
        32, // DataLen
        SendData, RecData, 100 // SelectTimeOut
        );
      if iErr = 0 then
      Begin
        rSessionID := RecData[4] + RecData[27] * 256;
        if (rSessionID = fSessionID) then
        Begin
          fLogined := True;
          iErr := TErrors.NO_ERROR;
        End else
        Begin
          fSessionID := 0;
          iErr := TErrors.NOT_LOGIN_DEVICE;
        End
      End
      else
      Begin
        fSessionID := 0;
        iErr := TErrors.NOT_LOGIN_DEVICE;
      End;
    End
    else
      iErr := TErrors.NOT_PREPARE_LOGINDATA;
  except
    on E: Exception do
    begin
      DoLog(lgError,'LoginDeviceArt','Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

Function TTcpRdrBase.LoginDevicePr1: Integer;
Var
  iErr, i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for i := 0 to 15 do
      SendData[i] := fEncDeviceLoginKey[i];

    iErr := ExecuteCmd(1, // CmdNo
      1, // SubCmdNo
      1, // Acknowledge
      16, // DataLen
      SendData, RecData, 100 // SelectTimeOut
      );
    fLogined := (iErr = 0);
  except
    on E: Exception do
    begin
      DoLog(lgError,'LoginDeviceStandart', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

Function TTcpRdrBase.LoginDevicePr2: Integer;
Var
  iErr, i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for i := 0 to 15 do
      SendData[i] := fEncDeviceLoginKey[i];

    iErr := ExecuteCmd(1, // CmdNo
      2, // SubCmdNo
      1, // Acknowledge
      16, // DataLen
      SendData, RecData, 100 // SelectTimeOut
      );
    fLogined := (iErr = 0);
  except
    on E: Exception do
    begin
      DoLog(lgError,'LoginDeviceStandart', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

Function TTcpRdrBase.LoginDevice: Integer;
Begin
  try
    case fProtocolType of
      PR0:
        Result := LoginDevicePr0;
      PR1:
        Result := LoginDevicePr1;
      PR2:
        Result := LoginDevicePr2;
      else Result := -1;
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'LoginDevice', 'Exception Error : ' + E.Message);
    end;
  end;
End;

function TTcpRdrBase.DoConnect: Integer;
Begin
  Result := ConnectIndy;
end;

function TTcpRdrBase.CheckConnection: Integer;
Begin
  Result := CheckConnectionIndy;
end;

function TTcpRdrBase.ReConnect: Integer;
Begin
  Result := ReConnectIndy;
end;

function TTcpRdrBase.ReConnectOnline: Integer;
Begin
  if ((fNextDeviceConnTime < Now) and (fOnlineEnabled)) then
  Begin
    fNextDeviceConnTime := Now;
    fNextDeviceConnTime := AddMSecToTime(fNextDeviceConnTime,fOnlineReConnectTimeOut);
    Result := ReConnect;
  End;
end;

function TTcpRdrBase.DoDisConnect(DisableOnline : Boolean): Integer;
Begin
  Result := DisConnectIndy(DisableOnline);
end;

function TTcpRdrBase.SetProtocol: Integer;
Begin
  try
    case fProtocolType of
      PR0:
        Result := SetProtocolPR0;
      PR1:
        Result := SetProtocolPR1;
      PR2:
        Result := SetProtocolPR2;
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'LoginDevice', 'Exception Error : ' + E.Message);
    end;
  end;
End;

function TTcpRdrBase.SetProtocolPR0: Integer;
Var
  uSerialCrc, uTCPCCrc, i: word;
  iErr: Integer;
Begin
  iErr := 0;
  try
    TxBuffer.u2Len := TxBuffer.Tx_DataLen + fTx_Protocol_Len;
    TxBuffer.uaBuff[fTx_TCP_Header_Pos] := $AA;
    TxBuffer.uaBuff[fTx_TCP_Header_Pos + 1] := $BB;
    TxBuffer.uaBuff[fTx_TCP_Len_Pos] := ((TxBuffer.u2Len - 6) mod 256);
    TxBuffer.uaBuff[fTx_TCP_Len_Pos + 1] := ((TxBuffer.u2Len - 6) div 256);
    TxBuffer.uaBuff[fTx_Serial_Header_Pos] := 2;
    TxBuffer.uaBuff[fTx_Serial_Header_Pos + 1] :=  (fSessionID) mod 256;
    TxBuffer.uaBuff[fTx_Serial_Len_Pos] := ((TxBuffer.Tx_DataLen + 2) mod 256);
    TxBuffer.uaBuff[fTx_Serial_Len_Pos + 1] :=
      ((TxBuffer.Tx_DataLen + 2) div 256);
    TxBuffer.uaBuff[fTx_Command_Pos] := TxBuffer.CmdNo;
    TxBuffer.uaBuff[fTx_SubCommand_Pos] := TxBuffer.SubCmdNo;
    TxBuffer.uaBuff[fTx_SessionID_Pos] := (fSessionID) div 256;

    // XOR lu Session ID
    TxBuffer.uaBuff[fTx_Data_Start_Pos + TxBuffer.Tx_DataLen]
        := 09 xor TxBuffer.uaBuff[fTx_Serial_Header_Pos + 1]; // SessionId1
    TxBuffer.uaBuff[fTx_Data_Start_Pos + TxBuffer.Tx_DataLen + 1]
        := 10 xor TxBuffer.uaBuff[fTx_SessionID_Pos]; // SessionId2

    // serial crc
    uSerialCrc := 0;
    for i := 0 to (TxBuffer.Tx_DataLen + 9 - 1) do
      ByteCrc(TxBuffer.uaBuff[fTx_Serial_Header_Pos + i], uSerialCrc);

    TxBuffer.uaBuff[fTx_Data_Start_Pos + TxBuffer.Tx_DataLen + 2] :=
      uSerialCrc mod 256; // Csum
    TxBuffer.uaBuff[fTx_Data_Start_Pos + TxBuffer.Tx_DataLen + 3] :=
      uSerialCrc div 256; // etx

    // tcp crc
    uTCPCCrc := 0;
    for i := 2 to TxBuffer.u2Len - 2 - 1 do
      ByteCrc(TxBuffer.uaBuff[i], uTCPCCrc);

    TxBuffer.uaBuff[TxBuffer.u2Len - 2] := uTCPCCrc mod 256; // CRC 16
    TxBuffer.uaBuff[TxBuffer.u2Len - 1] := uTCPCCrc div 256; // CRC 16
  except
    on E: Exception do
    begin
      DoLog(lgError,'SetTcpProtocolPR1', 'Exception Error : ' + E.Message);
      //gError('SetTcpProtocolPR1', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;

End;

function TTcpRdrBase.SetProtocolPR1: Integer;
Var
  uSerialCrc, uTCPCCrc, i: word;
  iErr: Integer;
Begin
  iErr := 0;
  try
    TxBuffer.u2Len := TxBuffer.Tx_DataLen + fTx_Protocol_Len;
    TxBuffer.uaBuff[fTx_TCP_Header_Pos] := $AA;
    TxBuffer.uaBuff[fTx_TCP_Header_Pos + 1] := $CC;
    TxBuffer.uaBuff[fTx_TCP_Len_Pos] := ((TxBuffer.u2Len - 6) mod 256);
    TxBuffer.uaBuff[fTx_TCP_Len_Pos + 1] := ((TxBuffer.u2Len - 6) div 256);
    TxBuffer.uaBuff[fTx_Serial_Header_Pos] := 2;
    TxBuffer.uaBuff[fTx_Serial_Header_Pos + 1] := 0;
    TxBuffer.uaBuff[fTx_Serial_Len_Pos] := ((TxBuffer.Tx_DataLen + 2) mod 256);
    TxBuffer.uaBuff[fTx_Serial_Len_Pos + 1] :=
      ((TxBuffer.Tx_DataLen + 2) div 256);
    TxBuffer.uaBuff[fTx_Command_Pos] := TxBuffer.CmdNo;
    TxBuffer.uaBuff[fTx_SubCommand_Pos] := TxBuffer.SubCmdNo;

    // serial crc
    uSerialCrc := 0;
    for i := 0 to (TxBuffer.Tx_DataLen + 6 - 1) do
      ByteCrc(TxBuffer.uaBuff[fTx_Serial_Header_Pos + i], uSerialCrc);

    TxBuffer.uaBuff[fTx_Data_Start_Pos + TxBuffer.Tx_DataLen] :=
      uSerialCrc mod 256; // Csum
    TxBuffer.uaBuff[fTx_Data_Start_Pos + TxBuffer.Tx_DataLen + 1] :=
      uSerialCrc div 256; // etx

    // tcp crc
    uTCPCCrc := 0;
    for i := 2 to TxBuffer.u2Len - 2 - 1 do
      ByteCrc(TxBuffer.uaBuff[i], uTCPCCrc);

    TxBuffer.uaBuff[TxBuffer.u2Len - 2] := uTCPCCrc mod 256; // CRC 16
    TxBuffer.uaBuff[TxBuffer.u2Len - 1] := uTCPCCrc div 256; // CRC 16
  except
    on E: Exception do
    begin
      DoLog(lgError,'SetTcpProtocolPR1', 'Exception Error : ' + E.Message);
      //gError('SetTcpProtocolPR1', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TTcpRdrBase.SetProtocolPR2: Integer;
Var
  uSerialCrc, uTCPCCrc, i: word;
  iErr: Integer;
Begin
  iErr := 0;
  try
    TxBuffer.u2Len := TxBuffer.Tx_DataLen + fTx_Protocol_Len;
    TxBuffer.uaBuff[fTx_TCP_Header_Pos] := $AA;
    TxBuffer.uaBuff[fTx_TCP_Header_Pos + 1] := $DD;
    TxBuffer.uaBuff[fTx_TCP_Len_Pos] := ((TxBuffer.u2Len - 6) mod 256);
    TxBuffer.uaBuff[fTx_TCP_Len_Pos + 1] := ((TxBuffer.u2Len - 6) div 256);
    TxBuffer.uaBuff[fTx_Serial_Header_Pos] := 2;
    TxBuffer.uaBuff[fTx_Serial_Header_Pos + 1] := 0;
    TxBuffer.uaBuff[fTx_Serial_Len_Pos] := ((TxBuffer.Tx_DataLen + 2) mod 256);
    TxBuffer.uaBuff[fTx_Serial_Len_Pos + 1] :=
      ((TxBuffer.Tx_DataLen + 2) div 256);
    TxBuffer.uaBuff[fTx_Command_Pos] := TxBuffer.CmdNo;
    TxBuffer.uaBuff[fTx_SubCommand_Pos] := TxBuffer.SubCmdNo;

    // serial crc
    uSerialCrc := 0;
    for i := 0 to (TxBuffer.Tx_DataLen + 6 - 1) do
      ByteCrc(TxBuffer.uaBuff[fTx_Serial_Header_Pos + i], uSerialCrc);

    TxBuffer.uaBuff[fTx_Data_Start_Pos + TxBuffer.Tx_DataLen] :=
      uSerialCrc mod 256; // Csum
    TxBuffer.uaBuff[fTx_Data_Start_Pos + TxBuffer.Tx_DataLen + 1] :=
      uSerialCrc div 256; // etx
    // tcp crc
    uTCPCCrc := 0;
    for i := 2 to TxBuffer.u2Len - 2 - 1 do
      ByteCrc(TxBuffer.uaBuff[i], uTCPCCrc);

    TxBuffer.uaBuff[TxBuffer.u2Len - 2] := uTCPCCrc mod 256; // CRC 16
    TxBuffer.uaBuff[TxBuffer.u2Len - 1] := uTCPCCrc div 256; // CRC 16
  except
    on E: Exception do
    begin
      DoLog(lgError,'SetTcpProtocolPR1', 'Exception Error : ' + E.Message);
      //gError('SetTcpProtocolPR1', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;


function TTcpRdrBase.CheckProtocol: integer;
Begin
  try
    case fProtocolType of
      PR0:
        Result := CheckProtocolPR0;
      PR1:
        Result := CheckProtocolPR1;
      PR2:
        Result := CheckProtocolPR2;
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'CheckProtocol', 'Exception Error : ' + E.Message);
      //gError('CheckProtocol', 'Exception Error : ' + E.Message);
    end;
  end;
End;

function TTcpRdrBase.CheckProtocolPR0: integer;
var
  iErr, i: integer;
  u2DataLen, uTCPCrc, SLen, uSerialCrc: word;
  tmpSessionID, xortmpSessionID,S1, S2: word;
label lend;
begin
  iErr := 0;
  try

    if RxBuffer.u2Len < 15 then
      iErr := TErrors.DATA_IS_NOT_ENOUGH;
    if iErr <> 0 then
      goto lend;

    if not((RxBuffer.uaBuff[fRx_TCP_Header_Pos] = $AA) and
      (RxBuffer.uaBuff[fRx_TCP_Header_Pos + 1] = $BB)) then
      iErr := TErrors.WRONG_TCP_HEADER;
    if iErr <> 0 then
      goto lend;

    u2DataLen := RxBuffer.uaBuff[fRx_TCP_Len_Pos] + RxBuffer.uaBuff
      [fRx_TCP_Len_Pos + 1] * 256;
    if RxBuffer.u2Len < (u2DataLen + 6) then
      iErr := TErrors.DATA_IS_NOT_ENOUGH;
    if iErr <> 0 then
      goto lend;

    uTCPCrc := 0;
    for i := 0 to 2 + u2DataLen - 1 do
      ByteCrc(RxBuffer.uaBuff[2 + i], uTCPCrc);

    if (RxBuffer.uaBuff[4 + u2DataLen + 0] + RxBuffer.uaBuff[4 + u2DataLen + 1]
      * 256) <> uTCPCrc then
      iErr := TErrors.WRONG_CRC;
    if iErr <> 0 then
      goto lend;

    if not(RxBuffer.uaBuff[fRx_Serial_Header_Pos] = 2) then
      iErr := TErrors.WRONG_SERIAL_HEADER;
    if iErr <> 0 then
      goto lend;

    SLen := RxBuffer.uaBuff[fRx_Serial_Len_Pos] + RxBuffer.uaBuff
      [fRx_Serial_Len_Pos + 1] * 256;
    if RxBuffer.u2Len < (SLen + 6 + 3) then
      iErr := TErrors.DATA_IS_NOT_ENOUGH;
    if iErr <> 0 then
      goto lend;

    uSerialCrc := 0;
    for i := 4 to RxBuffer.u2Len - 4 - 1 do
      ByteCrc(RxBuffer.uaBuff[i], uSerialCrc);

    if (RxBuffer.uaBuff[RxBuffer.u2Len - 4] + RxBuffer.uaBuff
      [RxBuffer.u2Len - 3] * 256) <> uSerialCrc then
      iErr := TErrors.WRONG_CSUM;
    if iErr <> 0 then
      goto lend;

    //
    tmpSessionID := RxBuffer.uaBuff[fRx_Serial_Header_Pos + 1] + RxBuffer.uaBuff
      [fRx_SessionID_Pos] * 256;
    S1 := 09 xor RxBuffer.uaBuff[RxBuffer.u2Len - 6];
    S2 := 10 xor RxBuffer.uaBuff[RxBuffer.u2Len - 5];
    xortmpSessionID := S1 + S2 * 256;

    if (tmpSessionID <> xortmpSessionID) then
      iErr := TErrors.SESSION_ID_MISMATCH;
    if iErr <> 0 then
      goto lend;

    if (tmpSessionID <> fSessionID) then
      iErr := TErrors.WRONG_SESSION_ID;
    if iErr <> 0 then
      goto lend;

    iErr := TErrors.NO_ERROR;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoLog(lgError,'CheckTcpProtocol', 'Exception:' + E.Message);
      //gError('CheckTcpProtocol', 'Exception:' + E.Message);
    end;
  end; // try
  Result := iErr;

End;

function TTcpRdrBase.CheckProtocolPR1: integer;
var
  iErr, i: integer;
  u2DataLen, uTCPCrc, SLen, uSerialCrc: word;
label lend;
begin
  iErr := 0;
  try

    if RxBuffer.u2Len < 15 then
      iErr := TErrors.DATA_IS_NOT_ENOUGH;
    if iErr <> 0 then
      goto lend;

    if not((RxBuffer.uaBuff[fRx_TCP_Header_Pos] = $AA) and
      (RxBuffer.uaBuff[fRx_TCP_Header_Pos + 1] = $CC)) then
      iErr := TErrors.WRONG_TCP_HEADER;
    if iErr <> 0 then
      goto lend;

    u2DataLen := RxBuffer.uaBuff[fRx_TCP_Len_Pos] + RxBuffer.uaBuff
      [fRx_TCP_Len_Pos + 1] * 256;
    if RxBuffer.u2Len < (u2DataLen + 6) then
      iErr := TErrors.DATA_IS_NOT_ENOUGH;
    if iErr <> 0 then
      goto lend;

    uTCPCrc := 0;
    for i := 0 to 2 + u2DataLen - 1 do
      ByteCrc(RxBuffer.uaBuff[2 + i], uTCPCrc);

    if (RxBuffer.uaBuff[4 + u2DataLen + 0] + RxBuffer.uaBuff[4 + u2DataLen + 1]
      * 256) <> uTCPCrc then
      iErr := TErrors.WRONG_CRC;
    if iErr <> 0 then
      goto lend;

    if not(RxBuffer.uaBuff[fRx_Serial_Header_Pos] = 2) then
      iErr := TErrors.WRONG_SERIAL_HEADER;
    if iErr <> 0 then
      goto lend;

    SLen := RxBuffer.uaBuff[fRx_Serial_Len_Pos] + RxBuffer.uaBuff
      [fRx_Serial_Len_Pos + 1] * 256;
    if RxBuffer.u2Len < (SLen + 6 + 3) then
      iErr := TErrors.DATA_IS_NOT_ENOUGH;
    if iErr <> 0 then
      goto lend;

    uSerialCrc := 0;
    for i := 4 to RxBuffer.u2Len - 4 - 1 do
      ByteCrc(RxBuffer.uaBuff[i], uSerialCrc);

    if (RxBuffer.uaBuff[RxBuffer.u2Len - 4] + RxBuffer.uaBuff
      [RxBuffer.u2Len - 3] * 256) <> uSerialCrc then
      iErr := TErrors.WRONG_CSUM;
    if iErr <> 0 then
      goto lend;

    iErr := TErrors.NO_ERROR;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoLog(lgError,'CheckTcpProtocol', 'Exception:' + E.Message);
      //gError('CheckTcpProtocol', 'Exception:' + E.Message);
    end;
  end; // try
  Result := iErr;
End;

function TTcpRdrBase.CheckProtocolPR2: integer;
var
  iErr, i: integer;
  u2DataLen, uTCPCrc, SLen, uSerialCrc: word;
label lend;
begin
  iErr := 0;
  try

    if RxBuffer.u2Len < 15 then
      iErr := TErrors.DATA_IS_NOT_ENOUGH;
    if iErr <> 0 then
      goto lend;

    if not((RxBuffer.uaBuff[fRx_TCP_Header_Pos] = $AA) and
      (RxBuffer.uaBuff[fRx_TCP_Header_Pos + 1] = $DD)) then
      iErr := TErrors.WRONG_TCP_HEADER;
    if iErr <> 0 then
      goto lend;

    u2DataLen := RxBuffer.uaBuff[fRx_TCP_Len_Pos] + RxBuffer.uaBuff
      [fRx_TCP_Len_Pos + 1] * 256;
    if RxBuffer.u2Len < (u2DataLen + 6) then
      iErr := TErrors.DATA_IS_NOT_ENOUGH;
    if iErr <> 0 then
      goto lend;

    uTCPCrc := 0;
    for i := 0 to 2 + u2DataLen - 1 do
      ByteCrc(RxBuffer.uaBuff[2 + i], uTCPCrc);

    if (RxBuffer.uaBuff[4 + u2DataLen + 0] + RxBuffer.uaBuff[4 + u2DataLen + 1]
      * 256) <> uTCPCrc then
      iErr := TErrors.WRONG_CRC;
    if iErr <> 0 then
      goto lend;

    if not(RxBuffer.uaBuff[fRx_Serial_Header_Pos] = 2) then
      iErr := TErrors.WRONG_SERIAL_HEADER;
    if iErr <> 0 then
      goto lend;

    SLen := RxBuffer.uaBuff[fRx_Serial_Len_Pos] + RxBuffer.uaBuff
      [fRx_Serial_Len_Pos + 1] * 256;
    if RxBuffer.u2Len < (SLen + 6 + 6) then
      iErr := TErrors.DATA_IS_NOT_ENOUGH;
    if iErr <> 0 then
      goto lend;

    uSerialCrc := 0;
    for i := 4 to RxBuffer.u2Len - 4 - 1 do
      ByteCrc(RxBuffer.uaBuff[i], uSerialCrc);

    if (RxBuffer.uaBuff[RxBuffer.u2Len - 4] + RxBuffer.uaBuff
      [RxBuffer.u2Len - 3] * 256) <> uSerialCrc then
      iErr := TErrors.WRONG_CSUM;
    if iErr <> 0 then
      goto lend;

    iErr := TErrors.NO_ERROR;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoLog(lgError,'CheckTcpProtocol', 'Exception:' + E.Message);
      //gError('CheckTcpProtocol', 'Exception:' + E.Message);
    end;
  end; // try
  Result := iErr;
End;

function TTcpRdrBase.ExecuteCmd(CmdNo, SubCmdNo, Acknowledge,
  DataLen: Integer; SendData: TDataByte; Out RecData: TDataByte;
  SelectTimeOut: Integer = 0;CmdRetry:Integer=0): Integer;
Var
  iErr, uRetry,lCmdRetry,i: Integer;
  StartTime: Cardinal;
  //TempBuffer: TTCPBuffer;
  CmdSuccess: boolean;
Begin
  if fConnected then
  begin
    fOnCmd := True;
    try
      try

        ResetTxBuffer;
        ResetRxBuffer;

        if CmdRetry <> 0 then
          lCmdRetry := CmdRetry
        else
          lCmdRetry := fDefcmdRetry;

        TxBuffer.CmdNo := CmdNo;
        TxBuffer.SubCmdNo := SubCmdNo;
        TxBuffer.Tx_Acknowledge := Acknowledge;
        TxBuffer.Tx_DataLen := DataLen;

        for I := 0 to TxBuffer.Tx_DataLen-1 do
          TxBuffer.uaBuff[fTx_Data_Start_Pos+i] := SendData[i];

        if SelectTimeOut <> 0 then
          TxBuffer.SelectTimeOut := SelectTimeOut
        else
          TxBuffer.SelectTimeOut := fDefSelectTimeout;

        StartTime := lTimeToMs(Now);
        CmdSuccess := False;
        iErr := SetProtocol;

        if (iErr = 0) then
        Begin
          uRetry := 0;
          repeat
            iErr := Send;
            if (iErr = 0) then
              iErr := Receive(StartTime);
            if (iErr = 0) then
            Begin
              if (Acknowledge = RxBuffer.Rx_Acknowledge) then
              Begin
                CmdSuccess := True;
                iErr := RxBuffer.Rx_Return_Valuse;
              End
              else
                iErr := TErrors.ACKNOWLEDGE_MISMATCH;
            End
            else
              inc(uRetry);
          until fAbort or (uRetry >= (lCmdRetry)) or CmdSuccess; // (iErr = 0);
          if uRetry > 3 Then
            DoLog(lgError,'uRetry-' + IntToStr(SubCmdNo), IntToStr(uRetry));
            //LogDebug('uRetry-' + IntToStr(SubCmdNo), IntToStr(uRetry));
        End;
        if (iErr = 0) and (RxBuffer.Rx_DataLen > 0) then
        Begin
          for I := 0 to RxBuffer.Rx_DataLen - 1 do
            RecData[i] := RxBuffer.uaBuff[ fRx_Data_Start_Pos + i];
        End;

      except
        on E: Exception do
        begin
          DoLog(lgError,'ExecuteCmd', 'Exception Error : ' + E.Message);
          iErr := TErrors.EXCEPTION;
          fOnCmd := False;
        end;
      end; // try
    finally
      fOnCmd := False;
    end;
  end
  else
    iErr := TErrors.NOT_CONNECTED;
  Result := iErr;
End;

function TTcpRdrBase.Send: integer;
begin
  Result := SendIndy;
end;

function TTcpRdrBase.Receive(const OprStartTime: Cardinal): integer;
begin
  Result := ReceiveIndy(OprStartTime);
end;

procedure TTcpRdrBase.DoOnCardRead(const CardID: string);
begin
  if Assigned(fOnCardRead) then
    fOnCardRead(Self, CardID);
end;
{
procedure TTcpRdrBase.DoOnLog(const Msg: string);
Begin
  if Assigned(fOnLog) then
    fOnLog(Self, Msg);
End;
}

procedure TTcpRdrBase.DoOnPasswordRead(const PassType :byte ;const Password :word ;const Code:LongWord);
Begin
  if Assigned(fOnPasswordReadEvent) then
    fOnPasswordReadEvent(Self, PassType,Password,Code);
End;

procedure TTcpRdrBase.DoOnInputText(const ConfirmationType :TInputConfirmationType ;const InputText :String);
Begin
  if Assigned(fOnInputTextEvent) then
    fOnInputTextEvent(Self, ConfirmationType,InputText);
End;

procedure TTcpRdrBase.DoOnTurnstileTurn(Const Success: Boolean;const CardID: string);
begin
  if Assigned(fOnTurnstileTurn) then
    fOnTurnstileTurn(Self,Success,CardID);
end;

procedure TTcpRdrBase.DoOnTagRead(const IO:byte;const TagID: string);
begin
  if Assigned(fOnTagRead) then
    fOnTagRead(Self,IO, TagID);
end;

procedure TTcpRdrBase.DoOnSerialReadStr(const SerialPortNo:byte;const Data:String);
begin
  if Assigned(fOnSerialReadStr) then
    fOnSerialReadStr(Self,SerialPortNo, Data);
end;

procedure TTcpRdrBase.DoOnDoorOpenAlarm(const DoorOpen :Boolean ;const OpenTime:LongWord );
Begin
  if Assigned(fOnDoorOpenAlarm) then
    fOnDoorOpenAlarm(Self,DoorOpen,OpenTime);
End;

procedure TTcpRdrBase.DoOnConnected;
begin
  if Assigned(fOnConnected) then
    fOnConnected(Self);
end;

procedure TTcpRdrBase.DoOnDisConnected;
begin
  if Assigned(fOnDisConnected) then
    fOnDisConnected(Self);
end;

/// //////////Indy Methods ///////////////////////////////////
procedure TTcpRdrBase.IdTCPClientStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  if AStatus in [hsDisconnecting,hsDisconnected] then
  Begin
    fConnected := False;
  End;
  if AStatus in [hsDisconnected] then
    DoOnDisConnected;
  DoLog(lgDebug,'TCPClientStatus','Status : '+AStatusText);
end;

procedure TTcpRdrBase.CheckOnlineData;
var
  iRx ,i,iErr: Integer;
  ReadRxBuffer: TIdBytes;
  CardID,DataStr: String;
  RecData: TDataByte;
  TurnSucces: Boolean;
  IO,SerialPort : Integer;
  ltimeout : LongWord;
  DoorOpen : Boolean;
  PassType :byte ;
  Password :word ;
  Code : LongWord;
  InputConfType : TInputConfirmationType;
  InputText:String;
  position : Integer;
Begin
  if ((not fOnCmd) and fAutoRxEnabled) then
  Begin
    if fConnected then
    Begin
      try
        if Assigned(fIdTCPClient.Socket) then
          fConnected := fIdTCPClient.Socket.Connected
        else
          fConnected := True;
      except
        on E: Exception do
        begin
          fConnected := False;
          DoLog(lgError,'CheckOnlineData', 'Exception:' + E.Message);
        end;
      end; // try
    end;

    if fConnected then
    Begin
      iRx := 0;
      if fIdTCPClient.Socket.InputBufferIsEmpty then
        fIdTCPClient.Socket.CheckForDataOnSource(5);
      iRx := fIdTCPClient.Socket.InputBuffer.Capacity;

      if iRx > 0 then
      Begin
        fOnCmd := True; //burasý sonra düþünülecek.
        try
          fIdTCPClient.Socket.InputBuffer.ExtractToBytes(ReadRxBuffer);
          for i := 0 to iRx - 1 do
            RxBuffer.uaBuff[i] := ReadRxBuffer[i];
          RxBuffer.u2Len := iRx;
          iErr := CheckProtocol;
          if (iErr = 0) then
          begin
            RxBuffer.Rx_Acknowledge := RxBuffer.uaBuff[fRx_Acknowledge_Pos];
            RxBuffer.Rx_DataLen := RxBuffer.u2Len - fRx_Protocol_Len;
            RxBuffer.Rx_Return_Valuse := RxBuffer.uaBuff[fRx_Return_Value_Pos];
            // To Do protokol 0 için session ID
            //RxBuffer.Rx_SessionId := RxBuffer.uaBuff[fRx_SessionID_Pos];
            //RxBuffer.Rx_XORSessionId := RxBuffer.uaBuff[fRx_Return_Value_Pos];
            if RxBuffer.Rx_Acknowledge = 35 then
            Begin
              for I := 0 to RxBuffer.Rx_DataLen - 1 do
                RecData[i] := RxBuffer.uaBuff[ fRx_Data_Start_Pos + i];
              CardID := prBytesToHex(RecData,3,7);
              DoOnCardRead(CardID);
            End;
            if RxBuffer.Rx_Acknowledge = 55 then
            Begin
              for I := 0 to RxBuffer.Rx_DataLen - 1 do
                RecData[i] := RxBuffer.uaBuff[ fRx_Data_Start_Pos + i];
              TurnSucces := prBytesToBoolean(RecData,0);
              CardID := prBytesToHex(RecData,1,7);
              DoOnTurnstileTurn(TurnSucces,CardID);
            End;
            if RxBuffer.Rx_Acknowledge = 56 then
            Begin
              for I := 0 to RxBuffer.Rx_DataLen - 1 do
                RecData[i] := RxBuffer.uaBuff[ fRx_Data_Start_Pos + i];
              CardID := prBytesToHex(RecData,3,8);
              IO := RecData[11];
              DoOnTagRead(IO,CardID);
            End;
            if RxBuffer.Rx_Acknowledge = 57 then
            Begin
              for I := 0 to RxBuffer.Rx_DataLen - 1 do
                RecData[i] := RxBuffer.uaBuff[ fRx_Data_Start_Pos + i];
              DoorOpen := prBytesToBoolean(RecData,0);
              ltimeout := prBytesToLongWord(RecData,1);
              ltimeout := (ltimeout div 1000);
              DoOnDoorOpenAlarm(DoorOpen,ltimeout);
            End;
            if RxBuffer.Rx_Acknowledge = 58 then
            Begin
              for I := 0 to RxBuffer.Rx_DataLen - 1 do
                RecData[i] := RxBuffer.uaBuff[ fRx_Data_Start_Pos + i];
              SerialPort := RecData[0];
              DataStr := prByteToString (RecData,1,RxBuffer.Rx_DataLen - 1);
              DoOnSerialReadStr(SerialPort,DataStr);
            End;
            if RxBuffer.Rx_Acknowledge = 59 then
            Begin
              for I := 0 to RxBuffer.Rx_DataLen - 1 do
                RecData[i] := RxBuffer.uaBuff[ fRx_Data_Start_Pos + i];

              PassType := RecData[3];
              Password := prBytesToWord(RecData,4);
              Code := prBytesToLongWord(RecData,6);
              DoOnPasswordRead(PassType,Password,Code);
            End;
            if RxBuffer.Rx_Acknowledge = 43 then
            Begin
              for I := 0 to RxBuffer.Rx_DataLen - 1 do
                RecData[i] := RxBuffer.uaBuff[ fRx_Data_Start_Pos + i];

              if RecData[0] = 0 Then
                InputConfType := ctOk
              else
                InputConfType := ctCancel;
              InputText := prByteToString(RecData,1,RxBuffer.Rx_DataLen - 1);
              position := Pos('-',InputText);
              if position <> 0 then
                InputText := copy(InputText,1,position-1);
              DoOnInputText(InputConfType,InputText);
            End;

          end;
        finally
          fOnCmd := false;
        end;
      End;

    End else
      ReConnectOnline;

    if fConnected and fSyncServerEnabled then
    //GetSyncServerEnabled
    Begin
      SyncServer;
    End;
  End;

End;

function TTcpRdrBase.GetSyncServerEnabled:Boolean;
Begin
  InitializeCriticalSection(CSRdr);
  try
    EnterCriticalSection(CSRdr);
    Result := fSyncServerEnabled;
  finally
    LeaveCriticalSection(CSRdr);
  end;
End;

procedure TTcpRdrBase.SetSyncServerEnabled(value : Boolean);
Begin
  InitializeCriticalSection(CSRdr);
  try
    EnterCriticalSection(CSRdr);
    fSyncServerEnabled := Value;
  finally
    LeaveCriticalSection(CSRdr);
  end;
End;

Procedure TTcpRdrBase.SyncServer;
Begin

End;

function TTcpRdrBase.ConnectIndy: Integer;
Var
  iErr: Integer;
Begin
  try
    if Assigned(fIdTCPClient) then
    Begin
      tryDisconnectIndy;
      fIdTCPClient.Host := fIP;
      fIdTCPClient.Port := StrToInt(fPort);
      fIdTCPClient.OnStatus := IdTCPClientStatus;

      fIdTCPClient.Connect;
      fIdTCPClient.Socket.Binding.SetKeepAliveValues(True,5000,1000);
      if fIdTCPClient.Connected then
      begin
        fConnected := True;
        iErr := LoginDevice
      end
      else
        iErr := TErrors.CANNOT_CONNECT;
    End
    else
      iErr := TErrors.NOT_CREATED_TCPCOMP;
  except
    on E: Exception do
    begin
      DoLog(lgError,'ConnectIndy', 'Exception Error 1 : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  fConnected := (iErr = 0);
  if fConnected then
  Begin
    DoLog(lgDebug,'Connect', 'Connected');
    //LogDebug('Connect', 'Connected');
    DoOnConnected;
    if fAutoRxEnabled then
    Begin
      if not Assigned(fCheckOnlineThread) then
        fCheckOnlineThread := TCheckOnlineThread.Create(fOnlineThreadWaitTime,self);
      fCheckOnlineThread.SetEnable;
      fOnlineEnabled := True;
    End;
  End
  else
  Begin
    DoLog(lgDebug,'ConnectIndy', 'Not Connected');
    //LogDebug('ConnectIndy', 'Not Connected');
  End;
  Result := iErr;
End;

function TTcpRdrBase.tryDisconnectIndy:Boolean;
Begin
  Result := False;
  try
    if Assigned(fIdTCPClient.Socket) then
    Begin
      fIdTCPClient.Disconnect;
      fIdTCPClient.IOHandler.InputBuffer.Clear;
      fIdTCPClient.IOHandler.CloseGracefully;
      fIdTCPClient.Disconnect;
      fIdTCPClient.IOHandler.CloseGracefully;
      fIdTCPClient.IOHandler.InputBuffer.Clear;
      fIdTCPClient.Disconnect;
      if fIdTCPClient.Socket.Connected then
      Begin
        fIdTCPClient.IOHandler.CloseGracefully;
        fIdTCPClient.IOHandler.InputBuffer.Clear;
        fIdTCPClient.Disconnect;
        Sleep(500);
        fIdTCPClient.IOHandler.CloseGracefully;
        fIdTCPClient.IOHandler.InputBuffer.Clear;
        fIdTCPClient.Disconnect;
      End;
    End
    else
      fIdTCPClient.Disconnect;
    if Assigned(fIdTCPClient.Socket) then
      Result := not fIdTCPClient.Socket.Connected
    else
      Result := True;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tryDisconnectIndy', 'Exception Error : ' + E.Message);
   end;
  end; // try
End;

function TTcpRdrBase.DisConnectIndy(DisableOnline : Boolean): Integer;
Var
  iErr: Integer;
Begin
  try
    fOnlineEnabled := not DisableOnline;
    if Assigned(fCheckOnlineThread) and DisableOnline then
      fCheckOnlineThread.SetDisable;
    if Assigned(fIdTCPClient) then
    Begin
      if tryDisconnectIndy Then
        DoLog(lgDebug,'DisConnectIndy','Device disconnected.')
      else
        DoLog(lgDebug,'DisConnectIndy','Device not disconnected.');
      fConnected := False;
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'DisConnectIndy', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
      fConnected := False;
    end;
  end; // try
  Result := iErr;
End;

function TTcpRdrBase.CheckConnectionIndy: Integer;
Var
  iErr: Integer;
Begin
  try
    if fConnected then
    Begin
      if Assigned(fIdTCPClient) then
      begin
        if Assigned(fIdTCPClient.Socket) then
        Begin
          if fIdTCPClient.Socket.Connected Then
            iErr := TErrors.NO_ERROR
          else
            iErr := TErrors.NOT_CONNECTED;
        End else
          iErr := TErrors.NOT_CREATED_TCP_SOCKET;
      end
      else
        iErr := TErrors.NOT_CREATED_TCPCOMP;
    End
    else
      iErr := TErrors.NOT_CONNECTED;
  except
    on E: Exception do
    begin
      DoLog(lgError,'CheckConnection','Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  if (iErr <> 0) and fAutoConnect then
  Begin
    iErr := ReConnect;
  End;
  fConnected := (iErr = 0);
  Result := iErr;
End;

function TTcpRdrBase.ReConnectIndy: Integer;
Var
  iErr: Integer;
Begin
  DoLog(lgDebug,'ReConnect','ReConnect 1');
  try
    DoDisConnect(false);
  except
    on E: Exception do
    begin
      DoLog(lgError,'ReConnect DisConnect', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  try
    iErr := DoConnect;
  except
    on E: Exception do
    begin
      DoLog(lgError,'ReConnect Connect', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TTcpRdrBase.SendIndy: integer;
var
  iErr,i, Sendlen: integer;
  tmpBuff:TIdBytes;
label lend;
begin
  try
    iErr := CheckConnection;
    if iErr <> 0 then
      goto lend;
    if fAbort then
      iErr := TErrors.CANCELED_BY_USER; // Error:  Canlceled by user!
    if iErr <> 0 then
      goto lend;
    fIdTCPClient.Socket.WriteBufferClear;

    SetLength(tmpBuff,TxBuffer.u2Len);
    for I := 0 to TxBuffer.u2Len-1 do
      tmpBuff[i] := TxBuffer.uaBuff[i];
    fIdTCPClient.Socket.Write(tmpBuff,TxBuffer.u2Len);
      iErr := TErrors.NO_ERROR;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoLog(lgError,'Send', 'Send Exception:' + E.Message);
      if E is EIdConnClosedGracefully then
      Begin
        ReConnect;
      End;
    end;
  end; // try
  Result := iErr;
End;

function TTcpRdrBase.ReceiveIndy(const OprStartTime: Cardinal): integer;
var
  iErr, iRx, i: integer;
  bRxSession: boolean;
  ReadRxBuffer: TIdBytes;
  TimeoutasParam: Cardinal;
//  ReadSelect, WriteSelect, ErrorSelect: boolean;
label lend;
begin
  try
    bRxSession := True;
    TimeoutasParam := fTimeOut;

    iErr := CheckConnection;
    if iErr <> 0 then
      goto lend;

    repeat
      sleep(1);
      if fAbort then
      Begin
        iErr := TErrors.CANCELED_BY_USER; // Error:  Canceled by user!
        bRxSession := False;
      end;

      fIdTCPClient.Socket.CheckForDataOnSource(TxBuffer.SelectTimeOut);
      iRx := fIdTCPClient.Socket.InputBuffer.Capacity;
      if iRx > 0 then
      begin
        //SetLength(ReadRxBuffer,iRx);
        if (iRx + RxBuffer.u2Len) > length(RxBuffer.uaBuff) then
        begin
          iRx := length(RxBuffer.uaBuff) - RxBuffer.u2Len;
        end;

        fIdTCPClient.Socket.InputBuffer.ExtractToBytes(ReadRxBuffer);

        if ((ReadRxBuffer[0] = 0) and (ReadRxBuffer[1] = 0)) then
        begin
          iRx := 0;
        end
        else
        Begin
          for i := 0 to iRx - 1 do
            RxBuffer.uaBuff[RxBuffer.u2Len + i] := ReadRxBuffer[i];
          RxBuffer.u2Len := RxBuffer.u2Len + iRx;
        End;
      end; // if iRx > 0 then

      if (iRx > 0) then
        iErr := CheckProtocol
      else
        iErr := TErrors.DATA_IS_NOT_ENOUGH;

      if (iErr = 0) then
      begin
        RxBuffer.Rx_Acknowledge := RxBuffer.uaBuff[fRx_Acknowledge_Pos];
        RxBuffer.Rx_DataLen := RxBuffer.u2Len - fRx_Protocol_Len;
        RxBuffer.Rx_Return_Valuse := RxBuffer.uaBuff[fRx_Return_Value_Pos];
        // To Do protokol 0 için session ID
        //RxBuffer.Rx_SessionId := RxBuffer.uaBuff[fRx_SessionID_Pos];
        //RxBuffer.Rx_XORSessionId := RxBuffer.uaBuff[fRx_Return_Value_Pos];
        iErr := TErrors.NO_ERROR;
        bRxSession := False;
      end
      else if (iErr = TErrors.DATA_IS_NOT_ENOUGH) then
      begin
        bRxSession := False;
      end
      else //
      begin
        // Sonra Düþünülecek
        bRxSession := False;
      end; // else // if i4Err = -9 then

      if bRxSession then
      begin
        if ((OprStartTime + TimeoutasParam) <= lTimeToMs(Now)) then
        begin
          // rx timeout
          bRxSession := False;
        end;
      end;
    until not bRxSession;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoLog(lgError,'Receive', 'Exception:' + E.Message);
    end;
  end; // try
  Result := iErr;
End;

procedure TTcpRdrBase.DoLog(LogLevel: TprLogLevel; const aMethodName,
  aMsg: string; ErrorID: Integer);
var
  LogMsg: string;
begin
  if Assigned(FOnLog) then
  Begin
    if ErrorID <> 0 then
      LogMsg := '[' + aMethodName + '] [' + ErrorID.ToString() + ']' + aMsg
    else
      LogMsg := '[' + aMethodName + '] ' + aMsg;
    FOnLog(Self,LogLevel, LogMsg);
  End;
end;

/// //////////Indy Methods ///////////////////////////////////

function TCustomTcpRdr.Connect: Boolean;
Begin
  Result := (DoConnect =0);
End;

function TCustomTcpRdr.DisConnect: Boolean;
Begin
  Result := (DoDisConnect(True) =0);
End;

///// Device General Functions
function TCustomTcpRdr.tcpSetDeviceLoginKey(Key: array of Byte): Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
  tmpPassWord : array[0..15] of byte;
Begin
  try
    iErr := EncryptDeviceKey(Key,tmpPassWord);
    if iErr = 0 then
    Begin
      for i := 0 to 15 do
        SendData[i] := tmpPassWord[i];
      iErr := ExecuteCmd(2, // CmdNo
        1, // SubCmdNo
        1, // Acknowledge
        16, // DataLen
        SendData, RecData // SelectTimeOut
        );
    End
    else
      iErr := TErrors.NOT_ENCYRPTED;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetDevicePassword', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetDeviceGeneralSettings(out rSettings : TGeneralDeviceSettings) : Integer; // CMD 2.2
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      2, // SubCmdNo
      2, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
      rSettings.DefaultScreenTxt1:=prByteToString(RecData,0,16);
      rSettings.DefaultScreenTxt2:=prByteToString(RecData,16,16);
      rSettings.CardReadBeepTime := RecData[32];
      if RecData[33] = 0 then
        rSettings.TrOut1Type := NrOpen
      else
        rSettings.TrOut1Type := NrClosed;
      if RecData[34] = 0 then
        rSettings.TrOut2Type := NrOpen
      else
        rSettings.TrOut2Type := NrClosed;
      if RecData[35] = 0 then
        rSettings.IdleScreenType := stText
      else
        rSettings.IdleScreenType := stLogo;
      rSettings.DailyRebootEnb := prBytesToBoolean(RecData,36);
      rSettings.RebootTime := EncodeTime(RecData[37],RecData[38],0,0);
      rSettings.DevNo := prBytesToWord(RecData,39);
      rSettings.Backlight := prBytesToWord(RecData,41);
      rSettings.Contrast := prBytesToWord(RecData,43) ;
      rSettings.CardReadTimeOut := prBytesToWord(RecData,45);
      rSettings.VariableClearTimeout := prBytesToWord(RecData,47);
      rSettings.DefaultScreenFontType := RecData[49];
      rSettings.CardReadDelay := RecData[50];
      rSettings.StatusMode := RecData[51];
      rSettings.StatusModeType := RecData[52];
      rSettings.Pin_BUTTON_Type := RecData[53];
      for i := 0 to 5 do
        rSettings.RFU[i] := RecData[i+54];
    end;

  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetDeviceGeneralSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetDeviceGeneralSettings(rSettings:TGeneralDeviceSettings) : Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(rSettings.DefaultScreenTxt1,SendData,0,16);
    ToPrBytes(rSettings.DefaultScreenTxt2,SendData,16,16);
    SendData[32] := rSettings.CardReadBeepTime;
    if rSettings.TrOut1Type = NrOpen then
      SendData[33] := 0
    else
      SendData[33] := 1;
    if rSettings.TrOut2Type = NrOpen then
      SendData[34] := 0
    else
      SendData[34] := 1;
    case rSettings.IdleScreenType of
      stText : SendData[35] := 0;
      stLogo : SendData[35] := 1;
    end;
    ToPrBytes(rSettings.DailyRebootEnb,SendData,36);
    ToPrBytes(rSettings.RebootTime,SendData,37,2);
    ToPrBytes(rSettings.DevNo,SendData,39);
    ToPrBytes(rSettings.Backlight,SendData,41);
    ToPrBytes(rSettings.Contrast,SendData,43);
    ToPrBytes(rSettings.CardReadTimeOut,SendData,45);
    ToPrBytes(rSettings.VariableClearTimeout,SendData,47);
    ToPrBytes(rSettings.DefaultScreenFontType,SendData,49);
    ToPrBytes(rSettings.CardReadDelay,SendData,50);
    ToPrBytes(rSettings.StatusMode,SendData,51);
    ToPrBytes(rSettings.StatusModeType,SendData,52);
    ToPrBytes(rSettings.Pin_BUTTON_Type,SendData,53);
    for i := 0 to 5 do
      SendData[i+54] := rSettings.RFU[i];

    iErr := ExecuteCmd(2, // CmdNo
      3, // SubCmdNo
      3, // Acknowledge
      60,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetDeviceGeneralSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetDeviceTCPSettings(out rSettings : TTCPSettings) : Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      4, // SubCmdNo
      4, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
      rSettings.IPAdress := prBytesToIPv4Str(RecData,0);
      rSettings.DefGetway := prBytesToIPv4Str(RecData,4);
      rSettings.NetMask := prBytesToIPv4Str(RecData,8);
      rSettings.PriDNS := prBytesToIPv4Str(RecData,12);
      rSettings.SecDNS := prBytesToIPv4Str(RecData,16);
      rSettings.Port := prBytesToWord(RecData,20);
      rSettings.RemIpAdress := prBytesToIPv4Str(RecData,22);
      rSettings.DHCP := prBytesToBoolean(RecData,26);
      rSettings.ConnectOnlyRemIpAdress := prBytesToBoolean(RecData,27);
      case RecData[28] of
        0 : rSettings.ProtocolType := PR0;
        1 : rSettings.ProtocolType := PR1;
        2 : rSettings.ProtocolType := PR2;
      end;
      rSettings.ServerEchoTimeOut := RecData[29];
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetDeviceTCPSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;


function TCustomTcpRdr.tcpSetDeviceTCPSettings(rSettings:TTCPSettings) : Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := 0;
    if not ToPrBytesfromIPv4Str(rSettings.IPAdress,SendData,0) Then
       iErr := TErrors.INVALID_IP_ADRESS;
    if iErr = 0 then
       if not ToPrBytesfromIPv4Str(rSettings.DefGetway ,SendData,4) then
         iErr := TErrors.INVALID_IP_ADRESS;
    if iErr = 0 then
       if not ToPrBytesfromIPv4Str(rSettings.NetMask,SendData,8) then
         iErr := TErrors.INVALID_IP_ADRESS;
    if iErr = 0 then
       if not ToPrBytesfromIPv4Str(rSettings.PriDNS,SendData,12) then
         iErr := TErrors.INVALID_IP_ADRESS;
    if iErr = 0 then
       if not ToPrBytesfromIPv4Str(rSettings.SecDNS,SendData,16) then
         iErr := TErrors.INVALID_IP_ADRESS;
    if iErr = 0 then
       if not ToPrBytesfromIPv4Str(rSettings.RemIpAdress,SendData,22) then
         iErr := TErrors.INVALID_IP_ADRESS;

    if iErr = 0  then
    begin
      ToPrBytes(rSettings.Port,SendData,20);
      ToPrBytes(rSettings.DHCP,SendData,26);
      ToPrBytes(rSettings.ConnectOnlyRemIpAdress,SendData,27);
      case rSettings.ProtocolType of
        PR0 : SendData[28] := 0;
        PR1 : SendData[28] := 1;
        PR2 : SendData[28] := 2;
      end;
      SendData[29] := rSettings.ServerEchoTimeOut;

      iErr := ExecuteCmd(2, // CmdNo
        5, // SubCmdNo
        5, // Acknowledge
        30,  // DataLen
        SendData, RecData // SelectTimeOut
        );
    end;

  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetDeviceTCPSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetDeviceUDPSettings(out rSettings:TUDPSettings) : Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      6, // SubCmdNo
      6, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
      rSettings.UDPIsActive := prBytesToBoolean(RecData,0);
      rSettings.UDPLogIsActive := prBytesToBoolean(RecData,1);
      rSettings.RemUDPAdress := prBytesToIPv4Str(RecData,2);
      rSettings.UDPPort := prBytesToWord(RecData,6);
      rSettings.RFU := RecData[8];
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetDeviceUDPSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetDeviceUDPSettings(rSettings:TUDPSettings) : Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := 0;
    if not ToPrBytesfromIPv4Str(rSettings.RemUDPAdress,SendData,2) Then
       iErr := TErrors.INVALID_IP_ADRESS;
    if iErr = 0  then
    begin

      ToPrBytes(rSettings.UDPIsActive,SendData,0);
      ToPrBytes(rSettings.UDPLogIsActive,SendData,1);

      ToPrBytes(rSettings.UDPPort,SendData,6);
      SendData[8] := rSettings.RFU;

      iErr := ExecuteCmd(2, // CmdNo
        7, // SubCmdNo
        7, // Acknowledge
        9,  // DataLen
        SendData, RecData // SelectTimeOut
        );
    end;

  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetDeviceUDPSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetMACAddress(out MacAddr:String) : Integer;
Var
  iErr : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      8, // SubCmdNo
      8, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
        MacAddr := prBytesToHex(RecData,0,6);
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetMACAddress', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetMACAddress(MacAddr:String) : Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(MacAddr,SendData,0,0);
    iErr := ExecuteCmd(2, // CmdNo
      9, // SubCmdNo
      9, // Acknowledge
      6, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetMACAddress', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TCustomTcpRdr.tcpGetDeviceWorkModeSettings(out rSettings : TWorkModeSettings) : Integer; // CMD 2.10
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      10, // SubCmdNo
      10, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
      case RecData[0] of
        0 : rSettings.WorkingMode := wmOffline ;
        1 : rSettings.WorkingMode := wmOfflineCard;
        2 : rSettings.WorkingMode := wmTCPOnline ;
        3 : rSettings.WorkingMode := wmUDPOnline ;
        4 : rSettings.WorkingMode := wmTCPOnlineClientMode;
      end;
      rSettings.OfflineModePermission := prBytesToBoolean(RecData,1);
      rSettings.ServerAnswerTimeOut := prBytesToLongWord(RecData,2);
      rSettings.OfflineOnlineMode := TOnlineCardWorkMode(RecData[6]);

      for I := 0 to 4 do
        rSettings.RFU[i] := RecData[i+7];
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetDeviceWorkModeSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetDeviceWorkModeSettings(rSettings : TWorkModeSettings) : Integer; // CMD 2.11
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    case rSettings.WorkingMode of
      wmOffline : SendData[0] := 0;
      wmOfflineCard : SendData[0] := 1;
      wmTCPOnline : SendData[0] := 2;
      wmUDPOnline : SendData[0] := 3;
      wmTCPOnlineClientMode : SendData[0] := 4;
      wmSendSerail : SendData[0] := 5;
    end;
    ToPrBytes(rSettings.OfflineModePermission,SendData,1);
    ToPrBytes(rSettings.ServerAnswerTimeOut,SendData,2);
    ToPrBytes(byte(rSettings.OfflineOnlineMode),SendData,6);
    for I := 0 to 4 do
      SendData[i+7] := rSettings.RFU[i];

    iErr := ExecuteCmd(2, // CmdNo
      11, // SubCmdNo
      11, // Acknowledge
      12,  // DataLen
      SendData, RecData // SelectTimeOut
      );

  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetDeviceWorkModeSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetWebPassword(Out WebPassword:string):Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      12, // SubCmdNo
      12, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
      WebPassword := '';
      for i := 0 to 19 do
        WebPassword := WebPassword + chr(RecData[i]);
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetWEbPassword', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TCustomTcpRdr.tcpSetWebPassword(WebPassword:string):Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for i := 0 to 19 do
    begin
      if Length(WebPassword) > i then
        SendData[i] := Ord(WebPassword[i+1])
      else
        SendData[i] := 0;
    end;

    iErr := ExecuteCmd(2, // CmdNo
      13, // SubCmdNo
      13, // Acknowledge
      20, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetWebPassword', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TCustomTcpRdr.tcpSetDeviceFactoryDefault(ResetIP:Boolean):Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    if ResetIP then
      SendData[0] := 1
    else
      SendData[0] := 0;
    iErr := ExecuteCmd(2, // CmdNo
      14, // SubCmdNo
      14, // Acknowledge
      1, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetFactoryDefault', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TCustomTcpRdr.tcpGetSerialNumber(out SerialArr : array of byte) : Integer; // CMD 2.15
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      15, // SubCmdNo
      15, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    Begin
      //SetLength(SerialArr,16);
      for I := 0 to 15 do
        SerialArr[i] := RecData[i];
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetSerialNumber', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TCustomTcpRdr.tcpSetSerialNumber(SerialArr : array of byte) : Integer; // CMD 2.16
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for I := 0 to 15 do
      SendData[i] := SerialArr[i];

    iErr := ExecuteCmd(2, // CmdNo
      16, // SubCmdNo
      16, // Acknowledge
      16, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetSerialNumber', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TCustomTcpRdr.tcpReboot: Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      17, // SubCmdNo
      17, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpReboot', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetFwVwersion(out fWVersion:string):Integer;
Var
  iErr, i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      18, // SubCmdNo
      18, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
      for i := 0 to 15 do
        fWVersion := fWVersion + Chr(RecData[i]);
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetFwVwersion', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TCustomTcpRdr.tcpSetDateTime(dt:TDateTime): Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := Hourof(dt);
    SendData[1] := Minuteof(dt);
    SendData[2] := Secondof(dt);
    SendData[3] := Dayof(dt);
    SendData[4] := Monthof(dt);
    SendData[5] := Yearof(dt)-2000;

    iErr := ExecuteCmd(2, // CmdNo
      19, // SubCmdNo
      19, // Acknowledge
      6, // DataLen
      SendData, RecData // SelectTimeOut
      );

  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetDateTime', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetMfrKeyList(out KeyList : TMfrKeyList) : Integer; // CMD 2.20
Var
  iErr ,i ,j: Integer;
  SendData, RecData,KeyData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      20, // SubCmdNo
      20, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    Begin
      if DecryptMfrKeyData(RecData,KeyData) = 0 then
      Begin
        for I := 0 to 15 do
          for j := 0 to 5 do
          Begin
            KeyList.Sector[i].KeyA[j] := KeyData[i*12+j];
            KeyList.Sector[i].KeyB[j] := KeyData[i*12+j+6];
          End;

      End else iErr := -99;
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetMfrKeyList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetMfrKeyList(KeyList : TMfrKeyList) : Integer; // CMD 2.21
Var
  iErr ,i,j : Integer;
  SendData, RecData,KeyData: TDataByte;
Begin
  try
    for I := 0 to 15 do
      for j := 0 to 5 do
      Begin
        KeyData[i*12+j  ] := KeyList.Sector[i].KeyA[j];
        KeyData[i*12+j+6] := KeyList.Sector[i].KeyB[j];
      End;
    iErr := EncryptMfrKeyData(KeyData,SendData);
    if  iErr = 0 then
    Begin
      iErr := ExecuteCmd(2, // CmdNo
        21, // SubCmdNo
        21, // Acknowledge
        192, // DataLen
        SendData, RecData // SelectTimeOut
        );
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetMfrKeyList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetHeadTailCapacity(out Head,Tail,Capacity:LongWord): Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      22, // SubCmdNo
      22, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if (iErr = 0) then
    Begin
      Head := RecData[0] +
             (RecData[1]*256) +
             (RecData[2]*256*256);

      Tail := RecData[3] +
             (RecData[4]*256) +
             (RecData[5]*256*256);

      Capacity := RecData[6] +
                 (RecData[7]*256) +
                 (RecData[8]*256*256);
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetHeadTailCapacity', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetHeadTail(Head,Tail:Cardinal): Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] :=  Head          and $FF;
    SendData[1] := (Head shr 8)  and $FF;
    SendData[2] := (Head shr 16) and $FF;
    SendData[3] :=  Tail          and $FF;
    SendData[4] := (Tail shr 8)  and $FF;
    SendData[5] := (Tail shr 16) and $FF;
    iErr := ExecuteCmd(2, // CmdNo
      23, // SubCmdNo
      23, // Acknowledge
      6, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetHeadTail', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetDeviceStatus(out StatusEnb:Boolean) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      24, // SubCmdNo
      24, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if (iErr = 0) then
    Begin
      StatusEnb := prBytesToBoolean(RecData,0);
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetDeviceStatus', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetDeviceStatus(StatusEnb:Boolean) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(StatusEnb,SendData,0);
    iErr := ExecuteCmd(2, // CmdNo
      25, // SubCmdNo
      25, // Acknowledge
      1, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetDeviceStatus', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetLCDMessages(ID : longword;out LcdScreenMsg:TLcdScreen) : Integer; // CMD 2.26
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(ID,SendData,0);
    iErr := ExecuteCmd(2, // CmdNo
      26, // SubCmdNo
      26, // Acknowledge
      2, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if (iErr = 0) then
    Begin
      LcdScreenMsg.ID := prBytesToWord(RecData,0);
      LcdScreenMsg.HeaderType := RecData[2];
      LcdScreenMsg.Caption := prByteToString(RecData,3,21);
      LcdScreenMsg.Line[0].Text := prByteToString(RecData,24,21);
      LcdScreenMsg.Line[0].X := RecData[45];
      LcdScreenMsg.Line[0].Y := RecData[46];
      LcdScreenMsg.Line[0].Alligment := RecData[47];
      LcdScreenMsg.Line[1].Text := prByteToString(RecData,48,21);
      LcdScreenMsg.Line[1].X := RecData[69];
      LcdScreenMsg.Line[1].Y := RecData[70];
      LcdScreenMsg.Line[1].Alligment := RecData[71];
      LcdScreenMsg.Line[2].Text := prByteToString(RecData,72,21);
      LcdScreenMsg.Line[2].X := RecData[93];
      LcdScreenMsg.Line[2].Y := RecData[94];
      LcdScreenMsg.Line[2].Alligment := RecData[95];
      LcdScreenMsg.Line[3].Text := prByteToString(RecData,96,21);
      LcdScreenMsg.Line[3].X := RecData[117];
      LcdScreenMsg.Line[3].Y := RecData[118];
      LcdScreenMsg.Line[3].Alligment := RecData[119];
      LcdScreenMsg.Line[4].Text := prByteToString(RecData,120,21);
      LcdScreenMsg.Line[4].X := RecData[141];
      LcdScreenMsg.Line[4].Y := RecData[142];
      LcdScreenMsg.Line[4].Alligment := RecData[143];
      LcdScreenMsg.FooterType := RecData[144];
      LcdScreenMsg.Footer := prByteToString(RecData,145,21);
      LcdScreenMsg.RL_Time1 := prBytesToWord(RecData,166);
      LcdScreenMsg.RL_Time2 := prBytesToWord(RecData,168);
      LcdScreenMsg.BZR_time := prBytesToWord(RecData,170);
      LcdScreenMsg.IsBlink := prBytesToBoolean(RecData,172);
      LcdScreenMsg.ScreenDuration := prBytesToWord(RecData,173);
      LcdScreenMsg.FontType := RecData[175];
      LcdScreenMsg.LineCount := RecData[176];
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetLCDMessages', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetLCDMessages(LcdScreenMsg:TLcdScreen) : Integer; // CMD 2.27
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(LcdScreenMsg.ID,SendData,0);
    SendData[2] := LcdScreenMsg.HeaderType;
    ToPrBytes(LcdScreenMsg.Caption,SendData,3,21);
    ToPrBytes(LcdScreenMsg.Line[0].Text,SendData,24,21);
    SendData[45] := LcdScreenMsg.Line[0].X;
    SendData[46] := LcdScreenMsg.Line[0].Y;
    SendData[47] := LcdScreenMsg.Line[0].Alligment;
    ToPrBytes(LcdScreenMsg.Line[1].Text,SendData,48,21);
    SendData[69] := LcdScreenMsg.Line[1].X;
    SendData[70] := LcdScreenMsg.Line[1].Y;
    SendData[71] := LcdScreenMsg.Line[1].Alligment;
    ToPrBytes(LcdScreenMsg.Line[2].Text,SendData,72,21);
    SendData[93] := LcdScreenMsg.Line[2].X;
    SendData[94] := LcdScreenMsg.Line[2].Y;
    SendData[95] := LcdScreenMsg.Line[2].Alligment;
    ToPrBytes(LcdScreenMsg.Line[3].Text,SendData,96,21);
    SendData[117] := LcdScreenMsg.Line[3].X;
    SendData[118] := LcdScreenMsg.Line[3].Y;
    SendData[119] := LcdScreenMsg.Line[3].Alligment;
    ToPrBytes(LcdScreenMsg.Line[4].Text,SendData,120,21);
    SendData[141] := LcdScreenMsg.Line[4].X;
    SendData[142] := LcdScreenMsg.Line[4].Y;
    SendData[143] := LcdScreenMsg.Line[4].Alligment;
    SendData[144] := LcdScreenMsg.FooterType;
    ToPrBytes(LcdScreenMsg.Footer,SendData,145,21);
    ToPrBytes(LcdScreenMsg.RL_Time1,SendData,166);
    ToPrBytes(LcdScreenMsg.RL_Time2,SendData,168);
    ToPrBytes(LcdScreenMsg.BZR_time,SendData,170);
    ToPrBytes(LcdScreenMsg.IsBlink,SendData,172);
    ToPrBytes(LcdScreenMsg.ScreenDuration,SendData,173);
    SendData[175] := LcdScreenMsg.FontType;
    SendData[176] := LcdScreenMsg.LineCount;

    iErr := ExecuteCmd(2, // CmdNo
      27, // SubCmdNo
      27, // Acknowledge
      177, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetLCDMessages', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetBeepRelayAndSecreenMessage(LcdScreenMsg : TLcdScreen) : Integer; // CMD 2.28
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(LcdScreenMsg.ID,SendData,0);
    SendData[2] := LcdScreenMsg.HeaderType;
    ToPrBytes(LcdScreenMsg.Caption,SendData,3,21);
    ToPrBytes(LcdScreenMsg.Line[0].Text,SendData,24,21);
    SendData[45] := LcdScreenMsg.Line[0].X;
    SendData[46] := LcdScreenMsg.Line[0].Y;
    SendData[47] := LcdScreenMsg.Line[0].Alligment;
    ToPrBytes(LcdScreenMsg.Line[1].Text,SendData,48,21);
    SendData[69] := LcdScreenMsg.Line[1].X;
    SendData[70] := LcdScreenMsg.Line[1].Y;
    SendData[71] := LcdScreenMsg.Line[1].Alligment;
    ToPrBytes(LcdScreenMsg.Line[2].Text,SendData,72,21);
    SendData[93] := LcdScreenMsg.Line[2].X;
    SendData[94] := LcdScreenMsg.Line[2].Y;
    SendData[95] := LcdScreenMsg.Line[2].Alligment;
    ToPrBytes(LcdScreenMsg.Line[3].Text,SendData,96,21);
    SendData[117] := LcdScreenMsg.Line[3].X;
    SendData[118] := LcdScreenMsg.Line[3].Y;
    SendData[119] := LcdScreenMsg.Line[3].Alligment;
    ToPrBytes(LcdScreenMsg.Line[4].Text,SendData,120,21);
    SendData[141] := LcdScreenMsg.Line[4].X;
    SendData[142] := LcdScreenMsg.Line[4].Y;
    SendData[143] := LcdScreenMsg.Line[4].Alligment;
    SendData[144] := LcdScreenMsg.FooterType;
    ToPrBytes(LcdScreenMsg.Footer,SendData,145,21);
    ToPrBytes(LcdScreenMsg.RL_Time1,SendData,166);
    ToPrBytes(LcdScreenMsg.RL_Time2,SendData,168);
    ToPrBytes(LcdScreenMsg.BZR_time,SendData,170);
    ToPrBytes(LcdScreenMsg.IsBlink,SendData,172);
    ToPrBytes(LcdScreenMsg.ScreenDuration,SendData,173);
    SendData[175] := LcdScreenMsg.FontType;
    SendData[176] := LcdScreenMsg.LineCount;
    ToPrBytes(LcdScreenMsg.NextScreen,SendData,177);

    iErr := ExecuteCmd(2, // CmdNo
      28, // SubCmdNo
      28, // Acknowledge
      179, // DataLen
      SendData, RecData,
      1000, // SelectTimeOut
      1
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetBeepRelayAndSecreenMessage', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetDeviceClientTCPSettings(out rSettings : TClientTCPSettings) : Integer; // CMD 2.29
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      29, // SubCmdNo
      29, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
      rSettings.IPAdress := prBytesToIPv4Str(RecData,0);
      rSettings.Port := prBytesToWord(RecData,4);
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetDeviceClientTCPSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetDeviceClientTCPSettings(rSettings:TClientTCPSettings) : Integer; // CMD 2.30
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := 0;
    if not ToPrBytesfromIPv4Str(rSettings.IPAdress,SendData,0) Then
       iErr := TErrors.INVALID_IP_ADRESS;

    if iErr = 0  then
    begin
      ToPrBytes(rSettings.Port,SendData,4);
      iErr := ExecuteCmd(2, // CmdNo
        30, // SubCmdNo
        30, // Acknowledge
        6,  // DataLen
        SendData, RecData // SelectTimeOut
        );
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetDeviceClientTCPSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetWeekDayNames(out WeekDays : TWeekDays) : Integer; // CMD 2.31
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      31, // SubCmdNo
      31, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    Begin
      for I := 0 to 6 do
        WeekDays.Names[i] := Trim(prByteToString(RecData,i*12,12));
        //ToPrBytes(WeekDays.Names[i],SendData,3,21);
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetWeekDayNames', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetWeekDayNames(WeekDays : TWeekDays) : Integer; // CMD 2.32
Var
  iErr ,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for I := 0 to 6 do
      ToPrBytes(WeekDays.Names[i],SendData,i*12,12);
    iErr := ExecuteCmd(2, // CmdNo
      32, // SubCmdNo
      32, // Acknowledge
      84, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetWeekDayNames', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpReadPageData(PageNo: word;out HexValue :String) : Integer;
Var
  iErr ,i,LoopCnt : Integer;
  SendData, RecData: TDataByte;
  tmpDataStr:String;
Begin
  try
    LoopCnt :=  fDFPageSize div 176;
    for I := 0 to LoopCnt-1 do
    begin
      ToPrBytes(PageNo,SendData,0);
      SendData[2] := i ;
      iErr := ExecuteCmd(2, // CmdNo
        33, // SubCmdNo
        33, // Acknowledge
        3,  // DataLen
        SendData, RecData // SelectTimeOut
        );
        if iErr = 0 then
        Begin
          tmpDataStr := prBytesToHex(RecData,0,176);
        End
        else
          break;
    end;
    if iErr = 0  then
       HexValue := tmpDataStr;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpReadPageData', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpWritePageData(PageNo: word; HexValue :String) : Integer;
Var
  iErr ,i,Start,StrLen,LoopCnt : Integer;
  SendData, RecData: TDataByte;
  tmpDataStr:String;
Begin
  try
    if IsHex(HexValue) Then
    Begin
      StrLen := Length(HexValue);
      if (StrLen =(fDFPageSize*2)) then
      Begin
        LoopCnt :=  StrLen div 352;
        for I := 0 to LoopCnt-1 do
        begin
          tmpDataStr := '';
          ToPrBytes(PageNo,SendData,0);
          SendData[2] := i ;
          if i = 0 then
            Start := 0
          else
            Start := i*352 + 1;

          tmpDataStr := copy(HexValue,Start,352);
          ToPrBytesFromHex(tmpDataStr,SendData,3);

          iErr := ExecuteCmd(2, // CmdNo
            34, // SubCmdNo
            34, // Acknowledge
            179,  // DataLen
            SendData, RecData // SelectTimeOut
            );
            if iErr <> 0 then
              break;
        end;
      End
      else
        iErr :=  TErrors.ERR_WRONGPAGESIZE;
    End
    else
      iErr :=  TErrors.ERR_WRONHEXDATA;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpReadPageData', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSerialTestFunction : Integer;
Var
  iErr  : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      35, // SubCmdNo
      35, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSerialTestFunction', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetLCDMessagesFactoryDefault : Integer;
Var
  iErr  : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      36, // SubCmdNo
      36, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetLCDMessagesFactoryDefault', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpTestCreateRecordFunction : Integer;
Var
  iErr : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      37, // SubCmdNo
      37, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpTestCreateRecordFunction', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetSerialPortSettings(out SerailAppType,Serial0,Serial1 :Byte ): Integer; // CMD 2.38
Var
  iErr  : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      38, // SubCmdNo
      38, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
      if (iErr =0) then
      begin
        Serial0 := RecData[0];
        Serial1 := RecData[1];
        SerailAppType := RecData[2];
      end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetSerialPortBaudrateSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetSerialPortSettings(SerailAppType,Serial0,Serial1 :Byte ): Integer; // CMD 2.39
Var
  iErr : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := Serial0;
    SendData[1] := Serial1;
    SendData[2] := SerailAppType;
    iErr := ExecuteCmd(2, // CmdNo
      39, // SubCmdNo
      39, // Acknowledge
      3, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetSerialPortBaudrateSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpReadCardBlockData(SectorNo,BlockNo,KeyType:Byte;Out ValueBuff : array of byte ): Integer; // CMD 2.40
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := SectorNo*4+BlockNo;
    SendData[1] := KeyType;
    iErr := ExecuteCmd(2, // CmdNo
      40, // SubCmdNo
      40, // Acknowledge
      2, // DataLen
      SendData, RecData // SelectTimeOut
      );
      if (iErr = 0) then
      Begin
        for I := 0 to 15 do
          ValueBuff[i] := RecData[i];
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpReadCardBlockData', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpWriteCardBlockData(SectorNo,BlockNo,KeyType:Byte;ValueBuff : array of byte ): Integer; // CMD 2.41
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := SectorNo*4+BlockNo;
    SendData[1] := KeyType;
    for I := 0 to 15 do
      SendData[i+2] := ValueBuff[i];

    iErr := ExecuteCmd(2, // CmdNo
      41, // SubCmdNo
      41, // Acknowledge
      18, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpWriteCardBlockData(', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpSetBeepRelayAndInboxMessage(LcdScreenMsg : TLcdScreen) : Integer; // CMD 2.42
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(LcdScreenMsg.ID,SendData,0);
    SendData[2] := LcdScreenMsg.HeaderType;
    ToPrBytes(LcdScreenMsg.Caption,SendData,3,21);
    ToPrBytes(LcdScreenMsg.Line[0].Text,SendData,24,21);
    SendData[45] := LcdScreenMsg.Line[0].X;
    SendData[46] := LcdScreenMsg.Line[0].Y;
    SendData[47] := LcdScreenMsg.Line[0].Alligment;
    ToPrBytes(LcdScreenMsg.Line[1].Text,SendData,48,21);
    SendData[69] := LcdScreenMsg.Line[1].X;
    SendData[70] := LcdScreenMsg.Line[1].Y;
    SendData[71] := LcdScreenMsg.Line[1].Alligment;
    ToPrBytes(LcdScreenMsg.Line[2].Text,SendData,72,21);
    SendData[93] := LcdScreenMsg.Line[2].X;
    SendData[94] := LcdScreenMsg.Line[2].Y;
    SendData[95] := LcdScreenMsg.Line[2].Alligment;
    ToPrBytes(LcdScreenMsg.Line[3].Text,SendData,96,21);
    SendData[117] := LcdScreenMsg.Line[3].X;
    SendData[118] := LcdScreenMsg.Line[3].Y;
    SendData[119] := LcdScreenMsg.Line[3].Alligment;
    ToPrBytes(LcdScreenMsg.Line[4].Text,SendData,120,21);
    SendData[141] := LcdScreenMsg.Line[4].X;
    SendData[142] := LcdScreenMsg.Line[4].Y;
    SendData[143] := LcdScreenMsg.Line[4].Alligment;
    SendData[144] := LcdScreenMsg.FooterType;
    ToPrBytes(LcdScreenMsg.Footer,SendData,145,21);
    ToPrBytes(LcdScreenMsg.RL_Time1,SendData,166);
    ToPrBytes(LcdScreenMsg.RL_Time2,SendData,168);
    ToPrBytes(LcdScreenMsg.BZR_time,SendData,170);
    ToPrBytes(LcdScreenMsg.IsBlink,SendData,172);
    ToPrBytes(LcdScreenMsg.ScreenDuration,SendData,173);
    SendData[175] := LcdScreenMsg.FontType;
    SendData[176] := LcdScreenMsg.LineCount;
    ToPrBytes(LcdScreenMsg.NextScreen,SendData,177);
    SendData[179] := LcdScreenMsg.KeyPadType;

    iErr := ExecuteCmd(2, // CmdNo
      42, // SubCmdNo
      42, // Acknowledge
      180, // DataLen
      SendData, RecData,
      1000, // SelectTimeOut
      1
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetBeepRelayAndSecreenMessage', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TCustomTcpRdr.tcpGetReaderServiceStatus(out StatusEnb:Boolean;out TimeOut : word) : Integer; // CMD 2.44
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(2, // CmdNo
      44, // SubCmdNo
      44, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if (iErr = 0) then
    Begin
      StatusEnb := prBytesToBoolean(RecData,0);
      TimeOut := prBytesToWord(RecData,1);
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetReaderServiceStatus', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TCustomTcpRdr.tcpSetReaderServiceStatus(StatusEnb:Boolean;TimeOut : word) : Integer; // CMD 2.45
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(StatusEnb,SendData,0);
    ToPrBytes(TimeOut,SendData,1);
    iErr := ExecuteCmd(2, // CmdNo
      45, // SubCmdNo
      45, // Acknowledge
      3, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetReaderServiceStatus', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

///// Device General Functions

function TCustomTcpRdr.SetDeviceLoginKey(Key: array of Byte): Boolean;
Begin
  Result := (tcpSetDeviceLoginKey(Key)=0);
End;

function TCustomTcpRdr.SetDeviceLoginKey(Key: String): Boolean;
Var
  tmpKey:array [0 .. 15] of byte;
  KeyData : TDataByte;
  i,iErr :Integer;
Begin
  iErr := 0;
  if ToPrBytesFromHex(Key,KeyData,0,32) Then
  Begin
    for I := 0 to 15 do
      tmpKey[i] := KeyData[i];
    Result := (tcpSetDeviceLoginKey(tmpKey)=0);
  End else
  Begin
    Result := False;
    iErr := TErrors.INVALID_COMN_KEY;
    DoLog(lgError,'SetDeviceLoginKey', ' SetDeviceLoginKey Error No : ' +IntToStr(iErr));
  End;
End;

function TCustomTcpRdr.GetDeviceGeneralSettings(out rSettings : TGeneralDeviceSettings) : Boolean;
Begin
  Result := (tcpGetDeviceGeneralSettings(rSettings)=0);
End;

function TCustomTcpRdr.SetDeviceGeneralSettings(rSettings:TGeneralDeviceSettings) : Boolean;
Begin
  Result := (tcpSetDeviceGeneralSettings(rSettings)=0);
End;

function TCustomTcpRdr.GetDeviceTCPSettings(out rSettings : TTCPSettings) : Boolean;
Begin
  Result := (tcpGetDeviceTCPSettings(rSettings)=0);
End;

function TCustomTcpRdr.SetDeviceTCPSettings(rSettings:TTCPSettings) : Boolean;
Begin
  Result := (tcpSetDeviceTCPSettings(rSettings)=0);
End;

function TCustomTcpRdr.GetDeviceUDPSettings(out rSettings:TUDPSettings) : Boolean;
Begin
  Result := (tcpGetDeviceUDPSettings(rSettings)=0);
End;

function TCustomTcpRdr.SetDeviceUDPSettings(rSettings:TUDPSettings) : Boolean;
Begin
  Result := (tcpSetDeviceUDPSettings(rSettings)=0);
End;

function TCustomTcpRdr.GetMACAddress(out MacAddr:String) : Boolean;
Begin
  Result := (tcpGetMACAddress(MacAddr)=0);
End;

function TCustomTcpRdr.GetMACAddress:String;
var
  MACAddressStr:String;
Begin
  if tcpGetMACAddress(MACAddressStr)=0 then
    Result := MACAddressStr
  else
    Result := '*';
End;

function TCustomTcpRdr.SetMACAddress(MacAddr:String) : Boolean;
Begin
  Result := (tcpSetMACAddress(MacAddr)=0);
End;

function TCustomTcpRdr.GetDeviceWorkModeSettings(out rSettings : TWorkModeSettings) : Boolean;
Begin
  Result := (tcpGetDeviceWorkModeSettings(rSettings)=0);
End;

function TCustomTcpRdr.SetDeviceWorkModeSettings(rSettings : TWorkModeSettings) : Boolean;
Begin
  Result := (tcpSetDeviceWorkModeSettings(rSettings)=0);
End;

function TCustomTcpRdr.GetWebPassword(Out WebPassword:string):Boolean;
Begin
  Result := (tcpGetWebPassword(WebPassword)=0);
End;

function TCustomTcpRdr.GetWebPassword:String;
var
  PassStr:String;
Begin
  if tcpGetWebPassword(PassStr)=0 then
    Result := PassStr
  else
    Result := '*';
End;

function TCustomTcpRdr.SetWebPassword(WebPassword:string):Boolean;
Begin
  Result := (tcpSetWebPassword(WebPassword)=0);
End;

function TCustomTcpRdr.SetDeviceFactoryDefault(ResetIP:Boolean=False) : Boolean;
Begin
  Result := (tcpSetDeviceFactoryDefault(ResetIP)=0);
End;

function TCustomTcpRdr.GetSerialNumber(out SerialArr : array of byte) : Boolean;
Begin
  Result := (tcpGetSerialNumber(SerialArr)=0);
End;

function TCustomTcpRdr.SetSerialNumber(SerialArr : array of byte) : Boolean;
Begin
  Result := (tcpSetSerialNumber(SerialArr)=0);
End;

function TCustomTcpRdr.GetSerialNumber : String ;
Var
  SerialArr : array[0..15] of byte;
Begin
  if tcpGetSerialNumber(SerialArr)=0 then
    Result := prByteToString(SerialArr)
  else
    Result := 'XXX';
End;

function TCustomTcpRdr.SetSerialNumber(SerialStr : String) : Boolean;
Var
  SerialData : TDataByte;
  SerialArr : array [0..15] of byte;
  i:Integer;
Begin
  ToPrBytes(SerialStr,SerialData,0,16);
  for I := 0 to 15 do
    SerialArr[i] := SerialData[i];
  Result := (tcpSetSerialNumber(SerialArr)=0);
End;

procedure TCustomTcpRdr.Reboot;
Begin
  tcpReboot;
End;

function TCustomTcpRdr.GetFwVwersion(out fWVersion:string):Boolean;
Begin
  Result := (tcpGetFwVwersion(fWVersion)=0);
End;

function TCustomTcpRdr.GetFwVwersion:String;
var
  VersStr:String;
Begin
  if tcpGetFwVwersion(VersStr)=0 then
    Result := VersStr
  else
    Result := '';
End;

function TCustomTcpRdr.SetDateTime(dt:TDateTime): Boolean;
Begin
  Result := (tcpSetDateTime(dt)=0);
End;

function TCustomTcpRdr.GetMfrKeyList(out KeyList : TMfrKeyList) : Boolean;
Begin
  Result := (tcpGetMfrKeyList(KeyList)=0);
End;

function TCustomTcpRdr.SetMfrKeyList(KeyList : TMfrKeyList) : Boolean;
Begin
  Result := (tcpSetMfrKeyList(KeyList)=0);
End;

function TCustomTcpRdr.GetMfrKeyList(out KeyList : TMfrKeyListStr) : Boolean;
Var
  tmpKeyList : TMfrKeyList;
  i : Integer;
  str:String;
Begin
  Result := (tcpGetMfrKeyList(tmpKeyList)=0);
  if Result then
  Begin
    for I := 0 to 15 do
    Begin
      str := '';
      str := prBytesToHex(tmpKeyList.Sector[i].KeyA,0,6);
      KeyList.Sector[i].KeyA := str;
      str := '';
      str := prBytesToHex(tmpKeyList.Sector[i].KeyB,0,6);
      KeyList.Sector[i].KeyB := str;
    End;
  End;
End;

function TCustomTcpRdr.SetMfrKeyList(KeyList : TMfrKeyListStr) : Boolean;
Var
  tmpKeyList : TMfrKeyList;
  i : Integer;
Begin
  for I := 0 to 15 do
  Begin
    ToPrBytesFromHex(KeyList.Sector[i].KeyA,tmpKeyList.Sector[i].KeyA);
    ToPrBytesFromHex(KeyList.Sector[i].KeyB,tmpKeyList.Sector[i].KeyB);
  End;
  Result := (tcpSetMfrKeyList(tmpKeyList)=0);
End;

function TCustomTcpRdr.GetHeadTailCapacity(Out Head,Tail,Capacity:LongWord): Boolean;
Begin
  Result := (tcpGetHeadTailCapacity(Head,Tail,Capacity)=0);
End;

function TCustomTcpRdr.GetHead: Integer;
Var
 tmpHead,tmpTail,tmpCapacity:Cardinal;
Begin
  if tcpGetHeadTailCapacity(tmpHead,tmpTail,tmpCapacity) = 0 then
    Result := tmpHead
  else
    Result := -1;
End;

function TCustomTcpRdr.GetTail: Integer;
Var
 tmpHead,tmpTail,tmpCapacity:Cardinal;
Begin
  if tcpGetHeadTailCapacity(tmpHead,tmpTail,tmpCapacity) = 0 then
    Result := tmpTail
  else
    Result := -1;
End;

function TCustomTcpRdr.GetCapacity: Integer;
Var
 tmpHead,tmpTail,tmpCapacity:Cardinal;
Begin
  if tcpGetHeadTailCapacity(tmpHead,tmpTail,tmpCapacity) = 0 then
    Result := tmpCapacity
  else
    Result := -1;
End;

function TCustomTcpRdr.SetHeadTail(Head,Tail:LongWord): Boolean;
Begin
  Result := (tcpSetHeadTail(Head,Tail)=0);
End;

function TCustomTcpRdr.GetDeviceStatus : Boolean;
Var
  enb:Boolean;
Begin
  if (tcpGetDeviceStatus(enb)=0) then
    Result := enb
  else
    Result := False;
End;

function TCustomTcpRdr.SetDeviceStatus(StatusEnb:Boolean) : Boolean;
Begin
  Result := (tcpSetDeviceStatus(StatusEnb)=0);
End;

function TCustomTcpRdr.GetLCDMessages(ID : Integer;out LcdScreenMsg : TLcdScreen) : Boolean;
Begin
  Result := (tcpGetLCDMessages(ID,LcdScreenMsg)=0);
End;

function TCustomTcpRdr.SetLCDMessages(LcdScreenMsg : TLcdScreen) : Boolean;
Begin
  Result := (tcpSetLCDMessages(LcdScreenMsg)=0);
End;

function TCustomTcpRdr.SetBeepRelayAndSecreenMessage(
        HeaderType,FooterType:Integer;
        Caption,Text1,Text2,Text3,Text4,Text5,Footer:String;
        X1,Y1,Alligment1,X2,Y2,Alligment2,X3,Y3,Alligment3,
        X4,Y4,Alligment4,X5,Y5,Alligment5:Byte;
        LineCount,FontType:Byte;
        ScreenDuration,RL_Time1,RL_Time2,BZR_time : word;
        IsBlink : Boolean) : Boolean;
Var LcdScreenMsg : TLcdScreen;
begin
  try
    LcdScreenMsg.ID := 0;
    LcdScreenMsg.HeaderType := HeaderType;   //1
    LcdScreenMsg.Caption := Caption;    //21
    LcdScreenMsg.Line[0].X := X1; //105   +15
    LcdScreenMsg.Line[0].Y := Y1;
    LcdScreenMsg.Line[0].Alligment := Alligment1;
    LcdScreenMsg.Line[0].Text := Text1;
    LcdScreenMsg.Line[1].X := X2; //105   +15
    LcdScreenMsg.Line[1].Y := Y2;
    LcdScreenMsg.Line[1].Alligment := Alligment2;
    LcdScreenMsg.Line[1].Text := Text2;
    LcdScreenMsg.Line[2].X := X3; //105   +15
    LcdScreenMsg.Line[2].Y := Y3;
    LcdScreenMsg.Line[2].Alligment := Alligment3;
    LcdScreenMsg.Line[2].Text := Text3;
    LcdScreenMsg.Line[3].X := X4; //105   +15
    LcdScreenMsg.Line[3].Y := Y4;
    LcdScreenMsg.Line[3].Alligment := Alligment4;
    LcdScreenMsg.Line[3].Text := Text4;
    LcdScreenMsg.Line[4].X := X5; //105   +15
    LcdScreenMsg.Line[4].Y := Y5;
    LcdScreenMsg.Line[4].Alligment := Alligment5;
    LcdScreenMsg.Line[4].Text := Text5;
    LcdScreenMsg.FooterType := FooterType;   //1
    LcdScreenMsg.Footer := Footer;    //21
    LcdScreenMsg.RL_Time1 := RL_Time1;    //2
    LcdScreenMsg.RL_Time2 := RL_Time2;    //2
    LcdScreenMsg.BZR_time := BZR_time;    //2
    LcdScreenMsg.IsBlink := IsBlink;  //1
    LcdScreenMsg.ScreenDuration := ScreenDuration; //2
    LcdScreenMsg.FontType := FontType;    //1
    LcdScreenMsg.LineCount := LineCount;    //1
    LcdScreenMsg.NextScreen := 3;
  except
    on E: Exception do
    begin
      DoLog(lgError,'SetBeepRelayAndSecreenMessage', 'Exception Error : ' + E.Message);
    end;
  end; // try

  Result := (TcpSetBeepRelayAndSecreenMessage(LcdScreenMsg)=0);

end;

function TCustomTcpRdr.SetBeepRelayAndSecreenMessage(
       Text1,Text2:String;ScreenDuration,RL_Time1,BZR_time : word;
        IsBlink : Boolean) : Boolean;
Var LcdScreenMsg : TLcdScreen;
begin
  try
    LcdScreenMsg.ID := 0;
    LcdScreenMsg.HeaderType := 0;   //1
    LcdScreenMsg.Caption := '';    //21
    LcdScreenMsg.Line[0].X := 0; //105   +15
    LcdScreenMsg.Line[0].Y := 0;
    LcdScreenMsg.Line[0].Alligment := 0;
    LcdScreenMsg.Line[0].Text := Text1;
    LcdScreenMsg.Line[1].X := 0; //105   +15
    LcdScreenMsg.Line[1].Y := 0;
    LcdScreenMsg.Line[1].Alligment := 0;
    LcdScreenMsg.Line[1].Text := Text2;
    LcdScreenMsg.Line[2].X := 0; //105   +15
    LcdScreenMsg.Line[2].Y := 0;
    LcdScreenMsg.Line[2].Alligment := 0;
    LcdScreenMsg.Line[2].Text := '';
    LcdScreenMsg.Line[3].X := 0; //105   +15
    LcdScreenMsg.Line[3].Y := 0;
    LcdScreenMsg.Line[3].Alligment := 0;
    LcdScreenMsg.Line[3].Text := '';
    LcdScreenMsg.Line[4].X := 0; //105   +15
    LcdScreenMsg.Line[4].Y := 0;
    LcdScreenMsg.Line[4].Alligment := 0;
    LcdScreenMsg.Line[4].Text := '';
    LcdScreenMsg.FooterType := 0;   //1
    LcdScreenMsg.Footer := '';    //21
    LcdScreenMsg.RL_Time1 := RL_Time1;    //2
    LcdScreenMsg.RL_Time2 := 0;    //2
    LcdScreenMsg.BZR_time := BZR_time;    //2
    LcdScreenMsg.IsBlink := IsBlink;  //1
    LcdScreenMsg.ScreenDuration := ScreenDuration; //2
    LcdScreenMsg.FontType := 0;    //1
    LcdScreenMsg.LineCount := 2;    //1
    LcdScreenMsg.NextScreen := 3;
  except
    on E: Exception do
    begin
      DoLog(lgError,'SetBeepRelayAndSecreenMessage', 'Exception Error : ' + E.Message);
    end;
  end; // try

  Result := (TcpSetBeepRelayAndSecreenMessage(LcdScreenMsg)=0);

end;

function TCustomTcpRdr.SetBeepRelayAndInboxMessage(
        HeaderType:Integer;
        Caption,Text1,Text2:String;
        X1,Y1,Alligment1,X2,Y2,Alligment2:Byte;
        ScreenDuration,RL_Time1,RL_Time2,BZR_time : word;
        IsBlink : Boolean;KeyPadType:Byte) : Boolean;
Var LcdScreenMsg : TLcdScreen;
begin
  try
    LcdScreenMsg.ID := 71;
    LcdScreenMsg.HeaderType := HeaderType;   //1
    LcdScreenMsg.Caption := Caption;    //21
    LcdScreenMsg.Line[0].X := X1; //105   +15
    LcdScreenMsg.Line[0].Y := Y1;
    LcdScreenMsg.Line[0].Alligment := Alligment1;
    LcdScreenMsg.Line[0].Text := Text1;
    LcdScreenMsg.Line[1].X := X2; //105   +15
    LcdScreenMsg.Line[1].Y := Y2;
    LcdScreenMsg.Line[1].Alligment := Alligment2;
    LcdScreenMsg.Line[1].Text := Text2;
    LcdScreenMsg.Line[2].X := 0; //105   +15
    LcdScreenMsg.Line[2].Y := 0;
    LcdScreenMsg.Line[2].Alligment := 0;
    LcdScreenMsg.Line[2].Text := '';
    LcdScreenMsg.Line[3].X := 0; //105   +15
    LcdScreenMsg.Line[3].Y := 0;
    LcdScreenMsg.Line[3].Alligment := 0;
    LcdScreenMsg.Line[3].Text := '';
    LcdScreenMsg.Line[4].X := 0; //105   +15
    LcdScreenMsg.Line[4].Y := 0;
    LcdScreenMsg.Line[4].Alligment := 0;
    LcdScreenMsg.Line[4].Text := '';
    LcdScreenMsg.FooterType := 1;   //1
    LcdScreenMsg.Footer := '';    //21
    LcdScreenMsg.RL_Time1 := RL_Time1;    //2
    LcdScreenMsg.RL_Time2 := RL_Time2;    //2
    LcdScreenMsg.BZR_time := BZR_time;    //2
    LcdScreenMsg.IsBlink := IsBlink;  //1
    LcdScreenMsg.ScreenDuration := ScreenDuration; //2
    LcdScreenMsg.FontType := 0;    //1
    LcdScreenMsg.LineCount := 3;    //1
    LcdScreenMsg.NextScreen := 3;
    LcdScreenMsg.KeyPadType := KeyPadType;
  except
    on E: Exception do
    begin
      DoLog(lgError,'SetBeepRelayAndSecreenMessage', 'Exception Error : ' + E.Message);
    end;
  end; // try

  Result := (tcpSetBeepRelayAndInboxMessage(LcdScreenMsg)=0);

end;

function TCustomTcpRdr.GetDeviceClientTCPSettings(out rSettings : TClientTCPSettings) : Boolean;
Begin
  Result := (tcpGetDeviceClientTCPSettings(rSettings)=0);
End;

function TCustomTcpRdr.SetDeviceClientTCPSettings(rSettings:TClientTCPSettings) : Boolean;
Begin
  Result := (tcpSetDeviceClientTCPSettings(rSettings)=0);
End;

function TCustomTcpRdr.GetWeekDayNames(out WeekDays : TWeekDays) : Boolean;
Begin
  Result := (tcpGetWeekDayNames(WeekDays)=0);
End;

function TCustomTcpRdr.SetWeekDayNames(WeekDays : TWeekDays) : Boolean;
Begin
  Result := (tcpSetWeekDayNames(WeekDays)=0);
End;

function TCustomTcpRdr.ReadPageData(PageNo: word;out HexValue :String) : Boolean;
Begin
  Result := (tcpReadPageData(PageNo,HexValue)=0);
End;

function TCustomTcpRdr.WritePageData(PageNo: word; HexValue :String) : Boolean;
Begin
  Result := (tcpWritePageData(PageNo,HexValue)=0);
End;

function TCustomTcpRdr.SerialTestFunction : Boolean;
Begin
  Result := (tcpSerialTestFunction=0);
End;

function TCustomTcpRdr.SetLCDMessagesFactoryDefault : Boolean;
Begin
  Result := (tcpSetLCDMessagesFactoryDefault=0);
End;

function TCustomTcpRdr.TestCreateRecordFunction : Boolean;
Begin
  Result := (tcpTestCreateRecordFunction=0);
End;

function TCustomTcpRdr.GetSerialPortSettings(out SerailAppType,Serial0,Serial1 :Byte ): Boolean;
Begin
  Result := (tcpGetSerialPortSettings(SerailAppType,Serial0,Serial1)=0);
End;

function TCustomTcpRdr.SetSerialPortSettings(SerailAppType,Serial0,Serial1 :Byte ): Boolean;
Begin
  Result := (tcpSetSerialPortSettings(SerailAppType,Serial0,Serial1)=0);
End;

function TCustomTcpRdr.ReadCardBlockData(SectorNo,BlockNo:Byte;KeyType : byte;Out ValueBuff : array of byte ):Boolean;
Begin
  Result := (tcpReadCardBlockData(SectorNo,BlockNo,KeyType,ValueBuff)=0);
End;

function TCustomTcpRdr.WriteCardBlockData(SectorNo,BlockNo:Byte;KeyType : byte;ValueBuff : array of byte ):Boolean;
Begin
  Result := (tcpWriteCardBlockData(SectorNo,BlockNo,KeyType,ValueBuff)=0);
End;

function TCustomTcpRdr.GetReaderServiceStatus(out StatusEnb:Boolean;out TimeOut : word) : Boolean;
Begin
  Result := (tcpGetReaderServiceStatus(StatusEnb,TimeOut)=0);
End;

function TCustomTcpRdr.SetReaderServiceStatusEnable : Boolean;
Begin
  Result := (tcpSetReaderServiceStatus(True,0)=0);
End;

function TCustomTcpRdr.SetReaderServiceStatusDisable(TimeOut : word) : Boolean;
begin
  Result := (tcpSetReaderServiceStatus(False,TimeOut)=0);
end;

end.
