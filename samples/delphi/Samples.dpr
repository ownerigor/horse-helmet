program Samples;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  System.JSON,
  Horse.Helmet in 'src\Horse.Helmet.pas';

begin
  THorse.Use(Helmet);

  THorse.Get('/users',
    procedure(Req: THorseRequest; Res: THorseResponse;  Next: TProc)
    var
      LUser: TJSONObject;
      LUsers: TJSONArray;
    begin
      LUser := TJSONObject.Create
        .AddPair('name', 'Igor')
        .AddPair('login', 'igor.queirantes');
      LUsers := TJSONArray.Create(LUser);
      Res.Send<TJSONArray>(LUsers);
    end);

  THorse.Listen(9000,
    procedure
    begin
      Writeln('Server is runing on port 9000...');
      Readln;
    end);
end.
