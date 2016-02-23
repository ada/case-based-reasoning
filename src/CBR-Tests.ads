package CBR.Tests is

   generic
      type Sample is private;
      type Index is range <>;
      type Sample_Array is array (Index range <>) of Sample;
      type Neighbor_Array is array (Index range <>) of Index;
      with function Distance (X1 : Sample; X2 : Sample) return Float;
   procedure KNN (S : Sample; X : Sample_Array; Y : out Neighbor_Array);


   generic
      type Index is (<>);
      Unknown : Index;
      type Index_Array is array (Integer range <>) of Index;
   procedure KNN_Summery (X : Index_Array; Y : out Index_Array);

end;
