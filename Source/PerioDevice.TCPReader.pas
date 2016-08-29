{ *************************************************************************
  * Perio TCP Reader Library ver. 1.01                                    *
  *   Reader Model  : ART26M,ART63M                                       *
  *   for Delphi 2010..XE5                                                *
  *                                                                       *
  *  http://www.perio.com.tr                                              *
  *                                                                       *
  *                                                                       *
  ************************************************************************* }
unit PerioDevice.TCPReader;
/// ////////////////////////////////////////////////////////////////////////
///
/// (+) Eklendi
/// (-) Silindi
/// (*) Bug, düzeltme veya Uyarý
/// (/) Deðiþiklik Yapýldý
///
/// ////////////////////////////////////////////////////////////////////////
/// (+) 2014_04_09 Ozan Güçlü
//        Yemekhane fw ile ilgili fonksiyonlar ve Recorlar eklendi.
///    GetYmkSettings,SetYmkSettings,GetMealTable,SetMealTable,SetYmkFactoryDefaults,
///    GetMealRigthTable,SetMealRigthTable,GetPriceListTable,SetPriceListTable
///
/// (*) 2014_02_05 Ozan Güçlü
///    Ýlk sürüm Bu dosyada Pdks,Eks,Hgs ile ilgili fonksiyonlar yer almaktadýr.
/// ////////////////////////////////////////////////////////////////////////
interface
uses
  Classes,
  SysUtils,
  DateUtils,
  Perio.Global,
  PerioDevice,
  PerioDevice.TCPReaderBase;

