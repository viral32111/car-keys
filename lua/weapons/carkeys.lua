--[[-------------------------------------------------------------------------
Car Keys - A SWEP that lets players lock, unlock, buy and sell vehicles.
Copyright (C) 2017 - 2021 viral32111 (https://viral32111.com).

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
--TOS of the license said i must point out all my code changes... i think?
--I will point them out by signing my comments with -nak for NotAKidoS

include("autorun/shared/sh_carkeys_config.lua") -- Include our configuration file.

SWEP.PrintName = "Car Keys"	-- SWEP Name.
SWEP.Category = "Car Keys" -- Spawnmenu Category.
SWEP.Spawnable = true -- Show it in the spawnmenu.

SWEP.Author = "viral32111" -- Me, because I made it :P
SWEP.Contact = "https://viral32111.com" -- Where to contact me.
SWEP.Purpose = "Lock, unlock, buy and sell vehicles." -- Purpose of this.
SWEP.Instructions = "Left Click locks vehicle, Right Click unlocks vehicle, Reload buys/sells vehicle." -- Instructions on how to use it.

SWEP.Slot = 1 -- Hotbar slot number.
SWEP.SlotPos = 1 -- Hotbar slot position.
SWEP.DrawAmmo = false -- Disable drawing ammo on the screen.

-- Set primary ammo to none.
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

-- Set secondary ammo to none.
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

-- View Model & World Model
SWEP.ViewModelFOV = 70
SWEP.UseHands = false
SWEP.ViewModel = "models/sentry/pgkey.mdl"
SWEP.WorldModel = "models/sentry/w_pgkey.mdl" --nak world model so the swep can be dropped properly and be in hand in 3rd person

-- Switching when player runs out of ammo.
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

-- Called when the SWEP is initilised for the first time.
function SWEP:Initialize()
	self:SetHoldType("normal") -- Set the hold type to "normal".
end

-- Called when the reload key is pressed.
function SWEP:Reload()
	if (CLIENT) then return end

	if (timer.Exists("carKeysReloadTimer")) then
		timer.Adjust("carKeysReloadTimer", 0.1, 1, function() end)
		return
	else
		timer.Create("carKeysReloadTimer", 0.1, 1, function() end)
	end

	local ply = self.Owner
	local ent = ply:GetEyeTrace().Entity

	if not IsSupported(ent, ply) then return end --nak look at bottom of file for function. turned the multiple copy paste code checks into a function to make allowing supported vehicles MUCH easier

	local owner = ent:GetNWEntity("carKeysVehicleOwner")
	local price = ent:GetNWInt("carKeysVehiclePrice")

	if (owner == NULL) then
		if (engine.ActiveGamemode() == "darkrp") then
			if (ply:canAfford(price)) then
				ply:addMoney(-price)
				ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"You've bought this vehicle for $\" .. tostring(LocalPlayer():GetEyeTrace().Entity:GetNWInt(\"carKeysVehiclePrice\")) .. \".\")")
				ent:SetNWEntity("carKeysVehicleOwner", ply)
				ent:EmitSound("ambient/machines/keyboard6_clicks.wav")
			else
				ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"You can't afford this vehicle! It costs $\" .. tostring(LocalPlayer():GetEyeTrace().Entity:GetNWInt(\"carKeysVehiclePrice\")) .. \".\")")
			end
		else
			ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"You have acquired this vehicle!\")")
			ent:SetNWEntity("carKeysVehicleOwner", ply)
			ent:EmitSound("ambient/machines/keyboard6_clicks.wav")
		end
	else
		if (owner:UniqueID() == ply:UniqueID()) then
			if (engine.ActiveGamemode() == "darkrp") then
				ply:addMoney(price)
				ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"You've sold your vehicle for $\" .. tostring(LocalPlayer():GetEyeTrace().Entity:GetNWInt(\"carKeysVehiclePrice\")) .. \".\")")
			else
				ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"You no longer own this vehicle.\")")
			end

			ent:SetNWBool("carKeysVehicleLocked", false)
			if (ent:GetClass() == "gmod_sent_vehicle_fphysics_base") then 
				ent:UnLock() --nak uses the built in lock/unlock with simfphys to disable the wheels from letting you in the car even if locked. Sent an issue report to Luna about simfphys remote control bypassing the built in simfphys lock function so hopfully thats fixed by them..
			end
			ent:SetNWEntity("carKeysVehicleOwner", NULL)
			ent:EmitSound("buttons/lightswitch2.wav")

			if ent:GetNWBool("carKeysVehicleAlarm") then
				timer.Remove("carKeysAlarmLights" .. ent:EntIndex())
				ent:StopSound("carKeysAlarmSound")
				ent:StopSound(ent:GetNWString("carkeysCAlarmSound"))
				ent:SetNWBool("carKeysVehicleAlarm", false)
				if (ent:GetClass() == "gmod_sent_vehicle_fphysics_base") then 
					net.Start( "simfphys_turnsignal" )
					net.WriteEntity( ent )
					net.WriteInt( 0, 32 )
					net.Broadcast()
				end
			end
		else
			ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"You can't purchase this vehicle, it's owned by \" .. LocalPlayer():GetEyeTrace().Entity:GetNWEntity(\"carKeysVehicleOwner\"):Nick() .. \".\")")
			ent:EmitSound("doors/handle_pushbar_locked1.wav")
		end
	end
