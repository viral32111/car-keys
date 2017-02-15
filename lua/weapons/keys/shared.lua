SWEP.Author	 = "viral32111"
SWEP.Contact = "https://github.com/viral32111/car-keys/issues"
SWEP.Purpose = "To lock your cars"
SWEP.Instructions = "Left click locks vehicle, Right click unlocks vehicle"
SWEP.Category = "Car Keys"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel = ""
SWEP.WorldModel = ""

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

function SWEP:PrimaryAttack()
	local ply = self.Owner
	local trace = ply:GetEyeTrace()
	if not ( table.HasValue( validVehicles, trace.Entity:GetClass() ) ) then return end

	ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
	trace.Entity:SetNWBool( "vehicleLocked", true )

	ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
end

function SWEP:SecondaryAttack()
	local ply = self.Owner
	local trace = ply:GetEyeTrace()
	if not ( table.HasValue( validVehicles, trace.Entity:GetClass() ) ) then return end
 
	ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
	trace.Entity:SetNWBool( "vehicleLocked", false )

	ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
end

hook.Add( "CanPlayerEnterVehicle", "vehicleManager", function( player, vehicle, sRole )
	if ( SERVER ) then
		if not ( table.HasValue( validVehicles, player:GetEyeTrace().Entity:GetClass() ) ) then return end

		if ( player:GetEyeTrace().Entity:GetNWBool( "vehicleLocked", false ) ) then
			return false
		else
			return true
		end
	end
end )