unit SecureFinanceSpreadsheetUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  TheSpreadsheetUnit, mysql56conn;
  //all uses that are required for functions
type

  { TForm1 }

  TForm1 = class(TForm)
    ExitProgMain: TButton;
    CodePad: TButton;
    SecureQs: TButton;
    EnterUP: TButton;
    EnterUsername: TEdit;
    EnterPassword: TEdit;
    Label1: TLabel;
    UsernameLabel: TLabel;
    PasswordLabel: TLabel;
    procedure CodePadClick(Sender: TObject);
    procedure EnterUPClick(Sender: TObject);
    procedure ExitProgMainClick(Sender: TObject);
    procedure SecureQsClick(Sender: TObject);
  private

  public

  end;
  //All buttons, labels and procudures that are being used in this unit

var
  Form1: TForm1;
  Username, Password, Folder, Extension, answer, answertwo, answerthree : string;
  myfile : textfile;
  Attempt, count : integer;
  TheAnswer, TheAnswerTwo : string;

  //Variables all listed in one place for quick access

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.EnterUPClick(Sender: TObject);
begin

  Username := EnterUsername.text;
  Password := EnterPassword.text;
  Extension := Username + Password;

  if (Extension <> 'SteveP3r3ira01') and (Attempt <= 2) then
  begin
    Attempt := Attempt + 1;
    count := count - 1;
    label1.caption := 'You have ' + inttostr(count) + ' attepmt(s)';

    if Attempt > 2 then
    begin
      showmessage('Locked Out');
      halt;
    end

    else

    begin
      showmessage('Incorrect, try again');
      EnterUsername.clear;
      EnterPassword.clear;
    end;
  end

  else

  begin
    Attempt := 0;
    EnterUsername.clear;
    EnterPassword.clear;
    EnterPassword.PasswordChar := #0;
    UsernameLabel.caption := 'What is the name of your dog?';
    PasswordLabel.caption := 'What is your fathers name?';
    SecureQs.visible := true;
    EnterUP.visible := false;
    label1.caption := 'You have 2 attempts';
    count := 2;
  end;

end;
  //The first login to check if the username and password is correct
  //If correct then it will be able to load the file and secuirty questions

procedure TForm1.ExitProgMainClick(Sender: TObject);
begin
  halt;
end;
  //Stops the program

procedure TForm1.CodePadClick(Sender: TObject);
begin

   Folder := 'C:\Users\David Pereira\Documents\P\Project Files\.loginfile\' + Extension + '.txt';
   Assignfile(myfile, Folder);
   Reset(myFile);
   readln(myfile, answer);
   readln(myfile, answertwo);
   readln(myfile, answerthree);

   if (answerthree <> EnterUsername.text) then
   begin
     count := count - 1;
     label1.caption := 'You have ' + inttostr(count) + ' attepmt(s)';
     showmessage('Incorrect, Locked Out');
     halt;
   end

   else

   begin
      Attempt := 0;
      EnterUsername.visible := false;
      EnterPassword.visible := false;
      UsernameLabel.visible := false;
      PasswordLabel.visible := false;
      SecureQs.visible := false;
      EnterUP.visible := false;
      CodePad.visible := false;
      label1.visible := false;
      Form2.show;
      Form1.visible := false;
    end;


end;
  //Final line from the folder holds the keypad answer
  //If correct then the spreadsheet unit is loaded

procedure TForm1.SecureQsClick(Sender: TObject);
begin

    Folder := 'C:\Users\David Pereira\Documents\P\Project Files\.loginfile\' + Extension + '.txt';
    Assignfile(myfile, Folder);
    Reset(myFile);
    readln(myfile, answer);
    readln(myfile, answertwo);


    if (answer <> EnterUsername.text) or (answertwo <> EnterPassword.text) then
    begin
      Attempt := Attempt + 1;
      count := count - 1;
      label1.caption := 'You have ' + inttostr(count) + ' attepmt(s)';

      if Attempt > 1 then
      begin
        showmessage('Locked Out');
        halt;
      end

      else

      begin
        showmessage('Incorrect, try again');
        EnterUsername.clear;
        EnterPassword.clear;
      end;
    end

    else

    begin
      Attempt := 0;
      EnterUsername.clear;
      EnterUsername.PasswordChar := '*';
      EnterPassword.visible := false;
      UsernameLabel.caption := 'Enter 4 digit passcode';
      PasswordLabel.visible := false;
      SecureQs.visible := false;
      EnterUP.visible := false;
      CodePad.visible := true;
      label1.caption := 'You have 1 attempt';
      count := 1;
    end;

    closefile(myfile);

end;
  //First two lines of the file are read to get the secuirty questions
  //If correct then the final keypad is loaded for the user

begin
  Attempt := 0;
  count := 3;
end.
  //sets the inital number of attempts for the user
