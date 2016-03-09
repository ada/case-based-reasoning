package body CBR.Distances is

   function Euclidean2 (A, B : Float) return Float is
   begin
      return (A - B) ** 2;
   end;

   function Euclidean2 (W, A, B : Float_Array) return Float is
      S : Float := 0.0;
   begin
      for I in W'Range loop
         S := S + W (I) * Euclidean2 (A (I), B (I));
      end loop;
      return S;
   end;


end;
