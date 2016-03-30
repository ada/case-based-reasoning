with Ada.Assertions;
with Ada.Text_IO;
with Ada.Float_Text_IO;

package body Dev.Math is

   procedure Dummy is null;

   function Normalize (Value : Float; Min, Max : Float) return Float is
      use Ada.Assertions;
   begin
      Assert (Min - Max /= 0.0, "Normalize Min - Max = 0.0");
      return (Value - Min) / (Max - Min);
   end;

   procedure Normalize (X : in out Float_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
   begin
      for I in X.First_Index .. X.Last_Index loop
         X (I) := Normalize (X (I), Min (I), Max (I));
      end loop;
   end;

   procedure Find_Min_Max (X : Float_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
   begin
      for I in X.First_Index .. X.Last_Index loop
         Min (I) := Float'Min (X (I), Min (I));
         Max (I) := Float'Max (X (I), Max (I));
      end loop;
   end;



end;
