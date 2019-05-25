local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

local base = require( "base" )

local titleText

local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

local function handleCancelButtonEvent()
	composer.gotoScene("menu")
end

local function handleLevelSelect( event )
	if ( "ended" == event.phase ) then
	
		base.settings.currentLevel = event.target.id
		if(event.target.id == '1') then
            composer.gotoScene( "levels.level1", { effect="crossFade", time=333 } )
        elseif ( event.target.id == '2') then
			composer.gotoScene( "levels.level2", { effect="crossFade", time=333 } ) 
		elseif ( event.target.id == '3') then
			composer.gotoScene( "levels.level3", { effect="crossFade", time=333 } )    
		elseif ( event.target.id == '4') then
            composer.gotoScene( "levels.level4", { effect="crossFade", time=333 } )            
		else
			composer.gotoScene( "levels.final", { effect="crossFade", time=333 } )
		end		
	end
end

function scene:create( event )
    local sceneGroup = self.view
    
    sceneGroup:insert(backGroup)
	sceneGroup:insert(mainGroup)
	sceneGroup:insert(uiGroup)

	local background = display.newImageRect( backGroup, "images/selector-imgs/box.png", display.contentWidth - 150, display.contentHeight )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	backGroup:insert( background )

	local levelSelectGroup = display.newGroup()

	local xOffset = display.contentCenterX
	local yOffset = 200

	local scrollView = widget.newScrollView{
		left = 0,
		top = 0,
		topPadding = 50,
		bottomPadding = 50,
		width = display.contentWidth - 150,
		height = display.contentHeight,
		hideBackground = true,
		horizontalScrollDisabled = true ,
		verticalScrollDisabled = false ,
}

	local buttons = {}

	for i = 1, base.settings.maxLevels do

		background = display.newImageRect(uiGroup, base.settings.levels[i].background, 200, 200)
		background.x = xOffset
        background.y = yOffset
		backGroup:insert( background )
		scrollView:insert(background)

        buttons[i] = widget.newButton({
			id = tostring(i),
			width = 50,
			height = 33,
			defaultFile = "images/selector-imgs/resumebtn.png",
			onEvent = handleLevelSelect,
        }) 
        buttons[i].x = xOffset
		buttons[i].y = yOffset
		uiGroup:insert( buttons[i] )
		scrollView:insert( uiGroup )

        titleText = display.newText(uiGroup ,base.settings.levels[i].title, 0, 0, native.systemFont, 30)
		titleText:setFillColor(0.2)
		titleText.x = xOffset
		titleText.y = yOffset + 130
		-- scrollView:insert(titleText)

        yOffset = yOffset + 300

    end

	sceneGroup:insert(levelSelectGroup)
	sceneGroup:insert(scrollView)
	levelSelectGroup.x = display.contentCenterX
	levelSelectGroup.y = display.contentCenterY
end

-- On scene show...
function scene:show( event )
	local sceneGroup = self.view
	if ( event.phase == "did" ) then
	end
end

-- On scene hide...
function scene:hide( event )
	local sceneGroup = self.view
    if ( event.phase == "will" ) then
        backGroup:removeSelf()
		uiGroup:removeSelf()
	end
end

-- On scene destroy...
function scene:destroy( event )
	local sceneGroup = self.view   
end

-- Composer scene listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene