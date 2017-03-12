-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

addonVersion = "1.0.9"
versionchecked = false

if ( SERVER ) then
	print("[Car Keys] Loading...")
	print("[Car Keys] Author: viral32111 (www.github.com/viral32111)")
	print("[Car Keys] Version: " .. addonVersion )

	print("[Car Keys] Finished loading!")
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
	http.Post( "http://viralstudios.phy.sx/addons/car-keys/post.php", { hostname = GetHostName(), ip = game.GetIPAddress(), version = addonVersion }, 
	function( result )
		if ( result ) then 
			print("[Car Keys] Post success") 
		end
	end, 
	function( failed )
		Error("[Car Keys] Failed to post addon\n")
	end )
end )

hook.Add( "PhysgunPickup", "CarKeysVehiclePickingUp", function( ply, ent )
	if ( table.HasValue( validVehicles, ent:GetClass() ) ) then
		if ( ent:GetNWString( "vehicleOwner", "N/A" ) == "N/A" ) then
			return false
		else
			if ( ent:GetNWString( "vehicleOwner", "N/A" ) == ply:Nick() ) then
				return true
			end
		end
	end
end )

validVehicles = {
	"prop_vehicle_jeep",
	"prop_vehicle_airboat",
	"gmod_sent_vehicle_fphysics_base",
	"prop_vehicle_prisoner_pod",
	"sent_sakarias_car_banshee",
	"sent_sakarias_car_belair",
	"sent_sakarias_car_bobcat",
	"sent_sakarias_car_bus",
	"sent_sakarias_car_cadillac",
	"sent_sakarias_car_camaro",
	"sent_sakarias_car_chaos126p",
	"sent_sakarias_car_chevy66",
	"sent_sakarias_car_clydesdale",
	"sent_sakarias_car_comet",
	"sent_sakarias_car_delorean",
	"sent_sakarias_car_fordgt",
	"sent_sakarias_car_hedgehog",
	"sent_sakarias_car_hummer",
	"sent_sakarias_car_humvee",
	"sent_sakarias_car_huntley",
	"sent_sakarias_car_impala88",
	"sent_sakarias_car_junker4",
	"sent_sakarias_car_mothtruck",
	"sent_sakarias_car_mustang",
	"sent_sakarias_car_police",
	"sent_sakarias_car_ratmobile",
	"sent_sakarias_car_sabre",
	"sent_sakarias_car_stagpickup",
	"sent_sakarias_car_studebaker",
	"sent_sakarias_car_taxi",
	"sent_sakarias_car_1996corvette",
	"sent_sakarias_car_abrams",
	"sent_sakarias_car_brera",
	"sent_sakarias_car_carreragt",
	"sent_sakarias_car_dodgeram",
	"sent_sakarias_car_ferrari360",
	"sent_sakarias_car_ferrarif50",
	"sent_sakarias_car_ferrarif430",
	"sent_sakarias_car_fordmustangtr",
	"sent_sakarias_car_ilcar",
	"sent_sakarias_car_jimmygibbsjr",
	"sent_sakarias_car_lambodiablo",
	"sent_sakarias_car_lambodicop",
	"sent_sakarias_car_lambomurci",
	"sent_sakarias_car_lambomurcicop",
	"sent_sakarias_car_nissanskyline",
	"sent_sakarias_car_paganizonda",
	"sent_sakarias_car_porsche911",
	"sent_sakarias_car_porsche911cop",
	"sent_sakarias_car_suprarz",
	"sent_sakarias_car_toyotagtone",
	"sent_sakarias_car_vipercc",
	"sent_sakarias_car_vipersrt10",
	"sent_sakarias_car_yamahayfz450",
	"sent_sakarias_car_junker3",
	"sent_sakarias_car_junker2",
	"sent_sakarias_car_junker1",
}

hook.Add( "CanPlayerEnterVehicle", "CarKeysVehicleEntering", function( player, vehicle, sRole )
	if ( SERVER and table.HasValue( validVehicles, vehicle:GetClass() ) ) then
		if ( player:GetEyeTrace().Entity:GetNWBool( "vehicleLocked", false ) ) then
			player:SendLua(' chat.AddText( Color( 0, 180, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "This vehicle is locked, You cannot enter it." ) ')
			return false
		else
			return true
		end
	end
end )