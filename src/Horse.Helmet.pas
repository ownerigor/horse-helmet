unit Horse.Helmet;

interface

uses
{$IF DEFINED(FPC)}
  SysUtils,
  StrUtils,
{$ELSE}
  System.StrUtils,
  System.SysUtils,
  System.JSON,
{$ENDIF}
  Horse;

  type
    TContentSecurityPolicy = record
      DefaultSrc: string;
      ScriptSrc: string;
      StyleSrc: string;
    end;

procedure Helmet(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);

implementation

function ReturnDefaultHeadersCSP(const AHttps: string): string;
begin
  Result := 'default-src ''self''; script-src ''self'' :https; style-src ''self'' :https';
  Result := StringReplace(Result, ':https', AHttps, [rfReplaceAll, rfIgnoreCase]);
end;

procedure Helmet(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
const
  CONTENT_CSP = 'Content-Security-Policy';
begin

  Next;

  //Default headers for CSP
  if Res.RawWebResponse.GetCustomHeader(CONTENT_CSP).IsEmpty then
  begin
    Res.RawWebResponse.SetCustomHeader(CONTENT_CSP, ReturnDefaultHeadersCSP('localhost:9000'));
  end;
end;

end.

