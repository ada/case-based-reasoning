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

   X : Birds.Samples.Sample_Array;


   procedure Read_Files is
      use Birds;
      use Birds.Samples;
      Min, Max : Float := 0.0;
   begin
      Read_Sample_Array ("A.csv", Freq1_Kind, X, Min, Max);
      Normalize (Freq1_Kind, Min, Max, X);
      Read_Sample_Array ("B.csv", Freq2_Kind, X, Min, Max);
      Normalize (Freq2_Kind, Min, Max, X);
      Read_Sample_Array_Type ("R.csv", X);
   end;



begin

   Read_Files;

   -- Print Cases with their respective attributes
   declare
      use Ada.Text_IO;
      use Birds.Samples;
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
      use Birds.Probabilities;
      use Birds.Samples;
      Sum : Float := 0.0;
      Bird : Bird_Probability_Collection;
      Deviation : Deviation_Array;
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

         Estimate (X (1), X (I), Deviation);
         Estimate (X (1), X (I), Bird (X (I).Bird));

         Put (Tail (X (I).Bird'Img, 12));
         Put ("|");

         Put (Deviation (Manhattan_Kind), 4, 7, 0);
         Put ("|");
         Put (Deviation (Euclidean2_Kind), 4, 7, 0);
         Put ("|");
         Put (Deviation (Canberra_Kind), 4, 7, 0);
         Put ("|");
         Put (Deviation (Mixed_Kind), 4, 7, 0);
         Put ("|");
         New_Line;
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
      Put (Tail ("Likelihood", 12));
      Put ("|");
      New_Line;
      for I in Bird'Range loop
         Put (Tail (I'Img, 12));
         Put ("|");
         Put (Bird (I).Count, 12);
         Put ("|");
         Put (Bird (I).Deviation (Manhattan_Kind), 4, 7, 0);
         Put ("|");
         Put (Bird (I).Deviation (Euclidean2_Kind), 4, 7, 0);
         Put ("|");
         Put (Bird (I).Deviation (Canberra_Kind), 4, 7, 0);
         Put ("|");
         Put (Bird (I).Deviation (Mixed_Kind), 4, 7, 0);
         Put ("|");
         Put (Likelihood (Bird (I)), 4, 7, 0);
         Put ("|");
         New_Line;
      end loop;
      New_Line (2);


   end;


end;

