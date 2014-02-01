-- "Chat" API: aka how PlayBoy connects to the IRC server and interacts with it.
local ROOT_PATH = (...):match('(.+)%.%w+$')
local Class  = require(ROOT_PATH ..".class")
local Socket = require("socket") -- We'll need some good old socket action
local Chat = Class("PlayBoy Chat") -- Oh, and some good ol' PlayBoy Chat action.

function string:split(delimiter) --Not by me (SOMEONE IMPROVE THIS IT'S A GLOBAL FUNCTION AND THAT NEEDS TO CHANGE)
	local result = {}
	local from  = 1
	local delim_from, delim_to = string.find( self, delimiter, from  )
	while delim_from do
		table.insert( result, string.sub( self, from , delim_from-1 ) )
		from = delim_to + 1
		delim_from, delim_to = string.find( self, delimiter, from  )
	end
	table.insert( result, string.sub( self, from  ) )
	return result
end

function Chat:connect(server, port)
	self.tcp = Socket.tcp()
	local ok = self.tcp:connect(server, port)
	
	if ok == 1 then
		print(">Connected to " .. server .. "!")
	else
		print(">Cannot connect to " .. server .. ".")
	end
end

function Chat:getStats()
	-- Returns bytes received, sent, and the socket object's age (in seconds).
	if not self.tcp then return end
	return self.tcp:getstats()
end

function Chat:sendCommand(command, message)
	-- Sends a command to the server, with a message.
	if not self.tcp then return end
	self.tcp:send(command .. " " .. (message or "") .. "\r\n")
end

function Chat:joinChannel(channel)
	-- If it's able to, sends the JOIN command. It's pretty much a shortcut.
	self:sendCommand("JOIN", channel or "#love") -- Now I'm really making things blatant!
end

function Chat:setTimeout(timeout)
	-- Sets up the timeout.
	if not self.tcp then return end
	self.tcp:settimeout(timeout or 0)
end

function Chat:operate()
	-- RECEIVES MESSAGES
	local message, err = self.tcp:receive("*l")
	if message then
		-- Right now it only gets the raw message. That's probably a good idea to update.
		print(message)
	end
end

function Chat:close()
	-- Called to close up the chat, if you catch my drift.
	if self.tcp then self.tcp:close() end
end

return Chat