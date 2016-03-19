with Ada.Text_IO;
with CBR.Generic_Samples;
with Sortings;
with CBR;
with Ada.Integer_Text_IO;

procedure Main_CBR_Load is

   subtype Dimension is Positive range 1 .. Number_Of_Dimensions;
   subtype Class is Natural range 0 .. Number_Of_Classes;
   package Samples is new CBR.Generic_Samples (Class => Class, Dimension => Dimension, Unknown_Class => Class'First);
   procedure Swap is new Sortings.Generic_Swap (Samples.Sample);

   procedure Begin_Compare (X : in out Samples.Sample_Array; El : in out Samples.Election_Array; A : Samples.Feature_Vector) is
      use Ada.Text_IO;
   begin
      for E of X loop
         E.Distance := Weighted_Distance (Weight, CBR.Float_Array (E.Point), CBR.Float_Array (A));
      end loop;
      Samples.Sort (X);
      Samples.Summarize (X);
      Samples.Elect (X, El);
      New_Line;
      Samples.Put (X (X'First .. X'Last), El);
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

   X : Samples.Sample_Array (1 .. Maximum_Number_Of_Assets);
   Last : Integer := Maximum_Number_Of_Assets;

begin

   declare
      use Ada.Text_IO;
      use Ada.Integer_Text_IO;
      Local_Last : Integer;
   begin
      for I in Dimension loop
         Put ("Loading ");
         Put (Get_Dimension_File_Name (I));
         New_Line;
         Samples.Read_Point (Get_Dimension_File_Name (I), I, Local_Last, X);
         Last := Integer'Min (Last, Local_Last);
      end loop;

      Samples.Read_Class (Class_File_Name, Local_Last, X);
      Last := Integer'Min (Last, Local_Last);

      for I in 1 .. Number_Of_Samples loop
         Put ("Swapping ");
         Put (I, 2);
         Put (Get_Sample_Index (I), 2);
         New_Line;
         Swap (X (I), X (Get_Sample_Index (I)));
      end loop;

      Begin_Compare (X (X'First + Number_Of_Samples .. Last), X (X'First .. X'First + Number_Of_Samples - 1));
   end;

end;
