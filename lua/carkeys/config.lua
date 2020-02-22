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

-- This informs me (viral32111) whenever you add support for a car yourself within the game. By leaving this enabled, I can use the data to add native support for the vehicles you had to add, credit will be given.
carKeys.config.reportNewVehicles=true,

-- Groups listed here can access the server settings within the spawnmenu.
carKeys.config.spawnmenuAdminGroups={
	["superadmin"]=true
}

-- Groups listed here can pickup other players vehicles without being the owner of them.
carKeys.config.physgunAdminGroups={
	["superadmin"]=true,
	["admin"]=true,
	["operator"]=true
}

-- These are base vehicle classes that are natively supported.
carKeys.config.supportedBaseClasses={
	-- [LFS] Planes (https://steamcommunity.com/sharedfiles/filedetails/?id=1571918906)
	["lunasflightschool_basescript"]={alarm=false},

	-- Star Wars Vehicles: Episode 1 (https://steamcommunity.com/sharedfiles/filedetails/?id=495762961)
	["fighter_base"]={alarm=false},
	["speeder_base"]={alarm=false}

	-- Star Wars Vehicles: Episode 2 (https://steamcommunity.com/sharedfiles/filedetails/?id=608632308)
	-- ["example"]={alarm=false},

	-- [simfphys] LUA Vehicles - Base (https://steamcommunity.com/sharedfiles/filedetails/?id=771487490)
	-- ["gmod_sent_vehicle_fphysics_base"]={alarm=true},

	-- SCars Basic (https://steamcommunity.com/sharedfiles/filedetails/?id=104487316)
	-- ["sent_sakarias_car_base"]={alarm=true},

	-- SCars Extra (https://steamcommunity.com/sharedfiles/filedetails/?id=104492363)
	-- ["example"]={alarm=true},

	-- SCars Slim (https://steamcommunity.com/sharedfiles/filedetails/?id=104483020)
	-- ["example"]={alarm=true},

	-- WAC Aircraft (https://steamcommunity.com/sharedfiles/filedetails/?id=104990330)
	-- ["example"]={alarm=false},
}

-- These are individual vehicle classes that are natively supported.
carKeys.config.supportedIndividualClasses={
	-- Half-Life 2 (Includes TDMCars, LW Cars, etc.)
	--[[["prop_vehicle_jeep"]={alarm=true}
	["prop_vehicle_jeep_old"]={alarm=true},
	["prop_vehicle_airboat"]={alarm=true},
	["prop_vehicle_prisoner_pod"]={alarm=true},]]

	-- [simfphys] LUA Vehicles - Base (https://steamcommunity.com/sharedfiles/filedetails/?id=771487490)
	--[[["gmod_sent_vehicle_fphysics_base"] = {valid=true, alarm=true},
	["gmod_sent_vehicle_fphysics_wheel"] = {valid=false, alarm=false},

	-- SCars (https://steamcommunity.com/workshop/filedetails/?id=149640069)
	["sent_sakarias_car_banshee"] = {valid=true, alarm=true},
	["sent_sakarias_car_belair"] = {valid=true, alarm=true},
	["sent_sakarias_car_bobcat"] = {valid=true, alarm=true},
	["sent_sakarias_car_bus"] = {valid=true, alarm=true},
	["sent_sakarias_car_cadillac"] = {valid=true, alarm=true},
	["sent_sakarias_car_camaro"] = {valid=true, alarm=true},
	["sent_sakarias_car_chaos126p"] = {valid=true, alarm=true},
	["sent_sakarias_car_chevy66"] = {valid=true, alarm=true},
	["sent_sakarias_car_clydesdale"] = {valid=true, alarm=true},
	["sent_sakarias_car_comet"] = {valid=true, alarm=true},
	["sent_sakarias_car_delorean"] = {valid=true, alarm=true},
	["sent_sakarias_car_fordgt"] = {valid=true, alarm=true},
	["sent_sakarias_car_hedgehog"] = {valid=true, alarm=true},
	["sent_sakarias_car_hummer"] = {valid=true, alarm=true},
	["sent_sakarias_car_humvee"] = {valid=true, alarm=true},
	["sent_sakarias_car_huntley"] = {valid=true, alarm=true},
	["sent_sakarias_car_impala88"] = {valid=true, alarm=true},
	["sent_sakarias_car_junker4"] = {valid=true, alarm=true},
	["sent_sakarias_car_mothtruck"] = {valid=true, alarm=true},
	["sent_sakarias_car_mustang"] = {valid=true, alarm=true},
	["sent_sakarias_car_police"] = {valid=true, alarm=true},
	["sent_sakarias_car_ratmobile"] = {valid=true, alarm=true},
	["sent_sakarias_car_sabre"] = {valid=true, alarm=true},
	["sent_sakarias_car_stagpickup"] = {valid=true, alarm=true},
	["sent_sakarias_car_studebaker"] = {valid=true, alarm=true},
	["sent_sakarias_car_taxi"] = {valid=true, alarm=true},
	["sent_sakarias_car_1996corvette"] = {valid=true, alarm=true},
	["sent_sakarias_car_abrams"] = {valid=true, alarm=true},
	["sent_sakarias_car_brera"] = {valid=true, alarm=true},
	["sent_sakarias_car_carreragt"] = {valid=true, alarm=true},
	["sent_sakarias_car_dodgeram"] = {valid=true, alarm=true},
	["sent_sakarias_car_ferrari360"] = {valid=true, alarm=true},
	["sent_sakarias_car_ferrarif50"] = {valid=true, alarm=true},
	["sent_sakarias_car_ferrarif430"] = {valid=true, alarm=true},
	["sent_sakarias_car_fordmustangtr"] = {valid=true, alarm=true},
	["sent_sakarias_car_ilcar"] = {valid=true, alarm=true},
	["sent_sakarias_car_jimmygibbsjr"] = {valid=true, alarm=true},
	["sent_sakarias_car_lambodiablo"] = {valid=true, alarm=true},
	["sent_sakarias_car_lambodicop"] = {valid=true, alarm=true},
	["sent_sakarias_car_lambomurci"] = {valid=true, alarm=true},
	["sent_sakarias_car_lambomurcicop"] = {valid=true, alarm=true},
	["sent_sakarias_car_nissanskyline"] = {valid=true, alarm=true},
	["sent_sakarias_car_paganizonda"] = {valid=true, alarm=true},
	["sent_sakarias_car_porsche911"] = {valid=true, alarm=true},
	["sent_sakarias_car_porsche911cop"] = {valid=true, alarm=true},
	["sent_sakarias_car_suprarz"] = {valid=true, alarm=true},
	["sent_sakarias_car_toyotagtone"] = {valid=true, alarm=true},
	["sent_sakarias_car_vipercc"] = {valid=true, alarm=true},
	["sent_sakarias_car_vipersrt10"] = {valid=true, alarm=true},
	["sent_sakarias_car_yamahayfz450"] = {valid=true, alarm=true},
	["sent_sakarias_car_junker3"] = {valid=true, alarm=true},
	["sent_sakarias_car_junker2"] = {valid=true, alarm=true},
	["sent_sakarias_car_junker1"] = {valid=true, alarm=true},]]

	-- Star Wars Vehicles: Episode 1 & 2 (https://steamcommunity.com/sharedfiles/filedetails/?id=495762961, https://steamcommunity.com/sharedfiles/filedetails/?id=608632308)
	--[[["att"] = {valid=true, alarm=false},
	["sith_speeder"] = {valid=true, alarm=false},
	["droid_tri"] = {valid=true, alarm=false},
	["geonosis"] = {valid=true, alarm=false},
	["mtt"] = {valid=true, alarm=false},
	["munificent"] = {valid=true, alarm=false},
	["vulture"] = {valid=true, alarm=false},
	["stap"] = {valid=true, alarm=false},
	["soulless"] = {valid=true, alarm=false},
	["imp_speeder"] = {valid=true, alarm=false},
	["lambda"] = {valid=true, alarm=false},
	["sentinel"] = {valid=true, alarm=false},
	["slave"] = {valid=true, alarm=false},
	["speeder_bike"] = {valid=true, alarm=false},
	["star_destroyer"] = {valid=true, alarm=false},
	["tie_advanced"] = {valid=true, alarm=false},
	["tie_bomber"] = {valid=true, alarm=false},
	["tie_fighter"] = {valid=true, alarm=false},
	["tie_interceptor"] = {valid=true, alarm=false},
	["podracer"] = {valid=true, alarm=false},
	["storm"] = {valid=true, alarm=false},
	["landspeeder"] = {valid=true, alarm=false},
	["xj6"] = {valid=true, alarm=false},
	["a-wing"] = {valid=true, alarm=false},
	["b-wing"] = {valid=true, alarm=false},
	["blockade"] = {valid=true, alarm=false},
	["millenium_falcon"] = {valid=true, alarm=false},
	["calamari"] = {valid=true, alarm=false},
	["snowspeeder"] = {valid=true, alarm=false},
	["x-wing"] = {valid=true, alarm=false},
	["y-wing"] = {valid=true, alarm=false},
	["acclamator"] = {valid=true, alarm=false},
	["arc170"] = {valid=true, alarm=false},
	["delta"] = {valid=true, alarm=false},
	["republic_speeder"] = {valid=true, alarm=false},
	["consular"] = {valid=true, alarm=false},
	["delta7"] = {valid=true, alarm=false},
	["eta2"] = {valid=true, alarm=false},
	["laat"] = {valid=true, alarm=false},
	["n-1"] = {valid=true, alarm=false},
	["republic_cruiser"] = {valid=true, alarm=false},
	["tx130"] = {valid=true, alarm=false},
	["v19torrent"] = {valid=true, alarm=false},
	["v-wing"] = {valid=true, alarm=false},
	["headhunter"] = {valid=true, alarm=false},

	-- [LFS] - Planes (https://steamcommunity.com/sharedfiles/filedetails/?id=1571918906)
	["lunasflightschool_arc170"] = {valid=true, alarm=false},
	["lunasflightschool_bf109"] = {valid=true, alarm=false},
	["lunasflightschool_cessna"] = {valid=true, alarm=false},
	["lunasflightschool_combineheli"] = {valid=true, alarm=false},
	["lunasflightschool_tridroid"] = {valid=true, alarm=false},
	["lunasflightschool_n1starfighter"] = {valid=true, alarm=false},
	["lunasflightschool_p47d"] = {valid=true, alarm=false},
	["lunasflightschool_rebelheli"] = {valid=true, alarm=false},
	["lunasflightschool_spitfire"] = {valid=true, alarm=false},
	["lunasflightschool_vulturedroid"] = {valid=true, alarm=false},]]

	-- WAC Aircraft (https://steamcommunity.com/sharedfiles/filedetails/?id=104990330)
	--[[["wac_aircraft_maintenance"] = {valid=false, alarm=false},
	["wac_hitdetector"] = {valid=false, alarm=false},
	["wac_pod_aimedgun"] = {valid=false, alarm=false},
	["wac_pod_base"] = {valid=false, alarm=false},
	["wac_pod_gatling"] = {valid=false, alarm=false},
	["wac_pod_hellfire"] = {valid=false, alarm=false},
	["wac_pod_hydra"] = {valid=false, alarm=false},
	["wac_rotor"] = {valid=false, alarm=false},
	["wac_seat_connector"] = {valid=false, alarm=false},
	["wac_hc_ah1z_viper"] = {valid=true, alarm=false},
	["wac_hc_base"] = {valid=true, alarm=false},
	["wac_hc_blackhawk_uh60"] = {valid=true, alarm=false},
	["wac_hc_hebullet"] = {valid=true, alarm=false},
	["wac_hc_littlebird_ah6"] = {valid=true, alarm=false},
	["wac_hc_littlebird_mh6"] = {valid=true, alarm=false},
	["wac_hc_mi28_havoc"] = {valid=true, alarm=false},
	["wac_hc_rocket"] = {valid=true, alarm=false},
	["wac_pl_base"] = {valid=true, alarm=false},
	["wac_pl_c172"] = {valid=true, alarm=false},
	
	-- WAC Community 1 (https://steamcommunity.com/sharedfiles/filedetails/?id=108907015)
	["wac_hc_206b"] = {valid=true, alarm=false},
	["wac_hc_206b_amphib"] = {valid=true, alarm=false},
	["wac_hc_ah64d_longbow"] = {valid=true, alarm=false},
	["wac_hc_ch46_seaknight"] = {valid=true, alarm=false},
	["wac_hc_ch47_chinook"] = {valid=true, alarm=false},
	["wac_pl_jenny"] = {valid=true, alarm=false},
	["wac_pl_ultralight"] = {valid=true, alarm=false},

	-- WAC Communtiy 2 (https://steamcommunity.com/sharedfiles/filedetails/?id=108909229)
	["wac_hc_ec655"] = {valid=true, alarm=false},
	["wac_hc_littlebird_h500"] = {valid=true, alarm=false},
	["wac_hc_mh53_pavelow"] = {valid=true, alarm=false},
	["wac_hc_mi35"] = {valid=true, alarm=false},
	["wac_hc_r22"] = {valid=true, alarm=false},
	["wac_hc_uh1y_venom"] = {valid=true, alarm=false},

	-- WAC Community 3 (https://steamcommunity.com/sharedfiles/filedetails/?id=109977794)
	["wac_hc_ka50"] = {valid=true, alarm=false},
	["wac_hc_mv22"] = {valid=true, alarm=false},
	["wac_hc_oh58_kiowa"] = {valid=true, alarm=false},
	["wac_hc_rah66"] = {valid=true, alarm=false},
	["wac_hc_uh1d"] = {valid=true, alarm=false},
	["wac_pl_bd5j"] = {valid=true, alarm=false},

	-- WAC Community 4 (https://steamcommunity.com/sharedfiles/filedetails/?id=128559085)
	["wac_hc_raven_oh23"] = {valid=true, alarm=false},
	["wac_hc_s64"] = {valid=true, alarm=false},
	["wac_pl_c130"] = {valid=true, alarm=false},
	["wac_pl_ju87"] = {valid=true, alarm=false},
	["wac_pl_p39"] = {valid=true, alarm=false},
	["wac_pl_p40"] = {valid=true, alarm=false},

	-- WAC Community 5 (https://steamcommunity.com/sharedfiles/filedetails/?id=139224513)
	["wac_pod_bomb"] = {valid=false, alarm=false},
	["wac_pl_a10"] = {valid=true, alarm=false},
	["wac_pl_a6m2"] = {valid=true, alarm=false},
	["wac_pl_bf109"] = {valid=true, alarm=false},
	["wac_pl_p51"] = {valid=true, alarm=false},
	["wac_pl_spitfire"] = {valid=true, alarm=false},
	["wac_pl_t45"] = {valid=true, alarm=false},
	
	-- WAC Community 6 (https://steamcommunity.com/sharedfiles/filedetails/?id=141486806)
	["wac_pod_cannon"] = {valid=false, alarm=false},
	["wac_hc_ah1w"] = {valid=true, alarm=false},
	["wac_hc_mi17"] = {valid=true, alarm=false},
	["wac_pl_f16"] = {valid=true, alarm=false},
	["wac_pl_f4"] = {valid=true, alarm=false},
	["wac_pl_fa18"] = {valid=true, alarm=false},
	["wac_pl_fw190"] = {valid=true, alarm=false},

	-- WAC Community 7 (https://steamcommunity.com/sharedfiles/filedetails/?id=162016658)
	["wac_pl_dh98"] = {valid=true, alarm=false},
	["wac_pl_f86"] = {valid=true, alarm=false},]]

	-- [LFS] Jedi Starfighters (https://steamcommunity.com/sharedfiles/filedetails/?id=1580175017)
	--[[["lunasflightschool_delta7_adi"]={valid=true,alarm=false},
	["lunasflightschool_delta7_ahsoka"]={valid=true,alarm=false},
	["lunasflightschool_delta7_anakin"]={valid=true,alarm=false},
	["lunasflightschool_eta2_anakin"]={valid=true,alarm=false},
	["lunasflightschool_delta7_barriss"]={valid=true,alarm=false},
	["lunasflightschool_delta7_kit"]={valid=true,alarm=false},
	["lunasflightschool_delta7_luminara"]={valid=true,alarm=false},
	["lunasflightschool_delta7_mace"]={valid=true,alarm=false},
	["lunasflightschool_delta7_obiwan"]={valid=true,alarm=false},
	["lunasflightschool_eta2_obiwan"]={valid=true,alarm=false},
	["lunasflightschool_delta7_plo"]={valid=true,alarm=false},
	["lunasflightschool_delta7_saesee"]={valid=true,alarm=false},

	-- SW Vehicles : TIE Fighters [LFS] (https://steamcommunity.com/sharedfiles/filedetails/?id=1580978413)
	["kingpommes_tie_advanced"]={valid=true,alarm=false},
	["kingpommes_tie_defender"]={valid=true,alarm=false},
	["kingpommes_tie_fighter"]={valid=true,alarm=false},
	["kingpommes_tie_interceptor"]={valid=true,alarm=false},
	["kingpommes_tie_interceptorr"]={valid=true,alarm=false},]]
}