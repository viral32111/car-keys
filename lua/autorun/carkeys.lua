--[[-------------------------------------------------------------------------
Copyright 2017 viral32111

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

local Version = "1.1.8"

if ( SERVER ) then
	print("[Car Keys] Loaded Version: " .. Version )

	include("autorun/server/sv_carkeys.lua")

	AddCSLuaFile("carkeys_config.lua")
	include("carkeys_config.lua")

	resource.AddSingleFile("materials/sentry/key/key.vmt")
	resource.AddSingleFile("materials/sentry/key/key.vtf")
	resource.AddSingleFile("models/sentry/pgkey.dx80.vtx")
	resource.AddSingleFile("models/sentry/pgkey.dx90.vtx")
	resource.AddSingleFile("models/sentry/pgkey.mdl")
	resource.AddSingleFile("models/sentry/pgkey.phy")
	resource.AddSingleFile("models/sentry/pgkey.sw.vtx")
	resource.AddSingleFile("models/sentry/pgkey.vvd")

	resource.AddSingleFile("sound/carkeys/lock.wav")

	if not ( file.Exists( "carkeys", "DATA" ) ) then
		file.CreateDir( "carkeys" )
	end
end

if ( CLIENT ) then
	print("Thanks for using Car Keys, Created by viral32111!")
end

hook.Add( "PlayerConnect", "CarKeysVersionCheck", function()
	http.Fetch( "https://raw.githubusercontent.com/viral32111/car-keys/master/VERSION.txt", function( body, len, headers, code )
		local body = string.gsub( body, "\n", "" )
		if ( body == Version ) then
			print( "[Car Keys] You are running the most recent version of Car Keys!" )
		elseif ( body == "404: Not Found" ) then
			print( "[Car Keys] Version page does not exist")
		else
			print( "[Car Keys] You are using outdated version of Car Keys! (Latest: " .. body .. ", Current: " .. Version .. ")" )
		end
	end,
	function( error )
		print( "[Car Keys] Failed to get addon version! (" .. error .. ")" )
	end )

	hook.Remove( "PlayerConnect", "CarKeysVersionCheck" )
end )