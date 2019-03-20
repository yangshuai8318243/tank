--[[--ldoc desc
@module Bullet
@author ShuaiYang

Date   2019-03-19 18:58:10
Last Modified by   ShuaiYang
Last Modified time 2019-03-19 19:08:47
]]

local Bullet = class("Bullet",cc.load("mvc").ViewBase);
local SpriteAnim = require("app.views.SpriteAnim")

local function getDeltaByDir(dir,speed)

	if action == UP then
		return -speed,0;
	elseif action == DOWN then
		return speed,0;
	elseif action == LEFT then
		return 0,speed;
	elseif action == RIGHT then
		return 0,-speed;
	else
		return 0,0;
	end

end

function Bullet:onCreate(dir,tank)
   
    self.sp =  cc.Sprite:createWithSpriteFrameName("bullet0.png"):addTo(self);

    self.spAnim =  SpriteAnim.new(self.sp);
    -- self.spAnim:Define("green","tank","run",8,0.1,false);
    -- self.spAnim:setFrame("green",0);
    self.dx, self.dy= getDeltaByDir(dir,200);
    self.sp:setPosition(cc.p(tank:getPositionX(),tank:getPositionY()))
    

end


return Bullet;