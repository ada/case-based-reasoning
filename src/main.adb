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
   begin
      Read_Sample_Array_Normalized ("A.csv", Freq1_Kind, X);
      Read_Sample_Array_Normalized ("B.csv", Freq2_Kind, X);
      Read_Sample_Array_Type ("R.csv", X);
   end;



   -- Print Cases with their respective attributes
   procedure Put_Samples is
      use Ada.Text_IO;
      use Birds.Samples;
      use Birds;
   begin
      Put_Line ("Samples");
      Put_Attribute_Kind (12);
      New_Line;
      Put_Sample_Array (X, 12);
   end;




   -- Calculate deviation between Case 1 and all other cases.
   -- The case with max value is the most similar one.
   procedure Estimation is
      use Ada.Integer_Text_IO;
      use Ada.Float_Text_IO;
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Birds.Probabilities;
      use Birds.Samples;
      use Birds;
      Sum : Float := 0.0;
      Bird : Bird_Probability_Collection;
      Divergency : Deviation_Array;
   begin

      Put_Line ("Deviation");
      Put (Tail ("Class", 12));
      Put ("|");
      Put_Deviation_Kind (12, "|");

      New_Line;

      for I in Sample_Array'Range loop

         Estimate (X (1), X (I), Divergency);
         Estimate (X (1), X (I), Bird (X (I).Bird));

         Put (Tail (X (I).Bird'Img, 12));
         Put ("|");

         Put (Divergency (Manhattan_Kind), 4, 7, 0);
         Put ("|");
         Put (Divergency (Euclidean2_Kind), 4, 7, 0);
         Put ("|");
         Put (Divergency (Canberra_Kind), 4, 7, 0);
         Put ("|");
         Put (Divergency (Mixed_Kind), 4, 7, 0);
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
         Put (Bird (I).Divergency (Manhattan_Kind), 4, 7, 0);
         Put ("|");
         Put (Bird (I).Divergency (Euclidean2_Kind), 4, 7, 0);
         Put ("|");
         Put (Bird (I).Divergency (Canberra_Kind), 4, 7, 0);
         Put ("|");
         Put (Bird (I).Divergency (Mixed_Kind), 4, 7, 0);
         Put ("|");
         Put (Likelihood (Bird (I)), 4, 7, 0);
         Put ("|");
         New_Line;
      end loop;
      New_Line (2);


   end;



begin

   Read_Files;

   Put_Samples;

   Ada.Text_IO.New_Line (2);

   Estimation;

end;

