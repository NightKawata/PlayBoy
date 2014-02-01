PlayBoy
=======

The sexy lil' IRC API for LÖVE.
-------------------------------

Get started, yo! I opened up the source, so you can mess with it all you want.

###HOW TO GET YOUR PLAYBOY TO WORK:
Now we all know that doesn't sound right.
Here's the easiest way to get PlayBoy set up:

	function love.load()
		playBoy = require("playboy"):new()
		playBoy:connect()
	end
	
That's all you've got to do to get PlayBoy to connect. Once you call up the connect function, PlayBoy will automatically connect to the default network, and it'll be showin' off in no time. As of right now it will technically connect, it just won't show you any output if you don't call the update function.

Now to get some fancy console printing:

	function love.update()
		playBoy:update(dt)
	end

As of right now, it really only shows messages received by the console. That'll definitely change later.
Also, unless you like leaving doors open, you should probably close your PlayBoy, so:

	function love.quit()
		playBoy:close()
	end
	
That's all. You'll have your PlayBoy closed, and you can open it right back up.
