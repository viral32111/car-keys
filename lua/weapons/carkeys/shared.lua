-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

include("sh_carkeys_config.lua")

SWEP.Author = "viral32111"
SWEP.Contact = "www.github.com/viral32111/car-keys/issues"
SWEP.Purpose = "Manage your vehicles"
SWEP.Instructions = "Left click locks vehicle. Right click unlocks vehicle. R purchases vehicle"
SWEP.Category = "Car Keys"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

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
		
		if ( trace.Entity:GetNWString( "vehicleOwner", "N/A" ) == "N/A" ) then
			trace.Entity:SetNWString( "vehicleOwner", ply:Nick() )
			ply:EmitSound("ambient/machines/keyboard6_clicks.wav")
		else
			if ( trace.Entity:GetNWString( "vehicleOwner", "N/A" ) == ply:Nick() ) then
				trace.Entity:SetNWString( "vehicleOwner", "N/A" )
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

		if ( trace.Entity:GetNWString( "vehicleOwner", "N/A" ) == ply:Nick() ) then
			ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
			trace.Entity:SetNWBool( "vehicleLocked", true )
		else
			ply:SendLua([[ chat.AddText( Color( 0, 180, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot lock this vehicle, You don\'t own it." ) ]])
			ply:EmitSound("doors/handle_pushbar_locked1.wav")
		end
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
	 
		if ( trace.Entity:GetNWString( "vehicleOwner", "N/A" ) == ply:Nick() ) then
			ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
			trace.Entity:SetNWBool( "vehicleLocked", false )
		else
			ply:SendLua([[ chat.AddText( Color( 0, 180, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot unlock this vehicle, You don\'t own it." ) ]])
			ply:EmitSound("doors/handle_pushbar_locked1.wav")
		end
	end	
end