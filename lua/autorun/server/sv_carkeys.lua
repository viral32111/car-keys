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

carKeys={localCommit=117,remoteCommit=nil,config={}}

-- lua_run sql.Query("CREATE TABLE carKeysVehiclePrices (EntityClass VARCHAR PRIMARY KEY, Price INT)")
-- lua_run sql.Query("INSERT OR IGNORE INTO carKeysVehiclePrices (EntityClass,Price) VALUES ('prop_vehicle_jeep',2000); UPDATE carKeysVehiclePrices SET Price=2000 WHERE EntityClass='prop_vehicle_jeep'")
-- lua_run sql.Query("INSERT OR IGNORE INTO carKeysVehiclePrices (EntityClass,Price) VALUES ('prop_vehicle_jeep_old',250); UPDATE carKeysVehiclePrices SET Price=250 WHERE EntityClass='prop_vehicle_jeep_old'")

-- Create an SQL table for saving vehicle information
sql.Query("CREATE TABLE carKeysVehicles (Class VARCHAR NOT NULL PRIMARY KEY,Vehicle VARCHAR NOT NULL UNIQUE,Price INT NOT NULL DEFAULT 0)")

-- Copy old version SQL table to new SQL table for backwards compatibility
if(sql.TableExists("carKeysVehiclePrices"))then
	local vehiclePriceData=sql.Query("SELECT * FROM carKeysVehiclePrices")
	if(!istable(vehiclePriceData))then return end
	sql.Begin()
	for _,data in pairs(vehiclePriceData)do sql.Query("INSERT INTO carKeysVehicles (Class,Vehicle,Price) VALUES ('"..data.EntityClass.."','"..data.EntityClass.."',"..data.Price..")")end
	sql.Commit()
	sql.Query("DROP TABLE carKeysVehiclePrices")
end

-- Add the alarm sound file
sound.Add({name="carKeysAlarmSound",channel=CHAN_STATIC,volume=0.4,level=80,sound="carkeys/alarm.wav"})

-- Add all custom resources to client download queue
resource.AddSingleFile("materials/sentry/key/key.vmt")
resource.AddSingleFile("materials/sentry/key/key.vtf")
resource.AddSingleFile("models/sentry/pgkey.mdl")
resource.AddSingleFile("models/sentry/pgkey.phy")
resource.AddSingleFile("models/sentry/pgkey.vvd")
resource.AddSingleFile("models/sentry/pgkey.sw.vtx")
resource.AddSingleFile("models/sentry/pgkey.dx80.vtx")
resource.AddSingleFile("models/sentry/pgkey.dx90.vtx")
resource.AddSingleFile("sound/carkeys/lock.wav")
resource.AddSingleFile("sound/carkeys/alarm.wav")

-- Check for updates on GitHub
hook.Add("Think","carKeysVersionChecker",function()
	hook.Remove("Think","carKeysVersionChecker")
	http.Fetch("https://api.github.com/repos/viral32111/car-keys/git/refs/heads/master",function(latestCommitBody,_,_,latestCommitStatus)
		if(latestCommitStatus~=200)then error("An error occured while checking for the latest Car Keys commit! (Recieved status code "..latestCommitStatus..")")end
		http.Fetch("https://api.github.com/repos/viral32111/car-keys/compare/9a9d99a163cd3faa54f969d8e18b793ba73669b0..."..util.JSONToTable(latestCommitBody)["object"]["sha"],function(comparisonBody,_,_,comparisonStatus)
			if(comparisonStatus~=200)then error("An error occured while checking the Car Keys commit comparison! (Recieved status code "..latestCommitStatus..")")end
			carKeys.remoteCommit=util.JSONToTable(comparisonBody)["ahead_by"]+1
			if(remoteCommitCount~=carKeys.localCommit)then MsgC(Color(255,0,0),"Car Keys is out of date! Please consider downloading the latest update for the newest features and bug fixes.\n")end
		end,function(errorMessage)
			error("An error occured while checking the Car Keys commit comparison! ("..errorMessage..")")
		end)
	end,function(errorMessage)
		error("An error occured while checking for the latest Car Keys update! ("..errorMessage..")")
	end)
end)