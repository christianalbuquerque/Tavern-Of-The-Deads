local base = {}
base.levels = {}

--------------------------------------
--------------------------------------
-------------- LEVELS ----------------
--------------------------------------
--------------------------------------

    --------------------------------------
    --- BABY LEVEL ---
    -------------------------------------
    
    base.levels[1] = {}
        base.levels[1].background = "images/game/bar-piso.png"
        base.levels[1].numEnemies = 1
        base.levels[1].backgroundNear = {}

            base.levels[1].backgroundNear[1] = {}
            base.levels[1].backgroundNear[1].path = "images/game/ghost.png"
            base.levels[1].backgroundNear[1].x = 50
            base.levels[1].backgroundNear[1].y = 120

        base.levels[1].collectibles = {}
        base.levels[1].numCollectibles = 2

            base.levels[1].collectibles[1]={}
            base.levels[1].collectibles[1].type = "health"
            base.levels[1].collectibles[1].path = "ui/collect/blast.png"

            base.levels[1].collectibles[2]={}
            base.levels[1].collectibles[2].type = "shoot"
            base.levels[1].collectibles[2].path = "ui/collect/bear.png"

        base.levels[1].obstacles = {}
        base.levels[1].numObstacles = 1
        
            base.levels[1].obstacles[1] = {}
            base.levels[1].obstacles[1].type = "health"
            base.levels[1].obstacles[1].path = "ui/collect/dicese.png"

    --------------------------------------
    --- CHILD LEVEL ---
    -------------------------------------
        
    base.levels[2] = {}
        base.levels[2].background = "ui/child/background.png"
        base.levels[2].numBackgroundsNear = 7
        base.levels[2].backgroundNear = {}

            base.levels[2].backgroundNear[1] = {}
            base.levels[2].backgroundNear[1].path = "ui/child/door.png"
            base.levels[2].backgroundNear[1].y = 126
            
            base.levels[2].backgroundNear[2] = {}
            base.levels[2].backgroundNear[2].path = "ui/child/door02.png"
            base.levels[2].backgroundNear[2].y = 126
            
            base.levels[2].backgroundNear[3] = {}
            base.levels[2].backgroundNear[3].path = "ui/child/clock.png"
            base.levels[2].backgroundNear[3].y = 100
            
            base.levels[2].backgroundNear[4] = {}
            base.levels[2].backgroundNear[4].path = "ui/baby/table.png"
            base.levels[2].backgroundNear[4].y = 185
            
            base.levels[2].backgroundNear[5] = {}
            base.levels[2].backgroundNear[5].path = "ui/child/lockers.png"
            base.levels[2].backgroundNear[5].y = 155

            base.levels[2].backgroundNear[6] = {}
            base.levels[2].backgroundNear[6].path = "ui/child/board.png"
            base.levels[2].backgroundNear[6].y = 130

            base.levels[2].backgroundNear[7] = {}
            base.levels[2].backgroundNear[7].path = "ui/child/chair.png"
            base.levels[2].backgroundNear[7].y = 192
        
        base.levels[2].collectibles = {}
        base.levels[2].numCollectibles = 3
        
            base.levels[2].collectibles[1]={}
            base.levels[2].collectibles[1].type = "health"
            base.levels[2].collectibles[1].path = "ui/collect/pills.png"

            base.levels[2].collectibles[2]={}
            base.levels[2].collectibles[2].type = "happiness"
            base.levels[2].collectibles[2].path = "ui/collect/carts.png"

            base.levels[2].collectibles[3]={}
            base.levels[2].collectibles[3].type = "shoot"
            base.levels[2].collectibles[3].path = "ui/collect/ball.png"

        base.levels[2].obstacles = {}
        base.levels[2].numObstacles = 2
        
            base.levels[2].obstacles[1] = {}    
            base.levels[2].obstacles[1].type = "health"
            base.levels[2].obstacles[1].path = "ui/collect/dicese.png"

            base.levels[2].obstacles[2] = {}    
            base.levels[2].obstacles[2].type = "happiness"
            base.levels[2].obstacles[2].path = "ui/collect/badvibe.png"
return base

