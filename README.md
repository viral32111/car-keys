# Car Keys

This adds a Car Keys SWEP to Garry's Mod which lets players lock, unlock, buy and sell vehicles.

There's also a version on the Steam Workshop available [here](https://steamcommunity.com/sharedfiles/filedetails/?id=864523561), it won't always be kept as up to date as this version but if you're not using an SVN and you would rather have an auto-updating version it's better to use the workshop one.

## How to use

If you own the vehicle you have the ability to lock it, unlock it, drive it, sell it and pick it up with your physgun. (Admins on the server still have the ablity to pickup anyones car.)

If you've bought a car and your game crashes or you leave a server, the vehicle will still be yours when you join again as long as the server doesn't restart or have prop removal on disconnect.

## Configuration

If you're running DarkRP with this then you'll be able to utilise the buying, selling and set price chat command. (`!setprice <amount>`)

## Vehicle Support

It's possible to add your own support for vehicles in `Spawnmenu > Utilities > Car Keys > Vehicle Support`, that being said there's still native support for the following:

* Half-Life 2 vehicles
* [TDMCars](https://steamcommunity.com/sharedfiles/filedetails/?id=140550510)
* [LoneWolfie Cars](https://steamcommunity.com/workshop/filedetails/?id=221591331)
* [SCars](https://steamcommunity.com/workshop/filedetails/?id=149640069)
* [[simfphys] LUA Vehicles - Base](https://steamcommunity.com/sharedfiles/filedetails/?id=771487490)
* [[LFS] - Planes](https://steamcommunity.com/sharedfiles/filedetails/?id=1571918906)
* [Star Wars Vehicles: Episode 1](https://steamcommunity.com/sharedfiles/filedetails/?id=495762961)
* [Star Wars Vehicles: Episode 2](https://steamcommunity.com/sharedfiles/filedetails/?id=608632308)
* [WAC Aircraft](https://steamcommunity.com/sharedfiles/filedetails/?id=199107624) *Except Halo, RoflCopter & MH-X Stealthhawk
* [[LFS] Jedi Starfighters](https://steamcommunity.com/sharedfiles/filedetails/?id=1580175017)
* [SW Vehicles : TIE Fighters [LFS]](https://steamcommunity.com/sharedfiles/filedetails/?id=1580978413)

## Buying & Selling Support

You must be running one of the following gamemodes to use the price based buying & selling feature:

* [DarkRP](https://github.com/FPtje/DarkRP)

## Translations

I apprechiate all the hard work everyone has done to make this addon available in so many other languages, thank you :D

The following languages are supported:

* [English (GB)](lua/carkeys/translations/en-gb.lua)

### How to switch client language

When using the addon for the first time an assumption on what language you use will be made based on the result of `system.GetCountry()`, this is usually accurate unless you happen to be using a VPN/Proxy or another country/language spoofing software.

To specifically set your language you can either:

* Open the spawnmenu, navigate to `Utilities > Car Keys > Client Options` and set "Language" option to your desired language.
* Set the `cl_carkeys_language` convar to your desired language locale, a list can be found [here](lua/carkeys/translations) (excluding the `.lua` extension).

### How to switch server language

Set the convar `sv_carkeys_language` to the desired language locale, a list can be found [here](lua/carkeys/translations) (excluding the `.lua` extension).
For example, if you want to set the server language to English (GB) you would set the convar `sv_carkeys_language en-gb`.

## Developer Guide

I've created this addon in such a way that making external addons for it should be relatively easy for the average programmer/developer.

### Global Variables

Commit number of the locally installed version:

```lua
number carKeys.localCommit
```

Commit number of the latest remote version (returns `-1` if fetching hte latest version failed):

```lua
number carKeys.remoteCommit
```

### Functions

Returns true or false depending on wether the specified vehicle is supported or not:

```lua
boolean carKeys.isVehicleSupported(string class) -- Shared
```

Returns true or false depending on wether the specified player has the nessasary permissions to access the server settings in the spawnmenu:

```lua
boolean carKeys.hasSettingPermissions(player ply) -- Serverside
```

Returns true or false depending on wether the specified player has the nessasary permissions to physgun other players vehicles without owning them:

```lua
boolean carKeys.hasPhysgunPermissions(player ply) -- Serverside
```

Returns true or false depending on wether custom vehicle support reporting is enabled:

```lua
boolean carKeys.isReportingEnabled() -- Serverside
```

Returns a 5 character locale string that represents what language the specified player is using:

```lua
string carKeys.getPlayerLanguage(player ply) -- Serverside
```

## Hooks

Called when a player acquires/buys a vehicle (return `false` to prevent the purchase):

```lua
boolean carKeysVehicleBought(player buyer, entity vehicle, number price)
```

Note: The `price` argument will be `nil` if the vehicle was acquired, not bought (buying is only supported in a few gamemodes).

Called when a player disowns/sells a vehicle (return `false` to prevent the disownership):

```lua
boolean carKeysVehicleDisowned(player buyer, entity vehicle, number price)
```

Note: The `price` argument will be `nil` if the vehicle was disowned, not sold (selling is only supported in a few gamemodes).

## Contributions & Credits

Many have contributed to this project, credit goes to:

* [Morretz](https://steamcommunity.com/profiles/76561198204059269) for the car key model.
* [Skynet](https://steamcommunity.com/profiles/76561198192118142) for suggesting native support for [[LFS] Jedi Starfighters](https://steamcommunity.com/sharedfiles/filedetails/?id=1580175017) and [SW Vehicles : TIE Fighters [LFS]](https://steamcommunity.com/sharedfiles/filedetails/?id=1580978413).

## Copyright License

This addon is licensed under the [GNU General Public Licence v3.0](https://choosealicense.com/licenses/gpl-3.0/) (GNU GPLv3).

Permissions:

* Commercial use - This software and derivatives may be used for commercial purposes.
* Distribution - This software may be distributed.
* Modification - This software may be modified.
* Patent use - This license provides an express grant of patent rights from contributors.
* Private use - This software may be used and modified in private.

Conditions:

* Disclose source - Source code must be made available when the software is distributed.
* License and copyright notice - A copy of the license and copyright notice must be included with the software.
* Same license - Modifications must be released under the same license when distributing the software. In some cases a similar or related license may be used.
* State changes - Changes made to the code must be documented.

Limitations:

* Liability - This license includes a limitation of liability.
* Warranty - The license explicitly states that it does NOT provide any warranty.

>Car Keys - A SWEP that lets players lock, unlock, buy and sell vehicles.
>Copyright (C) 2017-2020 viral32111
>
>This program is free software: you can redistribute it and/or modify
>it under the terms of the GNU General Public License as published by
>the Free Software Foundation, either version 3 of the License, or
>(at your option) any later version.
>
>This program is distributed in the hope that it will be useful,
>but WITHOUT ANY WARRANTY; without even the implied warranty of
>MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>GNU General Public License for more details.
>
>You should have received a copy of the GNU General Public License
>along with this program. If not, see https://www.gnu.org/licenses/.