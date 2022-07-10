unit TheSpreadsheetUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql56conn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids, DBCtrls, Menus, ExtCtrls, LockedU;
  //uses used for this unit

type

  { TForm2 }

  TForm2 = class(TForm)
    BackBut: TButton;
    LOCKBUT: TButton;
    Label5: TLabel;
    UpDatBut: TButton;
    EditDataBut: TButton;
    Label3: TLabel;
    YearTotalCalc: TButton;
    Tablecomp1: TEdit;
    Tablecomp2: TEdit;
    Exithere: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    FindEnt: TButton;
    DogU: TButton;
    FindB: TEdit;
    FireU: TButton;
    Label2: TLabel;
    MySQL56Connection1: TMySQL56Connection;
    OfficersU: TButton;
    CivilianU: TButton;
    CalcYr: TButton;
    CalcBut: TButton;
    Label1: TLabel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    YearTotalLabel: TLabel;
    WhichMonth: TEdit;
    MonthTotalLabel: TLabel;
    procedure BackButClick(Sender: TObject);
    procedure LOCKBUTClick(Sender: TObject);
    procedure CalcButClick(Sender: TObject);
    procedure CalcYrClick(Sender: TObject);
    procedure CivilianUClick(Sender: TObject);
    procedure DogUClick(Sender: TObject);
    procedure EditDataButClick(Sender: TObject);
    procedure ExithereClick(Sender: TObject);
    procedure FindEntClick(Sender: TObject);
    procedure FireUClick(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure OfficersUClick(Sender: TObject);
    procedure UpDatButClick(Sender: TObject);
    procedure YearTotalCalcClick(Sender: TObject);
  private

  public

  end;
  //every procedure and item needed for this unit listed

var
  Form2: TForm2;
  row, answer, column, Tanswer : integer;
  Tab, TABONE, TABTWO, DATA, MONTH, EDCOLUMN, EDDATA, x, Foldertwo, dataexp : string;
  myfiletwo : textfile;
  //all variables needed stored in one place

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.CalcButClick(Sender: TObject);
begin

  x := WhichMonth.Text;

  SQLQuery1.Active := false;
  SQLQuery1.SQL.clear;

  try
    SQLQuery1.SQL.add('SELECT budget-(pay+expenses+overtime) FROM '+Tab+' where month = '+ x);
    SQLQuery1.Active := true;
  except
    Showmessage('Error, try again');
  end;

end;
  //calculates the total for a month the user wants

procedure TForm2.BackButClick(Sender: TObject);
begin

  SQLQuery1.Active := false;
  SQLQuery1.SQL.clear;

  label5.visible := false;
  UpDatBut.visible := false;
  Tablecomp1.caption := 'Table1';
  Tablecomp2.caption := 'Table2';
  FindB.caption := 'Enter Data';
  EditDataBut.visible := false;
  YearTotalCalc.visible := false;
  Tablecomp1.visible := true;
  Tablecomp2.visible := true;
  label2.visible := true;
  Label1.visible := false;
  Label3.visible := false;
  WhichMonth.visible := false;
  CalcBut.visible := false;
  MonthTotalLabel.visible := false;
  CalcYr.visible := false;
  YearTotalLabel.visible := false;
  FindB.visible := true;
  FindEnt.visible := true;

end;

procedure TForm2.LOCKBUTClick(Sender: TObject);
begin

  form3.visible := true;
  form2.visible := false;

end;

  //takes the user back to the menu

procedure TForm2.CalcYrClick(Sender: TObject);
begin

  SQLQuery1.Active := false;
  SQLQuery1.SQL.clear;

  SQLQuery1.SQL.add('SELECT (SUM(Budget-(Pay+Expenses+Overtime)))/12 FROM ' + Tab);
  SQLQuery1.Active := true;

end;
  //calculates the year average spent for the unit selected

procedure TForm2.CivilianUClick(Sender: TObject);
begin

  SQLQuery1.Active := false;
  SQLQuery1.SQL.clear;

  label5.visible := false;
  UpDatBut.visible := false;
  Label3.visible := false;
  EditDataBut.visible := true;
  YearTotalCalc.visible := true;
  Tablecomp1.visible := false;
  Tablecomp2.visible := false;
  label2.visible := false;
  Label1.visible := true;
  WhichMonth.visible := true;
  CalcBut.visible := true;
  MonthTotalLabel.visible := true;
  CalcYr.visible := true;
  YearTotalLabel.visible := true;
  FindB.visible := false;
  FindEnt.visible := false;

  SQLQuery1.SQL.add('SELECT * FROM civilian');
  SQLQuery1.Active := true;

  Tab := 'civilian';
  YearTotalLabel.caption := Tab;

end;
  //loads the civilian table from the database

procedure TForm2.DogUClick(Sender: TObject);
begin

  SQLQuery1.Active := false;
  SQLQuery1.SQL.clear;

  label5.visible := false;
  UpDatBut.visible := false;
  Label3.visible := false;
  EditDataBut.visible := true;
  YearTotalCalc.visible := true;
  Tablecomp1.visible := false;
  Tablecomp2.visible := false;
  label2.visible := false;
  Label1.visible := true;
  WhichMonth.visible := true;
  CalcBut.visible := true;
  MonthTotalLabel.visible := true;
  CalcYr.visible := true;
  YearTotalLabel.visible := true;
  FindB.visible := false;
  FindEnt.visible := false;

  SQLQuery1.SQL.add('SELECT * FROM dog');
  SQLQuery1.Active := true;

  Tab := 'dog';
  YearTotalLabel.caption := Tab;

end;
  //loads the dog table from the database

procedure TForm2.EditDataButClick(Sender: TObject);
begin

  Tablecomp1.caption := 'Enter Coloumn';
  Tablecomp2.caption := 'Enter data';
  FindB.caption := 'Enter Month';
  Tablecomp1.visible := true;
  Tablecomp2.visible := true;
  label3.visible := true;
  FindB.visible := true;
  UpDatBut.visible := true;

end;
  //Loads the necessary items for the user to be able to edit the tables data

procedure TForm2.ExithereClick(Sender: TObject);
begin
  halt;
end;
  //stops the program

procedure TForm2.FindEntClick(Sender: TObject);
begin

  SQLQuery1.Active := false;
  SQLQuery1.SQL.clear;

  TABONE := Tablecomp1.text;
  TABTWO := Tablecomp2.text;
  DATA := FindB.text;

  If (DATA = '') OR (DATA = 'Enter Data') then
  DATA := '*';

  try
    SQLQuery1.SQL.add('SELECT '+TABONE+'.'+DATA+', '+TABTWO+'.'+DATA+' FROM '+TABONE+' JOIN '+TABTWO+' ON '+TABONE+'.month = '+TABTWO+'.month');
    SQLQuery1.Active := true;
  except
    Showmessage('Error, try again');
  end;

  label5.visible := true;
  YearTotalLabel.visible := true;
  YearTotalLabel.caption := TABONE;
  label5.caption := TABTWO;

end;
  //finds data from two tables to compare them

procedure TForm2.FireUClick(Sender: TObject);
begin

  SQLQuery1.Active := false;
  SQLQuery1.SQL.clear;

  label5.visible := false;
  UpDatBut.visible := false;
  Label3.visible := false;
  EditDataBut.visible := true;
  YearTotalCalc.visible := true;
  Tablecomp1.visible := false;
  Tablecomp2.visible := false;
  label2.visible := false;
  Label1.visible := true;
  WhichMonth.visible := true;
  CalcBut.visible := true;
  MonthTotalLabel.visible := true;
  CalcYr.visible := true;
  YearTotalLabel.visible := true;
  FindB.visible := false;
  FindEnt.visible := false;

  SQLQuery1.SQL.add('SELECT * FROM firearms');
  SQLQuery1.Active := true;

  Tab := 'firearms';
  YearTotalLabel.caption := Tab;

end;
  //loads the firearms table from the database

procedure TForm2.IdleTimer1Timer(Sender: TObject);
begin

end;

procedure TForm2.OfficersUClick(Sender: TObject);
begin

  SQLQuery1.Active := false;
  SQLQuery1.SQL.clear;

  label5.visible := false;
  UpDatBut.visible := false;
  Label3.visible := false;
  EditDataBut.visible := true;
  YearTotalCalc.visible := true;
  Tablecomp1.visible := false;
  Tablecomp2.visible := false;
  label2.visible := false;
  Label1.visible := true;
  WhichMonth.visible := true;
  CalcBut.visible := true;
  MonthTotalLabel.visible := true;
  CalcYr.visible := true;
  YearTotalLabel.visible := true;
  FindB.visible := false;
  FindEnt.visible := false;

  SQLQuery1.SQL.add('SELECT * FROM officer');
  SQLQuery1.Active := true;

  Tab := 'officer';
  YearTotalLabel.caption := Tab;

end;
  //loads the officer table from the database


procedure TForm2.UpDatButClick(Sender: TObject);
begin

  EDCOLUMN := Tablecomp1.text;
  EDDATA := Tablecomp2.text;
  MONTH := FindB.text;

  SQLQuery1.SQL.clear;
  SQLQuery1.SQL.add('UPDATE '+TAB+' SET '+EDCOLUMN+' = '+EDDATA+' WHERE Month = '+MONTH);
  try
    SQLQuery1.ExecSQL;
    SQLTransaction1.commit;
    showmessage('Changes saved');
  except
    Showmessage('Error, try again');
  end;

end;
  //Saves the changes the user wants to the database/table

procedure TForm2.YearTotalCalcClick(Sender: TObject);
begin

  SQLQuery1.Active := false;
  SQLQuery1.SQL.clear;

  SQLQuery1.SQL.add('SELECT SUM(Budget-(Pay+Expenses+Overtime)) FROM ' + Tab);
  SQLQuery1.Active := true;

end;
  //Calculates the total for the year for the table selected

end.

