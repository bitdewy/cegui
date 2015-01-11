Demo6 = {}
Demo6.__index = Demo6

function Demo6.initialize(args)
    local context = CEGUI.toGUIContextEventArgs(args).context

    -- we will use of the WindowManager.
    local winMgr = CEGUI.WindowManager:getSingleton()

    -- load scheme and set up defaults
    CEGUI.SchemeManager:getSingleton():createFromFile("TaharezLook.scheme")
    context:getMouseCursor():setDefaultImage("TaharezLook/MouseArrow")

    -- load font and setup default if not loaded via scheme
    local defaultFont = CEGUI.FontManager:getSingleton():createFromFile("DejaVuSans-12.font")
    -- Set default font for the gui context
    context:setDefaultFont(defaultFont)

    -- load an image to use as a background
    local imgMgr = CEGUI.ImageManager:getSingleton()
    if not imgMgr:isDefined("SpaceBackgroundImage") then
        imgMgr:addFromImageFile("SpaceBackgroundImage", "SpaceBackground.jpg")
    end

    -- here we will use a StaticImage as the root, then we can use it to place a background image
    local background = winMgr:createWindow("TaharezLook/StaticImage", "root_wnd")
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

    -- do demo stuff
    Demo6.createDemoWindows(background)
    Demo6.initDemoEventWiring(background)
end

