(* *************************************************************************
  * Perio USB/Serial Rdr Library ver. 1.2                                              *
  *   Reader Model  : ART12U                                               *
  *   for Delphi 2010,XE-XE7                                               *
  *                                                                        *
  *  http://www.artelektronik.com                                          *
  *                                                                        *
  * Kullanýlan Seri Port Haberleþme Component'i ComPort Library ver. 4.11  *
  *     download : http://sourceforge.net/projects/comport/                *
  *                                                                        *
  ************************************************************************* *)
unit PerioDevice.UsbReader;

/// ////////////////////////////////////////////////////////////////////////
///
/// (+) Eklendi
/// (-) Silindi
/// (*) Bug düzeltme yada Uyarý
/// (/) Deðiþiklik Yapýldý
///
/// ////////////////////////////////////////////////////////////////////////
///
/// ////////////////////////////////////////////////////////////////////////
interface

uses
  SysUtils,
  Classes,
  DateUtils,
  CPort;

const
  ADDR_POS = 1;
  LEN_POS = 2;
  DATA_START_POS = 3;
  BUFFSIZE = 1024;
  CARDOPR_SECTORCOUNT = 40;
  CARDOPR_BLOCKPERSECTOR_1 = 4; // first 32 sector have 4 blocks
  CARDOPR_BLOCKPERSECTOR_2 = 16; // last 8 sector have 16 blocks
  CARDOPR_BLOCKSIZE = 16;
  CARDOPR_SECTORSIZE = 48;
  CARDOPR_KEYSIZE = 6;
  CARDOPR_VALSIZE = 4;
  CARDOPR_MASTERKEYCOUNT = 32;
  IO_COUNT = 6;

type

  TCardReadMode = (crmStandardMode, crmSendCardID, crmSendBlock, crmSendSector,
    crmSendCardID_ASCII, crmSendBlock_ASCII, crmUnknown);

  TKeyType = (ktKeyA, ktKeyB);

  TIOState = (ioOn, ioBlink, ioOff);

  TDeviceParams = record
    u2DevNum: word;
    bDevIsInitialized: boolean;
    rCardReadMode: TCardReadMode;
    rMasterKeyType: TKeyType;
    uMasterKeynum: byte;
    uBuzzBeepTime: byte;
    uDfltRelayTime: byte;
    uDfltBlockNum: byte;
    uDfltSectorNum: byte;
    uaFWVer: array [0 .. 4] of byte;
    uaRFU: array [0 .. 16] of byte;
  end;

type
  TAutoRxCardIDEvent = procedure(Sender: TObject; Const TermNo: Integer;
    const CardID: string) of object;

  TRdrErrorEvent = procedure(Sender: TObject; const Log: string) of object;

  TPerioUsbReader = class(TComPort)
  private type
    TByteBuffer = array [0 .. BUFFSIZE - 1] of byte;

    TRDRBuffer = record
      u2Len: word;
      uaBuff: TByteBuffer;
    end;

    TErrors = class
    const
      // Global errors
      NO_ERROR = 0;
      TIMEOUT = 10001;
      EXCEPTION = 10003;
      NOT_CONNECTED = 10005;
      DATA_IS_NOT_ENOUGH = 10130;
      WRONG_STX = 10131;
      WRONG_SERIAL_HEADER = 10133;
      WRONG_CSUM = 10134;
      WRONG_CRC = 10135;
      WRONG_ETX = 10136;
      NOT_EXPECTED_DATA = 10137;

      WRONG_DATA_ONTX = 10144;
      WRONG_PARAMETER = 10145;

      NO_CARD = 10540;
      FAULTY_KEY = 10541;
      FAULTY_CMD_KEYTYPE = 10542;
      FAIL = 10543;
      WRITE_ERROR = 10545;
      WRONG_SECTOR_NUM = 10550;
      WRONG_BLOCK_NUM = 10551;
      WRONG_MASTERKEY_NUM = 10552;
      WRONG_FORM_NUM = 10553;
      ERR_CMD_FORM = 10554;
      UNKNOWN_FORM_NUM = 10555;
      CARD_IS_NOT_SELECTED = 10556;
      SECTOR_IS_NOT_LOGIN = 10557;
      WRONG_IO_NUM = 10558;
      WRONG_IO_STATE = 10559;
      WRONG_DEV_NUM = 10560;
    end;
  private
    FTxBuffer: TRDRBuffer;
    FRxBuffer: TRDRBuffer;
    FbSelectCard: boolean;
    fcmdRetry: Integer;
    fReadTimeOut: Integer;
    fi2LoginSector: Integer;
    fRxCount: Integer;
    fRxFlag: boolean;
    fOnCmdRx: boolean;
    fOnRxCardID: TAutoRxCardIDEvent;
    fOnError: TRdrErrorEvent;
  protected

    function CheckProtocol(out u2DataLen: word): integer;
    procedure SetProtocol(const u2DataLen: word);
    function FindRealBlockNumber(const i2Sector: shortint; const uBlock: byte;
      out uRealBlock: byte): integer;
    function WaitToFinish(u4StartTime: cardinal; u4TimeOut: cardinal): integer;
    function lTimeToMs(dt: TDateTime): cardinal;

    procedure DoRxBuf(const Buffer; Count: Integer); Override;
    procedure DoRxChar(Count: Integer); Override;
    procedure DoRxFlag; Override;
    procedure DoArtRdrError(MethodName, Msg: string);
    procedure DoRxCardID(Const TermNo: Integer; const CardID: string);
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetErrMessage(iErr: Integer): String;
    function HexToStr(const arrofbyte; const size: integer): widestring;
    function HexToByte(HexStr: string): byte;

    function HexStrToT6Byte(HexStr: string; Var Key: array of byte): integer;
    function HexStrToT16Byte(HexStr: string;
      Var ValuesBuf: array of byte): integer;
    function HexStrToDtByte(HexStr: string; Var DtBuf: array of byte): integer;

    function T6ByteToHexStr(Key: array of byte; Var HexStr: string): integer;
    function T16ByteToHexStr(ValuesBuf: array of byte;
      Var HexStr: string): integer;
    function DtByteToHexStr(DtBuf: array of byte; Var HexStr: string): Integer;

    Function EncodeDTSISDateTime(dt: TDateTime;
      out Buffer: array of byte): Integer;
    Function DecodeDTSISDateTime(Buffer: array of byte;
      out dt: TDateTime): Integer;

    // SELECT CARD
    function SelectCard(Var CardID: String): Integer;
    function ExtendedSelectCard(Var CardType: byte; Var CardID: String)
      : integer;

    // SECTOR LOGIN
    function SectorLogin_withFKey_Philips(uSectorNum: byte): integer;
    function SectorLogin_withFKey_Infineon(KeyType: TKeyType;
      uSectorNum: byte): integer;
    function SectorLogin_withKey(KeyType: TKeyType; Key: array of byte;
      uSectorNum: byte): integer;
    function SectorLogin_withMasterKey(KeyType: TKeyType;
      uSectorNum, uMasterKeynum: byte): integer;
    function WriteMasterKey(uMasterKeynum: byte; Key: array of byte): integer;

    // BLOCK OPERATIONS
    function ReadBlock(out ValueBuf: array of byte; BlockNum: byte): integer;
    function WriteBlock(ValueBuf: array of byte; BlockNum: byte): integer;

    // VALUE OPERATIONS
    function ReadValue(Var Value: cardinal; BlockNum: byte): integer;
    function WriteValue(Value: cardinal; BlockNum: byte): integer;
    function CopyValue(SrcBlockNum, DestBlockNum: byte): integer;
    function IncValue(IncValue: cardinal; BlockNum: byte): integer;
    function DecValue(DecValue: cardinal; BlockNum: byte): integer;

    // CONFIGURATIONS OPERATIONS
    function ConfigSector(FormNum: String; KeyA, KeyB: array of byte): integer;
    function ReadSectorForm(Var FormNum: String): integer;

    // IO OPERATIONS
    function SetOutput(uIONum: byte; IOState: TIOState; Duration: byte)
      : integer;
    function SetIORedLed(Duration: byte; Blink: boolean = False): Integer;
    function SetIOGreenLed(Duration: byte; Blink: boolean = False): Integer;
    function SetIOBuzzer(Duration: byte; Blink: boolean = False): Integer;

    // Terminal Settings
    function ReadTerminalSetup(Var DeviceParams: TDeviceParams): integer;
    function WriteTerminalSetup(DeviceParams: TDeviceParams): integer;

  published
    property ArtCmdRetry: Integer read fcmdRetry write fcmdRetry default 3;
    property ArtReadTimeOut: Integer read fReadTimeOut write fReadTimeOut
      default 50;
    property OnRxCardID: TAutoRxCardIDEvent read fOnRxCardID write fOnRxCardID;
    property OnError: TRdrErrorEvent read fOnError write fOnError;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Perio Communication', [TPerioUsbReader]);
end;

procedure TPerioUsbReader.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

function TPerioUsbReader.GetErrMessage(iErr: Integer): String;
Var
  ErrStr: String;
Begin
  case iErr of
    0:
      ErrStr := 'No Error.';
    1:
      ErrStr := 'Timeout.';
    20:
      ErrStr := 'Not Assigned.';
    21:
      ErrStr := 'Exception.';
    22:
      ErrStr := 'Cannot Connect.';
    23:
      ErrStr := 'Cannot  Stop.';
    24:
      ErrStr := 'Not Connected.';
    25:
      ErrStr := 'Cancelled by User.';
    26:
      ErrStr := 'Cannot Get Params.';
    27:
      ErrStr := 'Cannot Send.';
    30:
      ErrStr := 'Data is not Enough.';
    31:
      ErrStr := 'Wrong stx.';
    32:
      ErrStr := 'Wrong addr.';
    33:
      ErrStr := 'Wrong csum.';
    34:
      ErrStr := 'Wrong etx.';
    35:
      ErrStr := 'Not expected Data.';
    36:
      ErrStr := 'Wrong data ontx.';
    37:
      ErrStr := 'Wrong Parameter.';
    40:
      ErrStr := 'No Card.';
    41:
      ErrStr := 'Faulty Key.';
    42:
      ErrStr := 'Faulty cmd Keytype.';
    43:
      ErrStr := 'Fail.';
    45:
      ErrStr := 'Write error.';
    50:
      ErrStr := 'Wrong Sector num.';
    51:
      ErrStr := 'Wrong Block num.';
    52:
      ErrStr := 'wrong Masterkey num.';
    53:
      ErrStr := 'Wrong Factor num.';
    54:
      ErrStr := 'Err cmd form.';
    55:
      ErrStr := 'Unknown form num.';
    56:
      ErrStr := 'Card is not selected.';
    57:
      ErrStr := 'Sector is not logined.';
    58:
      ErrStr := 'Wrong io num.';
    59:
      ErrStr := 'Wrong io state.';
    60:
      ErrStr := 'Wrong dev num.';
    61:
      ErrStr := 'Wrong Bckl Cntr.';
    62:
      ErrStr := 'NO_MORE_RECS.';
    63:
      ErrStr := 'WL_WRONG_COUNT.';
    64:
      ErrStr := 'WL_WRONG_START_POS.';
    65:
      ErrStr := 'WL_NOTCONFIRMED_COUNT.';
    66:
      ErrStr := 'FU_NOFILE.';
    67:
      ErrStr := 'FU_FILE_IS_EMPTY.';
    68:
      ErrStr := 'CMD_IS_NOT_SUPPORTED.';
    69:
      ErrStr := 'NOT_FOUND.';
    108:
      ErrStr := 'ERR_NODATA.';
    10540:
      ErrStr := 'No CARD.';
    10541:
      ErrStr := 'FAULTY_KEY';
    10542:
      ErrStr := 'FAULTY_CMD_KEYTYPE';
    10543:
      ErrStr := 'FAIL';
    10545:
      ErrStr := 'WRITE_ERROR';
    10550:
      ErrStr := 'WRONG_SECTOR_NUM';
    10551:
      ErrStr := 'WRONG_BLOCK_NUM';
    10552:
      ErrStr := 'WRONG_MASTERKEY_NUM';
    10553:
      ErrStr := 'WRONG_FORM_NUM';
    10554:
      ErrStr := 'ERR_CMD_FORM';
    10555:
      ErrStr := 'UNKNOWN_FORM_NUM';
    10556:
      ErrStr := 'CARD_IS_NOT_SELECTED';
    10557:
      ErrStr := 'SECTOR_IS_NOT_LOGIN';
    10558:
      ErrStr := 'WRONG_IO_NUM';
    10559:
      ErrStr := 'WRONG_IO_STATE';
    10560:
      ErrStr := 'WRONG_DEV_NUM';
    10561:
      ErrStr := 'WRONG_BCKL_CNTR';
    10562:
      ErrStr := 'NO_MORE_RECS';
    10563:
      ErrStr := 'WL_WRONG_COUNT';
    10564:
      ErrStr := 'WL_WRONG_START_POS';
    10565:
      ErrStr := 'WL_NOTCONFIRMED_COUNT';
    10566:
      ErrStr := 'FU_NOFILE';
    10567:
      ErrStr := 'FU_FILE_IS_EMPTY';
    10900:
      ErrStr := 'CP_ERR_TIMEOUT';
    10901:
      ErrStr := 'CP_ERR_NOTOPENED';
    10902:
      ErrStr := 'CP_ERR_UNFINISHEDPREVCMD';
    10904:
      ErrStr := 'CP_ERR_SETUP';
    10905:
      ErrStr := 'CP_ERR_ALREADYOPEN';
    10906:
      ErrStr := 'CP_ERR_CANNOTOPEN';
    10907:
      ErrStr := 'CP_ERR_CANNOTREAD';
  else
    ErrStr := ' Err ID Not found. ';
  end;
  Result := ErrStr;
End;

function TPerioUsbReader.HexToStr(const arrofbyte; const size: integer)
  : widestring;
var
  i: integer;
  s: string;
  P: PChar;
begin
  try
    s := '';
    P := @arrofbyte;
    for I := 0 to size - 1 do
    begin
      s := s + Format('%.2X', [byte(P^)]);
      inc(P);
    end;
    Result := s;
  except
    on E: Exception do
    begin
      DoArtRdrError('HexToStr', 'Exception :' + E.Message);
    end;
  end;
end;

function TPerioUsbReader.HexToByte(HexStr: string): byte;
const
  tablohex: array [0 .. 15] of char = '0123456789ABCDEF';
  tablobyte: array [0 .. 15] of byte = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
    12, 13, 14, 15);
var
  say, i: byte;
  s: string;
begin
  s := HexStr;
  say := 0;
  for i := 0 to 15 do
  begin
    if copy(s, 2, 1) = tablohex[i] then
      say := say + tablobyte[i];
    if copy(s, 1, 1) = tablohex[i] then
      say := say + tablobyte[i] * 16;
  end;
  HexToByte := say;
end;

function TPerioUsbReader.HexStrToT6Byte(HexStr: string;
  Var Key: array of byte): integer;
Var
  iErr, i: Integer;
Begin
  iErr := 0;
  if length(HexStr) = 12 then
  Begin
    try
      for I := 0 to 5 do
        Key[i] := HexToByte(copy(HexStr, (i * 2) + 1, 2));
    Except
      iErr := -1;
    end;
  End
  else
    iErr := -2;
  Result := iErr;
End;

function TPerioUsbReader.HexStrToDtByte(HexStr: string;
  Var DtBuf: array of byte): integer;
Var
  iErr, i: Integer;
Begin
  iErr := 0;
  if length(HexStr) = 8 then
  Begin
    try
      for I := 0 to 3 do
        DtBuf[i] := HexToByte(copy(HexStr, (i * 2) + 1, 2));
    Except
      iErr := -1;
    end;
  End
  else
    iErr := -2;
  Result := iErr;
End;

function TPerioUsbReader.HexStrToT16Byte(HexStr: string;
  Var ValuesBuf: array of byte): integer;
Var
  iErr, i: Integer;
Begin
  iErr := 0;
  if length(HexStr) = 32 then
  Begin
    try
      for I := 0 to 15 do
        ValuesBuf[i] := HexToByte(copy(HexStr, (i * 2) + 1, 2));
    Except
      iErr := -1;
    end;
  End
  else
    iErr := -2;
  Result := iErr;
End;

function TPerioUsbReader.T6ByteToHexStr(Key: array of byte;
  Var HexStr: string): integer;
Var
  iErr, i: Integer;
Begin
  iErr := 0;
  HexStr := '';
  try
    for I := 0 to 5 do
      HexStr := HexStr + HexToStr(Key[i], 1);
  Except
    iErr := -1;
  end;
  Result := iErr;
End;

function TPerioUsbReader.T16ByteToHexStr(ValuesBuf: array of byte;
  Var HexStr: string): integer;
Var
  iErr, i: Integer;
Begin
  iErr := 0;
  HexStr := '';
  try
    for I := 0 to 15 do
      HexStr := HexStr + HexToStr(ValuesBuf[i], 1);
  Except
    iErr := -1;
  end;
  Result := iErr;
End;

function TPerioUsbReader.DtByteToHexStr(DtBuf: array of byte;
  Var HexStr: string): Integer;
Var
  iErr, i: Integer;
Begin
  iErr := 0;
  HexStr := '';
  try
    for I := 0 to 3 do
      HexStr := HexStr + HexToStr(DtBuf[i], 1);
  Except
    iErr := -1;
  end;
  Result := iErr;
End;

Function TPerioUsbReader.EncodeDTSISDateTime(dt: TDateTime;
  out Buffer: array of byte): Integer;
var
  DTTemp: TDateTime;
  uDay, uMonth, uYear, uHour, uMinute, uSecond: byte;
  ret: Integer;
begin
  try
    ret := 0;
    Buffer[0] := 0;
    Buffer[1] := 0;
    Buffer[2] := 0;
    Buffer[3] := 0;
    DTTemp := dt;
    if YearOf(DTTemp) < 2000 then
      uYear := 0
    else
      uYear := YearOf(DTTemp) - 2000;
    uDay := DayOf(DTTemp);
    uMonth := MonthOf(DTTemp);
    uHour := HourOf(DTTemp);
    uMinute := MinuteOf(DTTemp);
    uSecond := SecondOf(DTTemp);
    Buffer[0] := (uHour shl 3) + ($07 and (uMinute shr 3));
    Buffer[1] := (uMinute shl 5) + ($1F and (uSecond shr 1));
    Buffer[2] := (uSecond shl 7) + ($7C and (uDay shl 2)) +
      ($03 and (uMonth shr 2));
    Buffer[3] := (uMonth shl 6) + ($3F and (uYear));
  Except
    ret := -1;
  end;
  Result := ret;
end; // procedure EncodeDTSISDateTime(dt: TDateTime; out buffer : array of byte);

Function TPerioUsbReader.DecodeDTSISDateTime(Buffer: array of byte;
  out dt: TDateTime): Integer;
var
  uDay, uMonth, uYear, uHour, uMinute, uSecond: byte;
  ret: Integer;
begin
  try
    ret := 0;
    uHour := (Buffer[0] shr 3);
    uMinute := $3F and ((Buffer[0] shl 3) + (Buffer[1] shr 5));
    uSecond := $3F and ((Buffer[1] shl 1) + (Buffer[1] shr 7));
    uDay := $1F and (Buffer[2] shr 2);
    uMonth := $0F and ((Buffer[2] shl 2) + (Buffer[3] shr 6));
    uYear := $3F and (Buffer[3]);
    if not TryEncodeDateTime(uYear + 2000, uMonth, uDay, uHour, uMinute,
      uSecond, 0, dt) then
    Begin
      dt := DateUtils.EncodeDateTime(2000, 1, 1, 0, 0, 0, 0);
      ret := -1;
    End;
  except
    ret := -2;
  end;
  Result := ret;
end;

procedure TPerioUsbReader.SetProtocol(const u2DataLen: word);
var
  uXORCSum: byte;
  i: integer;
begin
  FTxBuffer.u2Len := u2DataLen + 5;
  FTxBuffer.uaBuff[0] := 2; // stx
  FTxBuffer.uaBuff[ADDR_POS] := 1 and $FF;
  FTxBuffer.uaBuff[LEN_POS] := u2DataLen;

  uXORCSum := 0;
  for I := ADDR_POS to (u2DataLen + 2) do
    uXORCSum := uXORCSum xor FTxBuffer.uaBuff[i];

  FTxBuffer.uaBuff[u2DataLen + 3] := uXORCSum;
  FTxBuffer.uaBuff[u2DataLen + 4] := 3; // etx
end;

function TPerioUsbReader.CheckProtocol(out u2DataLen: word): integer;
var
  i4Err, i: integer;
  uCSum: byte;
label lend;
begin
  try
    u2DataLen := 0;

    i4Err := TErrors.DATA_IS_NOT_ENOUGH;
    if FRxBuffer.u2Len < 6 then
      goto lend;

    if (FRxBuffer.uaBuff[0] <> 2) then
    begin
      i4Err := TErrors.WRONG_STX;
      goto lend;
    end;

    u2DataLen := FRxBuffer.uaBuff[LEN_POS];

    if u2DataLen = 0 then
      goto lend;

    uCSum := 0;
    for I := ADDR_POS to (u2DataLen + 2) do
      uCSum := uCSum xor FRxBuffer.uaBuff[i];

    if uCSum <> FRxBuffer.uaBuff[u2DataLen + 3] then
    begin
      i4Err := TErrors.WRONG_CSUM;
      goto lend;
    end;

    if FRxBuffer.uaBuff[u2DataLen + 4] <> $03 then
    begin
      i4Err := TErrors.WRONG_ETX;
      goto lend;
    end;

    i4Err := TErrors.NO_ERROR;
  lend:
  except
    on E: Exception do
    begin
      i4Err := TErrors.EXCEPTION;
      DoArtRdrError('CheckProtocol', 'Exception:' + E.Message);
    end;
  end; // try
  Result := i4Err;
end;

function TPerioUsbReader.FindRealBlockNumber(const i2Sector: shortint;
  const uBlock: byte; out uRealBlock: byte): integer;
var
  i4Err: integer;
label lend;
begin
  try
    i4Err := TErrors.NO_ERROR;

    if i2Sector = -1 then
    begin
      i4Err := TErrors.SECTOR_IS_NOT_LOGIN;
      goto lend;
    end;

    if ((i2Sector < 32) and (uBlock >= CARDOPR_BLOCKPERSECTOR_1)) then
    begin
      i4Err := TErrors.WRONG_BLOCK_NUM;
      goto lend;
    end;

    if i2Sector < 32 then
      uRealBlock := ((i2Sector * CARDOPR_BLOCKPERSECTOR_1) + uBlock)
    else
    begin
      uRealBlock := (32 * CARDOPR_BLOCKPERSECTOR_1);
      uRealBlock := uRealBlock + ((i2Sector - 32) * CARDOPR_BLOCKPERSECTOR_2);
      uRealBlock := uRealBlock + uBlock;
    end; // else of if Fi2LoginSector < 32 then
  lend:
  except
    on E: Exception do
    begin
      DoArtRdrError('FindRealBlockNumber', 'Exception Error : ' + E.Message);
      i4Err := TErrors.EXCEPTION;
    end;
  end; // try
  Result := i4Err;
end;

function TPerioUsbReader.WaitToFinish(u4StartTime: cardinal;
  u4TimeOut: cardinal): integer;
Var
  iErr: Integer;
  u4ElapsedTime: cardinal;
Begin
  u4ElapsedTime := 0;
  try
    while (not fRxFlag) and ((u4StartTime + u4TimeOut) >= lTimeToMs(now)) do
    Begin
      u4ElapsedTime := lTimeToMs(now) - u4StartTime;
    End;
    if fRxFlag then
      iErr := 0
    else
      iErr := TErrors.TIMEOUT;
  except
    on E: Exception do
    begin
      DoArtRdrError('WaitToFinish', 'Exception Error : ' + E.Message+' - '+u4ElapsedTime.ToString());
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioUsbReader.lTimeToMs(dt: TDateTime): cardinal;
var
  AHour, AMinute, ASecond, AMilliSecond: word;
begin
  DecodeTime(dt, AHour, AMinute, ASecond, AMilliSecond);
  Result := (AHour * 60 * 60 * 1000) + (AMinute * 60 * 1000) + (ASecond * 1000)
    + AMilliSecond;
end;

constructor TPerioUsbReader.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BaudRate := br9600;
  TriggersOnRxChar := False;
  fOnCmdRx := False;
  FbSelectCard := False;
  fcmdRetry := 3;
  fRxCount := 0;
  fRxFlag := False;
  Events := [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR,
    evError, evRLSD, evRx80Full];
  Port := 'COM3'
end;

destructor TPerioUsbReader.Destroy;
begin
  inherited Destroy;
end;

procedure TPerioUsbReader.DoRxFlag;
Begin
  inherited;
  fRxFlag := True;
End;

procedure TPerioUsbReader.DoRxChar(Count: Integer);
Begin
  inherited;
  fRxCount := Count;
End;

procedure TPerioUsbReader.DoArtRdrError(MethodName, Msg: string);
Var
  ErrMsg: String;
begin
  ErrMsg := '[' + MethodName + '] ' + Msg;
  if Assigned(fOnError) then
    fOnError(Self, ErrMsg)
  else
    raise Exception.Create(ErrMsg);
end;

procedure TPerioUsbReader.DoRxBuf(const Buffer; Count: Integer);
var
  Rxbuf: TRDRBuffer;
  TermNo, i: Integer;
  strCardID: String;
Begin
  if (not fOnCmdRx) then
  Begin
    case Count of
      10: // SendCardID
        Begin
          FillChar(Rxbuf.uaBuff, BUFFSIZE, 0);
          Rxbuf.u2Len := Count;
          Rxbuf.uaBuff := TByteBuffer(Buffer);
          TermNo := Rxbuf.uaBuff[DATA_START_POS];
          strCardID := '';
          for I := 0 to 3 do
            strCardID := strCardID +
              HexToStr(Rxbuf.uaBuff[DATA_START_POS + 1 + i], 1);
          DoRxCardID(TermNo, strCardID);
          // LogDebug('DoRxBuf','TermNo: '+IntToStr(TermNo)+' CardID : '+strCardID);
        End;
      13: // SendCardID
        Begin
          FillChar(Rxbuf.uaBuff, BUFFSIZE, 0);
          Rxbuf.u2Len := Count;
          Rxbuf.uaBuff := TByteBuffer(Buffer);
          TermNo := Rxbuf.uaBuff[DATA_START_POS];
          strCardID := '';
          for I := 0 to 6 do
            strCardID := strCardID +
              HexToStr(Rxbuf.uaBuff[DATA_START_POS + 1 + i], 1);
          DoRxCardID(TermNo, strCardID);
          // LogDebug('DoRxBuf','TermNo: '+IntToStr(TermNo)+' CardID : '+strCardID);
        End;
      20: // SendCardID
        Begin
          FillChar(Rxbuf.uaBuff, BUFFSIZE, 0);
          Rxbuf.u2Len := Count;
          Rxbuf.uaBuff := TByteBuffer(Buffer);
          TermNo := Rxbuf.uaBuff[DATA_START_POS];
          strCardID := '';
          for I := 0 to 6 do
            strCardID := strCardID +
              HexToStr(Rxbuf.uaBuff[DATA_START_POS + 1 + i], 1);
          DoRxCardID(TermNo, strCardID);
          // LogDebug('DoRxBuf','TermNo: '+IntToStr(TermNo)+' CardID : '+strCardID);
        End;
    end;
  End;
  inherited;
End;

procedure TPerioUsbReader.DoRxCardID(Const TermNo: Integer; const CardID: string);
Begin
  if Assigned(OnRxCardID) then
    OnRxCardID(Self, TermNo, CardID);
End;

function TPerioUsbReader.SelectCard(Var CardID: String): Integer;
Var
  iErr, RtryCnt: Integer;
  RxDataLen: word;
  Doexception: boolean;
