(**************************************************************************
 * Perio Key Encryption Library ver. 1                                      *
 *                                                                        *
 *   for Delphi 5, 6, 7, 2007-2010,XE,XE2                                 *
 *                                                                        *
 *  Mifare Kart Masterkey þifreleri ve Cihaz ile haberleþme  þifreleri    *
 *     encrypt edilerek kullanýlýyor                                      *
 **************************************************************************)
unit PerioDevice.Encryption;
///////////////////////////////////////////////////////////////////////////
///
///  (+) Eklendi
///  (-) Silindi
///  (*) Bug düzeltme yada Uyarý
///  (/) Deðiþiklik Yapýldý
///
///////////////////////////////////////////////////////////////////////////
///
///
///////////////////////////////////////////////////////////////////////////
interface

uses Math,SysUtils,DateUtils,ElAES,PerioDevice;

  function EncryptDeviceKey(Key:array of Byte; out EncryptedKey:array of byte):Integer;
  function PrepareLoginDataPR0(Key:array of Byte;out SessionID :word;Out LoginData:TDataByte):Integer;
  function EncryptMfrKeyData(Data:array of Byte; out EncryptedData:array of byte):Integer;
  function DecryptMfrKeyData(EncryptedData:array of Byte; out Data:array of byte):Integer;

implementation

function  GetSessionID:Integer;
Begin
  Result:=RandomRange(256,65535);
End;

function  GetRandomByte:byte;
Begin
  Result:=RandomRange(0,255);
End;

function EncryptDeviceKey(Key:array of Byte; out EncryptedKey:array of byte):Integer;
var
  iErr,i:Integer;
  expKey: TAESExpandedKey128;
  inArray,outArray: TAESBuffer;
  const aesKey:TAESKey128
    = ( $A0,$BF,$54,$31,$A4,$69,$81,$4C,$56,$DF,$DF,$A3,$7D,$F3,$A9,$9C);
    //  = ( $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF);
begin
  iErr := 0;
  try
    for i := 0 to Length(Key)-1 do
      inArray[i]:=Key[i];
    ExpandAESKeyForEncryption(aeskey,expKey);
    EncryptAES(inArray,expKey,outArray);
    for i := 0 to Length(outArray)-1 do
      EncryptedKey[i]:=outArray[i];
  except
    iErr := -1;
  end;
  Result := iErr;
end;

function EncryptMfrKeyData(Data:array of Byte; out EncryptedData:array of byte):Integer;
var
  iErr,i,k:Integer;
  expKey: TAESExpandedKey128;
  inArray,outArray: TAESBuffer;
  const aesKey:TAESKey128
    =( $42,$CF,$54,$A9,$A4,$07,$81,$4C,$59,$7F,$DF,$A3,$7D,$Fe,$A9,$9C );
begin
  iErr := 0;
  try
    for k := 0 to 11 do
    Begin
      for i := 0 to 15 do
        inArray[i]:=Data[i+k*16];
      ExpandAESKeyForEncryption(aeskey,expKey);
      EncryptAES(inArray,expKey,outArray);
      for i := 0 to 15 do
        EncryptedData[i+k*16] := outArray[i];
    End;
  except
    iErr := -1;
  end;
  Result := iErr;
end;

function DecryptMfrKeyData(EncryptedData:array of Byte; out Data:array of byte):Integer;
var
  iErr,i,k:Integer;
  expKey: TAESExpandedKey128;
  inArray,outArray: TAESBuffer;
  const aesKey:TAESKey128
    =( $42,$CF,$54,$A9,$A4,$07,$81,$4C,$59,$7F,$DF,$A3,$7D,$Fe,$A9,$9C );
begin
  iErr := 0;
  try
    for k := 0 to 11 do
    Begin
      for i := 0 to 15 do
        inArray[i]:=EncryptedData[i+k*16];
      ExpandAESKeyForDecryption(aeskey,expKey);
      DecryptAES(inArray,expKey,outArray);
      for i := 0 to 15 do
        Data[i+k*16]:=outArray[i];
    End;
  except
    iErr := -1;
  end;
  Result := iErr;
end;

function PrepareLoginDataPR0(Key:array of Byte;out SessionID :word;Out LoginData:TDataByte):Integer;
var
  iErr,i:Integer;
Begin
  try
    iErr := 0;
    SessionID := GetSessionID;
    for I := 0 to 31 do
      LoginData[i] := GetRandomByte;
    LoginData[3] := SessionID mod 256;
    for I := 10 to 25 do
      LoginData[i] := Key[i-10];
    LoginData[27] := SessionID div 256;
  except
    iErr := -1;
  end;
  Result := iErr;
end;

end.
