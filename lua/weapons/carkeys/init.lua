-- Copyright 2017 viral32111. https://github.com/viral32111/car-keys/blob/master/LICENCE

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/sentry/pgkey.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["Box001"] = { scale = Vector(3, 3, 3), pos = Vector(30, -15.37, -14.631), angle = Angle(-34.445, -81.112, -41.112) }
}