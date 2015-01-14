TabControlDemo = {}
TabControlDemo.__index = TabControlDemo

local SKIN = "TaharezLook"
-- for this to work you'll have to change the .layout files
--#define SKIN "WindowsLook"

local context

local PageText = {
    "This is page three",
    "And this is page four, it's not too different from page three, isn't it?",
    "Yep, you guessed, this is page five",
    "And this is page six",
    "Seven",
    "Eight",
    "Nine. Quite boring, isn't it?",
    "Ten",
    "Eleven",
    "Twelve",
    "Thirteen",
    "Fourteen",
    "Fifteen",
    "And, finally, sixteen. Congrats, you found the last page!",
}

-- Sample sub-class for ListboxTextItem that auto-sets the selection brush
-- image.  This saves doing it manually every time in the code.
local MyListItem = function (text)
	local item = CEGUI.createListboxTextItem(text)
	item:setSelectionBrushImage(SKIN.."/MultiListSelectionBrush")
	return item
end

-- method to initialse the samples windows and events.
function TabControlDemo.initialize(args)

    context = CEGUI.toGUIContextEventArgs(args).context

    -- load font and setup default if not loaded via scheme
    local defaultFont = CEGUI.FontManager:getSingleton():createFromFile("DejaVuSans-12.font")
    -- Set default font for the gui context
    context:setDefaultFont(defaultFont)

    -- we will use of the WindowManager.
    local winMgr = CEGUI.WindowManager:getSingleton()

    -- load scheme and set up defaults
    CEGUI.SchemeManager:getSingleton():createFromFile(SKIN..".scheme")
    context:getMouseCursor():setDefaultImage(SKIN.."/MouseArrow")

    -- load an image to use as a background
    if not CEGUI.ImageManager:getSingleton():isDefined("SpaceBackgroundImage") then
        CEGUI.ImageManager:getSingleton():addFromImageFile("SpaceBackgroundImage", "SpaceBackground.jpg")
    end

    -- here we will use a StaticImage as the root, then we can use it to place a background image
    local background = winMgr:createWindow(SKIN.."/StaticImage")
    -- set area rectangle
    background:setArea(CEGUI.PropertyHelper:stringToURect("{{0,0},{0,0},{1,0},{1,0}}"))
    -- disable frame and standard background
    background:setProperty("FrameEnabled", "false")
    background:setProperty("BackgroundEnabled", "false")
    -- set the background image
    background:setProperty("Image", "SpaceBackgroundImage")
    -- install this as the root GUI sheet
    context:setRootWindow(background)

    -- set tooltip styles (by default there is none)
    context:setDefaultTooltipType(SKIN.."/Tooltip")

    -- load some demo windows and attach to the background 'root'
    background:addChild(winMgr:loadLayoutFromFile("TabControlDemo.layout"))

    local tc = CEGUI.toTabControl(background:getChild("Frame/TabControl"))

    -- Add some pages to tab control
    tc:addTab(winMgr:loadLayoutFromFile("TabPage1.layout"))
    tc:addTab(winMgr:loadLayoutFromFile("TabPage2.layout"))

    CEGUI.toPushButton(
        background:getChild("Frame/TabControl/Page1/AddTab")):subscribeEvent(
            "Clicked",
            "TabControlDemo.handleAddTab")

    -- Click to visit this tab
    CEGUI.toPushButton(
        background:getChild("Frame/TabControl/Page1/Go")):subscribeEvent(
            "Clicked",
            "TabControlDemo.handleGoto")

    -- Click to make this tab button visible (when scrolling is required)
    CEGUI.toPushButton(
        background:getChild("Frame/TabControl/Page1/Show")):subscribeEvent(
            "Clicked",
            "TabControlDemo.handleShow")

    CEGUI.toPushButton(
        background:getChild("Frame/TabControl/Page1/Del")):subscribeEvent(
            "Clicked",
            "TabControlDemo.handleDel")

    local rb = CEGUI.toRadioButton(
                          background:getChild("Frame/TabControl/Page1/TabPaneTop"))
    rb:setSelected(tc:getTabPanePosition() == CEGUI.TabControl.Top)
    rb:subscribeEvent(
        "SelectStateChanged",
        "TabControlDemo.handleTabPanePos")

    rb = CEGUI.toRadioButton(
             background:getChild("Frame/TabControl/Page1/TabPaneBottom"))
    rb:setSelected(tc:getTabPanePosition() == CEGUI.TabControl.Bottom)
    rb:subscribeEvent(
        "SelectStateChanged",
        "TabControlDemo.handleTabPanePos")

    local sb = CEGUI.toScrollbar(
                        background:getChild("Frame/TabControl/Page1/TabHeight"))
    sb:setScrollPosition(tc:getTabHeight().offset)
    sb:subscribeEvent(
        "ScrollPositionChanged",
        "TabControlDemo.handleTabHeight")

    sb = CEGUI.toScrollbar(
             background:getChild("Frame/TabControl/Page1/TabPadding"))
    sb:setScrollPosition(tc:getTabTextPadding().offset)
    sb:subscribeEvent(
        "ScrollPositionChanged",
        "TabControlDemo.handleTabPadding")

    TabControlDemo.refreshPageList()

    -- From now on, we don't rely on the exceptions anymore, but perform nice (and recommended) checks
    -- ourselves.

    return true
