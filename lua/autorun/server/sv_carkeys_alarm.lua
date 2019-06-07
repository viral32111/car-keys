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
include("autorun/simfphyshornalarm.lua") -- Include simfphy horn thing
-- Add the alarm sound file.
sound.Add({
	name = "carKeysAlarmSound",
	channel = CHAN_STATIC,
	volume = 0.4, -- Fuck that alarm was loud.
	level = 80,
	sound = "carkeys/car_alarm.wav"
})
-- Vehicle takes damage
hook.Add("EntityTakeDamage", "carKeysVehicleDamaged", function(ent, dmg)
	if ent:GetNWBool("carkeysSupported") then elseif (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (carKeysVehicles[ent:GetClass()].alarm == false) then return end -- Stop execution if vehicle is invalid.

	if (ent:GetNWBool("carKeysVehicleLocked") and ent:GetNWEntity("carKeysVehicleOwner") != NULL) then

		if not ent:GetNWBool("carKeysVehicleAlarm") then
			ent:SetNWBool("carKeysVehicleAlarm", true) -- Set the alarm currently playing to true.
			ent:GetNWEntity("carKeysVehicleOwner"):SendLua("chat.AddText(Color(0, 180, 255), \"(Car Keys) \", Color(255, 255, 255), \"Your car has been damaged!\")") -- Send the vehicle owner a message saying their car is damaged.
		end



		--Alarm lights loop
		if (ent:GetClass() == "gmod_sent_vehicle_fphysics_base") then -- Is the vehicle a Simfphys vehicle?
			timer.Create("carKeysAlarmLights" .. ent:EntIndex(), 2, 48, function() -- Create a timer that turns on and off lights on a loop.
				if (ent:IsValid()) then -- Is the entity still valid?
					ent:SetLightsEnabled(true) -- Turn the Simfphys lights on.
				else
					timer.Remove("carKeysAlarmLights" .. ent:EntIndex()) -- Remove light timer.
				end
				timer.Simple(0.8, function() -- After one.8th(spit noise) second, turn the lights off.
					if (ent:IsValid()) then -- Is the entity still valid?
						ent:SetLightsEnabled(false) -- Turn the Simfphys lights off.
						
					else
						timer.Remove("carKeysAlarmLights" .. ent:EntIndex()) -- Remove light timer.
					end
				end)
			end)
		end
		


		-- Alarm sound loop
		
		if ent:GetNWBool("carKeysVehicleAlarm") == true then
			if ent:GetNWBool("carkeysCustomAlarm") then
				ent:EmitSound(ent:GetNWString("carkeysCAlarmSound"))
			else
				ent:EmitSound("carKeysAlarmSound")
			end
			net.Start( "simfphys_turnsignal" )
			net.WriteEntity( ent )
			net.WriteInt( 1, 32 )
			net.Broadcast()
		end-- the else statement would never run as this code is run only when the vehicle is damaged and then alarm on..
	end
end)

-- Stop alarm when vehicle is removed
hook.Add("EntityRemoved", "carKeysVehicleRemoved", function(ent)
	ent:CallOnRemove( "carkeysAlarmEnd", function( ent ) if ent:GetNWBool("carKeysVehicleAlarm") then 
		ent:SetNWBool("carKeysVehicleAlarm", false)
		ent:StopSound("carkeysAlarmSound")
		ent:StopSound(ent:GetNWString("carkeysCAlarmSound"))
		ent:SetNWBool("carkeysHorn", false)
	end end )
end)


