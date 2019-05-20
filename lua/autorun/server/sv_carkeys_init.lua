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

-- Current commit of the addon.
local currentCommit = ""

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

-- Create an SQLite (sv.db) table for saving vehicle prices.
sql.Query("CREATE TABLE carKeysVehiclePrices (EntityClass VARCHAR PRIMARY KEY, Price INT)")

-- Add the alarm sound file.
sound.Add({
	name = "carKeysAlarmSound",
	channel = CHAN_STATIC,
	volume = 0.4, -- Fuck that alarm was loud.
	level = 80,
	sound = "carkeys/alarm.wav"
})

-- Check for updates on GitHub.
hook.Add("Think", "carKeysVersionChecker", function()
	http.Fetch("https://api.github.com/repos/viral32111/car-keys/commits", function(body, size, headers, code)
		local response = util.JSONToTable(body)
		local latestCommit = string.sub(response[1]["sha"], 0, 7)

		if (latestCommit != currentCommit) then
			MsgC(Color(255, 0, 0), "[Car Keys] This addon is out of date! Please consider downloading the latest update for the best features and bug fixes.\n")
		end
	end, function(err)
		error("An error occured while checking for the latest update on Car Keys. (Details: " .. err .. ")")
	end)

	hook.Remove("Think", "carKeysVersionChecker")
end)