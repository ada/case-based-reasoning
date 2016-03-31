package Dev.Math.Distances is

   package Kinds is
      type Kind is (Unknown, Canberra, Euclidean, Euclidean2, Manhattan);
      function Value (Name : String) return Kind;
   end;

   function Equal_Index  (A : Point; B : Point; W : Weight_Vector) return Boolean;

   function Manhattan (A : Point; B : Point; W : Weight_Vector) return Distance with Pre => Equal_Index (A, B, W);
   function Canberra (A : Point; B : Point; W : Weight_Vector) return Distance with Pre => Equal_Index (A, B, W);
   function Euclidean (A : Point; B : Point; W : Weight_Vector) return Distance with Pre => Equal_Index (A, B, W);
   function Euclidean2 (A : Point; B : Point; W : Weight_Vector) return Distance with Pre => Equal_Index (A, B, W);
   function Selective (A : Point; B : Point; W : Weight_Vector; Kind : Kinds.Kind) return Distance with Pre => Equal_Index (A, B, W);

end;
