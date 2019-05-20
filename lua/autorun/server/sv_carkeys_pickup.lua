--[[-------------------------------------------------------------------------
Copyright 2017-2019 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

include("autorun/shared/sh_carkeys_config.lua") -- Include our configuration file.

-- Physgun pickup on vehicle
hook.Add("PhysgunPickup", "carKeysVehiclePickup", function(ply, ent)
	if (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) then return end -- Stop execution if vehicle is invalid.

	local owner = ent:GetNWEntity("carKeysVehicleOwner") -- Get the vehicle owner

	if (ply:IsAdmin()) or (owner != NULL and ply:UniqueID() == owner:UniqueID()) then -- Is the player an admin, or are they the owner of the vehicle?
		return true -- Allow them to pick it up.
	end
end)