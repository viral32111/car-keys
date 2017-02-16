-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

include("shared.lua")

SWEP.PrintName = "Car Keys"			
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

hook.Add( "HUDPaint", "KeysHUD", function()
	local ply = LocalPlayer()
	local vehicle = ply:GetEyeTrace().Entity
	local ownerName = LocalPlayer():GetEyeTrace().Entity:GetNWString( "vehicleOwner", "nil" )


	if not ( ply:Alive() ) then return end
	if ( ply:InVehicle() ) then return end

	if ( ply:GetActiveWeapon():GetClass() == "carkeys" ) then
		if ( table.HasValue( validVehicles, vehicle:GetClass() ) ) then
			if ( ownerName != "nil" ) then
				draw.DrawText( "Owned by " .. ownerName, "TargetID", ScrW()/2, ScrH()/2-10, Color(255, 255, 255), TEXT_ALIGN_CENTER)
				if ( ply:GetEyeTrace().Entity:GetNWBool( "vehicleLocked", false ) ) then
					draw.DrawText( "Vehicle is locked", "TargetIDSmall", ScrW()/2, ScrH()/2+9, Color(255, 255, 255), TEXT_ALIGN_CENTER)
				else
					draw.DrawText( "Vehicle is unlocked", "TargetIDSmall", ScrW()/2, ScrH()/2+9, Color(255, 255, 255), TEXT_ALIGN_CENTER)
				end
			else
				draw.DrawText( "Vehicle is unowned!", "TargetID", ScrW()/2, ScrH()/2-10, Color(255, 255, 255), TEXT_ALIGN_CENTER)
				draw.DrawText( "Press R to acquire it", "TargetIDSmall", ScrW()/2, ScrH()/2+9, Color(255, 255, 255), TEXT_ALIGN_CENTER)
			end
		end
	end
end )