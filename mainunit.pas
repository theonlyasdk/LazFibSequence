unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
    FormAbout, LCLType, Types;

    { TFMain }

    TFMain = class(TForm)
        BtnGenerate: TButton;
        LBFib: TListBox;
        LblTitle: TLabel;
        LEFibN: TLabeledEdit;
        procedure BtnGenerateClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure LBFibDrawItem(Control: TWinControl; Index: Integer;
          ARect: TRect; State: TOwnerDrawState);
        procedure LblTitleClick(Sender: TObject);
        procedure LEFibNKeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
    private

    public
        function Fibonacci(const n: fibonacciLeftInverseRange): nativeuint;
        procedure DoFibExecute;
    end;

var
    FMain: TFMain;

implementation

{$R *.lfm}

{ TFMain }

{ Returns nth number in the fibonacci series }
function TFMain.Fibonacci(const n: fibonacciLeftInverseRange): nativeuint;
var
    N1: Int64 = 0;
    N2: Int64 = 1;
    NextNum: Int64 = 1;
    Count: Integer = 1;
begin
     while Count <= n do
     begin
       LBFib.Items.Add(IntToStr(NextNum));
       Inc(Count);
       N1 := N2;
       N2 := NextNum;
       NextNum := N1 + N2;

       // exit if overflow
       if NextNum < 0 then Break;
     end;

     Exit(NextNum);
end;

procedure TFMain.LblTitleClick(Sender: TObject);
begin
    FAbout.ShowModal;
end;

procedure TFMain.LEFibNKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then DoFibExecute;
end;

procedure TFMain.DoFibExecute;
var
    SafeN: integer;
    OldCaption: string;
begin
  if LEFibN.Text = '' then Exit;

  SafeN := Abs(StrToInt(LEFibN.Text));
  OldCaption := Caption;
  Caption := 'Processing...';
  LBFib.Items.Clear;
  Fibonacci(SafeN);
  Caption := OldCaption;
end;

procedure TFMain.BtnGenerateClick(Sender: TObject);
begin
     DoFibExecute;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
    Constraints.MinWidth := Width;
    Constraints.MinHeight := Height;
end;

{ https://wiki.lazarus.freepascal.org/TListBox }
procedure TFMain.LBFibDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
var
  aColor: TColor;
begin
  if (Index mod 2 = 0)                  //Index tells which item it is
    then aColor:=$FFFFFF                //every second item gets white as the background color
    else aColor:=$EEEEFF;               //every second item gets pink background color
  if odSelected in State then aColor:=$4444FF;  //If item is selected, then red as background color
  LBFib.Canvas.Brush.Color:=aColor;  //Set background color
  LBFib.Canvas.FillRect(ARect);      //Draw a filled rectangle
  LBFib.Canvas.TextRect(ARect, 2, ARect.Top+2, LBFib.Items[Index]);  //Draw Itemtext
end;

end.
