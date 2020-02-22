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

-- Vehicle takes damage
hook.Add("EntityTakeDamage", "carKeysVehicleDamaged", function(ent, dmg)
	if (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (carKeysVehicles[ent:GetClass()].alarm == false) then return end -- Stop execution if vehicle is invalid.

	if (ent:GetNWBool("carKeysVehicleLocked") and ent:GetNWEntity("carKeysVehicleOwner") != NULL) then
		if (timer.Exists("carKeysDamageTimer" .. ent:EntIndex())) then -- Does the loop timer already exist?
			return -- Stop execution.
		else
			timer.Create("carKeysDamageTimer" .. ent:EntIndex(), 96, 1, function() end) -- Create the loop timer.
		end

		ent:SetNWBool("carKeysVehicleAlarm", true) -- Set the alarm currently playing to true.
		ent:GetNWEntity("carKeysVehicleOwner"):SendLua("chat.AddText(Color(0, 180, 255), \"(Car Keys) \", Color(255, 255, 255), \"Your car has been damaged!\")") -- Send the vehicle owner a message saying their car is damaged.

		-- Alarm lights loop
		if (ent:GetClass() == "gmod_sent_vehicle_fphysics_base") then -- Is the vehicle a Simfphys vehicle?
			timer.Create("carKeysAlarmLights" .. ent:EntIndex(), 2, 48, function() -- Create a timer that turns on and off lights on a loop.
				if (ent:IsValid()) then -- Is the entity still valid?
					ent:SetLightsEnabled(true) -- Turn the Simfphys lights on.
				else
					timer.Remove("carKeysAlarmLights" .. ent:EntIndex()) -- Remove light timer.
				end
				timer.Simple(1, function() -- After one second, turn the lights off.
					if (ent:IsValid()) then -- Is the entity still valid?
						ent:SetLightsEnabled(false) -- Turn the Simfphys lights off.
					else
						timer.Remove("carKeysAlarmLights" .. ent:EntIndex()) -- Remove light timer.
					end
				end)
			end)
		end

		-- Alarm sound loop
		ent:EmitSound("carKeysAlarmSound") -- Start playing the alarm sound.
		timer.Create("carKeysLoopAlarm" .. ent:EntIndex(), 8, 12, function() -- Create a timer for looping the alarm.
			if (ent:IsValid()) then -- Is the entity still valid?
				ent:EmitSound("carKeysAlarmSound") -- Start playing the alarm sound.
			else
				ent:SetNWBool("carKeysVehicleAlarm", false) -- Set the alarm currently playing to false.
				timer.Remove("carKeysLoopAlarm" .. ent:EntIndex()) -- Remove alarm timer.
			end
		end)
	end
end)

-- Stop alarm when vehicle is removed
hook.Add("EntityRemoved", "carKeysVehicleRemoved", function(ent)
	if (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (carKeysVehicles[ent:GetClass()].alarm == false) then return end -- Stop execution if vehicle is invalid.

	if (ent:GetNWBool("carKeysVehicleAlarm")) then -- Is the alarm currently playing?
		timer.Remove("carKeysLoopAlarm" .. ent:EntIndex()) -- Remove alarm timer.
		timer.Remove("carKeysAlarmLights" .. ent:EntIndex()) -- Remove light timer.
		ent:StopSound("carKeysAlarmSound") -- Stop alarm sound on vehicle.
		ent:SetNWBool("carKeysVehicleAlarm", false) -- Set the alarm currently playing to false.
	end
end)