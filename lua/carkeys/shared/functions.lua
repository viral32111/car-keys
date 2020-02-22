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

function carKeys.IsVehicleSupported(class)
	for baseClass,options in pairs(carKeys.config.supportedBaseClasses)do if(scripted_ents.IsBasedOn(class,baseClass))then return true,options.alarm end end
	if(istable(carKeys.supportedIndividualClasses[class]))then return true,carKeys.supportedIndividualClasses[class].alarm end
	return false
end