--/*************************************************************************
--    Create the windows and widgets for the demo
--*************************************************************************/
function Demo6.createDemoWindows(root)
    local winMgr = CEGUI.WindowManager:getSingleton()

    -- create the main list.
    local mcl = CEGUI.toMultiColumnList(winMgr:createWindow("TaharezLook/MultiColumnList", "MainList"))
    root:addChild(mcl)
    mcl:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.01,0},{0.1, 0}}"))
    mcl:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.5,0},{0.8, 0}}"))

    -- create frame window for control panel
    local fwnd = CEGUI.toFrameWindow(winMgr:createWindow("TaharezLook/FrameWindow", "ControlPanel"))
    root:addChild(fwnd)
    fwnd:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.53,0},{0.03,0}}"))
    fwnd:setMaxSize(CEGUI.PropertyHelper:stringToUSize("{{1.0,0},{1.0,0}}"))
    fwnd:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.44,0},{0.94,0}}"))
    fwnd:setText("Demo 6 - Control Panel")

    -- create combo-box.
    local cbbo = CEGUI.toCombobox(winMgr:createWindow("TaharezLook/Combobox", "SelModeBox"))
    fwnd:addChild(cbbo)
    cbbo:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.04,0},{0.06,0}}"))
    cbbo:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.66,0},{0.33,0}}"))
    -- cbbo:setSortingEnabled(true)

    -- populate combobox with possible selection modes
    local sel_img = CEGUI.ImageManager:getSingleton():get("TaharezLook/MultiListSelectionBrush")
    local itm = CEGUI.createListboxTextItem("Full Row (Single)", 0)
    itm:setSelectionBrushImage(sel_img)
    cbbo:addItem(itm)
    itm = CEGUI.createListboxTextItem("Full Row (Multiple)", 1)
    itm:setSelectionBrushImage(sel_img)
    cbbo:addItem(itm)
    itm = CEGUI.createListboxTextItem("Full Column (Single)", 2)
    itm:setSelectionBrushImage(sel_img)
    cbbo:addItem(itm)
    itm = CEGUI.createListboxTextItem("Full Column (Multiple)", 3)
    itm:setSelectionBrushImage(sel_img)
    cbbo:addItem(itm);
    itm = CEGUI.createListboxTextItem("Single Cell (Single)", 4)
    itm:setSelectionBrushImage(sel_img)
    cbbo:addItem(itm)
    itm = CEGUI.createListboxTextItem("Single Cell (Multiple)", 5)
    itm:setSelectionBrushImage(sel_img)
    cbbo:addItem(itm)
    itm = CEGUI.createListboxTextItem("Nominated Column (Single)", 6)
    itm:setSelectionBrushImage(sel_img)
    cbbo:addItem(itm)
    itm = CEGUI.createListboxTextItem("Nominated Column (Multiple)", 7)
    itm:setSelectionBrushImage(sel_img)
    cbbo:addItem(itm)
    local pStore = itm
    itm = CEGUI.createListboxTextItem("Nominated Row (Single)", 8)
    itm:setSelectionBrushImage(sel_img)
    cbbo:addItem(itm)
    itm = CEGUI.createListboxTextItem("Nominated Row (Multiple)", 9)
    itm:setSelectionBrushImage(sel_img)
    cbbo:addItem(itm)
    cbbo:setReadOnly(true)
    -- Now change the text to test the sorting
    pStore:setText("Abracadabra")
    -- cbbo:setSortingEnabled(false)
    cbbo:setSortingEnabled(true)
    -- cbbo:handleUpdatedListItemData()

    -- column control section
    local st = winMgr:createWindow("TaharezLook/StaticText", "ColumnPanel")
    fwnd:addChild(st)
    st:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.12,0}}"))
    st:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.96,0},{0.25,0}}"))
    st:setText("Column Control")
    st:setProperty("VertFormatting", "TopAligned")

    local label = winMgr:createWindow("TaharezLook/StaticText", "Label1")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.2,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.12,0}}"))
    label:setText("ID Code:")

    label = winMgr:createWindow("TaharezLook/StaticText", "Label2")
    st:addChild(label);
    label:setProperty("FrameEnabled", "false");
    label:setProperty("BackgroundEnabled", "false");
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.23,0},{0.2,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.12,0}}"))
    label:setText("Width:")

    label = winMgr:createWindow("TaharezLook/StaticText", "Label3")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.44,0},{0.2,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.12,0}}"))
    label:setText("Caption:")

    local btn = CEGUI.toPushButton(winMgr:createWindow("TaharezLook/Button", "AddColButton"))
    st:addChild(btn)
    btn:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.81,0},{0.32,0}}"))
    btn:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.15,0},{0.2,0}}"))
    btn:setText("Add")

    local ebox = CEGUI.toEditbox(winMgr:createWindow("TaharezLook/Editbox", "NewColIDBox"))
    st:addChild(ebox)
    ebox:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.32,0}}"))
    ebox:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.2,0}}"))
    ebox:setValidationString("\\d*")
    ebox:setText("Test -- ")

    ebox = CEGUI.toEditbox(winMgr:createWindow("TaharezLook/Editbox", "NewColWidthBox"))
    st:addChild(ebox)
    ebox:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.23,0},{0.32,0}}"))
    ebox:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.2,0}}"))
    ebox:setValidationString("\\d*")

    ebox = CEGUI.toEditbox(winMgr:createWindow("TaharezLook/Editbox", "NewColTextBox"))
    st:addChild(ebox)
    ebox:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.44,0},{0.32,0}}"))
    ebox:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.36,0},{0.2,0}}"))
    ebox:setValidationString(".*")

    label = winMgr:createWindow("TaharezLook/StaticText", "Label4")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.55,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.12,0}}"))
    label:setText("ID Code:")

    ebox = CEGUI.toEditbox(winMgr:createWindow("TaharezLook/Editbox", "DelColIDBox"))
    st:addChild(ebox);
    ebox:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.67,0}}"))
    ebox:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.2,0}}"))
    ebox:setValidationString("\\d*")

    btn = CEGUI.toPushButton(winMgr:createWindow("TaharezLook/Button", "DelColButton"))
    st:addChild(btn)
    btn:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.25,0},{0.67,0}}"))
    btn:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.4,0},{0.2,0}}"))
    btn:setText("Delete Column")

    -- Row control box
    st = winMgr:createWindow("TaharezLook/StaticText", "RowControl")
    fwnd:addChild(st)
    st:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.38,0}}"))
    st:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.96,0},{0.25,0}}"))
    st:setText("Row Control")
    st:setProperty("VertFormatting", "TopAligned")

    label = winMgr:createWindow("TaharezLook/StaticText", "Label5")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.2,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.12,0}}"))
    label:setText("Col ID:")

    label = winMgr:createWindow("TaharezLook/StaticText", "Label6")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.23,0},{0.2,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.55,0},{0.12,0}}"))
    label:setText("Item Text:");

    ebox = CEGUI.toEditbox(winMgr:createWindow("TaharezLook/Editbox", "RowColIDBox"))
    st:addChild(ebox)
    ebox:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.32,0}}"))
    ebox:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.2,0}}"))
    ebox:setValidationString("\\d*")

    ebox = CEGUI.toEditbox(winMgr:createWindow("TaharezLook/Editbox", "RowTextBox"))
    st:addChild(ebox)
    ebox:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.23,0},{0.32,0}}"))
    ebox:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.55,0},{0.2,0}}"))
    ebox:setValidationString(".*")

    btn = CEGUI.toPushButton(winMgr:createWindow("TaharezLook/Button", "AddRowButton"))
    st:addChild(btn)
    btn:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.81,0},{0.32,0}}"))
    btn:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.15,0},{0.2,0}}"))
    btn:setText("Add")

    label = winMgr:createWindow("TaharezLook/StaticText", "Label7")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.55,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.12,0}}"))
    label:setText("Row Idx:")

    ebox = CEGUI.toEditbox(winMgr:createWindow("TaharezLook/Editbox", "DelRowIdxBox"))
    st:addChild(ebox)
    ebox:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.67,0}}"))
    ebox:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.2,0}}"))
    ebox:setValidationString("\\d*")

    btn = CEGUI.toPushButton(winMgr:createWindow("TaharezLook/Button", "DelRowButton"))
    st:addChild(btn)
    btn:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.25,0},{0.67,0}}"))
    btn:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.4,0},{0.2,0}}"))
    btn:setText("Delete Row")

    -- set item box
    st = winMgr:createWindow("TaharezLook/StaticText", "SetItemPanel")
    fwnd:addChild(st)
    st:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.65,0}}"))
    st:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.96,0},{0.25,0}}"))
    st:setText("Item Modification")
    st:setProperty("VertFormatting", "TopAligned")

    label = winMgr:createWindow("TaharezLook/StaticText", "Label8")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.2,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.12,0}}"))
    label:setText("Row Idx:")

    label = winMgr:createWindow("TaharezLook/StaticText", "Label9")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.23,0},{0.2,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.12,0}}"))
    label:setText("Col ID:")

    label = winMgr:createWindow("TaharezLook/StaticText", "Label10")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.44,0},{0.2,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.12,0}}"))
    label:setText("Item Text:")

    ebox = CEGUI.toEditbox(winMgr:createWindow("TaharezLook/Editbox", "SetItemRowBox"))
    st:addChild(ebox)
    ebox:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.32,0}}"))
    ebox:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.2,0}}"))
    ebox:setValidationString("\\d*")

    ebox = CEGUI.toEditbox(winMgr:createWindow("TaharezLook/Editbox", "SetItemIDBox"))
    st:addChild(ebox)
    ebox:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.23,0},{0.32,0}}"))
    ebox:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.2,0},{0.2,0}}"))
    ebox:setValidationString("\\d*")

    ebox = CEGUI.toEditbox(winMgr:createWindow("TaharezLook/Editbox", "SetItemTextBox"))
    st:addChild(ebox)
    ebox:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.44,0},{0.32,0}}"))
    ebox:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.36,0},{0.2,0}}"))
    ebox:setValidationString(".*")

    btn = CEGUI.toPushButton(winMgr:createWindow("TaharezLook/Button", "SetItemButton"))
    st:addChild(btn)
    btn:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.81,0},{0.32,0}}"))
    btn:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.15,0},{0.2,0}}"))
    btn:setText("Set")

    label = winMgr:createWindow("TaharezLook/StaticText", "RowCount")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.55,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{1.0,0},{0.12,0}}"))
    label:setText("Current Row Count:")

    label = winMgr:createWindow("TaharezLook/StaticText", "ColCount")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.67,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{1.0,0},{0.12,0}}"))
    label:setText("Current Column Count:")

    label = winMgr:createWindow("TaharezLook/StaticText", "SelCount")
    st:addChild(label)
    label:setProperty("FrameEnabled", "false")
    label:setProperty("BackgroundEnabled", "false")
    label:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.02,0},{0.79,0}}"))
    label:setSize(CEGUI.PropertyHelper:stringToUSize("{{1.0,0},{0.12,0}}"))
    label:setText("Current Selected Count:")

    btn = CEGUI.toPushButton(winMgr:createWindow("TaharezLook/Button", "QuitButton"))
    fwnd:addChild(btn)
    btn:setPosition(CEGUI.PropertyHelper:stringToUVector2("{{0.25,0},{0.93,0}}"))
    btn:setSize(CEGUI.PropertyHelper:stringToUSize("{{0.50,0},{0.05,0}}"))
    btn:setText("Quit This Demo!")
