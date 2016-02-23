package CBR.Tests is

   generic
      type Sample is private;
      type Index is range <>;
      type Sample_Array is array (Index range <>) of Sample;
      type Neighbor_Array is array (Index range <>) of Index;
      with function Distance (X1 : Sample; X2 : Sample) return Float;
   procedure KNN (S : Sample; X : Sample_Array; Y : out Neighbor_Array);


end;
