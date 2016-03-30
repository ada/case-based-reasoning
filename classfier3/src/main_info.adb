with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;
with CBR;
with CBR.Texts;
with CBR.Readings;

procedure Main_Info is

   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use Ada.Text_IO;
   use Ada.Command_Line;
   use Ada.Integer_Text_IO;
   use Ada.Strings.Fixed;

   X : Asset_Vectors.Vector;

   Help_Text_1 : constant String := "<Class_File>";

begin

   if Argument_Count = 1 then
      Read_Class (X, Argument (1));

      Put (Tail ("Asset count ", 30));
      Put (Integer (X.Length), 5);
      New_Line;

      Put (Tail ("Max class count ", 30));
      Put (Max_Class (X), 5);
      New_Line;

      Put (Tail ("Unique class count ", 30));
      Put (Unique_Class_Count (X), 5);
      New_Line;

      Put (Tail ("Dimension count max ", 30));
      Put (Dim_Count_Max (X), 5);
      New_Line;

      Put (Tail ("Dimension count min ", 30));
      Put (Dim_Count_Min (X), 5);
      New_Line;

      New_Line;
      Put_Point (X);
   else
      Put_Line ("Usage");
      Put_Line (Help_Text_1);
   end if;

end;
