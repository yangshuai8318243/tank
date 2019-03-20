--[[--ldoc desc
@module Map
@author ShuaiYang

Date   2019-03-14 14:32:25
Last Modified by   ShuaiYang
Last Modified time 2019-03-19 18:57:40
]]
local Map = class("Map",cc.load("mvc").ViewBase);
local Lattice = require("app.views.Lattice")
Map.index = 0;



function Map:ctor()
	self.map = {}

	for x=0,MapWidth-1 do
		for y=0, MapHeight-1 do
			if x == 0 or x== MapWidth-1 or y==0 or y== MapHeight-1 then
				self:setLattice(x,y,"steel");
			else
				self:setLattice(x,y,"mud");
			end
		end
	end

	self:setLattice(10,10,"steel");

	-- for k,lattice in pairs(self.map) do
		
 --        if lattice.attributes.name == "steel" then
 --        	print("钢铁方块：",lattice.attributes)
 --        end
	-- end
	
end

function Map:setLattice(x,y,name)
	-- body
	local id = x*MapHeight+y;

	local latticeItem = self.map[id];

	if latticeItem == nil then

		latticeItem = Lattice.new(name);
		local posX,posY = Grid2Pos(x,y);
		latticeItem:setPosition(cc.p(posX,posY))

		latticeItem:setAttributes("x",x)
		latticeItem:setAttributes("y",y)
		latticeItem:setAttributes("id",id)

		latticeItem:addTo(self)	

		self.map[id] = latticeItem;
		

	else
		latticeItem:updataLattice(name)
	end

	
end

function Map:getLattice(x,y)
	-- body
	if x<0 or y<0 then
		return nil
	end

	if x>= MapWidth or y>= MapHeight then
		return nil
	end

	return self.map[x*MapHeight+y];

end


function Map:collideWithBlock(r,x,y)
	-- body
	-- print("====",r.left,r.right,r.top,r.bottom,"-----------------tank,data")
	local lattice = self:getLattice(x,y)

	if lattice == nil then
		return nil
	end

	-- print("方块数据：",lattice.attributes)
	if lattice.attributes.damping >= 1 or lattice.attributes.name == "steel" then
		return nil
	end


	local rect = NewRect(lattice:getPositionX(),lattice:getPositionY())
	if RectIntersect(r,rect) ~= nil then
		return lattice
	end

	return nil;

end


function Map:Collide(posx,posy,ex)	
	-- body
	local rect = NewRect(posx,posy,ex)
	for x=0,MapWidth-1 do
		for y=0, MapHeight-1 do
			local b = self:collideWithBlock(rect,x,y)
			if b then
				return b;
			end
		end
	end


	return nil
end
--子弹碰撞
function Map:Hit(posx,posy)
	-- body
	local x,y = Pos2Grid(posx,posy)

	local lattice = self:getLattice(x,y);

	if lattice == nil then
		return nil;
	end

	if lattice.attributes.breakable then
		return lattice;
	end

	return nil;

end


return Map;