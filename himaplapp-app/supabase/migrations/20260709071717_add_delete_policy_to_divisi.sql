CREATE POLICY "Enable delete for authenticated users" ON "public"."divisi"
FOR DELETE
TO authenticated
USING (true);
