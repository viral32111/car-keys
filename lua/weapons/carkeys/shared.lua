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

include("sh_carkeys_config.lua")

SWEP.Author = "viral32111"
SWEP.Contact = "www.github.com/viral32111"
SWEP.Purpose = "Manage your vehicles"
SWEP.Instructions = "Left click locks vehicle. Right click unlocks vehicle. R purchases vehicle"
SWEP.Category = "viral32111's scripts"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "normal"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/sentry/pgkey.mdl"
SWEP.WorldModel = "models/sentry/pgkey.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.ViewModelBoneMods = {
	["Box001"] = { scale = Vector(1.215, 1.215, 1.215), pos = Vector(16.364, -9.473, -9.41), angle = Angle(-24.66, -112.496, -33.352) }
}

--if ( CLIENT ) then
SWEP.v_bonemods = {
	["Box001"] = { scale = Vector(1.215, 1.215, 1.215), pos = Vector(16.364, -9.473, -9.41), angle = Angle(-24.66, -112.496, -33.352) }
}
--end

SWEP.WElements = {
	["carkey_worldmodel"] = { type = "Model", model = "models/sentry/pgkey.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.878, 1.86, -5.7), angle = Angle(0, 24.231, 0), size = Vector(1.08, 1.08, 1.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.w_bonemods = {
	["carkeys_world"] = { type = "Model", model = "models/sentry/pgkey.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.763, 0.037, -6.15), angle = Angle(1.61, -3.158, 9.465), size = Vector(1.08, 1.08, 1.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Reload()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "CarKeysReloadTimer" ) ) then
			timer.Adjust( "CarKeysReloadTimer", 0.1, 1, function() end )
			return
		else
			timer.Create( "CarKeysReloadTimer", 0.1, 1, function() end )
		end

		local ply = self.Owner
		local trace = ply:GetEyeTrace()
		local Price = trace.Entity:GetNWInt( "CarKeysVehiclePrice", 0 )

		if not ( table.HasValue( CarKeysVehicles, trace.Entity:GetClass() ) ) then return end
		
		if ( trace.Entity:GetNWString( "CarKeysVehicleOwner", "N/A" ) == "N/A" ) then
			if ( table.HasValue( CarKeysRPGamemodes, engine.ActiveGamemode() ) or string.find( engine.ActiveGamemode(), "rp" ) ) then
				if ( ply:canAfford( Price ) ) then
					ply:addMoney( -Price )
					ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You have bought this vehicle for $" .. tostring( LocalPlayer():GetEyeTrace().Entity:GetNWInt( "CarKeysVehiclePrice", 0 ) ) ) ]])
					trace.Entity:SetNWString( "CarKeysVehicleOwner", ply:Nick() )
					ply:EmitSound("ambient/machines/keyboard6_clicks.wav")
				else
					ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot affort this vehicle! It cost $" .. tostring( LocalPlayer():GetEyeTrace().Entity:GetNWInt( "CarKeysVehiclePrice", 0 ) ) ) ]])
				end
			else
				ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You have acquired this vehicle!" ) ]])
				trace.Entity:SetNWString( "CarKeysVehicleOwner", ply:Nick() )
				ply:EmitSound("ambient/machines/keyboard6_clicks.wav")
				print("[Car Keys] Cannot subtract money ($" .. Price .. ") from " .. ply:Nick() .. " for buying vehicle because gamemode is not of a roleplay type!")
			end
		else
			if ( trace.Entity:GetNWString( "CarKeysVehicleOwner", "N/A" ) == ply:Nick() ) then
				if ( table.HasValue( CarKeysRPGamemodes, engine.ActiveGamemode() ) or string.find( engine.ActiveGamemode(), "rp" ) ) then
					ply:addMoney( Price )
					ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You have sold your vehicle for $" .. tostring( LocalPlayer():GetEyeTrace().Entity:GetNWInt( "CarKeysVehiclePrice", 0 ) ) ) ]])
				else
					ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You have sold your vehicle!" ) ]])
					print("[Car Keys] Cannot add money ($" .. Price .. ") to " .. ply:Nick() .. " for selling vehicle because gamemode is not of a roleplay type!")
				end

				trace.Entity:SetNWString( "CarKeysVehicleOwner", "N/A" )
				ply:EmitSound("buttons/lightswitch2.wav")
			else
				ply:SendLua([[ chat.AddText( Color( 26, 198, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot purchase this vehicle, It is owned by " .. LocalPlayer():GetEyeTrace().Entity:GetNWString( "CarKeysVehicleOwner", "N/A" ) ) ]])
				ply:EmitSound("doors/handle_pushbar_locked1.wav")
			end
		end
	end
end

function SWEP:PrimaryAttack()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "CarKeysPrimaryAttackTimer" ) ) then
			timer.Adjust( "CarKeysPrimaryAttackTimer", 0.01, 1, function() end )
			return
		else
			timer.Create( "CarKeysPrimaryAttackTimer", 0.01, 1, function() end )
		end

		local ply = self.Owner
		local trace = ply:GetEyeTrace()

		if not ( table.HasValue( CarKeysVehicles, trace.Entity:GetClass() ) ) then return end

		if ( trace.Entity:GetNWString( "CarKeysVehicleOwner", "N/A" ) == ply:Nick() ) then
			ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
			trace.Entity:SetNWBool( "CarKeysVehicleLocked", true )
		else
			ply:SendLua([[ chat.AddText( Color( 0, 180, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot lock this vehicle, You don\'t own it." ) ]])
			ply:EmitSound("doors/handle_pushbar_locked1.wav")
		end
		ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
		ply:SendLua([[ LocalPlayer():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true) ]])
	end
end

function SWEP:SecondaryAttack()
	if ( SERVER and IsFirstTimePredicted() ) then
		if ( timer.Exists( "CarKeysSecondaryAttackTimer" ) ) then
			timer.Adjust( "CarKeysSecondaryAttackTimer", 0.01, 1, function() end )
			return
		else
			timer.Create( "CarKeysSecondaryAttackTimer", 0.01, 1, function() end )
		end

		local ply = self.Owner
		local trace = ply:GetEyeTrace()

		if not ( table.HasValue( CarKeysVehicles, trace.Entity:GetClass() ) ) then return end
	 
		if ( trace.Entity:GetNWString( "CarKeysVehicleOwner", "N/A" ) == ply:Nick() ) then
			ply:EmitSound("npc/metropolice/gear" .. math.floor( math.Rand( 1, 7 ) ) .. ".wav")
			trace.Entity:SetNWBool( "CarKeysVehicleLocked", false )
		else
			ply:SendLua([[ chat.AddText( Color( 0, 180, 255 ), "(Car Keys) ", Color( 255, 255, 255 ), "You cannot unlock this vehicle, You don\'t own it." ) ]])
			ply:EmitSound("doors/handle_pushbar_locked1.wav")
		end
		ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true )
		ply:SendLua([[ LocalPlayer():AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true ) ]])
	end	
end

--[[if ( CLIENT ) then
   function SWEP:CalcViewModelView( ent, oldPos, oldAng, pos, ang )
	-- pos = pos + ang:Right() * 7 + ang:Forward() * 17 + ang:Up() * -4.5
	pos = Vector(16.364, -9.473, -9.41)
	
	ang:RotateAroundAxis( ang:Up(), 170 )
	ang:RotateAroundAxis( ang:Right(), -70 )
	
	ent:SetPos( pos )
	ent:SetAngles( ang )
   end
end]]

--[[function SWEP:GetViewModelPosition( pos, ang )
	pos = pos + 1*ang:Up() - ang:Forward() - 1*ang:Right()
	//pos = pos - Vector( -3, 3, 1 )
	// ang = ang + Angle( 180, 0, 0 )
	return pos, ang
end]]

--[[SWEP.WElements = {
	["carkey_worldmodel"] = { type = "Model", model = "models/sentry/pgkey.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.878, 1.86, -5.7), angle = Angle(0, 24.231, 0), size = Vector(1.08, 1.08, 1.08), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

--if ( CLIENT ) then
	SWEP.v_bonemods = {
		["Box001"] = { scale = Vector(1.215, 1.215, 1.215), pos = Vector(16.364, -9.473, -9.41), angle = Angle(-24.66, -112.496, -33.352) }
	}
--end]]