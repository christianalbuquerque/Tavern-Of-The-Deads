
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )
-- physics.setDrawMode("hybrid")

local currentTime = time
local died = false
local qtdEnemy = math.random(3,7)
local uiEnemy = qtdEnemy
local gameLoopTimer
local timeText
local scoreText

local enemyTable = {}

local backGroup
local mainGroup
local uiGroup

local function endGame()
	display.remove(background)
	composer.gotoScene( "game_over", { time=800, effect="crossFade" } )
end

-- local function nextLevel()
-- 	composer.gotoScene( "", { time=800, effect="crossFade" } )
-- end

local function tapListener(event) 
	print( "FOI" )  -- "event.target" is the tapped object
	time = 6
	score = score + 1
	scoreText.text = "Score: " .. score
	uiEnemy = uiEnemy - 1
	enemyText.text = "Inimigos: ".. uiEnemy
	event.target:removeSelf()
	if( uiEnemy == 0 ) then
		endGame()
	end
    return true
end

local function gameTime()
    time = time - 1
	timeText.text= "Tempo: " .. time
	if(time == 0) then
		endGame()
	end
end

timer.performWithDelay( 100, count, 0 )

local function createEnemy()

	local newEnemy = display.newImageRect( mainGroup, "./images/game/level2/zombie.png", 50, 120 )
	table.insert( enemyTable, newEnemy )
	physics.addBody( newEnemy, "dynamic", { radius=40 } )
	newEnemy.myName = "enemy"
	newEnemy:addEventListener( "tap", tapListener)

	local whereFrom = math.random( 2 )

	if( whereFrom == 1 ) then
		--From Left
		newEnemy.x = math.random(120, display.contentCenterX)
		newEnemy.y = math.random(150, display.contentCenterY)
		-- transition.to( newEnemy, { time=1500, alpha=0, x=(-60), y=(-150) } )
    elseif ( whereFrom == 2 ) then
        -- From the right
        newEnemy.x = math.random(display.contentCenterX, display.contentWidth - 120)
		newEnemy.y = math.random(150, display.contentCenterY)
		-- transition.to( newEnemy, { time=1500, alpha=0, x=(display.contentWidth + 60), y=(-150) } )
	end
end

local function gameLoop()
	while( qtdEnemy ~= 0 ) do
		createEnemy()
		qtdEnemy = qtdEnemy - 1
	end
end

local function updateText()
	timeText.text = "Tempo: " .. time
	scoreText.text = "Score: " .. score
	enemyText.text = "Inimigos: ".. qtdEnemy
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

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

	local backgroundLevel2 = display.newImageRect(backGroup, './images/game/level2/day-level.png', display.contentWidth - 150, display.contentHeight )
	backgroundLevel2.x = display.contentCenterX
	backgroundLevel2.y = display.contentCenterY

	-- Display lives and score
	timeText = display.newText( uiGroup, "Tempo: " .. currentTime, 200, 80, native.systemFont, 24 )
	scoreText = display.newText( uiGroup, "Score: " .. score, 400, 80, native.systemFont, 24 )
	enemyText = display.newText( uiGroup, "Inimigos: ".. qtdEnemy, 600, 80, native.systemFont, 24 )

	gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
	timer.performWithDelay( 1000, gameTime, 0 )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
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
		physics.pause()
		composer.removeScene( "level2" )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
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
