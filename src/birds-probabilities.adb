package body Birds.Probabilities is

   procedure Estimate (Sample : Bird_Sample; Asset : Bird_Sample; Deviation : in out Deviation_Array) is
      W : Attribute_Array := (others => 1.0);
   begin
      for I in Deviation_Kind loop
         Deviation (I) := Deviation_Operator_List (I) (W, Sample.Attribute, Asset.Attribute);
      end loop;
   end;

   procedure Estimate (Sample : Bird_Sample; Asset : Bird_Sample; Probability : in out Bird_Probability) is
      W : Attribute_Array := (others => 1.0);
   begin
      for I in Deviation_Kind loop
         Probability.Deviation (I) := Probability.Deviation (I) + Deviation_Operator_List (I) (W, Sample.Attribute, Asset.Attribute);
      end loop;
      Probability.Count := Probability.Count + 1;
   end;

   function Likelihood (Probability : in out Bird_Probability) return Float is
      Sum : Float := 0.0;
   begin
      for I in Deviation_Kind loop
         Sum := Sum + Probability.Deviation (I);
      end loop;
      Sum := Sum / Float (Sample_Array'Length * Deviation_Array'Length);
      return Sum;
   end;

end;
