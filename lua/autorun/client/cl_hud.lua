-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

hook.Add( "HUDPaint", "CarKeysHUD", function()
	if ( LocalPlayer() == nil ) then return end
	if ( LocalPlayer():GetActiveWeapon() == nil ) then return end
	if not ( LocalPlayer():GetActiveWeapon():GetClass() == "carkeys" ) then return end
	
	local ply = LocalPlayer()

	if not ( ply:Alive() ) then return end
	if ( ply:InVehicle() ) then return end
	
	local trace = ply:GetEyeTrace().Entity
	local owner = trace:GetNWString( "vehicleOwner", "nil" )

	if ( table.HasValue( validVehicles, trace:GetClass() ) ) then
		if ( owner != "nil" ) then
			draw.DrawText( "Owned by " .. owner, "TargetID", ScrW()/2, ScrH()/2-10, Color(255, 255, 255), TEXT_ALIGN_CENTER)
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
end )