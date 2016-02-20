with Ada.Float_Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Integer_Text_IO;

with Birds.Attributes;

package body Birds.Probabilities is


   procedure Estimate (Instance : Sample; Asset : Sample; Deviation : in out Deviations.Vector) is
      W : constant Attributes.Vector := (others => 1.0);
   begin
      for I in Deviations.Kinds.Kind loop
         Deviation (I) := Deviations.Operator_List (I) (W, Instance.Attribute, Asset.Attribute);
      end loop;
   end;

   procedure Estimate (Instance : Sample; Asset : Sample; Prospect : in out Probability) is
      W : constant Attributes.Vector := (others => 1.0);
   begin
      for I in Deviations.Kinds.Kind loop
         Prospect.Divergency (I) := Prospect.Divergency (I) + Deviations.Operator_List (I) (W, Instance.Attribute, Asset.Attribute);
      end loop;
      Prospect.Count := Prospect.Count + 1;
   end;

   function Likelihood (Prospect : Probability) return Float is
      Sum : Float := 0.0;
   begin
      for I in Prospect.Divergency'Range loop
         Sum := Sum + Prospect.Divergency (I);
      end loop;
      Sum := Sum / Float (Prospect.Divergency'Length * Prospect.Count);
      return (1.0 - Sum) * 100.0;
   end;


   procedure Put_Probability (X : Probability; Fore : Field; Aft : Field; Exp : Field; Width : Natural; Separator : String) is
      use Ada.Float_Text_IO;
      use Ada.Integer_Text_IO;
   begin
      Put (X.Count, Width);
      Put (Separator);
      Deviations.Put (X.Divergency, Fore, Aft, Exp, Separator);
      Put (Likelihood (X), Fore, Aft, Exp);
      Put (" %");
      Put (Separator);
   end;

   procedure Put_Probability_Header (Width : Natural; Separator : String) is
      use Ada.Strings.Fixed;
   begin
      Put (Tail ("Count", Width));
      Put (Separator);
      Deviations.Kinds.Put_Tail (Width, ' ', Separator);
      Put (Tail ("Likelihood", Width));
      Put (Separator);
   end;


end;
