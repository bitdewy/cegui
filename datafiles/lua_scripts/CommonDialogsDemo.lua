CommonDialogsDemo = {}
CommonDialogsDemo.__index = CommonDialogsDemo

function CommonDialogsDemo.initialize(args)
	local context = CEGUI.toGUIContextEventArgs(args).context

	-- load font and setup default if not loaded via scheme
	local fontMgr = CEGUI.FontManager:getSingleton()
    local defaultFont = fontMgr:createFromFile("DejaVuSans-12.font")
    
    -- Set default font for the gui context
    context:setDefaultFont(defaultFont)

    -- load resources and set up system defaults
    local schemeMgr = CEGUI.SchemeManager:getSingleton()
    schemeMgr:createFromFile("VanillaSkin.scheme")
    schemeMgr:createFromFile("VanillaCommonDialogs.scheme")

    context:getMouseCursor():setDefaultImage("Vanilla-Images/MouseArrow")

    -- set up the root window / gui sheet
    local winMgr = CEGUI.WindowManager:getSingleton()
    local root = winMgr:createWindow("DefaultWindow", "Root")
    context:setRootWindow(root)

    -- create container window for the demo
    local wnd = CEGUI.toFrameWindow(winMgr:createWindow("Vanilla/FrameWindow"))
    root:addChild(wnd)

    wnd:setAlwaysOnTop(true)

    wnd:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.05,0},{0.25, 0}}"))
    wnd:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.5,0},{0.5, 0}}"))
    wnd:setText("Common Dialogs Demo - Main Window")
    wnd:setCloseButtonEnabled(false)

    -- Add a colour picker & label
    local colourPickerLabel = winMgr:createWindow("Vanilla/Label")
    wnd:addChild(colourPickerLabel)
    colourPickerLabel:setSize(CEGUI.PropertyHelper:stringToUSize("{{1.0,0},{0.0, 30}}"))
    colourPickerLabel:setText("Open the colour picker by clicking on the respective box:")

    local colourPicker = winMgr:createWindow("Vanilla/ColourPicker")
    wnd:addChild(colourPicker)
    colourPicker:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0,20},{0, 40}}"))
    colourPicker:setSize(CEGUI.PropertyHelper:stringToUSize("{{0,100},{0, 30}}"))
    -- TODO downcast
    -- colourPicker:setColour(CEGUI.PropertyHelper:stringToColour("FF00007F"))

    colourPicker = winMgr:createWindow("Vanilla/ColourPicker")
    wnd:addChild(colourPicker)
    colourPicker:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0,20},{0, 80}}"))
    colourPicker:setSize(CEGUI.PropertyHelper:stringToUSize("{{0,100},{0, 30}}"))
    -- TODO downcast
    -- colourPicker:setColour(CEGUI.PropertyHelper:stringToColour("00FFFF00"))

    colourPicker = winMgr:createWindow("Vanilla/ColourPicker")
    wnd:addChild(colourPicker)
    colourPicker:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0,20},{0, 120}}"))
    colourPicker:setSize(CEGUI.PropertyHelper:stringToUSize("{{0,100},{0, 30}}"))
    -- TODO downcast
    -- colourPicker:setColour(CEGUI.PropertyHelper:stringToColour("666600FF"))

    colourPicker = winMgr:createWindow("Vanilla/ColourPicker")
    wnd:addChild(colourPicker)
    colourPicker:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0,20},{0, 160}}"))
    colourPicker:setSize(CEGUI.PropertyHelper:stringToUSize("{{0,100},{0, 30}}"))
    -- TODO downcast
    -- colourPicker:setColour(CEGUI.PropertyHelper:stringToColour("FF337FEE"))
end
