unit Perio.Global;

interface

uses
  System.SysUtils ,
  System.StrUtils ,
  System.DateUtils ;

const
  field_separator_ = chr(31);
  record_separator_ = chr(30);
  PerioNullDate = 73050;
  
type
  TLanguage = (langTR, langEN);
  TServerConnectionType = (sctClientServer, sctRestService);
  TClientRestType = (crtLocalDB,crtMemoryDB);
  TPerioApplicationType = (prWinApp,prWinService);

  TprRecMode = (prAdd,prEdit,prCloneAdd);

  TprLogLevel = (lgDebug, lgVerbose, lgMessage, lgWarning, lgError, lgFatal);
  TprLogEvent = procedure(Sender: TObject; const Log: string) of object;

  function prMin(const AValueOne, AValueTwo: Int64): Int64; overload;
  function prMin(const AValueOne, AValueTwo: LongInt): LongInt; overload;
  function prMin(const AValueOne, AValueTwo: Word): Word; overload;
  function prMax(const AValueOne, AValueTwo: Int64): Int64; overload;
  function prMax(const AValueOne, AValueTwo: LongInt): LongInt; overload;
  function prMax(const AValueOne, AValueTwo: Word): Word; overload;

  function prLength(const ABuffer: String; const ALength: Integer = -1; const AIndex: Integer = 1): Integer; overload;
  function prLength(const ABuffer: array of Byte; const ALength: Integer = -1; const AIndex: Integer = 0): Integer; overload;

  function IsNum(const AChar: Char): Boolean;overload;
  function IsNum(const AString: String): Boolean;overload;
  function IsHex(const AChar: Char): Boolean; overload;
  function IsHex(const AString: string; const ALength: Integer = -1; const AIndex: Integer = 1): Boolean; overload;
  function isIP(Ip:String):Boolean;

  function GetAppParamValue(Key : String;KeyOnly : Boolean = True):string;

  function Get_Next_From_Rowtext(Var rowtext_, Name_, Value_: String): Boolean;
  function StrToDateTime_rowtext(sDT: String): TDateTime;
  function DateTimeToStrPerio(Value : TDateTime):string;
  function GetLanguage(iValue : string):TLanguage;

implementation

function GetLanguage(iValue : string):TLanguage;
Begin
  if iValue = 'EN' then
    Result := langEN
  else
    Result := langTR;
End;

function prMin(const AValueOne, AValueTwo: LongInt): LongInt;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne > AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function prMin(const AValueOne, AValueTwo: Int64): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne > AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function prMin(const AValueOne, AValueTwo: Word): Word;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne > AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function prMax(const AValueOne, AValueTwo: Int64): Int64;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne < AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function prMax(const AValueOne, AValueTwo: LongInt): LongInt;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne < AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function prMax(const AValueOne, AValueTwo: Word): Word;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  if AValueOne < AValueTwo then begin
    Result := AValueTwo;
  end else begin
    Result := AValueOne;
  end;
end;

function prLength(const ABuffer: String; const ALength: Integer = -1; const AIndex: Integer = 1): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LAvailable: Integer;
begin
  Assert(AIndex >= 1);
  LAvailable := prMax(Length(ABuffer)-AIndex+1, 0);
  if ALength < 0 then begin
    Result := LAvailable;
  end else begin
    Result := prMin(LAvailable, ALength);
  end;
end;

function prLength(const ABuffer: array of Byte; const ALength: Integer = -1; const AIndex: Integer = 0): Integer;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  LAvailable: Integer;
begin
  Assert(AIndex >= 0);
  LAvailable := prMax(Length(ABuffer)-AIndex, 0);
  if ALength < 0 then begin
    Result := LAvailable;
  end else begin
    Result := prMin(LAvailable, ALength);
  end;
end;

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

function IsNum(const AChar: Char): Boolean;overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  // Do not use IsCharAlpha or IsCharAlphaNumeric - they are Win32 routines
  Result := (AChar >= '0') and (AChar <= '9'); {Do not Localize}
end;

function IsNum(const AString: String): Boolean;overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
Var
  i,len : Integer;
begin
  Len := length(AString);
  if Len>0 then
  Begin
    for i := 0 to Len-1 do
    begin
      if IsNum(AString[i+1]) then
        Result := True
      else
      Begin
        Result := false;
        Break;
      end;
    end;
  End
  else
    result := False;
end;

function IsHex(const AChar: Char): Boolean; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := IsNum(AChar)
   or ((AChar >= 'A') and (AChar <= 'F')) {Do not Localize}
   or ((AChar >= 'a') and (AChar <= 'f')); {Do not Localize}
end;

function IsHex(const AString: string; const ALength: Integer = -1; const AIndex: Integer = 1): Boolean; overload;
{$IFDEF USE_INLINE}inline;{$ENDIF}
var
  i: Integer;
  LLen: Integer;