end

function Demo6.initDemoEventWiring(root)

    -- subscribe handler that adds a new column
    root:getChild("ControlPanel/ColumnPanel/AddColButton"):subscribeEvent("Clicked", "Demo6.handleAddColumn")

    -- subscribe handler that deletes a column
    root:getChild("ControlPanel/ColumnPanel/DelColButton"):subscribeEvent("Clicked", "Demo6.handleDeleteColumn")

    -- subscribe handler that adds a new row
    root:getChild("ControlPanel/RowControl/AddRowButton"):subscribeEvent("Clicked", "Demo6.handleAddRow")

    -- subscribe handler that deletes a row
    root:getChild("ControlPanel/RowControl/DelRowButton"):subscribeEvent("Clicked", "Demo6.handleDeleteRow")

    -- subscribe handler that sets the text for an existing item
    root:getChild("ControlPanel/SetItemPanel/SetItemButton"):subscribeEvent("Clicked", "Demo6.handleSetItem")

    -- subscribe handler that quits the application
    root:getChild("ControlPanel/QuitButton"):subscribeEvent("Clicked", "Demo6.handleQuit")

    -- subscribe handler that processes a change in the 'selection mode' combobox
    root:getChild("ControlPanel/SelModeBox"):subscribeEvent("ListSelectionAccepted", "Demo6.handleSelectModeChanged")

    -- subscribe handler that processes a change in the item(s) selected in the list
    root:getChild("MainList"):subscribeEvent("ListSelectionAccepted", "Demo6.handleSelectChanged")

    -- subscribe handler that processes a change in the list content.
    root:getChild("MainList"):subscribeEvent("ListSelectionAccepted", "Demo6.handleContentsChanged")
