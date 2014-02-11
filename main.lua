--[[
	PlayBoy: The _PREMIERE_ LOVE IRC Client.
	
	>Uses LuaSocket
	>Uses LOVE
	
	~NightKawata
--]]
local playBoy = nil -- the PlayBoy instance.
local deltz = 0

function love.load()
	playBoy = require("playboy"):new() -- We'll obviously need PlayBoy to do our dirty work.
	playBoy:connect()
end

function love.update(dt)
	deltz = deltz + dt
	if deltz >= 3 then
		deltz = 0
		playBoy:sendMessage("hello")
	end
	playBoy:update(dt)
end

function love.quit()
	playBoy:close()
end