end

-- Called when Left Click is pressed.
function SWEP:PrimaryAttack()
	if (CLIENT) or (not IsFirstTimePredicted()) then return end

	local ply = self.Owner
	local ent = ply:GetEyeTrace().Entity

	if not IsSupported(ent, ply) then return end --nak look at bottom of file for function. turned the multiple copy paste code checks into a function to make allowing supported vehicles MUCH easier

	local owner = ent:GetNWEntity("carKeysVehicleOwner")
	local price = ent:GetNWInt("carKeysVehiclePrice")

	if (owner != NULL) and (owner:UniqueID() == ply:UniqueID()) then
		ent:EmitSound("npc/metropolice/gear" .. math.floor(math.Rand(1, 7)) .. ".wav")
		ent:SetNWBool("carKeysVehicleLocked", true)
		if (ent:GetClass() == "gmod_sent_vehicle_fphysics_base") then 
			ent:Lock() --nak uses the built in lock/unlock with simfphys to disable the wheels from letting you in the car even if locked. 
		end

		if not (ent:WaterLevel() >= 1) then
			timer.Simple(0.5, function()
				if (ent:IsValid()) then
					ent:EmitSound("carkeys/lock.wav")
				end
			end)
		end
	else
		ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"You cannot lock this vehicle, you don't own it.\")")
		ent:EmitSound("doors/handle_pushbar_locked1.wav")
	end

	if not (timer.Exists("carKeysAnimationTimer")) then
		timer.Create("carKeysAnimationTimer", 2, 1, function() end)
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
		ply:SendLua("LocalPlayer():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)")
	end
end

