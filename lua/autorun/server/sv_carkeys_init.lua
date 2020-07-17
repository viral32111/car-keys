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

-- Current commit of the addon.
local currentCommit = "060f308"

-- Add config file to client download queue.
AddCSLuaFile("autorun/shared/sh_carkeys_config.lua")

-- Add all resource to client download queue.
resource.AddSingleFile("materials/sentry/key/key.vmt")
resource.AddSingleFile("materials/sentry/key/key.vtf")
resource.AddSingleFile("models/sentry/pgkey.mdl")
resource.AddSingleFile("models/sentry/pgkey.phy")
resource.AddSingleFile("models/sentry/pgkey.vvd")
resource.AddSingleFile("models/sentry/pgkey.sw.vtx")
resource.AddSingleFile("models/sentry/pgkey.dx80.vtx")
resource.AddSingleFile("models/sentry/pgkey.dx90.vtx")
resource.AddSingleFile("sound/carkeys/lock.wav")
resource.AddSingleFile("sound/carkeys/alarm.wav")
resource.AddSingleFile("sound/carkeys/car_alarm.wav") --nak Add new looped wav sound to queue as well. Original alarm sound is still in the addon though

-- Create an SQLite (sv.db) table for saving vehicle prices.
sql.Query("CREATE TABLE carKeysVehiclePrices (EntityClass VARCHAR PRIMARY KEY, Price INT)")

-- Check for updates on GitHub.
hook.Add("Think", "carKeysVersionChecker", function()
	http.Fetch("https://api.github.com/repos/viral32111/car-keys/commits", function(body, size, headers, code)
		local response = util.JSONToTable(body)
		local latestCommit = string.sub(response[2]["sha"], 0, 7)

		if (latestCommit != currentCommit) then
			MsgC(Color(255, 0, 0), "[Car Keys] This addon is out of date! Please consider downloading the latest update for the best features and bug fixes.\n")
		end
	end, function(err)
		error("An error occured while checking for the latest update on Car Keys. (Details: " .. err .. ")")
	end)

	hook.Remove("Think", "carKeysVersionChecker")
end)
