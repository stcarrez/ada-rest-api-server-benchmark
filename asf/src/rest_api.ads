-----------------------------------------------------------------------
--  rest_api - REST API with Ada Server Faces
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
with Ada.Calendar;
with ASF.Rest.Definition;
package Rest_Api is

   type Mon is new Natural;

   --  Get operation
   procedure Get (D      : in out Mon;
                  Req    : in out ASF.Rest.Request'Class;
                  Reply  : in out ASF.Rest.Response'Class;
                  Stream : in out ASF.Rest.Output_Stream'Class);

   package Benchmark_API is new ASF.Rest.Definition (Object_Type => Mon,
                                                     URI         => "/api");

private

   --  Declare each REST API with a relative URI from Benchmark_API definition.
   --  GET /api
   package Benchmark_Test is
      new Benchmark_API.Definition (Handler    => Get'Access,
                                    Method     => ASF.Rest.GET,
                                    Pattern    => "",
                                    Permission => 0);

end Rest_Api;
