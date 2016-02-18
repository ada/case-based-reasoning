with Ada.Text_IO;
with Ada.Strings.Fixed;

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
      Read_Vector_Normalized ("A.csv", Attributes.Freq1, X);
      Read_Vector_Normalized ("B.csv", Attributes.Freq2, X);
      Read_Vector_Kind ("R.csv", X);
   end;



   -- Print Cases with their respective attributes
   procedure Put_Samples is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Birds.Samples;
      use Birds;
   begin
      Put_Line (Tail ("[Samples]", 16));
      New_Line;
      Attributes.Put_Kind (16, "");
      New_Line;
      Put_Vector (X, 16);
   end;




   -- Calculate deviation between Case 1 and all other cases.
   -- The case with max value is the most similar one.
   procedure Estimation is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Birds.Probabilities;
      use Birds;
      Prospect_Array : Probability_Collection;
      Divergency : Deviations.Vector;
   begin

      Put_Line (Tail ("[Deviation]", 16));
      New_Line;
      Put (Tail ("Class", 16));
      Put (" ");
      Deviations.Put_Kind (16, " ");
      New_Line;

      for I in X'Range loop
         Estimate (X (1), X (I), Divergency);
         Estimate (X (1), X (I), Prospect_Array (X (I).Bird));
         Put_Kind (X (I).Bird, 16);
         Put (" ");
         Deviations.Put_Vector (Divergency, 16, " ");
         New_Line;
      end loop;

      New_Line (2);


      Put_Line (Tail ("[Summation]", 16));
      New_Line;
      Put (Tail ("Class", 16));
      Put (" ");
      Put_Probability_Header (16, " ");
      New_Line;

      for I in Prospect_Array'Range loop
         Put_Kind (I, 16);
         Put (" ");
         Put_Probability (Prospect_Array (I), 16, " ");
         New_Line;
      end loop;

   end;



begin

   Ada.Text_IO.New_Line (2);

   Read_Files;

   Put_Samples;

   Ada.Text_IO.New_Line (2);

   Estimation;

   Ada.Text_IO.New_Line (2);

end;

