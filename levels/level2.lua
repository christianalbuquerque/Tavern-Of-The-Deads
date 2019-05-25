local composer = require( "composer" )
local lvl = require( "level_template" )

composer.recycleOnSceneChange = false
local scene = composer.newScene()

local sounds = require( "sound_file" )
local base = require( "base" )

local gameLoop

local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local function gameTime()
	lvl:reduceTime(1)
	if(lvl:getTime() == 0) then
		lvl:endGame()
	end
end 

-- create()
function scene:create( event )

	local sceneGroup = self.view
	lvl:setCurrentLevel(2)

	sceneGroup:insert(backGroup)
	sceneGroup:insert(mainGroup)
	sceneGroup:insert(uiGroup)

	lvl:startTime()

----------------------------- Carregar Sprites
	-- mainGroup:insert(lvl:createBartender())
	backGroup:insert(lvl:createBackground())

	local header = lvl:buildHeader()
	uiGroup:insert(header)
	timer.performWithDelay( 1000, gameTime, 0 )

	gameLoop = timer.performWithDelay( 1000, gameTime, 0 )

	local enemies = lvl:createAllEnemies()
	mainGroup:insert(lvl:getEnemiesGroup())
	
	lvl:startAimCollision()
	lvl:startEnemyQtd()
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		playGameMusic(gameMusic)
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		lvl:endAimCollision()
		backGroup:removeSelf()
		mainGroup:removeSelf()
		uiGroup:removeSelf()
		-- timer.cancel(enemyInteractionLoop)
		timer.cancel(gameLoop)
		lvl:destroy()
	elseif ( phase == "did" ) then
		audio.stop( 1 )
	end
end


-- destroy()
function scene:destroy( event )
	print('DESTROY2')
	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose( gameMusic )
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
