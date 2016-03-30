with Ada.Command_Line;
with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
with Ada.Strings.Maps;
with Ada.Assertions;

package body Dev.Args is

   use Ada.Assertions;
   use Ada.Command_Line;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Integer_Text_IO;

   function Find_Argument (F : String) return Natural is
      P : Natural := 0;
   begin
      loop
         if P = Argument_Count then
            return 0;
         end if;
         P := P + 1;
         if Argument (P)'Length = F'Length and then Argument (P) (1 .. F'Length) = F then
            return P;
         end if;
      end loop;
   end;


   function Get (P : in out Positive; To : out Float) return Boolean is
   begin
      To := Float'Value (Argument (P));
      P := P + 1;
      return True;
   exception
      when others => return False;
   end;


   function Get_Argument_Value (P : Positive) return String is
   begin
      if Argument (P) (1) = '-' then
         return "";
      else
         return Argument (P);
      end if;
   end;
end;
