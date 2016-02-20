with CBR.Distances;
with Birds;
with Birds.Attributes;
with Texts;

package Birds.Deviations is

   use Birds;
   use CBR;

   function Euclidean2   is new Distances.Generic_Deviation (Attributes.Kinds.Kind, Attributes.Vector, Distances.Euclidean2);
   function Manhattan    is new Distances.Generic_Deviation (Attributes.Kinds.Kind, Attributes.Vector, Distances.Manhattan);
   function Canberra     is new Distances.Generic_Deviation (Attributes.Kinds.Kind, Attributes.Vector, Distances.Canberra);
   function Tanh        is new Distances.Generic_Deviation (Attributes.Kinds.Kind, Attributes.Vector, Distances.Tanh);
   function Tan          is new Distances.Generic_Deviation (Attributes.Kinds.Kind, Attributes.Vector, Distances.Tan);
   type Operator is access function (W, X1, X2 : Attributes.Vector) return Float;

   package Kinds is
      type Kind is (Euclidean2, Manhattan, Canberra, Tanh, Tan);
      procedure Put_Head is new Texts.Generic_Put_All_Enum_Head (Kinds.Kind);
      procedure Put_Tail is new Texts.Generic_Put_All_Enum_Tail (Kinds.Kind);
      procedure Put_Head is new Texts.Generic_Put_Enum_Head (Kinds.Kind);
      procedure Put_Tail is new Texts.Generic_Put_Enum_Tail (Kinds.Kind);
   end;


   Operator_List : constant array (Deviations.Kinds.Kind) of Operator :=
     (
      Euclidean2'Access,
      Manhattan'Access,
      Canberra'Access,
      Tanh'Access,
      Tan'Access
     );

   type Unconstrained_Vector is array (Deviations.Kinds.Kind range <>) of Float;
   subtype Vector is Unconstrained_Vector (Deviations.Kinds.Kind);


   procedure Put is new Texts.Generic_Put_Digit_Vector (Float, Deviations.Kinds.Kind, Unconstrained_Vector);

   procedure Dummy;

end;
