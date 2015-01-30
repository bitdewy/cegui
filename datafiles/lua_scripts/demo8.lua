-----------------------------------------
-- Start of handler functions
-----------------------------------------
require("Echo")

local model = require("Demo8Data")
-- load our demo8 window layout
local windows = require("Echo.Window").loadLayout("Demo8.layout")
local root = windows.root

-----------------------------------------
-- Alpha slider handler (not used!)
-----------------------------------------
function sliderHandler(args)
    root:setAlpha(CEGUI.toSlider(CEGUI.toWindowEventArgs(args).window):getCurrentValue())
end

-----------------------------------------
-- Handler to slide pane
--
-- Here we move the 'Demo8' sheet window
-- and re-position the scrollbar
-----------------------------------------
function panelSlideHandler(args)
    local scroller = CEGUI.toScrollbar(CEGUI.toWindowEventArgs(args).window)
    local demoWnd = windows.demoWnd

    local parentPixelHeight = demoWnd:getParent():getPixelSize().height
    local relHeight = CEGUI.CoordConverter:asRelative(demoWnd:getHeight(), parentPixelHeight)

    scroller:setPosition(CEGUI.UVector2(CEGUI.UDim(0,0), CEGUI.UDim(scroller:getScrollPosition() / relHeight,0)))
    demoWnd:setPosition(CEGUI.UVector2(CEGUI.UDim(0,0), CEGUI.UDim(-scroller:getScrollPosition(),0)))
end

-----------------------------------------
-- Handler to set preview colour when
-- colour selector scrollers change
-----------------------------------------
function colourChangeHandler(args)    
    local r = model:getProperty("r")
    local g = model:getProperty("g")
    local b = model:getProperty("b")
    local col = CEGUI.Colour:new_local(r, g, b, 1)
    local crect = CEGUI.ColourRect(col)
    model:setProperty("colour", CEGUI.PropertyHelper:colourRectToString(crect))
end


-----------------------------------------
-- Handler to add an item to the box
-----------------------------------------
function addItemHandler(args)
    local text = windows.editBox:getText()
    local cols = CEGUI.PropertyHelper:stringToColourRect(model:getProperty("colour"))

    local newItem = CEGUI.createListboxTextItem(text, 0, nil, false, true)
    newItem:setSelectionBrushImage("TaharezLook/MultiListSelectionBrush")
    newItem:setSelectionColours(cols)

    windows.listBox:addItem(newItem)
end

-----------------------------------------
-- Script Entry Point
-----------------------------------------
function initialize(args)
    local context = CEGUI.toGUIContextEventArgs(args).context
    local guiSystem = CEGUI.System:getSingleton()
    local schemeMgr = CEGUI.SchemeManager:getSingleton()

    -- load our demo8 scheme
    schemeMgr:createFromFile("TaharezLook.scheme");

    -- set the layout as the root
    context:setRootWindow(root)
    -- set default mouse cursor
    context:getMouseCursor():setDefaultImage("TaharezLook/MouseArrow")
    -- set the Tooltip type
    context:setDefaultTooltipType("TaharezLook/Tooltip")
end
