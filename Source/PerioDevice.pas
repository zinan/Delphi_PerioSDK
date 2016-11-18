unit PerioDevice;

interface

uses
  Classes,Sysutils,DateUtils,StrUtils,Perio.Global,System.Generics.Collections;

const
  /// GLOBAL CONTANTS
  TCP_IO_BUFF_CAP = 512; // tcp/ip tx rx buffer capacity
  PrHexDigits: array [0..15] of Char = ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'); {do not localize}
  PrOctalDigits: array [0..7] of Char = ('0','1','2','3','4','5','6','7'); {do not localize}
  PrHexPrefix = '0x';  {Do not translate}

type
  TErrors = class
  const
    // Global errors
    NO_ERROR            = 0;
    TIMEOUT             = 10001;
    EXCEPTION           = 10003;
    CANNOT_CONNECT      = 10004;
    NOT_CONNECTED       = 10005;
    CANCELED_BY_USER    = 10006;
    CANNOT_SEND         = 10007;
    NOT_CREATED_TCPCOMP = 10008;
    NOT_CREATED_TCP_SOCKET = 10009;
    ALREADY_ON_CMD         = 10010;
    NOT_CREATED_THREAD     = 10011;
    TCP_CLIENT_ERROR = 10160;
    //
    // ERR_NOTFOUND  = 12;
    // Protocol errors
    DATA_IS_NOT_ENOUGH = 10130;
    WRONG_STX = 10131;
    WRONG_TCP_HEADER = 10132;
    WRONG_SERIAL_HEADER = 10133;
    WRONG_CSUM = 10134;
    WRONG_CRC = 10135;
    WRONG_ETX = 10136;
    NOT_EXPECTED_DATA = 10137;


    ACKNOWLEDGE_MISMATCH = 10138;
    NOT_CMD_SUCCESS = 10139;
    NOT_PREPARE_LOGINDATA = 10140;
    NOT_LOGIN_DEVICE = 10141;
    WRONG_SESSION_ID = 10142;
    SESSION_ID_MISMATCH = 10143;

    WRONG_DATA_ONTX       = 10144;
    WRONG_PARAMETER       = 10145;

    NOT_ENCYRPTED = 10151;
    INVALID_IP_ADRESS = 10152;
    INVALID_COMN_KEY = 10153;

    //CARD OPERATIONS
    NO_CARD               = 10540;
    FAULTY_KEY            = 10541;
    FAULTY_CMD_KEYTYPE    = 10542;
    FAIL                  = 10543;
    WRITE_ERROR           = 10545;
    WRONG_SECTOR_NUM      = 10550;
    WRONG_BLOCK_NUM       = 10551;
    WRONG_MASTERKEY_NUM   = 10552;
    WRONG_FORM_NUM        = 10553;
    ERR_CMD_FORM          = 10554;
    UNKNOWN_FORM_NUM      = 10555;
    CARD_IS_NOT_SELECTED  = 10556;
    SECTOR_IS_NOT_LOGIN   = 10557;
    WRONG_IO_NUM          = 10558;
    WRONG_IO_STATE        = 10559;
    WRONG_DEV_NUM         = 10560;
    WRONG_BCKL_CNTR       = 10561;
    NO_MORE_RECS          = 10562;
    WL_WRONG_COUNT        = 10563;
    WL_WRONG_START_POS    = 10564;
    WL_NOTCONFIRMED_COUNT = 10565;
    FU_NOFILE             = 10566;
    FU_FILE_IS_EMPTY      = 10567;
    //COMPORT
    CP_ERR_TIMEOUT           = 10900; //Timeout
    CP_ERR_NOTOPENED         = 10901; //Error: Com is not opened.
    CP_ERR_UNFINISHEDPREVCMD = 10902; //Error: The previous command is not finished yet.
    CP_ERR_SETUP             = 10904; //Error: Com port setup error.
    CP_ERR_ALREADYOPEN       = 10905; //Error: Comport is already opened.
    CP_ERR_CANNOTOPEN        = 10906; //Error: Can't open com port.
    CP_ERR_CANNOTREAD        = 10907;
    INVALID_COMPORT          = 10908;
    ERR_NODATA               = 10950;
    ERR_WRONGPAGESIZE        = 10951;
    ERR_WRONHEXDATA          = 10952;
    ERR_DB_EXCEPTIN_ERROR    = 30001;
////////////////////
///  Perio Art Device Errors
    INVALID_COMMAND_NUMBER = 20101;
    COMMAND_NOT_SET_TO_DEVICE = 20102;
    COMMAND_NOT_GET_FROM_DEVICE = 20103;
    COMMAND_NOT_GET_FROM_DB = 20104;
    NO_DATA_FOUND_FROM_DB = 20105;
    INVALID_TR_OUT_TYPE = 20106;
    INVALID_IDLE_SCREEN_TYPE = 20107;
    INVALID_REBOOT_TIME = 20108;
    INVALID_CONN_PROTOCOL_TYPE = 20109;
    INVALID_WORK_MODE = 20110;
    NOT_HEXADECIMAL_VALUE = 20111;
    NOT_TRUE_LENGHT = 20112;
    NOT_BYTE = 20113;
    DB_CONNECTION_PARAMS_NOT_FOUND = 20114;
    DB_CONNECTION_ERROR = 20115;
    ALLREADY_INITIALIZED = 20116;
  end;

{
  TErrors = class
  const
    NO_ERROR = 0;
    NOT_CREATED_THREAD = 1;
    NOT_CONNECTED_DB = 2;
    NOT_CREATED_LOG = 3;
    EXCEPTION = 4;
    DB_SQL_ERROR = 5;
    DB_ERROR = 6;
    TIMEOUT = 7;
  end;
}

type
  TByteBuffer     = array[0..1023] of byte;

  TRDRBuffer = record
    u2Len : word;
    uaBuff: TByteBuffer;
//    uaBuff : arrOfBytes;
  end;

  TTcpCompType    = (cIndy,cFnd);

  //TKeyType        = (ktKeyA, ktKeyB);

  //TIOState        = (ioOn, ioBlink, ioOff);



  TDtByte         = array[0..3] of byte;

  T6Byte          = array[0..5] of byte;

  //T16Byte         = array[0..15] of byte;

  T128Byte        = array[0..127] of byte;

 // TPerioBytes = array of byte;

  TDataByte = array [0 .. TCP_IO_BUFF_CAP - 32] of byte;

  TProtocolType = (PR0, PR1, PR2, PR3);

  TReaderType = (rdr26M, rdr63M_V3,rdr63M_V5);

  TfwAppType =(fwPDKS,fwYMK,fwHGS);

  TDFType = (df4MB,df8MB);

  TTCPSettings = record
    IPAdress : String;
    DefGetway : String;
    NetMask   : string;
    PriDNS  : string;
    SecDNS : string;
    Port : word;
    RemIpAdress : String;
    DHCP : Boolean;
    ConnectOnlyRemIpAdress: Boolean;
    ProtocolType : TProtocolType;
    ServerEchoTimeOut : Byte;
  end;

  TClientTCPSettings = record
    IPAdress : String;
    Port : word;
  end;

  TUDPSettings = record
    UDPIsActive : Boolean;
    UDPLogIsActive : Boolean;
    RemUDPAdress : String;
    UDPPort : word;
    RFU:  byte;
  end;

  TrOutType = (NrOpen,NrClosed);

  TIdleScreenType = (stText,stLogo);

  TGeneralDeviceSettings = record
    DefaultScreenTxt1 : String;
    DefaultScreenTxt2 : String;
    CardReadBeepTime : byte;
    TrOut1Type : TrOutType;
    TrOut2Type : TrOutType;
    IdleScreenType : TIdleScreenType;
    DailyRebootEnb :Boolean;
    RebootTime : TTime;
    DevNo : word;
    Backlight : word;
    Contrast : word;
    CardReadTimeOut : word;
    VariableClearTimeout : word;
    DefaultScreenFontType : byte;
    CardReadDelay : Byte;//Ms
    StatusMode :Byte;
    StatusModeType :Byte;
    Pin_BUTTON_Type : Byte;
    RFU : array [0 .. 5] of byte;
  end;

  TWorkingMode = (wmOffline,wmOfflineCard,wmTCPOnline,wmUDPOnline,wmTCPOnlineClientMode,wmSendSerail);
  TOnlineCardWorkMode = (womTCPOnline,womUDPOnline,womTCPOnlineClientMode);
  TWorkModeSettings = record
    WorkingMode : TWorkingMode;
    OfflineModePermission : Boolean;
    ServerAnswerTimeOut : LongWord;
    OfflineOnlineMode : TOnlineCardWorkMode;
    RFU : array [0 .. 4] of byte;
  end;

  TMfrKey = record
    KeyA : array [0..5] of byte;
    KeyB : array [0..5] of byte;
  end;

  TMfrKeyList = record
    Sector : array [0..15] of TMfrKey;
  end;

  TMfrKeyStr = record
    KeyA : String;
    KeyB : String;
  end;

  TMfrKeyListStr = record
    Sector : array [0..15] of TMfrKeyStr;
  end;

  TInputSettings = record
   InputType : Byte;
   InputDurationTimeout : word;
  end;

  TAccessMode = record
    AccessType : byte;
    PasswordType : byte;
  end;

  TAccessGeneralSettings = record
    InputSettings :TInputSettings;
    AccessMode :TAccessMode;
    TimeAccessConstraintEnabled:Boolean;
    PersonelTimeZoneMode : Byte;
  end;

  TAPBSettings = record
    APBType : byte;
    SequentialTransitionTime : byte;
    SecurityZone : byte;
    ApbInOut : byte;
  end;

  TBellSettings = record
    Enabled : Boolean;
    ScreenText1 : string;
    ScreenText2 : string;
    OutType : Byte;
  end;

  TOutOfServiceSettings = record
    Enabled : Boolean;
    ScreenText1 : string;
    ScreenText2 : string;
    OutType : Byte;
  end;

  TOneOOS = record
    StartTime :TTime;
    EndTime :TTime;
  end;

  TDayOSS = record
    part : array [0..3] of TOneOOS;
  end;

  TOSTable = record
    Day : array [0..7] of TDayOSS;
  end;

  THolidayDate = record
    Date : TDate;
  end;

  THolidays = record
    List : array [0..29] of THolidayDate;
  end;

  TOneBell = record
    StartTime : TTime;
    Duration : byte;
  end;

  TBellTable = record
    List : array [0..23] of TOneBell;
  end;

  TBellTableWeek = record
    List : array [0..7] of TBellTable;
  end;

  TOneTAC = Record
    StartTime : TTime;
    EndTime : TTime;
  end;

  TTACDay = record
    Part : array [0..7] of TOneTAC;
  end;

  TTACList = record
    Day : array [0..7] of TTACDay;
  end;

  TFullTimeACList = record
    List : array [0..47] of TTACList;
  end;

  TPersTZ = record
    Day : TDate;
    Part : array [0..7] of TOneTAC;
    TZListNo : byte;
  end;

  TPersTZList = record
    List : array [0..4] of TPersTZ;
  end;

  TScreenLine = record
    Text : AnsiString;
    Alligment : byte;
    X : byte;
    Y : byte;
  end;

  TLcdScreen = record
    ID : word;           //2
    HeaderType : byte;   //1
    Caption : AnsiString;    //21
    Line : array [0..4] of TScreenLine; //105   +15
    FooterType :Byte;   //1
    Footer : String;    //21
    RL_Time1 : word;    //2
    RL_Time2 : word;    //2
    BZR_time : word;    //2
    IsBlink : Boolean;  //1
    ScreenDuration : word; //2
    FontType : byte;    //1
    LineCount :byte;    //1
    NextScreen : word;// Sonraki Ekran Online Ýçin deðiþtirilebilir olsun diye eklendi
    KeyPadType:Byte;
  end;                      //177

  TPerson = record
    CardID : string;
    Name   : Ansistring;
    TimeZoneListNo : byte;
    Code : LongWord;
    Password : Word;
    EndDate  : Tdate;
    AccessDevice : Boolean;
    APBEnabled : Boolean;
    TZEnabled : Boolean;
    AccessCardEnabled : Boolean;
    isOnlineCard : Boolean;
//	  MealRightWorkMode : Byte;
//	  MealRightListNo: Byte;
//	  ContorModeEnable: Boolean;
//	  PriceGroup: Byte;
//	  ReReadPriceGroup: Byte;
//	  ReReadCount: Byte;
//	  ReReadType: Byte;
    MealSettingListNo : Byte;
	  WeeklyTotalMealCount: Byte;
	  MonthlyTotalMealCount: Byte;
    BlackListCmdNo : Byte;
    NeedCmdControl : Byte;
    BirthDate : TDate;
    PermitedInEmergency : Boolean;
  end;

  TBlackList = record
    CardID : string;
    Caption : string;
    BlackListCmdNo : Byte;
  end;

  TPersonMealSetting = record
	  MealRightWorkMode : Byte;
	  MealRightListNo: Byte;
	  ContorModeEnable: Boolean;
	  PriceGroup: Byte;
	  ReReadPriceGroup: Byte;
	  ReReadCount: Byte;
	  ReReadType: Byte;
    ReReadTimeOut : Word;
    ExtraLimit : Byte;
  end;

  TPersonCard = record
    Name : String;
    TimeAccessMask : array [0..6] of byte;
    Code : LongWord;
    Password : Word;
    EndDate  : Tdate;
    APBEnabled : Boolean;
    ATCEnabled : Boolean;
    AccessMask : array [0..95] of byte;
  end;

  TOneRecord = record
    CardID     : string;
    DoorNo     : Byte;
    RecordType : Byte;
    PdksType   : Byte;
    IOType     : Byte;
    Fee        : Word;
    LastSessionId : Cardinal;
    ReReadCnt  :  Byte;
    RFU        : array [0..1] of byte;
    TimeDate   : TDateTime;
  end;

  TAccessRecords = record
    Count : Cardinal;
    raDeviceRecs : array of TOneRecord;
  end;

  TOneHGSRecord = record
    CardID     : string;
    DoorNo     : Byte;
    RecordType : Byte;
    TimeDate   : TDateTime;
  end;

  THGSRecords = record
    Count : Cardinal;
    raDeviceRecs : array of TOneHGSRecord;
  end;

  TEksOtherSettings = Record
    PersDataCardSector : byte;
    AccessDataCardSector : byte;
  end;

  TWeekDays = record
    Names : array [0..6] of string;
  end;

  Ttree_Node = record
    Adress : LongWord;
    Value  : array [0..6] of byte;
    Color  : byte;
    Left   : LongWord;
    Right  : LongWord;
    Parent : LongWord;
  end;

  TWhiteListStatus = record
    PersCnt : LongWord;
    rb_ins_tree_root : LongWord;
    rb_Del_tree_root : LongWord;
    InsNode : Ttree_Node;
    DelNode : Ttree_Node;
  end;
  //  Smack Parmak Ýzi Cihazý Ýle ilgili
  TFpReaderType = (SmackFP,SmackFaceAndFP);

  TSmackVerificationMode = (smFPorCardorPWD=0,smFPandCard=1,smFPandPWD=2,smCardandPWD=3 ,smFPandCardandPWD = 4,smNone5 =5,smFP =6 ,smCard = 7,smNone8,smIDandWD = 9,smNone10,smFACE =11,smFACEandCard = 12,smFACEandPWD = 13,smFaceandCardandPWD = 14,smFaceandFP =15);
  TSmackModeOfControllingDoor = (smUnconditionalClose=0,smUnconditionalOpen=1,smAuto=2);
  TSmackDoorSensorType =(smNone=0,smAlwaysOpen=1,smAlwaysClose=2);
    TSmackMachinePrivilege = (smEmployee = 0,smAdministrator = 1,smEnrollmentManager = 2,smSetupManager = 3);
  TSmackSerialBaudRate = (br9600=3, br19200=4, br38400=5,br57600=6 ,br115200=7);
  TSmackSerialParityCheck = (NoMakingParityCheck = 0, EvenCheck =1, OddCheck=2);
  TSmackSerialStopBit = (StopBit1 = 0 , StopBit2=1);


  TSmackDeviceStatus = record
    NumberOfManagers        : Integer;
    NumberOfUsers           : Integer;
    NumberOfFingerPrints    : Integer;
    NumberOfPassword        : Integer;
    NumberOfManagementLog   : Integer;
    NumberOfTimeLog         : Integer;
    NumberOfCards           : Integer;
    AlarmStatus             : Integer;
    NumberOfFaces           : Integer;
    NumberOfManagementLogNotRead: Integer;
    NumberOfTimeLogNotRead  : Integer;
  end;

  TSmackDeviceSettings = record
    MaxNumManager : byte ; //0-10
    MachineID     : byte ; //1-255
    AutoPowerOfInterval	: word ; //0-9999
    DoorOpeningTime	: byte ; //0-10
    TimeLogWarning	: word ; //0-1000
    ManagementLogWarning : byte ; //0-100
    ReVerificationinterval : byte ;	//0-255
    VerificationMode : TSmackVerificationMode;
    ModeOfControllingDoor : TSmackModeOfControllingDoor;
    DoorSensorType :TSmackDoorSensorType ;
    DoorOpeningTimeout : byte;	//0-255
    AntiPass : Boolean ; //0,1
    AutoSleepInterval	: word ; //0-9999
    DaylightOffset : byte ;	//0-3
    //
    SerialBaudRate              : Integer;
    SerialParityCheck           : Integer;
    SerialStopBit               : Integer;
    DateSeparator               : Integer;
    //
    UILanguage                  : Integer;
  end;

  TfpTemplate = Record
    Cnt             : Integer;
    BackupNumber    : Array[0..9] of Boolean;
    FingerTemplate  : Array[0..9] of Ansistring;
  End;


  TSmackPerson = record
    UserID : Integer; //
    CardIDHex : Ansistring;
    CardIDInt : Int64;
    Name   : string;
    TimeAccessMask : array [0..4] of byte;
    Password : LongWord;
    fpTemplate   : TfpTemplate;
    FaceTemplate : Ansistring;
    DepartmentName : String;
    Privilege : TSmackMachinePrivilege;
    UserPeriodEnabled : Boolean;
    UserPeriodStartDate : TDate;
    UserPeriodEndDate : TDate;
  end;

  TSmackOneRecord = record
    EnrolNo    : Integer;
    DoorNo     : Integer;
    RecordType : Integer;
    TimeDate   : TDateTime;
  end;

  TSmackOneBell = record
    StartTime : TTime;
    Enabled   : Boolean;
  end;

  TSmackBellTable = record
    BellCount : byte;
    BellList  : array[0..23] of TSmackOneBell;
  end;

  TSmackOneTZ = record
    StartTime : TTime;
    EndTime   : TTime;
    VerifyMode : byte;
  end;

  TSmackWeekTZ = Record
    Week  : array[0..7] of TSmackOneTZ;
  end;

  TSmackTZTable = record
    Tz   : array[0..49] of TSmackWeekTZ;
  end;

  //  Smack Parmak Ýzi Cihazý Ýle ilgili

  //HGS Settings
  THGS_Settings = record
    PaketBoyu        : byte;
    CardBaslangic    : Byte;
    CardBoyu         : Byte;
    TrCikisSure1     : Byte;
    TrCikisSure2     : Byte;
    ProgramMode      : Byte;
    DiziEklemeSure1  : Byte;
    DiziEklemeSure2  : Byte;
    ZamanKisitEnb    : Boolean;
    AntenPower1      : byte;
    AntenPower2      : byte;
    AntenTanitim     : byte;
    DefMaksimumArac  : byte;
    DefAntiPassPack  : byte;
    AppType          : byte;
  end;

  THGSArac = record
    CardID : string;
    Name   : string;
    TimeAccessMask : array [0..6] of byte;
    Daire : Word;
    DaireHak : byte;
    AracNo  : byte;
    EndDate  : Tdate;
    AccessDevice : Boolean;
    APBEnabled : Boolean;
    ATCEnabled : Boolean;
    AccessCardEnabled : Boolean;
  end;

  TYmkSettings = record
	  UseMonthlyRight : Boolean;
	  CurrPriceList : Byte;
    YmkSectorNo : Byte;
    PlantNo : Byte;
    OutOfMealstatus : Byte;
  end;

  TOneMeal = record
    StartTime : TTime;
    StartDBY  : Byte;
    EndTime   : TTime;
    EndDBY    : Byte;
    Active    : Boolean;
  end;

  TDayMealList = record
    list : array[0..7] of TOneMeal;
  end;

  TMealTable = record
    Days : array[0..7] of TDayMealList;
  end;

  TDailyMealRight = record
    MealRigths : array [0..7] of byte;
    TotalDayRight : Byte;
  end;

  TWeaklyMealRight = record
    Days : array [0..7] of TDailyMealRight ;
    TotalWeeklyMealRight : array [0..7] of Byte;
    TotalMonthlyMealRight : array [0..7] of Byte;
  end;

  TFullMealRigthTable = record
    List : array [0..63] of TWeaklyMealRight;
  end;

  TOneMealPrice = record
    Prices : array [0..14] of word;
  end;

  TOneDayPrice = record
    Meals : array [0..7] of TOneMealPrice;
  end;

  TPriceList = record
    Name : String;
    Days : array [0..7] of TOneDayPrice;
  end;

  TFullPriceList = record
    List : array [0..15] of TPriceList;
  end;

  TMealNameList = record
    code : array [0..7] of string;
    Name : array [0..7] of string;
  end;

  TCardPersonData = record
    Name   : string;
    Code : LongWord;
    Password : Word;
    EndDate  : Tdate;
    APBEnabled : Boolean;
    TZEnabled : Boolean;
    isOnlineCard : Boolean;
    TimeZoneListNo : byte;
    AccsRestrictedZoneList: array [0..127] of Boolean;
    MealSettingListNo : Byte;
	  WeeklyTotalMealCount: Byte;
	  MonthlyTotalMealCount: Byte;
  end;

  TCanteenData = record
    LastCardID : string;
    Amount : Currency;
    Meals : array [0..7] of Byte;
    LastOperation : TDateTime;
    Last1Meal : TDateTime;
    ReReadCount : Byte;
    WeeklyDone : Byte;
    MonthlyDone : Byte;
    LastCmdSession : Cardinal;
    DeptBalance : Currency;
    BckAmount : Currency;
    BckDeptBalance : Currency;
    BckLastOperation : TDateTime;
    ValueBuf0 : array [0..15] of Byte;
    ValueBuf1 : array [0..15] of Byte;
    ValueBuf2 : array [0..15] of Byte;
  end;


  TInputConfirmationType = (ctOk,ctCancel);

  TOneCommand = record
    CmdType : Byte;
    SessionID : Cardinal;
    Amount : Word;
  end;

  TPersonCommandList = record
    List : array [0..14] of TOneCommand;
    TotalCommand : Byte;
  end;

  /////////////////////////////////////////////////////////////////
  ///  Hanvon
  THanvonCheckType = (ctFace,ctCardFace,ctCard,ctNumPassword, ctNumNface, ctCardNphoto, ctCardOrface);
  THanvonOpenDoorType = (dtFace,dtCardFace,dtCard,dtNumPassword);
  THanvonManagerType = (mtSuperAdministrator,mtNormalAdministrator, mtAccessControlAttendance, mtAttendanceOnly, mtAccessOnly, mtAuthorityForOthers);
  THanvonCardSource = (csFromDoor,csFromCheck);
  THanvonMagnetAlarmType = (atMeansNone, atMeansNormallyOpen,atMeansNormallyClosed);
  THanvonPictureType = (ptFace,ptPhoto,ptCard,ptName);

  THanvonTimeZoneStartEndTime   = record
      startTime     : TTime;
      endTime       : TTime;
  end;

  THanvonTimeZone  = record
     id             : Integer;
     name           : string;
     Sunday         : THanvonTimeZoneStartEndTime;
     Monday         : THanvonTimeZoneStartEndTime;
     Tuesday        : THanvonTimeZoneStartEndTime;
     Wednesday      : THanvonTimeZoneStartEndTime;
     Thursday       : THanvonTimeZoneStartEndTime;
     Friday         : THanvonTimeZoneStartEndTime;
     Saturday       : THanvonTimeZoneStartEndTime;
  end;

  THanvonBell   = record
    Status              : Boolean;
    BellNumber          : Integer;
    BellSound           : Integer;
    AlarTime            : TTime;
    BellTimeInterval    : Integer;
    BellWeek            : array of Integer;
  end;

  THanvonPerson   = record
    UserID        : Integer;
    Name          : string;
    Authority     : THanvonManagerType;
    CardNumber    : AnsiString;
    CalId         : Integer;
    CheckType     : THanvonCheckType;
    OpendoorType  : THanvonOpenDoorType;
    Password      : string;
    Photo         : WideString;
    FaceData      : TList<string>;
    constructor Create(AOwner: TComponent);

  end;

  THanvonRecord  = record
     DeviceId     : string;
     Time         : TDateTime;
     UserId       : Integer;
     Name         : string;
     WorkCode     : Integer; //bu alan dinamik
     WorkCodeName : String;
     Status       : integer; //Enable disable
     Authority    : String;
     CardSource   : THanvonCardSource;
  end;

  THanvonDeviceInfo  = record
    Time           : TDateTime;
    DeviceId       : string;
    Edition        : string;
    Volume         : Integer;
    Weigen         : Integer;
    Ip             : string; // 192168000032 aralarda virgül olmadan geliyor
    Gateway        : string; // 192168000032 aralarda virgül olmadan geliyor
    Netmask        : string; // 192168000032 aralarda virgül olmadan geliyor
    Mac            : string;
    MaxManagerCount: Integer; //max_managernum
    ManagerCount   : Integer; //managernum

    MaxFaceCount   : Integer; //max_faceregist
    FaceCount      : Integer;
    MaxFaceRecordCount : Integer;
    FaceRecordCount    : Integer;

    MaxPersonCount : Integer;
    PersonCount    : Integer;
    MaxOtherCount  : Integer;
    OtherCount     : Integer;
    DeviceType     : string;
    AlgEdition     : string;
  end;


  /////////////////////////////////////////////////////////////////
  type TCardOpPerson = record
    dept:Currency;
    receivable:Currency;
    DbTransferAmount : Currency;
    personNameSurName:string;
    personId : Integer;
  end;



  function HexToByte(HexStr: string): byte;

  Function EncodeDTSISDateTime(dt: TDateTime;
    out Buffer: array of byte): Integer;
  Function DecodeDTSISDateTime(Buffer: array of byte;
     out dt: TDateTime): Integer;

  Function DecodeDTSISDate(Buffer: array of byte;
     out dt: TDateTime): Integer;

  Function EncodeDTSISDate(dt: TDateTime;
     out Buffer: array of byte): Integer;

  function prBytesToDateTime(const AValue: array of byte; const AStartIndex : Integer = 0): TDateTime;
  function prBytesToDateTimeEx(const AValue: array of byte; const AStartIndex : Integer = 0): TDateTime;
  function prBytesToWord(const AValue: array of byte; const AStartIndex : Integer = 0): Word;
  function prBytesToLongWord(const AValue: array of byte; const AStartIndex : Integer = 0): LongWord;
  function prBytesToInt64(const AValue: array of byte; const AStartIndex: Integer = 0): Int64;
  function prBytesToBoolean(const AValue: array of byte; const AStartIndex : Integer = 0): Boolean;
  function prBytesToIPv4Str(const AValue: array of byte; const AStartIndex: Integer = 0): String;
  function prBytesToHex(const AValue: array of byte; const AStartIndex: Integer = 0;const ALength: Integer=1): String;

  function prByteToString(const strValue:array of byte;const AStartIndex: Integer;
        const ALength: Integer = -1):String;overload;
  function prByteToString(const strValue:array of byte):string;overload;
  function prHexStrToStr(const strValue:String):string;

  procedure ToPrBytes(const AValue: byte;Var Data :Array of byte;const AStartIndex : Integer = 0); overload;
  procedure ToPrBytes(const AValue: Word;Var Data :Array of byte;const AStartIndex : Integer = 0); overload;
  procedure ToPrBytes(const AValue: LongWord;Var Data :Array of byte;const AStartIndex : Integer = 0); overload;
  procedure ToPrBytes(const AValue: Int64;Var Data :Array of byte;const AStartIndex : Integer = 0); overload;
  procedure ToPrBytes(const AValue: Ansistring;Var Data :Array of byte;const AStartIndex : Integer = 0;Const ALength: Integer = 0); overload;
  procedure ToPrBytes(const AValue: Boolean;Var Data :Array of byte; const AStartIndex : Integer = 0); overload;

