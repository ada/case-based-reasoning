with CBR.Distances;
with Birds;
with Birds.Attributes;
with Texts;

package Birds.Deviations is

   use Birds;
   use CBR;

   function Euclidean2   is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Euclidean2);
   function Manhattan    is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Manhattan);
   function Canberra     is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Canberra);
   function Tanh        is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Tanh);
   function Tan          is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Tan);
   type Operator is access function (W, X1, X2 : Attributes.Vector) return Float;
   type Kind is (Euclidean2_Kind, Manhattan_Kind, Canberra_Kind, Tanh_Kind, Tan_Kind);
   Operator_List : constant array (Deviations.Kind) of Operator :=
     (
      Euclidean2'Access,
      Manhattan'Access,
      Canberra'Access,
      Tanh'Access,
      Tan'Access
     );
   type Vector is array (Kind) of Float;

   procedure Put_Kind is new Texts.Generic_Put_Enum_Value (Kind);
   procedure Put_Kind is new Texts.Generic_Put_Enum (Kind, Put_Kind);




   procedure Put_Vector (X : Deviations.Vector; Width : Natural; Separator : String);
end;
