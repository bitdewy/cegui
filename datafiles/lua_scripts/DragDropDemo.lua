DragDropDemo = {}
DragDropDemo.__index = DragDropDemo

function DragDropDemo.initialize(args)
    local context = CEGUI.toGUIContextEventArgs(args).context

    -- load windows look
    CEGUI.SchemeManager:getSingleton():createFromFile("WindowsLook.scheme")

    -- load font and setup default if not loaded via scheme
    local defaultFont = CEGUI.FontManager:getSingleton():createFromFile("DejaVuSans-12.font")
    -- Set default font for the gui context
    context:setDefaultFont(defaultFont)

    -- set up defaults
    context:getMouseCursor():setDefaultImage("WindowsLook/MouseArrow")

    -- load the drive icons imageset
    CEGUI.ImageManager:getSingleton():loadImageset("DriveIcons.imageset")

    -- load the initial layout
    context:setRootWindow(
        CEGUI.WindowManager:getSingleton():loadLayoutFromFile("DragDropDemo.layout"))
end

function DragDropDemo.handle_ItemDropped(args)

    -- cast the args to the 'real' type so we can get access to extra fields
    local dd_args = CEGUI.toDragDropEventArgs(args)

    if dd_args.window:getChildCount() == 0 then
        --add dragdrop item as child of target if target has no item already
        dd_args.window:addChild(dd_args.dragDropItem)
        -- Now we must reset the item position from it's 'dropped' location,
        -- since we're now a child of an entirely different window
        dd_args.dragDropItem:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.05,0},{0.05,0}}"))
    end
    return true
end

function DragDropDemo.handle_CloseButton(args)
    return true
end
