with Birds.Samples;
with Birds.Deviations;
with Ada.Text_IO;

package Birds.Probabilities is

   use Birds.Samples;
   use Ada.Text_IO;

   type Probability is record
      Count : Natural := 0;
      Divergency : Deviations.Vector := (others => 0.0);
   end record;

   type Probability_Collection is array (Birds.Kinds.Kind) of Probability;

   procedure Estimate (Instance : Sample; Asset : Sample; Deviation : in out Deviations.Vector);
   procedure Estimate (Instance : Sample; Asset : Sample; Prospect : in out Probability);
   function Likelihood (Prospect : Probability) return Float;


   procedure Put_Probability (X : Probability; Fore : Field; Aft : Field; Exp : Field; Width : Natural; Separator : String);
   procedure Put_Probability_Header (Width : Natural; Separator : String);



end;
