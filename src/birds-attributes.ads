with Texts;

package Birds.Attributes is

   type Kind is (Freq1, Freq2);
   type Vector is array (Kind) of Float;

   procedure Put_Kind is new Texts.Generic_Put_Enum_Value (Kind);
   procedure Put_Kind is new Texts.Generic_Put_Enum (Kind, Put_Kind);

   procedure Dummy;

end;
