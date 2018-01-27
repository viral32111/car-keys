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

if ( CLIENT ) then return end
include("carkeys_config.lua")

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
Set Vehicle Price on Spawn
---------------------------------------------------------------------------]]
hook.Add( "PlayerSpawnedVehicle", "CarKeysSetVehiclePrice", function( ply, vehicle )
	if ( table.HasValue( CarKeysVehicles, vehicle:GetClass() ) ) then
		vehicle:SetNWString( "CarKeysVehicleOwner", ply:Nick() )
		if ( table.HasValue( CarKeysRPGamemodes, engine.ActiveGamemode() ) or string.find( engine.ActiveGamemode(), "rp" ) ) then
			if ( file.Exists( "carkeys/" .. vehicle:GetClass() .. ".txt", "DATA" ) ) then
				local price = tonumber( file.Read( "carkeys/" .. vehicle:GetClass() .. ".txt", "DATA" ) )
				vehicle:SetNWInt( "CarKeysVehiclePrice", price )
			else
				vehicle:SetNWInt( "CarKeysVehiclePrice", 0 )
			end
		end
	end
end )

--[[-------------------------------------------------------------------------
Vehicle Pickup
---------------------------------------------------------------------------]]
hook.Add( "PhysgunPickup", "CarKeysVehiclePickingUp", function( ply, ent )
	if ( table.HasValue( CarKeysVehicles, ent:GetClass() ) ) then
		if ( ply:IsAdmin() or ply:IsSuperAdmin() ) then
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

--[[-------------------------------------------------------------------------
Set Vehicle Price Property
---------------------------------------------------------------------------]]
if ( table.HasValue( CarKeysRPGamemodes, engine.ActiveGamemode() ) or string.find( engine.ActiveGamemode(), "rp" ) ) then
	hook.Add( "PlayerSay", "CarKeysSetVehiclePrice", function( ply, text, public )
		local text = string.lower( text )

		if ( string.sub( text, 1, 9 ) == "!setprice" ) then
			if ( ply:GetEyeTrace().Entity:IsVehicle() ) then
				if ( string.sub( text, 11 ) != "" ) then
					if ( table.HasValue( CarKeysVehicles, ply:GetEyeTrace().Entity:GetClass() ) ) then
						vehicle = ply:GetEyeTrace().Entity
						price = string.sub( text, 11 )
						vehicle:SetNWInt("CarKeysVehiclePrice", tonumber( price ) )
						file.Write("carkeys/" .. vehicle:GetClass() .. ".txt", price )
						ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You have successfully set the price of this vehicle!" ) ]])
					else
						ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "This vehicle is not compatible with Car Keys, Please contact the creator to fix this issue." ) ]])
					end
				else
					ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "Please supply a price argument, e.g. !setprice 1000" ) ]])
				end
			else
				ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You must be looking at a vehicle to set it's price." ) ]])
			end
			return ""
		end
	end )
else
	print( "[Car Keys] Set vehicle price chat command has been disabled." )
end
