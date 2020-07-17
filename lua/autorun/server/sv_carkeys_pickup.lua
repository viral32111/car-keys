--[[-------------------------------------------------------------------------
Car Keys - A SWEP that lets players lock, unlock, buy and sell vehicles.
Copyright (C) 2017-2020 viral32111

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see https://www.gnu.org/licenses/.
---------------------------------------------------------------------------]]
--Me, NotAKidoS is signing all code changes by me with --nak to comply with the license

include("autorun/shared/sh_carkeys_config.lua") -- Include our configuration file.

-- Physgun pickup on vehicle
hook.Add("PhysgunPickup", "carKeysVehiclePickup", function(ply, ent)
	if ent:GetNWBool("carkeysSupported") then elseif (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) then return end -- Stop execution if vehicle is invalid.
	--nak first bit to the elseif. Checks if supported by bool if not try original config check.
	local owner = ent:GetNWEntity("carKeysVehicleOwner") -- Get the vehicle owner

	if (ply:IsAdmin()) or (owner != NULL and ply:UniqueID() == owner:UniqueID()) then -- Is the player an admin, or are they the owner of the vehicle?
		return true -- Allow them to pick it up.
	end
end)