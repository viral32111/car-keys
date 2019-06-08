# Car Keys (Unofficial Fork by NotAKidoS)

**Project started: 15/02/2017, Last updated: 7/6/2019 by NotAKidoS**

This adds a Car Keys SWEP to Garry's Mod which lets players lock, unlock, buy and sell vehicles.

If you own the vehicle you have the ability to lock it, unlock it, drive it, sell it and pick it up with your physgun. (Admins on the server still have the ablity to pickup anyones car.)

If you've bought a car and your game crashes or you leave a server, the vehicle will still be yours when you join again as long as the server doesn't restart or have prop removal on disconnect.

If you're running DarkRP with this then you'll be able to utilise the buying, selling and set price chat command. (`!setprice <amount>`)

__Currently compatible with:__ *(Should work with almost every car in the game, if it doesn't though contact Viral32111 to possibly add support)*
* Any vehicle that is based on `prop_vehicle_jeep`, `prop_vehicle_jeep_old`, `prop_vehicle_airboat` and `prop_vehicle_prisoner_pod`.
* Any entity with the "carkeysSupported" NWBool
* [TDMCars](https://steamcommunity.com/sharedfiles/filedetails/?id=140550510)
* [LoneWolfie Cars](https://steamcommunity.com/workshop/filedetails/?id=221591331)
* [SCars](https://steamcommunity.com/workshop/filedetails/?id=149640069)
* [[simfphys] LUA Vehicles - Base](https://steamcommunity.com/sharedfiles/filedetails/?id=771487490)
* [[LFS] - Planes](https://steamcommunity.com/sharedfiles/filedetails/?id=1571918906)
* [Star Wars Vehicles: Episode 1](https://steamcommunity.com/sharedfiles/filedetails/?id=495762961)
* [Star Wars Vehicles: Episode 2](https://steamcommunity.com/sharedfiles/filedetails/?id=608632308)
* [WAC Aircraft](https://steamcommunity.com/sharedfiles/filedetails/?id=199107624) *(Except Halo, RoflCopter & MH-X Stealthhawk)*

__Changes between the Official and Unofficial fork:__ 
* Looped WAV sound instead of looping with timers
* Simfphys vehicles now use blinkers when alarm is playing
* Support for vehicles with the "carkeysSupported" NWBool
* Allows custom alarm sounds with the "carkeysCustomAlarm" NWBool and "carkeysCAlarmSound" NWString
* Ability to change key use location from origin of vehicle with "carkeysForwardPos", "carkeysRightPos", and "carkeysUpPos" NWFloats
* A couple of major bug fixes to do with the alarm sounding

__Example of adding support with the NWBool:__ 
*code snippet is from my own GTAV LFS Avenger*
```
sound.Add({ -- Create the custom alarm sound
	name = "avengeralarm",
	channel = CHAN_STATIC,
	volume = 0.4, 
	level = 80,
	sound = "gtaiv/gtaiv_mrtastyhorn_3.wav"
})

function ENT:RunOnSpawn() -- called when the vehicle is spawned
	self:SetNWBool("carkeysSupported", true)
	self:SetNWBool("carkeysCustomAlarm", true)
	self:SetNWFloat("carkeysForwardPos", 200 )
	self:SetNWFloat("carkeysRightPos", 0 )
	self:SetNWFloat("carkeysUpPos", 0 )
	self:SetNWString("carkeysCAlarmSound", "avengeralarm")
  -- the string MUST BE THE SAME NAME as specified in sound.add!!!
end
```
__Video of my plane:__ 

__Is it usefull?:__ 
YEA, These bools allow vehicle creators to add support for their custom entities without needing to go to Viral32111 or having players edit their supported car keys config list
Custom alarm code will work on any supported vehicle without the "carkeysSupported" NWBool!!!
Hopfully more vehicle creators will add support for this addon themselves without the need of Viral32111 doing it.

The NWBool "carKeysVehicleLocked" can be used to find if the vehicle is locked
The NWBool "carKeysVehicleAlarm" can be used to find if the vehicles alarm is playing
Ex) *this code snippet is of a Simfphys vehicle with support for this addon*
```
  OnSpawn = function(ent)
  -- simfphys is already supported in the carkeys config so you dont need the "carkeysSupported" bool!!!!!1!!!1! 2ewdasdf
  -- that is only needed on vehicles that Class names are not in the config file already. 
  -- (aka all LFS/WAC/SCars outside of their base addons as their Class name is diffrent for each of them!)
  -- You can find your vehicles class name if you let it kill you. My LFS Plane will say lunasflightschool_gtavenger while
  -- all simfphys vehicles will say gmod_sent_vehicle_fphysics_base. LFS/WAC/SCars or any other vehicle entity that is      
  -- not consistant with their class name across vehicles of the same type will most likely need the NWBool unless
  -- manually added in the car keys config file by either a server owner, a player, or Viral32111. 
    ent:SetNWBool("carkeysCustomAlarm", true)
    ent:SetNWString("carkeysCAlarmSound", "GTAVmeephornalarm")
    local IsLocked = ent:GetNWBool("carKeysVehicleLocked")
    local IsAlarm = ent:GetNWBool("carKeysVehicleAlarm")
  end,
  OnTick = function(ent)
    local loc = IsLocked and 1 or 0 -- turns the IsLocked TRUE or FALSE into a variable that is 1 or 0
    ent:SetPoseParameter("vehicle_closedoors", loc)
    -- sets door animation to 1 or 0 depending on if the car is locked
    -- you can have an if statement checking if its locked and do other things than what ive done here. This is a POC!
    
    if IsAlarm then
      ent:StallAndRestart( 0.1, false )
      -- constantly stall and restart the engine every 0.1 seconds if the alarm is on. idk its an example :P
    end
  end,
  
  *OUTSIDE THE SIMFPHYS SPAWNLIST CODE BLOCK THING*
  sound.Add({ -- Create the custom alarm sound
    name = "GTAVmeephornalarm",
    channel = CHAN_STATIC,
    volume = 0.4, 
    level = 80,
    sound = "meephorn_alarm.wav"
  })
```
  *THAT CODE SPECIFIED A CUSTOM ALARM, CUSTOM ALARM SOUND, IF LOCKED CLOSE DOOR ANIMATION, AND IF ALARM CONSTANTLY STALL AND RESTART THE CAR EVERY TENTH OF A SECOND JUST BECAUSE IDK*
  
Now you can see this allows for vehicle creators much more customisation and intigration with Car Keys!



*NOT THE SAME AS THIS UNOFFICIAL FORK*
[Workshop Version](https://steamcommunity.com/sharedfiles/filedetails/?id=864523561)

###### [Copyright 2017-2019 viral32111](LICENCE.txt)
