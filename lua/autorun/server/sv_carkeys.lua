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

if ( CLIENT ) then return end
include("sh_carkeys_config.lua")

--[[-------------------------------------------------------------------------
Vehicle Locking
---------------------------------------------------------------------------]]
hook.Add( "PlayerUse", "CarKeysUseVehicle", function( ply, ent )
	if ( table.HasValue( CarKeysVehicles, ent:GetClass() ) ) then
		if ( ent:GetNWBool( "CarKeysVehicleLocked", false ) ) then
			return false
		else
			return true
		end
	end
end )

hook.Add( "KeyPress", "CarKeysVehicleMessage", function( ply, key )
	if ( key == IN_USE ) then
		if ( table.HasValue( CarKeysVehicles, ply:GetEyeTrace().Entity:GetClass() ) ) then
			if ( ply:GetEyeTrace().Entity:GetNWBool( "CarKeysVehicleLocked", false ) ) then
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
			if ( ent:GetNWString( "CarKeysVehicleOwner", "N/A" ) == "N/A" ) then
				return false
			else
				if ( ent:GetNWString( "CarKeysVehicleOwner", "N/A" ) == ply:Nick() ) then
					return true
				end
			end
		end
	end
end )