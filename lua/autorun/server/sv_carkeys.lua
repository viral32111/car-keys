-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

if ( CLIENT ) then return end
include("sh_carkeys_config.lua")

--[[-------------------------------------------------------------------------
Vehicle Locking
---------------------------------------------------------------------------]]
hook.Add( "PlayerUse", "CarKeysUseVehicle", function( ply, ent )
	if ( table.HasValue( CarKeysVehicles, ent:GetClass() ) ) then
		if ( ent:GetNWBool( "vehicleLocked", false ) ) then
			return false
		else
			return true
		end
	end
end )

hook.Add( "KeyPress", "CarKeysVehicleMessage", function( ply, key )
	if ( key == IN_USE ) then
		if ( table.HasValue( CarKeysVehicles, ply:GetEyeTrace().Entity:GetClass() ) ) then
			if ( ply:GetEyeTrace().Entity:GetNWBool( "vehicleLocked", false ) ) then
				ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "This vehicle is locked, You cannot enter it." ) ]])
			end
		end
	end
end )

--[[-------------------------------------------------------------------------
Vehicle Pickup
---------------------------------------------------------------------------]]
hook.Add( "PhysgunPickup", "CarKeysVehiclePickingUp", function( ply, ent )
	if ( table.HasValue( CarKeysVehicles, ent:GetClass() ) ) then
		if ( ply:IsAdmin() ) then
			return true
		else
			if ( ent:GetNWString( "vehicleOwner", "N/A" ) == "N/A" ) then
				return false
			else
				if ( ent:GetNWString( "vehicleOwner", "N/A" ) == ply:Nick() ) then
					return true
				end
			end
		end
	end
end )