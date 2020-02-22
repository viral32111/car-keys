--[[-------------------------------------------------------------------------
Car Keys - A SWEP that lets players lock, unlock, buy and sell vehicles.
Copyright (C) 2017-2020 viral32111

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see https://www.gnu.org/licenses/.
---------------------------------------------------------------------------]]

function SWEP:GetViewModelPosition(position,angle)
	local owner=self.Owner
	if(IsValid(owner)==true)then position=position+owner:GetRight()*11+owner:GetAimVector()*21 end
	angle:RotateAroundAxis(angle:Up(),210)
	angle:RotateAroundAxis(angle:Right(),220)
	angle:RotateAroundAxis(angle:Forward(),10)
	return position,angle
end

function SWEP:DrawHUD()
	local ply=LocalPlayer()
	if(IsValid(ply)==false)or(ply:InVehicle()==true)then return end

	local ent=ply:GetEyeTrace().Entity
	if(IsValid(ent)==false)or(carKeys.IsVehicleSupported()==false)then return end

	if(ply:GetPos():DistToSqr(ent:GetPos())>150)then return end

	local owner = ent:GetNWEntity("carKeysVehicleOwner")
	--local price = ent:GetNWInt("carKeysVehiclePrice")

	if (owner != NULL) then -- Is the owner valid?
		draw.DrawText("Owned by " .. owner:Nick(), "TargetID", ScrW()/2, ScrH()/2+15, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		
		if (ply:GetEyeTrace().Entity:GetNWBool("carKeysVehicleLocked")) then
			draw.DrawText("Vehicle is locked", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		else
			draw.DrawText("Vehicle is unlocked", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		end
	else
		draw.DrawText("Vehicle is unowned!", "TargetID", ScrW()/2, ScrH()/2+15, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		
		if (engine.ActiveGamemode() == "darkrp") then -- Are we running DarkRP?
			draw.DrawText("Press R to buy it for $" .. price, "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		else
			draw.DrawText("Press R to acquire it", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		end
	end
end