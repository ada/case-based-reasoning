with Ada.Text_IO;
with Ada.Strings.Fixed;

with Birds;
with Birds.Probabilities;
with Birds.Samples;
with Birds.Deviations;
with Birds.Attributes;

procedure Main is

   X : Birds.Samples.Vector (1 .. 20);

   Y : Birds.Samples.Vector (22 .. 25);


   procedure Read_Files is
      use Birds;
      use Birds.Samples;
   begin
      Read_Vector_Normalized ("A.csv", Attributes.Kinds.Freq1, X);
      Read_Vector_Normalized ("B.csv", Attributes.Kinds.Freq2, X);
      Read_Vector_Kind ("R.csv", X);

      Read_Vector_Normalized ("A.csv", Attributes.Kinds.Freq1, Y);
      Read_Vector_Normalized ("B.csv", Attributes.Kinds.Freq2, Y);
      Read_Vector_Kind ("R.csv", Y);
   end;



   -- Print Cases with their respective attributes
   procedure Put_Samples (Item : Birds.Samples.Vector) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Birds.Samples;
      use Birds;
      use Birds.Attributes;
   begin
      New_Line;
      Put (Head ("Class", 16));
      Attributes.Kinds.Put_Tail (16, ' ', " ");
      New_Line;
      for E of Item loop
         Put (Head (E.Bird'Img, 16));
         Put (E.Attribute, 5, 10, 0, " ");
         New_Line;
      end loop;
   end;




   -- Calculate deviation between Case 1 and all other cases.
   -- The case with max value is the most similar one.
   procedure Estimation (Instance : Birds.Samples.Sample) is
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
         Estimate (Instance, X (I), Divergency);
         Estimate (Instance, X (I), Prospect_Array (X (I).Bird));
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

   Ada.Text_IO.Put_Line (Ada.Strings.Fixed.Tail ("[Assets]", 16));
   Put_Samples (X);

   Ada.Text_IO.New_Line (2);


   Ada.Text_IO.Put_Line (Ada.Strings.Fixed.Tail ("[Sample]", 16));
   Put_Samples (Y (25 .. 25));

   Ada.Text_IO.New_Line (2);

   Estimation (Y (25));

   Ada.Text_IO.New_Line (2);

end;

