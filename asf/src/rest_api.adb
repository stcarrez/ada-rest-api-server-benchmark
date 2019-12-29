-----------------------------------------------------------------------
--  rest_api - REST API with Ada Servlet
--  Copyright (C) 2017, 2019 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
-----------------------------------------------------------------------
with Servlet.Responses;
package body Rest_Api is

   procedure Get (Req    : in out Servlet.Rest.Request'Class;
                  Reply  : in out Servlet.Rest.Response'Class;
                  Stream : in out Servlet.Rest.Output_Stream'Class) is
      pragma Unreferenced (Req);
   begin
      --  Write the JSON/XML document.
      Stream.Start_Document;
      Stream.Start_Entity ("");
      Stream.Write_Entity ("greeting", "Hello World!");
      Stream.End_Entity ("");
      Stream.End_Document;

   exception
      when others =>
         Reply.Set_Status (Servlet.Responses.SC_NOT_FOUND);
   end Get;

end Rest_Api;
