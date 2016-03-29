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

procedure Main_Ksort is

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

   procedure Calc (X : in out Asset_Vector; P : in out Prominent_Vector) is
   begin
      for I in X.First_Element.Dis.First_Index .. X.First_Element.Dis.Last_Index loop
         Sort_Distance (X, I);
         Calc_Prominent (X);
         Summarize (P, X);
      end loop;
   end;

   X : Asset_Vector;
   P : Prominent_Vector;

   Help_Text_1 : constant String := "<Distance_File> <K_Count>";
   Help_Text_2 : constant String := "<Distance_File> <K_Count> <Out_Prominent_File>";

begin

   if Argument_Count = 2 then
      Read_Distance (X, Argument (1));
      --Include 0 as unknown class
      Initialize (P, Count_Type (Max_Class (X) + 1), Count_Type'Value (Argument (2)));
      Calc (X, P);
      Put (P);
   elsif Argument_Count = 3 then
      Read_Distance (X, Argument (1));
      Initialize (P, Count_Type (Max_Class (X) + 1), Count_Type'Value (Argument (2)));
      Calc (X, P);
      Write_Prominent (P, Argument (3));
   else
      Put_Line ("Argument_Count must be 2 or 3.");
      Put_Line ("Usage: " & Help_Text_1);
      Put_Line ("Usage: " & Help_Text_2);
   end if;


end;