begin
  Result := False;
 {$IFDEF MSWINDOWS}
  LLen := prLength(AString, ALength, AIndex);
  if LLen > 0 then begin
    for i := 0 to LLen-1 do begin
      if not IsHex(AString[AIndex+i]) then begin
        Exit;
      end;
    end;
    Result := True;
  end;
 {$ELSE}
  Result := True;
 {$ENDIF}

end;

function GetAppParamValue(Key : String;KeyOnly : Boolean = True):string;
var
  Docontinue : Boolean;
  i : integer;
  Param : string ;
  sKey : string ;
  DelimEquel,DelimDot : Integer;
  ParamDelimPos : Integer;
  ParamDelim : string;
Begin
  Result := '';
  Docontinue := False;
  if ParamCount > 0 then
  Begin
    for I := 0 to ParamCount do
    Begin
      Param := UpperCase(ParamStr(i));
      sKey := UpperCase(Key);
      if KeyOnly then
      Begin
        if Param.Contains(sKey) then
          Result := Key;
      End
      else
      begin
        Docontinue :=(Param.StartsWith('/') or Param.StartsWith('--')or Param.StartsWith('-'));
        if Docontinue then
        Begin
          DelimEquel := pos('=',Param);
          DelimDot := pos(':',Param);
          Docontinue := (DelimEquel > 0) or (DelimDot > 0);
        End;

        if Docontinue then
          Docontinue := not ((DelimEquel > 0) and (DelimDot > 0));

        if (DelimEquel > 0) and (DelimDot > 0) then
          Docontinue := False
        else if (DelimEquel > 0) then
          ParamDelimPos := DelimEquel
        else if (DelimDot > 0) then
          ParamDelimPos := DelimDot
        else
          Docontinue := False;

        if Docontinue then
        Begin
          if sKey.Compare(sKey,Copy(Param,2,ParamDelimPos-2))=0 then
          Begin
            Result := Copy(ParamStr(i),ParamDelimPos+1,length(param)-ParamDelimPos);
            Break;
          End;
        End;
      end;
    End;
  End;
End;

function isIP(Ip:String):Boolean;
  function DotControl(IP:String):Boolean;
  var
    position,Len,DotCnt,LastDot : Integer;
  Begin
    DotCnt := 0;
    Len := length(IP);
    LastDot := LastDelimiter('.',IP);
    position := PosEx('.',IP,1);
    DotCnt := Occurrences('.',IP);
    if (position = 0) or (position = 1 )
       or (LastDot = Len ) or (DotCnt <> 3 ) then
      Result := false
    else
      Result := True;
  End;
Var
 IPArr:String;
 i,Start,Position,IPn:Integer;
Begin

  if DotControl(IP) then
  Begin
    Start := 1;
    for I := 0 to 3 do
    begin
      Position := PosEx('.',IP,start);
      if Position <> 0 then
        IPArr := copy(IP,Start,Position-Start)
      else
        IPArr := copy(IP,Start,length(IP)-Start+1);
      start := Position+1;
      if IsNum(IPArr) then
      Begin
        IPn := StrToInt(IPArr);
        if (( IPn>=0) and (IPn <= 255)) then
          Result := True
        else
        begin
          Result := false;
          Break;
        end;
      end
      else
      Begin
        Result := false;
        Break;
      end;
    end;
  end
  else
    Result := false;
End;

function Get_Next_From_Rowtext(Var rowtext_, Name_, Value_: String): Boolean;
Var
  From_, to_, index_: Integer;
Begin
  From_ := 1;
  to_ := pos(record_separator_, rowtext_);
  if to_ > 0 then
  Begin
    index_ := pos(field_separator_, rowtext_);
    Name_ := copy(rowtext_, From_, index_ - From_);
    Value_ := copy(rowtext_, index_ + 1, to_ - index_ - 1);
    rowtext_ := copy(rowtext_, to_ + 1, length(rowtext_) - to_);
    result := True;
  end
  else
    result := False;
end;

function StrToDateTime_rowtext(sDT: String): TDateTime;
Var
  AYear, AMonth, ADay, AHour, AMinute, ASecond: Word;
Begin
  AYear := StrToInt(copy(sDT, 1, 4));
  AMonth := StrToInt(copy(sDT, 5, 2));
  ADay := StrToInt(copy(sDT, 7, 2));
  AHour := StrToInt(copy(sDT, 9, 2));
  AMinute := StrToInt(copy(sDT, 11, 2));
  ASecond := StrToInt(copy(sDT, 13, 2));
  if ASecond = 60 then
  Begin
    AMinute := AMinute + 1;
    ASecond := 0;
  End;
  result := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, 0);
End;

function DateTimeToStrPerio(Value : TDateTime):string;
Var
  AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
Begin
  DecodeDateTime(Value, AYear, AMonth, ADay, AHour, AMinute, ASecond,
    AMilliSecond);
  Result := Format('%.4d', [AYear]) + Format('%.2d', [AMonth]) +
    Format('%.2d', [ADay]) + Format('%.2d', [AHour]) + Format('%.2d', [AMinute])
    + Format('%.2d', [ASecond]);
End;


end.