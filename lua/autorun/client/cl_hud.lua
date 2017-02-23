-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

validVehicles = {
	"prop_vehicle_jeep",
	"prop_vehicle_airboat"
}

hook.Add( "HUDPaint", "CarKeysHUD", function()
	if ( LocalPlayer() == nil ) then return end
	if not ( LocalPlayer():Alive() or string.find( tostring( LocalPlayer():GetActiveWeapon() ), "carkeys" ) ) then return end
	if ( LocalPlayer():InVehicle() ) then return end

	local ply = LocalPlayer()
	local trace = ply:GetEyeTrace().Entity
	local owner = trace:GetNWString( "vehicleOwner", "nil" )

	if ( trace == nil ) then return end

	if ( table.HasValue( validVehicles, tostring( ply:GetEyeTrace().Entity ) ) ) then
		if ( owner != "nil" ) then
			draw.DrawText( "Owned by " .. owner, "TargetID", ScrW()/2, ScrH()/2+15, Color(255, 255, 255), TEXT_ALIGN_CENTER)
			if ( ply:GetEyeTrace().Entity:GetNWBool( "vehicleLocked", false ) ) then
				draw.DrawText( "Vehicle is locked", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color(255, 255, 255), TEXT_ALIGN_CENTER)
			else
				draw.DrawText( "Vehicle is unlocked", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color(255, 255, 255), TEXT_ALIGN_CENTER)
			end
		else
			draw.DrawText( "Vehicle is unowned!", "TargetID", ScrW()/2, ScrH()/2+15, Color(255, 255, 255), TEXT_ALIGN_CENTER)
			draw.DrawText( "Press R to acquire it", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		end
	end
end )