-- Called when Right Click is pressed.
function SWEP:SecondaryAttack()
	if (CLIENT) or (not IsFirstTimePredicted()) then return end

	local ply = self.Owner
	local ent = ply:GetEyeTrace().Entity
	
	if not IsSupported(ent, ply) then return end --nak look at bottom of file for function. turned the multiple copy paste code checks into a function to make allowing supported vehicles MUCH easier
	
	local owner = ent:GetNWEntity("carKeysVehicleOwner")
	local price = ent:GetNWInt("carKeysVehiclePrice")

	if (owner != NULL) and (owner:UniqueID() == ply:UniqueID()) then
		if ent:GetNWBool("carKeysVehicleAlarm") == true then
			ent:SetNWBool("carKeysVehicleAlarm", false)
			ent:StopSound("carKeysAlarmSound")
			ent:StopSound(ent:GetNWString("carkeysCAlarmSound")) --nak Stop custom alarm sound if possible
			if (ent:GetClass() == "gmod_sent_vehicle_fphysics_base") then --nak check if simfphys and then remove blinkers
				net.Start( "simfphys_turnsignal" )
				net.WriteEntity( ent )
				net.WriteInt( 0, 32 )
				net.Broadcast()
			end
			timer.Remove("carKeysAlarmLights" .. ent:EntIndex())
			ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"Car alarm stopped.\")")
		end

		ent:EmitSound("npc/metropolice/gear" .. math.floor(math.Rand(1, 7)) .. ".wav")
		ent:SetNWBool("carKeysVehicleLocked", false)
		if (ent:GetClass() == "gmod_sent_vehicle_fphysics_base") then 
			ent:UnLock() --nak uses the built in lock/unlock with simfphys to disable the wheels from letting you in the car even if locked. Simfphys RC remote still bypasses this.. hopfully Luna fixes it
		end
	else
		ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"You cannot unlock this vehicle, you don't own it.\")")
		ent:EmitSound("doors/handle_pushbar_locked1.wav")
	end
	
	if not (timer.Exists("carKeysAnimationTimer")) then
		timer.Create("carKeysAnimationTimer", 2, 1, function() end)
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
		ply:SendLua("LocalPlayer():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)")
	end
end

-- Sets the view model position

function SWEP:GetViewModelPosition(position, angle)
	local owner = self.Owner

	if (IsValid(owner)) then
		position = position + owner:GetUp()*-1 + owner:GetRight()*9 + owner:GetAimVector()*20
	end
	--naknaknak this code will move the key but not scale to the players screen. edit: could be wrong idk
	--[[		
	local ply = LocalPlayer()
	local X = ScrW()
	local Y = ScrH()
	-- example of getting the player on the client and their screen size, i dont have a clue currently how to impliment it..
	--]]
	angle:RotateAroundAxis(angle:Up(), 210)
	angle:RotateAroundAxis(angle:Right(), 220)
	angle:RotateAroundAxis(angle:Forward(), 10)

	return position, angle
end

-- Custom HUD that shows the white text in the middle of the screen.
function SWEP:DrawHUD()
	local ply = LocalPlayer() -- Get the player
	local ent = ply:GetEyeTrace().Entity -- Get the entity the player is looking at
	
	if not IsSupported(ent, ply) then return end --nak look at bottom of file for function. turned the multiple copy paste code checks into a function to make allowing supported vehicles MUCH easier
	--nakkkkk theres so many of these checks for if its a supported vehicle and if its far away... should be a function by now :L EDIT: made it a function <O/
	
	local owner = ent:GetNWEntity("carKeysVehicleOwner") -- Get the vehicle's owner
	local price = ent:GetNWInt("carKeysVehiclePrice") -- Get the vehicle's price

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

--NAK made the multiple checks if supported into a function so i dont need to repeat copy paste my patches
function IsSupported(ent, ply)
	if ent:GetNWBool("carkeysSupported") and not (ply:InVehicle()) and (ply:GetPos():Distance( (ent:GetPos() + ent:GetForward()*ent:GetNWFloat("carkeysForwardPos") + ent:GetRight()*ent:GetNWFloat("carkeysRightPos") + ent:GetUp()*ent:GetNWFloat("carkeysUpPos") ) ) <= 150) or (ply:InVehicle()) then elseif (ent == nil or ent == NULL) or (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (ply:GetPos():Distance(ent:GetPos()) >= 150) then return end  -- Stop execution if vehicle is invalid, or player is more than 150 units away.
	return true -- if the vehicle passes the check return true.. (im learning new tricks in lua yaaaaaaaaa boi)
end
function IsCarKeyable(ent, ply)
	if ent:GetNWBool("carkeysSupported") and not (ply:InVehicle()) then elseif (ent == nil or ent == NULL) or (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (ply:InVehicle()) then return end  -- Stop execution if vehicle is invalid, or player is more than 150 units away.
	return true -- This function is the same as above but with no distance. For checks related to entering vehicle not lock/unlock with the swep
end