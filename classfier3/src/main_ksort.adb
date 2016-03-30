with Ada.Assertions;
with CBR;
with CBR.Texts;
with CBR.Readings;
with CBR.Writings;
with Dev.Args;

procedure Main_Ksort is

   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use CBR.Writings;
   use Dev.Args;
   use Ada.Assertions;

   procedure Calc (X : in out Asset_Vector; P : in out Prominent_Vector) is
   begin
      for I in X.First_Element.Dis.First_Index .. X.First_Element.Dis.Last_Index loop
         Sort_Distance (X, I);
         Calc_Prominent (X);
         Summarize (P, X);
      end loop;
   end;

   X : Asset_Vector;
   Y : Prominent_Vector;
   P : Natural;

begin

   P := Find_Argument ("-d");
   Assert (P > 0, "Missing distance file -d flag");
   Read_Distance (X, Get_Argument_Value (P + 1));

   P := Find_Argument ("-k");
   Assert (P > 0, "Missing k count -k flag");
   Initialize (Y, Max_Class (X) + 1, Natural'Value (Get_Argument_Value (P + 1)));
   Calc (X, Y);

   P := Find_Argument ("-o");
   if P > 0 then
      Write_Prominent (Y, Get_Argument_Value (P + 1));
   end if;

   P := Find_Argument ("-csv");
   if P > 0 then
      Write_Prominent_CSV (Y, Get_Argument_Value (P + 1));
   end if;

   P := Find_Argument ("-put");
   if P > 0 then
      Put (Y);
   end if;

end;
