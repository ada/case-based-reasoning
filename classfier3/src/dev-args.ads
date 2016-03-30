package Dev.Args is
   function Find_Argument (F : String) return Natural;
   function Get (P : in out Positive; To : out Float) return Boolean;
   function Get_Argument_Value (P : Positive) return String;
end;