end

function Demo6.handleQuit(args)
    return true
end

function Demo6.handleAddColumn(args)

    -- get access to the widgets that contain details about the column to add
    local mcl = CEGUI.toMultiColumnList(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("MainList"))
    local idbox = CEGUI.toEditbox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/ColumnPanel/NewColIDBox"))
    local widthbox = CEGUI.toEditbox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/ColumnPanel/NewColWidthBox"))
    local textbox = CEGUI.toEditbox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/ColumnPanel/NewColTextBox"))

    -- get ID for new column
    local id = tonumber(idbox:getText()) or 0
    -- get width to use for new column (in pixels)
    local width = tonumber(widthbox:getText()) or 0
    -- get column label text
    local text = textbox:getText()

    -- re-set the widget contents
    idbox:setText("")
    widthbox:setText("")
    textbox:setText("")

    -- ensure a minimum width of 10 pixels
    if width < 10.0 then
        width = 10.0
    end

    -- finally, add the new column to the list.
    mcl:addColumn(text, id, CEGUI.PropertyHelper:stringToUDim("{".. width ..",0}"))

    -- event was handled.
    return true
end

function Demo6.handleDeleteColumn(args)
    -- get access to the widgets that contain details about the column to delete
    local mcl = CEGUI.toMultiColumnList(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("MainList"))
    local idbox = CEGUI.toEditbox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/ColumnPanel/DelColIDBox"))

    -- obtain the id of the column to be deleted
    local id = tonumber(idbox:getText())

    -- attempt to delete the column, ignoring any errors.
    local err, msg = pcall(function () mcl:removeColumnWithID(id) end)
    if err then
        print(msg)
    end

    -- reset the delete column ID box.
    idbox:setText("")

    -- event was handled.
    return true
end

function Demo6.handleAddRow(args)
    -- get access to the widgets that contain details about the row to add
    local mcl = CEGUI.toMultiColumnList(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("MainList"))
    local idbox = CEGUI.toEditbox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/RowControl/RowColIDBox"))
    local textbox = CEGUI.toEditbox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/RowControl/RowTextBox"))

    -- get the ID of the initial column item to set
    local id = tonumber(idbox:getText())
    -- get the text that is to be set initially into the specified column of the new row
    local text = textbox:getText()

    -- reset input boxes
    idbox:setText("")
    textbox:setText("")

    -- construct a new CEGUI.ListboxTextItem with the required string
    local item = CEGUI.createListboxTextItem(text)
    -- set the selection brush to use for this item.
    item:setSelectionBrushImage("TaharezLook/MultiListSelectionBrush")

    -- attempt to add a new row, using the new CEGUI.ListboxTextItem as the initial content for one of the columns
    local err = pcall(function () mcl:addRow(item, id) end)
    -- something went wrong, so cleanup the CEGUI.ListboxTextItem
    if err then
        item:delete()
    end

    -- event was handled.
    return true
end

