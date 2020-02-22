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

SWEP.PrintName="Car Keys"
SWEP.Category="Car Keys"

SWEP.Author="viral32111"
SWEP.Contact="https://viral32111.com"
SWEP.Purpose="Lock, unlock, buy and sell vehicles."
SWEP.Instructions="Left Click locks vehicle, Right Click unlocks vehicle, Reload buys/sells vehicle."

SWEP.Slot=1
SWEP.SlotPos=1
SWEP.DrawAmmo=false.

SWEP.Primary.ClipSize=-1
SWEP.Primary.DefaultClip=-1
SWEP.Primary.Automatic=false
SWEP.Primary.Ammo="none"

SWEP.Secondary.ClipSize=-1
SWEP.Secondary.DefaultClip=-1
SWEP.Secondary.Automatic=false
SWEP.Secondary.Ammo="none"

SWEP.ViewModelFOV=70
SWEP.ViewModel="models/sentry/pgkey.mdl"
SWEP.WorldModel=""

SWEP.AutoSwitchTo=false
SWEP.AutoSwitchFrom=false

function SWEP:Initialize()
	self:SetHoldType("normal")
end

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