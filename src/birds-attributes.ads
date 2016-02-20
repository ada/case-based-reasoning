package Birds.Attributes is

   package Kinds is
      type Kind is (Freq1, Freq2);
      procedure Put_Head is new Texts.Generic_Put_All_Enum_Head (Kinds.Kind);
      procedure Put_Tail is new Texts.Generic_Put_All_Enum_Tail (Kinds.Kind);
      procedure Put_Head is new Texts.Generic_Put_Enum_Head (Kinds.Kind);
      procedure Put_Tail is new Texts.Generic_Put_Enum_Tail (Kinds.Kind);
   end;


   type Unconstrained_Vector is array (Kinds.Kind range <>) of Float;
   subtype Vector is Unconstrained_Vector (Kinds.Kind);



   procedure Put is new Texts.Generic_Put_Digit_Vector (Float, Kinds.Kind, Unconstrained_Vector);

   procedure Dummy;

end;
