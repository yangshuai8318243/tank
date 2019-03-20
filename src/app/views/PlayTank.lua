--[[--ldoc desc
@module PlayTank
@author ShuaiYang

Date   2018-10-18 10:16:11
Last Modified by   ShuaiYang
Last Modified time 2018-10-18 10:39:44
]]

local socket = require("socket");
local PlayTank  = class("PlayTank");


function PlayTank:ctor(tack)
	self.tack = tack;
	self.dirTable = {};
end


function PlayTank:upDataTankPosition(callback)
	-- body
	local delta = cc.Director:getInstance():getDeltaTime();

	local nextPosX = self.tack:getPositionX() + self.dx*delta;
	local nextPosY = self.tack:getPositionY() + self.dy*delta;
	

	if callback then
		callback(nextPosX,nextPosY);
		return;
	end

	if self.tack.dx ~= 0 then
		self.tack:setPositionX(nextPosX);
	end

	if self.tack.dy ~= 0 then
		self.tack:setPositionY(nextPosY);
	end

end


function PlayTank:moveBegin(data)
	-- body
	self.dirTable[data] = socket:getTime();

end

return PlayTank;

