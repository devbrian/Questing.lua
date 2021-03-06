-- Copyright © 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local sys    = require "Libs/syslib"
local game   = require "Libs/gamelib"
local Quest  = require "Quests/Quest"
local Dialog = require "Quests/Dialog"

local name		  = 'Rock Tunnel'
local description = '(Route 9 to Lavander Town)'
local level = 33

local RockTunnelQuest = Quest:new()

function RockTunnelQuest:new()
	return Quest.new(RockTunnelQuest, name, description, level)
end

function RockTunnelQuest:isDoable()
	if self:hasMap() and not hasItem("Rainbow Badge") then
		return true
	end
	return false
end

function RockTunnelQuest:isDone()
	if getMapName() == "Celadon City" or getMapName() == "Pokecenter Vermilion" then --FIX Blackout if not Route10 or Lavander Pokecenter is Setup
		return true
	else
		return false
	end
end

function RockTunnelQuest:Route9()
	return moveToCell(86,33)
end

function RockTunnelQuest:Route10()
	if game.inRectangle(9,0,24,11) then
		if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Route 10" then
			return moveToMap("Pokecenter Route 10")
		else
			return moveToMap("Rock Tunnel 1")
		end
	else
		return moveToMap("Lavender Town")
	end
end

function RockTunnelQuest:PokecenterRoute10()
	self:pokecenter("Route 10")
end

function RockTunnelQuest:RockTunnel1()
	if game.inRectangle(33,8,45,18) then
		return moveToCell(35,16)
	elseif game.inRectangle(6,6,29,17) then
		return moveToCell(8,15)
	else
		return moveToCell(21,32) -- Route 10 - 2nd Part
	end
end

function RockTunnelQuest:RockTunnel2()
	if game.inRectangle(35,5,45,25) or game.inRectangle(6,5,34,11) then
		if isNpcOnCell(42,26) then
			talkToNpcOnCell(42,26) --Item: Escape Rope
		else
			moveToCell(7,5)
		end
	elseif game.inRectangle(6,12,27,28) then
		return moveToCell(8,26)
	else
	end
end

function RockTunnelQuest:LavenderTown()
	if self:needPokecenter() or not game.isTeamFullyHealed() or self.registeredPokecenter ~= "Pokecenter Lavender" then
		return moveToMap("Pokecenter Lavender")
	else
		return moveToMap("Route 8")
	end
end

function RockTunnelQuest:PokecenterLavender()
	self:pokecenter("Lavender Town")
end

function RockTunnelQuest:Route8()
	if isNpcOnCell(56,3) then -- Item: Leppa Berry
		return talkToNpcOnCell(56,3)
	elseif isNpcOnCell(57,3) then -- Item: Leppa Berry
		return talkToNpcOnCell(57,3)
	elseif isNpcOnCell(52,9) then --Pokemon: Growlithe LvL 10 (BlueBall)
		return talkToNpcOnCell(52,9)
	elseif isNpcOnCell(17,3) then  -- Item: Rawst Berry
		return talkToNpcOnCell(17,3)
	elseif isNpcOnCell(18,3) then  -- Item: Lum Berry
		return talkToNpcOnCell(18,3)
	elseif isNpcOnCell(18,3) then  -- Item: Perism Berry
		return talkToNpcOnCell(18,3)
	else
		return moveToMap("Underground House 4")
	end
end

function RockTunnelQuest:UndergroundHouse4()
	return moveToMap("Underground1")
end

function RockTunnelQuest:Underground1()
	return moveToMap("Underground House 3")
end

function RockTunnelQuest:UndergroundHouse3()
	return moveToMap("Route 7")
end

function RockTunnelQuest:Route7()
	if isNpcOnCell(8,30) then -- Item: Sitrus Berry
		return talkToNpcOnCell(8,30)
	else
		return moveToMap("Celadon City")
	end
end

return RockTunnelQuest