//  procedure ToPrBytes(const AValue: Word;Var Data :T16Byte;const AStartIndex : Integer = 0); overload;
//  procedure ToPrBytes(const AValue: LongWord;Var Data :T16Byte;const AStartIndex : Integer = 0); overload;
//  procedure ToPrBytes(const AValue: string;Var Data :T16Byte;const AStartIndex : Integer = 0;Const ALength: Integer = 0); overload;
//  procedure ToPrBytes(const AValue: Boolean;Var Data :T16Byte; const AStartIndex : Integer = 0); overload;

  procedure ToPrBytes(const AValue: TTime;Var Data :TDataByte; const AStartIndex : Integer = 0;Alength : Integer = 3); overload;
  procedure ToPrBytes(const AValue: TDate;Var Data :TDataByte; const AStartIndex : Integer = 0;Alength : Integer = 3); overload;
  procedure ToPrBytes(const AValue: TDate;Var Data :array of byte; const AStartIndex : Integer = 0;Alength : Integer = 3); overload;
  function ToPrBytesfromIPv4Str(const AValue: String;Var Data :TDataByte; const AStartIndex : Integer = 0):boolean ;overload;
  //function ToPrBytesFromHex(const AValue: string;Var Data :TDataByte;const AStartIndex : Integer = 0;Const ALength: Integer = 0):Boolean; overload;
  function ToPrBytesFromHex(const AValue: string;var Data :Array of byte;const AStartIndex : Integer = 0;Const ALength: Integer = 0):Boolean; overload;

  function GetHexLength(const AValue: string;const AStartIndex : Integer = 0;Const ALength: Integer = 0):Integer;

  function ToHex(const AValue: array of byte; const ACount: Integer = -1; const AIndex: Integer = 0): string; overload;

  function ToByte(const AValue: Boolean):Byte;
  function ByteFromBitArray(const AValue: array of byte):Byte;

  function GetBooleanValue(strBoolean : String): Boolean;
  function GetBooleanByte(bBoolean : Boolean): byte;

  procedure UnZipMeal(ZippedData :array of byte ;out Data : array of byte);
  procedure ZipMeal(Data :array of byte ;out ZippedData : array of byte);
  function GetAccessRestrictedZoneListFromStr(AcsStr : string;out ArrB :array of Boolean):Boolean;
  function LeftPad(S: string; Ch: Char; Len: Integer): string;
  function RightPad(S: string; Ch: Char; Len: Integer): string;


