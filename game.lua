
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
_G.time = 1000
_G.score = 0
local qtdEnemy = math.random(3,7)
local uiEnemy = qtdEnemy
local screenEnemy = qtdEnemy
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

-- Função que leva ao meu Game Over

	local function endGame()
		composer.gotoScene( "game_over", { time=800, effect="crossFade" } )
	end
	

-- Me redireciona para a próxima fase (temporario)
	local function nextLevel()
		composer.gotoScene( "level2", { time=800, effect="crossFade" } )
	end

	local function verifyEnemies()
		print('--------------- VERIFY ENEMIES')
		for x = 1, uiEnemy, 1 do
			print('--- COLLIDING')
			print(enemyTable[x].colliding)
			print(enemyTable[x].x)
			if enemyTable[x] ~= nil and enemyTable[x].colliding == true then				
				enemyTable[x].colliding = false 
				enemyTable[x]:removeSelf()
				enemyTable[x] = enemyTable[uiEnemy]
				uiEnemy = uiEnemy - 1
			end			
		end
	end

	local function updateValues(event)

		timeText.text = "Tempo: " .. time
		time = 6
		score = score + 1
		scoreText.text = "Score: " .. score
		screenEnemy = screenEnemy - 1
		enemyText.text = "Inimigos: ".. screenEnemy

		if( uiEnemy == 0 ) then
			nextLevel()
		end

		return true
	end
	
-- Lida com toda parte da colisão que se relaciona com a mira do meu jogo

	local function aimCollision(event)	
		if(event.object2.myName == "enemy" and event.object1.myName == "aim") or 
		(event.object1.myName == "enemy" and event.object2.myName == "aim") then	
			print('--------------- COLIDIU FANTASMA')
			if event.phase == "began" then
				if event.object1.myName == "enemy" then
					event.object1.colliding = true
				else
					event.object2.colliding = true
				end
			end
			
			if event.phase == "ended" then
				if event.object1.myName == "enemy" then
					event.object2.colliding = false
				else
					event.object1.colliding = false
				end
			end
			print(event.object1.colliding)
			print(event.object2.colliding)
			updateValues()
		end
	end

-- Loop que diminui o eixo Y referente a minha mira, fazendo ela subir
	
	local function aimLooper()
		aim.y = aim.y - 10
	end
	
-- Faço um verificação do estado do meu evento, se for inicial crio a minha mira. Atribuo a sua colisão
-- fisica e afins.

	local function touchAim(event)
		if event.phase == "began" then
	
			aim = display.newImageRect('./images/game/mira.png', 50, 50)
			aim.x = event.x
			aim.y = event.y			
			aim.myName = "aim"

			physics.addBody(aim, "dynamic", { radius=20, isSensor=true })
			aimTimerLoop = timer.performWithDelay(10, aimLooper, -1)
	
		elseif event.phase == "ended" or event.phase == "cancelled" then			
			timer.cancel(aimTimerLoop) -- Cancela o timer da mira
			verifyEnemies()
		end
	end
	
-- Aqui tenho todo o controle do tempo do jogo

	local function gameTime()
		time = time - 1
		timeText.text = "Tempo: " .. time
		if(time == 0) then
			endGame()
		end
	end
	
	timer.performWithDelay( 100, count, 0 )

-- Crio os meus inimigos e defino as posições iniciais deles
	
	local function createEnemy()
	
		local newEnemy = display.newImageRect( mainGroup, "./images/game/ghost.png", 50, 120 )
		table.insert( enemyTable, newEnemy )
		physics.addBody( newEnemy, "dynamic", { radius=40 } )
		newEnemy.myName = "enemy"
		newEnemy.colliding = false
	
		local whereFrom = math.random( 2 )
	
		if( whereFrom == 1 ) then -- Dependendo do valor que sair desse Math.Random defino de qual posição ele irá ser gerado

			--From Left
			newEnemy.x = math.random(120, display.contentCenterX)
			newEnemy.y = math.random(150, display.contentCenterY)
		elseif ( whereFrom == 2 ) then

			-- From the right
			newEnemy.x = math.random(display.contentCenterX, display.contentWidth - 120)
			newEnemy.y = math.random(150, display.contentCenterY)
		end
	end

-- Loop de controle da criação dos meus inimigos que serão gerados na tela
	
	local function gameLoop()
		while( qtdEnemy ~= 0 ) do
			createEnemy()
			qtdEnemy = qtdEnemy - 1
		end
	end

-- Função de controle do elementos visuais que serão modificados de acordo com o tempo
	
	local function updateText()
		timeText.text = "Tempo: " .. time
		scoreText.text = "Score: " .. score
		enemyText.text = "Inimigos: ".. qtdEnemy
	end
	
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

	Runtime:addEventListener("collision", aimCollision)
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