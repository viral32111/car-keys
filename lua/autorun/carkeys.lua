-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

local CarKeysAddonVersion = "1.1.2"
local CarKeysVersionChecked = false

if ( SERVER ) then
	print("[Car Keys] Loaded!")
	print("[Car Keys] Author: viral32111 (www.github.com/viral32111)")
	print("[Car Keys] Version: " .. CarKeysAddonVersion )

	resource.AddSingleFile("materials/icon64/carkeys.jpg")

	include("autorun/server/sv_carkeys.lua")

	AddCSLuaFile("sh_carkeys_config.lua")
	include("sh_carkeys_config.lua")
end

if ( CLIENT ) then
	print("This server is running Car Keys, Created by viral32111! (www.github.com/viral32111)")
end

hook.Add( "PlayerConnect", "CarKeysLoad", function( name, ip )
	if not ( CarKeysVersionChecked ) then
		CarKeysVersionChecked = true
		http.Fetch( "https://raw.githubusercontent.com/viral32111/car-keys/master/VERSION.md",
		function( body, len, headers, code )
			local formattedBody = string.gsub( body, "\n", "")
			if ( formattedBody == CarKeysAddonVersion ) then
				print("[Car Keys] You are running the most recent version of Car Keys!")
			elseif ( formattedBody == "404: Not Found" ) then
				Error("[Car Keys] Version page does not exist\n")
			else
				print("[Car Keys] You are using outdated version of Car Keys! (Latest: " .. formattedBody .. ", Yours: " .. CarKeysAddonVersion .. ")" )
			end
		end,
		function( error )
			Error("[Car Keys] Failed to get addon version\n")
		end
		)
	end
end )