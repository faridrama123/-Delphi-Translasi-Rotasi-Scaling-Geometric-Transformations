unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, ExtCtrls, Menus, ActnList, jpeg;
  Const N = 3;

type
  Matrik33 = array [1..3,1..3] of Real;
  Matrik3N = array [1..3,1..N] of Real;
  TForm2 = class(TForm)
    eNilaiB: TEdit;
    eNilaiA: TEdit;
    Button1: TButton;
    Button2: TButton;
    StringGrid1: TStringGrid;
    BitBtn1: TBitBtn;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    StringGrid2: TStringGrid;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Image1: TImage;
    Image2: TImage;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Obyek2D(Sender: TObject; var Obyek:Matrik3N);
    procedure MatrikTranslasi2D(Sender: TObject; var Tv: Matrik33; a,b:real);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure Image2Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure Label15Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
 // Tv: Matrik33;
  a,b :real;
  Obyek:Matrik3N;
  x0, y0 : integer;
  ShowMenu: integer;

implementation

uses Unit1, Unit3;

{$R *.dfm}


procedure TForm2.Obyek2D (Sender: TObject; var Obyek:Matrik3N);
var
i,j :Integer;
begin
  for i := 1 to 2 do
    for j := 1 to N do
    Obyek [i,j]:=StrToFloat (StringGrid1.Cells[j,i-1]);
    for j := 1 to N do
    Obyek [3,j] := 1;

end;


procedure TForm2.MatrikTranslasi2D  (Sender: TObject;var Tv : Matrik33; a,b :real);
begin
a := StrToFloat(eNilaiA.Text);
b := StrToFloat(eNilaiB.Text);
Tv[1,1]:=1; Tv[1,2]:=0; Tv[1,3]:=a;
Tv[2,1]:=0; Tv[2,2]:=1; Tv[2,3]:=b;
Tv[3,1]:=0; Tv[3,2]:=0; Tv[3,3]:=1;
end;

procedure MatrikKaliTransformasiObyek2D( var Obyek: Matrik3N; Tr : Matrik33);
var
   i,j,k : integer;
   Hasil : Matrik3N;
begin
for i := 1 to 3 do
for k := 1 to N do
begin
Hasil[i,k]:=0;
for j := 1 to 3 do
Hasil[i,k]:= Hasil[i,k] + Tr[i,j] * Obyek[j,k];
end;
Obyek := Hasil;
end;



procedure TForm2.FormPaint(Sender: TObject);
var k:integer;

begin


     for k:= 180 to (ClientWidth) do // sumbu x
     Canvas.Pixels[k,y0] := clBlue;
     for k:= 0 to (ClientHeight) do // sumbu y
     Canvas.Pixels [x0,k]:= clRed;

end;


procedure TForm2.FormCreate(Sender: TObject);

begin
Canvas.pen.Color := clBlack;
    x0 := ClientWidth div 2;
     y0 := ClientHeight   div 2;
     StringGrid1.Cells[1,0] := '30';
     StringGrid1.Cells[1,1] := '30';

     StringGrid1.Cells[2,0] := '120';
     StringGrid1.Cells[2,1] := '30';

     StringGrid1.Cells[3,0] := '30';
     StringGrid1.Cells[3,1] := '120';

     eNilaiA.Text := '0';
     eNilaiB.Text := '0';

    Label4.Visible := false;
   Label5.Visible := false;
   Label6.Visible := false;

      Label4.Font.Color := clGreen;
   Label5.Font.Color := clGreen;
   Label6.Font.Color := clGreen;


           Label12.Visible := false;
   Label13.Visible := false;
   Label14.Visible := false;
   Label15.Visible := false;


Timer1.Enabled := True;

end;

procedure TForm2.Button1Click(Sender: TObject);
var Obyek:Matrik3N;
begin
  Obyek2D(Sender,Obyek);
  Canvas.MoveTo(trunc(X0 + Obyek [1,1]), trunc(Y0 - Obyek[2,1]));
  Canvas.LineTo(trunc(X0 + Obyek [1,2]), trunc(Y0 - Obyek[2,2]));
  Canvas.MoveTo(trunc(X0 + Obyek [1,2]), trunc(Y0 - Obyek[2,2]));
  Canvas.LineTo(trunc(X0 + Obyek [1,3]), trunc(Y0 - Obyek[2,3]));
  Canvas.MoveTo(trunc(X0 + Obyek [1,3]), trunc(Y0 - Obyek[2,3]));
  Canvas.LineTo(trunc(X0 + Obyek [1,1]), trunc(Y0 - Obyek[2,1]));
end;

procedure TForm2.Button2Click(Sender: TObject);
var
 Obyek:Matrik3N;
