with Ada.Containers.Vectors;

package Dev.Math.Distances is

   package Kinds is
      type Kind is (Unknown, Canberra, Euclidean, Euclidean2, Manhattan);
      function Value (Name : String) return Kind;
   end;

   function Equal_Index  (A : Float_Vector; B : Float_Vector; W : Float_Vector) return Boolean;

   function Manhattan (A : Float_Vector; B : Float_Vector; W : Float_Vector) return Distance with Pre => Equal_Index (A, B, W);
   function Canberra (A : Float_Vector; B : Float_Vector; W : Float_Vector) return Distance with Pre => Equal_Index (A, B, W);
   function Euclidean (A : Float_Vector; B : Float_Vector; W : Float_Vector) return Distance with Pre => Equal_Index (A, B, W);
   function Euclidean2 (A : Float_Vector; B : Float_Vector; W : Float_Vector) return Distance with Pre => Equal_Index (A, B, W);
   function Distance_Select (A : Float_Vector; B : Float_Vector; W : Float_Vector; Kind : Kinds.Kind) return Distance with Pre => Equal_Index (A, B, W);

end;
