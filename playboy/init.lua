--[[
	START READING SOME PLAYBOY, DAWG
--]]
local __DEBUG = true
local Class = require("playboy.class") -- NOT BY ME
local Chat = require("playboy.chat")
local Playboy = Class("PlayBoy Client")
-- Now that all that's over with, let's make some magic

function Playboy:setServer(server)
	-- server: the IRC server you'd like to connect to.
	self.server = server or "irc.oftc.net" -- As a default, we'll use our LOVE-ly network.
end

function Playboy:setPort(port)
	self.port = port or 6667 -- In case any magic (or friendship) is needed.
end

function Playboy:setNickname(nickname)
	self.nickname = nickname or "PlayBoy_Client"
end

function Playboy:setUsername(username)
	self.username = username or "PlayBoy" -- There are no masked men
end

function Playboy:setRealname(realname)
	self.realname = realname or "PlayBoy X" -- GTA IV reference, get!
end

function Playboy:connect()
	-- Now THIS is what you want to run to begin PlayBoy.
	-- If things don't exist, make them exist
	if not self.server then self:setServer() end
	if not self.port then self:setPort() end
	if not self.nickname then self:setNickname() end
	if not self.username then self:setUsername() end
	if not self.realname then self:setRealname() end
	
	-- Now let's set up the chat, and have it connect somewhere.
	self.chat = Chat:new()
	self.chat:connect(self.server, self.port)
	self.chat:sendCommand("NICK", self.nickname)
	self.chat:sendCommand("USER", self.username .. " 8 * :" .. self.realname)
	self.chat:joinChannel("#playboy")
	self.chat:setTimeout()
end

function Playboy:update(dt)
	if self.chat then
		self.chat:operate()
	end
end

function Playboy:close()
	if self.chat then self.chat:close() end
end

return Playboy