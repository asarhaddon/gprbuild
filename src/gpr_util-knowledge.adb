------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                  G P R _ U T I L . K N O W L E D G E                     --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--            Copyright (C) 2010, Free Software Foundation, Inc.            --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

with GprConfig.Knowledge; use GprConfig.Knowledge;
with GprConfig.Sdefault;  use  GprConfig.Sdefault;
separate (Gpr_Util)

package body Knowledge is

   Base : Knowledge_Base;

   -------------------------
   -- Normalized_Hostname --
   -------------------------

   function Normalized_Hostname return String is
      Id : Targets_Set_Id;
   begin
      Get_Targets_Set (Base, Hostname, Id);
      return Normalized_Target (Base, Id);
   end Normalized_Hostname;

   --------------------------
   -- Parse_Knowledge_Base --
   --------------------------

   procedure Parse_Knowledge_Base (Directory : String := "") is
      Dir : String_Access;
   begin
      if Directory'Length = 0 then
         Dir := new String'(Default_Knowledge_Base_Directory);
      else
         Dir := new String'(Directory);
      end if;

      Parse_Knowledge_Base (Base, Dir.all, Parse_Compiler_Info => False);
   exception
      when Invalid_Knowledge_Base =>
         Fail_Program ("could not parse the XML files in " & Dir.all);
   end Parse_Knowledge_Base;

end Knowledge;