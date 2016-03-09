package Sortings is

   generic
      type Element is private;
   procedure Generic_Swap (A, B : in out Element);

   generic
      type Index is (<>);
      type Element is private;
      type Vector is array (Index range <>) of Element;
      with function "<" (Left, Right : Element) return Boolean is <>;
      with function ">" (Left, Right : Element) return Boolean is <>;
   procedure Generic_Quicksort (Item : in out Vector);

end;