Tv : Matrik33;
a,b : real;
var x1,x2,x3,y1,y2,y3 :integer;
var xx1,xx2,xx3,yy1,yy2,yy3 :integer;
begin
 Obyek2D(Sender,Obyek);
 MatrikTranslasi2D(Sender,Tv, a,b);
 MatrikKaliTransformasiObyek2D(Obyek,Tv);
  canvas.pen.Color := clGreen;
  Canvas.MoveTo(trunc(X0 + Obyek [1,1]), trunc(Y0 - Obyek[2,1]));
  Canvas.LineTo(trunc(X0 + Obyek [1,2]), trunc(Y0 - Obyek[2,2]));
  Canvas.MoveTo(trunc(X0 + Obyek [1,2]), trunc(Y0 - Obyek[2,2]));
  Canvas.LineTo(trunc(X0 + Obyek [1,3]), trunc(Y0 - Obyek[2,3]));
  Canvas.MoveTo(trunc(X0 + Obyek [1,3]), trunc(Y0 - Obyek[2,3]));
  Canvas.LineTo(trunc(X0 + Obyek [1,1]), trunc(Y0 - Obyek[2,1]));




   y1:= trunc(Y0 - Obyek [2,1]) ;
   y2:= trunc(Y0 - Obyek [2,2]) ;
   y3:= trunc(Y0 - Obyek [2,3]) ;
   x1:= trunc(X0 + Obyek [1,1]) ;
   x2:= trunc(X0 + Obyek [1,2]) ;
   x3:= trunc(X0 + Obyek [1,3]) ;

      Label4.Left := x1-10;
   Label4.Top := y1+5;
   Label5.Left := x2;
   Label5.Top := y2+5;
   Label6.Left := x3;
   Label6.Top := y3-15;


   Label4.Visible := true;
   Label5.Visible := true;
   Label6.Visible := true;

   xx1 := strtoint(StringGrid1.Cells[1,0])+ strtoint(eNilaiA.Text);
   xx2 := strtoint(StringGrid1.Cells[2,0])+ strtoint(eNilaiA.Text);
   xx3 := strtoint(StringGrid1.Cells[3,0])+ strtoint(eNilaiA.Text);

   yy1 := strtoint(StringGrid1.Cells[1,1])+ strtoint(eNilaiB.Text);
   yy2 := strtoint(StringGrid1.Cells[2,1])+ strtoint(eNilaiB.Text);
   yy3 := strtoint(StringGrid1.Cells[3,1])+ strtoint(eNilaiB.Text);

      Label4.Caption := 'x1, y1('+inttostr(xx1)+','+inttostr(yy1)+')';
    Label5.Caption := 'x2, y2('+inttostr(xx1)+','+inttostr(yy1)+')';
      Label6.Caption := 'x3, y3('+inttostr(xx1)+','+inttostr(yy1)+')';

end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
form1.Refresh;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
   with StringGrid1 do begin
   Cells[0,0]:= '    X  ';
   Cells[0,1]:= '    Y  ';
   end;

     with StringGrid2 do begin
   Cells[0,0]:= '    1  ';
   Cells[1,0]:= '    2  ';
   Cells[2,0]:= '    3  ';
   end;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var x1,x2,x3,y1,y2,y3 :integer;
var time: integer;
begin


    Obyek2D(Sender,Obyek);

     y1:= trunc(Y0 - Obyek [2,1]) ;
   y2:= trunc(Y0 - Obyek [2,2]) ;
   y3:= trunc(Y0 - Obyek [2,3]) ;
   x1:= trunc(X0 + Obyek [1,1]) ;
   x2:= trunc(X0 + Obyek [1,2]) ;
   x3:= trunc(X0 + Obyek [1,3]) ;

   Label1.Left := x1-10;
   Label1.Top := y1+5;
   Label2.Left := x2;
   Label2.Top := y2+5;
   Label3.Left := x3;
   Label3.Top := y3-15;



  Label1.Caption := 'x1, y1('+StringGrid1.Cells[1,0]+','+StringGrid1.Cells[1,1]+')';
    Label2.Caption := 'x2, y2('+StringGrid1.Cells[2,0]+','+StringGrid1.Cells[2,1]+')';
      Label3.Caption := 'x3, y3('+StringGrid1.Cells[3,0]+','+StringGrid1.Cells[3,1]+')';


  Canvas.MoveTo(trunc(X0 + Obyek [1,1]), trunc(Y0 - Obyek[2,1]));
  Canvas.LineTo(trunc(X0 + Obyek [1,2]), trunc(Y0 - Obyek[2,2]));
  Canvas.MoveTo(trunc(X0 + Obyek [1,2]), trunc(Y0 - Obyek[2,2]));
  Canvas.LineTo(trunc(X0 + Obyek [1,3]), trunc(Y0 - Obyek[2,3]));
  Canvas.MoveTo(trunc(X0 + Obyek [1,3]), trunc(Y0 - Obyek[2,3]));
  Canvas.LineTo(trunc(X0 + Obyek [1,1]), trunc(Y0 - Obyek[2,1]));
     Timer1.Enabled:= false;

end;



procedure TForm2.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
 form2.Refresh;
     Label4.Visible := false;
   Label5.Visible := false;
   Label6.Visible := false;

 Timer1.Enabled:= true;

    canvas.pen.Color := clBlack;
end;

procedure TForm2.Image2Click(Sender: TObject);


begin
 ShowMenu := ShowMenu +1;
 if ShowMenu mod 2= 0  then
     begin
   Label12.Visible := false;
   Label13.Visible := false;
   Label14.Visible := false;
   Label15.Visible := false;

   Label11.Visible := true; //

     end
 else
       begin
       Label11.Visible := false;  //
             Label12.Visible := true;
   Label13.Visible := true;
   Label14.Visible := true;
   Label15.Visible := true;


       end
end;


procedure TForm2.Label12Click(Sender: TObject);
begin
Form2.Hide;
Form3 := TForm3.Create(Application);
Form3.Show;

end;

procedure TForm2.Label13Click(Sender: TObject);
begin
Form2.Hide;
Form1 := TForm1.Create(Application);
Form1.Show;

end;

procedure TForm2.Label15Click(Sender: TObject);
begin
Application.Terminate()
end;

end.
