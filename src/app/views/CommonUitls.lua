--[[--ldoc desc
@module CommonUitls
@author ShuaiYang

Date   2019-03-14 16:38:36
Last Modified by   ShuaiYang
Last Modified time 2019-03-19 19:00:39
]]



cGridSize = 32

cHalfGrid = cGridSize/2;

MapWidth = 16

MapHeight = 16

BoxSize = 0.4

UP = "up";
DOWN = "down";
LEFT = "left";
RIGHT = "right";

local PosOffsetX = cGridSize*MapWidth *0.5 - cHalfGrid;
local PosOffsetY = cGridSize*MapHeight *0.5 - cHalfGrid;



--[[
取数字整数部分
]]
function GetIntPart(x)
    if x <= 0 then
        return math.ceil(x);
    end

    if math.ceil(x) == x then
        x = math.ceil(x);
    else
        x = math.ceil(x) - 1;
    end
    return x;
end

function Grid2Pos(x,y)
	-- body
	local visibleSize = cc.Director:getInstance():getVisibleSize();
	local origin = cc.Director:getInstance():getVisibleOrigin();

	local finalX = origin.x + visibleSize.width*0.5 + x*cGridSize-PosOffsetX
	local finalY = origin.y + visibleSize.height*0.5 + y*cGridSize-PosOffsetY

	return finalX,finalY;
end

function Pos2Grid(posx,posy)
	-- body
	local visibleSize = cc.Director:getInstance():getVisibleSize();
	local origin = cc.Director:getInstance():getVisibleOrigin();

	local x = (posx - origin.x - visibleSize.width*0.5 + PosOffsetX)/cGridSize;
	local y = (posy - origin.y - visibleSize.height*0.5 + PosOffsetY)/cGridSize;


	return GetIntPart(x+0.5),GetIntPart(y+0.5);
end

function NewRect(x,y,ex )
	-- body
	ex = ex and ex or 0;
	return {
		left = x - cHalfGrid -ex,
		top = y + cHalfGrid +ex,
		right = x + cHalfGrid +ex,
		bottom = y - cHalfGrid -ex,


		width = function (self )
			-- body
			return math.abs(self.right-self.left)
		end,
		height = function (self )
			-- body
			return math.abs(self.bottom-self.top)
		end,
		center = function (self )
			-- body
			return x,y
		end,

		tostring = function (self)
			-- body
			print(string.format("%d  %d  %d  %d",self.left,self.top,self.right,self.bottom))
		end
	}

end



function RectIntersect(r1,r2 )


	-- body
	if r1:width() == 0 or r1:height() == 0 then
		return r2
	end

	if r2:width() == 0 or r2:height() == 0 then
		return r1
	end

	local left = math.max(r1.left,r2.left)

	if left>= r1.right or left>= r2.right then
		return nil
	end

	local right = math.max(r1.right,r2.right)

	if right<= r1.left or right<= r2.left then
		return nil
	end


	local top = math.max(r1.top,r2.top)

	if top<= r1.bottom or top<= r2.bottom then
		return nil
	end


	local bottom = math.max(r1.bottom,r2.bottom)

	if bottom>= r1.top or bottom>= r2.top then
		return nil
	end
	
	-- print("====",left,right,top,bottom,"---------RectIntersect-----------------")

	return NewRect(left,top,right,bottom)

end


function RectHit(r,x,y)
	-- body

	return x>= r.left and x<=r.right and y>=r.bottom and y<=top;
end


local s_max_nest = 5;
local tab_tag = ""
local loadTable = function(t, nest)
    if type(t) ~= "table" then 
        return t;
    end
    if nest > s_max_nest then
        return "MAX NESTING";
    end
    local tab = tab_tag;
    tab_tag = tab_tag .. "    ";
    local strArr = {};
    table.insert(strArr, "");
    for k,v in pairs(t) do 
        if v ~= nil and k~="___message" then 
            local key = tab_tag;
            if type(k) == "string" then
                key =  string.format("%s[\"%s\"] = ", key, tostring(k) );
            else 
                key =  string.format("%s[%s] = ", key, tostring(k) );
            end 
            
            table.insert(strArr, key);
            if type(v) == "table" then 
                table.insert(strArr, loadTable(v, nest+1) );
            elseif type(v) == "string" then 
                table.insert(strArr, string.format("\"%s\";\n",tostring(v)));
            else 
                table.insert(strArr, string.format("%s;\n",tostring(v)));
            end 
        end 
    end 
    tab_tag = tab;
    local str = string.format("\n%s{\n%s%s};\n", tab_tag, table.concat(strArr), tab_tag);
    return str;
end


local getData = function(...)  
    local strArr = {};
    table.insert(strArr, "");
    for _,v in pairs({...}) do
        local tempType = type(v); 
        if tempType == "table" then
            table.insert(strArr, loadTable(v, 1) );
        else
            table.insert(strArr, tostring(v) );
        end
        table.insert(strArr, " ");
    end
    return string.format("%s", table.concat(strArr));
end


local _print = print;
function print(...)
    local logInfo = getData(...)
    logInfo = "curFrame：" .. "----" .. os.date("%Y-%m-%d %H:%M:%S") .. "--" .. logInfo
    return _print(logInfo)
end




