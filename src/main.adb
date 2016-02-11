with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Numerics.Real_Arrays;
with Ada.Strings.Fixed;

procedure Main is

   package CBR_Distances is
      use Ada.Numerics.Real_Arrays;
      function Deviation_Manhattan (W, A, B : Real_Vector) return Float;
      function Deviation_Euclidean (W, A, B : Real_Vector) return Float;
      function Deviation_Canberra (W, A, B : Real_Vector) return Float;
      function Deviation_Mixed (W, A, B : Real_Vector) return Float;
   end;

   package body CBR_Distances is

      function Deviation_Euclidean (X1, X2 : Float) return Float is
      begin
         return (X1 - X2) ** 2;
      end;

      function Deviation_Manhattan (X1, X2 : Float) return Float is
      begin
         return abs (X1 - X2);
      end;

      function Deviation_Canberra (X1, X2 : Float) return Float is
      begin
         if (X1 - X2) = 0.0 then
            return 0.0;
         end if;
         return abs (X1 - X2) / (abs X1 + abs X2);
      end;

      function Deviation_Mixed (X1, X2 : Float) return Float is
         R : Float;
      begin
         R := Deviation_Euclidean (X1, X2) + Deviation_Manhattan (X1, X2) + Deviation_Canberra (X1, X2);
         R := R / 3.0;
         return R;
      end;


      function Deviation_Euclidean (W, A, B : Real_Vector) return Float is
         Sum : Float := 0.0;
      begin
         for I in A'Range loop
            Sum := Sum + W(I) * Deviation_Euclidean (A (I), B (I));
         end loop;
         Sum := Sum / Float (A'Length);
         return Sum;
      end;

      function Deviation_Manhattan (W, A, B : Real_Vector) return Float is
         Sum : Float := 0.0;
      begin
         for I in A'Range loop
            Sum := Sum + W(I) * Deviation_Manhattan (A (I), B (I));
         end loop;
         Sum := Sum / Float (A'Length);
         return Sum;
      end;

      function Deviation_Canberra (W, A, B : Real_Vector) return Float is
         Sum : Float := 0.0;
      begin
         for I in A'Range loop
            Sum := Sum + W (I) * Deviation_Canberra (A (I), B (I));
         end loop;
         Sum := Sum / Float (A'Length);
         return Sum;
      end;

      function Deviation_Mixed (W, A, B : Real_Vector) return Float is
         Sum : Float := 0.0;
      begin
         for I in A'Range loop
            Sum := Sum + W (I) * Deviation_Mixed (A (I), B (I));
         end loop;
         Sum := Sum / Float (A'Length);
         return Sum;
      end;

   end;


   package Samples is
      use Ada.Numerics.Real_Arrays;
      subtype Attribute_Type is Integer range 1 .. 3;
      subtype Sample is Real_Vector (Attribute_Type);
      type Sample_Array is array (1 .. 5) of Sample;
      procedure Read (Name : String; A : Attribute_Type; X : out Sample_Array; Min : out Float; Max : out Float);
      procedure Normalize (A : Attribute_Type; Min, Max : Float; X : in out Sample_Array);
      procedure Put (X : Sample);
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
   declare
      use Ada.Text_IO;
   begin
      Put_Line ("Sample_Array");
      for I in Sample_Array'Range loop
         Put (X (I));
         New_Line;
      end loop;
      New_Line (2);
   end;



   -- Calculate deviation between Case 1 and all other cases.
   -- The case with max value is the most similar one.
   declare
      use Ada.Float_Text_IO;
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      use CBR_Distances;
      Sum : Float := 0.0;
   begin
      Put_Line ("Deviation");
      Put (Tail ("Class", 12));
      Put ("|");
      Put (Tail ("Manhattan", 12));
      Put ("|");
      Put (Tail ("Euclidean", 12));
      Put ("|");
      Put (Tail ("Canberra", 12));
      Put ("|");
      Put (Tail ("Mixed", 12));
      Put ("|");
      New_Line;
      for I in Sample_Array'Range loop
         Put (X (I) (3), 4, 7, 0);
         Put ("|");
         Sum := Deviation_Manhattan (W, X (1) (1 .. 2), X (I) (1 .. 2));
         Put (Sum, 4, 7, 0);
         Put ("|");
         Sum := Deviation_Euclidean (W, X (1) (1 .. 2), X (I) (1 .. 2));
         Put (Sum, 4, 7, 0);
         Put ("|");
         Sum := Deviation_Canberra (W, X (1) (1 .. 2), X (I) (1 .. 2));
         Put (Sum, 4, 7, 0);
         Put ("|");
         Sum := Deviation_Mixed (W, X (1) (1 .. 2), X (I) (1 .. 2));
         Put (Sum, 4, 7, 0);
         Put ("|");
         New_Line;
      end loop;
      New_Line (2);
   end;


end;

