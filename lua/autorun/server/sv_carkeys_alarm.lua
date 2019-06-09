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

-- Add the alarm sound file. 
sound.Add({
	name = "carKeysAlarmSound",
	channel = CHAN_STATIC,
	volume = 0.4, -- Fuck that alarm was loud. 
	level = 80,
	sound = "carkeys/car_alarm.wav"
}) --nak lol rip virals hearing, also moved sound.add from swep file to here

-- Vehicle takes damage (actually checking for ALL entitys being damaged, then if it is supported and locked.)
hook.Add("EntityTakeDamage", "carKeysVehicleDamaged", function(ent, dmg)
	if ent:GetNWBool("carkeysSupported") then elseif (ent == nil or ent == NULL) or (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) then return end  -- Stop execution if vehicle is invalid, or player is more than 150 units away.
	-- check if alarm is already playing and break code. fixes bug when 2 locked vehicles set each others alarm off, and create a third alarm that is not possible to remove without clearing the map.
	if ent:GetNWBool("carKeysVehicleAlarm") then return end
	-- check if locked and owner is not no one
	if (ent:GetNWBool("carKeysVehicleLocked") and ent:GetNWEntity("carKeysVehicleOwner") != NULL) then

		ent:SetNWBool("carKeysVehicleAlarm", true) -- Set the alarm currently playing to true. doesnt need to be in a check if the alarm is on as this code cant be run again due to line 30
		ent:GetNWEntity("carKeysVehicleOwner"):SendLua("chat.AddText(Color(0, 180, 255), \"(Car Keys) \", Color(255, 255, 255), \"Your car has been damaged!\")") -- Send the vehicle owner a message saying their car is damaged.
		ent.AlarmLooped = 0 --set the looped alarm counter to 0 
		
		--Alarm lights loop
		if (ent:GetClass() == "gmod_sent_vehicle_fphysics_base") then -- Is the vehicle a Simfphys vehicle?
			timer.Create("carKeysAlarmLights" .. ent:EntIndex(), 1, 48, function() -- Create a timer that turns on and off lights on a loop. Second numer is how many loops before the lights turn off.
				if (ent:IsValid()) then -- Is the entity still valid?
					ent:SetLightsEnabled(true) -- Turn the Simfphys lights on.
					ent.AlarmLooped = ent.AlarmLooped + 1
					if ent.AlarmLooped == 48 then -- equal to timers second number to make alarm sound disable as well
						ent:SetNWBool("carKeysVehicleAlarm", false) -- stop alarm bool
						ent:StopSound("carKeysAlarmSound") -- stop alarm sound 
						ent:StopSound(ent:GetNWString("carkeysCAlarmSound")) -- stop custom alarm sound if enabled
						if (ent:GetClass() == "gmod_sent_vehicle_fphysics_base") then 
							net.Start( "simfphys_turnsignal" ) --start network broadcast
							net.WriteEntity( ent ) -- write to our entity
							net.WriteInt( 0, 32 ) -- write disable both L and R blinkers
							net.Broadcast() -- broadcast
						end
					end
				else
					timer.Remove("carKeysAlarmLights" .. ent:EntIndex()) -- Remove light timer.
				end
				timer.Simple(0.8, function() -- After 0.8 seconds, turn the lights off. First number of other timer must be about the same to make this delay matter!
					if (ent:IsValid()) then -- Is the entity still valid?
						ent:SetLightsEnabled(false) -- Turn the Simfphys lights off.
					else
						timer.Remove("carKeysAlarmLights" .. ent:EntIndex()) -- Remove light timer.
					end
				end)
			end)
		end
		
		-- Alarm sound loop using a looped WAV file. Also enable simfphys blinkers
		
		-- check if alarm should be on EDIT: removed as this code can only be run if the alarm is off first due to line 30. No need for useless checks.
		if ent:GetNWBool("carkeysCustomAlarm") then -- check for custom alarm sound
			ent:EmitSound(ent:GetNWString("carkeysCAlarmSound")) -- play custom alarm sound
		else -- if not play normal alarm sound
			ent:EmitSound("carKeysAlarmSound")
		end
		if (ent:GetClass() == "gmod_sent_vehicle_fphysics_base") then -- if simfphys enable hazzards
			net.Start( "simfphys_turnsignal" )
			net.WriteEntity( ent )
			net.WriteInt( 1, 32 ) --we technecly dont need the check if it is simfphys, but theres no use writing
			net.Broadcast() -- a network broadcast to a vehicle that cant do anything with it...
		end

	end
end)

-- Stop alarm when vehicle is removed or destroyed
hook.Add("EntityRemoved", "carKeysVehicleRemoved", function(ent) --nak removed everything here and redid it
	if ent:GetNWBool("carKeysVehicleAlarm") then -- if alarm is on
		ent:SetNWBool("carKeysVehicleAlarm", false) -- disable alarm
		ent:StopSound("carkeysAlarmSound") -- stop alarm
		ent:StopSound(ent:GetNWString("carkeysCAlarmSound")) -- stop custom alarm if possible
	end
end)