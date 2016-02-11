with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics.Real_Arrays; use Ada.Numerics.Real_Arrays;

procedure Main is
   subtype Range_Total is Integer range 1 .. 5; --Number of cases
   subtype Range_Train is Range_Total range Range_Total'First .. 2; --Number of training rows
   subtype Range_Eval is Range_Total range Range_Train'Last .. Range_Total'Last; --Number of evaluation rows
   subtype Vector_Attributes is Real_Vector (1 .. 3); --Feature continer type
   type Vector_Array is array (Range_Total range <>) of Vector_Attributes;--Case container type

   procedure Read ( X : out Vector_Array; C : Positive; Name : String; Min, Max : out Float ) is
      F : File_Type;
   begin
      Min := Float'Last;
      Max := Float'First;
      Open (F, In_File, Name);

      for I in Range_Total loop
         declare
            S : String := Get_Line (F);
            V : Float := Float'Value (S);
         begin
            -- Update min max values
            if V > Max then
               Max := V;
            end if;
            if V < Min then
               Min := V;
            end if;

            X (I)(C) := V;
         end;
      end loop;

      Close (F);
   end;

   procedure Put ( X : Real_Vector;  Scientific_Notation : Integer := 0) is
   begin
      for E of X loop
         Put (E, 4, 1, Scientific_Notation);
      end loop;
   end;

   function Deviation (C, S : Float) return Float is
   begin
      return abs (C - S);
   end;

   function Deviation (W, Case_1, Case_2 : Vector_Attributes) return Float is
      Sum : Float := 0.0;
   begin
      for i in Vector_Attributes'First .. Vector_Attributes'Last - 1 loop
         Sum := Sum + W(i) * Deviation (Case_1(i), Case_2(i));
      end loop;
      return Sum;
   end;

   procedure Normalize ( X : in out Vector_Array; Col : Positive; Min, Max : Float ) is
   begin
      for I in X'Range loop
         X (I) (Col) := ( X(I)(Col) - Min ) * (1.0 - 0.0) / (Max - Min) + 0.0;
      end loop;
   end;

   C : Vector_Array (Range_Total) := (others => (others => 0.0));
   W : Vector_Attributes := (Others => 1.0); --Weight array
   Min, Max : Float := 0.0;
begin
   Read (C, 1, "A.csv", Min, Max);
   Normalize (C, 1, Min, Max);
   Read (C, 2, "B.csv", Min, Max);
   Normalize (C, 2, Min, Max);
   Read (C, 3, "R.csv", Min, Max);

   -- Print Cases with their respective attributes
   for E of C loop
      Put(E);
      New_Line;
   end loop;


   -- Calculate deviation between Case 1 and all other cases.
   -- The case with max value is the most similar one.
   declare
      S : Float := 0.0;
   begin
      for i in C'Range loop
         New_Line;
         S := Deviation (W, C(1), C(i));
         Put(S, 2, 2, 0);
      end loop;
   end;

end;
