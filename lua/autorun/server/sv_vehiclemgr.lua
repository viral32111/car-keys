if ( CLIENT ) then return end

--[[-------------------------------------------------------------------------
Vehicle Table
---------------------------------------------------------------------------]]
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

--[[-------------------------------------------------------------------------
Vehicle Locking
---------------------------------------------------------------------------]]
hook.Add( "PlayerUse", "CarKeysUseVehicle", function( ply, ent )
	if ( table.HasValue( validVehicles, ent:GetClass() ) ) then
		if ( ent:GetNWBool( "vehicleLocked", false ) ) then
			return false
		else
			return true
		end
	end
end )

hook.Add( "KeyPress", "CarKeysVehicleMessage", function( ply, key )
	if ( key == IN_USE ) then
		if ( table.HasValue( validVehicles, ply:GetEyeTrace().Entity:GetClass() ) ) then
			if ( ply:GetEyeTrace().Entity:GetNWBool( "vehicleLocked", false ) ) then
				ply:SendLua(' chat.AddText( Color( 0, 180, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "This vehicle is locked, You cannot enter it." ) ')
			end
		end
	end
end )

--[[-------------------------------------------------------------------------
Vehicle Pickup
---------------------------------------------------------------------------]]
hook.Add( "PhysgunPickup", "CarKeysVehiclePickingUp", function( ply, ent )
	if ( table.HasValue( validVehicles, ent:GetClass() ) ) then
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