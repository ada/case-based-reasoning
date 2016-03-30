package body CBR is

   procedure Calc_Distance (Item : in out Asset_Vector; Sample : Asset; Kind : Distances.Kinds.Kind; W : Float_Vector) is
      use Distance_Vectors;
      use Dev.Math.Distances;
   begin
      for E : Asset of Item loop
         Append (E.Dis, Distance_Select (E.Point, Sample.Point, W, Kind));
      end loop;
   end;

   procedure Calc_Distance (Item : in out Asset_Vector; Sample : Asset_Vector; Kind : Distances.Kinds.Kind; W : Float_Vector) is
   begin
      for E : Asset of Sample loop
         Calc_Distance (Item, E, Kind, W);
      end loop;
   end;

   procedure Calc_Prominent (Item : in out Asset_Vector) is
      use Class_Vectors;
      S : Class_Vector;
      M : Integer := -1;
      T : Integer := 0;
      N : constant Count_Type := 10;
   begin
      S := To_Vector (0, N);
      for E : Asset of Item loop
         S (E.Class) := S (E.Class) + 1;
         if M = S (E.Class) then
            T := 0;
         elsif M < S (E.Class) then
            M := S (E.Class);
            T := E.Class;
         end if;
         E.Prominent := T;
      end loop;
   end;

   procedure Sort_Distance (Item : in out Asset_Vector; Index : Natural) is
      function "<" (A, B : Asset) return Boolean is (A.Dis (Index) < B.Dis (Index));
      package Sorting is new Asset_Vectors.Generic_Sorting ("<");
   begin
      Sorting.Sort (Item);
   end;

   procedure Summarize (Summation : in out Prominent_Vector; Estimations : Asset_Vector) is
   begin
      for I in Summation.First_Index .. Natural'Min (Summation.Last_Index, Estimations.Last_Index) loop
         Summation (I).P (Estimations (I).Prominent) := Summation (I).P (Estimations (I).Prominent) + 1;
      end loop;
   end;

   procedure Initialize (Item : in out Prominent_Vector; Class_Count : Natural; K_Count : Natural) is
      use Prominent_Vectors;
      use Class_Vectors;
      P : Prominent;
   begin
      P.P := To_Vector (0, Count_Type (Class_Count));
      Item := To_Vector (P, Count_Type (K_Count));
   end;

   function Max_Class (Item : Asset_Vector) return Natural is
      S : Natural := 0;
   begin
      for E : Asset of Item loop
         S := Natural'Max (S, E.Class);
      end loop;
      return S;
   end;

   function Dim_Count_Max (Item : Asset_Vector) return Natural is
      S : Natural := 0;
   begin
      for E : Asset of Item loop
         S := Natural'Max (S, Natural (E.Point.Length));
      end loop;
      return S;
   end;

   function Dim_Count_Min (Item : Asset_Vector) return Natural is
      S : Natural := Natural'Last;
   begin
      for E : Asset of Item loop
         S := Natural'Min (S, Natural (E.Point.Length));
      end loop;
      return S;
   end;

   function Evaluate (Item : in out Prominent; X : Asset_Vector) return Natural is
      S : Natural := 0;
   begin
      for E : Asset of X loop
         if Item.P (E.Class) > 0 then
            Item.P (E.Class) := Item.P (E.Class) - 1;
            S := S + 1;
         end if;
      end loop;
      return S;
   end;

   procedure Evaluate (Item : in out Prominent_Vector; Sample : Asset_Vector; Correctness : out Natural_Vector) is
      use Natural_Vectors;
   begin
      for E : Prominent of Item loop
         Append (Correctness, Evaluate (E, Sample));
      end loop;
   end;

   function Unique_Class_Count (Item : Asset_Vector) return Natural is
      use Natural_Vectors;
      N : Natural_Vector := To_Vector (0, Count_Type (Max_Class (Item)));
      R : Natural := 0;
   begin
      for E : Asset of Item loop
         N (E.Class) := N (E.Class) + 1;
      end loop;
      for E : Natural of N loop
         if E > 0 then
            R := R + 1;
         end if;
      end loop;
      return R;
   end;

end;
