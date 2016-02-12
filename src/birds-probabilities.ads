with Ada.Numerics.Real_Arrays;
with CBR.Distances;

package Birds.Probabilities is

   use Ada.Numerics.Real_Arrays;
   use CBR.Distances;


   type Bird_Probability is record
      Count : Natural := 0;
      Likeliness : Distance_Collection := (others => 0.0);
   end record;

   type Bird_Probability_Collection is array (Bird_Kind) of Bird_Probability;




end;
