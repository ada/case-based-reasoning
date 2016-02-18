package Texts is

   generic
      type Enum is (<>);
   procedure Generic_Put_Enum_Value (X : Enum; Width : Natural);

   generic
      type Enum is (<>);
      with procedure Put (I : Enum; Width : Natural);
   procedure Generic_Put_Enum (Width : Natural; Separator : String);


   procedure Put (Value : Float; Fore : Natural; Width : Natural);

end;
