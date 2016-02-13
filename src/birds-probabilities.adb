with Ada.Float_Text_IO;
with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Integer_Text_IO;

package body Birds.Probabilities is

   procedure Estimate (Instance : Sample; Asset : Sample; Deviation : in out Deviations.Vector) is
      W : Attributes.Vector := (others => 1.0);
   begin
      for I in Deviations.Kind loop
         Deviation (I) := Deviations.Operator_List (I) (W, Instance.Attribute, Asset.Attribute);
      end loop;
   end;

   procedure Estimate (Instance : Sample; Asset : Sample; Prospect : in out Probability) is
      W : Attributes.Vector := (others => 1.0);
   begin
      for I in Deviations.Kind loop
         Prospect.Divergency (I) := Prospect.Divergency (I) + Deviations.Operator_List (I) (W, Instance.Attribute, Asset.Attribute);
      end loop;
      Prospect.Count := Prospect.Count + 1;
   end;

   function Likelihood (Prospect : Probability) return Float is
      Sum : Float := 0.0;
   begin
      for I in Deviations.Kind loop
         Sum := Sum + Prospect.Divergency (I);
      end loop;
      --Sum := Sum / Float (Sample_Array'Length * Deviation_Array'Length);
      return Sum;
   end;

   procedure Put_Deviation_Kind (X : Deviations.Kind; Width : Natural) is
      use Ada.Strings.Fixed;
      use Ada.Text_IO;
      Trim_Right : constant Natural := 5;
   begin
      Put (Tail (X'Img (X'Img'First .. X'Img'Last - Trim_Right), Width));
   end;

   procedure Put_Deviation_Kind (Width : Natural; Separator : String) is
      use Ada.Text_IO;
   begin
      for I in Deviations.Kind loop
         Put_Deviation_Kind (I, Width);
         Put (Separator);
      end loop;
   end;

   procedure Put_Deviation_Array (X : Deviations.Vector; Width : Natural; Separator : String) is
      use Ada.Float_Text_IO;
      use Ada.Text_IO;
   begin
      for I in X'Range loop
         Put (X (I), 4, Width - 5, 0);
         Put (Separator);
      end loop;
   end;

   procedure Put_Probability (X : Probability; Width : Natural; Separator : String) is
      use Ada.Float_Text_IO;
      use Ada.Text_IO;
      use Ada.Integer_Text_IO;
   begin
      Put (X.Count, Width);
      Put (Separator);
      Put_Deviation_Array (X.Divergency, Width, Separator);
      Put (Likelihood (X), 4, Width - 5, 0);
      Put (Separator);
   end;

   procedure Put_Probability_Header (Width : Natural; Separator : String) is
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
   begin
      Put (Tail ("Class", Width));
      Put (Separator);
      Put (Tail ("Sample-Count", Width));
      Put (Separator);
      Put_Deviation_Kind (Width, Separator);
      Put (Tail ("Likelihood", Width));
      Put (Separator);
   end;


end;
