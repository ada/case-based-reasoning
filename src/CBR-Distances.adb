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

   function Euclidean2_Distance (X1, X2 : Float) return Float is
   begin
      return (X1 - X2) ** 2;
   end;

   function Manhattan_Distance (X1, X2 : Float) return Float is
   begin
      return abs (X1 - X2);
   end;

   function Canberra_Distance (X1, X2 : Float) return Float is
   begin
      if (X1 - X2) = 0.0 then
         return 0.0;
      end if;
      return abs (X1 - X2) / (abs X1 + abs X2);
   end;

   function Mixed_Distance (X1, X2 : Float) return Float is
      R : Float;
   begin
      R := Euclidean2_Distance (X1, X2) + Manhattan_Distance (X1, X2) + Canberra_Distance (X1, X2);
      R := R / 3.0;
      return R;
   end;

   function Experimental_Distance (X1, X2 : Float) return Float is
   begin
      return (X1 - X2) ** 2 / (X1 ** 2 + X2 ** 2);
   end;



end;
