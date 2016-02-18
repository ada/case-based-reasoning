with Texts;

package Birds is

   type Kind is (Blahake, Bofink);

   procedure Put_Kind is new Texts.Generic_Put_Enum_Value (Kind);
   procedure Put_Kind is new Texts.Generic_Put_Enum (Kind, Put_Kind);

   procedure Dummy;

end;
