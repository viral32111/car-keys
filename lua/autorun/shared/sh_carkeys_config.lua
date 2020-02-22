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

carKeysVehicles = {
	-- Half-Life 2 (Any car based off this, TDMCars, LoneWolfie Cars, etc.)
	["prop_vehicle_jeep"] = {valid=true, alarm=true},
	["prop_vehicle_jeep_old"] = {valid=true, alarm=true},
	["prop_vehicle_airboat"] = {valid=true, alarm=true},
	["prop_vehicle_prisoner_pod"] = {valid=true, alarm=true},

	-- [simfphys] LUA Vehicles - Base (https://steamcommunity.com/sharedfiles/filedetails/?id=771487490)
	["gmod_sent_vehicle_fphysics_base"] = {valid=true, alarm=true},
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
	["sent_sakarias_car_junker1"] = {valid=true, alarm=true},

	-- Star Wars Vehicles: Episode 1 & 2 (https://steamcommunity.com/sharedfiles/filedetails/?id=495762961, https://steamcommunity.com/sharedfiles/filedetails/?id=608632308)
	["att"] = {valid=true, alarm=false},
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
	["lunasflightschool_vulturedroid"] = {valid=true, alarm=false},

	-- WAC Aircraft (https://steamcommunity.com/sharedfiles/filedetails/?id=104990330)
	["wac_aircraft_maintenance"] = {valid=false, alarm=false},
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
	["wac_pl_f86"] = {valid=true, alarm=false},

	--[[
	https://steamcommunity.com/sharedfiles/filedetails/?id=947544869
	https://steamcommunity.com/sharedfiles/filedetails/?id=1580978413
	https://steamcommunity.com/sharedfiles/filedetails/?id=1258744627
	https://steamcommunity.com/sharedfiles/filedetails/?id=1580666744
	https://steamcommunity.com/sharedfiles/filedetails/?id=1716586634
	https://steamcommunity.com/sharedfiles/filedetails/?id=1580173688
	https://steamcommunity.com/sharedfiles/filedetails/?id=1739279660
	https://steamcommunity.com/sharedfiles/filedetails/?id=1797733425
	https://steamcommunity.com/sharedfiles/filedetails/?id=1923261937
	https://steamcommunity.com/sharedfiles/filedetails/?id=1580175325
	https://steamcommunity.com/sharedfiles/filedetails/?id=1721058603
	https://steamcommunity.com/sharedfiles/filedetails/?id=1599748363
	https://steamcommunity.com/sharedfiles/filedetails/?id=1964419680
	https://steamcommunity.com/sharedfiles/filedetails/?id=1580173141
	https://steamcommunity.com/sharedfiles/filedetails/?id=1731090054
	https://steamcommunity.com/sharedfiles/filedetails/?id=817850162
	https://steamcommunity.com/sharedfiles/filedetails/?id=1894613649
	https://steamcommunity.com/sharedfiles/filedetails/?id=1746991793
	https://steamcommunity.com/sharedfiles/filedetails/?id=1747763643
	https://steamcommunity.com/sharedfiles/filedetails/?id=1699081112
	https://steamcommunity.com/sharedfiles/filedetails/?id=1755725700
	https://steamcommunity.com/sharedfiles/filedetails/?id=1696173191
	https://steamcommunity.com/sharedfiles/filedetails/?id=1693558389
	https://steamcommunity.com/sharedfiles/filedetails/?id=1655057679
	https://steamcommunity.com/sharedfiles/filedetails/?id=1580175017
	https://steamcommunity.com/sharedfiles/filedetails/?id=1573034515
	https://steamcommunity.com/sharedfiles/filedetails/?id=1512369734
	https://steamcommunity.com/sharedfiles/filedetails/?id=1322584182
	https://steamcommunity.com/sharedfiles/filedetails/?id=2003539477
	https://steamcommunity.com/sharedfiles/filedetails/?id=1527897309
	https://steamcommunity.com/sharedfiles/filedetails/?id=1910572465
	https://steamcommunity.com/sharedfiles/filedetails/?id=1579376621
	https://steamcommunity.com/sharedfiles/filedetails/?id=1495015851
	https://steamcommunity.com/sharedfiles/filedetails/?id=1406438579
	https://steamcommunity.com/sharedfiles/filedetails/?id=1626356763
	--]]
	["lunasflightschool_tieinterceptor"]={valid=true,alarm=false},
	["lunasflightschool_falcon"]={valid=true,alarm=false},
	["lfs_scifi_shuttle"]={valid=true,alarm=false},
	["tiesilencer_lfs"]={valid=true,alarm=false},
	["lunasflightschool_awing"]={valid=true,alarm=false},
	["lunasflightschool_eta2"]={valid=true,alarm=false},
	["kingpommes_lfs_tie_advanced"]={valid=true,alarm=false},
	["kingpommes_lfs_tie_defender"]={valid=true,alarm=false},
	["kingpommes_lfs_tie_fighter"]={valid=true,alarm=false},
	["kingpommes_lfs_tie_interceptor"]={valid=true,alarm=false},
	["kingpommes_lfs_tie_interceptorr"]={valid=true,alarm=false},
	["lfs_vanilla_vwing"]={valid=true,alarm=false},
	["lfs_vanilla_azureangel"]={valid=true,alarm=false},
	["lfs_vanilla_nushuttle"]={valid=true,alarm=false},
	["lfs_vanilla_tiebomber"]={valid=true,alarm=false},
	["lfs_vanilla_uwing"]={valid=true,alarm=false},
	["lfs_vanilla_v19"]={valid=true,alarm=false},
	["lunasflightschool_bf2hyenabomber"]={valid=true,alarm=false},
	["lunasflightschool_cgihyenabomber"]={valid=true,alarm=false},
	["lfs_awing"]={valid=true,alarm=false},
	["lunasflightschool_delta7_adi"]={valid=true,alarm=false},
	["lfs_advdroid"]={valid=true,alarm=false},
	["lunasflightschool_delta7_ahsoka"]={valid=true,alarm=false},
	["lfs_alligator"]={valid=true,alarm=false},
	[""]={valid=true,alarm=false},
	["lunasflightschool_alpha3vwing"]={valid=true,alarm=false},
	["lfs_alphag"]={valid=true,alarm=false},
	["lunasflightschool_delta7_anakin"]={valid=true,alarm=false},
	["lunasflightschool_eta2_anakin"]={valid=true,alarm=false},
	["lfs_antiairturret"]={valid=true,alarm=false},
	["lfs_antiinfantryturret"]={valid=true,alarm=false},
	["lfs_antivehicleturret"]={valid=true,alarm=false},
	["lunasflightschool_laatgunshiparcblue"]={valid=true,alarm=false},
	["lunasflightschool_laatgunshiparcgreen"]={valid=true,alarm=false},
	["lunasflightschool_laatgunshiparcred"]={valid=true,alarm=false},
	["lunasflightschool_arc170_alternate"]={valid=true,alarm=false},
	["lunasflightschool_delta7_barriss"]={valid=true,alarm=false},
	["lfs_soulless"]={valid=true,alarm=false},
	["lunasflightschool_cgi_laat"]={valid=true,alarm=false},
	["lunasflightschool_cgi_laat_coruscant"]={valid=true,alarm=false},
	["lfs_repcorvette1"]={valid=true,alarm=false},
	["lfs_cr90"]={valid=true,alarm=false},
	["lfs_spiral"]={valid=true,alarm=false},
	["lfs_ebonhawk"]={valid=true,alarm=false},
	["lfs_eta5"]={valid=true,alarm=false},
	["lunasflightschool_geofighter"]={valid=true,alarm=false},
	["lfs_havoc"]={valid=true,alarm=false},
	["lfs_ig2000"]={valid=true,alarm=false},
	["lunasflightschool_imp_dropship"]={valid=true,alarm=false},
	["lfs_kimogila"]={valid=true,alarm=false},
	["lunasflightschool_delta7_kit"]={valid=true,alarm=false},
	["lunasflightschool_laatgunshipblue"]={valid=true,alarm=false},
	["lunasflightschool_laatgunshipgreen"]={valid=true,alarm=false},
	["lunasflightschool_laatgunshipred"]={valid=true,alarm=false},
	["lunasflightschool_lambda"]={valid=true,alarm=false},
	["lfs_repcorvette2"]={valid=true,alarm=false},
	["lfs_repcorvette3"]={valid=true,alarm=false},
	["lunasflightschool_delta7_luminara"]={valid=true,alarm=false},
	["lfs_scyk"]={valid=true,alarm=false},
	["lunasflightschool_delta7_mace"]={valid=true,alarm=false},
	["lfs_gauntlet"]={valid=true,alarm=false},
	["lfs_geo"]={valid=true,alarm=false},
	["lfs_nbt630"]={valid=true,alarm=false},
	["lunasflightschool_delta7_obiwan"]={valid=true,alarm=false},
	["lunasflightschool_eta2_obiwan"]={valid=true,alarm=false},
	["lunasflightschool_delta7_plo"]={valid=true,alarm=false},
	["lfs_portableturret"]={valid=true,alarm=false},
	["lfs_r41"]={valid=true,alarm=false},
	["lfs_repz95"]={valid=true,alarm=false},
	["lunasflightschool_delta7_saesee"]={valid=true,alarm=false},
	["lfs_skipray"]={valid=true,alarm=false},
	["lunasflightschool_boba"]={valid=true,alarm=false},
	["lunasflightschool_jango"]={valid=true,alarm=false},
	["lfs_t42"]={valid=true,alarm=false},
	["lfs_tie_avenger"]={valid=true,alarm=false},
	["lfs_tie_droid"]={valid=true,alarm=false},
	["lfs_tie_interdictor"]={valid=true,alarm=false},
	["lfs_tie_oppressor"]={valid=true,alarm=false},
	["lfs_tie_raptor"]={valid=true,alarm=false},
	["lfs_tie_scout"]={valid=true,alarm=false},
	["lunasflightschool_v19torrent"]={valid=true,alarm=false},
	["lfs_vwing"]={valid=true,alarm=false},
	["lfs_wwing"]={valid=true,alarm=false},
	["lfs_z95"]={valid=true,alarm=false},
}