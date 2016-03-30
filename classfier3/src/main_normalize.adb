with Ada.Text_IO;
with Ada.Assertions;
with CBR;
with CBR.Texts;
with CBR.Readings;
with CBR.Writings;
with Dev.Math;
with Dev.Args;

procedure Main_Normalize is

   use Dev.Math;
   use Dev.Args;
   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use CBR.Writings;
   use Ada.Text_IO;
   use Ada.Assertions;

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
   Min : Float_Vector;
   Max : Float_Vector;
   P : Natural;

begin

   if Find_Argument ("-help") > 0 then
      Put_Line ("Help text");
      return;
   end if;

   P := Find_Argument ("-mm");
   Assert (P > 0, "Missing database file -mm flag");
   Read_Class (X, Get_Argument_Value (P + 1));
   Set_Min_Max (X, Min, Max);
   Find_Min_Max (X, Min, Max);

   P := Find_Argument ("-data");
   if P > 0 then
      X.Set_Length (0);
      Read_Class (X, Get_Argument_Value (P + 1));
   end if;

   Normalize (X, Min, Max);

   P := Find_Argument ("-o");
   if P > 0 then
      Write_Class (X, Get_Argument_Value (P + 1));
   else
      Put_Point (X);
   end if;

end;
