local composer = require( "composer" )
local lvl = require("level_template")

composer.recycleOnSceneChange = true
local scene = composer.newScene()

local sounds = require( "sound_file" )
local base = require( "base" )

local aimStopped = false
local aim
local gameLoop

local enemyInteractionLoop

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

local function enemyInteraction()
	local enemy
	print(lvl:getEnemyQtd())
	enemy = math.random(1, lvl:getEnemyQtd())
	enemies = lvl:getEnemiesGroup()
	enemies[enemy].x = math.random(120, display.contentCenterX)
	enemies[enemy].y = math.random(150, display.contentCenterY)
end

-- create()
function scene:create( event )

	local sceneGroup = self.view
	lvl:setCurrentLevel(4)

	sceneGroup:insert(backGroup)
	sceneGroup:insert(mainGroup)
	sceneGroup:insert(uiGroup)

	lvl:startTime()
	
	----------------------------- Carregar Sprites
	
	-- mainGroup:insert(lvl:createBartender())
	backGroup:insert(lvl:createBackground())
			
	local header = lvl:buildHeader()
	uiGroup:insert(header)
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

	elseif ( phase == "did" ) then
		-- physics.start()
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
		timer.cancel(gameLoop)
		lvl:destroy()
	elseif ( phase == "did" ) then
		-- physics.pause()
		audio.stop( 1 )
	end
end

-- destroy()
function scene:destroy( event )
	print('DESTROOY')
	local sceneGroup = self.view
	audio.dispose( gameMusic )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene