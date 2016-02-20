with Texts;

package Birds is

   package Kinds is
      type Kind is (Blahake, Bofink);
      procedure Put_Head is new Texts.Generic_Put_All_Enum_Head (Kinds.Kind);
      procedure Put_Tail is new Texts.Generic_Put_All_Enum_Tail (Kinds.Kind);
      procedure Put_Head is new Texts.Generic_Put_Enum_Head (Kinds.Kind);
      procedure Put_Tail is new Texts.Generic_Put_Enum_Tail (Kinds.Kind);
   end;

   procedure Dummy;

end;
