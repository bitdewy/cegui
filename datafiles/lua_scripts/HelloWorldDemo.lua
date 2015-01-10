-----------------------------------------
-- Script Entry Point
-----------------------------------------
HelloWorldDemo = {}
HelloWorldDemo.__index = HelloWorldDemo

function HelloWorldDemo.initialize(args)
    local context = CEGUI.toGUIContextEventArgs(args).context
    local schemeMgr = CEGUI.SchemeManager:getSingleton()
    
    -- CEGUI relies on various systems being set-up, so this is what we do
    -- here first.

    -- The first thing to do is load a CEGUI 'scheme' this is basically a file
    -- that groups all the required resources and definitions for a particular
    -- skin so they can be loaded / initialised easily

    -- So, we use the SchemeManager singleton to load in a scheme that loads the
    -- imagery and registers widgets for the TaharezLook skin.  This scheme also
    -- loads in a font that gets used as the system default.

    schemeMgr:createFromFile("TaharezLook.scheme")

    -- The next thing we do is to set a default mouse cursor image.  This is
    -- not strictly essential, although it is nice to always have a visible
    -- cursor if a window or widget does not explicitly set one of its own.

    -- The TaharezLook Imageset contains an Image named "MouseArrow" which is
    -- the ideal thing to have as a defult mouse cursor image.

    context:getMouseCursor():setDefaultImage("TaharezLook/MouseArrow")

    -- Now the system is initialised, we can actually create some UI elements, for
    -- this first example, a full-screen 'root' window is set as the active GUI
    -- sheet, and then a simple frame window will be created and attached to it.

    -- All windows and widgets are created via the WindowManager singleton.

    local winMgr = CEGUI.WindowManager:getSingleton()

    -- Here we create a "DefaultWindow".  This is a native type, that is, it does
    -- not have to be loaded via a scheme, it is always available.  One common use
    -- for the DefaultWindow is as a generic container for other windows.  Its
    -- size defaults to 1.0f x 1.0f using the Relative metrics mode, which means
    -- when it is set as the root GUI sheet window, it will cover the entire display.
    -- The DefaultWindow does not perform any rendering of its own, so is invisible.

    -- Create a DefaultWindow called 'Root'.

    local root = winMgr:createWindow("DefaultWindow", "Root")

    local fontMgr = CEGUI.FontManager:getSingleton()

    -- load font and setup default if not loaded via scheme
    local defaultFont = fontMgr:createFromFile("DejaVuSans-12.font")

    -- Set default font for the gui context
    context:setDefaultFont(defaultFont)

    -- Set the root window as root of our GUI Context
    context:setRootWindow(root);

    -- A FrameWindow is a window with a frame and a titlebar which may be moved around
    -- and resized.

    -- Create a FrameWindow in the TaharezLook style, and name it 'Demo Window'
    local wnd = winMgr:createWindow("TaharezLook/FrameWindow", "Demo Window")

    -- Here we attach the newly created FrameWindow to the previously created
    -- DefaultWindow which we will be using as the root of the displayed gui.
    root:addChild(wnd)

    -- Windows are in Relative metrics mode by default.  This means that we can
    -- specify sizes and positions without having to know the exact pixel size
    -- of the elements in advance.  The relative metrics mode co-ordinates are
    -- relative to the parent of the window where the co-ordinates are being set.
    -- This means that if 0.5f is specified as the width for a window, that window
    -- will be half as its parent window.

    -- Here we set the FrameWindow so that it is half the size of the display,
    -- and centered within the display.
    wnd:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.25,0},{0.25,0}}"))
    wnd:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.5,0},{0.5,0}}"))

    -- now we set the maximum and minum sizes for the new window.  These are
    -- specified using relative co-ordinates, but the important thing to note
    -- is that these settings are aways relative to the display rather than the
    -- parent window.

    -- here we set a maximum size for the FrameWindow which is equal to the size
    -- of the display, and a minimum size of one tenth of the display.
    wnd:setMaxSize(CEGUI.PropertyHelper:stringToUSize("{{1.0,0},{1.0,0}}"))
    wnd:setMinSize(CEGUI.PropertyHelper:stringToUSize("{{0.1,0},{0.1,0}}"))

    -- As a final step in the initialisation of our sample window, we set the window's
    -- text to "Hello World!", so that this text will appear as the caption in the
    -- FrameWindow's titlebar.
    wnd:setText("Hello World!")

    wnd:subscribeEvent("MouseClick", "HelloWorldDemo.handleHelloWorldClicked")
end

function HelloWorldDemo.handleHelloWorldClicked(args)
    print("Hello World!")
end
