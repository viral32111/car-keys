--[[-------------------------------------------------------------------------
Copyright 2017-2018 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

CarKeys = {}
CarKeys.Version = 131
CarKeys.Name = "Car Keys"

AddCSLuaFile("carkeys_config.lua")

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

if ( SERVER ) then
	if not ( file.Exists("carkeys", "DATA") ) then
		file.CreateDir("carkeys")
	end
end

sound.Add({
	name = "carkeys_alarm",
	channel = CHAN_STATIC,
	volume = 0.4, -- Fuck that alarm was loud
	level = 80,
	pitch = 100,
	sound = "carkeys/alarm.wav"
})

hook.Add("PlayerConnect", CarKeys.Name .. "VersionCheck", function()
	http.Fetch("https://raw.githubusercontent.com/viral32111/car-keys/master/README.md", function(body)
		local LatestVersion = tonumber(string.sub(body, string.len(CarKeys.Name)+18, string.len(CarKeys.Name)+21))
		if (LatestVersion == CarKeys.Version) then
			print("[" .. CarKeys.Name .. "] You are running the latest version!")
		elseif ( LatestVersion > CarKeys.Version ) then
			print("[" .. CarKeys.Name .. "] You are running an outdated version! (Latest: " .. LatestVersion .. ", Current: " .. CarKeys.Version .. ")")
		elseif ( LatestVersion < CarKeys.Version ) then
			print("[" .. CarKeys.Name .. "] You are running a future version, Please reinstall the addon. (Latest: " .. LatestVersion .. ", Current: " .. CarKeys.Version .. ")")
		else
			print("[" .. CarKeys.Name .. "] Failed to parse addon version! (Latest: " .. LatestVersion .. ", Current: " .. CarKeys.Version .. ")")
		end
	end, function(error)
		print("[" .. CarKeys.Name .. "] Failed to get addon version! (" .. error .. ")")
	end )

	hook.Remove("PlayerConnect", CarKeys.Name .. "VersionCheck")
end )

print("[" .. CarKeys.Name .. "] Loaded Version: " .. CarKeys.Version)