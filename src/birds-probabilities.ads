with Ada.Numerics.Real_Arrays;
with CBR.Distances;
with Birds.Samples;

package Birds.Probabilities is

   use Ada.Numerics.Real_Arrays;
   use Birds.Samples;

   function Euclidean2_Deviation is new CBR.Distances.Generic_Deviation (Attribute_Kind, Attribute_Array, CBR.Distances.Euclidean2_Distance);
   function Manhattan_Deviation is new CBR.Distances.Generic_Deviation (Attribute_Kind, Attribute_Array, CBR.Distances.Manhattan_Distance);
   function Canberra_Deviation is new CBR.Distances.Generic_Deviation (Attribute_Kind, Attribute_Array, CBR.Distances.Canberra_Distance);
   function Mixed_Deviation is new CBR.Distances.Generic_Deviation (Attribute_Kind, Attribute_Array, CBR.Distances.Mixed_Distance);

   type Deviation_Operator is access function (W, X1, X2 : Attribute_Array) return Float;
   type Deviation_Kind is (Euclidean2_Kind, Manhattan_Kind, Canberra_Kind, Mixed_Kind);

   Deviation_Operator_List : constant array (Deviation_Kind) of Deviation_Operator :=
     (
      Euclidean2_Deviation'Access,
      Manhattan_Deviation'Access,
      Canberra_Deviation'Access,
      Mixed_Deviation'Access
     );

   type Deviation_Array is array (Deviation_Kind) of Float;

   type Probability is record
      Count : Natural := 0;
      Divergency : Deviation_Array := (others => 0.0);
   end record;

   type Bird_Probability_Collection is array (Bird_Kind) of Probability;

   procedure Estimate (Instance : Sample; Asset : Sample; Deviation : in out Deviation_Array);
   procedure Estimate (Instance : Sample; Asset : Sample; Prospect : in out Probability);
   function Likelihood (Prospect : in out Probability) return Float;

   procedure Put_Deviation_Kind (Width : Natural; Separator : String);

end;