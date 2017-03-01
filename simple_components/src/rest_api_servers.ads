--                                                                    --
--  package Test_HTTP_Servers       Copyright (c)  Dmitry A. Kazakov  --
--  Test server                                    Luebeck            --
--  Interface                                      Winter, 2012       --
--                                                                    --
--                                Last revision :  08:20 11 Jan 2015  --
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

with GNAT.Sockets;               use GNAT.Sockets;
with GNAT.Sockets.Server;        use GNAT.Sockets.Server;

with GNAT.Sockets.Connection_State_Machine.HTTP_Server;
use  GNAT.Sockets.Connection_State_Machine.HTTP_Server;

package Rest_Api_Servers is
   Max_File_Path : constant := 4 * 1024;

   type Api_HTTP_Factory
        (Request_Length  : Positive;
         Input_Size      : Buffer_Length;
         Output_Size     : Buffer_Length;
         Max_Connections : Positive
        ) is new Connections_Factory with private;
   function Create
            (Factory  : access Api_HTTP_Factory;
             Listener : access Connections_Server'Class;
             From     : Sock_Addr_Type
            ) return Connection_Ptr;
   type Api_Client
        (Listener       : access Connections_Server'Class;
         Request_Length : Positive;
         Input_Size     : Buffer_Length;
         Output_Size    : Buffer_Length
        ) is new HTTP_Client with private;
   procedure Do_Get  (Client : in out Api_Client);
   procedure Initialize (Client : in out Api_Client);

private
   type Api_HTTP_Factory
        (Request_Length  : Positive;
         Input_Size      : Buffer_Length;
         Output_Size     : Buffer_Length;
         Max_Connections : Positive
        ) is new Connections_Factory with null record;

   type Api_Client
        (Listener        : access Connections_Server'Class;
         Request_Length  : Positive;
         Input_Size      : Buffer_Length;
         Output_Size     : Buffer_Length
        ) is new HTTP_Client
                  (Listener       => Listener,
                   Request_Length => Request_Length,
                   Input_Size     => Input_Size,
                   Output_Size    => Output_Size
                  ) with null record;

end Rest_Api_Servers;
