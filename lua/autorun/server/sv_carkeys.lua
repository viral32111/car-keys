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
Set Vehicle Price on Spawn
---------------------------------------------------------------------------]]
hook.Add( "PlayerSpawnedVehicle", "CarKeysSetVehiclePrice", function( ply, vehicle )
	if ( table.HasValue( CarKeysVehicles, vehicle:GetClass() ) ) then
		vehicle:SetNWInt( "CarKeysVehiclePrice", CarKeysVehiclePrices[ vehicle:GetClass() ] or 0 )
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
	properties.Add( "setvehicleprice", {
		MenuLabel = "Set Vehicle Price",
		Order = 8,
		MenuIcon = "icon16/money.png",

		Filter = function( self, ent, ply ) -- A function that determines whether an entity is valid for this property
			if not ( IsValid( ent ) ) then return end
			if ( ent:IsPlayer() ) then return end
			if not ( ent:IsVehicle() ) then return end
			if not ( string.find( engine.ActiveGamemode(), "rp" ) ) then return end

			return table.HasValue( CarKeysVehicles, ent:GetClass() )
		end,
		Action = function( self, ent ) -- The action to perform upon using the property ( Clientside )
			self:MsgStart()
				net.WriteEntity( ent )
			self:MsgEnd()

		end,
		Receive = function( self, length, player ) -- The action to perform upon using the property ( Serverside )
			local ent = net.ReadEntity()
			if not ( self:Filter( ent, player ) ) then return end

			ent:SetNWInt("CarKeysVehiclePrice", 1000 )
			ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "The price of this vehicle has been set to $1000" ) ]])
		end
	})
else
	print("[Car Keys] Cannot add the Set Vehicle Price property because gamemode is not of a roleplay type!")
end