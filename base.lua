local base = {}
base.levels = {}

--------------------------------------
--------------------------------------
-------------- LEVELS ----------------
--------------------------------------
--------------------------------------

    --------------------------------------
    --- LEVEL 1 ---
    -------------------------------------
    
    base.levels[1] = {}
        base.levels[1].background = "images/game/bar-piso.png"
        base.levels[1].numEnemies = 5
        base.levels[1].time = 5
        base.levels[1].lvlName = "game"
        base.levels[1].enemies = {}

            base.levels[1].enemies[1] = {}
            base.levels[1].enemies[1].path = "images/game/ghost.png"
            base.levels[1].enemies[1].x = 50
            base.levels[1].enemies[1].y = 120

    --------------------------------------
    --- LEVEL 2 ---
    -------------------------------------
        
    base.levels[2] = {}
        base.levels[2].background = "images/game/level2/day-level.png"
        base.levels[2].numEnemies = 2
        base.levels[2].time = 500
        base.levels[2].lvlName = "level2"
        base.levels[2].enemies = {}

            base.levels[2].enemies[1] = {}
            base.levels[2].enemies[1].path = "images/game/ghost.png"
            base.levels[2].enemies[1].x = 50
            base.levels[2].enemies[1].y = 120

            
            base.levels[2].enemies[2] = {}
            base.levels[2].enemies[2].path = "images/game/level2/zombie.png"
            base.levels[2].enemies[2].x = 50
            base.levels[2].enemies[2].y = 120
return base

