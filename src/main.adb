with Ada.Text_IO;
with Ada.Strings.Fixed;

with Birds;
with Birds.Probabilities;
with Birds.Samples;
with Birds.Deviations;
with Birds.Attributes;

procedure Main is

   procedure Read_Files (Destination : in out Birds.Samples.Vector) is
      use Birds;
      use Birds.Samples;
   begin
      Read_Vector_Normalized ("A.csv", Attributes.Kinds.Freq1, Destination);
      Read_Vector_Normalized ("B.csv", Attributes.Kinds.Freq2, Destination);
      Read_Vector_Kind ("R.csv", Destination);
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
      Put (Head ("Class", 8));
      Attributes.Kinds.Put_Tail (16, ' ', " ");
      New_Line;
      for E of Item loop
         Put (Head (E.Bird'Img, 8));
         Put (E.Attribute, 5, 10, 0, " ");
         New_Line;
      end loop;
   end;

   -- Calculate deviation between Case 1 and all other cases.
   -- The case with max value is the most similar one.
   procedure Estimation (Instance : Birds.Samples.Sample; Assets : Birds.Samples.Vector) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use Birds.Probabilities;
      use Birds;
      Prospect_Array : Probability_Collection;
      Divergency : Deviations.Vector;
   begin
      Put_Line (Head ("[Deviation]", 16));
      New_Line;
      Put (Head ("Class", 8));
      Put (" ");
      Deviations.Kinds.Put_Tail (16, ' ', " ");
      New_Line;
      for I in Assets'Range loop
         Estimate (Instance, Assets (I), Divergency);
         Estimate (Instance, Assets (I), Prospect_Array (Assets (I).Bird));
         Put (Head (Assets (I).Bird'Img, 8));
         Put (" ");
         Deviations.Put (Divergency, 5, 10, 0, " ");
         New_Line;
      end loop;
      New_Line (2);
      Put_Line (Head ("[Summation]", 16));
      New_Line;
      Put (Head ("Class", 8));
      Put (" ");
      Put_Probability_Header (16, " ");
      New_Line;
      for I in Prospect_Array'Range loop
         Put (Head (I'Img, 8));
         Put (" ");
         Put_Probability (Prospect_Array (I), 5, 10, 0, 16, " ");
         New_Line;
      end loop;
   end;

   Asset_Vector : Birds.Samples.Vector (1 .. 20);
   Test_Vector : Birds.Samples.Vector (22 .. 25);

begin

   Ada.Text_IO.New_Line (2);
   Read_Files (Asset_Vector);
   Read_Files (Test_Vector);
   Ada.Text_IO.Put_Line (Ada.Strings.Fixed.Head ("[Asset]", 16));
   Put_Samples (Asset_Vector);
   Ada.Text_IO.New_Line (2);
   Ada.Text_IO.Put_Line (Ada.Strings.Fixed.Head ("[Test]", 16));
   Put_Samples (Test_Vector (25 .. 25));
   Ada.Text_IO.New_Line (2);
   Estimation (Test_Vector (25), Asset_Vector);
   Ada.Text_IO.New_Line (2);

end;

