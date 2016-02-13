with CBR.Distances;
with Birds.Samples;

package Birds.Probabilities is

   use Birds.Samples;
   use CBR.Distances;

   package Deviations is
      function Euclidean2 is new Generic_Deviation (Attribute_Kind, Attribute_Array, Euclidean2_Distance);
      function Manhattan is new Generic_Deviation (Attribute_Kind, Attribute_Array, Manhattan_Distance);
      function Canberra is new Generic_Deviation (Attribute_Kind, Attribute_Array, Canberra_Distance);
      function Canal is new Generic_Deviation (Attribute_Kind, Attribute_Array, Canal_Distance);
      function Tan is new Generic_Deviation (Attribute_Kind, Attribute_Array, Tan_Distance);
      function Mixed is new Generic_Deviation (Attribute_Kind, Attribute_Array, Mixed_Distance);
      function Experimental is new Generic_Deviation (Attribute_Kind, Attribute_Array, Experimental_Distance);
      type Operator is access function (W, X1, X2 : Attribute_Array) return Float;
      type Kind is (Euclidean2_Kind, Manhattan_Kind, Canberra_Kind, Canal_Kind, Tan_Kind, Mixed_Kind, Experimental_Kind);
      Operator_List : constant array (Kind) of Operator :=
        (
         Euclidean2'Access,
         Manhattan'Access,
         Canberra'Access,
         Canal'Access,
         Tan'Access,
         Mixed'Access,
         Experimental'Access
        );
      type Vector is array (Kind) of Float;
   end;










   type Probability is record
      Count : Natural := 0;
      Divergency : Deviations.Vector := (others => 0.0);
   end record;

   type Probability_Collection is array (Bird_Kind) of Probability;

   procedure Estimate (Instance : Sample; Asset : Sample; Deviation : in out Deviations.Vector);
   procedure Estimate (Instance : Sample; Asset : Sample; Prospect : in out Probability);
   function Likelihood (Prospect : Probability) return Float;

   procedure Put_Deviation_Kind (X : Deviations.Kind; Width : Natural);
   procedure Put_Deviation_Kind (Width : Natural; Separator : String);
   procedure Put_Deviation_Array (X : Deviations.Vector; Width : Natural; Separator : String);
   procedure Put_Probability (X : Probability; Width : Natural; Separator : String);
   procedure Put_Probability_Header (Width : Natural; Separator : String);



end;
