with Ada.Text_IO;


package Texts is

   use Ada.Text_IO;


   generic
      type Enum is (<>);
   procedure Generic_Put_Enum_Head (Item : Enum; Width : Natural; Pad : Character);

   generic
      type Enum is (<>);
   procedure Generic_Put_Enum_Tail (Item : Enum; Width : Natural; Pad : Character);

   generic
      type Enum is (<>);
   procedure Generic_Put_All_Enum_Head (Width : Field; Pad : Character; Separator : String);

   generic
      type Enum is (<>);
   procedure Generic_Put_All_Enum_Tail (Width : Field; Pad : Character; Separator : String);

   generic
      type Element is digits <>;
      type Index is (<>);
      type Vector is array (Index range <>) of Element;
   procedure Generic_Put_Digit_Vector (Item : Vector; Fore : Field; Aft : Field; Exp : Field; Separator : String);

   generic
      type Vector (<>) is limited private;
      with procedure Set (Index : Positive; Value : Float; Destination : out Vector);
   procedure Generic_Read_Float_List (Name : String; Count : Natural; Destination : out Vector; Min : out Float; Max : out Float);

end;
