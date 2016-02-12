with Ada.Numerics.Real_Arrays;

package CBR.Distances is

   use Ada.Numerics.Real_Arrays;

   type Distance_Kind is (Euclidean2_Kind, Manhattan_Kind, Canberra_Kind, Mixed_Kind);

   type Distance_Collection is array (Distance_Kind) of Float;

   function Euclidean2_Distance (X1, X2 : Float) return Float;
   function Manhattan_Distance (X1, X2 : Float) return Float;
   function Canberra_Distance (X1, X2 : Float) return Float;
   function Mixed_Distance (X1, X2 : Float) return Float;

   function Manhattan_Deviation (W, A, B : Real_Vector) return Float;
   function Euclidean2_Deviation (W, A, B : Real_Vector) return Float;
   function Canberra_Deviation (W, A, B : Real_Vector) return Float;
   function Mixed_Deviation (W, A, B : Real_Vector) return Float;

end;
