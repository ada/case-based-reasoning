with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
with Ada.Assertions;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Containers;
with CBR;
with CBR.Texts;
with CBR.Readings;
with Dev.Math;
with Dev.Args;
with Dev.Math.Distances;

procedure Main_KNN is

   use Dev.Args;
   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use Ada.Text_IO;
   use Ada.Assertions;
   use Ada.Strings.Unbounded;
   use Ada.Strings.Unbounded.Text_IO;
   use Ada.Integer_Text_IO;
   use Ada.Float_Text_IO;

   use type Ada.Containers.Count_Type;

   X : Asset_Vector;
   S : Asset_Vector;
   D : Distance_Info_Vector;
   J : Natural;
   DT : Dev.Math.Distances.Kinds.Kind;
   W : Weight_Vector;
   W0 : Float;
   K : K_Class_Vector;
   P : Prominent_Vector;
   KN : Natural;
   F : Name_Vector;
   C : Name_Vector;

begin

   Put_Line ("==========K nearest neighbor (KNN)==========");
   New_Line;

   J := Find_Argument_Asserted ("-db", "Missing database -db flag");
   Read_Class (X, Get_Argument_Value (J + 1));

   J := Find_Argument_Asserted ("-d", "Missing distance type -d flag");
   DT := Dev.Math.Distances.Kinds.Value (Get_Argument_Value (J + 1));

   J := Find_Argument_Asserted ("-s", "Missing sample file -s flag");
   Read_Class (S, Get_Argument_Value (J + 1));

   J := Find_Argument_Asserted ("-w", "Missing weight -w flag") + 1;
   while Get (J, W0) loop
      W.Append (W0);
   end loop;

   J := Find_Argument ("-f");
   if J > 0 then
      Read (F, Get_Argument_Value (J + 1));
      Assert (F.First_Index = W.First_Index and F.Last_Index = W.Last_Index, "Feature name list length not equal weight vector dimension count. F.First_Index = W.First_Index and F.Last_Index = W.Last_Index");
      Put_Line ("Weights");
      for I in F.First_Index .. F.Last_Index loop
         Put (I, 3);
         Put (" ");
         Put (Head (F (I), 30));
         Put (" ");
         Put (W (I), 3, 3, 0);
         New_Line;
      end loop;
      New_Line;
   end if;

   Assert (Dim_Count_Min (X) = Natural (W.Length), "Number of weights is not equal number of dimension.");

   J := Find_Argument_Asserted ("-k", "Missing k count -k flag");
   KN := Natural'Value (Get_Argument_Value (J + 1));
   Initialize (P, Integer (Max_Class (X) + 1), KN);

   for E of S loop
      D.Set_Length (0);
      K.Set_Length (0);
      Calc_Distance (X, E, DT, W, D);
      Sort (D);
      Calc_Prominent (D, K);
      Summarize1 (K, P);
   end loop;

   J := Find_Argument ("-c");
   if J > 0 then
      Read (C, Get_Argument_Value (J + 1));
      for E of C loop
         Put (Tail (E, 16));
         Put (",");
      end loop;
      New_Line;
   end if;
   Put_CSV (P);

end;
