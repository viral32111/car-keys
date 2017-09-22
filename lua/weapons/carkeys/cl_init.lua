--[[-------------------------------------------------------------------------
Copyright 2017 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

include("shared.lua")
include("sh_carkeys_config.lua")

SWEP.PrintName = "Car Keys"			
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false

function SWEP:DrawHUD()
	local ply = LocalPlayer()
	local trace = ply:GetEyeTrace().Entity
	local owner = trace:GetNWString( "CarKeysVehicleOwner", "N/A" )
	local Price = tostring( trace:GetNWInt( "CarKeysVehiclePrice", 0 ) )

	if ( trace == nil ) then return end
	if ( ply:InVehicle() ) then return end

	if ( table.HasValue( CarKeysVehicles, trace:GetClass() ) ) then
		if ( owner != "N/A" ) then
			draw.DrawText( "Owned by " .. owner, "TargetID", ScrW()/2, ScrH()/2+15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			if ( ply:GetEyeTrace().Entity:GetNWBool( "CarKeysVehicleLocked", false ) ) then
				draw.DrawText( "Vehicle is locked", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			else
				draw.DrawText( "Vehicle is unlocked", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			end
		else
			draw.DrawText( "Vehicle is unowned!", "TargetID", ScrW()/2, ScrH()/2+15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			if ( string.find( engine.ActiveGamemode(), "rp" ) ) then
				draw.DrawText( "Press R to buy it for $" .. Price, "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			else
				draw.DrawText( "Press R to acquire it", "TargetIDSmall", ScrW()/2, ScrH()/2+35, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			end
		end
	end
end