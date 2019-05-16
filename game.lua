
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )
physics.setDrawMode("hybrid")

-- Initialize variables
_G.time = 5
_G.score = 0
local qtdEnemy = math.random(3,7)
local uiEnemy = qtdEnemy

local aimStopped = false

local aim
local aimTimerLoop

local enemyTable = {}

local gameLoopTimer
local timeText
local scoreText
local sounds = require( "sound_file" )

local backGroup
local mainGroup
local uiGroup

local function endGame()
	composer.gotoScene( "game_over", { time=800, effect="crossFade" } )
end

local function nextLevel()
	composer.gotoScene( "level2", { time=800, effect="crossFade" } )
end

local function aimCollision(self, event)
	if(event.other.myName == "enemy") then
		event.other:removeSelf()
	end
end

local function aimLooper()
	print(aim.y)
	aim.y = aim.y - 10
end

local function touchAim(event)
	if event.phase == "began" then
		
		aim = display.newImageRect('./images/game/mira.png', 50, 50)
		aim.x = display.contentCenterX
		aim.y = display.contentCenterY
		aim.myName = "aim"

		aim.collision = aimCollision
		aim:addEventListener("collision")

		physics.addBody(aim, "dynamic", { radius=20, isSensor=true })
		aimTimerLoop = timer.performWithDelay(10, aimLooper, -1)

	elseif event.phase == "ended" or event.phase == "cancelled" then
		timer.cancel(aimTimerLoop)
	end
end

local function tapListener(event) 
	print( "FOI" )  -- "event.target" is the tapped object
	timeText.text = "Tempo: " .. time
	time = 6
	score = score + 1
	scoreText.text = "Score: " .. score
	uiEnemy = uiEnemy - 1
	enemyText.text = "Inimigos: ".. uiEnemy
	event.target:removeSelf()
	if( uiEnemy == 0 ) then
		nextLevel()
	end
    return true
end

local function gameTime()
    time = time - 1
	timeText.text = "Tempo: " .. time
	if(time == 0) then
		endGame()
	end
end

timer.performWithDelay( 100, count, 0 )

local function createEnemy()

	local newEnemy = display.newImageRect( mainGroup, "./images/game/ghost.png", 50, 120 )
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
	
	-- Load the background
	local background = display.newImageRect( backGroup, "./images/game/bar-piso.png", display.contentWidth - 150, display.contentHeight )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background:addEventListener("touch", touchAim)

	-- Load my balcony
	local balcony = display.newImageRect( mainGroup, "./images/game/balcao.png", 800, 150 )
	balcony.x = display.contentCenterX
	balcony.y = display.contentCenterY + 400

	-- Load my main character
	local astronaut = display.newImageRect( mainGroup, "./images/astronaut.png", 100, 100 )
	astronaut.x = display.contentCenterX
	astronaut.y = display.contentCenterY + 450
	
	-- Display lives and score
	timeText = display.newText( uiGroup, "Tempo: " .. time, 200, 80, native.systemFont, 24 )
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
		playGameMusic(gameMusic)
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		timer.cancel( gameLoopTimer )

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		physics.pause()
		 -- Stop the music!
		audio.stop( 1 )
		composer.removeScene( "game" )
	end
end


-- destroy()
function scene:destroy( event )
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
--------------------------------------------------------------------------------------

return scene