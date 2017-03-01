--                                                                    --
--  package Test_HTTP_Servers       Copyright (c)  Dmitry A. Kazakov  --
--  Test server                                    Luebeck            --
--  Implementation                                 Winter, 2012       --
--                                                                    --
--                                Last revision :  12:25 15 May 2015  --
--                                                                    --
--  This  library  is  free software; you can redistribute it and/or  --
--  modify it under the terms of the GNU General Public  License  as  --
--  published by the Free Software Foundation; either version  2  of  --
--  the License, or (at your option) any later version. This library  --
--  is distributed in the hope that it will be useful,  but  WITHOUT  --
--  ANY   WARRANTY;   without   even   the   implied   warranty   of  --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU  --
--  General  Public  License  for  more  details.  You  should  have  --
--  received  a  copy  of  the GNU General Public License along with  --
--  this library; if not, write to  the  Free  Software  Foundation,  --
--  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.    --
--                                                                    --
--  As a special exception, if other files instantiate generics from  --
--  this unit, or you link this unit with other files to produce  an  --
--  executable, this unit does not by  itself  cause  the  resulting  --
--  executable to be covered by the GNU General Public License. This  --
--  exception  does not however invalidate any other reasons why the  --
--  executable file might be covered by the GNU Public License.       --
-- ___________________________________________________________________--

package body Rest_Api_Servers is

   function Create
            (Factory  : access Api_HTTP_Factory;
             Listener : access Connections_Server'Class;
             From     : Sock_Addr_Type
            ) return Connection_Ptr is
      pragma Unreferenced (From);
      Result : Connection_Ptr;
   begin
      if Get_Clients_Count (Listener.all) < Factory.Max_Connections then
         Result :=
            new Api_Client
                (Listener       => Listener.all'Unchecked_Access,
                 Request_Length => Factory.Request_Length,
                 Input_Size     => Factory.Input_Size,
                 Output_Size    => Factory.Output_Size
                );
         Receive_Body_Tracing   (Api_Client (Result.all), True);
         Receive_Header_Tracing (Api_Client (Result.all), True);
         return Result;
      else
         return null;
      end if;
   end Create;

   procedure Do_Get (Client : in out Api_Client) is
   begin
      Send_Status_Line (Client, 200, "OK");
      Send_Date (Client);
      Send_Server (Client);
      Send_Content_Type (Client, "application/json");
      Accumulate_Body (Client, "{""greeting"":""Hello World!""}");
      Send_Body (Client, True);
   end Do_Get;
   procedure Initialize (Client : in out Api_Client) is
   begin
      Initialize (HTTP_Client (Client));
   end Initialize;

end Rest_Api_Servers;