type
  TPerioTCPRdr = class(TCustomTcpRdr)
  private
    ffwAppType : TfwAppType;

  protected
    function tcpGetAppGeneralSettings(out rSettings :TAccessGeneralSettings) : Integer; // CMD 3.1
    function tcpSetAppGeneralSettings(rSettings :TAccessGeneralSettings) : Integer; // CMD 3.2
    function tcpGetAntiPassbackSettings(out rSettings :TAPBSettings ) : Integer; // CMD 3.3
    function tcpSetAntiPassbackSettings(rSettings :TAPBSettings ) : Integer; // CMD 3.4
    function tcpGetOutOfServiceSettings(out rSettings : TOutOfServiceSettings) : Integer; // CMD 3.5
    function tcpSetOutOfServiceSettings(rSettings : TOutOfServiceSettings) : Integer; // CMD 3.6
    function tcpGetOutOfServiceTable(out rTOSTable :TOSTable ) : Integer; // CMD 3.7
    function tcpSetOutOfServiceTable(rTOSTable :TOSTable ) : Integer; // CMD 3.8
    function tcpGetBellSettings(out rSettings : TBellSettings) : Integer; // CMD 3.9
    function tcpSetBellSettings(rSettings : TBellSettings) : Integer; // CMD 3.10
    function tcpGetBellTable(DayNo : Byte;out BellTable : TBellTable) : Integer; // CMD 3.11
    function tcpSetBellTable(DayNo : Byte;BellTable : TBellTable) : Integer; // CMD 3.12
    function tcpGetTimeConstraintTables(TableNo : Byte ;out TACList : TTACList) : Integer; // CMD 3.13
    function tcpSetTimeConstraintTables(TableNo : Byte ;TACList : TTACList) : Integer; // CMD 3.14
    function tcpGetEksOtherSettings(out EksOtherSettings:TEksOtherSettings) : Integer; // CMD 3.15
    function tcpSetEksOtherSettings( EksOtherSettings:TEksOtherSettings) : Integer; // CMD 3.16
    function tcpGetRegularInfo(out deviceDate:TDateTime;
        out headTail:Byte;out head:Cardinal;out tail:Cardinal;out Capacity:Cardinal;
        out DoorOpen :Boolean;out DoorOpenDT :TDateTime;out DeviceStatusMode : Byte) : Integer; // CMD 3.17
    function tcpAddWhitelist(rPerson : TPerson;out IndexNo : Integer) : Integer;overload; // CMD 3.18
    function tcpGetWhitelistWithCardID(CardID:String;out rPerson : TPerson;out IndexNo : Integer) : Integer; // CMD 3.19
    function tcpGetWhitelistWithPwd : Integer; // CMD 3.20
    function tcpEditWhitelistWithCardID (rPerson : TPerson;out IndexNo : Integer): Integer; // CMD 3.21
    function tcpEditWhitelistWithPwd : Integer; // CMD 3.22
    function tcpDeleteWhitelistWithCardID (CardID : String;out IndexNo : Integer): Integer; // CMD 3.23
    function tcpDeleteWhitelistWithPwd : Integer; // CMD 3.24
    function tcpGetWhitelistCardIDCount(out WhiteListCnt:LongWord) : Integer; // CMD 3.25
    function tcpGetWhitelistPwdCount : Integer; // CMD 3.26
    function tcpIsCardIDExistInWhitelist(CardID : String;out IndexNo : Integer) : Integer; // CMD 3.27
    function tcpIsPwdExistInWhitelist : Integer; // CMD 3.28
    function tcpReadRecords(StartFrom,HowMany:Cardinal;out Recs:TAccessRecords) : Integer; // CMD 3.29
    function tcpTransferRecords(Out Recs:TAccessRecords) : Integer; // CMD 3.30
    function tcpClearWhitelist : Integer; // CMD 3.32
    function tcpGetOutOfServiceHolidayList(out Holidays : THolidays) : Integer; // CMD 3.33
    function tcpSetOutOfServiceHolidayList(Holidays : THolidays) : Integer; // CMD 3.34
    // CMD 3.35 SendOnlineCardIDToServer için kullanýldý
    function tcpSetAppFactoryDefault(Reboot:Boolean):Integer; // CMD 3.36
    function tcpGetWhitelisStatus(out WhiteListStatus:TWhiteListStatus):Integer; // CMD 3.37
    function tcpSetWhitelisStatus(WhiteListStatus:TWhiteListStatus):Integer; // CMD 3.38
    function tcpGetHGSSettings(out HGS_Settings:THGS_Settings):Integer; // CMD 3.39
    function tcpSetHGSSettings(HGS_Settings:THGS_Settings):Integer; // CMD 3.40
    function tcpAddHGSWhitelist(rArac: THGSArac;out IndexNo : Integer) : Integer;overload; // CMD 3.41
    function tcpGetHGSWhitelistWithCardID(CardID:String;out rArac: THGSArac;out IndexNo : Integer) : Integer; // CMD 3.42
    function tcpEditHGSWhitelistWithCardID (rArac: THGSArac;out IndexNo : Integer): Integer; // CMD 3.43
    function tcpDeleteHGSWhitelistWithCardID (CardID : String;out IndexNo : Integer): Integer; // CMD 3.44
    function tcpIsHGSCardIDExistInWhitelist(CardID : String;out IndexNo : Integer) : Integer; // CMD 3.45
    function tcpGetHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte;out rArac: THGSArac;out IndexNo : Integer) : Integer; // CMD 3.46
    function tcpIsHGSCardIDDaireAracExistInWhitelist(CardID : String;DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Integer; // CMD 3.47
    function tcpDeleteHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Integer; // CMD 3.48
    function tcpIsHGSDaireAracExistInWhitelist(DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Integer; // CMD 3.49
    function tcpReadHGSRecords(StartFrom,HowMany:Cardinal;out Recs:THGSRecords) : Integer; // CMD 3.50
    function tcpTransferHGSRecords(Out Recs:THGSRecords) : Integer; // CMD 3.51
    function tcpGetHGSDaireParkHak(rDaire:word;out rHak:Byte) : Integer; // CMD 3.53
    function tcpSetHGSDaireParkHak(rDaire:word;rHak:Byte) : Integer; // CMD 3.54
    function tcpSetTumAralarDisarda : Integer; // CMD 3.60
    function tcpGetTreeNode(Address :Cardinal;out Node:Ttree_Node):Integer; // CMD 3.61
    function tcpSetTreeNode(Node:Ttree_Node):Integer; // CMD 3.62
    function tcpGetStatusMode(out StatusMode :Byte;out StatusModeType :Byte):Integer; // CMD 3.63
    function tcpSetStatusMode(StatusMode :Byte;StatusModeType :Byte ):Integer; // CMD 3.64
    function tcpGetPersonTZList(CardID : String;out PersTZList : TPersTZList) : Integer; // CMD 3.65
    function tcpSetPersonTZList(CardID : String;PersTZList : TPersTZList) : Integer; // CMD 3.66
    // CMD 3.67

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function tcpGetYmkSettings(out rSettings :TYmkSettings) : Integer; // CMD 4.1
    function tcpSetYmkSettings(rSettings :TYmkSettings) : Integer; // CMD 4.2
    function tcpGetMealTable(out rSettings :TMealTable) : Integer; // CMD 4.3
    function tcpSetMealTable(rSettings :TMealTable) : Integer; // CMD 4.4
    function tcpGetMealRigthTable(TableNo : Byte ;out rSettings :TWeaklyMealRight) : Integer; // CMD 4.5
    function tcpSetMealRigthTable(TableNo : Byte ;rSettings :TWeaklyMealRight) : Integer; // CMD 4.6
    function tcpGetPriceListTable(TableNo : Byte ;out rSettings :TPriceList) : Integer; // CMD 4.7
    function tcpSetPriceListTable(TableNo : Byte ;rSettings :TPriceList) : Integer; // CMD 4.8
    function tcpSetYmkFactoryDefaults(Reboot : Boolean):Integer; // CMD 4.11
    function tcpGetPersonYmkSettingList(ListNo : Byte ;out rSettings :TPersonMealSetting) : Integer; // CMD 4.12
    function tcpSetPersonYmkSettingList(ListNo : Byte ;rSettings :TPersonMealSetting) : Integer; // CMD 4.13
    function tcpGetStaticMealRightList(ListNo : Byte ;out rSettings :TDailyMealRight) : Integer; // CMD 4.14
    function tcpSetStaticMealRightList(ListNo : Byte ;rSettings :TDailyMealRight) : Integer; // CMD 4.15
    function tcpGetMonthlyMealRightList(CardID : String;DayNo : Byte ;out rSettings :TDailyMealRight) : Integer; // CMD 4.16
    function tcpSetMonthlyMealRightList(CardID : String;DayNo : Byte ;rSettings :TDailyMealRight) : Integer; // CMD 4.17
    function tcpGetMealNameList(out Names : TMealNameList) : Integer; // CMD 4.18
    function tcpSetMealNameList(Names : TMealNameList) : Integer; // CMD 4.19
    function tcpGetPersonCommands(CardID : String;out CommandList : TPersonCommandList) : Integer; // CMD 4.20
    function tcpSetPersonCommands(CardID : String;CommandList : TPersonCommandList) : Integer; // CMD 4.21
    function tcpDisablePersCommands(CardID : String) : Integer; // CMD 4.22
    // CMD 4.23

  public

    function GetAppGeneralSettings(out rSettings :TAccessGeneralSettings) : Boolean;
    function SetAppGeneralSettings(rSettings :TAccessGeneralSettings) : Boolean;
    function GetAntiPassbackSettings(out rSettings :TAPBSettings ) : Boolean;
    function SetAntiPassbackSettings(rSettings :TAPBSettings ) : Boolean;
    function GetOutOfServiceSettings(out rSettings : TOutOfServiceSettings) : Boolean;
    function SetOutOfServiceSettings(rSettings : TOutOfServiceSettings) : Boolean;
    function GetOutOfServiceTable(out rTOSTable :TOSTable ) : Boolean;
    function SetOutOfServiceTable(rTOSTable :TOSTable ) : Boolean;
    function GetBellSettings(out rSettings : TBellSettings) : Boolean;
    function SetBellSettings(rSettings : TBellSettings) : Boolean;
    function GetBellTable(DayNo : Byte;out BellTable : TBellTable) : Boolean;
    function SetBellTable(DayNo : Byte;BellTable : TBellTable) : Boolean;
    function GetTimeConstraintTables(TableNo : Byte ;out TACList : TTACList) : Boolean;
    function SetTimeConstraintTables(TableNo : Byte ;TACList : TTACList) : Boolean;
    function GetEksOtherSettings(out EksOtherSettings:TEksOtherSettings) : Boolean;
    function SetEksOtherSettings( EksOtherSettings:TEksOtherSettings) : Boolean;
    function GetRegularInfo(out deviceDate:TDateTime;
       out headTail:Byte;out head:Cardinal;out tail:Cardinal;out Capacity:Cardinal;
       out DoorOpen :Boolean;out DoorOpenDT :TDateTime;out DeviceStatusMode : Byte):Boolean;
    function AddWhitelist(rPerson : TPerson;IfExistEdit:Boolean=false) : Integer;overload;
    function AddWhitelist(rPerson : TPerson;out IndexNum : Integer;IfExistEdit:Boolean=false) : Integer;overload;
    function AddBlacklist(rBlackList : TBlackList;out IndexNum : Integer;IfExistEdit:Boolean=False) : Integer;

    function GetWhitelistWithCardID(CardID:String;out rPerson : TPerson) : Integer;overload;
    function GetWhitelistWithCardID(CardID:String;out rPerson : TPerson;out IndexNum : Integer) : Integer;overload;
    function GetBlacklistWithCardID(CardID:String;out rBlackList : TBlackList;out IndexNum : Integer) : Integer;
    function EditWhitelistWithCardID (rPerson : TPerson): Integer;overload;
    function EditWhitelistWithCardID (rPerson : TPerson;out IndexNum : Integer): Integer;overload;
    function EditBlacklistWithCardID (rBlackList : TBlackList;out IndexNum : Integer): Integer;
    function DeleteWhitelistWithCardID (CardID : String): Integer;overload;
    function DeleteWhitelistWithCardID (CardID : String;out IndexNum : Integer): Integer;overload;
    function DeleteBlacklistWithCardID (CardID : String;out IndexNum : Integer): Integer;
    function GetWhitelistCardIDCount : Integer;
    function IsCardIDExistInWhitelist(CardID : String) : Boolean;overload;
    function IsCardIDExistInWhitelist(CardID : String;out IndexNum : Integer) : Boolean;overload;
    function IsCardIDExistInWhitelistX(CardID : String) : Integer;overload;
    function IsCardIDExistInWhitelistX(CardID : String;out IndexNum : Integer) : Integer;overload;
    function ClearWhitelist : Boolean;
    function ReadRecords(StartFrom,HowMany:Cardinal;out Recs:TAccessRecords) : Boolean;
    function TransferRecords(Out Recs:TAccessRecords) : Boolean;
    function GetOutOfServiceHolidayList(out Holidays : THolidays) : Boolean;
    function SetOutOfServiceHolidayList(Holidays : THolidays) : Boolean;
    function SetAppFactoryDefault(Reboot:Boolean): Boolean;
    function GetWhitelisStatus(out WhiteListStatus:TWhiteListStatus):Boolean;
    function SetWhitelisStatus(WhiteListStatus:TWhiteListStatus):Boolean;
    function GetHGSSettings(out HGS_Settings:THGS_Settings):Boolean;
    function SetHGSSettings(HGS_Settings:THGS_Settings):Boolean;
    function AddHGSWhitelist(rArac: THGSArac;out IndexNum : Integer;IfExistEdit:Boolean=false) : Integer;overload;
    function AddHGSWhitelist(rArac: THGSArac;IfExistEdit:Boolean=false) : Integer;overload;
    function GetHGSWhitelistWithCardID(CardID:String;out rArac: THGSArac) : Integer;overload;
    function GetHGSWhitelistWithCardID(CardID:String;out rArac: THGSArac;out IndexNum : Integer) : Integer;overload;
    function EditHGSWhitelistWithCardID (rArac: THGSArac): Integer;overload;
    function EditHGSWhitelistWithCardID (rArac: THGSArac;out IndexNum : Integer): Integer;overload;
    function DeleteHGSWhitelistWithCardID (CardID : String): Integer;overload;
    function DeleteHGSWhitelistWithCardID (CardID : String;out IndexNum : Integer): Integer;overload;
    function IsCardIDExistHGSInWhitelist(CardID : String) : Boolean;overload;
    function IsCardIDExistHGSInWhitelist(CardID : String;out IndexNum : Integer) : Boolean;overload;
    function IsCardIDExistHGSInWhitelistX(CardID : String) : Integer;overload;
    function IsCardIDExistHGSInWhitelistX(CardID : String;out IndexNum : Integer) : Integer;overload;
    function GetHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte;out rArac: THGSArac) : Integer;overload;
    function GetHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte;out rArac: THGSArac;out IndexNum : Integer) : Integer;overload;
    function DeleteHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Integer;overload;
    function DeleteHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte) : Integer;overload;
    function IsHGSCardIDDaireAracExistInWhitelist(CardID : String; DaireNo : Word ;AracNo : Byte) : Boolean;overload;
    function IsHGSCardIDDaireAracExistInWhitelist(CardID : String; DaireNo : Word ;AracNo : Byte;out IndexNum : Integer) : Boolean;overload;
    function IsHGSCardIDDaireAracExistInWhitelistX(CardID : String; DaireNo : Word ;AracNo : Byte) : Integer;overload;
    function IsHGSCardIDDaireAracExistInWhitelistX(CardID : String; DaireNo : Word ;AracNo : Byte;out IndexNum : Integer) : Integer;overload;
    function IsHGSDaireAracExistInWhitelist(DaireNo : Word ;AracNo : Byte) : Boolean;overload;
    function IsHGSDaireAracExistInWhitelist(DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Boolean;overload;
    function IsHGSDaireAracExistInWhitelistX(DaireNo : Word ;AracNo : Byte) : Integer;overload;
    function IsHGSDaireAracExistInWhitelistX(DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Integer;overload;
    function ReadHGSRecords(StartFrom,HowMany:Cardinal;out Recs:THGSRecords) : Boolean;
    function TransferHGSRecords(Out Recs:THGSRecords) : Boolean;
    function GetHGSDaireParkHak(rDaire:word;out rHak:Byte) : Boolean;overload;
    function GetHGSDaireParkHak(rDaire:word) : Byte;overload;
    function SetHGSDaireParkHak(rDaire:word;rHak:Byte) : Boolean;
    function SetTumAralarDisarda : Boolean;
    function GetTagListToFile(aFileName : String;StartPage:Integer=1034;EndPage:Integer=1233):Boolean;
    function GetTreeNode(Address :Cardinal;out Node:Ttree_Node):Boolean;
    function SetTreeNode(Node:Ttree_Node):Boolean;
    function GetStatusMode(out StatusMode :Byte;out StatusModeType :Byte):Boolean;
    function SetStatusMode(StatusMode :Byte;StatusModeType: byte):Boolean;

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    function GetYmkSettings(out rSettings :TYmkSettings) : Boolean;
    function SetYmkSettings(rSettings :TYmkSettings) : Boolean;
    function GetMealTable(out rSettings :TMealTable) : Boolean;
    function SetMealTable(rSettings :TMealTable) : Boolean;
    function GetMealRigthTable(TableNo : Byte ;out rSettings :TWeaklyMealRight) : Boolean;
    function SetMealRigthTable(TableNo : Byte ;rSettings :TWeaklyMealRight) : Boolean;
    function GetPriceListTable(TableNo : Byte ;out rSettings :TPriceList) : Boolean;
    function SetPriceListTable(TableNo : Byte ;rSettings :TPriceList) : Boolean;
    function SetYmkFactoryDefaults(Reboot : Boolean):Boolean;
    function GetPersonYmkSettingList(ListNo : Byte ;out rSettings :TPersonMealSetting) : Boolean;
    function SetPersonYmkSettingList(ListNo : Byte ;rSettings :TPersonMealSetting) : Boolean;
    function GetStaticMealRightList(ListNo : Byte ;out rSettings :TDailyMealRight) : Boolean;
    function SetStaticMealRightList(ListNo : Byte ;rSettings :TDailyMealRight) : Boolean;
    function GetMonthlyMealRightList(CardID : String;DayNo : Byte ;out rSettings :TDailyMealRight) : Boolean;
    function SetMonthlyMealRightList(CardID : String;DayNo : Byte ;rSettings :TDailyMealRight) : Boolean;
    function GetMealNameList(out Names : TMealNameList) : Boolean;
    function SetMealNameList(Names : TMealNameList) : Boolean;
    function GetPersonCommands(CardID : String;out CommandList : TPersonCommandList) : Boolean;
    function SetPersonCommands(CardID : String;CommandList : TPersonCommandList) : Boolean;
    function DisablePersCommands(CardID : String) : Boolean;
    function GetPersonTZList(CardID : String;out PersTZList : TPersTZList) : Boolean;
    function SetPersonTZList(CardID : String;PersTZList : TPersTZList): Boolean;
  published
     property fwAppType : TfwAppType  read ffwAppType write ffwAppType;
  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  RegisterComponents('Perio Communication', [TPerioTCPRdr]);
//end;

function TPerioTCPRdr.tcpGetAppGeneralSettings(Out rSettings :TAccessGeneralSettings) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      1, // SubCmdNo
      1, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      begin
        rSettings.InputSettings.InputType := RecData[0];
        rSettings.InputSettings.InputDurationTimeout := prBytesToWord(RecData,1);
        rSettings.AccessMode.AccessType := RecData[3];
        rSettings.AccessMode.PasswordType := RecData[4];
        rSettings.TimeAccessConstraintEnabled := prBytesToBoolean(RecData,5);
        rSettings.PersonelTimeZoneMode := RecData[6];
      end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetAppGeneralSettings', 'Exception Error : ' + E.Message);
      //LogError('tcpGetAppGeneralSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetAppGeneralSettings(rSettings :TAccessGeneralSettings) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := rSettings.InputSettings.InputType;
    ToPrBytes(rSettings.InputSettings.InputDurationTimeout,SendData,1);
    SendData[3] := rSettings.AccessMode.AccessType;
    SendData[4] := rSettings.AccessMode.PasswordType;
    ToPrBytes(rSettings.TimeAccessConstraintEnabled,SendData,5);
    SendData[6] := rSettings.PersonelTimeZoneMode;
    iErr := ExecuteCmd(3, // CmdNo
      2, // SubCmdNo
      2, // Acknowledge
      7,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetAppGeneralSettings', 'Exception Error : ' + E.Message);
      //LogError('tcpSetAppGeneralSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetAntiPassbackSettings(out rSettings :TAPBSettings ) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      3, // SubCmdNo
      3, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    Begin
      rSettings.APBType := RecData[0];
      rSettings.SequentialTransitionTime := RecData[1];
      rSettings.SecurityZone := RecData[2];
      rSettings.ApbInOut := RecData[3];
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetAntiPassbackSettings', 'Exception Error : ' + E.Message);
      //LogError('tcpGetAntiPassbackSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetAntiPassbackSettings(rSettings :TAPBSettings ) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := rSettings.APBType;
    SendData[1] := rSettings.SequentialTransitionTime;
    SendData[2] := rSettings.SecurityZone;
    SendData[3] := rSettings.ApbInOut;
    iErr := ExecuteCmd(3, // CmdNo
      4, // SubCmdNo
      4, // Acknowledge
      4,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetAntiPassbackSettings', 'Exception Error : ' + E.Message);
      //LogError('tcpSetAntiPassbackSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetOutOfServiceSettings(out rSettings : TOutOfServiceSettings) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      5, // SubCmdNo
      5, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
      rSettings.Enabled := prBytesToBoolean(RecData,0);
      rSettings.ScreenText1 := prByteToString(RecData,1,16);
      rSettings.ScreenText2 := prByteToString(RecData,17,16);
      rSettings.OutType := RecData[33]
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetOutOfServiceSettings', 'Exception Error : ' + E.Message);
      //LogError('tcpGetOutOfServiceSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetOutOfServiceSettings(rSettings : TOutOfServiceSettings) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(rSettings.Enabled,SendData,0);
    ToPrBytes(rSettings.ScreenText1,SendData,1,16);
    ToPrBytes(rSettings.ScreenText2,SendData,17,16);
    SendData[33] := rSettings.OutType;
    iErr := ExecuteCmd(3, // CmdNo
      6, // SubCmdNo
      6, // Acknowledge
      34,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetOutOfServiceSettings', 'Exception Error : ' + E.Message);
      //LogError('tcpSetOutOfServiceSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetOutOfServiceTable(out rTOSTable :TOSTable ) : Integer;
Var
  iErr,i,j: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      7, // SubCmdNo
      7, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    Begin
      for I := 0 to 7 do
        for j := 0 to 3 do
        Begin
          rTOSTable.Day[i].part[j].StartTime
            := EncodeTime(RecData[i*16+j*4],RecData[i*16+j*4+1],0,0);
          rTOSTable.Day[i].part[j].EndTime
            := EncodeTime(RecData[i*16+j*4+2],RecData[i*16+j*4+3],0,0);
        End;
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetOutOfServiceTable', 'Exception Error : ' + E.Message);
      //LogError('tcpGetOutOfServiceTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetOutOfServiceTable(rTOSTable :TOSTable) : Integer;
Var
  iErr,i,j: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for I := 0 to 7 do
      for j := 0 to 3 do
        Begin
          SendData[i*16+j*4] := HourOf(rTOSTable.Day[i].part[j].StartTime);
          SendData[i*16+j*4+1] := MinuteOf(rTOSTable.Day[i].part[j].StartTime);
          SendData[i*16+j*4+2] := HourOf(rTOSTable.Day[i].part[j].EndTime);
          SendData[i*16+j*4+3] := MinuteOf(rTOSTable.Day[i].part[j].EndTime);
        End;
    iErr := ExecuteCmd(3, // CmdNo
      8, // SubCmdNo
      8, // Acknowledge
      128,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetOutOfServiceTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetBellSettings(out rSettings : TBellSettings) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      9, // SubCmdNo
      9, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
      rSettings.Enabled := prBytesToBoolean(RecData,0);
      rSettings.ScreenText1 := prByteToString(RecData,1,16);
      rSettings.ScreenText2 := prByteToString(RecData,17,16);
      rSettings.OutType := RecData[33]
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetBellSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetBellSettings(rSettings : TBellSettings) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(rSettings.Enabled,SendData,0);
    ToPrBytes(rSettings.ScreenText1,SendData,1,16);
    ToPrBytes(rSettings.ScreenText2,SendData,17,16);
    SendData[33] := rSettings.OutType;
    iErr := ExecuteCmd(3, // CmdNo
      10, // SubCmdNo
      10, // Acknowledge
      34,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetBellSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetBellTable(DayNo : Byte;out BellTable : TBellTable) : Integer;
Var
  iErr , i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := DayNo;
    iErr := ExecuteCmd(3, // CmdNo
      11, // SubCmdNo
      11, // Acknowledge
      1,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    Begin
      for I := 0 to 23 do
      Begin
        BellTable.List[i].StartTime := EncodeTime(RecData[i*3],RecData[i*3+1],0,0);
        BellTable.List[i].Duration := RecData[i*3+2];
      End;
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetBellTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetBellTable(DayNo : Byte;BellTable : TBellTable) : Integer;
Var
  iErr , i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := DayNo;
    for I := 0 to 23 do
    Begin
      SendData[i*3+1] := HourOf(BellTable.List[i].StartTime);
      SendData[i*3+2] := MinuteOf(BellTable.List[i].StartTime);
      SendData[i*3+3] := BellTable.List[i].Duration;
    End;
    iErr := ExecuteCmd(3, // CmdNo
      12, // SubCmdNo
      12, // Acknowledge
      73,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetBellTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetTimeConstraintTables(TableNo : Byte ;out TACList : TTACList) : Integer;
Var
  iErr , Day,j: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for Day := 0 to 7 do
    Begin
      SendData[0] := TableNo;
      SendData[1] := Day;
      iErr := ExecuteCmd(3, // CmdNo
        13, // SubCmdNo
        13, // Acknowledge
        2,  // DataLen
        SendData, RecData // SelectTimeOut
        );
      if iErr = 0 then
      Begin
        for j := 0 to 7 do
        Begin
          TACList.Day[Day].Part[j].StartTime
            := EncodeTime(RecData[j*4],RecData[j*4+1],0,0);
          TACList.Day[Day].Part[j].EndTime
            := EncodeTime(RecData[j*4+2],RecData[j*4+3],0,0);
        End;      
      End
      else
        Break ;      
    End;
 except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetTimeConstaintTables', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetTimeConstraintTables(TableNo : Byte ;TACList : TTACList) : Integer;
Var
  iErr , Day,j: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for Day := 0 to 7 do
    begin
      SendData[0] := TableNo;
      SendData[1] := Day;
      for j := 0 to 7 do
      Begin
        SendData[j*4+2] := HourOf(TACList.Day[Day].Part[j].StartTime);
        SendData[j*4+3] := MinuteOf(TACList.Day[Day].Part[j].StartTime);
        SendData[j*4+4] := HourOf(TACList.Day[Day].Part[j].EndTime);
        SendData[j*4+5] := MinuteOf(TACList.Day[Day].Part[j].EndTime);
      End;
      iErr := ExecuteCmd(3, // CmdNo
      14, // SubCmdNo
      14, // Acknowledge
      34,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr <> 0 then Break;          
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetTimeConstraintTables', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetEksOtherSettings(out EksOtherSettings:TEksOtherSettings) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      15, // SubCmdNo
      15, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    Begin
      EksOtherSettings.PersDataCardSector := RecData[0];
      EksOtherSettings.AccessDataCardSector := RecData[1];
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetEksSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetEksOtherSettings(EksOtherSettings:TEksOtherSettings) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := EksOtherSettings.PersDataCardSector;
    SendData[1] := EksOtherSettings.AccessDataCardSector;
    iErr := ExecuteCmd(3, // CmdNo
      16, // SubCmdNo
      16, // Acknowledge
      2,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetEksSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetRegularInfo(out deviceDate:TDateTime;
        out headTail:Byte;out head:Cardinal;out tail:Cardinal;out Capacity:Cardinal;
        out DoorOpen :Boolean;out DoorOpenDT :TDateTime;out DeviceStatusMode : Byte) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      17, // SubCmdNo
      17, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    begin
      if not TryEncodeDateTime(RecData[5]+2000,RecData[4],
                    RecData[3],RecData[0],RecData[1],
                    RecData[2],0,deviceDate) Then
      Begin
        deviceDate := EncodeDateTime(2000,1,1,0,0,0,0)
      End;
//      deviceDate := EncodeDateTime(RecData[5]+2000,RecData[4],
//                    RecData[3],RecData[0],RecData[1],
//                    RecData[2],0);
      headTail   := RecData[6];
      head       := RecData[7] +
                   (RecData[8]*256) +
                   (RecData[9]*256*256);
      tail       := RecData[10] +
                   (RecData[11]*256) +
                   (RecData[12]*256*256);
      Capacity   := RecData[13] +
                   (RecData[14]*256) +
                   (RecData[15]*256*256);
      DoorOpen := (RecData[16]=1);
      if not TryEncodeDateTime(RecData[17]+2000,RecData[18],
                    RecData[19],RecData[20],RecData[21],
                    RecData[22],0,DoorOpenDT) Then
      Begin
        DoorOpenDT := EncodeDateTime(2000,1,1,0,0,0,0)
      End;
      DeviceStatusMode := RecData[23];
    end;

  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetRegularInfo', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpAddWhitelist(rPerson : TPerson; out IndexNo:Integer) : Integer;
Var
  iErr,i  : Integer;
  OldCmdRetry:Integer;
  SendData, RecData: TDataByte;
  DTByte : array [0..1] of byte;
Begin
  try
    OldCmdretry := CommandRetry;
    CommandRetry := 1;
    try
      ToPrBytesFromHex(rPerson.CardID,SendData,0);
      ToPrBytes(rPerson.Name,SendData,7,18);
      SendData[25] := rPerson.TimeZoneListNo;
      ToPrBytes(rPerson.Code,SendData,26);
      ToPrBytes(rPerson.Password,SendData,30);
      ToPrBytes(rPerson.EndDate,SendData,32);
      ToPrBytes(rPerson.AccessDevice,SendData,35);
      ToPrBytes(rPerson.APBEnabled,SendData,36);
      ToPrBytes(rPerson.TZEnabled,SendData,37);
      ToPrBytes(rPerson.AccessCardEnabled,SendData,38);
      ToPrBytes(rPerson.isOnlineCard,SendData,39);
      ToPrBytes(rPerson.PermitedInEmergency,SendData,40);
      ToPrBytes(rPerson.BirthDate,SendData,41);

      ToPrBytes(rPerson.WeeklyTotalMealCount ,SendData,44);
      ToPrBytes(rPerson.MonthlyTotalMealCount ,SendData,45);
      ToPrBytes(rPerson.MealSettingListNo ,SendData,46);
      ToPrBytes(rPerson.BlackListCmdNo,SendData,47);
      ToPrBytes(rPerson.NeedCmdControl,SendData,48);
      for I := 49 to 51 do
        SendData[i] := 0;
      iErr := ExecuteCmd(3, // CmdNo
        18, // SubCmdNo
        18, // Acknowledge
        52,  // DataLen
        SendData, RecData // SelectTimeOut
        ,3000,1);
        if iErr = 0 then
        Begin
            IndexNo := prBytesToLongWord(RecData,0);
        End;
    except
      on E: Exception do
      begin
        DoLog(lgError,'tcpAddWhitelist', 'Exception Error : ' + E.Message);
        iErr := TErrors.EXCEPTION;
      end;
    end; // try
  finally
    CommandRetry := OldCmdretry;
  end;
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetWhitelistWithCardID (CardID:String;out rPerson : TPerson;out IndexNo : Integer): Integer;
Var
  iErr ,i: Integer;
  SendData, RecData: TDataByte;
  tmpDt : TDateTime;
Begin
  try
    ToPrBytesFromHex(CardID,SendData,0);
    iErr := ExecuteCmd(3, // CmdNo
      19, // SubCmdNo
      19, // Acknowledge
      7,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        rPerson.CardID := prBytesToHex(RecData,0,7);
        rPerson.Name := trim(prByteToString(RecData,7,18));        
        rPerson.TimeZoneListNo := RecData[25];
        rPerson.Code := prBytesToLongWord(RecData,26);
        rPerson.Password := prBytesToWord(RecData,30);
        TryEncodeDate(RecData[34]+2000,RecData[33],RecData[32],tmpDt);
        rPerson.EndDate := tmpDt;
        rPerson.AccessDevice := prBytesToBoolean(RecData,35);
        rPerson.APBEnabled := prBytesToBoolean(RecData,36);
        rPerson.TZEnabled := prBytesToBoolean(RecData,37);
        rPerson.AccessCardEnabled := prBytesToBoolean(RecData,38);
        rPerson.isOnlineCard := prBytesToBoolean(RecData,39);
        rPerson.PermitedInEmergency := prBytesToBoolean(RecData,40);
        TryEncodeDate(RecData[43]+2000,RecData[42],RecData[41],tmpDt);
        rPerson.BirthDate := tmpDt;
        rPerson.WeeklyTotalMealCount := RecData[44];
        rPerson.MonthlyTotalMealCount := RecData[45];
        rPerson.MealSettingListNo := RecData[46];
        rPerson.BlackListCmdNo := RecData[47];
        rPerson.NeedCmdControl := RecData[48];
        IndexNo := prBytesToWord(RecData,52);
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetWhitelistWithCardID', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetWhitelistWithPwd : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      20, // SubCmdNo
      20, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetWhitelistWithPwd', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpEditWhitelistWithCardID (rPerson : TPerson;out IndexNo : Integer): Integer;
Var
  iErr,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(rPerson.CardID,SendData,0);
    ToPrBytes(rPerson.Name,SendData,7,18);
    SendData[25] := rPerson.TimeZoneListNo;
    ToPrBytes(rPerson.Code,SendData,26);
    ToPrBytes(rPerson.Password,SendData,30);
    ToPrBytes(rPerson.EndDate,SendData,32);
    ToPrBytes(rPerson.AccessDevice,SendData,35);
    ToPrBytes(rPerson.APBEnabled,SendData,36);
    ToPrBytes(rPerson.TZEnabled,SendData,37);
    ToPrBytes(rPerson.AccessCardEnabled,SendData,38);
    ToPrBytes(rPerson.isOnlineCard,SendData,39);
    ToPrBytes(rPerson.PermitedInEmergency,SendData,40);
    ToPrBytes(rPerson.BirthDate,SendData,41);

    ToPrBytes(rPerson.WeeklyTotalMealCount ,SendData,44);
    ToPrBytes(rPerson.MonthlyTotalMealCount ,SendData,45);
    ToPrBytes(rPerson.MealSettingListNo ,SendData,46);
    ToPrBytes(rPerson.BlackListCmdNo,SendData,47);
    ToPrBytes(rPerson.NeedCmdControl,SendData,48);
    for I := 49 to 51 do
      SendData[i] := 0;

    iErr := ExecuteCmd(3, // CmdNo
      21, // SubCmdNo
      21, // Acknowledge
      52,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
          IndexNo := prBytesToWord(RecData,0);
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpEditWhitelistWithCardID', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpEditWhitelistWithPwd : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      22, // SubCmdNo
      22, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpEditWhitelistWithPwd', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpDeleteWhitelistWithCardID(CardID : String;out IndexNo : Integer) : Integer;
Var
  iErr: Integer;
  OldCmdRetry:Integer;
  SendData, RecData: TDataByte;
Begin
  try
    OldCmdretry := CommandRetry;
    CommandRetry := 1;
    try
      ToPrBytesFromHex(CardID,SendData,0);
      iErr := ExecuteCmd(3, // CmdNo
        23, // SubCmdNo
        23, // Acknowledge
        7,  // DataLen
        SendData, RecData // SelectTimeOut
        ,3000,1);
        if iErr = 0 then
        Begin
            IndexNo := prBytesToWord(RecData,0);
        End;
    except
      on E: Exception do
      begin
        DoLog(lgError,'tcpDeleteWhitelistWithCardID', 'Exception Error : ' + E.Message);
        iErr := TErrors.EXCEPTION;
      end;
    end; // try
  finally
    CommandRetry := OldCmdretry;
  end;
  Result := iErr;
End;

function TPerioTCPRdr.tcpDeleteWhitelistWithPwd : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      24, // SubCmdNo
      24, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpDeleteWhitelistWithPwd', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetWhitelistCardIDCount(out WhiteListCnt:LongWord) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      25, // SubCmdNo
      25, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
        WhiteListCnt := prBytesToLongWord(RecData,0);
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetWhitelistCardIDCount', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetWhitelistPwdCount : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      26, // SubCmdNo
      26, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetWhitelistPwdCount', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpIsCardIDExistInWhitelist(CardID : String;out IndexNo : Integer) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(CardID,SendData,0);
    iErr := ExecuteCmd(3, // CmdNo
      27, // SubCmdNo
      27, // Acknowledge
      7,  // DataLen
      SendData, RecData // SelectTimeOut
      ,2000,3
      );
      if iErr = 0 then
      Begin
          IndexNo := prBytesToWord(RecData,0);
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpIsCardIDExistInWhitelist', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpIsPwdExistInWhitelist : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      28, // SubCmdNo
      28, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpIsPwdExistInWhitelist', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpReadRecords(StartFrom,HowMany:Cardinal;out Recs:TAccessRecords) : Integer;
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
  TransferredCount ,RecordSize ,ReceivedCount,
  TempCountPerTime,TempStartFrom : Integer;
  tempRecs     : TAccessRecords;
  CardId:String;
Begin
  try
    RecordSize := 17;
    TransferredCount := 0;
    TempStartFrom := StartFrom;
    tempRecs.Count:= 0;
    SetLength(tempRecs.raDeviceRecs,0);

    repeat
      if ((HowMany - TransferredCount) >= 12 ) then
        TempCountPerTime:= 12
      else TempCountPerTime:= HowMany - TransferredCount;

      SendData[0] :=  TempStartFrom         and $FF;
      SendData[1] := (TempStartFrom shr 8)  and $FF;
      SendData[2] := (TempStartFrom shr 16) and $FF;
      SendData[3] := TempCountPerTime;
      iErr := ExecuteCmd(3, // CmdNo
        29, // SubCmdNo
        29, // Acknowledge
        4,  // DataLen
        SendData, RecData // SelectTimeOut
        );
      if iErr = 0 then
      Begin
        ReceivedCount := RecData[0];
        tempRecs.Count := tempRecs.Count + ReceivedCount;
        SetLength(tempRecs.raDeviceRecs,tempRecs.Count);
        for i := 0 to ReceivedCount - 1 do
        begin
          CardId := '';
          CardId := prBytesToHex(RecData,(RecordSize * i)+1,7);
          tempRecs.raDeviceRecs[i+TransferredCount].CardID := CardId;
          tempRecs.raDeviceRecs[i+TransferredCount].DoorNo     := RecData[(RecordSize*i)+8];
          tempRecs.raDeviceRecs[i+TransferredCount].RecordType := RecData[(RecordSize*i)+9];
          tempRecs.raDeviceRecs[i+TransferredCount].TimeDate :=
          prBytesToDateTimeEx(RecData,(RecordSize * i) + 10);
          tempRecs.raDeviceRecs[i+TransferredCount].RFU[0]     := RecData[(RecordSize*i)+16];
          tempRecs.raDeviceRecs[i+TransferredCount].RFU[1]     := RecData[(RecordSize*i)+17];
        end;
        TransferredCount:= TransferredCount + ReceivedCount;
        TempStartFrom:= TempStartFrom + ReceivedCount;
      End;
    until (TransferredCount = HowMany) or (iErr <> 0);
    if iErr=0 Then Recs := tempRecs;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpReadRecords', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpTransferRecords(Out Recs:TAccessRecords) : Integer;
  function ConfirmRecs(uTransferredCount: byte): integer;
  Var
    iErr: Integer;
    SendData, RecData: TDataByte;
  begin
    try
      SendData[0] := uTransferredCount;
      iErr := ExecuteCmd(3, // CmdNo
        31, // SubCmdNo
        31, // Acknowledge
        1,  // DataLen
        SendData, RecData // SelectTimeOut
        );
    except
      on E: Exception do
      begin
        DoLog(lgError,'ConfirmRecs', 'Exception Error : ' + E.Message);
        iErr := TErrors.EXCEPTION;
      end;
    end; // try
    Result := iErr;
  end;
Var
  iErr ,i: Integer;
  SendData, RecData: TDataByte;
  CountToTransfer,TransferredCount ,RecordSize ,ReceivedCount,
  CountPerTime,TempCountPerTime,StartFrom : Integer;
  tempRecs ,notConfRecs : TAccessRecords;
  Head,Tail,Capacity:Cardinal;
  CardId : String;
Begin
  try
    RecordSize := 17;
    TransferredCount := 0;
    tempRecs.Count:= 0;
    SetLength(tempRecs.raDeviceRecs,0);
    notConfRecs.Count := 0;
    SetLength(notConfRecs.raDeviceRecs,0);

    iErr := tcpGetHeadTailCapacity(Head,Tail,Capacity);
    if iErr = 0 then
    begin
      if Head > Tail then
        CountToTransfer := Head - Tail
      else
        CountToTransfer := Capacity - Tail + Head;
      CountPerTime := 12;
      StartFrom := Tail;

      repeat
        sleep(1);
        if ((CountToTransfer - tempRecs.Count) >= CountPerTime) then
          TempCountPerTime:= CountPerTime
        else
          TempCountPerTime:= CountToTransfer - tempRecs.Count;

        SendData[0] := TempCountPerTime;
        iErr := ExecuteCmd(3, // CmdNo
          30, // SubCmdNo
          30, // Acknowledge
          1,  // DataLen
          SendData, RecData // SelectTimeOut
          );

        if iErr = 0 then
        begin
          notConfRecs.Count:= RecData[0];
          SetLength(notConfRecs.raDeviceRecs,notConfRecs.Count);
          for i:= 0 to notConfRecs.Count - 1 do
          begin
            // Card ID
            CardId := '';
            CardId := prBytesToHex(RecData,(RecordSize * i)+1,7);
            notConfRecs.raDeviceRecs[i+TransferredCount].CardID := CardId;
            notConfRecs.raDeviceRecs[i+TransferredCount].DoorNo := RecData[(RecordSize*i)+8];
            notConfRecs.raDeviceRecs[i+TransferredCount].RecordType := RecData[(RecordSize*i)+9];
            notConfRecs.raDeviceRecs[i+TransferredCount].TimeDate
                 := prBytesToDateTimeEx(RecData,(RecordSize * i) + 10);

            notConfRecs.raDeviceRecs[i+TransferredCount].RFU[0] := RecData[(RecordSize*i)+16];
            notConfRecs.raDeviceRecs[i+TransferredCount].RFU[1] := RecData[(RecordSize*i)+17];
          end;
          iErr:= ConfirmRecs(notConfRecs.Count);
          if iErr = 0 then
          begin
            SetLength(TempRecs.raDeviceRecs,TempRecs.Count + notConfRecs.Count);
            for I := TempRecs.Count to (TempRecs.Count + notConfRecs.Count)-1 do
              TempRecs.raDeviceRecs[i]:= notConfRecs.raDeviceRecs[cardinal(i)-TempRecs.Count];
            TempRecs.Count:= TempRecs.Count + notConfRecs.Count;
          end;
        end;
      until (CountToTransfer <= tempRecs.Count) or (iErr <> 0);
    end;
    if iErr=0 Then  recs := tempRecs;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpTransferRecords', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpClearWhitelist : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      32, // SubCmdNo
      32, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpClearWhitelist', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetOutOfServiceHolidayList(out Holidays : THolidays) : Integer;
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      33, // SubCmdNo
      33, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
    if iErr = 0 then
    Begin
      for I := 0 to 29 do
      Begin
        Holidays.List[i].Date := EncodeDate(RecData[i*3+2]+2000,RecData[i*3+1],RecData[i*3]);
      End;
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetOutOfServiceHolidayList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetOutOfServiceHolidayList(Holidays : THolidays) : Integer;
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for I := 0 to 29 do
    Begin
      SendData[i*3] := DayOf(Holidays.List[i].Date);
      SendData[i*3+1] := MonthOf(Holidays.List[i].Date);
      SendData[i*3+2] := YearOf(Holidays.List[i].Date)-2000;
    End;
    iErr := ExecuteCmd(3, // CmdNo
      34, // SubCmdNo
      34, // Acknowledge
      90,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetOutOfServiceHolidayList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetAppFactoryDefault(Reboot:Boolean):Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    if Reboot then
      SendData[0] := 1
    else
      SendData[0] := 0;
    iErr := ExecuteCmd(3, // CmdNo
      36, // SubCmdNo
      36, // Acknowledge
      1, // DataLen
      SendData, RecData // SelectTimeOut
      ,1000,1);
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetAppFactoryDefault', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TPerioTCPRdr.tcpGetTreeNode(Address :Cardinal;out Node:Ttree_Node):Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(Address,SendData,0);
    iErr := ExecuteCmd(3, // CmdNo
      61, // SubCmdNo
      61, // Acknowledge
      4, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if (iErr = 0) then
    begin
      Node.Adress := prBytesToLongWord(RecData,0);
      for I := 0 to 6 do
        Node.Value[i] := RecData[i+4];
      Node.Color := RecData[11];
      Node.Left := prBytesToLongWord(RecData,12);
      Node.Right := prBytesToLongWord(RecData,16);
      Node.Parent := prBytesToLongWord(RecData,20);
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetTreeNode', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetTreeNode(Node:Ttree_Node):Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(Node.Adress,SendData,0);
    for I := 0 to 6 do
       SendData[i+4] := Node.Value[i];
    SendData[11] := Node.Color;
    ToPrBytes(Node.Left,SendData,12);
    ToPrBytes(Node.Right,SendData,16);
    ToPrBytes(Node.Parent,SendData,20);
    iErr := ExecuteCmd(3, // CmdNo
      62, // SubCmdNo
      62, // Acknowledge
      24, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetTreeNode', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetStatusMode(out StatusMode :Byte;out StatusModeType :Byte):Integer; // CMD 3.63
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      63, // SubCmdNo
      63, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if (iErr = 0) then
    begin
      StatusMode := RecData[0];
      StatusModeType := RecData[1];
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetStatusMode', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetStatusMode(StatusMode :Byte;StatusModeType:byte):Integer; // CMD 3.64
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := StatusMode;
    SendData[1] := StatusModeType;
    iErr := ExecuteCmd(3, // CmdNo
      64, // SubCmdNo
      64, // Acknowledge
      2, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetStatusMode', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetWhitelisStatus(out WhiteListStatus:TWhiteListStatus):Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      37, // SubCmdNo
      37, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if (iErr = 0) then
    begin
      WhiteListStatus.PersCnt := prBytesToLongWord(RecData,0);
      WhiteListStatus.rb_ins_tree_root := prBytesToLongWord(RecData,4);
      WhiteListStatus.rb_Del_tree_root := prBytesToLongWord(RecData,8);
      WhiteListStatus.InsNode.Adress := prBytesToLongWord(RecData,12);
      for I := 0 to 6 do
        WhiteListStatus.InsNode.Value[i] := RecData[i+16];
      WhiteListStatus.InsNode.Color := RecData[23];
      WhiteListStatus.InsNode.Left := prBytesToLongWord(RecData,24);
      WhiteListStatus.InsNode.Right := prBytesToLongWord(RecData,28);
      WhiteListStatus.InsNode.Parent := prBytesToLongWord(RecData,32);

      WhiteListStatus.DelNode.Adress := prBytesToLongWord(RecData,36);
      for I := 0 to 6 do
        WhiteListStatus.DelNode.Value[i] := RecData[i+40];
      WhiteListStatus.DelNode.Color := RecData[47];
      WhiteListStatus.DelNode.Left := prBytesToLongWord(RecData,48);
      WhiteListStatus.DelNode.Right := prBytesToLongWord(RecData,52);
      WhiteListStatus.DelNode.Parent := prBytesToLongWord(RecData,56);

    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetWhitelisStatus', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TPerioTCPRdr.tcpSetWhitelisStatus(WhiteListStatus:TWhiteListStatus):Integer;
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(WhiteListStatus.PersCnt,SendData,0);
    ToPrBytes(WhiteListStatus.rb_ins_tree_root,SendData,4);
    ToPrBytes(WhiteListStatus.rb_Del_tree_root,SendData,8);
    ToPrBytes(WhiteListStatus.InsNode.Adress,SendData,12);

    for I := 0 to 6 do
       SendData[i+16] := WhiteListStatus.InsNode.Value[i];

    SendData[23] := WhiteListStatus.InsNode.Color;

    ToPrBytes(WhiteListStatus.InsNode.Left,SendData,24);
    ToPrBytes(WhiteListStatus.InsNode.Right,SendData,28);
    ToPrBytes(WhiteListStatus.InsNode.Parent,SendData,32);

    ToPrBytes(WhiteListStatus.DelNode.Adress,SendData,36);
    for I := 0 to 6 do
       SendData[i+40] := WhiteListStatus.DelNode.Value[i];

    SendData[47] := WhiteListStatus.DelNode.Color;

    ToPrBytes(WhiteListStatus.DelNode.Left,SendData,48);
    ToPrBytes(WhiteListStatus.DelNode.Right,SendData,52);
    ToPrBytes(WhiteListStatus.DelNode.Parent,SendData,56);

    iErr := ExecuteCmd(3, // CmdNo
      38, // SubCmdNo
      38, // Acknowledge
      60, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetWhitelisStatus', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TPerioTCPRdr.tcpGetHGSSettings(out HGS_Settings:THGS_Settings):Integer; // CMD 3.39
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      39, // SubCmdNo
      39, // Acknowledge
      0, // DataLen
      SendData, RecData // SelectTimeOut
      );
    if (iErr = 0) then
    begin
      HGS_Settings.PaketBoyu        := RecData[0];
      HGS_Settings.CardBaslangic    := RecData[1];
      HGS_Settings.CardBoyu         := RecData[2];
      HGS_Settings.TrCikisSure1     := RecData[3];
      HGS_Settings.TrCikisSure2     := RecData[4];
      HGS_Settings.ProgramMode      := RecData[5];
      HGS_Settings.DiziEklemeSure1  := RecData[6];
      HGS_Settings.DiziEklemeSure2  := RecData[7];
      HGS_Settings.ZamanKisitEnb    := prBytesToBoolean(RecData[8]);
      HGS_Settings.AntenPower1      := RecData[9];
      HGS_Settings.AntenPower2      := RecData[10];
      HGS_Settings.AntenTanitim     := RecData[11];
      HGS_Settings.DefMaksimumArac  := RecData[12];
      HGS_Settings.DefAntiPassPack  := RecData[13];
      HGS_Settings.AppType          := RecData[14];
    end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetHGSSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetHGSSettings(HGS_Settings:THGS_Settings):Integer; // CMD 3.40
Var
  iErr,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := HGS_Settings.PaketBoyu ;
    SendData[1] := HGS_Settings.CardBaslangic;
    SendData[2] := HGS_Settings.CardBoyu;
    SendData[3] := HGS_Settings.TrCikisSure1;
    SendData[4] := HGS_Settings.TrCikisSure2;
    SendData[5] := HGS_Settings.ProgramMode;
    SendData[6] := HGS_Settings.DiziEklemeSure1;
    SendData[7] := HGS_Settings.DiziEklemeSure2;
    ToPrBytes(HGS_Settings.ZamanKisitEnb,SendData,8);
    SendData[9] := HGS_Settings.AntenPower1;
    SendData[10] := HGS_Settings.AntenPower2;
    SendData[11] := HGS_Settings.AntenTanitim;
    SendData[12] := HGS_Settings.DefMaksimumArac;
    SendData[13] := HGS_Settings.DefAntiPassPack;
    SendData[14] := HGS_Settings.AppType;

    iErr := ExecuteCmd(3, // CmdNo
      40, // SubCmdNo
      40, // Acknowledge
      15, // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetHGSSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpAddHGSWhitelist(rArac: THGSArac;out IndexNo : Integer) : Integer;
Var
  iErr , i : Integer;
  OldCmdRetry:Integer;
  SendData, RecData: TDataByte;
Begin
  try
    OldCmdretry := CommandRetry;
    CommandRetry := 1;
    try
      ToPrBytesFromHex(rArac.CardID,SendData,0);
      ToPrBytes(rArac.Name,SendData,8,18);
      for I := 0 to 6 do
        SendData[i+26] := rArac.TimeAccessMask[i];
      ToPrBytes(rarac.Daire,SendData,33);
      SendData[35] := rArac.AracNo;
      SendData[36] := 0;
      SendData[37] := 0;
      SendData[38] := 0;
      ToPrBytes(rArac.EndDate,SendData,39);
      ToPrBytes(rArac.AccessDevice,SendData,42);
      ToPrBytes(rArac.APBEnabled,SendData,43);
      ToPrBytes(rArac.ATCEnabled,SendData,44);
      ToPrBytes(rArac.AccessCardEnabled,SendData,45);
      for I := 46 to 51 do
        SendData[i] := 0;

      iErr := ExecuteCmd(3, // CmdNo
        41, // SubCmdNo
        41, // Acknowledge
        52,  // DataLen
        SendData, RecData // SelectTimeOut
        ,2000,1);
        if iErr = 0 then
        Begin
          IndexNo := prBytesToWord(RecData,0);
        End;
    except
      on E: Exception do
      begin
        DoLog(lgError,'tcpAddHGSWhitelist', 'Exception Error : ' + E.Message);
        iErr := TErrors.EXCEPTION;
      end;
    end; // try
  finally
    CommandRetry := OldCmdretry;
  end;
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetHGSWhitelistWithCardID(CardID:String;out rArac: THGSArac;out IndexNo : Integer) : Integer;
Var
  iErr ,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(CardID,SendData,0);
    iErr := ExecuteCmd(3, // CmdNo
      42, // SubCmdNo
      42, // Acknowledge
      8,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        rArac.CardID := prBytesToHex(RecData,0,8);
        rArac.Name := trim(prByteToString(RecData,8,18));
        for I := 26 to 32 do
          rArac.TimeAccessMask[i-26] := RecData[i];
        rArac.Daire := prBytesToWord(RecData,33);
        rArac.AracNo := RecData[35];
        rArac.EndDate := EncodeDate(RecData[41]+2000,RecData[40],RecData[39]);
        rArac.AccessDevice := prBytesToBoolean(RecData,42);
        rArac.APBEnabled := prBytesToBoolean(RecData,43);
        rArac.ATCEnabled := prBytesToBoolean(RecData,44);
        rArac.AccessCardEnabled := prBytesToBoolean(RecData,45);
        IndexNo := prBytesToWord(RecData,52);
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetHGSWhitelistWithCardID', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpEditHGSWhitelistWithCardID (rArac: THGSArac;out IndexNo : Integer): Integer;
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(rArac.CardID,SendData,0);
    ToPrBytes(rArac.Name,SendData,8,18);
    for I := 0 to 6 do
      SendData[i+26] := rArac.TimeAccessMask[i];
    ToPrBytes(rarac.Daire,SendData,33);
    SendData[35] := rArac.AracNo;
    SendData[36] := 0;
    SendData[37] := 0;
    SendData[38] := 0;
    ToPrBytes(rArac.EndDate,SendData,39);
    ToPrBytes(rArac.AccessDevice,SendData,42);
    ToPrBytes(rArac.APBEnabled,SendData,43);
    ToPrBytes(rArac.ATCEnabled,SendData,44);
    ToPrBytes(rArac.AccessCardEnabled,SendData,45);
    for I := 46 to 51 do
      SendData[i] := 0;

    iErr := ExecuteCmd(3, // CmdNo
      43, // SubCmdNo
      43, // Acknowledge
      52,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
          IndexNo := prBytesToWord(RecData,0);
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpEditHGSWhitelistWithCardID', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpDeleteHGSWhitelistWithCardID (CardID : String;out IndexNo : Integer): Integer;
Var
  iErr: Integer;
  OldCmdRetry:Integer;
  SendData, RecData: TDataByte;
Begin
  try
    OldCmdretry := CommandRetry;
    CommandRetry := 1;
    try
      ToPrBytesFromHex(CardID,SendData,0);
      iErr := ExecuteCmd(3, // CmdNo
        44, // SubCmdNo
        44, // Acknowledge
        8,  // DataLen
        SendData, RecData // SelectTimeOut
        ,2000,1);
        if iErr = 0 then
        Begin
            IndexNo := prBytesToWord(RecData,0);
        End;
    except
      on E: Exception do
      begin
        DoLog(lgError,'tcpDeleteHGSWhitelistWithCardID', 'Exception Error : ' + E.Message);
        iErr := TErrors.EXCEPTION;
      end;
    end; // try
  finally
    CommandRetry := OldCmdretry;
  end;
  Result := iErr;
End;

function TPerioTCPRdr.tcpIsHGSCardIDExistInWhitelist(CardID : String;out IndexNo : Integer) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(CardID,SendData,0);
    iErr := ExecuteCmd(3, // CmdNo
      45, // SubCmdNo
      45, // Acknowledge
      8,  // DataLen
      SendData, RecData // SelectTimeOut
      ,2000,3
      );
      if iErr = 0 then
      Begin
          IndexNo := prBytesToWord(RecData,0);
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpIsHGSCardIDExistInWhitelist', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte;out rArac: THGSArac;out IndexNo : Integer) : Integer;
Var
  iErr ,I : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(DaireNo,SendData,0);
    SendData[2] := AracNo;
    SendData[3] := 0;
    iErr := ExecuteCmd(3, // CmdNo
      46, // SubCmdNo
      46, // Acknowledge
      4,  // DataLen
      SendData, RecData // SelectTimeOut
      ,2000,3
      );
      if iErr = 0 then
      Begin
        rArac.CardID := prBytesToHex(RecData,0,8);
        rArac.Name := trim(prByteToString(RecData,8,18));
        for I := 26 to 32 do
          rArac.TimeAccessMask[i-26] := RecData[i];
        rArac.Daire := prBytesToWord(RecData,33);
        rArac.AracNo := RecData[35];
        rArac.EndDate := EncodeDate(RecData[41]+2000,RecData[40],RecData[39]);
        rArac.AccessDevice := prBytesToBoolean(RecData,42);
        rArac.APBEnabled := prBytesToBoolean(RecData,43);
        rArac.ATCEnabled := prBytesToBoolean(RecData,44);
        rArac.AccessCardEnabled := prBytesToBoolean(RecData,45);

          IndexNo := prBytesToWord(RecData,52);
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetHGSWhitelistWithDaireArac', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpIsHGSCardIDDaireAracExistInWhitelist(CardID : String;DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Integer; // CMD 3.47
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(CardID,SendData,0);
    ToPrBytes(DaireNo,SendData,8);
    SendData[10] := AracNo;
    SendData[11] := 0;
    iErr := ExecuteCmd(3, // CmdNo
      47, // SubCmdNo
      47, // Acknowledge
      12,  // DataLen
      SendData, RecData // SelectTimeOut
      ,2000,3
      );
      if iErr = 23 then
      Begin
          IndexNo := prBytesToWord(RecData,0);
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpIsHGSCardIDDaireAracExistInWhitelist', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpDeleteHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Integer; // CMD 3.48
Var
  iErr: Integer;
  OldCmdRetry:Integer;
  SendData, RecData: TDataByte;
Begin
  try
    OldCmdretry := CommandRetry;
    CommandRetry := 1;
    try
      ToPrBytes(DaireNo,SendData,0);
      SendData[2] := AracNo;
      SendData[3] := 0;
      iErr := ExecuteCmd(3, // CmdNo
        48, // SubCmdNo
        48, // Acknowledge
        4,  // DataLen
        SendData, RecData // SelectTimeOut
        ,2000,1);
        if iErr = 0 then
        Begin
            IndexNo := prBytesToWord(RecData,0);
        End;
    except
      on E: Exception do
      begin
        DoLog(lgError,'tcpDeleteHGSWhitelistWithDaireArac', 'Exception Error : ' + E.Message);
        iErr := TErrors.EXCEPTION;
      end;
    end; // try
  finally
    CommandRetry := OldCmdretry;
  end;
  Result := iErr;
End;

function TPerioTCPRdr.tcpIsHGSDaireAracExistInWhitelist(DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Integer;
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(DaireNo,SendData,0);
    SendData[2] := AracNo;
    SendData[3] := 0;
    iErr := ExecuteCmd(3, // CmdNo
      49, // SubCmdNo
      49, // Acknowledge
      4,  // DataLen
      SendData, RecData // SelectTimeOut
      ,2000,3
      );
      if iErr = 0 then
      Begin
          IndexNo := prBytesToWord(RecData,0);
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpIsHGSCardIDExistInWhitelist', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpReadHGSRecords(StartFrom,HowMany:Cardinal;out Recs:THGSRecords) : Integer;
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
  TransferredCount ,RecordSize ,ReceivedCount,
  TempCountPerTime,TempStartFrom : Integer;
  tempRecs     : THGSRecords;
  CardId:String;
Begin
  try
    RecordSize := 17;
    TransferredCount := 0;
    TempStartFrom := StartFrom;
    tempRecs.Count:= 0;
    SetLength(tempRecs.raDeviceRecs,0);

    repeat
      if ((HowMany - TransferredCount) >= 12 ) then
        TempCountPerTime:= 12
      else TempCountPerTime:= HowMany - TransferredCount;

      SendData[0] :=  TempStartFrom         and $FF;
      SendData[1] := (TempStartFrom shr 8)  and $FF;
      SendData[2] := (TempStartFrom shr 16) and $FF;
      SendData[3] := TempCountPerTime;
      iErr := ExecuteCmd(3, // CmdNo
        50, // SubCmdNo
        50, // Acknowledge
        4,  // DataLen
        SendData, RecData // SelectTimeOut
        );
      if iErr = 0 then
      Begin
        ReceivedCount := RecData[0];
        tempRecs.Count := tempRecs.Count + ReceivedCount;
        SetLength(tempRecs.raDeviceRecs,tempRecs.Count);
        for i := 0 to ReceivedCount - 1 do
        begin
          CardId := '';
          CardId := prBytesToHex(RecData,(RecordSize * i)+1,8);
          tempRecs.raDeviceRecs[i+TransferredCount].CardID := CardId;
          tempRecs.raDeviceRecs[i+TransferredCount].DoorNo     := RecData[(RecordSize*i)+9];
          tempRecs.raDeviceRecs[i+TransferredCount].RecordType := RecData[(RecordSize*i)+10];
          //tempRecs.raDeviceRecs[i+TransferredCount].RFU[0]     := RecData[(RecordSize*i)+11];
          //tempRecs.raDeviceRecs[i+TransferredCount].RFU[1]     := RecData[(RecordSize*i)+12];
          tempRecs.raDeviceRecs[i+TransferredCount].TimeDate :=
          prBytesToDateTimeEx(RecData,(RecordSize * i) + 12);
        end;
        TransferredCount:= TransferredCount + ReceivedCount;
        TempStartFrom:= TempStartFrom + ReceivedCount;
      End;
    until (TransferredCount = HowMany) or (iErr <> 0);
    if iErr=0 Then Recs := tempRecs;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpReadRecords', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpTransferHGSRecords(Out Recs:THGSRecords) : Integer;
  function ConfirmRecs(uTransferredCount: byte): integer;
  Var
    iErr: Integer;
    SendData, RecData: TDataByte;
  begin
    try
      SendData[0] := uTransferredCount;
      iErr := ExecuteCmd(3, // CmdNo
        52, // SubCmdNo
        52, // Acknowledge
        1,  // DataLen
        SendData, RecData // SelectTimeOut
        );
    except
      on E: Exception do
      begin
        DoLog(lgError,'ConfirmRecs', 'Exception Error : ' + E.Message);
        iErr := TErrors.EXCEPTION;
      end;
    end; // try
    Result := iErr;
  end;
Var
  iErr ,i: Integer;
  SendData, RecData: TDataByte;
  CountToTransfer,TransferredCount ,RecordSize ,ReceivedCount,
  CountPerTime,TempCountPerTime,StartFrom : Integer;
  tempRecs ,notConfRecs : THGSRecords;
  Head,Tail,Capacity:Cardinal;
  CardId : String;
Begin
  try
    RecordSize := 17;
    TransferredCount := 0;
    tempRecs.Count:= 0;
    SetLength(tempRecs.raDeviceRecs,0);
    notConfRecs.Count := 0;
    SetLength(notConfRecs.raDeviceRecs,0);

    iErr := tcpGetHeadTailCapacity(Head,Tail,Capacity);
    if iErr = 0 then
    begin
      if Head > Tail then
        CountToTransfer := Head - Tail
      else
        CountToTransfer := Capacity - Tail + Head;
      CountPerTime := 12;
      StartFrom := Tail;

      repeat
        sleep(1);
        if ((CountToTransfer - tempRecs.Count) >= CountPerTime) then
          TempCountPerTime:= CountPerTime
        else
          TempCountPerTime:= CountToTransfer - tempRecs.Count;

        SendData[0] := TempCountPerTime;
        iErr := ExecuteCmd(3, // CmdNo
          51, // SubCmdNo
          51, // Acknowledge
          1,  // DataLen
          SendData, RecData // SelectTimeOut
          );

        if iErr = 0 then
        begin
          notConfRecs.Count:= RecData[0];
          SetLength(notConfRecs.raDeviceRecs,notConfRecs.Count);
          for i:= 0 to notConfRecs.Count - 1 do
          begin
            // Card ID
            CardId := '';
            CardId := prBytesToHex(RecData,(RecordSize * i)+1,8);
            notConfRecs.raDeviceRecs[i+TransferredCount].CardID := CardId;
            // Door No
            notConfRecs.raDeviceRecs[i+TransferredCount].DoorNo := RecData[(RecordSize*i)+9];
            // Record Type
            notConfRecs.raDeviceRecs[i+TransferredCount].RecordType := RecData[(RecordSize*i)+10];
            // RFU
            //notConfRecs.raDeviceRecs[i+TransferredCount].RFU[0] := RecData[(RecordSize*i)+10];
            //notConfRecs.raDeviceRecs[i+TransferredCount].RFU[1] := RecData[(RecordSize*i)+11];
            // Date Time
            notConfRecs.raDeviceRecs[i+TransferredCount].TimeDate
                 := prBytesToDateTimeEx(RecData,(RecordSize * i) + 12);
          end;
          iErr:= ConfirmRecs(notConfRecs.Count);
          if iErr = 0 then
          begin
            SetLength(TempRecs.raDeviceRecs,TempRecs.Count + notConfRecs.Count);
            for I := TempRecs.Count to (TempRecs.Count + notConfRecs.Count)-1 do
              TempRecs.raDeviceRecs[i]:= notConfRecs.raDeviceRecs[cardinal(i)-TempRecs.Count];
            TempRecs.Count:= TempRecs.Count + notConfRecs.Count;
          end;
        end;
      until (CountToTransfer <= tempRecs.Count) or (iErr <> 0);
    end;
    if iErr=0 Then  recs := tempRecs;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpTransferRecords', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetHGSDaireParkHak(rDaire:word;out rHak:Byte) : Integer; // CMD 3.53
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(rDaire,SendData,0);
    iErr := ExecuteCmd(3, // CmdNo
      53, // SubCmdNo
      53, // Acknowledge
      2,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
         rHak := RecData[0];
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetHGSDaireParkHak', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetHGSDaireParkHak(rDaire:word;rHak:Byte) : Integer; // CMD 3.54
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(rDaire,SendData,0);
    ToPrBytes(rHak,SendData,2);
    iErr := ExecuteCmd(3, // CmdNo
      54, // SubCmdNo
      54, // Acknowledge
      3,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetHGSDaireParkHak', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetTumAralarDisarda : Integer; // CMD 3.54
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(3, // CmdNo
      60, // SubCmdNo
      60, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetHGSDaireParkHak', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;



function TPerioTCPRdr.tcpGetYmkSettings(out rSettings :TYmkSettings) : Integer; // CMD 4.1
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(4, // CmdNo
      1, // SubCmdNo
      1, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
	      rSettings.UseMonthlyRight :=prBytesToBoolean(RecData,0);
	      rSettings.CurrPriceList := RecData[1];
	      rSettings.YmkSectorNo := RecData[2];
	      rSettings.PlantNo := RecData[3];
        rSettings.OutOfMealstatus := RecData[4];
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetYmkSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetYmkSettings(rSettings :TYmkSettings) : Integer; // CMD 4.2
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
	  SendData[0] := ToByte(rSettings.UseMonthlyRight);
	  SendData[1] := rSettings.CurrPriceList;
	  SendData[2] := rSettings.YmkSectorNo;
	  SendData[3] := rSettings.PlantNo;
	  SendData[4] := rSettings.OutOfMealstatus;
    iErr := ExecuteCmd(4, // CmdNo
      2, // SubCmdNo
      2, // Acknowledge
      5,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetYmkSettings', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetMealTable(out rSettings :TMealTable) : Integer; // CMD 4.3
Var
  iErr , i ,j : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for I := 0 to 7 do
    Begin
       SendData[0] := i;
       iErr := ExecuteCmd(4, // CmdNo
         3, // SubCmdNo
         3, // Acknowledge
         1,  // DataLen
         SendData, RecData // SelectTimeOut
        );
        if iErr = 0 then
        Begin
          for j := 0 to 7 do
          Begin
            rSettings.Days[i].list[j].StartTime := EncodeTime(RecData[(j*7)+0],RecData[(j*7)+1],0,0);
            rSettings.Days[i].list[j].StartDBY := RecData[(j*7)+2];
            rSettings.Days[i].list[j].EndTime := EncodeTime(RecData[(j*7)+3],RecData[(j*7)+4],0,0);
            rSettings.Days[i].list[j].EndDBY := RecData[(j*7)+5];
            rSettings.Days[i].list[j].Active := prBytesToBoolean(RecData,(j*7)+6);
          End;
        End else break;
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetMealTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetMealTable(rSettings :TMealTable) : Integer; // CMD 4.4
Var
  iErr ,i,j : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for I := 0 to 7 do
    Begin
       SendData[0] := i;
       for j := 0 to 7 do
       Begin
         SendData[(j*7)+1] := HourOf(rSettings.Days[i].list[j].StartTime);
         SendData[(j*7)+2] := MinuteOf(rSettings.Days[i].list[j].StartTime);
         SendData[(j*7)+3] := rSettings.Days[i].list[j].StartDBY;
         SendData[(j*7)+4] := HourOf(rSettings.Days[i].list[j].EndTime);
         SendData[(j*7)+5] := MinuteOf(rSettings.Days[i].list[j].EndTime);
         SendData[(j*7)+6] := rSettings.Days[i].list[j].EndDBY;
         ToPrBytes(rSettings.Days[i].list[j].Active,SendData,(j*7)+7);
       End;
       iErr := ExecuteCmd(4, // CmdNo
         4, // SubCmdNo
         4, // Acknowledge
         57,  // DataLen
         SendData, RecData // SelectTimeOut
         );
        if iErr <> 0 then break;
    End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetMealTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetMealRigthTable(TableNo : Byte ;out rSettings :TWeaklyMealRight) : Integer; // CMD 4.5
Var
  iErr ,i,j : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := TableNo;
    iErr := ExecuteCmd(4, // CmdNo
      5, // SubCmdNo
      5, // Acknowledge
      1,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        for I := 0 to 7 do
        Begin
          for j := 0 to 7 do
            rSettings.Days[i].MealRigths[j] := RecData[(i*9)+j];
          rSettings.Days[i].TotalDayRight := RecData[(i*9)+8];
        End;
        for I := 0 to 7 do
          rSettings.TotalWeeklyMealRight[i] := RecData[i+72];
        for I := 0 to 7 do
          rSettings.TotalMonthlyMealRight[i] := RecData[i+80];
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetMealRigthTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetMealRigthTable(TableNo : Byte ;rSettings :TWeaklyMealRight) : Integer; // CMD 4.6
Var
  iErr ,i,j : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := TableNo;
    for I := 0 to 7 do
    Begin
      for j := 0 to 7 do
        SendData[(i*9)+j+1] := rSettings.Days[i].MealRigths[j];
      SendData[(i*9)+9] := rSettings.Days[i].TotalDayRight;
    End;
    for I := 0 to 7 do
      SendData[i+73] := rSettings.TotalWeeklyMealRight[i];
    for I := 0 to 7 do
      SendData[i+81] := rSettings.TotalMonthlyMealRight[i];

    iErr := ExecuteCmd(4, // CmdNo
      6, // SubCmdNo
      6, // Acknowledge
      89,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetMealRigthTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetPriceListTable(TableNo : Byte ;out rSettings :TPriceList) : Integer; // CMD 4.7
Var
  iErr ,i,j,k : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := TableNo;
    iErr := ExecuteCmd(4, // CmdNo
      9, // SubCmdNo
      9, // Acknowledge
      1,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        rSettings.Name := prByteToString(RecData,0,16);
        for I := 0 to 7 do
        Begin
          SendData[0] := TableNo;
          SendData[1] := i;//Day No
          iErr := ExecuteCmd(4, // CmdNo
            7, // SubCmdNo
            7, // Acknowledge
            2,  // DataLen
            SendData, RecData // SelectTimeOut
            );
            if iErr = 0 then
            Begin
              for j := 0 to 7 do
                 for k := 0 to 14 do
                    rSettings.Days[i].Meals[j].Prices[k] := prBytesToWord(RecData,(j*30)+(k*2));
            End
            else break;
        End;
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetPriceListTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetPriceListTable(TableNo : Byte ;rSettings :TPriceList) : Integer; // CMD 4.8
Var
  iErr ,i,j,k : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := TableNo;
    ToPrBytes(rSettings.Name,SendData,1,16);
    iErr := ExecuteCmd(4, // CmdNo
      10, // SubCmdNo
      10, // Acknowledge
      21,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        for I := 0 to 7 do
        Begin
         SendData[0] := TableNo;
         SendData[1] := i;
          for j := 0 to 7 do
            for k := 0 to 14 do
              ToPrBytes(rSettings.Days[i].Meals[j].Prices[k],SendData,(j*30)+(k*2)+2);
          iErr := ExecuteCmd(4, // CmdNo
            8, // SubCmdNo
            8, // Acknowledge
            242,  // DataLen
            SendData, RecData // SelectTimeOut
            ,2000
            );
          if iErr <> 0 then
            Break;
        End;
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetPriceListTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetYmkFactoryDefaults(Reboot : Boolean):Integer; // CMD 4.11
Var
  iErr: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytes(Reboot,SendData,0);
    iErr := ExecuteCmd(4, // CmdNo
      11, // SubCmdNo
      11, // Acknowledge
      1,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetYmkFactoryDefaults', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetPersonYmkSettingList(ListNo : Byte ;out rSettings :TPersonMealSetting) : Integer; // CMD 4.12
Var
  iErr ,i,j,k : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := ListNo;
    iErr := ExecuteCmd(4, // CmdNo
      12, // SubCmdNo
      12, // Acknowledge
      1,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        rSettings.MealRightWorkMode := RecData[0];
        rSettings.MealRightListNo := RecData[1];
        rSettings.ContorModeEnable := prBytesToBoolean(RecData,2);
        rSettings.PriceGroup := RecData[3];
        rSettings.ReReadPriceGroup := RecData[4];
        rSettings.ReReadCount := RecData[5];
        rSettings.ReReadType := RecData[6];
        rSettings.ReReadTimeOut := prBytesToWord(RecData,7);
        rSettings.ExtraLimit := RecData[9];

      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetPersonYmkSettingList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetPersonYmkSettingList(ListNo : Byte ;rSettings :TPersonMealSetting) : Integer; // CMD 4.13
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := ListNo;
    ToPrBytes(rSettings.MealRightWorkMode,SendData,1);
    ToPrBytes(rSettings.MealRightListNo,SendData,2);
    ToPrBytes(rSettings.ContorModeEnable,SendData,3);
    ToPrBytes(rSettings.PriceGroup,SendData,4);
    ToPrBytes(rSettings.ReReadPriceGroup,SendData,5);
    ToPrBytes(rSettings.ReReadCount,SendData,6);
    ToPrBytes(rSettings.ReReadType,SendData,7);
    ToPrBytes(rSettings.ReReadTimeOut,SendData,8);
    SendData[10] := rSettings.ExtraLimit;
    for I := 11 to 16 do
      SendData[i] := 0;
    //ToPrBytes(rSettings.Name,SendData,1,20);
    iErr := ExecuteCmd(4, // CmdNo
      13, // SubCmdNo
      13, // Acknowledge
      17,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetPriceListTable', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetStaticMealRightList(ListNo : Byte ;out rSettings :TDailyMealRight) : Integer; // CMD 4.14
Var
  iErr ,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := ListNo;
    iErr := ExecuteCmd(4, // CmdNo
      14, // SubCmdNo
      14, // Acknowledge
      1,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        for I := 0 to 7 do
          rSettings.MealRigths[i] := RecData[i];
        rSettings.TotalDayRight := RecData[8];
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetStaticMealRightList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetStaticMealRightList(ListNo : Byte ;rSettings :TDailyMealRight) : Integer; // CMD 4.15
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := ListNo;
    for I := 0 to 7 do
      SendData[i+1] := rSettings.MealRigths[i];
    SendData[9] := rSettings.TotalDayRight;

    iErr := ExecuteCmd(4, // CmdNo
      15, // SubCmdNo
      15, // Acknowledge
      10,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetStaticMealRightList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetMonthlyMealRightList(CardID : String;DayNo : Byte ;out rSettings :TDailyMealRight) : Integer; // CMD 4.16
Var
  iErr ,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := DayNo;
    ToPrBytesFromHex(CardID,SendData,1,14);
    iErr := ExecuteCmd(4, // CmdNo
      16, // SubCmdNo
      16, // Acknowledge
      8,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        for I := 0 to 7 do
          rSettings.MealRigths[i] := RecData[i];
        rSettings.TotalDayRight := RecData[8];
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetMonthlyMealRightList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetMonthlyMealRightList(CardID : String;DayNo : Byte ;rSettings :TDailyMealRight) : Integer; // CMD 4.17
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    SendData[0] := DayNo;
    ToPrBytesFromHex(CardID,SendData,1,14);
    for I := 0 to 7 do
      SendData[i+8] := rSettings.MealRigths[i];
    SendData[16] := rSettings.TotalDayRight;

    iErr := ExecuteCmd(4, // CmdNo
      17, // SubCmdNo
      17, // Acknowledge
      17,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetStaticMealRightList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetMealNameList(out Names : TMealNameList) : Integer; // CMD 4.18
Var
  iErr ,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    iErr := ExecuteCmd(4, // CmdNo
      18, // SubCmdNo
      18, // Acknowledge
      0,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        for I := 0 to 7 do
        Begin
          Names.code[i] := prByteToString(RecData,i*25,10);
          Names.Name[i] := prByteToString(RecData,i*25+10,15);
        End;
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetMealNameList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TPerioTCPRdr.tcpSetMealNameList(Names : TMealNameList) : Integer; // CMD 4.19
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    for I := 0 to 7 do
    Begin
      ToPrBytes(Names.code[i],SendData,i*25,10);
      ToPrBytes(Names.Name[i],SendData,i*25+10,15);
    End;

    iErr := ExecuteCmd(4, // CmdNo
      19, // SubCmdNo
      19, // Acknowledge
      200,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetMealNameList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TPerioTCPRdr.tcpGetPersonCommands(CardID : String;out CommandList : TPersonCommandList) : Integer; // CMD 4.20
Var
  iErr ,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(CardID,SendData,0,14);
    iErr := ExecuteCmd(4, // CmdNo
      20, // SubCmdNo
      20, // Acknowledge
      7,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        for I := 0 to 14 do
        Begin
          CommandList.List[i].CmdType := RecData[(7*i)];
          CommandList.List[i].SessionID := RecData[(7*i)+1]+RecData[(7*i)+2]*256+RecData[(7*i)+3]*256*256;
          CommandList.List[i].Amount := RecData[(7*i)+5]+RecData[(7*i)+6]*256;
        End;
        CommandList.TotalCommand := RecData[105];
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetPersonCommands', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetPersonCommands(CardID : String;CommandList : TPersonCommandList) : Integer; // CMD 4.21
Var
  iErr ,i : Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(CardID,SendData,0,14);
    for I := 0 to 14 do
    Begin
      SendData[7+(7*i)] := CommandList.List[i].CmdType;
      SendData[7+(7*i)+1] := CommandList.List[i].SessionID          and $FF;
      SendData[7+(7*i)+2] := (CommandList.List[i].SessionID shr 8)  and $FF;
      SendData[7+(7*i)+3] := (CommandList.List[i].SessionID shr 16) and $FF;
      SendData[7+(7*i)+4] := 0;
      SendData[7+(7*i)+5] := CommandList.List[i].Amount          and $FF;
      SendData[7+(7*i)+6] := (CommandList.List[i].Amount shr 8)  and $FF;
    End;
    SendData[112] := CommandList.TotalCommand;
    iErr := ExecuteCmd(4, // CmdNo
      21, // SubCmdNo
      21, // Acknowledge
      113,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetPersonCommands', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpGetPersonTZList(CardID : String;out PersTZList : TPersTZList) : Integer; // CMD 3.65
Var
  iErr ,i,j: Integer;
  Day,Month,Year,sHour, sMin,eHour, eMin : Word;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(CardID,SendData,0,14);
    iErr := ExecuteCmd(3, // CmdNo
      65, // SubCmdNo
      65, // Acknowledge
      7,  // DataLen
      SendData, RecData // SelectTimeOut
      );
      if iErr = 0 then
      Begin
        for I := 0 to 4 do
        Begin
          Day :=    RecData[36*i+0];
          Month :=  RecData[36*i+1];
          Year :=   RecData[36*i+2]+2000;
          PersTZList.List[i].Day := EncodeDate(Year,Month,Day);
          PersTZList.List[i].TZListNo := RecData[36*i+3];
          for j := 0 to 7 do
          Begin
            sHour := RecData[(36*i+4)+(j*4)+0];
            sMin :=  RecData[(36*i+4)+(j*4)+1];
            eHour := RecData[(36*i+4)+(j*4)+2];
            eMin :=  RecData[(36*i+4)+(j*4)+3];
            PersTZList.List[i].Part[j].StartTime := EncodeTime(sHour, sMin,0,0);
            PersTZList.List[i].Part[j].EndTime   := EncodeTime(eHour, eMin,0,0);
          End;

        End;
      End;
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpGetPersonTZList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.tcpSetPersonTZList(CardID : String;PersTZList : TPersTZList) : Integer; // CMD 3.66
Var
  iErr ,i,j : Integer;
  Day,Month,Year,sHour, sMin,eHour, eMin,Sec, MSec : Word;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(CardID,SendData,0,14);
    for I := 0 to 4 do
    Begin
      DecodeDate(PersTZList.List[i].Day,Year,Month,Day);
      SendData[7+36*i+0] := Day;
      SendData[7+36*i+1] := Month;
      SendData[7+36*i+2] := Year-2000;
      SendData[7+36*i+3] := PersTZList.List[i].TZListNo;
      for j := 0 to 7 do
      Begin
        DecodeTime(PersTZList.List[i].Part[j].StartTime,sHour, sMin,Sec, MSec);
        DecodeTime(PersTZList.List[i].Part[j].EndTime,eHour, eMin,Sec, MSec);
        SendData[7+(36*i+4)+(j*4)+0] := sHour;
        SendData[7+(36*i+4)+(j*4)+1] := sMin;
        SendData[7+(36*i+4)+(j*4)+2] := eHour;
        SendData[7+(36*i+4)+(j*4)+3] := eMin;
      End;
    End;
    iErr := ExecuteCmd(3, // CmdNo
      66, // SubCmdNo
      66, // Acknowledge
      187,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpSetPersonTZList', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;


function TPerioTCPRdr.tcpDisablePersCommands(CardID : String) : Integer; // CMD 4.22
Var
  iErr ,i: Integer;
  SendData, RecData: TDataByte;
Begin
  try
    ToPrBytesFromHex(CardID,SendData,0,14);
    iErr := ExecuteCmd(4, // CmdNo
      22, // SubCmdNo
      22, // Acknowledge
      7,  // DataLen
      SendData, RecData // SelectTimeOut
      );
  except
    on E: Exception do
    begin
      DoLog(lgError,'tcpDisablePersCommands', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.GetRegularInfo(out deviceDate:TDateTime;out headTail:Byte;out head:Cardinal;out tail:Cardinal;out Capacity:Cardinal;
   out DoorOpen :Boolean;out DoorOpenDT :TDateTime;out DeviceStatusMode : Byte):Boolean;
Begin
  Result := (tcpGetRegularInfo(deviceDate,headTail,head,tail,Capacity,DoorOpen,DoorOpenDT,DeviceStatusMode)=0);
End;

function TPerioTCPRdr.GetAppGeneralSettings(out rSettings :TAccessGeneralSettings) : Boolean;
Begin
  Result := (tcpGetAppGeneralSettings(rSettings)=0);
End;

function TPerioTCPRdr.SetAppGeneralSettings(rSettings :TAccessGeneralSettings) : Boolean;
Begin
  Result := (tcpSetAppGeneralSettings(rSettings)=0);
End;

function TPerioTCPRdr.GetAntiPassbackSettings(out rSettings :TAPBSettings ) : Boolean;
Begin
  Result := (tcpGetAntiPassbackSettings(rSettings)=0);
End;

function TPerioTCPRdr.SetAntiPassbackSettings(rSettings :TAPBSettings ) : Boolean;
Begin
  Result := (tcpSetAntiPassbackSettings(rSettings)=0);
End;

function TPerioTCPRdr.GetOutOfServiceSettings(out rSettings : TOutOfServiceSettings) : Boolean;
Begin
  Result := (tcpGetOutOfServiceSettings(rSettings)=0);
End;

function TPerioTCPRdr.SetOutOfServiceSettings(rSettings : TOutOfServiceSettings) : Boolean;
Begin
  Result := (tcpSetOutOfServiceSettings(rSettings)=0);
End;

function TPerioTCPRdr.GetOutOfServiceTable(out rTOSTable :TOSTable ) : Boolean;
Begin
  Result := (tcpGetOutOfServiceTable(rTOSTable)=0);
End;

function TPerioTCPRdr.SetOutOfServiceTable(rTOSTable :TOSTable ) : Boolean;
Begin
  Result := (tcpSetOutOfServiceTable(rTOSTable)=0);
End;

function TPerioTCPRdr.GetBellSettings(out rSettings : TBellSettings) : Boolean;
Begin
  Result := (tcpGetBellSettings(rSettings)=0);
End;

function TPerioTCPRdr.SetBellSettings(rSettings : TBellSettings) : Boolean;
Begin
  Result := (tcpSetBellSettings(rSettings)=0);
End;

function TPerioTCPRdr.GetBellTable(DayNo : Byte;out BellTable : TBellTable) : Boolean;
Begin
  Result := (tcpGetBellTable(DayNo,BellTable)=0);
End;

function TPerioTCPRdr.SetBellTable(DayNo : Byte;BellTable : TBellTable) : Boolean;
Begin
  Result := (tcpSetBellTable(DayNo,BellTable)=0);
End;

function TPerioTCPRdr.GetTimeConstraintTables(TableNo : Byte ;out TACList : TTACList) : Boolean;
Begin
  Result := (tcpGetTimeConstraintTables(TableNo,TACList)=0);
End;

function TPerioTCPRdr.SetTimeConstraintTables(TableNo : Byte ;TACList : TTACList) : Boolean;
Begin
  Result := (tcpSetTimeConstraintTables(TableNo,TACList)=0);
End;

function TPerioTCPRdr.GetEksOtherSettings(out EksOtherSettings:TEksOtherSettings) : Boolean;
Begin
  Result := (tcpGetEksOtherSettings(EksOtherSettings)=0);
End;

function TPerioTCPRdr.SetEksOtherSettings( EksOtherSettings:TEksOtherSettings) : Boolean;
Begin
  Result := (tcpSetEksOtherSettings(EksOtherSettings)=0);
End;

function TPerioTCPRdr.AddWhitelist(rPerson : TPerson;out IndexNum : Integer;IfExistEdit:Boolean=False) : Integer;
Var
  iErr,lclErr : Integer;
Begin
  try
    lclErr := IsCardIDExistInWhitelistX(rPerson.CardID,IndexNum);
    case lclErr of
      0 :
        Begin
          iErr := tcpAddWhitelist(rPerson,IndexNum);
          if (iErr <> 0) then
            DoLog(lgDebug,'AddWhitelist(*)','Error  ('+IntToStr(iErr)+') CardID <'+rPerson.CardID+'>',0);
            //LogDebug('AddWhitelist(*)','Error  ('+IntToStr(iErr)+') CardID <'+rPerson.CardID+'>',0);
        End;
      51:
        begin
           iErr := lclErr;
           DoLog(lgDebug,'AddWhitelist','CardID Exists <'+rPerson.CardID+'>  ',0);
           //LogDebug('AddWhitelist','CardID Exists <'+rPerson.CardID+'>  ',0);
           if IfExistEdit then
              iErr := EditWhitelistWithCardID(rPerson,IndexNum);
        end;
      else
        begin
           DoLog(lgDebug,'AddWhitelist','Error  ('+IntToStr(lclErr)+') CardID <'+rPerson.CardID+'>',0);
           //LogDebug('AddWhitelist','Error  ('+IntToStr(lclErr)+') CardID <'+rPerson.CardID+'>',0);
           iErr := lclErr;
        end;
      end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'AddWhitelist', 'CardID <'+rPerson.CardID+'> Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.AddWhitelist(rPerson : TPerson;IfExistEdit:Boolean=false) : Integer;
Var
  InxNm:Integer;
Begin
  Result := AddWhitelist(rPerson,InxNm,IfExistEdit);
End;

function TPerioTCPRdr.AddBlacklist(rBlackList : TBlackList;out IndexNum : Integer;IfExistEdit:Boolean=False) : Integer;
Var
  iErr,lclErr : Integer;
  rPerson : TPerson;
Begin
  try
    rPerson.CardID := rBlackList.CardID;
    rPerson.Name := rBlackList.Caption;
    rPerson.BlackListCmdNo := rBlackList.BlackListCmdNo;
    lclErr := IsCardIDExistInWhitelistX(rPerson.CardID,IndexNum);
    case lclErr of
      0 :
        Begin
          iErr := tcpAddWhitelist(rPerson,IndexNum);
          if (iErr <> 0) then
            DoLog(lgDebug,'AddBlacklist(*)','Error  ('+IntToStr(iErr)+') CardID <'+rPerson.CardID+'>',0);
            //LogDebug('AddBlacklist(*)','Error  ('+IntToStr(iErr)+') CardID <'+rPerson.CardID+'>',0);
        End;
      51:
        begin
           iErr := lclErr;
           DoLog(lgDebug,'AddBlacklist','CardID Exists <'+rPerson.CardID+'>  ',0);
           //LogDebug('AddBlacklist','CardID Exists <'+rPerson.CardID+'>  ',0);
           if IfExistEdit then
              iErr := EditWhitelistWithCardID(rPerson,IndexNum);
        end;
      else
        begin
           DoLog(lgDebug,'AddBlacklist','Error  ('+IntToStr(lclErr)+') CardID <'+rPerson.CardID+'>',0);
           //LogDebug('AddBlacklist','Error  ('+IntToStr(lclErr)+') CardID <'+rPerson.CardID+'>',0);
           iErr := lclErr;
        end;
      end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'AddBlacklist', 'CardID <'+rPerson.CardID+'> Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
End;

function TPerioTCPRdr.GetWhitelistWithCardID(CardID:String;out rPerson : TPerson) : Integer;
Var
  InxNum : Integer;
Begin
  Result := tcpGetWhitelistWithCardID(CardID,rPerson,InxNum) ;
End;

function TPerioTCPRdr.GetWhitelistWithCardID(CardID:String;out rPerson : TPerson;out IndexNum : Integer) : Integer;
Begin
  Result := tcpGetWhitelistWithCardID(CardID,rPerson,IndexNum) ;
End;

function TPerioTCPRdr.GetBlacklistWithCardID(CardID:String;out rBlackList : TBlackList;out IndexNum : Integer) : Integer;
Var
  rPerson : TPerson;
Begin
  Result := tcpGetWhitelistWithCardID(CardID,rPerson,IndexNum) ;
  if Result = 0 then
  Begin
    rBlackList.CardID := rPerson.CardID;
    rBlackList.Caption := rPerson.Name;
    rBlackList.BlackListCmdNo := rPerson.BlackListCmdNo;
  End;
End;

function TPerioTCPRdr.EditWhitelistWithCardID (rPerson : TPerson): Integer;
Var
  InxNum:Integer;
Begin
  Result := tcpEditWhitelistWithCardID (rPerson,InxNum);
End;

function TPerioTCPRdr.EditWhitelistWithCardID (rPerson : TPerson;out IndexNum : Integer): Integer;
Begin
  Result := tcpEditWhitelistWithCardID (rPerson,IndexNum);
End;

function TPerioTCPRdr.EditBlacklistWithCardID (rBlackList : TBlackList;out IndexNum : Integer): Integer;
Var
  rPerson : TPerson;
Begin
  rPerson.CardID := rBlackList.CardID;
  rPerson.Name := rBlackList.Caption;
  rPerson.BlackListCmdNo := rBlackList.BlackListCmdNo;
  Result := tcpEditWhitelistWithCardID (rPerson,IndexNum);
End;

function TPerioTCPRdr.DeleteWhitelistWithCardID (CardID : String): Integer;
Var
  InxNum:Integer;
Begin
  Result := DeleteWhitelistWithCardID(CardID,InxNum);
End;

function TPerioTCPRdr.DeleteWhitelistWithCardID (CardID : String;out IndexNum : Integer): Integer;
Var
  iErr,lclErr : Integer;
Begin

  try
    lclErr := IsCardIDExistInWhitelistX(CardID,IndexNum);
    case lclErr of
      0 :
        Begin
          IndexNum := -1;
          iErr := 0;
          DoLog(lgDebug,'DeleteWhitelistWithCardID','Card Not Found ['+CardID+'] iErr : ('+IntToStr(iErr)+') ',0);
        End;
      51:
        begin
          iErr := tcpDeleteWhitelistWithCardID(CardID,IndexNum);
          if (iErr <> 0) then
            DoLog(lgError,'DeleteWhitelistWithCardID','Error  ['+CardID+'] iErr : ('+IntToStr(iErr)+') ',0);
        end;
      else
        begin
           DoLog(lgError,'DeleteWhitelistWithCardID','Error  ['+CardID+'] iErr : ('+IntToStr(iErr)+') ',0);
           iErr := lclErr;
        end;
      end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'DeleteWhitelistWithCardID', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TPerioTCPRdr.DeleteBlacklistWithCardID (CardID : String;out IndexNum : Integer): Integer;
Var
  iErr,lclErr : Integer;
Begin

  try
    lclErr := IsCardIDExistInWhitelistX(CardID,IndexNum);
    case lclErr of
      0 :
        Begin
          iErr := 12;
          if (iErr <> 0) then
            DoLog(lgDebug,'DeleteWhitelistWithCardID','Error  ('+IntToStr(lclErr)+') ',0);
            //LogDebug('DeleteWhitelistWithCardID','Error  ('+IntToStr(lclErr)+') ',0);
        End;
      51:
        begin
          iErr := tcpDeleteWhitelistWithCardID(CardID,IndexNum);
          if (iErr <> 0) then
            DoLog(lgDebug,'DeleteWhitelistWithCardID','Error  ('+IntToStr(iErr)+') ',0);
            //LogDebug('DeleteWhitelistWithCardID','Error  ('+IntToStr(iErr)+') ',0);
        end;
      else
        begin
           DoLog(lgDebug,'DeleteWhitelistWithCardID','Error  ('+IntToStr(lclErr)+') ',0);
           //LogDebug('DeleteWhitelistWithCardID','Error  ('+IntToStr(lclErr)+') ',0);
           iErr := lclErr;
        end;
      end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'DeleteWhitelistWithCardID', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TPerioTCPRdr.GetWhitelistCardIDCount : Integer;
Var
  cnt : LongWord;
Begin
  if tcpGetWhitelistCardIDCount(Cnt) = 0 then
    Result := Cnt
  else
    Result := -1;
End;

function TPerioTCPRdr.IsCardIDExistInWhitelist(CardID : String) : Boolean;
Var
  InxNum:Integer;
Begin
  Result := (tcpIsCardIDExistInWhitelist(CardID,InxNum)=0);
End;

function TPerioTCPRdr.IsCardIDExistInWhitelist(CardID : String;out IndexNum : Integer) : Boolean;
Begin
  Result := (tcpIsCardIDExistInWhitelist(CardID,IndexNum)=0);
End;

function TPerioTCPRdr.IsCardIDExistInWhitelistX(CardID : String) : Integer;
Var
  InxNum : Integer;
Begin
  Result := tcpIsCardIDExistInWhitelist(CardID,InxNum);
End;

function TPerioTCPRdr.IsCardIDExistInWhitelistX(CardID : String;out IndexNum : Integer) : Integer;
Begin
  Result := tcpIsCardIDExistInWhitelist(CardID,IndexNum);
End;

function TPerioTCPRdr.ClearWhitelist : Boolean;
Begin
  Result := (tcpClearWhitelist=0);
End;


function TPerioTCPRdr.ReadRecords(StartFrom,HowMany:Cardinal;out Recs:TAccessRecords) : Boolean;
Var
  i : Integer;
Begin
  Result := (tcpReadRecords(StartFrom,HowMany,Recs)=0);
  if Result Then
  Begin
    case fwAppType of
      fwPDKS :
        Begin
          for I := 0 to recs.Count-1 do
          Begin
            recs.raDeviceRecs[i].PdksType := recs.raDeviceRecs[i].RFU[0];
            recs.raDeviceRecs[i].IOType := recs.raDeviceRecs[i].RFU[1];          
          End;
        end;
      fwYMK :
        Begin
          for I := 0 to recs.Count-1 do
          Begin
            recs.raDeviceRecs[i].Fee := recs.raDeviceRecs[i].RFU[0]
               + recs.raDeviceRecs[i].RFU[1]*256;
            recs.raDeviceRecs[i].LastSessionId := recs.raDeviceRecs[i].RFU[0]
               + recs.raDeviceRecs[i].RFU[1]*256 + recs.raDeviceRecs[i].DoorNo*256*256;
            recs.raDeviceRecs[i].ReReadCnt := recs.raDeviceRecs[i].DoorNo;
          End;
        end;
    end;
  end;
  
End;

function TPerioTCPRdr.TransferRecords(Out Recs:TAccessRecords) : Boolean;
var 
  i :Integer;
Begin
  Result := (tcpTransferRecords(Recs)=0);
  if Result Then
  Begin
    case fwAppType of
      fwPDKS :
        Begin
          for I := 0 to recs.Count-1 do
          Begin
            recs.raDeviceRecs[i].PdksType := recs.raDeviceRecs[i].RFU[0];
            recs.raDeviceRecs[i].IOType := recs.raDeviceRecs[i].RFU[1];          
          End;
        end;
      fwYMK :
        Begin
          for I := 0 to recs.Count-1 do
          Begin
            recs.raDeviceRecs[i].Fee := recs.raDeviceRecs[i].RFU[0] 
               + recs.raDeviceRecs[i].RFU[1]*256;
            recs.raDeviceRecs[i].LastSessionId := recs.raDeviceRecs[i].RFU[0]
               + recs.raDeviceRecs[i].RFU[1]*256 + recs.raDeviceRecs[i].DoorNo*256*256;
            recs.raDeviceRecs[i].ReReadCnt := recs.raDeviceRecs[i].DoorNo;
          End;        
        end;
    end;
  end;  
End;

function TPerioTCPRdr.GetOutOfServiceHolidayList(out Holidays : THolidays) : Boolean;
Begin
  Result := (tcpGetOutOfServiceHolidayList(Holidays)=0);
End;

function TPerioTCPRdr.SetOutOfServiceHolidayList(Holidays : THolidays) : Boolean;
Begin
  Result := (tcpSetOutOfServiceHolidayList(Holidays)=0);
End;

function TPerioTCPRdr.SetAppFactoryDefault(Reboot:Boolean): Boolean;
Begin
  Result := (tcpSetAppFactoryDefault(Reboot)=0);
End;

function TPerioTCPRdr.GetWhitelisStatus(out WhiteListStatus:TWhiteListStatus):Boolean;
Begin
  Result := (tcpGetWhitelisStatus(WhiteListStatus)=0);
End;

function TPerioTCPRdr.SetWhitelisStatus(WhiteListStatus:TWhiteListStatus):Boolean;
Begin
  Result := (tcpSetWhitelisStatus(WhiteListStatus)=0);
End;

function TPerioTCPRdr.GetTreeNode(Address :Cardinal;out Node:Ttree_Node):Boolean;
Begin
  Result := (tcpGetTreeNode(Address,Node)=0);
End;

function TPerioTCPRdr.SetTreeNode(Node:Ttree_Node):Boolean;
Begin
  Result := (tcpSetTreeNode(Node)=0);
End;

function TPerioTCPRdr.GetStatusMode(out StatusMode :Byte;out StatusModeType :Byte):Boolean;
Begin
  Result := (tcpGetStatusMode(StatusMode,StatusModeType)=0);
End;

function TPerioTCPRdr.SetStatusMode(StatusMode :Byte;StatusModeType:byte):Boolean;
Begin
  Result := (tcpSetStatusMode(StatusMode,StatusModeType)=0);
End;

function TPerioTCPRdr.GetHGSSettings(out HGS_Settings:THGS_Settings):Boolean;
Begin
  Result := (tcpGetHGSSettings(HGS_Settings)=0);
End;

function TPerioTCPRdr.SetHGSSettings(HGS_Settings:THGS_Settings):Boolean;
Begin
  Result := (tcpSetHGSSettings(HGS_Settings)=0);
End;

function TPerioTCPRdr.AddHGSWhitelist(rArac: THGSArac;out IndexNum : Integer;IfExistEdit:Boolean=false) : Integer;
Var
  iErr,lclErr : Integer;
Begin
  try
    lclErr := IsHGSCardIDDaireAracExistInWhitelistX(rArac.CardID,
                rArac.Daire,rArac.AracNo,IndexNum);
    case lclErr of
      23 :
        Begin
          iErr := tcpAddHGSWhitelist(rArac,IndexNum);
          if (iErr <> 0) then
            DoLog(lgDebug,'AddHGSWhitelist(*)','Error  ('+IntToStr(iErr)+') CardID <'+rArac.CardID+'>',0);
            //LogDebug('AddHGSWhitelist(*)','Error  ('+IntToStr(iErr)+') CardID <'+rArac.CardID+'>',0);
        End;
      26:
        begin
           iErr := lclErr;
           DoLog(lgDebug,'AddHGSWhitelist','CardID Exists <'+rArac.CardID+'>  ',0);
           //LogDebug('AddHGSWhitelist','CardID Exists <'+rArac.CardID+'>  ',0);
           if IfExistEdit then
              iErr := EditHGSWhitelistWithCardID(rArac,IndexNum);
        end;
      else
        begin
           DoLog(lgDebug,'AddHGSWhitelist','Error  ('+IntToStr(lclErr)+') CardID <'+rArac.CardID+'>',0);
           //LogDebug('AddHGSWhitelist','Error  ('+IntToStr(lclErr)+') CardID <'+rArac.CardID+'>',0);
           iErr := lclErr;
        end;
      end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'AddHGSWhitelist', 'CardID <'+rArac.CardID+'> Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;


End;

function TPerioTCPRdr.AddHGSWhitelist(rArac: THGSArac;IfExistEdit:Boolean=false) : Integer;
Var
  InxNm:Integer;
Begin
  Result := AddHGSWhitelist(rArac,InxNm,IfExistEdit);
End;

function TPerioTCPRdr.GetHGSWhitelistWithCardID(CardID:String;out rArac: THGSArac) : Integer;
Var
  InxNum : Integer;
Begin
  Result := tcpGetHGSWhitelistWithCardID(CardID,rArac,InxNum) ;
End;

function TPerioTCPRdr.GetHGSWhitelistWithCardID(CardID:String;out rArac: THGSArac;out IndexNum : Integer) : Integer;
Begin
  Result := tcpGetHGSWhitelistWithCardID(CardID,rArac,IndexNum) ;
End;

function TPerioTCPRdr.EditHGSWhitelistWithCardID (rArac: THGSArac): Integer;
Var
  InxNum:Integer;
Begin
  Result := tcpEditHGSWhitelistWithCardID (rArac,InxNum);
End;

function TPerioTCPRdr.EditHGSWhitelistWithCardID (rArac: THGSArac;out IndexNum : Integer): Integer;
Begin
  Result := tcpEditHGSWhitelistWithCardID (rArac,IndexNum);
End;

function TPerioTCPRdr.DeleteHGSWhitelistWithCardID (CardID : String): Integer;
Var
  InxNum:Integer;
Begin
  Result := DeleteHGSWhitelistWithCardID(CardID,InxNum);
End;

function TPerioTCPRdr.DeleteHGSWhitelistWithCardID (CardID : String;out IndexNum : Integer): Integer;
Var
  iErr,lclErr : Integer;
Begin
  try
    lclErr := IsCardIDExistHGSInWhitelistX(CardID,IndexNum);
    case lclErr of
      0 :
        Begin
          iErr := 12;
          if (iErr <> 0) then
            DoLog(lgDebug,'DeleteHGSWhitelistWithCardID','Error  ('+IntToStr(lclErr)+') ',0);
            //LogDebug('DeleteHGSWhitelistWithCardID','Error  ('+IntToStr(lclErr)+') ',0);
        End;
      51:
        begin
          iErr := tcpDeleteHGSWhitelistWithCardID(CardID,IndexNum);
          if (iErr <> 0) then
            DoLog(lgDebug,'DeleteHGSWhitelistWithCardID','Error  ('+IntToStr(iErr)+') ',0);
            //LogDebug('DeleteHGSWhitelistWithCardID','Error  ('+IntToStr(iErr)+') ',0);
        end;
      else
        begin
           DoLog(lgDebug,'DeleteHGSWhitelistWithCardID','Error  ('+IntToStr(lclErr)+') ',0);
           //LogDebug('DeleteHGSWhitelistWithCardID','Error  ('+IntToStr(lclErr)+') ',0);
           iErr := lclErr;
        end;
      end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'DeleteHGSWhitelistWithCardID', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TPerioTCPRdr.IsCardIDExistHGSInWhitelist(CardID : String) : Boolean;
Var
  InxNum:Integer;
Begin
  Result := (tcpIsHGSCardIDExistInWhitelist(CardID,InxNum)=0);
End;

function TPerioTCPRdr.IsCardIDExistHGSInWhitelist(CardID : String;out IndexNum : Integer) : Boolean;
Begin
  Result := (tcpIsHGSCardIDExistInWhitelist(CardID,IndexNum)=0);
End;

function TPerioTCPRdr.IsCardIDExistHGSInWhitelistX(CardID : String) : Integer;
Var
  InxNum : Integer;
Begin
  Result := tcpIsHGSCardIDExistInWhitelist(CardID,InxNum);
End;

function TPerioTCPRdr.IsCardIDExistHGSInWhitelistX(CardID : String;out IndexNum : Integer) : Integer;
Begin
  Result := tcpIsHGSCardIDExistInWhitelist(CardID,IndexNum);
End;

function TPerioTCPRdr.GetHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte;out rArac: THGSArac) : Integer;
Var
  InxNum : Integer;
Begin
  Result := tcpGetHGSWhitelistWithDaireArac(DaireNo,AracNo,rArac,InxNum) ;
End;

function TPerioTCPRdr.GetHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte;out rArac: THGSArac;out IndexNum : Integer) : Integer;
Begin
  Result := tcpGetHGSWhitelistWithDaireArac(DaireNo,AracNo,rArac,IndexNum) ;
End;

function TPerioTCPRdr.DeleteHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Integer;
Var
  iErr,lclErr : Integer;
Begin
  try
    lclErr := IsHGSDaireAracExistInWhitelistX(DaireNo,AracNo,IndexNo);
    case lclErr of
      0 :
        Begin
          iErr := 12;
          if (iErr <> 0) then
            DoLog(lgDebug,'DeleteHGSWhitelistWithDaireArac','Error  ('+IntToStr(lclErr)+') ',0);
            //LogDebug('DeleteHGSWhitelistWithDaireArac','Error  ('+IntToStr(lclErr)+') ',0);
        End;
      51:
        begin
          iErr := tcpDeleteHGSWhitelistWithDaireArac(DaireNo,AracNo,IndexNo);
          if (iErr <> 0) then
            DoLog(lgDebug,'DeleteHGSWhitelistWithDaireArac','Error  ('+IntToStr(iErr)+') ',0);
            //LogDebug('DeleteHGSWhitelistWithDaireArac','Error  ('+IntToStr(iErr)+') ',0);
        end;
      else
        begin
           DoLog(lgDebug,'DeleteHGSWhitelistWithDaireArac','Error  ('+IntToStr(lclErr)+') ',0);
           //LogDebug('DeleteHGSWhitelistWithDaireArac','Error  ('+IntToStr(lclErr)+') ',0);
           iErr := lclErr;
        end;
      end;
  except
    on E: Exception do
    begin
      DoLog(lgError,'DeleteHGSWhitelistWithDaireArac', 'Exception Error : ' + E.Message);
      iErr := TErrors.EXCEPTION;
    end;
  end; // try
  Result := iErr;
end;

function TPerioTCPRdr.DeleteHGSWhitelistWithDaireArac(DaireNo : Word ;AracNo : Byte) : Integer;
Var
  InxNum:Integer;
Begin
  Result := DeleteHGSWhitelistWithDaireArac(DaireNo,AracNo,InxNum);
End;

function TPerioTCPRdr.IsHGSCardIDDaireAracExistInWhitelist(CardID : String; DaireNo : Word ;AracNo : Byte) : Boolean;
Var
  InxNum:Integer;
Begin
  Result := (tcpIsHGSCardIDDaireAracExistInWhitelist(CardID,DaireNo,AracNo,InxNum)=0);
End;

function TPerioTCPRdr.IsHGSCardIDDaireAracExistInWhitelist(CardID : String; DaireNo : Word ;AracNo : Byte;out IndexNum : Integer) : Boolean;
Begin
  Result := (tcpIsHGSCardIDDaireAracExistInWhitelist(CardID,DaireNo,AracNo,IndexNum)=0);
End;

function TPerioTCPRdr.IsHGSCardIDDaireAracExistInWhitelistX(CardID : String; DaireNo : Word ;AracNo : Byte) : Integer;
Var
  InxNum:Integer;
Begin
  Result := tcpIsHGSCardIDDaireAracExistInWhitelist(CardID,DaireNo,AracNo,InxNum);
End;

function TPerioTCPRdr.IsHGSCardIDDaireAracExistInWhitelistX(CardID : String; DaireNo : Word ;AracNo : Byte;out IndexNum : Integer) : Integer;
Begin
  Result := tcpIsHGSCardIDDaireAracExistInWhitelist(CardID,DaireNo,AracNo,IndexNum);
End;

function TPerioTCPRdr.IsHGSDaireAracExistInWhitelist(DaireNo : Word ;AracNo : Byte) : Boolean;
Var
  InxNum:Integer;
Begin
  Result := (tcpIsHGSDaireAracExistInWhitelist(DaireNo,AracNo,InxNum)=0);
End;

function TPerioTCPRdr.IsHGSDaireAracExistInWhitelist(DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Boolean;
Begin
  Result := (tcpIsHGSDaireAracExistInWhitelist(DaireNo,AracNo,IndexNo)=0);
End;

function TPerioTCPRdr.IsHGSDaireAracExistInWhitelistX(DaireNo : Word ;AracNo : Byte) : Integer;
Var
  InxNum:Integer;
Begin
  Result := tcpIsHGSDaireAracExistInWhitelist(DaireNo,AracNo,InxNum);
End;

function TPerioTCPRdr.IsHGSDaireAracExistInWhitelistX(DaireNo : Word ;AracNo : Byte;out IndexNo : Integer) : Integer;
Begin
  Result := tcpIsHGSDaireAracExistInWhitelist(DaireNo,AracNo,IndexNo);
End;

function TPerioTCPRdr.ReadHGSRecords(StartFrom,HowMany:Cardinal;out Recs:THGSRecords) : Boolean;
Begin
  Result := (tcpReadHGSRecords(StartFrom,HowMany,Recs)=0);
End;

function TPerioTCPRdr.TransferHGSRecords(Out Recs:THGSRecords) : Boolean;
Begin
 Result := (tcpTransferHGSRecords(Recs)=0);
End;

function TPerioTCPRdr.GetHGSDaireParkHak(rDaire:word;out rHak:Byte) : Boolean;
Begin
  Result := (tcpGetHGSDaireParkHak(rDaire,rHak)=0);
End;

function TPerioTCPRdr.GetHGSDaireParkHak(rDaire:word) : Byte;
Var
  lHak : Byte;
Begin
  if GetHGSDaireParkHak(rDaire,lHak) then
    Result := lHak
  else
    Result := 255;
End;

function TPerioTCPRdr.SetHGSDaireParkHak(rDaire:word;rHak:Byte) : Boolean;
Begin
  Result := (tcpSetHGSDaireParkHak(rDaire,rHak)=0);
End;

function TPerioTCPRdr.SetTumAralarDisarda : Boolean;
Begin
  Result := (tcpSetTumAralarDisarda=0);
End;

function TPerioTCPRdr.GetTagListToFile(aFileName : String;StartPage:Integer=1034;EndPage:Integer=1233):Boolean;
Var
  Data,FileData : TStringlist;
  HexStr,HgsStr,tmpStr,PlakaNo: String;
  i,j,DaireNo,AracNo:Integer;
  rRet:Boolean;
Begin
  rRet := False;
  try
    Data := TStringlist.Create;
    FileData := TStringlist.Create;
    for I := StartPage to EndPage do
    Begin
      if ReadPageData(i, HexStr) then
      Begin
        for j := 0 to 11 do
        Begin
          HgsStr := Copy(HexStr,j*88+1,88);
          if CompareStr(HgsStr,'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF')<>0 then
            Data.Add(HgsStr);
        End;
        rRet := True;
      End
      else
      Begin
        rRet := False;
        break;
      End;
    End;
    if rRet then
    Begin
      for I := 0 to Data.Count-1 do
      Begin
        DaireNo := HexToByte(copy(Data.Strings[i],67,2))
        + HexToByte(copy(Data.Strings[i],69,2))*256;
        AracNo:= HexToByte(copy(Data.Strings[i],71,2));

        if CompareStr(copy(Data.Strings[i],17,36),'000000000000000000000000000000000000')<>0 then
          PlakaNo := prHexStrToStr(copy(Data.Strings[i],17,36))
        else
          PlakaNo := '';
        tmpStr := copy(Data.Strings[i],1,16)+';'
          + IntToStr(Daireno)+';'
          + IntToStr(AracNo)+';'
          + PlakaNo+';';

        FileData.Add(tmpStr);
      End;
      FileData.SaveToFile(aFileName);
    End;
  finally
    Data.Free;
    FileData.Free;
  end;
  Result := rRet;
End;


function TPerioTCPRdr.GetYmkSettings(out rSettings :TYmkSettings) : Boolean;
Begin
  Result := (tcpGetYmkSettings(rSettings)=0);
End;

function TPerioTCPRdr.SetYmkSettings(rSettings :TYmkSettings) : Boolean;
Begin
  Result := (tcpSetYmkSettings(rSettings)=0);
End;

function TPerioTCPRdr.GetMealTable(out rSettings :TMealTable) : Boolean;
Begin
  Result := (tcpGetMealTable(rSettings)=0);
End;

function TPerioTCPRdr.SetMealTable(rSettings :TMealTable) : Boolean;
Begin
  Result := (tcpSetMealTable(rSettings)=0);
End;

function TPerioTCPRdr.GetMealRigthTable(TableNo : Byte ;out rSettings :TWeaklyMealRight) : Boolean;
Begin
  Result := (tcpGetMealRigthTable(TableNo,rSettings)=0);
End;

function TPerioTCPRdr.SetMealRigthTable(TableNo : Byte ;rSettings :TWeaklyMealRight) : Boolean;
Begin
  Result := (tcpSetMealRigthTable(TableNo,rSettings)=0);
End;

function TPerioTCPRdr.GetPriceListTable(TableNo : Byte ;out rSettings :TPriceList) : Boolean;
Begin
  Result := (tcpGetPriceListTable(TableNo,rSettings)=0);
End;

function TPerioTCPRdr.SetPriceListTable(TableNo : Byte ;rSettings :TPriceList) : Boolean;
Begin
  Result := (tcpSetPriceListTable(TableNo,rSettings)=0);
End;

function TPerioTCPRdr.SetYmkFactoryDefaults(Reboot : Boolean):Boolean;
Begin
  Result := (tcpSetYmkFactoryDefaults(Reboot)=0);
End;

function TPerioTCPRdr.GetPersonYmkSettingList(ListNo : Byte ;out rSettings :TPersonMealSetting) : Boolean;
Begin
  Result := (tcpGetPersonYmkSettingList(ListNo,rSettings)=0);
End;

function TPerioTCPRdr.SetPersonYmkSettingList(ListNo : Byte ;rSettings :TPersonMealSetting) : Boolean;
Begin
  Result := (tcpSetPersonYmkSettingList(ListNo,rSettings)=0);
End;

function TPerioTCPRdr.GetStaticMealRightList(ListNo : Byte ;out rSettings :TDailyMealRight) : Boolean;
Begin
  Result := (tcpGetStaticMealRightList(ListNo,rSettings)=0);
End;

function TPerioTCPRdr.SetStaticMealRightList(ListNo : Byte ;rSettings :TDailyMealRight) : Boolean;
Begin
  Result := (tcpSetStaticMealRightList(ListNo,rSettings)=0);
End;

function TPerioTCPRdr.GetMonthlyMealRightList(CardID : String;DayNo : Byte ;out rSettings :TDailyMealRight) : Boolean;
Begin
  Result := (tcpGetMonthlyMealRightList(CardID,DayNo,rSettings)=0);
End;

function TPerioTCPRdr.SetMonthlyMealRightList(CardID : String;DayNo : Byte ;rSettings :TDailyMealRight) : Boolean;
Begin
  Result := (tcpSetMonthlyMealRightList(CardID,DayNo,rSettings)=0);
End;

function TPerioTCPRdr.GetMealNameList(out Names : TMealNameList) : Boolean;
Begin
  Result := (tcpGetMealNameList(Names)=0);
End;

function TPerioTCPRdr.SetMealNameList(Names : TMealNameList) : Boolean;
Begin
  Result := (tcpSetMealNameList(Names)=0);
End;

function TPerioTCPRdr.GetPersonCommands(CardID : String;out CommandList : TPersonCommandList) : Boolean;
Begin
  Result := (tcpGetPersonCommands(CardID,CommandList)=0);
End;

function TPerioTCPRdr.SetPersonCommands(CardID : String;CommandList : TPersonCommandList) : Boolean;
Begin
  Result := (tcpSetPersonCommands(CardID,CommandList)=0);
End;

function TPerioTCPRdr.DisablePersCommands(CardID : String) : Boolean;
Begin
  Result := (tcpDisablePersCommands(CardID)=0);
End;

function TPerioTCPRdr.GetPersonTZList(CardID : String;out PersTZList : TPersTZList) : Boolean;
Begin
  Result := (tcpGetPersonTZList(CardID,PersTZList)=0);
End;

function TPerioTCPRdr.SetPersonTZList(CardID : String;PersTZList : TPersTZList): Boolean;
Begin
  Result := (tcpSetPersonTZList(CardID,PersTZList)=0);
End;

end.
