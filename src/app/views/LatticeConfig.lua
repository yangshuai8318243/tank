--[[--ldoc desc
@module LatticeConfig
@author ShuaiYang

Date   2019-01-25 14:50:29
Last Modified by   ShuaiYang
Last Modified time 2019-01-25 17:20:22
]]

local LatticeConfig = {}

--泥土
LatticeConfig.mud  = {
	["name"] = "mud",
	["hp"] = 0,
	["maxhp"] = 0,
	["needAp"] = false, --是否需要穿甲
	["damping"] = 0.2 ,-- 阻尼
	["breakable"] = false,--是否破坏
}


--砖块
LatticeConfig.brick  = {
	["name"] = "brick",
	["hp"] = 3,
	["maxhp"] = 3,
	["needAp"] = false, --是否需要穿甲
	["damping"] = 1 ,-- 阻尼
	["breakable"] = true,--是否破坏
}

--钢铁
LatticeConfig.steel  = {
	["name"] = "steel",
	["hp"] = 3,
	["maxhp"] = 3,
	["needAp"] = true, --是否需要穿甲
	["damping"] = 1 ,-- 阻尼
	["breakable"] = true,--是否破坏
}

--公路
LatticeConfig.road  = {
	["name"] = "road",
	["hp"] = 3,
	["maxhp"] = 3,
	["needAp"] = false, --是否需要穿甲
	["damping"] = 0.1 ,-- 阻尼
	["breakable"] = false,--是否破坏
}

--水
LatticeConfig.water  = {
	["name"] = "water",
	["hp"] = 0,
	["maxhp"] = 0,
	["needAp"] = false, --是否需要穿甲
	["damping"] = 1 ,-- 阻尼
	["breakable"] = false,--是否破坏
}



return LatticeConfig;