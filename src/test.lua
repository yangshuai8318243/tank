--[[--ldoc desc
@module test
@author ShuaiYang

Date   2018-11-06 10:17:28
Last Modified by   ShuaiYang
Last Modified time 2019-01-18 14:58:14
]]
local socket = require("socket")
 
local host = "www.baidu.com"
local file = "/"
 
-- 创建一个 TCP 连接，连接到 HTTP 连接的标准端口 -- 80 端口上
local sock = assert(socket.connect(host, 80))
sock:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
repeat
    -- 以 1K 的字节块来接收数据，并把接收到字节块输出来
    local chunk, status, partial = sock:receive(1024)
    print(chunk or partial)
until status ~= "closed"
-- 关闭 TCP 连接
sock:close()

-- print("Hello from " .. socket.gettime() .. " and " .. mime._VERSION .. "!")
