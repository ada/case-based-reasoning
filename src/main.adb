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
      Read_Vector_Normalized ("A.csv", Attributes.Kinds.Freq1, X);
      Read_Vector_Normalized ("B.csv", Attributes.Kinds.Freq2, X);
      Read_Vector_Kind ("R.csv", X);
   end;



   -- Print Cases with their respective attributes
   procedure Put_Samples is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Birds.Samples;
      use Birds;
      use Birds.Attributes;
   begin
      Put_Line (Tail ("[Samples]", 16));
      New_Line;
      Attributes.Kinds.Put_Tail (16, ' ', " ");
      New_Line;
      for E of X loop
         Put (E.Attribute, 5, 10, 0, " ");
         New_Line;
      end loop;
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
      Put (Head ("Class", 16));
      Put (" ");
      Deviations.Kinds.Put_Tail (16, ' ', " ");
      New_Line;

      for I in X'Range loop
         Estimate (X (1), X (I), Divergency);
         Estimate (X (1), X (I), Prospect_Array (X (I).Bird));
         Put (Head (X (I).Bird'Img, 16));
         Put (" ");
         Deviations.Put (Divergency, 5, 10, 0, " ");
         New_Line;
      end loop;

      New_Line (2);


      Put_Line (Tail ("[Summation]", 16));
      New_Line;
      Put (Head ("Class", 16));
      Put (" ");
      Put_Probability_Header (16, " ");
      New_Line;

      for I in Prospect_Array'Range loop
         Put (Head (I'Img, 16));
         Put (" ");
         Put_Probability (Prospect_Array (I), 5, 10, 0, 16, " ");
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

