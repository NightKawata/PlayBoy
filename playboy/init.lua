-- READ SOME PLAYBOY, KID
local Class = require("playboy.class") -- NOT BY ME
local Chat = require("playboy.chat")
local Playboy = Class("PlayBoy Client")
-- Now that all that's over with, let's make some magic

function Playboy:initialize(server, port, nickname, username, realname)
	-- If any of this stuff isn't defined, it won't matter
	self:setServer(server)
	self:setPort(port)
	self:setNickname(nickname)
	self:setUsername(username)
	self:setRealname(realname)
	
	-- Oh and we probably need this
	self.chat = Chat:new()
end

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
	-- Now THIS is what you want to run to begin PlayBoy. We'll need to set up the Chat as well.
	if not self.chat then return end -- I don't know why this wouldn't exist (hackers), but hey
	self.chat:connect(self.server, self.port)
	self.chat:sendCommand("NICK", self.nickname)
	self.chat:sendCommand("USER", self.username .. " 8 * :" .. self.realname)
	self.chat:joinChannel("#playboy")
	self.chat:setTimeout()
end

function Playboy:update(dt)
	if self.chat then
		-- OPERATION
		self.chat:operate()
	end
end

function Playboy:close()
	-- Close up the chat, and GET DOWN WITH YOUR BAD SELF
	if self.chat then self.chat:close() end
end

return Playboy -- because someone stole it