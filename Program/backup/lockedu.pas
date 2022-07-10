unit LockedU;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;
  //uses used for this unit

type

  { TForm3 }

  TForm3 = class(TForm)
    ENT: TButton;
    KeyEnt: TEdit;
    Label1: TLabel;
    tmrlab: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Timer1: TTimer;
    procedure ENTClick(Sender: TObject);
    procedure Label3MouseEnter(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;
  //every procedure and item needed for this unit listed

var
  Form3: TForm3;
  counter : integer = 180;
  Attempt : integer = 1;
  //variables needed for this unit

implementation

uses
  TheSpreadsheetUnit;
  //allows unit to switch bag to the main unit

{$R *.lfm}

{ TForm3 }

procedure TForm3.Timer1Timer(Sender: TObject);
begin

  counter := counter - 1;
  tmrlab.caption := inttostr(counter);

  if counter = 0 then
  begin
    showmessage('Idle for too long, program closing');
    Timer1.enabled := false;
    halt;
  end;

end;
  //times out the program after 3 minutes

procedure TForm3.Label3MouseEnter(Sender: TObject);
begin

  Timer1.enabled := true;

end;
  //starts timer

procedure TForm3.ENTClick(Sender: TObject);
begin

  if (Attempt = 3) and (KeyEnt.text <> '2684') then
  begin
    showmessage('Too many attempts, terminating');
    halt;
  end;

  if KeyEnt.text = '2684' then
  begin
  form2.visible := true;
  form3.visible := false;
  KeyEnt.text := '';
  Attempt := 1;
  Timer1.enabled := false;
  counter := 180;
  tmrlab.caption := inttostr(counter);
  end
  else
  begin
  showmessage('Incorrect, try again');
  Attempt := Attempt + 1;
  end;

end;
  //checks passcode with input
  //if correct it returns to main unit
  //if three wrong attempts then program closes

end.

