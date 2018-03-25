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

include("carkeys_config.lua")

SWEP.Author = "viral32111"
SWEP.Contact = "contact@viral32111.com"
SWEP.Purpose = "Manage your vehicles"
SWEP.Instructions = "Left click locks vehicle. Right click unlocks vehicle. R buys/sells vehicle"
SWEP.Category = "Car Keys"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/viral/pgkey.mdl"
SWEP.WorldModel = "models/viral/pgkey.mdl"

function SWEP:Reload()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "CarKeysReloadTimer" ) ) then
			timer.Adjust( "CarKeysReloadTimer", 0.1, 1, function() end )
			return
		else
			timer.Create( "CarKeysReloadTimer", 0.1, 1, function() end )
		end

		local ply = self.Owner
		local ent = ply:GetEyeTrace().Entity
		local Price = ent:GetNWInt( "CarKeysVehiclePrice", 0 )

		if not ( table.HasValue( CarKeysVehicles, ent:GetClass() ) ) then return end
		if ( ply:GetPos():Distance( ent:GetPos() ) >= 150 ) then return end

		if ( ent:GetNWString( "CarKeysVehicleOwner", "N/A" ) == "N/A" ) then
			if ( table.HasValue( CarKeysRPGamemodes, engine.ActiveGamemode() ) or string.find( engine.ActiveGamemode(), "rp" ) ) then
				if ( ply:canAfford( Price ) ) then
					ply:addMoney( -Price )
					ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You have bought this vehicle for $" .. tostring( LocalPlayer():GetEyeTrace().Entity:GetNWInt( "CarKeysVehiclePrice", 0 ) ) ) ]])
					ent:SetNWString( "CarKeysVehicleOwner", ply:Nick() )
					ent:EmitSound("ambient/machines/keyboard6_clicks.wav")
				else
					ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot affort this vehicle! It cost $" .. tostring( LocalPlayer():GetEyeTrace().Entity:GetNWInt( "CarKeysVehiclePrice", 0 ) ) ) ]])
				end
			else
				ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You have acquired this vehicle!" ) ]])
				ent:SetNWString( "CarKeysVehicleOwner", ply:Nick() )
				ent:EmitSound("ambient/machines/keyboard6_clicks.wav")
				print("[Car Keys] Cannot subtract money ($" .. Price .. ") from " .. ply:Nick() .. " for buying vehicle because gamemode is not of a roleplay type!")
			end
		else
			if ( ent:GetNWString( "CarKeysVehicleOwner", "N/A" ) == ply:Nick() ) then
				if ( table.HasValue( CarKeysRPGamemodes, engine.ActiveGamemode() ) or string.find( engine.ActiveGamemode(), "rp" ) ) then
					ply:addMoney( Price )
					ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You have sold your vehicle for $" .. tostring( LocalPlayer():GetEyeTrace().Entity:GetNWInt( "CarKeysVehiclePrice", 0 ) ) ) ]])
				else
					ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You have sold your vehicle!" ) ]])
					print("[Car Keys] Cannot add money ($" .. Price .. ") to " .. ply:Nick() .. " for selling vehicle because gamemode is not of a roleplay type!")
				end

				ent:SetNWString( "CarKeysVehicleOwner", "N/A" )
				ent:EmitSound("buttons/lightswitch2.wav")
			else
				ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot purchase this vehicle, It is owned by " .. LocalPlayer():GetEyeTrace().Entity:GetNWString( "CarKeysVehicleOwner", "N/A" ) ) ]])
				ent:EmitSound("doors/handle_pushbar_locked1.wav")
			end
		end
	end
end

function SWEP:PrimaryAttack()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "CarKeysPrimaryAttackTimer" ) ) then
			timer.Adjust( "CarKeysPrimaryAttackTimer", 0.01, 1, function() end )
			return
		else
			timer.Create( "CarKeysPrimaryAttackTimer", 0.01, 1, function() end )
		end

		local ply = self.Owner
		local ent = ply:GetEyeTrace().Entity

		if not ( table.HasValue( CarKeysVehicles, ent:GetClass() ) ) then return end
		if ( ply:GetPos():Distance( ent:GetPos() ) >= 150 ) then return end

		if ( ent:GetNWString( "CarKeysVehicleOwner", "N/A" ) == ply:Nick() ) then
			ent:EmitSound( "npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav" )
			ent:SetNWBool( "CarKeysVehicleLocked", true )
			timer.Simple( 0.5, function()
				ent:EmitSound( "carkeys/lock.wav" )
			end )
		else
			ply:SendLua([[ chat.AddText( Color( 0, 180, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot lock this vehicle, You don't own it." ) ]])
			ent:EmitSound("doors/handle_pushbar_locked1.wav")
		end
		ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
		ply:SendLua([[ LocalPlayer():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true) ]])
	end
end

function SWEP:SecondaryAttack()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "CarKeysSecondaryAttackTimer" ) ) then
			timer.Adjust( "CarKeysSecondaryAttackTimer", 0.01, 1, function() end )
			return
		else
			timer.Create( "CarKeysSecondaryAttackTimer", 0.01, 1, function() end )
		end

		local ply = self.Owner
		local ent = ply:GetEyeTrace().Entity

		if not ( table.HasValue( CarKeysVehicles, ent:GetClass() ) ) then return end
		if ( ply:GetPos():Distance( ent:GetPos() ) >= 150 ) then return end
	 
		if ( ent:GetNWString( "CarKeysVehicleOwner", "N/A" ) == ply:Nick() ) then
			ent:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
			ent:SetNWBool( "CarKeysVehicleLocked", false )
		else
			ply:SendLua([[ chat.AddText( Color( 0, 180, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot unlock this vehicle, You don\'t own it." ) ]])
			ent:EmitSound("doors/handle_pushbar_locked1.wav")
		end
		ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
		ply:SendLua([[ LocalPlayer():AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true ) ]])
	end 
end

function SWEP:GetViewModelPosition( position, angle )
	local owner = self.Owner

	if ( IsValid( owner ) ) then
		position = position + owner:GetRight()*11 + owner:GetAimVector()*21
	end

	angle:RotateAroundAxis( angle:Up(), 210 )
	angle:RotateAroundAxis( angle:Right(), 220 )
	angle:RotateAroundAxis( angle:Forward(), 10 )

	return position, angle
end