function Demo6.handleDeleteRow(args)
    -- get access to the widgets that contain details about the row to delete.
    local mcl = CEGUI.toMultiColumnList(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("MainList"))
    local idxbox = CEGUI.toEditbox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/RowControl/DelRowIdxBox"))

    -- get index of row to delete.
    local idx = tonumber(idxbox:getText())

    -- attempt to delete the row, ignoring any errors.
    local err, msg = pcall(function () mcl:removeRow(idx) end)
    
    if err then
        print(msg)
    end

    -- clear the row index box
    idxbox:setText("")

    -- event was handled.
    return true
end

function Demo6.handleSetItem(args)
    -- get access to the widgets that contain details about the item to be modified
    local mcl = CEGUI.toMultiColumnList(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("MainList"))
    local idbox = CEGUI.toEditbox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/SetItemPanel/SetItemIDBox"))
    local rowbox = CEGUI.toEditbox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/SetItemPanel/SetItemRowBox"))
    local textbox = CEGUI.toEditbox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/SetItemPanel/SetItemTextBox"))

    -- get ID of column to be affected
    local id = tonumber(idbox:getText())
    -- get index of row to be affected
    local row = tonumber(rowbox:getText())
    -- get new text for item
    local text = textbox:getText()

    -- reset input boxes
    idbox:setText("")
    rowbox:setText("")
    textbox:setText("")

    -- create a new CEGUI.ListboxTextItem using the new text string
    local item = CEGUI.createListboxTextItem(text)
    -- set the selection brush to be used for this item.
    item:setSelectionBrushImage("TaharezLook/MultiListSelectionBrush")

    -- attempt to set the new item in place
    local err, msg = pcall(function () mcl:setItem(item, id, row) end)
   
    if err then
        item:delete()
    end

    -- event was handled.
    return true
end

function Demo6.handleSelectChanged(args)
    -- Get access to the list
    local mcl = CEGUI.toMultiColumnList(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("MainList"))

    -- update the selected count
    local buff = "Current Selected Count: "..mcl:getSelectedCount()

    CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/SetItemPanel/SelCount"):setText(buff)

    -- event was handled.
    return true
end

function Demo6.handleSelectModeChanged(args)

    -- get access to list
    local mcl = CEGUI.toMultiColumnList(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("MainList"))
    -- get access to the combobox
    local combo = CEGUI.toCombobox(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/SelModeBox"))

    -- find the selected item in the combobox
    local item = combo:findItemWithText(combo:getText(), nil)

    -- set new selection mode according to ID of selected ListboxItem
    if item then
        local id = item:getID()
        if id == 0 then
            mcl:setSelectionMode(CEGUI.MultiColumnList.RowSingle)
        elseif id == 1 then
            mcl:setSelectionMode(CEGUI.MultiColumnList.RowMultiple)
        elseif id == 2 then
            mcl:setSelectionMode(CEGUI.MultiColumnList.ColumnSingle)
        elseif id == 3 then
            mcl:setSelectionMode(CEGUI.MultiColumnList.ColumnMultiple)
        elseif id == 4 then
            mcl:setSelectionMode(CEGUI.MultiColumnList.CellSingle)
        elseif id == 5 then
            mcl:setSelectionMode(CEGUI.MultiColumnList.CellMultiple)
        elseif id == 6 then
            mcl:setSelectionMode(CEGUI.MultiColumnList.NominatedColumnSingle)
        elseif id == 7 then
            mcl:setSelectionMode(CEGUI.MultiColumnList.NominatedColumnMultiple)
        elseif id == 8 then
            mcl:setSelectionMode(CEGUI.MultiColumnList.NominatedRowSingle)
        elseif id == 9 then
            mcl:setSelectionMode(CEGUI.MultiColumnList.NominatedRowMultiple)
        else
            mcl:setSelectionMode(CEGUI.MultiColumnList.RowSingle)
        end 
    end

    -- event was handled.
    return true
end

function Demo6.handleContentsChanged(args)

    -- get access to required widgets
    local mcl = CEGUI.toMultiColumnList(CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("MainList"))
    local colText = CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/SetItemPanel/ColCount")
    local rowText = CEGUI.toWindowEventArgs(args).window:getRootWindow():getChild("ControlPanel/SetItemPanel/RowCount")

    -- update the column count
    local buff = "Current Column Count: "..tostring(mcl:getColumnCount())
    colText:setText(buff)

    -- update the row count
    buff = "Current Row Count: "..tostring(mcl:getRowCount())
    rowText:setText(buff)

    -- event was handled.
    return true
end
