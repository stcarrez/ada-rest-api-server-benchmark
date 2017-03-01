--  Copyright 2013, 2014 Simon Wright <simon@pushface.org>
--
--  This unit is free software; you can redistribute it and/or modify
--  it as you wish. This unit is distributed in the hope that it will
--  be useful, but WITHOUT ANY WARRANTY; without even the implied
--  warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

with Ada.Text_IO; use Ada.Text_IO;
with EWS.Server;
with EWS.Dynamic;
with GNAT.Command_Line;

with Rest_Api;

procedure EWS_Rest_Api is
   use EWS;
   Verbose : Boolean := False;
begin
   begin
      loop
         case GNAT.Command_Line.Getopt ("v") is
            when 'v' =>
               Verbose := True;
            when ASCII.NUL =>
               exit;
            when others =>
               null;  -- never taken
         end case;
      end loop;
   exception
      when GNAT.Command_Line.Invalid_Switch =>
         Put_Line (Standard_Error,
                   "invalid switch -" & GNAT.Command_Line.Full_Switch);
         return;
   end;

   Dynamic.Register (Rest_Api.Get'Access, "/api");

   Server.Serve (Using_Port => 8080,
                 With_Stack => 40_000,
                 Tracing => Verbose);

   delay 1_000_000.0;

end EWS_Rest_Api;
