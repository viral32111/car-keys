-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

local addonVersion = "1.0.0"
versionchecked = false

if ( SERVER or CLIENT ) then
	print("[Car Keys] Loading Car Keys...")
	print("[Car Keys] Author: viral32111")
	print("[Car Keys] Version: " .. addonVersion )

	print("[Car Keys] Finished loading Car Keys!")
end

hook.Add("PlayerConnect", "CarKeysCheckVersion", function()
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
end )