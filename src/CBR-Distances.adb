with Ada.Numerics.Elementary_Functions;

package body CBR.Distances is

   function Generic_Deviation (W, A, B : Vector) return Float is
      Sum : Float := 0.0;
   begin
      for I in Vector'Range loop
         Sum := Sum + W (I) * Distance (A (I), B (I));
      end loop;
      Sum := Sum / Float (Vector'Length);
      return Sum;
   end;

   function Euclidean2 (X1, X2 : Float) return Float is
   begin
      return (X1 - X2) ** 2;
   end;

   function Manhattan (X1, X2 : Float) return Float is
   begin
      return abs (X1 - X2);
   end;

   function Canberra (X1, X2 : Float) return Float is
   begin
      if (X1 - X2) = 0.0 then
         return 0.0;
      end if;
      return abs (X1 - X2) / (abs X1 + abs X2);
   end;


   function Tanh (X1, X2 : Float) return Float is
      use Ada.Numerics.Elementary_Functions;
   begin
      return abs Tanh (X1 - X2);
   end;


   function Tan (X1, X2 : Float) return Float is
      use Ada.Numerics.Elementary_Functions;
   begin
      return  Tan (abs (X1 - X2));
   end;


end;
