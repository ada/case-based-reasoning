with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Fixed;

with Birds;
with Birds.Probabilities;
with Birds.Samples;
with Birds.Deviations;
with Birds.Attributes;

with CBR.Tests;


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

   function Distance_1 (X1 : Birds.Samples.Sample; X2 : Birds.Samples.Sample) return Float is
      W : constant Birds.Attributes.Vector := (others => 1.0);
   begin
      return Birds.Deviations.Operators.Euclidean2 (W, X1.Attribute, X2.Attribute);
   end;

   procedure KNN is new CBR.Tests.KNN (Birds.Samples.Sample, Birds.Samples.Index, Birds.Samples.Vector, Birds.Samples.Index_Array, Distance_1);


   Asset_Vector : Birds.Samples.Vector (1 .. 20);
   Test_Vector : Birds.Samples.Vector (22 .. 25);
   Nearest : Birds.Samples.Index_Array (1 .. 10);

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


   KNN (Test_Vector (25), Asset_Vector, Nearest);

   declare
      use Ada.Integer_Text_IO;
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
   begin
      for E of Nearest loop
         Put (E, 4);
         Put (" ");
         Put (Head (Asset_Vector (E).Bird'Img, 8));
      end loop;
   end;



end;

