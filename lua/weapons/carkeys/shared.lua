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

include("sh_carkeys_config.lua")

SWEP.Author = "viral32111"
SWEP.Contact = "www.github.com/viral32111/car-keys/issues"
SWEP.Purpose = "Manage your vehicles"
SWEP.Instructions = "Left click locks vehicle. Right click unlocks vehicle. R purchases vehicle"
SWEP.Category = "viral32111's scripts"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/sentry/pgkey.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["Box001"] = { scale = Vector(3, 3, 3), pos = Vector(30, -15.37, -14.631), angle = Angle(-34.445, -81.112, -41.112) }
}


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Reload()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "pauseTimer" ) ) then
			timer.Adjust( "pauseTimer", 0.5, 1, function() end )
			return
		else
			timer.Create( "pauseTimer", 0.5, 1, function() end )
		end

		local ply = self.Owner
		local trace = ply:GetEyeTrace()
		if not ( table.HasValue( CarKeysVehicles, trace.Entity:GetClass() ) ) then return false end
		
		if ( trace.Entity:GetNWString( "CarKeysVehicleOwner", "N/A" ) == "N/A" ) then
			trace.Entity:SetNWString( "CarKeysVehicleOwner", ply:Nick() )
			ply:EmitSound("ambient/machines/keyboard6_clicks.wav")
		else
			if ( trace.Entity:GetNWString( "CarKeysVehicleOwner", "N/A" ) == ply:Nick() ) then
				trace.Entity:SetNWString( "CarKeysVehicleOwner", "N/A" )
				ply:EmitSound("buttons/lightswitch2.wav")
			end
		end
	end
end

function SWEP:PrimaryAttack()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "pauseTimer" ) ) then
			timer.Adjust( "pauseTimer", 0.01, 1, function() end )
			return
		else
			timer.Create( "pauseTimer", 0.01, 1, function() end )
		end

		local ply = self.Owner
		local trace = ply:GetEyeTrace()
		if not ( table.HasValue( CarKeysVehicles, trace.Entity:GetClass() ) ) then return false end

		if ( trace.Entity:GetNWString( "CarKeysVehicleOwner", "N/A" ) == ply:Nick() ) then
			ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
			trace.Entity:SetNWBool( "CarKeysVehicleLocked", true )
		else
			ply:SendLua([[ chat.AddText( Color( 0, 180, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot lock this vehicle, You don\'t own it." ) ]])
			ply:EmitSound("doors/handle_pushbar_locked1.wav")
		end
		ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
		ply:SendLua([[ LocalPlayer():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true) ]])
	end
end

function SWEP:SecondaryAttack()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "pauseTimer" ) ) then
			timer.Adjust( "pauseTimer", 0.01, 1, function() end )
			return
		else
			timer.Create( "pauseTimer", 0.01, 1, function() end )
		end

		local ply = self.Owner
		local trace = ply:GetEyeTrace()
		if not ( table.HasValue( CarKeysVehicles, trace.Entity:GetClass() ) ) then return false end
	 
		if ( trace.Entity:GetNWString( "CarKeysVehicleOwner", "N/A" ) == ply:Nick() ) then
			ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
			trace.Entity:SetNWBool( "CarKeysVehicleLocked", false )
		else
			ply:SendLua([[ chat.AddText( Color( 0, 180, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot unlock this vehicle, You don\'t own it." ) ]])
			ply:EmitSound("doors/handle_pushbar_locked1.wav")
		end
		ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
		ply:SendLua([[ LocalPlayer():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true) ]])
	end	
end