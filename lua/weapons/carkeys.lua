--[[-------------------------------------------------------------------------
Copyright 2017-2020 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

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
SWEP.ViewModel = "models/sentry/pgkey.mdl"
SWEP.WorldModel = ""

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

	if (ent == nil or ent == NULL) or (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (ply:GetPos():Distance(ent:GetPos()) >= 150) then return end  -- Stop execution if vehicle is invalid, or player is more than 150 units away.

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
			ent:SetNWEntity("carKeysVehicleOwner", NULL)
			ent:EmitSound("buttons/lightswitch2.wav")

			if (ent:GetNWBool("carKeysVehicleAlarm")) then
				timer.Remove("carKeysLoopAlarm" .. ent:EntIndex())
				timer.Remove("carKeysAlarmLights" .. ent:EntIndex())
				ent:StopSound("carKeysAlarmSound")
				ent:SetNWBool("carKeysVehicleAlarm", false)
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

	if (ent == nil or ent == NULL) or (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (ply:GetPos():Distance(ent:GetPos()) >= 150) then return end  -- Stop execution if vehicle is invalid, or player is more than 150 units away.

	local owner = ent:GetNWEntity("carKeysVehicleOwner")
	local price = ent:GetNWInt("carKeysVehiclePrice")

	if (owner != NULL) and (owner:UniqueID() == ply:UniqueID()) then
		ent:EmitSound("npc/metropolice/gear" .. math.floor(math.Rand(1, 7)) .. ".wav")
		ent:SetNWBool("carKeysVehicleLocked", true)

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

	if (ent == nil or ent == NULL) or (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (ply:GetPos():Distance(ent:GetPos()) >= 150) then return end  -- Stop execution if vehicle is invalid, or player is more than 150 units away.

	local owner = ent:GetNWEntity("carKeysVehicleOwner")
	local price = ent:GetNWInt("carKeysVehiclePrice")

	if (owner != NULL) and (owner:UniqueID() == ply:UniqueID()) then
		if (ent:GetNWBool("carKeysVehicleAlarm")) then
			ent:SetNWBool("carKeysVehicleAlarm", false)
			ent:StopSound("carKeysAlarmSound")

			timer.Remove("carKeysLoopAlarm" .. ent:EntIndex())
			timer.Remove("carKeysAlarmLights" .. ent:EntIndex())

			ply:SendLua("chat.AddText(Color(26, 198, 255), \"(Car Keys) \", Color(255, 255, 255), \"Car alarm stopped.\")")
		end

		ent:EmitSound("npc/metropolice/gear" .. math.floor(math.Rand(1, 7)) .. ".wav")
		ent:SetNWBool("carKeysVehicleLocked", false)
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
		position = position + owner:GetRight()*11 + owner:GetAimVector()*21
	end

	angle:RotateAroundAxis(angle:Up(), 210)
	angle:RotateAroundAxis(angle:Right(), 220)
	angle:RotateAroundAxis(angle:Forward(), 10)

	return position, angle
end

-- Custom HUD that shows the white text in the middle of the screen.
function SWEP:DrawHUD()
	local ply = LocalPlayer() -- Get the player
	local ent = ply:GetEyeTrace().Entity -- Get the entity the player is looking at
	
	if (ent == nil or ent == NULL) or (ply:InVehicle()) or (carKeysVehicles[ent:GetClass()] == nil) or (carKeysVehicles[ent:GetClass()].valid == false) or (ply:GetPos():Distance(ent:GetPos()) >= 150) then return end  -- Stop execution if vehicle is invalid, the player is in a vehicle, or player is more than 150 units away.

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