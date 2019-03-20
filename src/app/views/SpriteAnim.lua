--[[--ldoc desc
@module SpriteAnim
@author ShuaiYang

Date   2018-10-17 14:30:34
Last Modified by   ShuaiYang
Last Modified time 2019-01-25 17:14:14
]]
local SpriteAnim = class("SpriteAnim");

function SpriteAnim:ctor(sp)
	self.anim = {};
	self.sp = sp;

end

function SpriteAnim:Define(name,spname,typeNmae,frameCount,interval,once)
	-- body
	local def = {
		currFrame = 0,
		running = false,
		frameCount = frameCount,
		spname = spname,
		name = name,
		typeNmae = typeNmae,
		once = once,
		interval = interval,
		advanceFrame = function (defSelf)
			-- body
			defSelf.currFrame = defSelf.currFrame+1;

			if defSelf.currFrame > defSelf.frameCount then
				defSelf.currFrame = 0;
				return false
			end
			return true;
		end,

	}

	if name == nil then
		self.anim[spname] = def;
	else
		self.anim[name] = def;
	end

end

function SpriteAnim:setFrame(name,index)
	-- body
	local def = self.anim[name];

	if def == nil then
		return
	end

	if self.sp == nil then
		return
	end

	local spfc = cc.SpriteFrameCache:getInstance();

	local finalName;

	if def.name then
		finalName = string.format("%s_%s_%s%d.png",def.spname,def.name,def.typeNmae,index);
	else
		finalName = string.format("%s%d.png",def.spname,index);

	end

	local frame = spfc:spriteFrameByName(finalName);

	if frame == nil then
		print("spriteFrameByName nil"..finalName)
		return
	end

	self.sp:setSpriteFrame(frame);
end


function SpriteAnim:play(name,callback)
	-- body
	local def = self.anim[name];

	if def == nil then
		return
	end
	local scheduler = cc.Director:getInstance():getScheduler()
	if def.shid == nil then
		def.shid = scheduler:scheduleScriptFunc(function ()
			-- body
			if def.running then
				if def:advanceFrame() then
					self:setFrame(name,def.currFrame);
				elseif def.once then
					def.running = false;
					scheduler:unscheduleScriptEntry(def.shid)
					def.shid = nil;

					if callback then
						callback();
					end
				end
			end
		end, def.interval, false)
	end

	def.running = true;

end


function SpriteAnim:stop(name)
	-- body
	local def = self.anim[name];

	if def == nil then
		return
	end

	def.running = false;
end

function SpriteAnim:destory()
	-- body
	for name,def in pairs(self.anim) do
		if def.shid then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(def.shid)
		end
	end

	self.sp = nil;
end


return SpriteAnim;