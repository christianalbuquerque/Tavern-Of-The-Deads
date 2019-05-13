
local composer = require( "composer" )

local scene = composer.newScene()
local sounds = require("sound_file")

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local musicTrack

local function gotoGame()
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

local function gotoHighScores()
	composer.gotoScene( "level2", { time=800, effect="crossFade" } )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- Loading my menu background image
	local background = display.newImageRect( sceneGroup, './images/menu/darkback.png', 800, 1000 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY


	-- Loading my first short chain (right) in the top
	local rightShortChain = display.newImageRect( sceneGroup, "./images/menu/corrente.png", 40, 140 )
	rightShortChain.x = display.contentCenterX + 100
	rightShortChain.y = 80

	-- Loading my first short chain (left) in the top
	local leftShortChain = display.newImageRect( sceneGroup, "./images/menu/corrente.png", 40, 140 )
	leftShortChain.x = display.contentCenterX - 100
	leftShortChain.y = 80

	-- Loading my second short chain (right) in the midle
	local rightShortChain2 = display.newImageRect( sceneGroup, "./images/menu/corrente.png", 40, 140 )
	rightShortChain2.x = display.contentCenterX + 100
	rightShortChain2.y = 700

	-- Loading my second short chain (left) in the midle
	local leftShortChain2 = display.newImageRect( sceneGroup, "./images/menu/corrente.png", 40, 140 )
	leftShortChain2.x = display.contentCenterX - 100
	leftShortChain2.y = 700

	-- Loading my first long chain (right) in the midle
	local rightLongChain = display.newImageRect( sceneGroup, "./images/menu/corrente-longa.png", 40, 280 )
	rightLongChain.x = display.contentCenterX + 100
	rightLongChain.y = display.contentCenterY

	-- Loading my first long chain (right) in the midle
	local leftLongChain = display.newImageRect( sceneGroup, "./images/menu/corrente-longa.png", 40, 280 )
	leftLongChain.x = display.contentCenterX - 100
	leftLongChain.y = display.contentCenterY

	-- Loading my game logo
	local logo = display.newImageRect( sceneGroup, "./images/menu/logo.png", 500, 500 )
	logo.x = display.contentCenterX - 18
	logo.y = 400

	-- Play Button
	local playButton = display.newImageRect( sceneGroup, "./images/menu/playbtn.png", 350, 100 )
	playButton.x = display.contentCenterX 
	playButton.y = display.contentCenterY + 100

	-- Option Button
	local optButton = display.newImageRect( sceneGroup, "./images/menu/optionbtn.png", 350, 100 )
	optButton.x = display.contentCenterX
	optButton.y = display.contentCenterY + 250

	playButton:addEventListener( "tap", gotoGame )
	optButton:addEventListener( "tap", gotoHighScores )
	playGameMusic(menuMusic)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		-- Stop the music!
		audio.stop( 1 )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose( menuMusic )

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
