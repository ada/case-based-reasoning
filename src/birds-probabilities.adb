with Ada.Float_Text_IO;
with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;

package body Birds.Probabilities is

   procedure Estimate (Instance : Sample; Asset : Sample; Deviation : in out Deviation_Array) is
      W : Attribute_Array := (others => 1.0);
   begin
      for I in Deviation_Kind loop
         Deviation (I) := Deviation_Operator_List (I) (W, Instance.Attribute, Asset.Attribute);
      end loop;
   end;

   procedure Estimate (Instance : Sample; Asset : Sample; Prospect : in out Probability) is
      W : Attribute_Array := (others => 1.0);
   begin
      for I in Deviation_Kind loop
         Prospect.Divergency (I) := Prospect.Divergency (I) + Deviation_Operator_List (I) (W, Instance.Attribute, Asset.Attribute);
      end loop;
      Prospect.Count := Prospect.Count + 1;
   end;

   function Likelihood (Prospect : in out Probability) return Float is
      Sum : Float := 0.0;
   begin
      for I in Deviation_Kind loop
         Sum := Sum + Prospect.Divergency (I);
      end loop;
      Sum := Sum / Float (Sample_Array'Length * Deviation_Array'Length);
      return Sum;
   end;

   procedure Put_Deviation_Kind (Width : Natural; Separator : String) is
      use Ada.Strings.Fixed;
      use Ada.Text_IO;
   begin
      for I in Deviation_Kind loop
         Put (Tail (I'Img, Width));
         Put (Separator);
      end loop;
   end;

end;