begin
  iErr := 0;
  try
    FTxBuffer.u2Len := 0;
    FRxBuffer.u2Len := 0;
    FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
    FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);

    fOnCmdRx := True;
    FbSelectCard := False;
    Doexception := False;
    fi2LoginSector := -1;
    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          FTxBuffer.uaBuff[DATA_START_POS] := ord('s');
          SetProtocol(1);
          iErr := Write(FTxBuffer.uaBuff, 6);
          if iErr = 6 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 9);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 4 then
              begin
                iErr := TErrors.NO_ERROR;
                CardID := HexToStr(FRxBuffer.uaBuff[DATA_START_POS], 1) +
                  HexToStr(FRxBuffer.uaBuff[DATA_START_POS + 1], 1) +
                  HexToStr(FRxBuffer.uaBuff[DATA_START_POS + 2], 1) +
                  HexToStr(FRxBuffer.uaBuff[DATA_START_POS + 3], 1);
                FbSelectCard := True;
                // LogDebug('SelectCard','iErr : '+IntToStr(iErr) + ' CardID :'+CardID);
              end
              else if ((RxDataLen = 1) and
                (FRxBuffer.uaBuff[DATA_START_POS] = $4E)) then
                iErr := TErrors.NO_CARD
              else if ((RxDataLen = 1) and
                (FRxBuffer.uaBuff[DATA_START_POS] = ord('?'))) then
                iErr := TErrors.WRONG_DATA_ONTX;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            FbSelectCard := False;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('SelectCard', 'Exception: ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;
  finally
    fOnCmdRx := False;
  end;
  Result := iErr;
end;

function TPerioUsbReader.ExtendedSelectCard(Var CardType: byte;
  Var CardID: String): Integer;
Var
  iErr, RtryCnt: Integer;
  RxDataLen: word;
  Doexception: boolean;
begin
  iErr := 0;
  try
    FTxBuffer.u2Len := 0;
    FRxBuffer.u2Len := 0;
    FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
    FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
    fOnCmdRx := True;
    FbSelectCard := False;
    Doexception := False;
    fi2LoginSector := -1;
    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          FTxBuffer.uaBuff[DATA_START_POS] := ord('s');
          FTxBuffer.uaBuff[DATA_START_POS + 1] := ord('x');
          SetProtocol(2);
          iErr := Write(FTxBuffer.uaBuff, 7);
          if iErr = 7 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 15);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 4 then
              begin
                iErr := TErrors.NO_ERROR;
                CardType := FRxBuffer.uaBuff[DATA_START_POS];
                CardID := HexToStr(FRxBuffer.uaBuff[DATA_START_POS + 1], 1) +
                  HexToStr(FRxBuffer.uaBuff[DATA_START_POS + 2], 1) +
                  HexToStr(FRxBuffer.uaBuff[DATA_START_POS + 3], 1) +
                  HexToStr(FRxBuffer.uaBuff[DATA_START_POS + 4], 1);
                FbSelectCard := True;
                // LogDebug('ExtendedSelectCard','iErr : '+IntToStr(iErr) +' CardType : '+IntToStr(CardType)+ ' CardID :'+CardID);
              end
              else if ((RxDataLen = 1) and
                (FRxBuffer.uaBuff[DATA_START_POS] = $4E)) then
                iErr := TErrors.NO_CARD
              else if ((RxDataLen = 1) and
                (FRxBuffer.uaBuff[DATA_START_POS] = ord('?'))) then
                iErr := TErrors.WRONG_DATA_ONTX;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('ExtendedSelectCard', 'Exception: ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  finally
    fOnCmdRx := False;
  end;
  Result := iErr;
end;

function TPerioUsbReader.SectorLogin_withFKey_Philips(uSectorNum: byte): integer;
Var
  iErr, RtryCnt: Integer;
  RxDataLen: word;
  Doexception: boolean;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fi2LoginSector := -1;
  fOnCmdRx := True;
  Doexception := False;
  iErr := 0;
  try
    if not FbSelectCard then
    Begin
      iErr := TErrors.CARD_IS_NOT_SELECTED;
      goto lend;
    End;

    if (uSectorNum >= CARDOPR_SECTORCOUNT) then
    Begin
      iErr := TErrors.WRONG_SECTOR_NUM;
      goto lend;
    End;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          FTxBuffer.uaBuff[DATA_START_POS] := $6C;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := uSectorNum;
          FTxBuffer.uaBuff[DATA_START_POS + 2] := $FF;
          FTxBuffer.uaBuff[DATA_START_POS + 3] := $0D;
          SetProtocol(4);

          iErr := Write(FTxBuffer.uaBuff, 9);
          if iErr = 9 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 15);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'L':
                    Begin
                      fi2LoginSector := uSectorNum;
                      iErr := TErrors.NO_ERROR;
                      // LogDebug('SectorLogin_withFKey_Philips','iErr : '+IntToStr(iErr)+' uSectorNum : '+IntToStr(uSectorNum));
                    End;
                  'N':
                    iErr := TErrors.NO_CARD;
                  'F':
                    iErr := TErrors.FAIL;
                  'E':
                    iErr := TErrors.FAULTY_CMD_KEYTYPE;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('SectorLogin_withFKey_Philips', 'Exception: ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      fOnCmdRx := False;
      DoArtRdrError('SectorLogin_withFKey_Philips', '[2] Exception: ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.SectorLogin_withFKey_Infineon(KeyType: TKeyType;
  uSectorNum: byte): integer;
Var
  iErr, RtryCnt: Integer;
  RxDataLen: word;
  Doexception: boolean;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fi2LoginSector := -1;
  fOnCmdRx := True;
  Doexception := False;
  iErr := 0;
  try
    if not FbSelectCard then
    Begin
      iErr := TErrors.CARD_IS_NOT_SELECTED;
      goto lend;
    End;

    if (uSectorNum >= CARDOPR_SECTORCOUNT) then
    Begin
      iErr := TErrors.WRONG_SECTOR_NUM;
      goto lend;
    End;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          FTxBuffer.uaBuff[DATA_START_POS] := $6C;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := uSectorNum;
          if KeyType = ktKeyA then
            FTxBuffer.uaBuff[DATA_START_POS + 2] := $AA
          else
            FTxBuffer.uaBuff[DATA_START_POS + 2] := $BB;
          FTxBuffer.uaBuff[DATA_START_POS + 3] := $0D;
          SetProtocol(4);

          iErr := Write(FTxBuffer.uaBuff, 9);
          if iErr = 9 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 15);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'L':
                    Begin
                      fi2LoginSector := uSectorNum;
                      iErr := TErrors.NO_ERROR;
                      // LogDebug('SectorLogin_withFKey_Infineon','iErr : '+IntToStr(iErr)+' uSectorNum : '+IntToStr(uSectorNum));
                    End;
                  'N':
                    iErr := TErrors.NO_CARD;
                  'F':
                    iErr := TErrors.FAIL;
                  'E':
                    iErr := TErrors.FAULTY_CMD_KEYTYPE;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('SectorLogin_withFKey_Infineon', 'Exception: ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('SectorLogin_withFKey_Infineon', '[2] Exception: ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.SectorLogin_withKey(KeyType: TKeyType;
  Key: array of byte; uSectorNum: byte): integer;
Var
  iErr, RtryCnt, i: Integer;
  RxDataLen: word;
  Doexception: boolean;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fi2LoginSector := -1;
  fOnCmdRx := True;
  Doexception := False;
  iErr := 0;
  try
    if not FbSelectCard then
    Begin
      iErr := TErrors.CARD_IS_NOT_SELECTED;
      goto lend;
    End;

    if (uSectorNum >= CARDOPR_SECTORCOUNT) then
    Begin
      iErr := TErrors.WRONG_SECTOR_NUM;
      goto lend;
    End;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          FTxBuffer.uaBuff[DATA_START_POS] := $6C;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := uSectorNum;
          if KeyType = ktKeyA then
            FTxBuffer.uaBuff[DATA_START_POS + 2] := $AA
          else
            FTxBuffer.uaBuff[DATA_START_POS + 2] := $BB;

          for I := 0 to 5 do
            FTxBuffer.uaBuff[DATA_START_POS + 3 + i] := Key[i];

          SetProtocol(9);

          iErr := Write(FTxBuffer.uaBuff, 14);
          if iErr = 14 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 15);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'L':
                    Begin
                      fi2LoginSector := uSectorNum;
                      iErr := TErrors.NO_ERROR;
                      // LogDebug('SectorLogin_withKey','iErr : '+IntToStr(iErr)+' uSectorNum : '+IntToStr(uSectorNum));
                    End;
                  'N':
                    iErr := TErrors.NO_CARD;
                  'F':
                    iErr := TErrors.FAIL;
                  'E':
                    iErr := TErrors.FAULTY_CMD_KEYTYPE;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('SectorLogin_withKey', 'Exception: ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('SectorLogin_withKey', '[2] Exception: ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.SectorLogin_withMasterKey(KeyType: TKeyType;
  uSectorNum, uMasterKeynum: byte): integer;
Var
  iErr, RtryCnt: Integer;
  RxDataLen: word;
  Doexception: boolean;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fi2LoginSector := -1;
  fOnCmdRx := True;
  Doexception := False;
  iErr := 0;
  try
    if not FbSelectCard then
    Begin
      iErr := TErrors.CARD_IS_NOT_SELECTED;
      goto lend;
    End;

    if (uSectorNum >= CARDOPR_SECTORCOUNT) then
    Begin
      iErr := TErrors.WRONG_SECTOR_NUM;
      goto lend;
    End;

    if (uMasterKeynum >= CARDOPR_MASTERKEYCOUNT) then
    Begin
      iErr := TErrors.WRONG_MASTERKEY_NUM;
      goto lend;
    End;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          FTxBuffer.uaBuff[DATA_START_POS] := $6C;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := uSectorNum;
          if KeyType = ktKeyA then
            FTxBuffer.uaBuff[DATA_START_POS + 2] := $10 + uMasterKeynum
          else
            FTxBuffer.uaBuff[DATA_START_POS + 2] := $30 + uMasterKeynum;

          SetProtocol(3);

          iErr := Write(FTxBuffer.uaBuff, 8);
          if iErr = 8 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 15);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'L':
                    Begin
                      fi2LoginSector := uSectorNum;
                      iErr := TErrors.NO_ERROR;
                      // LogDebug('SectorLogin_withMasterKey','iErr : '+IntToStr(iErr)+' MasterKeyNum : '+IntToStr(uMasterKeyNum)+' uSectorNum : '+IntToStr(uSectorNum));
                    End;
                  'N':
                    iErr := TErrors.NO_CARD;
                  'F':
                    iErr := TErrors.FAIL;
                  'E':
                    iErr := TErrors.FAULTY_CMD_KEYTYPE;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('SectorLogin_withMasterKey', 'Exception: ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('SectorLogin_withMasterKey', '[2] Exception: ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.WriteMasterKey(uMasterKeynum: byte;
  Key: array of byte): integer;
Var
  iErr, RtryCnt, i: Integer;
  RxDataLen: word;
  Doexception: boolean;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  iErr := 0;
  try

    if (uMasterKeynum >= CARDOPR_MASTERKEYCOUNT) then
    Begin
      iErr := TErrors.WRONG_MASTERKEY_NUM;
      goto lend;
    End;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          sleep(1);
          FTxBuffer.uaBuff[DATA_START_POS] := $77;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := $6D;
          FTxBuffer.uaBuff[DATA_START_POS + 2] := uMasterKeynum;

          for i := 0 to CARDOPR_KEYSIZE - 1 do
            FTxBuffer.uaBuff[DATA_START_POS + 3 + i] := Key[i];
          SetProtocol(CARDOPR_KEYSIZE + 3);

          iErr := Write(FTxBuffer.uaBuff, 14);
          if iErr = 14 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut * 3);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 15);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'B':
                    Begin
                      iErr := TErrors.NO_ERROR;
                      // LogDebug('WriteMasterKey','iErr : '+IntToStr(iErr)+' MasterKeyNum : '+IntToStr(uMasterKeyNum));
                    End;
                  'F':
                    iErr := TErrors.FAIL;
                  'E':
                    iErr := TErrors.FAULTY_CMD_KEYTYPE;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('WriteMasterKey', 'Exception: ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('WriteMasterKey', '[2] Exception: ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.ReadBlock(out ValueBuf: array of byte;
  BlockNum: byte): integer;
Var
  iErr, RtryCnt, i: Integer;
  uRealBlockNum: byte;
  RxDataLen: word;
  Doexception: boolean;
  LogStr: String;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  try
    FillChar(ValueBuf, CARDOPR_BLOCKSIZE, 0);

    if (fi2LoginSector = -1) then
    Begin
      iErr := TErrors.SECTOR_IS_NOT_LOGIN;
      goto lend;
    End;

    uRealBlockNum := 0;

    iErr := FindRealBlockNumber(fi2LoginSector, BlockNum, uRealBlockNum);
    if iErr <> 0 then
      goto lend;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          FTxBuffer.uaBuff[DATA_START_POS] := $72;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := uRealBlockNum;
          SetProtocol(2);

          iErr := Write(FTxBuffer.uaBuff, 7);
          if iErr = 7 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 40);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin

              if RxDataLen = CARDOPR_BLOCKSIZE then
              begin
                LogStr := '';
                for I := 0 to CARDOPR_BLOCKSIZE - 1 do
                Begin
                  ValueBuf[i] := FRxBuffer.uaBuff[DATA_START_POS + i];
                  LogStr := LogStr + '[' + IntToStr(i) + '] [' +
                    IntToStr(ValueBuf[i]) + ']';
                End;
              end
              else if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'F':
                    iErr := TErrors.FAIL;
                  'N':
                    iErr := TErrors.NO_CARD;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('ReadBlock', 'Exception : ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('ReadBlock', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.WriteBlock(ValueBuf: array of byte;
  BlockNum: byte): integer;
