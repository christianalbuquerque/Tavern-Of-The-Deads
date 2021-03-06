
local composer = require( "composer" )
local base = require( "base" )
local lvl = require( "level_template" )
local sounds = require("sound_file")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local function gotoMenu()
	composer.gotoScene( "levels.menu", { time=800, effect="crossFade" } )
end

-- create()
function scene:create( event )

	local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    physics.pause()  -- Temporarily pause the physics engine

	-- Set up display groups
	backGroup = display.newGroup()  -- Display group for the background image
	sceneGroup:insert( backGroup )  -- Insert into the scene's view group

	mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
	sceneGroup:insert( mainGroup )  -- Insert into the scene's view group

	uiGroup = display.newGroup()    -- Display group for UI objects like the score
	sceneGroup:insert( uiGroup )    -- Insert into the scene's view group
    
    -- Loading my menu background image
	local background = display.newImageRect( sceneGroup, "images/sucesso.png", 800, 1000 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

    local backBtn = display.newImageRect( sceneGroup, "images/game_over/back.png", 400, 100 )
    backBtn.x = display.contentCenterX + 10
	backBtn.y = 715

	backBtn:addEventListener( "tap", gotoMenu )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		-- playGameMusic(gameOverMusic)
		-- playSFX(gameOverSound)

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		lvl:restoreScore()

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		-- audio.stop( 1 )
		-- audio.stop( 2 )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	-- audio.dispose( gameOverMusic )
	-- audio.dispose( gameOverSound )
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
