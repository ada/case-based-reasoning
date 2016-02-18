with Ada.Float_Text_IO;

package body Birds.Attributes is


   procedure Put_Attribute (X : Float; Width : Natural) is
      use Ada.Float_Text_IO;
      Right : constant Natural := 4;
   begin
      Put (X, 4, Width - Right - 1, 0);
   end;


end;
