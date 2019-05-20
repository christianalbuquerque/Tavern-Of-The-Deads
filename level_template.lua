local composer = require("composer")
local base = require( "base")

local physics = require( "physics" )
physics.start()
physics.setGravity(0, 0)
physics.setDrawMode("hybrid")

local lvl = {}

local uiGroup = display.newGroup()
local enemiesGroup
local background

local timeText
local time = 0
local scoreText
local score = 0
local enemyText
local qtdEnemy = 0

local enemyChosen

local bartender
local aim
local enemies = {}
local background

local currentLevel
local aimTimerLoop

------------ GETTERS AND SETTERS

function lvl:addScore(value) 
    score = score + value
    lvl:updateScore()
end

function lvl:updateScore()
    scoreText.text = "Score: " .. score
end

function lvl:getScore()
    return score
end

function lvl:restoreTime()
    time = time + 5
end

function lvl:reduceTime(value) 
    time = time - value
    lvl:updateTime()

    if time == 0 then
        lvl:endGame()
    end
end

function lvl:updateTime()
    timeText.text = "Tempo: " .. time
end

function lvl:getTime()
    return time
end

function lvl:updateEnemyScore()
    enemyText.text = "Inimigos: ".. qtdEnemy
end

function lvl:reduceEnemyQtd()
    qtdEnemy = qtdEnemy - 1
    lvl:updateEnemyScore()

    if qtdEnemy == 0 then
        lvl:nextLevel()
    end
end

function lvl:startEnemyQtd()
    qtdEnemy = base.levels[currentLevel].numEnemies
    lvl:updateEnemyScore()
end

function lvl:getEnemyQtd()
    return qtdEnemy
end

function lvl:startTime()
    time = base.levels[currentLevel].time
end

function lvl:getCurrentLevel()
	return currentLevel
end

function lvl:setCurrentLevel(numCurrent)
	currentLevel = numCurrent
end

------------ UI AND SCENARY

function lvl:buildHeader()
    headerGroup = display.newGroup()
    timeText = display.newText( uiGroup, "Tempo: " .. time, 200, 80, native.systemFont, 24 )
    headerGroup:insert(timeText)
    scoreText = display.newText( uiGroup, "Score: " .. score, 400, 80, native.systemFont, 24 )
    headerGroup:insert(scoreText)
    enemyText = display.newText( uiGroup, "Inimigos: ".. qtdEnemy, 600, 80, native.systemFont, 24 )
    headerGroup:insert(enemyText)

    return headerGroup
end

function lvl:createBackground()
    local backgroundGroup = display.newGroup()
    background = display.newImageRect( backgroundGroup, base.levels[currentLevel].background, display.contentWidth - 150, display.contentHeight )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background:addEventListener("touch", touchAim)
    backgroundGroup:insert(background)

    return backgroundGroup
end

function lvl:createBartender()
    local bartenderGroup = display.newGroup()
    bartender = display.newImageRect(bartenderGroup, "./images/astronaut.png", 100, 100 )
    bartender.x = display.contentCenterX
    bartender.y = display.contentCenterY + 450
    bartenderGroup:insert(bartender)
    return bartenderGroup
end

------------ ENEMIES

function selectEnemy()
    enemyChosen = math.random( 1, base.levels[currentLevel].numEnemies )
end

function lvl:createEnemy()
    print("------Enemies Group--------")
    print(enemiesGroup)
    print("------Caminho dos Inimigos--------")
    print(base.levels[currentLevel].enemies[1].path)
    local newEnemy = display.newImageRect(enemiesGroup, base.levels[currentLevel].enemies[1].path, 50, 120 )
    print("eiohGOE")
	newEnemy.myName = "enemy"
    newEnemy.colliding = false
    physics.addBody(newEnemy, "dynamic", { radius=40 } )
    
    table.insert(enemies, newEnemy)

	local whereFrom = math.random( 2 )
                        -- Posição do inimigo
    if( whereFrom == 1 ) then
		--From Left
		newEnemy.x = math.random(120, display.contentCenterX)
		newEnemy.y = math.random(150, display.contentCenterY)
	elseif ( whereFrom == 2 ) then
		-- From the right
		newEnemy.x = math.random(display.contentCenterX, display.contentWidth - 120)
		newEnemy.y = math.random(150, display.contentCenterY)
    end
end

function verifyEnemies()
    print('VERIFY ENEMIES')
    for x = 1, lvl:getEnemyQtd(), 1 do
        print(enemies[x].colliding)		
		if enemies[x] ~= nil and enemies[x].colliding == true then				
			enemies[x].colliding = false 
			enemies[x]:removeSelf()
            enemies[x] = enemies[qtdEnemy]
            lvl:startTime()
            lvl:reduceEnemyQtd()
            lvl:addScore(1)
		end			
	end
end

function lvl:createAllEnemies()
    enemiesGroup = display.newGroup() 
    for x=1, base.levels[currentLevel].numEnemies, 1 do
        lvl:createEnemy()
    end

    return enemies
end

function lvl:getEnemiesGroup()
    return enemiesGroup
end

------------ AIM

function aimCollision(event)
    print('COOLLIDIU')	
	if(event.object2.myName == "enemy" and event.object1.myName == "aim") or 
	(event.object1.myName == "enemy" and event.object2.myName == "aim") then	
		if event.phase == "began" then
			if event.object1.myName == "enemy" then
                event.object1.colliding = true
			else
				event.object2.colliding = true				
			end
		end
		
		if event.phase == "ended" then
			if event.object1.myName == "enemy" then
				event.object1.colliding = false
			else
				event.object2.colliding = false
			end
		end
	end
end

function aimMovement()
	aim.y = aim.y - 5
end

function touchAim(event)
	if event.phase == "began" then
		aim = display.newImageRect('./images/game/mira.png', 50, 50)
		aim.x = event.x
		aim.y = event.y			
		aim.myName = "aim"

		physics.addBody(aim, "dynamic", { radius=20, isSensor=true })
		aimTimerLoop = timer.performWithDelay(10, aimMovement, -1)

	elseif event.phase == "ended" then			
		timer.performWithDelay(10, timer.cancel(aimTimerLoop), 1)
		verifyEnemies()
		aim:removeSelf()
    end
    
    return aim
end

function lvl:startAimCollision()
    Runtime:addEventListener("collision", aimCollision)
end

function lvl:endAimCollision()
    Runtime:removeEventListener("collision", aimCollision)
end

------------ CONTROLLING LEVELS

function lvl:nextLevel()
	composer.gotoScene( base.levels[currentLevel+1].lvlName, { time=800, effect="crossFade" } )
end

function lvl:endGame()
	composer.gotoScene( "game_over", { time=800, effect="crossFade" } )
end

function lvl:destroy()
    enemies = {}
    lvl:endAimCollision()
    qtdEnemy = 0
    time = 0    
end

return lvl