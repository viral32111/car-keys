-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

SWEP.Author	 = "viral32111"
SWEP.Contact = "https://github.com/viral32111/car-keys/issues"
SWEP.Purpose = "To manage your vehicles"
SWEP.Instructions = "Left click locks vehicle, Right click unlocks vehicle, R owns/unowns vehicle"
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
		if not ( table.HasValue( validVehicles, trace.Entity:GetClass() ) ) then return false end
		
		if ( trace.Entity:GetNWString( "vehicleOwner", "N/A" ) == "N/A" ) then
			trace.Entity:SetNWString( "vehicleOwner", ply:Nick() )
			ply:EmitSound("ambient/machines/keyboard6_clicks.wav")
		else
			trace.Entity:SetNWString( "vehicleOwner", "N/A" )
			ply:EmitSound("buttons/lightswitch2.wav")
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
		if not ( table.HasValue( validVehicles, trace.Entity:GetClass() ) ) then return false end

		if ( trace.Entity:GetNWString( "vehicleOwner", "N/A" ) == ply:Nick() ) then
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
		if ( timer.Exists( "pauseTimer" ) ) then
			timer.Adjust( "pauseTimer", 0.01, 1, function() end )
			return
		else
			timer.Create( "pauseTimer", 0.01, 1, function() end )
		end

		local ply = self.Owner
		local trace = ply:GetEyeTrace()
		if not ( table.HasValue( validVehicles, trace.Entity:GetClass() ) ) then return false end
	 
		if ( trace.Entity:GetNWString( "vehicleOwner", "N/A" ) == ply:Nick() ) then
			ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
			trace.Entity:SetNWBool( "vehicleLocked", false )
			ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
		else
			ply:ChatPrint("You cannot unlock this vehicle, You don't own it.")
			ply:EmitSound("doors/handle_pushbar_locked1.wav")
		end
	end	
end