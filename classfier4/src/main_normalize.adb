with Ada.Text_IO;
with CBR;
with CBR.Texts;
with CBR.Readings;
with CBR.Writings;
with Dev.Args;

procedure Main_Normalize is

   use Dev.Args;
   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use CBR.Writings;
   use Ada.Text_IO;

   X : Asset_Vector;
   Min : Point;
   Max : Point;
   P : Natural;

begin

   Put_Line ("==========Normalize==========");

   if Find_Argument ("-help") > 0 then
      Put_Line ("Help text");
      return;
   end if;

   P := Find_Argument_Asserted ("-mm", "Missing database file -mm flag");
   Read_Class (X, Get_Argument_Value (P + 1));
   Initialize_Min_Max (X, Min, Max);
   Find_Min_Max (X, Min, Max);

   P := Find_Argument ("-data");
   if P > 0 then
      X.Set_Length (0);
      Read_Class (X, Get_Argument_Value (P + 1));
   end if;

   Normalize (X, Min, Max);

   P := Find_Argument ("-o");
   if P > 0 then
      Put_Line ("Writing to file " & Get_Argument_Value (P + 1));
      Write_Class (X, Get_Argument_Value (P + 1));
   else
      Put_Point (X);
   end if;

   New_Line (2);

end;
