-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

SWEP.Author	 = "viral32111"
SWEP.Contact = "https://github.com/viral32111/car-keys/issues"
SWEP.Purpose = "To lock your cars"
SWEP.Instructions = "Left click locks vehicle, Right click unlocks vehicle"
SWEP.Category = "viral32111's scripts"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "normal"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = ""
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {}

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

validVehicles = {
	"prop_vehicle_jeep",
	"prop_vehicle_airboat"
}

function SWEP:Deploy()
	local ply = self.Owner
	ply:DrawViewModel( false )
end

function SWEP:Reload()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "reload_stop_timer" ) ) then
			timer.Adjust( "reload_stop_timer", 0.01, 1, function() end )
			return
		else
			timer.Create( "reload_stop_timer", 0.01, 1, function() end )
		end

		local ply = self.Owner
		local trace = ply:GetEyeTrace()
		if not ( table.HasValue( validVehicles, trace.Entity:GetClass() ) ) then return false end
		
		if ( trace.Entity:GetNWString( "vehicleOwner", "nil" ) == "nil" ) then
			trace.Entity:SetNWString( "vehicleOwner", ply:Nick() )
			ply:EmitSound("ambient/machines/keyboard6_clicks.wav")
		else
			trace.Entity:SetNWString( "vehicleOwner", "nil" )
			ply:EmitSound("ambient/energy/zap6.wav")
		end
	end
end

function SWEP:PrimaryAttack()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "reload_stop_timer" ) ) then
			timer.Adjust( "reload_stop_timer", 0.01, 1, function() end )
			return
		else
			timer.Create( "reload_stop_timer", 0.01, 1, function() end )
		end

		local ply = self.Owner
		local trace = ply:GetEyeTrace()
		if not ( table.HasValue( validVehicles, trace.Entity:GetClass() ) ) then return false end

		if ( trace.Entity:GetNWString( "vehicleOwner", "nil" ) == ply:Nick() ) then
			ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
			trace.Entity:SetNWBool( "vehicleLocked", true )
			ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
		else
			ply:ChatPrint("You cannot lock this vehicle, You don't own it.")
			ply:EmitSound("doors/handle_pushbar_locked1.wav")
		end
	end
end

function SWEP:SecondaryAttack()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "reload_stop_timer" ) ) then
			timer.Adjust( "reload_stop_timer", 0.01, 1, function() end )
			return
		else
			timer.Create( "reload_stop_timer", 0.01, 1, function() end )
		end

		local ply = self.Owner
		local trace = ply:GetEyeTrace()
		if not ( table.HasValue( validVehicles, trace.Entity:GetClass() ) ) then return false end
	 
		if ( trace.Entity:GetNWString( "vehicleOwner", "nil" ) == ply:Nick() ) then
			ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
			trace.Entity:SetNWBool( "vehicleLocked", false )
			ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
		else
			ply:ChatPrint("You cannot unlock this vehicle, You don't own it.")
			ply:EmitSound("doors/handle_pushbar_locked1.wav")
		end
	end	
end

hook.Add( "CanPlayerEnterVehicle", "vehicleManager", function( player, vehicle, sRole )
	if ( SERVER and table.HasValue( validVehicles, player:GetEyeTrace().Entity:GetClass() ) ) then
		if ( player:GetEyeTrace().Entity:GetNWBool( "vehicleLocked", false ) ) then
			player:ChatPrint("This vehicle is locked, You cannot enter it.")
			return false
		else
			return true
		end
	end
end )