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