end

function TabControlDemo.refreshPageList()

    local root = context:getRootWindow()
    -- Check if the windows exists
    local lbox
    local tc

    if root:isChild("Frame/TabControl/Page1/PageList") then
        lbox = CEGUI.toListbox(root:getChild("Frame/TabControl/Page1/PageList"))
    end

    if root:isChild("Frame/TabControl") then
        tc = CEGUI.toTabControl(root:getChild("Frame/TabControl"))
    end

    if lbox and tc then
        lbox:resetList()

        for i = 0, tc:getTabCount() - 1 do
            lbox:addItem(MyListItem(tc:getTabContentsAtIndex(i):getName()))
        end
    end
end

function TabControlDemo.handleTabPanePos(args)
    local tpp

    local id = CEGUI.toWindowEventArgs(args).window:getID()
    
    if id == CEGUI.TabControl.Top or id == CEGUI.TabControl.Bottom then
        tpp = id
    else
        return false
    end

    -- Check if the window exists
    local root = context:getRootWindow()

    if root:isChild("Frame/TabControl") then
        CEGUI.toTabControl(root:getChild("Frame/TabControl")):setTabPanePosition(tpp)
    end

    return true
end

function TabControlDemo.handleTabHeight(args)
    local sb = CEGUI.toScrollbar(CEGUI.toWindowEventArgs(args).window)

    -- Check if the window exists
    local root = context:getRootWindow()

    if root:isChild("Frame/TabControl") then
        CEGUI.toTabControl(root:getChild("Frame/TabControl")):setTabHeight(CEGUI.PropertyHelper:stringToUDim("{0,"..sb:getScrollPosition().."}"))
	end
    -- The return value mainly sais that we handled it, not if something failed.
    return true
end

function TabControlDemo.handleTabPadding(args)
    local sb = CEGUI.toScrollbar(CEGUI.toWindowEventArgs(args).window)

    -- Check if the window exists
    local root = context:getRootWindow()

    if root:isChild("Frame/TabControl") then
        CEGUI.toTabControl(root:getChild("Frame/TabControl")):setTabTextPadding(CEGUI.PropertyHelper:stringToUDim("{0,"..sb:getScrollPosition().."}"))
    end

    return true
end

function TabControlDemo.handleAddTab(args)
	local root = context:getRootWindow()

    -- Check if the window exists
    if root:isChild("Frame/TabControl") then
        local tc = CEGUI.toTabControl(root:getChild("Frame/TabControl"))

        -- Add some tab buttons once
        for num = 3, 16 do
            local pgname
            pgname = "Page"..num

            if not root:isChild("Frame/TabControl/"..pgname) then
                local pg = CEGUI.WindowManager:getSingleton():loadLayoutFromFile("TabPage.layout")
                pg:setName(pgname)

	            -- This window has just been created while loading the layout
	            if pg:isChild("Text") then
	                local txt = pg:getChild("Text")
	                txt:setText(PageText [num - 2])

	                pg:setText(pgname)
	                tc:addTab(pg)

	                TabControlDemo.refreshPageList()
	                break
                end
            end     
        end
    end

    return true
end

function TabControlDemo.handleGoto(args)
    local root = context:getRootWindow()
    -- Check if the windows exists
    local lbox
    local tc

    if root:isChild("Frame/TabControl/Page1/PageList") then
        lbox = CEGUI.toListbox(root:getChild("Frame/TabControl/Page1/PageList"))
    end

    if root:isChild("Frame/TabControl") then
        tc = CEGUI.toTabControl(root:getChild("Frame/TabControl"))
    end

    if lbox and tc then
        local lbi = lbox:getFirstSelectedItem()

        if lbi then
            tc:setSelectedTab(lbi:getText())
        end
    end

    return true
end

function TabControlDemo.handleShow(args)
    local root = context:getRootWindow()
    -- Check if the windows exists
    local lbox
    local tc

    if root:isChild("Frame/TabControl/Page1/PageList") then
        lbox = CEGUI.toListbox(root:getChild("Frame/TabControl/Page1/PageList"))
    end

    if root:isChild("Frame/TabControl") then
        tc = CEGUI.toTabControl(root:getChild("Frame/TabControl"))
    end

    if lbox and tc then
        local lbi = lbox:getFirstSelectedItem()

        if lbi then
            tc:makeTabVisible(lbi:getText())
        end
    end

    return true
end

function TabControlDemo.handleDel()
    local root = context:getRootWindow()
    -- Check if the windows exists
    local lbox
    local tc

    if root:isChild("Frame/TabControl/Page1/PageList") then
        lbox = CEGUI.toListbox(root:getChild("Frame/TabControl/Page1/PageList"))
    end

    if root:isChild("Frame/TabControl") then
        tc = CEGUI.toTabControl(root:getChild("Frame/TabControl"))
    end

    if lbox and tc then
        local lbi = lbox:getFirstSelectedItem()

        if lbi then
            local content = tc:getTabContents(lbi:getText())
            tc:removeTab(lbi:getText())
            -- Remove the actual window from Cegui
            CEGUI.WindowManager:getSingleton():destroyWindow(content)

            TabControlDemo.refreshPageList()
        end
    end

    return true
end
