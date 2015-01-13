ScrollablePane = {}
ScrollablePane.__index = ScrollablePane

local pane

function ScrollablePane.initialize(args)
	local context = CEGUI.toGUIContextEventArgs(args).context

    -- this sample will use WindowsLook
    CEGUI.SchemeManager:getSingleton():createFromFile("WindowsLook.scheme")

    -- load the default font
    local font = CEGUI.FontManager:getSingleton():createFromFile("DejaVuSans-12-NoScale.font")
    context:setDefaultFont(font)

    -- set the mouse cursor
    context:getMouseCursor():setDefaultImage("WindowsLook/MouseArrow")

    -- set the default tooltip type
    context:setDefaultTooltipType("WindowsLook/Tooltip")

    -- create a root window
    -- this will be a static, to give a nice app'ish background
    local winMgr = CEGUI.WindowManager:getSingleton()
    local root = winMgr:createWindow("WindowsLook/Static")
    root:setProperty("FrameEnabled", "false")
    root:setSize(CEGUI.PropertyHelper:stringToUSize("{{1.0,0},{1.0,0}}"))
    root:setProperty("BackgroundColours", "tl:FFBFBFBF tr:FFBFBFBF bl:FFBFBFBF br:FFBFBFBF")

    -- root window will take care of hotkeys
    root:subscribeEvent("KeyDown", "ScrollablePane.hotkeysHandler")
    context:setRootWindow(root)

    -- create a menubar.
    -- this will fit in the top of the screen and have options for the demo
    local bar_bottom = CEGUI.PropertyHelper:stringToUDim("{0,"..font:getLineSpacing(1.5).." }")
    local zero = CEGUI.PropertyHelper:stringToUDim("{0,0}")
    local one = CEGUI.PropertyHelper:stringToUDim("{1,0}")
    local bar = winMgr:createWindow("WindowsLook/Menubar");

    bar:setArea(zero,zero,one,bar_bottom);
    root:addChild(bar)

    -- fill out the menubar
    ScrollablePane.createMenu(bar)

    -- create a scrollable pane for our demo content
    pane = CEGUI.toScrollablePane(winMgr:createWindow("WindowsLook/ScrollablePane"))
    pane:setArea(CEGUI.PropertyHelper:stringToURect("{{0,0},{0,"..font:getLineSpacing(1.5).."},{1,0},{1,0}}"))
    -- this scrollable pane will be a kind of virtual desktop in the sense that it's bigger than
    -- the screen. 3000 x 3000 pixels
    pane:setContentPaneAutoSized(false)
    pane:setContentPaneArea(CEGUI.Rectf(0, 0, 5000, 5000))
    root:addChild(pane)

    -- add a dialog to this pane so we have something to drag around :)
    local dlg = winMgr:createWindow("WindowsLook/FrameWindow")
    dlg:setMinSize(CEGUI.PropertyHelper:stringToUSize("{{0,250},{0,100}}"))
    dlg:setSize(CEGUI.PropertyHelper:stringToUSize("{{0,250},{0,100}}"))
    dlg:setText("Drag me around")
    pane:addChild(dlg)

    return true
end

-- /*************************************************************************
--     Creates the menu bar and fills it up :)
-- *************************************************************************/
function ScrollablePane.createMenu(bar)
    -- file menu item
    local winMgr = CEGUI.WindowManager:getSingleton()
    local file = winMgr:createWindow("WindowsLook/MenuItem")
    file:setText("File")
    bar:addChild(file)
    
    -- file popup
    local popup = winMgr:createWindow("WindowsLook/PopupMenu")
    file:addChild(popup)
    
    -- quit item in file menu
    local item = winMgr:createWindow("WindowsLook/MenuItem")
    item:setText("Quit")
    item:subscribeEvent("Clicked", "ScrollablePane.fileQuit")
    popup:addChild(item)

    -- demo menu item
    local demo = winMgr:createWindow("WindowsLook/MenuItem")
    demo:setText("Demo")
    bar:addChild(demo)

    -- demo popup
    popup = winMgr:createWindow("WindowsLook/PopupMenu")
    demo:addChild(popup)

    -- demo : new window
    item = winMgr:createWindow("WindowsLook/MenuItem")
    item:setText("New dialog")
    item:setTooltipText("Hotkey: Space")
    item:subscribeEvent("Clicked", "ScrollablePane.demoNewDialog")
    popup:addChild(item)
end

-- /*************************************************************************
--     Handler for the 'Demo : New dialog' menu item
-- *************************************************************************/
function ScrollablePane.demoNewDialog(args)
    -- add a dialog to this pane so we have some more stuff to drag around :)
	local winMgr = CEGUI.WindowManager:getSingleton()
    local dlg = winMgr:createWindow("WindowsLook/FrameWindow")
    dlg:setMinSize(CEGUI.PropertyHelper:stringToUSize("{{0,200},{0,100}}"))
    dlg:setSize(CEGUI.PropertyHelper:stringToUSize("{{0,200},{0,100}}"))
    dlg:setText("Drag me around too!")
    
    -- we put this in the center of the viewport into the scrollable pane
    -- UVector2 uni_center = CEGUI.PropertyHelper:stringToUVertor2("{{0.5,0},{0.5,0}}")
    -- URGENT FIXME!
    -- Vector2f center = CoordConverter:windowToScreen(*d_root, uni_center)
    -- Vector2f target = CoordConverter::screenToWindow(*d_pane:getContentPane(), center)
    -- dlg:setPosition(UVector2(UDim(0,target.d_x-100), UDim(0,target.d_y-50)))

    pane:addChild(dlg)
    
    return true
end

-- /*************************************************************************
--     Handler for global hotkeys
-- *************************************************************************/
function ScrollablePane.hotkeysHandler(args)
    local k = CEGUI.toKeyEventArgs(args).scancode

    -- space is a hotkey for demo : new dialog
    if k == CEGUI.Key.Space then
        -- this handler does not use the event args at all so this is fine :)
        -- though maybe a bit hackish...
        demoNewDialog(args)

    -- no hotkey found? event not used...
    else
        return false
    end
    return true
end

function ScrollablePane.fileQuit(args)
	return true
end