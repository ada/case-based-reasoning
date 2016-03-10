with Ada.Text_IO;
with CBR.Generic_Samples;
with CBR.Distances;
with Sortings;

procedure Main is

   subtype Class is Integer range 0 .. 2;
   package Samples is new CBR.Generic_Samples (Class => Class, Number_Of_Dimension => 2, Unknown_Class => 0);
   procedure Swap is new Sortings.Generic_Swap (Samples.Sample);

   procedure Begin_Compare (X : in out Samples.Sample_Array; El : in out Samples.Election_Array; A : Samples.Feature_Vector) is
      use Ada.Text_IO;
      W : constant Samples.Feature_Vector := (others => 1.0);
   begin
      for E of X loop
         E.Distance := CBR.Distances.Euclidean2 (W, E.Point, A);
      end loop;
      Samples.Sort (X);
      Samples.Summarize (X);
      Samples.Elect (X, El);
      New_Line;
      Samples.Put (X (X'First .. X'First + 10), El);
   end;

   procedure Begin_Compare (X : in out Samples.Sample_Array; A : Samples.Sample_Array) is
      use Ada.Text_IO;
      El : Samples.Election_Array (X'Range);
   begin
      New_Line;
      Put_Line ("Assets");
      Samples.Put (X, El);
      for E of A loop
         Begin_Compare (X, El, E.Point);
      end loop;
   end;

   X : Samples.Sample_Array (1 .. 100);
   Last : Integer;

begin

   declare
      use Ada.Text_IO;
   begin
      Samples.Read_Point ("AN.csv", 1, Last, X);
      Samples.Read_Point ("BN.csv", 2, Last, X);
      Samples.Read_Class ("R.csv", Last, X);
      Swap (X(1), X(4));
      Begin_Compare (X (X'First + 2 .. Last), X (X'First .. X'First + 1));
   end;

end;
