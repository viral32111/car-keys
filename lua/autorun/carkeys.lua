-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

local addonVersion = "1.1.1"
local versionchecked = false

if ( SERVER ) then
	print("[Car Keys] Loaded addon!")
	print("[Car Keys] Author: viral32111 (www.github.com/viral32111)")
	print("[Car Keys] Version: " .. addonVersion )

	include("autorun/server/sv_keys_vehiclemanager.lua")
end

if ( CLIENT ) then
	print("This server is running Car Keys, Created by viral32111! (https://www.steamcommunity.com/id/viral32111)")
end

hook.Add( "PlayerConnect", "CarKeysLoad", function( name, ip )
	if not ( versionchecked ) then
		versionchecked = true
		http.Fetch( "https://raw.githubusercontent.com/viral32111/car-keys/master/VERSION.md",
		function( body, len, headers, code )
			local formattedBody = string.gsub( body, "\n", "")
			if ( formattedBody == addonVersion ) then
				print("[Car Keys] You are running the most recent version of Car Keys!")
			elseif ( formattedBody == "404: Not Found" ) then
				Error("[Car Keys] Version page does not exist\n")
			else
				print("[Car Keys] You are using outdated version of Car Keys! (Latest: " .. formattedBody .. ", Yours: " .. addonVersion .. ")" )
			end
		end,
		function( error )
			Error("[Car Keys] Failed to get addon version\n")
		end
		)
	end
	
	-- Addon stats tracking
	if not ( game.GetIPAddress() == "loopback" or string.find( game.GetIPAddress(), "0.0.0.0" ) ) then
	http.Post( "http://viralstudios.phy.sx/carkeys/post.php", { hostname = GetHostName(), ip = game.GetIPAddress(), version = addonVersion, map = game.GetMap(), gamemode = engine.ActiveGamemode() } ) end
end )