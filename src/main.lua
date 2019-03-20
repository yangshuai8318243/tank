
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

local function main()
    -- require("app.MyApp"):create():run()
    local scene = cc.Scene:createWithPhysics()
    local MainScene = require("app.views.MainScene").new()
    scene:addChild(MainScene)
    
    display.runScene(scene)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
