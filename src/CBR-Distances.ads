package CBR.Distances is

   function Euclidean2 (X1, X2 : Float) return Float;
   function Manhattan (X1, X2 : Float) return Float;
   function Canberra (X1, X2 : Float) return Float;
   function Mixed (X1, X2 : Float) return Float;
   function Experimental (X1, X2 : Float) return Float;
   function Canal (X1, X2 : Float) return Float;
   function Tan (X1, X2 : Float) return Float;

   generic
      type Index is (<>);
      type Vector is array (Index) of Float;
      with function Distance (X1, X2 : Float) return Float;
   function Generic_Deviation (W, A, B : Vector) return Float;

end;
