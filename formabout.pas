unit FormAbout;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFAbout }

  TFAbout = class(TForm)
    BtnClose: TButton;
    LblAbout: TLabel;
    LblDesc: TLabel;
    MemoLicense: TMemo;
  private

  public

  end;

var
  FAbout: TFAbout;

implementation

{$R *.lfm}

end.