Var
  iErr, RtryCnt, i: Integer;
  uRealBlockNum: byte;
  RxDataLen: word;
  Doexception: boolean;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  try

    if (fi2LoginSector = -1) then
    Begin
      iErr := TErrors.SECTOR_IS_NOT_LOGIN;
      goto lend;
    End;

    uRealBlockNum := 0;

    iErr := FindRealBlockNumber(fi2LoginSector, BlockNum, uRealBlockNum);
    if iErr <> 0 then
      goto lend;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          FTxBuffer.uaBuff[DATA_START_POS] := $77;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := uRealBlockNum;
          for I := 0 to CARDOPR_BLOCKSIZE - 1 do
            FTxBuffer.uaBuff[DATA_START_POS + 2 + i] := ValueBuf[i];
          SetProtocol(CARDOPR_BLOCKSIZE + 2);

          iErr := Write(FTxBuffer.uaBuff, 23);
          if iErr = 23 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 40);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin

              if RxDataLen = CARDOPR_BLOCKSIZE then
              begin
                iErr := TErrors.NO_ERROR;
                for I := 0 to CARDOPR_BLOCKSIZE - 1 do
                begin
                  if FRxBuffer.uaBuff[DATA_START_POS + i] <> ValueBuf[i] then
                  begin
                    iErr := TErrors.WRITE_ERROR;
                    break;
                  end;
                end;
              end
              else if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'F':
                    iErr := TErrors.FAIL;
                  'N':
                    iErr := TErrors.NO_CARD;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('WriteBlock', 'Exception : ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('WriteBlock', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.ReadValue(Var Value: cardinal; BlockNum: byte): integer;
Var
  iErr, RtryCnt: Integer;
  uRealBlockNum: byte;
  RxDataLen: word;
  Doexception: boolean;
  LogStr: String;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  Value := 0;
  try

    if (fi2LoginSector = -1) then
    Begin
      iErr := TErrors.SECTOR_IS_NOT_LOGIN;
      goto lend;
    End;

    uRealBlockNum := 0;

    iErr := FindRealBlockNumber(fi2LoginSector, BlockNum, uRealBlockNum);
    if iErr <> 0 then
      goto lend;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);

          FTxBuffer.uaBuff[DATA_START_POS] := $72;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := $76;
          FTxBuffer.uaBuff[DATA_START_POS + 2] := uRealBlockNum;
          SetProtocol(3);

          iErr := Write(FTxBuffer.uaBuff, 8);
          if iErr = 8 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 9);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin

              if RxDataLen = CARDOPR_VALSIZE then
              begin
                iErr := TErrors.NO_ERROR;
                Value := FRxBuffer.uaBuff[DATA_START_POS] + FRxBuffer.uaBuff
                  [DATA_START_POS + 1] * $100 + FRxBuffer.uaBuff
                  [DATA_START_POS + 2] * $10000 + FRxBuffer.uaBuff
                  [DATA_START_POS + 3] * $1000000;

                LogStr := IntToStr(Value);
                // LogDebug('ReadValue',' Value : '+ LogStr);
              end
              else if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'F':
                    iErr := TErrors.FAIL;
                  'N':
                    iErr := TErrors.NO_CARD;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
              // else of if Fu2RxDataLen = CARDOPR_BLOCKSIZE then
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('ReadValue', 'Exception : ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('ReadValue', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.WriteValue(Value: cardinal; BlockNum: byte): integer;
Var
  iErr, RtryCnt: Integer;
  uRealBlockNum: byte;
  RxDataLen: word;
  Doexception: boolean;
  u4TempVal: cardinal;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;

  try

    if (fi2LoginSector = -1) then
    Begin
      iErr := TErrors.SECTOR_IS_NOT_LOGIN;
      goto lend;
    End;

    uRealBlockNum := 0;

    iErr := FindRealBlockNumber(fi2LoginSector, BlockNum, uRealBlockNum);
    if iErr <> 0 then
      goto lend;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);

          FTxBuffer.uaBuff[DATA_START_POS] := $77;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := $76;
          FTxBuffer.uaBuff[DATA_START_POS + 2] := uRealBlockNum;
          FTxBuffer.uaBuff[DATA_START_POS + 3] := (Value and $FF);
          FTxBuffer.uaBuff[DATA_START_POS + 4] := ((Value shr 8) and $FF);
          FTxBuffer.uaBuff[DATA_START_POS + 5] := ((Value shr 16) and $FF);
          FTxBuffer.uaBuff[DATA_START_POS + 6] := ((Value shr 24) and $FF);
          SetProtocol(CARDOPR_VALSIZE + 3);

          iErr := Write(FTxBuffer.uaBuff, 12);
          if iErr = 12 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 9);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin

              if RxDataLen = CARDOPR_VALSIZE then
              begin
                u4TempVal := FRxBuffer.uaBuff[DATA_START_POS] + FRxBuffer.uaBuff
                  [DATA_START_POS + 1] * $100 + FRxBuffer.uaBuff
                  [DATA_START_POS + 2] * $10000 + FRxBuffer.uaBuff
                  [DATA_START_POS + 3] * $1000000;
                if u4TempVal = Value then
                  iErr := TErrors.NO_ERROR
                else
                  iErr := TErrors.WRITE_ERROR;
                // LogDebug('WriteValue','iErr : '+IntToStr(iErr)+' Write Value : '+IntToStr(u4TempVal));
              end
              else if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'F':
                    iErr := TErrors.FAIL;
                  'N':
                    iErr := TErrors.NO_CARD;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
              // else of if Fu2RxDataLen = CARDOPR_BLOCKSIZE then

            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('WriteValue', 'Exception : ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('WriteValue', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.CopyValue(SrcBlockNum, DestBlockNum: byte): integer;
Var
  iErr, RtryCnt: Integer;
  uRealBlockNum1, uRealBlockNum2: byte;
  RxDataLen: word;
  Doexception: boolean;
  //u4TempVal: cardinal;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  try

    if (fi2LoginSector = -1) then
    Begin
      iErr := TErrors.SECTOR_IS_NOT_LOGIN;
      goto lend;
    End;

    uRealBlockNum1 := 0;

    iErr := FindRealBlockNumber(fi2LoginSector, SrcBlockNum, uRealBlockNum1);
    if iErr <> 0 then
      goto lend;

    uRealBlockNum2 := 0;

    iErr := FindRealBlockNumber(fi2LoginSector, DestBlockNum, uRealBlockNum2);
    if iErr <> 0 then
      goto lend;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);

          FTxBuffer.uaBuff[DATA_START_POS] := $3D;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := uRealBlockNum1;
          FTxBuffer.uaBuff[DATA_START_POS + 2] := uRealBlockNum2;
          SetProtocol(3);

          iErr := Write(FTxBuffer.uaBuff, 8);
          if iErr = 8 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 9);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin

              if RxDataLen = CARDOPR_VALSIZE then
              begin
                //u4TempVal := FRxBuffer.uaBuff[DATA_START_POS] + FRxBuffer.uaBuff
                //  [DATA_START_POS + 1] * $100 + FRxBuffer.uaBuff
                //  [DATA_START_POS + 2] * $10000 + FRxBuffer.uaBuff
                //  [DATA_START_POS + 3] * $1000000;
                iErr := TErrors.NO_ERROR;
              end
              else if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'F':
                    iErr := TErrors.FAIL;
                  'N':
                    iErr := TErrors.NO_CARD;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('CopyValue', 'Exception : ' + E.Message);
          end;
        end; // try
      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('CopyValue', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.IncValue(IncValue: cardinal; BlockNum: byte): integer;
Var
  iErr, RtryCnt: Integer;
  uRealBlockNum: byte;
  RxDataLen: word;
  Doexception: boolean;
  //u4TempVal: cardinal;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  try

    if (fi2LoginSector = -1) then
    Begin
      iErr := TErrors.SECTOR_IS_NOT_LOGIN;
      goto lend;
    End;

    uRealBlockNum := 0;

    iErr := FindRealBlockNumber(fi2LoginSector, BlockNum, uRealBlockNum);
    if iErr <> 0 then
      goto lend;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);

          FTxBuffer.uaBuff[DATA_START_POS] := $2B;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := uRealBlockNum;
          FTxBuffer.uaBuff[DATA_START_POS + 2] := (IncValue and $FF);
          FTxBuffer.uaBuff[DATA_START_POS + 3] := ((IncValue shr 8) and $FF);
          FTxBuffer.uaBuff[DATA_START_POS + 4] := ((IncValue shr 16) and $FF);
          FTxBuffer.uaBuff[DATA_START_POS + 5] := ((IncValue shr 24) and $FF);
          SetProtocol(CARDOPR_VALSIZE + 2);

          iErr := Write(FTxBuffer.uaBuff, 11);
          if iErr = 11 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 9);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin

              if RxDataLen = CARDOPR_VALSIZE then
              begin
                //u4TempVal := FRxBuffer.uaBuff[DATA_START_POS] + FRxBuffer.uaBuff
                //  [DATA_START_POS + 1] * $100 + FRxBuffer.uaBuff
                //  [DATA_START_POS + 2] * $10000 + FRxBuffer.uaBuff
                //  [DATA_START_POS + 3] * $1000000;
                iErr := TErrors.NO_ERROR;
              end
              else if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'F':
                    iErr := TErrors.FAIL;
                  'N':
                    iErr := TErrors.NO_CARD;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
              // else of if Fu2RxDataLen = CARDOPR_BLOCKSIZE then

            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('IncValue', 'Exception : ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('IncValue', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.DecValue(DecValue: cardinal; BlockNum: byte): integer;
Var
  iErr, RtryCnt: Integer;
  uRealBlockNum: byte;
  RxDataLen: word;
  Doexception: boolean;
  //u4TempVal: cardinal;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  try

    if (fi2LoginSector = -1) then
    Begin
      iErr := TErrors.SECTOR_IS_NOT_LOGIN;
      goto lend;
    End;

    uRealBlockNum := 0;

    iErr := FindRealBlockNumber(fi2LoginSector, BlockNum, uRealBlockNum);
    if iErr <> 0 then
      goto lend;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);

          FTxBuffer.uaBuff[DATA_START_POS] := $2D;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := uRealBlockNum;
          FTxBuffer.uaBuff[DATA_START_POS + 2] := (DecValue and $FF);
          FTxBuffer.uaBuff[DATA_START_POS + 3] := ((DecValue shr 8) and $FF);
          FTxBuffer.uaBuff[DATA_START_POS + 4] := ((DecValue shr 16) and $FF);
          FTxBuffer.uaBuff[DATA_START_POS + 5] := ((DecValue shr 24) and $FF);
          SetProtocol(CARDOPR_VALSIZE + 2);

          iErr := Write(FTxBuffer.uaBuff, 11);
          if iErr = 11 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 9);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin

              if RxDataLen = CARDOPR_VALSIZE then
              begin
                //u4TempVal := FRxBuffer.uaBuff[DATA_START_POS] + FRxBuffer.uaBuff
                //  [DATA_START_POS + 1] * $100 + FRxBuffer.uaBuff
                //  [DATA_START_POS + 2] * $10000 + FRxBuffer.uaBuff
                //  [DATA_START_POS + 3] * $1000000;
                iErr := TErrors.NO_ERROR;
              end
              else if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'F':
                    iErr := TErrors.FAIL;
                  'N':
                    iErr := TErrors.NO_CARD;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('DecValue', 'Exception : ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;
  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('DecValue', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.ConfigSector(FormNum: String;
  KeyA, KeyB: array of byte): integer;
Var
  iErr, RtryCnt, i: Integer;
  RxDataLen: word;
  Doexception: boolean;
  chFormNum: AnsiChar;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  iErr := 0;
  try
    if (fi2LoginSector = -1) then
    Begin
      iErr := TErrors.SECTOR_IS_NOT_LOGIN;
      goto lend;
    End;

    if (fi2LoginSector >= CARDOPR_SECTORCOUNT) then
    Begin
      iErr := TErrors.WRONG_SECTOR_NUM;
      goto lend;
    End;

    chFormNum := AnsiChar(FormNum[1]);
    if not(chFormNum in ['F', '0', '1', '2', '3', '4', '5', '6', '7']) then
    Begin
      iErr := TErrors.WRONG_FORM_NUM;
      goto lend;
    End;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          FTxBuffer.uaBuff[DATA_START_POS] := $66;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := fi2LoginSector;
          if FormNum = 'F' then
            FTxBuffer.uaBuff[DATA_START_POS + 2] := $0F
          else
            FTxBuffer.uaBuff[DATA_START_POS + 2] := StrToInt(FormNum);

          for I := 0 to CARDOPR_KEYSIZE - 1 do
            FTxBuffer.uaBuff[DATA_START_POS + 3 + i] := KeyA[i];
          for I := 0 to CARDOPR_KEYSIZE - 1 do
            FTxBuffer.uaBuff[DATA_START_POS + 3 + CARDOPR_KEYSIZE + i]
              := KeyB[i];

          SetProtocol(CARDOPR_KEYSIZE * 2 + 3);

          iErr := Write(FTxBuffer.uaBuff, 20);
          if iErr = 20 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 6);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'B':
                    Begin
                      iErr := TErrors.NO_ERROR;
                      // LogDebug('ConfigSector','iErr : '+IntToStr(iErr)+' SectorNum : '+IntToStr(fi2LoginSector));
                    End;
                  'N':
                    iErr := TErrors.NO_CARD;
                  'F':
                    iErr := TErrors.FAIL;
                  'E':
                    iErr := TErrors.FAULTY_CMD_KEYTYPE;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                  // {i4Err:=} rdrParseForAutoRxData();
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('ConfigSector', 'Exception : ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('ConfigSector', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.ReadSectorForm(Var FormNum: String): integer;
Var
  iErr, RtryCnt: Integer;
  RxDataLen: word;
  Doexception: boolean;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  iErr := 0;
  try
    if (fi2LoginSector = -1) then
    Begin
      iErr := TErrors.SECTOR_IS_NOT_LOGIN;
      goto lend;
    End;

    if (fi2LoginSector >= CARDOPR_SECTORCOUNT) then
    Begin
      iErr := TErrors.WRONG_SECTOR_NUM;
      goto lend;
    End;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          FTxBuffer.uaBuff[DATA_START_POS] := $72;
          FTxBuffer.uaBuff[DATA_START_POS + 1] := $66;
          FTxBuffer.uaBuff[DATA_START_POS + 2] := fi2LoginSector;
          SetProtocol(3);

          iErr := Write(FTxBuffer.uaBuff, 8);
          if iErr = 8 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 15);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 1 then
              begin
                case FRxBuffer.uaBuff[DATA_START_POS] of
                  0 .. 7:
                    begin
                      iErr := TErrors.NO_ERROR;
                      FormNum := IntToStr(FRxBuffer.uaBuff[DATA_START_POS]);
                      // LogDebug('ReadSectorForm','FormNum : ' + FormNum);
                    end;
                  $0F:
                    begin
                      iErr := TErrors.NO_ERROR;
                      FormNum := 'F';
                      // LogDebug('ReadSectorForm','FormNum : F ');
                    end;
                  ord('U'):
                    iErr := TErrors.UNKNOWN_FORM_NUM;
                  ord('F'):
                    iErr := TErrors.FAIL;
                  ord('N'):
                    iErr := TErrors.NO_CARD;
                  ord('E'):
                    iErr := TErrors.ERR_CMD_FORM;
                  ord('?'):
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of

              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('ReadSectorForm', 'Exception : ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('ReadSectorForm', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.SetOutput(uIONum: byte; IOState: TIOState;
  Duration: byte): integer;
Var
  iErr: Integer;
  RxDataLen: word;
  LogStr: String;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  try

    if uIONum >= IO_COUNT then
    begin
      iErr := TErrors.WRONG_IO_NUM;
      goto lend;
    end;
    if Connected then
    Begin
      try
        ClearBuffer(True, True);

        FTxBuffer.uaBuff[DATA_START_POS] := $6F;
        FTxBuffer.uaBuff[DATA_START_POS + 1] := (uIONum and $0F);

        case IOState of
          ioOn:
            FTxBuffer.uaBuff[DATA_START_POS + 1] := FTxBuffer.uaBuff
              [DATA_START_POS + 1] or ($00); // etkisiz eleman ama kalsýn
          ioBlink, ioOff:
            FTxBuffer.uaBuff[DATA_START_POS + 1] := FTxBuffer.uaBuff
              [DATA_START_POS + 1] or ($10);
        end; // case FrMainIO.rSetOutput.rIO.rState of

        if IOState = ioOff then
          FTxBuffer.uaBuff[DATA_START_POS + 2] := 1
        else
          FTxBuffer.uaBuff[DATA_START_POS + 2] := Duration;

        SetProtocol(3);

        iErr := Write(FTxBuffer.uaBuff, 8);
        if iErr = 8 then
        Begin
          fRxFlag := False;
          WaitToFinish(lTimeToMs(now), fReadTimeOut);
          FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 6);
          iErr := CheckProtocol(RxDataLen);
          if iErr = 0 then
          Begin
            if RxDataLen = 1 then
            begin
              iErr := TErrors.NO_ERROR;
              LogStr := 'Set Output Succesfull.';
              // LogDebug( 'SetOutput','Value : '+ LogStr);
            end
            else
              iErr := TErrors.NOT_EXPECTED_DATA;
            // else of if Fu2RxDataLen = CARDOPR_BLOCKSIZE then
          End;
        End;
        // inc(RtryCnt);
      except
        on E: Exception do
        begin
          // Doexception  := True ;
          iErr := TErrors.EXCEPTION;
          DoArtRdrError('SetOutput', 'Exception : ' + E.Message);
        end;
      end; // try
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('SetOutput', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
end;

function TPerioUsbReader.SetIORedLed(Duration: byte;
  Blink: boolean = False): Integer;
Var
  iErr: Integer;
Begin
  try
    if Blink then
      iErr := SetOutput(4, ioBlink, Duration)
    else
      iErr := SetOutput(4, ioOn, Duration);
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('SetIORedLed', 'Exception : ' + E.Message);
    end;
  end;
  Result := iErr;
End;

function TPerioUsbReader.SetIOGreenLed(Duration: byte;
  Blink: boolean = False): Integer;
Var
  iErr: Integer;
Begin
  try
    if Blink then
      iErr := SetOutput(3, ioBlink, Duration)
    else
      iErr := SetOutput(3, ioOn, Duration);
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('SetIOGreenLed', 'Exception : ' + E.Message);
    end;
  end;
  Result := iErr;
End;

function TPerioUsbReader.SetIOBuzzer(Duration: byte;
  Blink: boolean = False): Integer;
Var
  iErr: Integer;
Begin
  try
    if Blink then
      iErr := SetOutput(2, ioBlink, Duration)
    else
      iErr := SetOutput(2, ioOn, Duration);
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('SetIOBuzzer', 'Exception : ' + E.Message);
    end;
  end;
  Result := iErr;
End;

function TPerioUsbReader.ReadTerminalSetup(Var DeviceParams
  : TDeviceParams): integer;
Var
  iErr, RtryCnt, i: Integer;
  RxDataLen: word;
  Doexception: boolean;
  LogStr: String;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  try
    iErr := TErrors.NO_ERROR;
    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);
          sleep(1);
          FTxBuffer.uaBuff[DATA_START_POS] := $64;
          SetProtocol(1);

          iErr := Write(FTxBuffer.uaBuff, 6);
          if iErr = 6 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 69);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 64 then
              begin
                iErr := TErrors.NO_ERROR;
                // dev is initialized
                if FRxBuffer.uaBuff[DATA_START_POS] = 85 then
                  DeviceParams.bDevIsInitialized := True
                else
                  DeviceParams.bDevIsInitialized := False;

                DeviceParams.u2DevNum := FRxBuffer.uaBuff[DATA_START_POS + 1];
                // device number
                DeviceParams.uaRFU[0] := FRxBuffer.uaBuff[DATA_START_POS + 2];
                // commspeed
                DeviceParams.uaRFU[1] := FRxBuffer.uaBuff[DATA_START_POS + 3];
                // commparity
                DeviceParams.uaRFU[2] := FRxBuffer.uaBuff[DATA_START_POS + 4];
                // commtype

                // card read mode
                case FRxBuffer.uaBuff[DATA_START_POS + 5] of
                  $99:
                    DeviceParams.rCardReadMode := crmStandardMode;
                  $88:
                    DeviceParams.rCardReadMode := crmSendCardID;
                  $77:
                    DeviceParams.rCardReadMode := crmSendBlock;
                  $66:
                    DeviceParams.rCardReadMode := crmSendSector;
                  $55:
                    DeviceParams.rCardReadMode := crmSendCardID_ASCII;
                  $44:
                    DeviceParams.rCardReadMode := crmSendBlock_ASCII;
                end;

                // keytypeandno
                case FRxBuffer.uaBuff[DATA_START_POS + 6] of
                  0 .. 31:
                    begin
                      DeviceParams.rMasterKeyType := ktKeyA;
                      DeviceParams.uMasterKeynum := FRxBuffer.uaBuff
                        [DATA_START_POS + 6];
                    end;
                  128 .. 129:
                    begin
                      DeviceParams.rMasterKeyType := ktKeyB;
                      DeviceParams.uMasterKeynum := FRxBuffer.uaBuff
                        [DATA_START_POS + 6] - 128;
                    end;
                else
                  iErr := TErrors.WRONG_MASTERKEY_NUM;
                end; // case FRxBuffer.uaBuff[DATA_START_POS + 6] of

                // buzz beep time
                DeviceParams.uBuzzBeepTime := FRxBuffer.uaBuff
                  [DATA_START_POS + 7];

                // Default block number
                DeviceParams.uDfltBlockNum := FRxBuffer.uaBuff
                  [DATA_START_POS + 8];

                // Default sector number
                DeviceParams.uDfltSectorNum := FRxBuffer.uaBuff
                  [DATA_START_POS + 9];

                // FW ver
                for I := 0 to 4 do
                  DeviceParams.uaFWVer[i] := FRxBuffer.uaBuff
                    [DATA_START_POS + 10 + i];

                DeviceParams.uaRFU[3] := FRxBuffer.uaBuff[DATA_START_POS + 15];
                LogStr := 'Succesfull';
                // LogDebug('ReadTerminalSetup', LogStr);
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
              // else of if Fu2RxDataLen = CARDOPR_BLOCKSIZE then
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('ReadTerminalSetup', 'Exception : ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('ReadTerminalSetup', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
End;

function TPerioUsbReader.WriteTerminalSetup(DeviceParams: TDeviceParams): integer;
Var
  iErr, RtryCnt: Integer;
  RxDataLen: word;
  Doexception: boolean;
  LogStr: String;
label lend;
begin
  FTxBuffer.u2Len := 0;
  FRxBuffer.u2Len := 0;
  FillChar(FTxBuffer.uaBuff, BUFFSIZE, 0);
  FillChar(FRxBuffer.uaBuff, BUFFSIZE, 0);
  fOnCmdRx := True;
  Doexception := False;
  try
    iErr := TErrors.NO_ERROR;

    if not(DeviceParams.u2DevNum in [1 .. 254]) then
    begin
      iErr := TErrors.WRONG_DEV_NUM;
      goto lend;
    end;

    if (DeviceParams.uMasterKeynum >= CARDOPR_MASTERKEYCOUNT) then
    begin
      iErr := TErrors.WRONG_MASTERKEY_NUM;
      goto lend;
    end;

    if (DeviceParams.uDfltSectorNum >= CARDOPR_SECTORCOUNT) then
    begin
      iErr := TErrors.WRONG_SECTOR_NUM;
      goto lend;
    end;

    if ((DeviceParams.uDfltSectorNum < 32) and
      (DeviceParams.uDfltBlockNum >= CARDOPR_BLOCKPERSECTOR_1)) then
    begin
      iErr := TErrors.WRONG_BLOCK_NUM;
      goto lend;
    end;

    if Connected then
    Begin
      RtryCnt := 0;
      repeat
        try
          ClearBuffer(True, True);

          FTxBuffer.uaBuff[DATA_START_POS] := $63;
          FTxBuffer.uaBuff[DATA_START_POS + 2] := DeviceParams.u2DevNum and $FF;
          case DeviceParams.rCardReadMode of
            crmStandardMode:
              FTxBuffer.uaBuff[DATA_START_POS + 6] := $99;
            crmSendCardID:
              FTxBuffer.uaBuff[DATA_START_POS + 6] := $88;
            crmSendBlock:
              FTxBuffer.uaBuff[DATA_START_POS + 6] := $77;
            crmSendSector:
              FTxBuffer.uaBuff[DATA_START_POS + 6] := $66;
            crmSendCardID_ASCII:
              FTxBuffer.uaBuff[DATA_START_POS + 6] := $55;
            crmSendBlock_ASCII:
              FTxBuffer.uaBuff[DATA_START_POS + 6] := $44;
          end;

          case DeviceParams.rMasterKeyType of
            ktKeyA:
              FTxBuffer.uaBuff[DATA_START_POS + 7] :=
                DeviceParams.uMasterKeynum;
            ktKeyB:
              FTxBuffer.uaBuff[DATA_START_POS + 7] :=
                DeviceParams.uMasterKeynum + 128;
          end;

          FTxBuffer.uaBuff[DATA_START_POS + 8] := DeviceParams.uBuzzBeepTime;

          FTxBuffer.uaBuff[DATA_START_POS + 9] := DeviceParams.uDfltBlockNum;

          FTxBuffer.uaBuff[DATA_START_POS + 10] := DeviceParams.uDfltSectorNum;

          SetProtocol(64 + 1);

          iErr := Write(FTxBuffer.uaBuff, 70);
          if iErr = 70 then
          Begin
            fRxFlag := False;
            WaitToFinish(lTimeToMs(now), fReadTimeOut);
            FRxBuffer.u2Len := Read(FRxBuffer.uaBuff, 6);
            iErr := CheckProtocol(RxDataLen);
            if iErr = 0 then
            Begin
              if RxDataLen = 1 then
              begin
                case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                  'B':
                    iErr := TErrors.NO_ERROR;
                  'F':
                    iErr := TErrors.FAIL;
                  'E':
                    iErr := TErrors.ERR_CMD_FORM;
                  '?':
                    iErr := TErrors.WRONG_DATA_ONTX;
                else
                  iErr := TErrors.NOT_EXPECTED_DATA;
                end; // case chr(FRxBuffer.uaBuff[DATA_START_POS]) of
                LogStr := 'Succesfull';
                // LogDebug('WriteTerminalSetup',LogStr);
              end
              else
                iErr := TErrors.NOT_EXPECTED_DATA;
              // else of if Fu2RxDataLen = CARDOPR_BLOCKSIZE then
            End;
          End;
          inc(RtryCnt);
        except
          on E: Exception do
          begin
            Doexception := True;
            iErr := TErrors.EXCEPTION;
            DoArtRdrError('WriteTerminalSetup', 'Exception : ' + E.Message);
          end;
        end; // try

      until (Doexception or (iErr = TErrors.NO_ERROR) or
        (iErr = TErrors.NO_CARD) or (iErr = TErrors.WRONG_DATA_ONTX) or
        (RtryCnt >= fcmdRetry));
    End
    else
      iErr := TErrors.NOT_CONNECTED;

  lend:
  except
    on E: Exception do
    begin
      iErr := TErrors.EXCEPTION;
      DoArtRdrError('WriteTerminalSetup', 'Exception[2] : ' + E.Message);
    end;
  end;
  fOnCmdRx := False;
  Result := iErr;
End;

end.
