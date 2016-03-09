package body Sortings is



   procedure Generic_Swap (A, B : in out Element) is
      Temp : constant Element := A;
   begin
      A := B;
      B := Temp;
   end;

   procedure Generic_Quicksort (Item : in out Vector) is
      procedure Swap is new Generic_Swap (Element);
      pragma Suppress (Overflow_Check);
      pragma Suppress (Range_Check);
      Pivot : Element;
      Left : Index;
      Right : Index;
   begin
      if Item'Length > 1 then
         Pivot := Item (Item'Last);
         Left := Item'First;
         Right := Item'Last;
         while Left <= Right loop
            while Item (Left) < Pivot loop
               Left := Index'Succ (Left);
            end loop;
            while Item (Right) > Pivot loop
               Right := Index'Pred (Right);
            end loop;
            if Left <= Right then
               Swap (Item (Left), Item (Right));
               Left := Index'Succ (Left);
               Right := Index'Pred (Right);
            end if;
         end loop;
         Generic_Quicksort (Item (Item'First .. Right));
         Generic_Quicksort (Item (Left .. Item'Last));
      end if;
   end;




end;
