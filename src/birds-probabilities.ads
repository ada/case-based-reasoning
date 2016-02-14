with Birds.Samples;
with Birds.Deviations;

package Birds.Probabilities is

   use Birds.Samples;


   type Probability is record
      Count : Natural := 0;
      Divergency : Deviations.Vector := (others => 0.0);
   end record;

   type Probability_Collection is array (Kind) of Probability;

   procedure Estimate (Instance : Sample; Asset : Sample; Deviation : in out Deviations.Vector);
   procedure Estimate (Instance : Sample; Asset : Sample; Prospect : in out Probability);
   function Likelihood (Prospect : Probability) return Float;


   procedure Put_Probability (X : Probability; Width : Natural; Separator : String);
   procedure Put_Probability_Header (Width : Natural; Separator : String);



end;
