with Ada.Text_IO;
with CBR.Generic_Samples;
with CBR.Distances;
with CBR.Generic_KNN;
with Sortings;

procedure Main is

   subtype Class is Integer range 0 .. 2;
   package Samples is new CBR.Generic_Samples (Class => Class, Number_Of_Dimension => 2);
   package KNN is new CBR.Generic_KNN (Class => Class, Unknown_Class => 0);
   procedure Swap is new Sortings.Generic_Swap (Samples.Sample);

   procedure Begin_Compare (X : Samples.Sample_Array; A : Samples.Feature_Vector; K_Vote : in out KNN.Class_Vote_Array) is
      use Ada.Text_IO;
      D : KNN.Distance_Info_Array (X'Range);
      W : constant Samples.Feature_Vector := (others => 1.0);
      K : KNN.KNN_Block_Array (D'Range);
   begin
      New_Line;
      Put_Line ("Distance");
      for I in D'Range loop
         D (I).Kind := X (I).Kind;
         D (I).Distance := CBR.Distances.Euclidean2 (W, X (I).Point, A);
      end loop;
      KNN.Put (D);
      New_Line;
      Put_Line ("KNN.Sort (D)");
      KNN.Sort (D);
      KNN.Put (D);
      New_Line;
      Put_Line ("KNN.Make_Summery");
      KNN.Make_Summery (D, K);
      KNN.Put (K);
      New_Line;
      Put_Line ("KNN.Elect");
      KNN.Elect (K, K_Vote);
   end;

   procedure Begin_Compare (X : Samples.Sample_Array; A : Samples.Sample_Array) is
      use Ada.Text_IO;
      K_Vote : KNN.Class_Vote_Array (X'Range) := (others => (others => 0));
   begin
      New_Line;
      Put_Line ("Begin_Compare");
      Samples.Put (A);
      for I in A'Range loop
         Begin_Compare (X, A (I).Point, K_Vote);
      end loop;
      New_Line;
      Put_Line ("Election");
      KNN.Put (K_Vote);
   end;

   X : Samples.Sample_Array (1 .. 100);
   Last : Integer;

begin

   declare
      use Ada.Text_IO;
   begin
      New_Line;
      Put_Line ("Read_Point");
      Samples.Read_Point ("AN.csv", 1, Last, X);
      Samples.Read_Point ("BN.csv", 2, Last, X);
      Put_Line ("Read_Class");
      Samples.Read_Class ("R.csv", Last, X);
      Swap (X(1), X(4));
      New_Line;
      Put_Line ("Samples");
      Samples.Put (X);
      Begin_Compare (X (X'First + 2 .. Last), X (X'First .. X'First + 1));
   end;

end;
