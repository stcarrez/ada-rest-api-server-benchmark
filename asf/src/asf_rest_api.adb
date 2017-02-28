-----------------------------------------------------------------------
--  asf_rest_api -- Rest API Benchmark for Ada Server Faces with AWS
--  Copyright (C) 2017 Stephane Carrez
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

with ASF.Server.Web;
with ASF.Servlets.Rest;
with ASF.Servlets.Files;
with ASF.Applications;
with Util.Log.Loggers;
with Rest_Api;
with EL.Contexts.Default;

procedure ASF_Rest_Api is
   CONFIG_PATH  : constant String := "samples.properties";

   Api     : aliased ASF.Servlets.Rest.Rest_Servlet;
   Files   : aliased ASF.Servlets.Files.File_Servlet;
   App     : aliased ASF.Servlets.Servlet_Registry;
   WS      : ASF.Server.Web.AWS_Container;
   Ctx     : EL.Contexts.Default.Default_Context;
   Log     : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("Api_Server");
begin
   Util.Log.Loggers.Initialize (CONFIG_PATH);
   App.Set_Init_Parameter (ASF.Applications.VIEW_DIR, "samples/web/monitor");

   --  Register the servlets and filters
   App.Add_Servlet (Name => "api", Server => Api'Unchecked_Access);
   App.Add_Servlet (Name => "files", Server => Files'Unchecked_Access);

   --  Define servlet mappings
   App.Add_Mapping (Name => "api", Pattern => "/api/*");

   Rest_Api.Benchmark_API.Register (App, "api", Ctx);

   WS.Register_Application ("/api", App'Unchecked_Access);

   Log.Info ("Connect you browser to: http://localhost:8080/api");

   WS.Start;

   delay 6000.0;

end ASF_Rest_Api;
