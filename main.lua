-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- Your code here 

function createTitleScreen()
-- local titlescreen = display.newImage("titlescreen.png")
	local startgametext = display.newText("Click here to start", 0 , 0, "Helvetica" , 24 )

	startgametext.x = display.contentCenterX
	startgametext.y = display.contentCenterY
	startgametext:setTextColor(0,22,22)

	local function startPressed(event)
		display.remove(event.target)
		-- display.remove(titlescreen)
		startgametext = nil
		createGame()
 
	end
 
        startgametext:addEventListener ( "tap", startPressed )
end

function createGame( )

	local screenWidth
	local screenHeight
	local screenLeft
	local screenRight
	local gameOverText
	local replayButton

	screenWidth = display.contentWidth
	screenHeight = display.contentHeight
	local tap_count = 0
	local hit_count = 5

	local background_img = display.newImageRect("bg.jpg",800,720) -- X Y Cordinaes

	background_img.x=display.contentCenterX
	background_img.y=display.contentCenterY

	local score = display.newText(tap_count,display.contentCenterX-80,-15,native.systemFont,30) -- Score Displays
	score:setFillColor(0,0,55)

	local head = display.newText("Score : ",display.contentCenterX-120,-15,native.systemFont,20) -- Score Displays
	head:setFillColor(0,0,55)

	local soil = display.newImageRect("soil.png",screenWidth,60)
	soil.x=display.contentCenterX
	soil.y=display.contentHeight+25

	local ball = display.newImageRect("football.png",80,80)
	ball.x=display.contentCenterX
	ball.y=display.contentCenterY

	local physics = require("physics")
	physics.start()
	physics.addBody(ball,"dynamic",{radius = 10, bounce = 0.8}) -- Moving object : Get gravity and other forces
	physics.addBody(soil,"static") -- static never moves

	display.setStatusBar( display.TranslucentStatusBar)

	local function pushBallUp( )

		ball:applyLinearImpulse(0,-0.02,ball.x,ball.y)
		tap_count = tap_count + 1
		score.text = tap_count
	end
	local function onLocalCollision( self, event )
		if (event.phase == "ended") then
			tap_count = 0
			if(hit_count == 1 ) then
					gameOver()
				else
					hit_count = hit_count - 1
			end
			score.text = tap_count
		end
	end
	soil.collision = onLocalCollision
	soil:addEventListener( "collision" )

	ball:addEventListener("tap",pushBallUp)
	display.setStatusBar(display.DefaultStatusBar)


	function gameOver()
		-- Game Over : Remove all Texts 
		gameOverText = display.newText("Game Over!!", display.contentCenterX, display.contentCenterY-50, native.systemFontBold, 50)
		gameOverText:setFillColor(88,88,0)
		display.remove(soil)
		display.remove(ball)
		display.remove(head)
		display.remove(score)
		replayButton = display.newText("REPLAY", display.contentCenterX, display.contentCenterY+100, native.systemFontBold, 20)
		replayButton:addEventListener("tap",removeAll)
	end