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
--Me, NotAKidoS is signing all code changes by me with --nak to comply with the license

include("autorun/shared/sh_carkeys_config.lua") -- Include our configuration file.

-- Prevents the player from entering a locked vehicle.
hook.Add("PlayerUse", "carKeysUseVehicle", function(ply, ent)
	if not IsCarKeyable(ent, ply) then return end --nak look at bottom of carkeys.lua file for function. turned the multiple copy paste code checks into a function to make allowing supported vehicles MUCH easier

	if (ent:GetNWBool("carKeysVehicleLocked")) then -- Is the vehicle locked?
		return false -- Stop the player from entering the car.
	end
end)

-- Shows a chat message and plays a locked sound.
hook.Add("KeyPress", "carKeysVehicleMessage", function(ply, key)
	if (key == IN_USE) then -- Is the player pressing their Use key?
		local ent = ply:GetEyeTrace().Entity -- Get the entity the player is looking at.

		if not IsSupported(ent, ply) then return end --nak look at bottom of carkeys.lua file for function. turned the multiple copy paste code checks into a function to make allowing supported vehicles MUCH easier
		--nak using IsSupported instead of IsCarKeyable because say you hit E on a long vehicle away from the doors then why give the alert. Makes sense on larger vehicles like box trucks when opening/closing things. Code above still keeps you out of the vehicle though
		
		if (ent:GetNWBool("carKeysVehicleLocked")) then -- Is this a valid Car Keys vehicle and is it locked?
			ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"This vehicle is locked, You cannot enter it.\")") -- Display a chat message saying the vehicle is locked.
			ply:EmitSound("doors/handle_pushbar_locked1.wav") -- Play a locked sound.
		end
	end
end)