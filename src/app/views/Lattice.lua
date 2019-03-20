--[[--ldoc desc
@module Lattice
@author ShuaiYang

Date   2019-01-25 14:32:30
Last Modified by   ShuaiYang
Last Modified time 2019-03-15 15:52:18
]]

--mud  brick  steel  road  water
local Lattice = class("Lattice",cc.load("mvc").ViewBase);
local LatticeConfig = require("app.views.LatticeConfig")


function Lattice:ctor(name)
	self:updataLattice(name)
end

function Lattice:updataLattice(name)
	local latticeCon = LatticeConfig[name];
	self.attributes = {}
	for k,v in pairs(latticeCon) do
		self.attributes[k] = v
    end

	if self.sp then
		self:updataImage()
	else
		if self.attributes.breakable then
			self.sp =  cc.Sprite:createWithSpriteFrameName(name.."0.png"):addTo(self);
			-- local box = cc.PhysicsBody:createCircle(self.sp:getContentSize().width*BoxSize)
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
		else
			self.sp =  cc.Sprite:createWithSpriteFrameName(name..".png"):addTo(self);

		end
	end
	self.sp:setName("Lattice")

	


end

function Lattice:getAttributes()
	-- body
	return self.attributes;
end

function Lattice:setAttributes(key,var)
	-- body
	for k,v in pairs(self.attributes) do
		if key == k then
			v = var
			return v;
		end
	end

	self.attributes[key] = var;

	return var;

end


--是否可以破坏
function Lattice:breaks()
	-- body
	if self.attributes.breakable then

		self.attributes.hp = self.attributes.hp -1;
		if self.attributes.hp <= 0 then
			self:updataLattice("mud")
		else
			self:updataImage();
		end
	else
		return;
	end

end



function Lattice:updataImage()
	-- body
	local spfc = cc.SpriteFrameCache:getInstance();
	local finalName = "";
	if self.attributes.breakable then
		local hp = self.attributes.maxhp - self.attributes.hp;
		local name = self.attributes.name;
		finalName = string.format("%s%d.png",name,hp);
		-- local box = cc.PhysicsBody:createCircle(self.sp:getContentSize().width*BoxSize)
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
	else
		finalName = string.format("%d.png",name);
	end 
	
	local frame = spfc:spriteFrameByName(finalName);
	assert(frame,"没有对应类型资源")

	self.sp:setSpriteFrame(frame);
end



function Lattice:destory()
	-- body



end

return Lattice;

