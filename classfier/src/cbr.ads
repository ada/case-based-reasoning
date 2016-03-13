package CBR is
   type Float_Array is array (Integer range <>) of Float;
   type Weighted_Distance_Function is access function (W, A, B : Float_Array) return Float;
end;
