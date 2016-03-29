with Ada.Containers.Vectors;

package Dev.Math is

   procedure Dummy;

   subtype Distance is Float;

   package Float_Vectors is new Ada.Containers.Vectors (Natural, Float);
   subtype Float_Vector is Float_Vectors.Vector;

   procedure Find_Min_Max (X : Float_Vector; Min : in out Float_Vector; Max : in out Float_Vector);
   procedure Normalize (X : in out Float_Vector; Min : in out Float_Vector; Max : in out Float_Vector);

end;
