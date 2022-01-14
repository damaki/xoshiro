--  SPDX-License-Identifier: Apache-2.0
--
--  Copyright (c) 2022 onox <denkpadje@gmail.com>
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

generic
   type Unsigned_64 is mod <>;
package Xoshiro256 with SPARK_Mode => On is
   pragma Pure;

   pragma Compile_Time_Error (Unsigned_64'Size /= 64,
                              "Invalid mod type for Xoshiro256");

   pragma Compile_Time_Error (Unsigned_64'Modulus /= 2**64,
                              "Invalid mod type for Xoshiro256");

   subtype Unit_Interval is Long_Float range 0.0 .. 1.0;

   function To_Float (Value : Unsigned_64) return Unit_Interval
     with Inline_Always,
          Global  => null,
          Depends => (To_Float'Result => Value);

   type Generator is limited private;

   procedure Next (S : in out Generator; Value : out Unsigned_64)
     with Inline_Always,
          Global  => null,
          Depends => (S => S, Value => S);

   procedure Reset (S : out Generator; Seed : Unsigned_64)
     with Global  => null,
          Depends => (S => Seed),
          Pre     => Seed /= 0;

private

   type Generator is array (0 .. 3) of Unsigned_64;

end Xoshiro256;
