package Birds is

   type Kind is (Blahake_Kind, Bofink_Kind);
   procedure Put_Kind (Width : Natural);
   procedure Put_Kind (X : Kind; Width : Natural);

end;
