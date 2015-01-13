TextDemo = {}
TextDemo.__index = TextDemo

local context

function TextDemo.initialize(args)
    context = CEGUI.toGUIContextEventArgs(args).context

    -- we will make extensive use of the WindowManager.
    local winMgr = CEGUI.WindowManager:getSingleton()

    -- load font and setup default if not loaded via scheme
    local defaultFont = CEGUI.FontManager:getSingleton():createFromFile("DejaVuSans-12.font")
    -- Set default font for the gui context
    context:setDefaultFont(defaultFont)

    -- load scheme and set up defaults
    CEGUI.SchemeManager:getSingleton():createFromFile("TaharezLook.scheme")
    context:getMouseCursor():setDefaultImage("TaharezLook/MouseArrow")

    -- load an image to use as a background
    if not CEGUI.ImageManager:getSingleton():isDefined("SpaceBackgroundImage") then
        CEGUI.ImageManager:getSingleton():addFromImageFile("SpaceBackgroundImage", "SpaceBackground.jpg")
    end
    -- here we will use a StaticImage as the root, then we can use it to place a background image
    local background = winMgr:createWindow("TaharezLook/StaticImage", "background_wnd")
    -- set position and size
    background:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0,0},{0,0}}"))
    background:setSize(CEGUI.PropertyHelper:stringToUSize("{{1,0},{1,0}}"))
    -- disable frame and standard background
    background:setProperty("FrameEnabled", "false")
    background:setProperty("BackgroundEnabled", "false")
    -- set the background image
    background:setProperty("Image", "SpaceBackgroundImage")
    -- install this as the root GUI sheet
    context:setRootWindow(background)

    -- Load our layout as a basic
    background:addChild(winMgr:loadLayoutFromFile("TextDemo.layout"))

    -- Init the seperate blocks which make up this sample
    TextDemo.initStaticText()
    TextDemo.initSingleLineEdit()
    TextDemo.initMultiLineEdit()

    -- Quit button
    TextDemo.subscribeEvent("Root/TextDemo/Quit", "Clicked", "TextDemo.quit")

    -- Success (so far)
    return true
end

