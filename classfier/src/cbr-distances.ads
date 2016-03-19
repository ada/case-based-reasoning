package CBR.Distances is

   function Euclidean1 (W, A, B : Float_Array) return Float;
   function Euclidean2 (W, A, B : Float_Array) return Float;
   function Canberra (W, A, B : Float_Array) return Float;
   function Manhattan (W, A, B : Float_Array) return Float;

end;
