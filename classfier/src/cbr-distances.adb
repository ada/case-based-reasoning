with Ada.Numerics.Elementary_Functions;

package body CBR.Distances is

   function Euclidean2 (A, B : Float) return Float is
   begin
      return (A - B) ** 2;
   end;

   function Canberra (A, B : Float) return Float is
   begin
      return (if A - B = 0.0 then 0.0 else abs (A - B) / (abs A + abs B));
   end;

   function Manhattan (A, B : Float) return Float is
   begin
      return abs (A - B);
   end;

   function Euclidean2 (W, A, B : Float_Array) return Float is
      S : Float := 0.0;
   begin
      for I in W'Range loop
         S := S + W (I) * Euclidean2 (A (I), B (I));
      end loop;
      return S;
   end;

   function Euclidean1 (W, A, B : Float_Array) return Float is
      use Ada.Numerics.Elementary_Functions;
      S : Float := 0.0;
   begin
      for I in W'Range loop
         S := S + W (I) * Sqrt (Euclidean2 (A (I), B (I)));
      end loop;
      return S;
   end;

   function Canberra (W, A, B : Float_Array) return Float is
      use Ada.Numerics.Elementary_Functions;
      S : Float := 0.0;
   begin
      for I in W'Range loop
         S := S + W (I) * Canberra (A (I), B (I));
      end loop;
      return S;
   end;

   function Manhattan (W, A, B : Float_Array) return Float is
      S : Float := 0.0;
   begin
      for I in W'Range loop
         S := S + W (I) * Manhattan (A (I), B (I));
      end loop;
      return S;
   end;

end;