function TextDemo.initStaticText()
    -- Name, Group, Selected
    TextDemo.initRadio("Root/TextDemo/StaticGroup/HorzLeft", 0, true)
    TextDemo.initRadio("Root/TextDemo/StaticGroup/HorzRight", 0, false)
    TextDemo.initRadio("Root/TextDemo/StaticGroup/HorzCentered", 0, false)
    -- New group!
    TextDemo.initRadio("Root/TextDemo/StaticGroup/VertTop", 1, true)
    TextDemo.initRadio("Root/TextDemo/StaticGroup/VertBottom", 1, false)
    TextDemo.initRadio("Root/TextDemo/StaticGroup/VertCentered", 1, false)
    --
    -- Events
    --
    -- Word-wrap checkbox (we can't re-use a handler struct for the last argument!!)
    TextDemo.subscribeEvent("Root/TextDemo/StaticGroup/Wrap", "SelectStateChanged", "TextDemo.formatChangedHandler")
    TextDemo.subscribeEvent("Root/TextDemo/StaticGroup/HorzLeft", "SelectStateChanged", "TextDemo.formatChangedHandler")
    TextDemo.subscribeEvent("Root/TextDemo/StaticGroup/HorzRight", "SelectStateChanged", "TextDemo.formatChangedHandler")
    TextDemo.subscribeEvent("Root/TextDemo/StaticGroup/HorzCentered", "SelectStateChanged", "TextDemo.formatChangedHandler")
    TextDemo.subscribeEvent("Root/TextDemo/StaticGroup/VertTop", "SelectStateChanged", "TextDemo.formatChangedHandler")
    TextDemo.subscribeEvent("Root/TextDemo/StaticGroup/VertBottom", "SelectStateChanged", "TextDemo.formatChangedHandler")
    TextDemo.subscribeEvent("Root/TextDemo/StaticGroup/VertCentered", "SelectStateChanged", "TextDemo.formatChangedHandler")
end

function TextDemo.initSingleLineEdit()

    local root = context:getRootWindow()
    -- Only accepts digits for the age field
    if root:isChild("Root/TextDemo/SingleLineGroup/editAge") then
        CEGUI.toEditbox(root:getChild("Root/TextDemo/SingleLineGroup/editAge")):setValidationString("[0-9]*")
    end
    -- Set password restrictions
    if root:isChild("Root/TextDemo/SingleLineGroup/editPasswd") then
        local passwd = CEGUI.toEditbox(root:getChild("Root/TextDemo/SingleLineGroup/editPasswd"))
        passwd:setValidationString("[A-Za-z0-9]*")
        -- Render masked
        passwd:setTextMasked(true)
    end
end

function TextDemo.initMultiLineEdit()
    -- Scrollbar checkbox
    TextDemo.subscribeEvent("Root/TextDemo/MultiLineGroup/forceScroll", "SelectStateChanged", "TextDemo.vertScrollChangedHandler")
end

function TextDemo.initRadio(radio, group, selected)
    local root = context:getRootWindow()
    if root:isChild(radio) then
        local button = CEGUI.toRadioButton(root:getChild(radio))
        button:setGroupID(group)
        button:setSelected(selected)
    end
end

function TextDemo.subscribeEvent(widget, event, method)
    local root = context:getRootWindow()
    if root:isChild(widget) then
        local window = root:getChild(widget)
        window:subscribeEvent(event, method)
    end
end

function TextDemo.isRadioSelected(radio)
    local root = context:getRootWindow()
    -- Check
    if root:isChild(radio) then
        local button = CEGUI.toRadioButton(root:getChild(radio))
        return button:isSelected()
    end
    return false
end

function TextDemo.isCheckboxSelected(checkbox)
    local root = context:getRootWindow()
    -- Check
    if root:isChild(checkbox) then
        local button = CEGUI.toToggleButton(root:getChild(checkbox))
        return button:isSelected()
    end
    return false
end

function TextDemo.formatChangedHandler(args)
    local root = context:getRootWindow()
    if root:isChild("Root/TextDemo/StaticGroup/StaticText") then
        -- and also the static text for which we will set the formatting options
        local st = root:getChild("Root/TextDemo/StaticGroup/StaticText")

        -- handle vertical formatting settings
        if TextDemo.isRadioSelected("Root/TextDemo/StaticGroup/VertTop") then
            st:setProperty("VertFormatting", "TopAligned")
        elseif TextDemo.isRadioSelected("Root/TextDemo/StaticGroup/VertBottom") then
            st:setProperty("VertFormatting", "BottomAligned")
        elseif TextDemo.isRadioSelected("Root/TextDemo/StaticGroup/VertCentered") then
            st:setProperty("VertFormatting", "CentreAligned")
        end

        -- handle horizontal formatting settings
        local wrap = TextDemo.isCheckboxSelected("Root/TextDemo/StaticGroup/Wrap")

        if TextDemo.isRadioSelected("Root/TextDemo/StaticGroup/HorzLeft") then
            st:setProperty("HorzFormatting", wrap and "WordWrapLeftAligned" or "LeftAligned")
        elseif TextDemo.isRadioSelected("Root/TextDemo/StaticGroup/HorzRight") then
            st:setProperty("HorzFormatting", wrap and "WordWrapRightAligned" or "RightAligned")
        elseif TextDemo.isRadioSelected("Root/TextDemo/StaticGroup/HorzCentered") then
            st:setProperty("HorzFormatting", wrap and "WordWrapCentreAligned" or "CentreAligned")
        end
    end

    -- event was handled
    return true
end

function TextDemo.vertScrollChangedHandler(args)
    local root = context:getRootWindow()

    if root:isChild("Root/TextDemo/MultiLineGroup/editMulti") then
        local multiEdit = CEGUI.toMultiLineEditbox(root:getChild("Root/TextDemo/MultiLineGroup/editMulti"))
        -- Use setter for a change
        multiEdit:setShowVertScrollbar(TextDemo.isCheckboxSelected("Root/TextDemo/MultiLineGroup/forceScroll"))
    end

    -- event was handled
    return true
end

function TextDemo.quit(args)
    -- event was handled
    return true
end
