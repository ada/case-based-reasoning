with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
with Ada.Numerics.Real_Arrays;
with Ada.Containers.Formal_Vectors;
with Ada.Containers.Vectors;
with Ada.Containers.Indefinite_Vectors;
with Ada.Assertions;
with Ada.Strings.Fixed;
with CBR;
with CBR.Texts;
with CBR.Readings;
with Dev.Math;

procedure Main_Normalize is

   use Dev.Math;
   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use Ada.Numerics.Real_Arrays;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Containers;
   use Ada.Strings.Fixed;

   procedure Find_Min_Max (X : Asset_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
   begin
      for E : Asset of X loop
         Find_Min_Max (E.Point, Min, Max);
      end loop;
   end;

   procedure Set_Min_Max (X : Asset_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
      use Dev.Math.Float_Vectors;
   begin
      for E : Float of X (1).Point loop
         Append (Min, Float'Last);
         Append (Max, Float'First);
      end loop;
   end;

   procedure Normalize (X : in out Asset_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
   begin
      for E : Asset of X loop
         Normalize (E.Point, Min, Max);
      end loop;
   end;

   X : Asset_Vector;
   Y : Asset_Vector;
   Min : Float_Vector;
   Max : Float_Vector;

   Help_Text_1 : constant String := "<Asset_File>";
   Help_Text_2 : constant String := "<Asset_File> <Out_Asset_File_Normalized>";
   Help_Text_3 : constant String := "<Asset_Min_Max_File> <Asset_File> <Out_Asset_File_Normalized>";

begin


   if Argument_Count = 1 then
      Read_Class (X, Argument (1));
      Set_Min_Max (X, Min, Max);
      Find_Min_Max (X, Min, Max);
      Normalize (X, Min, Max);
      Put_Point (X);
   elsif Argument_Count = 2 then
      Read_Class (X, Argument (1));
      Set_Min_Max (X, Min, Max);
      Find_Min_Max (X, Min, Max);
      Normalize (X, Min, Max);
      Write_Class (X, Argument (2));
   elsif Argument_Count = 3 then
      Read_Class (X, Argument (1));
      Set_Min_Max (X, Min, Max);
      Find_Min_Max (X, Min, Max);
      Read_Class (Y, Argument (2));
      Normalize (Y, Min, Max);
      Write_Class (Y, Argument (3));
   else
      Put_Line ("Usage");
      Put_Line (Help_Text_1);
      Put_Line (Help_Text_2);
      Put_Line (Help_Text_3);
   end if;

end;
