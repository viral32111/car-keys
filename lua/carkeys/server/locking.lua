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

include("autorun/shared/sh_carkeys_config.lua") -- Include our configuration file.

-- Prevents the player from entering a locked vehicle.
hook.Add("PlayerUse", "carKeysUseVehicle", function(ply, ent)
	if (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (ply:GetPos():Distance(ent:GetPos()) >= 150) then return end  -- Stop execution if vehicle is invalid, or player is more than 150 units away.

	if (ent:GetNWBool("carKeysVehicleLocked")) then -- Is the vehicle locked?
		return false -- Stop the player from entering the car.
	end
end)

-- Shows a chat message and plays a locked sound.
hook.Add("KeyPress", "carKeysVehicleMessage", function(ply, key)
	if (key == IN_USE) then -- Is the player pressing their Use key?
		local ent = ply:GetEyeTrace().Entity -- Get the entity the player is looking at.

		if (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (ply:GetPos():Distance(ent:GetPos()) >= 150) then return end  -- Stop execution if vehicle is invalid, or player is more than 150 units away.

		if (ent:GetNWBool("carKeysVehicleLocked")) then -- Is this a valid Car Keys vehicle and is it locked?
			ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"This vehicle is locked, You cannot enter it.\")") -- Display a chat message saying the vehicle is locked.
			ply:EmitSound("doors/handle_pushbar_locked1.wav") -- Play a locked sound.
		end
	end
end)