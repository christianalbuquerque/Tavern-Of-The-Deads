local base = {}
base.levels = {}
base.settings = {}

--------------------------------------
--------------------------------------
-------------- LEVELS ----------------
--------------------------------------
--------------------------------------

    base.settings.maxLevels = 5
    base.settings.currentLevel = 1
    base.settings.levels = {}

        base.settings.levels[1] = {}
        base.settings.levels[1].title = "BAR"
        base.settings.levels[1].background = "images/selector-imgs/lvl1-img.png"

        base.settings.levels[2] = {}
        base.settings.levels[2].title = "DIA"
        base.settings.levels[2].background = "images/selector-imgs/lvl2-img.png"
        
        base.settings.levels[3] = {}
        base.settings.levels[3].title = "PRAIA"
        base.settings.levels[3].background = "images/selector-imgs/lvl4-img.png"

        base.settings.levels[4] = {}
        base.settings.levels[4].title = "NOITE"
        base.settings.levels[4].background = "images/selector-imgs/lvl3-img.png"

        base.settings.levels[5] = {}
        base.settings.levels[5].title = "FINAL"
        base.settings.levels[5].background = "images/selector-imgs/boss-img.png"

    --------------------------------------
    --- LEVEL 1 ---
    -------------------------------------
    
    base.levels[1] = {}
        base.levels[1].background = "images/bar-level/bar-piso.png"
        base.levels[1].numEnemies = 5
        base.levels[1].time = 5
        base.levels[1].lvlName = "level1"
        base.levels[1].enemies = {}

            base.levels[1].enemies[1] = {}
            base.levels[1].enemies[1].path = "images/bar-level/ghost.png"
            base.levels[1].enemies[1].type = "ghost"
            base.levels[1].enemies[1].x = 50
            base.levels[1].enemies[1].y = 120
            base.levels[1].enemies[1].width = 50
            base.levels[1].enemies[1].height = 120

    --------------------------------------
    --- LEVEL 2 ---
    -------------------------------------
        
    base.levels[2] = {}
        base.levels[2].background = "images/day-level/day-level.png"
        base.levels[2].numEnemies = 7
        base.levels[2].time = 100
        base.levels[2].lvlName = "level2"
        base.levels[2].enemies = {}

            base.levels[2].enemies[1] = {}
            base.levels[2].enemies[1].path = "images/day-level/zombie.png"
            base.levels[2].enemies[1].x = 50
            base.levels[2].enemies[1].y = 120
            base.levels[2].enemies[1].width = 50
            base.levels[2].enemies[1].height = 120

    --------------------------------------
    --- LEVEL 3 ---
    --------------------------------------

    base.levels[3] = {}
        base.levels[3].background = "images/night-level/night-level.png"
        base.levels[3].numEnemies = 10
        base.levels[3].time = 10
        base.levels[3].lvlName = "level3"
        base.levels[3].enemies = {}

            base.levels[3].enemies[1] = {}
            base.levels[3].enemies[1].path = "images/night-level/bat.png"
            base.levels[3].enemies[1].x = 50
            base.levels[3].enemies[1].y = 120
            base.levels[3].enemies[1].width = 80
            base.levels[3].enemies[1].height = 150

    --------------------------------------
    --- LEVEL 4 ---
    --------------------------------------

    base.levels[4] = {}
    base.levels[4].background = "images/forest-level/beach.png"
    base.levels[4].numEnemies = 10
    base.levels[4].time = 10
    base.levels[4].lvlName = "level4"
    base.levels[4].enemies = {}

        base.levels[4].enemies[1] = {}
        base.levels[4].enemies[1].path = "images/forest-level/octopus.png"
        base.levels[4].enemies[1].x = 50
        base.levels[4].enemies[1].y = 120
        base.levels[4].enemies[1].width = 50
        base.levels[4].enemies[1].height = 120

    --------------------------------------
    --- LEVEL FINAL ---
    --------------------------------------

    base.levels[5] = {}
    base.levels[5].background = "images/boss-level/boss-bar.png"
    base.levels[5].numEnemies = 1
    base.levels[5].time = 10
    base.levels[5].lvlName = "level5"
    base.levels[5].enemies = {}
    
        base.levels[5].enemies[1] = {}
        base.levels[5].enemies[1].path = "images/boss-level/skull.png"
        base.levels[5].enemies[1].x = 50
        base.levels[5].enemies[1].y = 120
        base.levels[5].enemies[1].width = 50    
        base.levels[5].enemies[1].height = 120

return base

