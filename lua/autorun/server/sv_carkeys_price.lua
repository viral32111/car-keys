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

-- Set the vehicle price and owner whenever its spawned.
hook.Add("PlayerSpawnedVehicle", "carKeysPlayerSpawnedVehicle", function(ply, ent)
	if not IsCarKeyable(ent, ply) then return end --nak look at bottom of carkeys.lua file for function. turned the multiple copy paste code checks into a function to make allowing supported vehicles MUCH easier. This checks if the vehicle is supported or not else stop code.

	ent:SetNWEntity("carKeysVehicleOwner", ply) -- Set the vehicle owner to the player that spawned it.

	if (engine.ActiveGamemode() == "darkrp") then
		local price = sql.Query("SELECT Price FROM carKeysVehiclePrices WHERE EntityClass='" .. ent:GetClass() .. "'") -- Query the database for our vehicle's price.
		
		if (price) then -- Did the query return a price?
			ent:SetNWInt("carKeysVehiclePrice", price) -- Set the vehicle to that price.
		else
			ent:SetNWInt("carKeysVehiclePrice", 0) -- Set the vehicle's price to $0.
		end
	end
end)

-- Set the vehicle price and owner whenever its spawned. (SENT Spawned hook is required because of WAC)
hook.Add("PlayerSpawnedSENT", "carKeysPlayerSpawnedEntity", function(ply, ent)
	if not IsCarKeyable(ent, ply) then return end --nak look at bottom of carkeys.lua file for function. turned the multiple copy paste code checks into a function to make allowing supported vehicles MUCH easier. This checks if the vehicle is supported or not else stop code.
	--nak oh hey i fixed the bug when spawning a vehicle with the supported bool instead of config that it didnt belong to you.. congrats me on fixing bugs i created :P
	
	ent:SetNWEntity("carKeysVehicleOwner", ply) -- Set the vehicle owner to the player that spawned it.

	if (engine.ActiveGamemode() == "darkrp") then
		local price = sql.Query("SELECT Price FROM carKeysVehiclePrices WHERE EntityClass='" .. ent:GetClass() .. "'") -- Query the database for our vehicle's price.
		
		if (price) then
			ent:SetNWInt("carKeysVehiclePrice", price) -- Set the vehicle to that price.
		else
			ent:SetNWInt("carKeysVehiclePrice", 0) -- Set the vehicle's price to $0.
		end
	end
end)

-- Set vehicle price chat command.
hook.Add("PlayerSay", "carKeysChatCommand", function(ply, text, team)
	if (engine.ActiveGamemode() != "darkrp") then return end -- Is this DarkRP?

	local text = string.lower(text) -- Convert our chat message to all lower-case.

	if (string.sub(text, 1, 9) == "!setprice") then -- Did their message start with "!setprice"?
		if (string.sub(text, 11) != "") then -- Did they provide a price in the chat command?
			local ent = ply:GetEyeTrace().Entity -- Get the entity the player is looking at.

			if (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) then -- Is the vehicle they are looking at invalid?
				ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"You're looking at a vehicle that Car Keys doesn't understand!\")") -- Send a message in chat saying that vehicle is invalid.
				return -- Stop any further execution.
			end
			
			local price = tonumber(string.sub(text, 11)) -- Get the price provided from the chat command and convert it to a number.

			sql.Query("INSERT OR IGNORE INTO carKeysVehiclePrices (EntityClass,Price) VALUES ('" .. ent:GetClass() .. "'," .. price .. "); UPDATE carKeysVehiclePrices SET Price=" .. price .. " WHERE EntityClass='" .. ent:GetClass() .. "'") -- Update the price in the database.
			ent:SetNWInt("carKeysVehiclePrice", price)

			ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"Successfully set vehicles price!\")") -- Send a message in chat saying it was successful.
		else
			ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"Please provide the price, e.g. !setprice 1000\")") -- Send a message in chat saying they need to provide the price argument.
		end

		return ""
	end
end)