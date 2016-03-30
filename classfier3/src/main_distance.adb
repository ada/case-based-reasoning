with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Assertions;
with CBR;
with CBR.Texts;
with CBR.Readings;
with CBR.Writings;
with Dev.Math.Distances;
with Dev.Math;
with Dev.Args;

procedure Main_Distance is

   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use CBR.Writings;
   use Dev.Math;
   use Dev.Args;
   use Ada.Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;

   X : Asset_Vectors.Vector;
   Y : Asset_Vectors.Vector;
   W : Float_Vectors.Vector;
   D : Distances.Kinds.Kind;

   P : Natural;
   W0 : Float;

begin

   if Find_Argument ("-help") > 0 then
      Put_Line ("Help text");
      return;
   end if;

   P := Find_Argument ("-db");
   Assert (P > 0, "Missing database file -db flag");
   Read_Class (X, Get_Argument_Value (P + 1));

   P := Find_Argument ("-s");
   Assert (P > 0, "Missing sample file -s flag");
   Read_Class (Y, Get_Argument_Value (P + 1));

   Assert (Dim_Count_Max (X) = Dim_Count_Min (X), "Different dimension count in database.");
   Assert (Dim_Count_Max (Y) = Dim_Count_Min (Y), "Different dimension count in sample.");
   Assert (Dim_Count_Max (X) = Dim_Count_Max (Y), "Different dimension count in database and sample.");

   P := Find_Argument ("-d");
   Assert (P > 0, "Missing distance type -d flag");
   D := Distances.Kinds.Value (Argument (P + 1));

   P := Find_Argument ("-w") + 1;
   Assert (P > 0, "Missing weight -w flag");
   while Get (P, W0) loop
      W.Append (W0);
   end loop;

   Assert (Dim_Count_Max (X) = Natural (W.Length), "Number of weights is not equal number of dimension.");
   Calc_Distance (X, Y, D, W);

   P := Find_Argument ("-o");
   if P > 0 then
      Write_Distance (X, Argument (P + 1));
   else
      Put_Distance (X);
   end if;


end;

