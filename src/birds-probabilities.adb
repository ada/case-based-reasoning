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
         Deviation (I) := Deviations.Operators.List (I) (W, Instance.Attribute, Asset.Attribute);
      end loop;
   end;

   procedure Estimate (Instance : Sample; Asset : Sample; Prospect : in out Probability) is
      W : constant Attributes.Vector := (others => 1.0);
   begin
      for I in Deviations.Kinds.Kind loop
         Prospect.Divergency (I) := Prospect.Divergency (I) + Deviations.Operators.List (I) (W, Instance.Attribute, Asset.Attribute);
      end loop;
      Prospect.Count := Prospect.Count + 1;
   end;

   function Likelihood (Item : Probability) return Float is
      Sum : Float := 0.0;
   begin
      for I in Item.Divergency'Range loop
         Sum := Sum + Item.Divergency (I);
      end loop;
      Sum := Sum / Float (Item.Divergency'Length * Item.Count);
      return (1.0 - Sum) * 100.0;
   end;


   procedure Put_Probability (Item : Probability; Fore : Field; Aft : Field; Exp : Field; Width : Natural; Separator : String) is
      use Ada.Float_Text_IO;
      use Ada.Integer_Text_IO;
      use Birds.Deviations;
   begin
      Put (Item.Count, Width);
      Put (Separator);
      Put (Item.Divergency, Fore, Aft, Exp, Separator);
      Put (Likelihood (Item), Fore, Aft, Exp);
      Put (" %");
      Put (Separator);
   end;

   procedure Put_Probability_Header (Width : Natural; Separator : String) is
      use Ada.Strings.Fixed;
      use Birds.Deviations.Kinds;
   begin
      Put (Tail ("Count", Width));
      Put (Separator);
      Put_Tail (Width, ' ', Separator);
      Put (Tail ("Likelihood", Width));
      Put (Separator);
   end;


end;
