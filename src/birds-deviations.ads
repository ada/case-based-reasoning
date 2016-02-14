with CBR.Distances;
with Birds;
with Birds.Attributes;

package Birds.Deviations is

   use Birds;
   use CBR;

   function Euclidean2   is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Euclidean2);
   function Manhattan    is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Manhattan);
   function Canberra     is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Canberra);
   function Canal        is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Canal);
   function Tan          is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Tan);
   function Mixed        is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Mixed);
   function Experimental is new Distances.Generic_Deviation (Attributes.Kind, Attributes.Vector, Distances.Experimental);
   type Operator is access function (W, X1, X2 : Attributes.Vector) return Float;
   type Kind is (Euclidean2_Kind, Manhattan_Kind, Canberra_Kind, Canal_Kind, Tan_Kind, Mixed_Kind, Experimental_Kind);
   Operator_List : constant array (Deviations.Kind) of Operator :=
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

   procedure Put_Kind (X : Deviations.Kind; Width : Natural);
   procedure Put_Kind (Width : Natural; Separator : String);
   procedure Put_Vector (X : Deviations.Vector; Width : Natural; Separator : String);
end;
