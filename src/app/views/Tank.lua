--[[--ldoc desc
@module Tank
@author ShuaiYang

Date   2018-10-17 16:12:17
Last Modified by   ShuaiYang
Last Modified time 2019-03-19 19:01:07
]]

local Tank = class("Tank",cc.load("mvc").ViewBase);
local SpriteAnim = require("app.views.SpriteAnim")



function Tank:onCreate()
   
    self.sp =  cc.Sprite:createWithSpriteFrameName("tank_green_run0.png"):addTo(self);

    self.spAnim =  SpriteAnim.new(self.sp);
    self.spAnim:Define("green","tank","run",8,0.1,false);
    self.spAnim:setFrame("green",0);
    self.dx = 0;
    self.dy = 0;
    self.speed = cGridSize;
    self.sp:setName("Tank")
 --    local box = cc.PhysicsBody:createCircle(self.sp:getContentSize().width*BoxSize)
 --    --是否设置物体为静态 
	-- box:setDynamic(true)
	-- --定义当前刚体的掩码值为bitmask
	-- box:setCategoryBitmask(1)  
	-- --在和掩码值为bitmask的刚体碰撞时通知我
	-- box:setContactTestBitmask(1)  
	-- --允许和掩码值为bitmask发生碰撞
	-- box:setCollisionBitmask(2)
	-- --设置物体是否受重力系数影响  
	-- box:setGravityEnable(false)
	-- self.sp:setPhysicsBody(box)

end

function Tank:actionTank(action,callbck)
	-- body
	
	if action == UP then
		self.dx = 0;
    	self.dy = self.speed;
		self:setRotation(0);
		self.spAnim:play("green");
	elseif action == DOWN then
		self.dx = 0;
    	self.dy = -self.speed;
	 	self:setRotation(180);
		self.spAnim:play("green");
	elseif action == LEFT then
		self.dx = -self.speed;
    	self.dy = 0;
	 	self:setRotation(-90);
		self.spAnim:play("green");
	elseif action == RIGHT then
		self.dx = self.speed;
    	self.dy = 0;
	 	self:setRotation(90);
		self.spAnim:play("green");
	else
		self.dx = 0;
    	self.dy = 0;
		self.spAnim:stop("green");
	end
	self:upDataPosition(callbck)
end




function Tank:upDataPosition(callbck)
	-- body

	local nextPosX = self:getPositionX() + self.dx
	local nextPosY = self:getPositionY() + self.dy

	
	if callbck and callbck(nextPosX,nextPosY) then

		self:setPositionX(nextPosX)
		self:setPositionY(nextPosY)

	end
	
end


function Tank:destory()
	-- body
	self.spAnim:destory();

end

return Tank;