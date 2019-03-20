--[[--ldoc desc
@module BoyaaView
@author ShuaiYang

Date   2018-10-18 12:09:59
Last Modified by   ShuaiYang
Last Modified time 2018-10-18 12:15:16
]]

local BoyaaView = class("BoyaaView", cc.Node);

function BoyaaView:ctor(ctr, name)
    self:enableNodeEvents()
    self.ctr = ctr

    -- check CSB resource file
    local res = rawget(self.class, "RESOURCE_FILENAME")
    if res then
        self:createResourceNode(res)
    end

    local binding = rawget(self.class, "RESOURCE_BINDING")
    if res and binding then
        self:createResourceBinding(binding)
    end

    if self.onCreate then self:onCreate() end

    if self.updata then
        self.updataFunId = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function ()
            self:updata();
            -- body
        end,0,false);
    end
end


return BoyaaView;