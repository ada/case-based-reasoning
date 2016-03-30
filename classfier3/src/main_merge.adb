with Ada.Command_Line;
with Ada.Assertions;
with CBR;
with CBR.Texts;
with CBR.Readings;
with CBR.Writings;
with Dev.Args;

procedure Main_Merge is

   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use CBR.Writings;
   use Dev.Args;
   use Ada.Command_Line;
   use Ada.Assertions;

   X : Asset_Vectors.Vector;
   P : Natural;

begin

   P := Find_Argument ("-c");
   Assert (P > 0, "Missing class file -c flag");
   Read_Class (X, Get_Argument_Value (P + 1));

   P := Find_Argument ("-f");

   loop
      exit when P = Argument_Count;
      P := P + 1;
      exit when Get_Argument_Value (P)'Length = 0;
      Read_Point (X, Argument (P));
   end loop;

   P := Find_Argument ("-o");
   if P > 0 then
      Write_Class (X, Get_Argument_Value (P + 1));
   else
      Put_Point (X);
   end if;

end;