implementation


function prBytesToWord(const AValue: array of byte; const AStartIndex: Integer = 0): Word;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  //Assert(Length(AValue) >= (AStartIndex+SizeOf(Word)));
  Result := PWord(@AValue[AStartIndex])^;
end;

function prBytesToLongWord(const AValue: array of byte; const AStartIndex: Integer = 0): LongWord;
 {$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  //Assert(Length(AValue) >= (AStartIndex+SizeOf(LongWord)));
  Result := PLongWord(@AValue[AStartIndex])^;
end;

function prBytesToInt64(const AValue: array of byte; const AStartIndex: Integer = 0): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  //Assert(Length(AValue) >= (AStartIndex+SizeOf(Int64)));
  Result := PInt64(@AValue[AStartIndex])^;
end;

function prBytesToBoolean(const AValue: array of byte; const AStartIndex: Integer = 0): Boolean;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  //Assert(Length(AValue) >= (AStartIndex+SizeOf(Word)));
  Result := (AValue[AStartIndex] = 1);
end;

function prByteToString(const strValue:array of byte;const AStartIndex: Integer;
        const ALength: Integer = -1):String;
var
  len ,i: Integer;
  //LBytes : array of byte;
  ch:Char;
  str:String;
begin
  len := prLength(strValue, ALength, AStartIndex);
  //SetLength(LBytes,len);
  str := '';
  for i := 0 to Len-1 do
  Begin
    case strValue[i+AStartIndex] of
      208 : Str := Str + 'Ð';
      240 : Str := Str + 'ð';
      221 : Str := Str + 'Ý';
      253 : Str := Str + 'ý';
      220 : Str := Str + 'Ü';
      252 : Str := Str + 'ü';
      199 : Str := Str + 'Ç';
      231 : Str := Str + 'ç';
      222 : Str := Str + 'Þ';
      254 : Str := Str + 'þ';
      214 : Str := Str + 'Ö';
      246 : Str := Str + 'ö';
    else
      ch := chr(strValue[i+AStartIndex]);
      Str := Str + ch;
    end;
  End;
  Result := trim(str);
end;

function HexToByte(HexStr: string): byte;
const
  tablohex : array [0 .. 15] of char = '0123456789ABCDEF';
  tablobyte : array [0 .. 15] of byte = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
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
  Result := say;
end;

Function EncodeDTSISDateTime(dt: TDateTime;
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
end;

Function EncodeDTSISDate(dt: TDateTime;
  out Buffer: array of byte): Integer;
var
  DTTemp: TDate;
  uDay, uMonth, uYear: byte;
  ret: Integer;
begin
  try
    ret := 0;
    Buffer[0] := 0;
    Buffer[1] := 0;
    DTTemp := dt;
    if YearOf(DTTemp) < 2000 then
      uYear := 0
    else
      uYear := YearOf(DTTemp) - 2000;
    uDay := DayOf(DTTemp);
    uMonth := MonthOf(DTTemp);
    Buffer[0] := ((uDay shl 3) and $F8) + ( ((uMonth and $0F) shr 1) and $07 );
    Buffer[1] := ((uMonth shl 7) and $80) + (uYear and $7F);
  Except
    ret := -1;
  end;
  Result := ret;
end;

Function DecodeDTSISDate(Buffer: array of byte;
  out dt: TDateTime): Integer;
var
  uDay, uMonth, uYear: byte;
  ret: Integer;
begin
  try
    ret := 0;
    uDay := ( (Buffer[0] shr 3) and $1F);
    uMonth := ( ((Buffer[0] shl 1) and $0E) + ( (Buffer[1] shr 7) and $01 ) );
    uYear := (Buffer[1] and $7F);
    if not TryEncodeDate(uYear + 2000, uMonth, uDay, dt) then
    Begin
      dt := EncodeDate(2000, 1, 1);
      ret := -1;
    End;
  except
    ret := -2;
  end;
  Result := ret;
end;


function prBytesToDateTime(const AValue: array of byte; const AStartIndex : Integer = 0): TDateTime;
Var
  tmpDt:TDateTime;
  tmpBuff:array of byte;
  i:Integer;
Begin
  SetLength(tmpBuff,4);
  for I := 0 to 3 do
    tmpBuff[i] := AValue[AStartIndex+i];
  DecodeDTSISDateTime(tmpBuff,tmpDt);
  result := tmpDt;
End;

function prBytesToDateTimeEx(const AValue: array of byte; const AStartIndex : Integer = 0): TDateTime;
Var
  tmpDt:TDateTime;
  //i:Integer;
  AYear, AMonth, ADay, AHour, AMinute, ASecond : Word;
Begin
  AHour := AValue[AStartIndex];
  AMinute := AValue[AStartIndex+1];
  ASecond  := AValue[AStartIndex+2];
  ADay := AValue[AStartIndex+3];
  AMonth := AValue[AStartIndex+4];
  AYear := AValue[AStartIndex+5];
  if not TryEncodeDateTime(AYear+2000, AMonth, ADay, AHour, AMinute, ASecond,0, tmpDt) then
     tmpDt := EncodeDateTime(2000,1,1,0,0,0,0);
  result := tmpDt;
End;

Function DecodeDTSISDateTime(Buffer: array of byte;
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

function prByteToString(const strValue:array of byte):string;
begin
  Result := prByteToString(strValue, 0, -1);
end;

function prHexStrToStr(const strValue:String):string;
Var
  strArray : array of byte;
  Len : Integer;
Begin
  Len := Length(strValue) div 2;
  SetLength(strArray,Len);
  ToPrBytes(strValue,strArray);
  Result := prByteToString(strArray);
End;


function prBytesToIPv4Str(const AValue: array of byte; const AStartIndex: Integer = 0): String;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  //Assert(Length(AValue) >= (AStartIndex+4));
  Result := IntToStr(Ord(AValue[AStartIndex])) + '.' +
           IntToStr(Ord(AValue[AStartIndex+1])) + '.' +
           IntToStr(Ord(AValue[AStartIndex+2])) + '.' +
           IntToStr(Ord(AValue[AStartIndex+3]));
end;

function prBytesToHex(const AValue: array of byte; const AStartIndex: Integer = 0;const ALength: Integer=1): String;
{$IFDEF USE_INLINE}inline;{$ENDIF}
Var i:Integer;
Begin
  for I := 0 to ALength-1 do
    result := result + Format('%.2X',[AValue[AStartIndex+i]]);
End;

procedure ToPrBytes(const AValue: byte;Var Data :Array of byte;const AStartIndex : Integer = 0); overload;
Begin
  Data[AStartIndex] := AValue;
End;

procedure ToPrBytes(const AValue: Word;Var Data :Array of byte;const AStartIndex : Integer = 0); overload;
Begin
  PWord(@Data[AStartIndex])^ := AValue;
End;

procedure ToPrBytes(const AValue: LongWord;Var Data :Array of byte;const AStartIndex : Integer = 0); overload;
Begin
  PLongWord(@Data[AStartIndex])^ := AValue;
End;

procedure ToPrBytes(const AValue: Int64;Var Data :Array of byte;const AStartIndex : Integer = 0); overload;
Begin
  PInt64(@Data[AStartIndex])^ := AValue;
End;

function PerioOrd(S:AnsiChar):Byte;
Begin
  case S of
    'Ð' : Result := 208;
    'ð' : Result := 240;
    'Ý' : Result := 221;
    'ý' : Result := 253;
    'Ü' : Result := 220;
    'ü' : Result := 252;
    'Ç' : Result := 199;
    'ç' : Result := 231;
    'Þ' : Result := 222;
    'þ' : Result := 254;
    'Ö' : Result := 214;
    'ö' : Result := 246;
  else
    Result := ord(S);
  end;
End;

procedure ToPrBytes(const AValue: Ansistring;Var Data :Array of byte;
    const AStartIndex : Integer = 0;Const ALength: Integer = 0); overload;
Var
  BufLen ,strLen ,fark , i : Integer;
Begin
  if ALength<>0 then
    BufLen := ALength
  else
    BufLen := Length(AValue);
  strLen := Length(AValue);
  if strLen > BufLen then strLen := BufLen;

  fark := BufLen - strLen;

  for I := 1 to strLen  do
  Begin
    Data[AStartIndex + i - 1]:= PerioOrd(AValue[i])
  End;

  for I := 0 to fark-1 do
    Data[AStartIndex + i + strLen]:= 0;
End;

procedure ToPrBytes(const AValue: Boolean;Var Data :Array of byte; const AStartIndex : Integer = 0); overload;
Begin
  if AValue then
    Data[AStartIndex]:= 1
  else
    Data[AStartIndex]:= 0;
End;

//procedure ToPrBytes(const AValue: string;Var Data :T16Byte;
//    const AStartIndex : Integer = 0;Const ALength: Integer = 0); overload;
//Var
//  tmpData :TDataByte;
//  i : Integer;
//Begin
//  ToPrBytes(AValue,tmpData,AStartIndex,ALength);
//  for I := 0 to length(tmpData)-1 do
//    Data[i] := tmpData[i];
//End;

//procedure ToPrBytes(const AValue: Word;Var Data :T16Byte;const AStartIndex : Integer = 0); overload;
//Var
//  tmpData :TDataByte;
//  i : Integer;
//Begin
//  ToPrBytes(AValue,tmpData,AStartIndex);
//  for I := 0 to length(tmpData)-1 do
//    Data[i] := tmpData[i];
//End;
//
//procedure ToPrBytes(const AValue: LongWord;Var Data :T16Byte;const AStartIndex : Integer = 0); overload;
//Var
//  tmpData :TDataByte;
//  i : Integer;
//Begin
//  ToPrBytes(AValue,tmpData,AStartIndex);
//  for I := 0 to length(tmpData)-1 do
//    Data[i] := tmpData[i];
//End;
//
//procedure ToPrBytes(const AValue: Boolean;Var Data :T16Byte; const AStartIndex : Integer = 0); overload;
//Var
//  tmpData :TDataByte;
//  i : Integer;
//Begin
//  ToPrBytes(AValue,tmpData,AStartIndex);
//  for I := 0 to length(tmpData)-1 do
//    Data[i] := tmpData[i];
//End;

function ToByte(const AValue: Boolean):Byte;
Begin
  if AValue then
    Result := 1
  else
    Result := 0;
End;


function ByteFromBitArray(const AValue: array of byte):Byte;
Var
  BytVal,TempVal,ReadVal : byte ;
  i:Integer;
Begin
  BytVal := 0;
  for I := 0 to 7 do
  Begin
    ReadVal := AValue[i];
    if i=0 Then
      TempVal := ReadVal
    Else
    Begin
     TempVal := ReadVal shl i;
    End;
    BytVal := TempVal or BytVal;
  End;
  Result := BytVal;
End;

procedure ToPrBytes(const AValue: TTime;Var Data :TDataByte; const AStartIndex : Integer = 0;Alength : Integer = 3); overload;
Var
  Hour, Min, Sec, MSec: Word;
Begin
  DecodeTime(AValue, Hour, Min, Sec, MSec);
  if Alength = 3 then
  Begin
    Data[AStartIndex] := Hour;
    Data[AStartIndex+1] := Min;
    Data[AStartIndex+2] := Sec;
  End else
  Begin
    Data[AStartIndex] := Hour;
    Data[AStartIndex+1] := Min;
  End;
End;

function Occurrences(const Substring, Text: string): integer;
var
  offset: integer;
begin
  result := 0;
  offset := PosEx(Substring, Text, 1);
  while offset <> 0 do
  begin
    inc(result);
    offset := PosEx(Substring, Text, offset + length(Substring));
  end;
end;

function ToPrBytesfromIPv4Str(const AValue: String;Var Data :TDataByte; const AStartIndex : Integer = 0):boolean ;overload;
Var
  IPOk:Boolean;
  i,Start,Position:Integer;
begin
  IPOk := isIP(AValue);
  if IPOk then
  Begin
    Start := 1;
    for I := 0 to 3 do
    begin
      Position := PosEx('.',AValue,start);
      if Position <> 0 then
        Data[AStartIndex+i] := StrToInt(copy(AValue,Start,Position-Start))
      else
        Data[AStartIndex+i] := StrToInt(copy(AValue,Start,length(AValue)-Start+1));
      start := Position+1;
    end;
  End;
  Result := IPOk;
end;

//function ToPrBytesFromHex(const AValue: string;Var Data :TDataByte;const AStartIndex : Integer = 0;Const ALength: Integer = 0):Boolean; overload;
//Var
//  Len,HexLen,Md,i : Integer;
//Begin
//  if ALength = 0 then
//    Len := length(AValue)
//  else
//    Len := ALength;
//  Md := Len mod 2;
//  if Md = 0 then
//  Begin
//    if IsHex(AValue) then
//    Begin
//      HexLen := Len div 2;
//      for i := 0 to HexLen-1 do
//        Data[AStartIndex+i] := HexToByte(Copy(AValue,(i*2)+1,2));
//      Result := True;
//    End else
//      result := false;
//  End else
//    Result := False;
//End;

function ToPrBytesFromHex(const AValue: string;var Data :Array of byte;const AStartIndex : Integer = 0;Const ALength: Integer = 0):Boolean; overload;
Var
  Len,HexLen,Md,i : Integer;
Begin
  if ALength = 0 then
    Len := length(AValue)
  else
    Len := ALength;
  Md := Len mod 2;
  if Md = 0 then
  Begin
    if IsHex(AValue) then
    Begin
      HexLen := Len div 2;
      for i := 0 to HexLen-1 do
        Data[AStartIndex+i] := HexToByte(Copy(AValue,(i*2)+1,2));
      Result := True;
    End else
      result := false;
  End else
    Result := False;
End;

function GetHexLength(const AValue: string;const AStartIndex : Integer = 0;Const ALength: Integer = 0):Integer;
Var
  Len,HexLen,Md,i : Integer;
Begin
  if ALength = 0 then
    Len := length(AValue)
  else
    Len := ALength;
  result := Len div 2;
End;

procedure ToPrBytes(const AValue: TDate;Var Data :TDataByte; const AStartIndex : Integer = 0;Alength : Integer = 3); overload;
Var
  Year, Month, Day: Word;
Begin
  DecodeDate(AValue, Year, Month, Day);
  if Alength = 3 then
  Begin
    Data[AStartIndex] := Day;
    Data[AStartIndex+1] := Month;
    Data[AStartIndex+2] := Year-2000;
  End;;
End;

procedure ToPrBytes(const AValue: TDate;Var Data :array of byte; const AStartIndex : Integer = 0;Alength : Integer = 3); overload;
Var
  Year, Month, Day: Word;
Begin
  DecodeDate(AValue, Year, Month, Day);
  if Alength = 3 then
  Begin
    Data[AStartIndex] := Day;
    Data[AStartIndex+1] := Month;
    Data[AStartIndex+2] := Year-2000;
  End;;
End;


function ToHex(const AValue: array of byte; const ACount: Integer = -1;
  const AIndex: Integer = 0): string;
 {$IFDEF USE_INLINE}inline;{$ENDIF}
var
  I, LCount: Integer;
begin
  LCount := prLength(AValue, ACount, AIndex);
  if LCount > 0 then begin
    SetLength(Result, LCount*2);
    for I := 0 to LCount-1 do begin
      Result[I*2+1] := prHexDigits[(AValue[AIndex+I] and $F0) shr 4];
      Result[I*2+2] := prHexDigits[AValue[AIndex+I] and $F];
    end;
  end else begin
    Result := '';
  end;
end;

function GetBooleanValue(strBoolean : String): Boolean;
begin
  if strBoolean = 'T' then
    Result := True
  else if strBoolean = 'F' then
    Result := False
  else
  Begin
    Result := False;
  End;
end;

function GetBooleanByte(bBoolean : Boolean): byte;
Begin
  Result := 0;
  if bBoolean then
    Result := 1;
End;

procedure UnZipMeal(ZippedData :array of byte ;out Data : array of byte);
Var
  i : Integer;
Begin
  for I := 0 to 3 do
  Begin
    Data[i*2] := ZippedData[i] shr 4;
    Data[i*2+1] := ZippedData[i] and $0F;
  End;
End;

procedure ZipMeal(Data :array of byte ;out ZippedData : array of byte);
Var
  i : Integer;
Begin
  for I := 0 to 3 do
    ZippedData[i] := (Data[i*2] shl 4) +(Data[i*2+1] and $0F);
End;

function GetAccessRestrictedZoneListFromStr(AcsStr : string;out ArrB :array of Boolean):Boolean;
Var
  i : Integer;
Begin
  if Length(AcsStr) <> 128 then
    Result := False
  else
  Begin
    for I := 0 to 127 do
     ArrB[i] := (Copy(AcsStr,i+1,1)='1');
    Result := true;
  End;
End;

function LeftPad(S: string; Ch: Char; Len: Integer): string;
var
  RestLen: Integer;
begin
  Result  := S;
  RestLen := Len - Length(s);
  if RestLen < 1 then Exit;
  Result := S + StringOfChar(Ch, RestLen);
end;

function RightPad(S: string; Ch: Char; Len: Integer): string;
var
  RestLen: Integer;
begin
  Result  := S;
  RestLen := Len - Length(s);
  if RestLen < 1 then Exit;
  Result := StringOfChar(Ch, RestLen) + S;
end;

{ THanvonPerson }

constructor THanvonPerson.Create(AOwner: TComponent);
begin
  inherited;
  FaceData:=TList<string>.Create;
end;

end.
