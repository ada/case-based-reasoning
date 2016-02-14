with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Numerics.Real_Arrays;
with Ada.Strings.Fixed;
with Ada.Integer_Text_IO;
with CBR.Distances;
with Birds;
with Birds.Probabilities;
with Birds.Samples;
with Birds.Deviations;
with Birds.Attributes;

procedure Main is

   X : Birds.Samples.Vector (1 .. 8);


   procedure Read_Files is
      use Birds;
      use Birds.Samples;
   begin
      Read_Sample_Array_Normalized ("A.csv", Attributes.Freq1, X);
      Read_Sample_Array_Normalized ("B.csv", Attributes.Freq2, X);
      Read_Sample_Array_Type ("R.csv", X);
   end;



   -- Print Cases with their respective attributes
   procedure Put_Samples is
      use Ada.Text_IO;
      use Birds.Samples;
      use Birds;
   begin
      Put_Line ("Samples");
      Attributes.Put_Kind (12);
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
      Prospect_Array : Probability_Collection;
      Divergency : Deviations.Vector;
   begin

      Put_Line ("Deviation");
      Put (Tail ("Class", 12));
      Put ("|");
      Deviations.Put_Kind (12, "|");

      New_Line;

      for I in X'Range loop
         Estimate (X (1), X (I), Divergency);
         Estimate (X (1), X (I), Prospect_Array (X (I).Bird));
         Put (Tail (X (I).Bird'Img, 12));
         Put ("|");
         Deviations.Put_Vector (Divergency, 12, "|");
         New_Line;
      end loop;

      New_Line (2);


      Put_Line ("Deviation Sum");
      Put_Probability_Header (12, "|");
      New_Line;

      for I in Prospect_Array'Range loop
         Put (Tail (I'Img, 12));
         Put ("|");
         Put_Probability (Prospect_Array (I), 12, "|");
         New_Line;
      end loop;

   end;



begin

   Read_Files;

   Put_Samples;

   Ada.Text_IO.New_Line (2);

   Estimation;

   Ada.Text_IO.New_Line (2);

end;

