with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Assertions;
with Ada.Strings.Fixed;
with CBR;
with CBR.Readings;
with CBR.Writings;
with Dev.Args;

procedure Main_Eval is

   use CBR;
   use CBR.Readings;
   use CBR.Writings;
   use Dev.Args;
   use Ada.Text_IO;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Strings.Fixed;

   Y : Prominent_Vectors.Vector;
   S : Asset_Vectors.Vector;
   N : Natural_Vectors.Vector;
   P : Natural;

begin

   P := Find_Argument ("-p");
   Assert (P > 0, "Missing Prominent_File -p flag");
   Read_Prominent (Y, Get_Argument_Value (P + 1));

   P := Find_Argument ("-s");
   Assert (P > 0, "Missing Sample_File -s flag");
   Read_Class (S, Get_Argument_Value (P + 1));

   Evaluate (Y, S, N);

   P := Find_Argument ("-o");
   if P > 0 then
      Write_Correctness (N, Get_Argument_Value (P + 1));
   else
      Put (Tail ("K", 3));
      Put (Tail ("Correct", 10));
      New_Line;
      for I in N.First_Index .. N.Last_Index loop
         Put (I, 3);
         Put (N (I), 10);
         New_Line;
      end loop;
   end if;

end;
