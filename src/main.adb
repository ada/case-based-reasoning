with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Numerics.Real_Arrays;
with Ada.Strings.Fixed;
with Ada.Integer_Text_IO;
with CBR.Distances;
with Birds;
with Birds.Probabilities;
with Birds.Samples;

procedure Main is




   use Birds;
   use Birds.Samples;
   use Ada.Numerics.Real_Arrays;

   X : Sample_Array;
   W : Real_Vector (Attribute_Type) := (others => 1.0);
   Min, Max : Float := 0.0;
begin

   Read_Sample_Array ("A.csv", 1, X, Min, Max);
   Normalize (1, Min, Max, X);
   Read_Sample_Array ("B.csv", 2, X, Min, Max);
   Normalize (2, Min, Max, X);
   Read_Sample_Array_Type ("R.csv", X);

   -- Print Cases with their respective attributes
   declare
      use Ada.Text_IO;
   begin
      Put_Line ("Sample_Array");
      for I in Sample_Array'Range loop
         Put (X (I));
         New_Line;
      end loop;
      New_Line (2);
   end;



   -- Calculate deviation between Case 1 and all other cases.
   -- The case with max value is the most similar one.
   declare
      use Ada.Integer_Text_IO;
      use Ada.Float_Text_IO;
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use CBR.Distances;
      use Birds.Probabilities;
      Sum : Float := 0.0;
      Bird : Bird_Probability_Collection;
   begin
      Put_Line ("Deviation");
      Put (Tail ("Class", 12));
      Put ("|");
      Put (Tail ("Manhattan", 12));
      Put ("|");
      Put (Tail ("Euclidean", 12));
      Put ("|");
      Put (Tail ("Canberra", 12));
      Put ("|");
      Put (Tail ("Mixed", 12));
      Put ("|");
      New_Line;
      for I in Sample_Array'Range loop
         Put (Tail (X (I).Bird'Img, 12));
         Put ("|");
         Sum := Manhattan_Deviation (W, X (1).Attribute, X (I).Attribute);
         Bird (X (I).Bird).Likeliness (Manhattan_Kind) := Bird (X (I).Bird).Likeliness (Manhattan_Kind) + Sum;
         Put (Sum, 4, 7, 0);
         Put ("|");
         Sum := Euclidean2_Deviation(W, X (1).Attribute, X (I).Attribute);
         Bird (X (I).Bird).Likeliness (Euclidean2_Kind) := Bird (X (I).Bird).Likeliness (Euclidean2_Kind) + Sum;
         Put (Sum, 4, 7, 0);
         Put ("|");
         Sum := Canberra_Deviation (W, X (1).Attribute, X (I).Attribute);
         Bird (X (I).Bird).Likeliness (Canberra_Kind) := Bird (X (I).Bird).Likeliness (Canberra_Kind) + Sum;
         Put (Sum, 4, 7, 0);
         Put ("|");
         Sum := Mixed_Deviation (W, X (1).Attribute, X (I).Attribute);
         Bird (X (I).Bird).Likeliness (Mixed_Kind) := Bird (X (I).Bird).Likeliness (Mixed_Kind) + Sum;
         Put (Sum, 4, 7, 0);
         Put ("|");
         New_Line;
         Bird (X (I).Bird).Count := Bird (X (I).Bird).Count + 1;
      end loop;
      New_Line (2);


      Put_Line ("Deviation Sum");
      Put (Tail ("Class", 12));
      Put ("|");
      Put (Tail ("Sample-Count", 12));
      Put ("|");
      Put (Tail ("Manhattan", 12));
      Put ("|");
      Put (Tail ("Euclidean", 12));
      Put ("|");
      Put (Tail ("Canberra", 12));
      Put ("|");
      Put (Tail ("Mixed", 12));
      Put ("|");
      New_Line;
      for I in Bird'Range loop
         Put (Tail (I'Img, 12));
         Put ("|");
         Put (Bird (I).Count, 12);
         Put ("|");
         Put (Bird (I).Likeliness (Manhattan_Kind), 4, 7, 0);
         Put ("|");
         Put (Bird (I).Likeliness (Euclidean2_Kind), 4, 7, 0);
         Put ("|");
         Put (Bird (I).Likeliness (Canberra_Kind), 4, 7, 0);
         Put ("|");
         Put (Bird (I).Likeliness (Mixed_Kind), 4, 7, 0);
         Put ("|");
         New_Line;
      end loop;
      New_Line (2);


   end;


end;

