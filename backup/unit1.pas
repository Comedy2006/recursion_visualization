unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Spin, Math,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    SpinEdit1: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure cantor(steps, x, y, size: integer);
begin
  if steps > 0 then begin
    dec(steps);
    size := size div 3; // we need 3 rows ==> we need to divide by 3
    // top
    cantor(steps, x, y, size);
    cantor(steps, x+2*size, y, size);
    y += size*2;
    //bottom
    cantor(steps, x, y, size);
    cantor(steps, x+2*size, y, size);
  end
  else
      form1.image1.canvas.fillrect(x,y,x+size,y+size);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  image1.canvas.brush.color := clWhite;
  image1.canvas.fillrect(0, 0, image1.height, image1.width);
  image1.canvas.brush.color := clBlack;

  cantor(SpinEdit1.Value, 0, 0, 600 {height & width});
end;

procedure sierpinski(steps, x, y, size: integer);
begin
  if steps > 0 then begin
    dec(steps);
    size := size div 3;
    // upper
    sierpinski(steps, x, y, size);
    sierpinski(steps, x+size, y, size);
    sierpinski(steps, x+2*size, y, size);
    // mid
    y += size;
    sierpinski(steps, x, y, size);
    sierpinski(steps, x+2*size, y, size);
    // lower
    y += size;
    sierpinski(steps, x, y, size);
    sierpinski(steps, x+size, y, size);
    sierpinski(steps, x+2*size, y, size);
  end
  else
      form1.image1.canvas.FillRect(x, y, x+size, y+size);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  image1.canvas.brush.color := clWhite;
  image1.canvas.fillrect(0, 0, image1.height, image1.width);
  image1.canvas.brush.color := clBlack;

  sierpinski(SpinEdit1.Value, 0, 0, 600);
end;

procedure koch(steps: integer;  x, y, L, a: double);
var
  xE, yE: double;
begin
  if steps > 0 then begin
    dec(steps);
    L /= 3;
    //first 3rd
    koch(steps, x, y, L, a);
    //second 3rd
    xE := x + L * cos(degtoRad(a));
    yE := y + L * sin(degtoRad(a));
    koch(steps, xE, yE, L, a+60);
    //
    xE := xE + L * cos(degtoRad(a+60));
    yE := yE + L * sin(degtoRad(a+60));
    koch(steps, xE, yE, L, a-60);
    //final 3rd
    xE := xE + L * cos(degtoRad(a-60));
    yE := yE + L * sin(degtoRad(a-60));
    koch(steps, xE, yE, L, a);
  end
  else begin
    xE := x + L * cos(degtoRad(a));
    yE := y + L * sin(degtoRad(a));
    form1.image1.canvas.line(round(x), form1.image1.height-round(y), round(xE), form1.image1.height-round(yE));
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  image1.canvas.brush.color := clWhite;
  image1.canvas.fillrect(0, 0, image1.height, image1.width);
  image1.canvas.brush.color := clBlack;

  koch(SpinEdit1.Value, 0, 300, 600, 0);   // steps for our recursion, x-coordinate, y-coordinate, length of the line, angle
end;



end.

