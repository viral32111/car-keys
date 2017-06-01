-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

include("shared.lua")
include("sh_carkeys_config.lua")

SWEP.PrintName = "Car Keys"			
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["Box001"] = { scale = Vector(3, 3, 3), pos = Vector(30, -15.37, -14.631), angle = Angle(-34.445, -81.112, -41.112) }
}

function SWEP:DrawHUD()
	local ply = LocalPlayer()
	local trace = ply:GetEyeTrace().Entity
	local owner = trace:GetNWString( "CarKeysVehicleOwner", "N/A" )

	if ( trace == nil ) then return end
	if ( ply:InVehicle() ) then return end

	if ( table.HasValue( CarKeysVehicles, tostring( ply:GetEyeTrace().Entity:GetClass() ) ) ) then
		if ( owner != "N/A" ) then
			draw.DrawText( "Owned by " .. owner, "TargetID", ScrW()/2, ScrH()/2+15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			if ( ply:GetEyeTrace().Entity:GetNWBool( "CarKeysVehicleLocked", false ) ) then
				draw.DrawText( "Vehicle is locked", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			else
				draw.DrawText( "Vehicle is unlocked", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			end
		else
			draw.DrawText( "Vehicle is unowned!", "TargetID", ScrW()/2, ScrH()/2+15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			draw.DrawText( "Press R to purchase it", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
		end
	end
end