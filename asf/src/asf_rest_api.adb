-----------------------------------------------------------------------
--  asf_rest_api -- Rest API Benchmark for Ada Servlet with AWS
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

with Servlet.Server.Web;
with Servlet.Rest;
with Servlet.Core.Rest;
with AWS.Config.Set;
with Util.Log.Loggers;
with Rest_Api;

procedure ASF_Rest_Api is
   procedure Configure (Config : in out AWS.Config.Object);

   CONFIG_PATH  : constant String := "samples.properties";

   procedure Configure (Config : in out AWS.Config.Object) is
   begin
      AWS.Config.Set.Server_Port (Config, 8080);
      AWS.Config.Set.Max_Connection (Config, 8);
      AWS.Config.Set.Accept_Queue_Size (Config, 512);
   end Configure;

   Api     : aliased Servlet.Core.Rest.Rest_Servlet;
   App     : aliased Servlet.Core.Servlet_Registry;
   WS      : Servlet.Server.Web.AWS_Container;
   Log     : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("Api_Server");
begin
   Util.Log.Loggers.Initialize (CONFIG_PATH);

   --  Register the servlets and filters
   App.Add_Servlet (Name => "api", Server => Api'Unchecked_Access);

   --  Define servlet mappings
   App.Add_Mapping (Name => "api", Pattern => "/*");

   Servlet.Rest.Register (App, Rest_Api.API_Get.Definition);

   WS.Configure (Configure'Access);
   WS.Register_Application ("/api", App'Unchecked_Access);

   Log.Info ("Connect you browser to: http://localhost:8080/api/api");

   WS.Start;

   delay 6000.0;

end ASF_Rest_Api;
