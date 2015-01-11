EditboxValidation = {}
EditboxValidation.__index = EditboxValidation

function EditboxValidation.initialize(args)
    local context = CEGUI.toGUIContextEventArgs(args).context

    -- load font and setup default if not loaded via scheme
    local defaultFont = CEGUI.FontManager:getSingleton():createFromFile("DejaVuSans-12.font")
    -- Set default font for the gui context
    context:setDefaultFont(defaultFont)

    CEGUI.SchemeManager:getSingleton():createFromFile("AlfiskoSkin.scheme")
    context:getMouseCursor():setDefaultImage("AlfiskoSkin/MouseArrow")
    local winMgr = CEGUI.WindowManager:getSingleton()

    local root = winMgr:createWindow("DefaultWindow")
    context:setRootWindow(root)

    local wnd = root:createChild("AlfiskoSkin/FrameWindow")
    wnd:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.25,0},{0.25,0}}"))
    wnd:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.5,0},{0.5,0}}"))
    wnd:setText("Editbox Validation Demo")

    local label = wnd:createChild("AlfiskoSkin/Label")
    label:setProperty("HorzFormatting", "WordWrapCentreAligned")
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{1.0,0},{0.2,0}}"))
    label:setText("[[Enter 4 digits into the Editbox. A valid entry will be [colour='FF00FF00']green, [colour='FFFFFFFF']an invalid entry will be [colour='FFFF0000']red [colour='FFFFFFFF']and a partially valid entry will be [colour='FFFFBB11']orange]]")

    local eb = CEGUI.toEditbox(wnd:createChild("AlfiskoSkin/Editbox"))
    eb:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.1,0},{0.25,0}}"))
    eb:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.8,0},{0.15,0}}"))
    eb:subscribeEvent("TextValidityChanged", "EditboxValidation.validationChangeHandler")

    eb:setValidationString("[0-9]{4}")
    eb:activate()
end

function EditboxValidation.validationChangeHandler(args)
    local ra = CEGUI.toRegexMatchStateEventArgs(args)
    local eb = CEGUI.toEditbox(ra.window)

    local state = ra.matchState
    if state == CEGUI.RegexMatcher.MS_INVALID then
        eb:setProperty("NormalTextColour", "FFFF0000")
    elseif state == CEGUI.RegexMatcher.MS_PARTIAL then
        eb:setProperty("NormalTextColour", "FFFFBB11")
    elseif state == CEGUI.RegexMatcher.MS_VALID then
        eb:setProperty("NormalTextColour", "FF00FF00")
    end
    return true
end

function EditboxValidation.quitButtonHandler(args)
    return true
end
