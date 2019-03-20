
local MainScene = class("MainScene", cc.load("mvc").ViewBase)
local Tank = require("app.views.Tank")
local Map = require("app.views.Map")
local testA = cc.load("mvc").test.testA;

require("app.views.CommonUitls")

local socket = require"socket"


g_TableLib = require("app.views.tableLib");

function MainScene:onCreate()
    -- add background image
    local spfc = cc.SpriteFrameCache:getInstance();
    cc.SpriteFrameCache:getInstance():addSpriteFrames("test.plist")
    self.map = Map.new();
    self.map:addTo(self)
    self.tank = Tank.new();
    self.tank:addTo(self);

    local finalX,finalY = Grid2Pos(5,5);
    self.tank:setPosition(cc.p(finalX,finalY))
    -- display.newSprite("tank_green_run0.png")
    --     :move(display.center)
    --     :addTo(self)

    -- add HelloWorld label
    testA:test()
    -- cc.Label:createWithSystemFont("Hello World", "Arial", 40)
    --     :move(display.cx, display.cy + 200)
    --     :addTo(self)
    self:setInput();

    -- local ok, socket1 = pcall(function()
    --     return require("socket")
    -- end)上一页下一页

    -- local sp = cc.Sprite:createWithSpriteFrameName("tank_blue_run0.png"):addTo(self);
    -- sp:setPosition(cc.p(10,10))
    -- print("yangshuai socket"..socket.gettime())
end


function MainScene:setInput()
	-- body

    local tankCallBack = function( x,y )
      local xxx = self.map:Collide(x,y,0)
      local y1 = false

      if xxx then
        y1 = true
      end

      return y1;
    end


	  local function onEnter()
        local shidList = {};
        local scheduler = cc.Director:getInstance():getScheduler()
        --键盘弹起
        local function onKeyReleased(keyCode, event)
            --键盘事件监听
          -- print("onKeyReleased in keyCode ：",keyCode)
       		-- print("onKeyReleased in event ：",tostring(event))
          local removeShidIndex = -1;
          for i,v in ipairs(shidList) do
              if v.keyCode == keyCode then
                scheduler:unscheduleScriptEntry(v.scheduler)
                removeShidIndex = i;
              end
          end

          if removeShidIndex>0 then
            table.remove(shidList,removeShidIndex)
          end

          self.tank:actionTank();

        end
        --键盘摁下
        local function onKeyPressed(keyCode, event)
            --键盘事件监听
          -- print("onKeyPressed in keyCode ：",keyCode)
          -- print("onKeyPressed in event ：",tostring(event))
          -- self.tank:actionTank();
          local keyCodeData = keyCode;
          local shid = scheduler:scheduleScriptFunc(function ()
            -- body
            if keyCodeData == 29 then
             self.tank:actionTank(DOWN,tankCallBack)
            elseif keyCodeData == 27 then
              self.tank:actionTank(RIGHT,tankCallBack)
            elseif keyCodeData == 28 then
              self.tank:actionTank(UP,tankCallBack)
            elseif keyCodeData == 26 then
              self.tank:actionTank(LEFT,tankCallBack)
            end

          end, 0.1, false)
          local shidData = {
            keyCode = keyCode,
            scheduler = shid
          }

          table.insert(shidList,shidData)

        end



        local listener = cc.EventListenerKeyboard:create()
        listener:registerScriptHandler(onKeyPressed, cc.Handler.EVENT_KEYBOARD_PRESSED )

        listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED )

        local eventDispatcher = self:getEventDispatcher()
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    end

    local function onNodeEvent(event)
        if event == "enter" then
            onEnter()
        end
    end

    self:registerScriptHandler(onNodeEvent)
    self:addEventListenerPhysicsContact()
end


function MainScene:addEventListenerPhysicsContact()
  -- body
  local conListener=cc.EventListenerPhysicsContact:create()
    conListener:registerScriptHandler(function(contact)  
        print("--------------addEventListenerPhysicsContact-----------------")

        local node1=contact:getShapeA():getBody():getNode()  
        local node2=contact:getShapeB():getBody():getNode()
        if not node1 or not node2 then return end 
        
        if node1:getName() ~= node2:getName() then
            local tank = nil
            local lattice = nil


            if node1:getName() == "Tank" then
                tank = node1:getParent()
                lattice = node2:getParent()
            else
                tank = node2:getParent()
                lattice = node1:getParent()
            end
            local x = lattice.attributes.x
            local y = lattice.attributes.y 
            local id = lattice.attributes.id
            print(string.format("x = %d  y = %d  id = %d ",x,y,id))

            -- if not vB._isAlive then
            --     return
            -- end
            -- if vB._isLockFishID ~= 0 and fish._id~=vB._isLockFishID then
            --     return
            -- end
            -- --播放鱼被击中的效果
            -- self:showHitFish(fish)
            -- --播放撒网动作
            -- local vBPos = cc.p(vB._sp:getPositionX(),vB._sp:getPositionY())
            -- self:FallingNet(vBPos, vB)
            -- local info = 
            -- {
            --     chairId = self._deskNum,
            --     fishId = fish._id,
            --     bulletKind = vB._buttleMultiplePicNum,
            --     bulletId = vB._id,
            --     bulletMulriple = vB._buttleMultiple,
            --     eventType = LKPY_NOTIFY_AssistantID.SUB_C_CATCH_FISH,
            -- }
            -- self._callback(info)
            -- for k,v in pairs(self._bulletList) do
            --     if v._id == vB._id or v._isKnockBall == 0 then
            --         table.remove(self._bulletList,k)
            --         v:disappear()
            --         break
            --     end
            -- end 
        end
        return true  
    end,cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)  
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(conListener,self)

end



return MainScene
