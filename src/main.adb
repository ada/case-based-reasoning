with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Numerics.Real_Arrays;

procedure Main is

   package Samples is
      use Ada.Numerics.Real_Arrays;
      subtype Attribute_Type is Integer range 1 .. 3;
      subtype Sample is Real_Vector (Attribute_Type);
      type Sample_Array is array (1 .. 5) of Sample;
      procedure Read (Name : String; A : Attribute_Type; X : out Sample_Array; Min : out Float; Max : out Float);
      procedure Normalize (A : Attribute_Type; Min, Max : Float; X : in out Sample_Array);
      procedure Put (X : Sample);
      function Deviation (W, A, B : Real_Vector) return Float;
   end;



   package body Samples is

      procedure Read (Name : String; A : Attribute_Type; X : out Sample_Array; Min : out Float; Max : out Float) is
         use Ada.Text_IO;
         use Ada.Float_Text_IO;
         File : File_Type;
      begin
         Min := Float'Last;
         Max := Float'First;
         Open (File, In_File, Name);
         for I in X'Range loop
            declare
               V : Float renames X (I) (A);
            begin
               Get (File, V);
               if V > Max then
                  Max := V;
               end if;
               if V < Min then
                  Min := V;
               end if;
            end;
         end loop;
         Close (File);
      end;

      function Deviation (W, X1, X2 : Float) return Float is
      begin
         return W * abs (X1 - X2);
      end;

      function Deviation (W, A, B : Real_Vector) return Float is
         Sum : Float := 0.0;
      begin
         for I in A'Range loop
            Sum := Sum + Deviation (W(I), A (I), B (I));
         end loop;
         return Sum;
      end;

      function Normalize (X : Float; Min : Float; Max : Float) return Float is
      begin
         return (X - Min) / (Max - Min);
      end;

      procedure Normalize (A : Attribute_Type; Min, Max : Float; X : in out Sample_Array) is
      begin
         for I in X'Range loop
            X (I) (A) := Normalize (X (I) (A), Min, Max);
         end loop;
      end;

      procedure Put (X : Sample) is
         use Ada.Float_Text_IO;
      begin
         for E of X loop
            Put (E, 4, 1, 0);
         end loop;
      end;

   end;

   use Samples;



   X : Sample_Array;
   W : Sample := (Others => 1.0);
   Min, Max : Float := 0.0;
begin

   Read ("A.csv", 1, X, Min, Max);
   Normalize (1, Min, Max, X);
   Read ("B.csv", 2, X, Min, Max);
   Normalize (2, Min, Max, X);
   Read ("R.csv", 3, X, Min, Max);
   Normalize (3, Min, Max, X);

   -- Print Cases with their respective attributes
   for I in Sample_Array'Range loop
      declare
         use Ada.Text_IO;
      begin
         Put (X (I));
         New_Line;
      end;
   end loop;


   -- Calculate deviation between Case 1 and all other cases.
   -- The case with max value is the most similar one.
   declare
      use Ada.Float_Text_IO;
      use Ada.Text_IO;
      Sum : Float := 0.0;
   begin
      for I in Sample_Array'Range loop
         Sum := Deviation (W, X (1) (1 .. 2), X (I) (1 .. 2));
         Put (Sum, 2, 2, 0);
         New_Line;
      end loop;
   end;


end;

