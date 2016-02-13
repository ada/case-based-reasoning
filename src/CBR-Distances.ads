package CBR.Distances is

   function Euclidean2_Distance (X1, X2 : Float) return Float;
   function Manhattan_Distance (X1, X2 : Float) return Float;
   function Canberra_Distance (X1, X2 : Float) return Float;
   function Mixed_Distance (X1, X2 : Float) return Float;

   generic
      type Index is (<>);
      type Vector is array (Index) of Float;
      with function Distance (X1, X2 : Float) return Float;
   function Generic_Deviation (W, A, B : Vector) return Float;

end;
