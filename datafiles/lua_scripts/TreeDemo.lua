TreeDemo = {}
TreeDemo.__index = TreeDemo

local TreeID    = 1
local EditBoxID = 2

local USE_VANILLA = false

local TreeDemoWindow

if USE_VANILLA then
	SCHEME_FILE_NAME = "VanillaSkin.scheme"
	IMAGES_FILE_NAME = "Vanilla-Images"
	STATICIMAGE_NAME = "Vanilla/StaticImage"
	TOOLTIP_NAME     = "Vanilla/Tooltip"
	LAYOUT_FILE_NAME = "TreeDemo.layout"
	BRUSH_NAME       = "GenericBrush"
else
	SCHEME_FILE_NAME = "TaharezLook.scheme"
	IMAGES_FILE_NAME = "TaharezLook"
	STATICIMAGE_NAME = "TaharezLook/StaticImage"
	TOOLTIP_NAME     = "TaharezLook/Tooltip"
	LAYOUT_FILE_NAME = "TreeDemoTaharez.layout"
	BRUSH_NAME       = "/TextSelectionBrush"
end

function randInt(low, high)
   return math.floor(math.random(low, high))
end

function TreeDemo.initialize(args)
	local context = CEGUI.toGUIContextEventArgs(args).context

	-- Get window manager which we will use for a few jobs here.
	local winMgr = CEGUI.WindowManager:getSingleton()

	-- load font and setup default if not loaded via scheme
	local defaultFont = CEGUI.FontManager:getSingleton():createFromFile("DejaVuSans-12.font")
	-- Set default font for the gui context
	context:setDefaultFont(defaultFont)

	-- Load the scheme to initialise the skin which we use in this sample
	CEGUI.SchemeManager:getSingleton():createFromFile(SCHEME_FILE_NAME)

	-- set default mouse image
	context:getMouseCursor():setDefaultImage(IMAGES_FILE_NAME .. "/MouseArrow")

	-- load an image to use as a background
	if not CEGUI.ImageManager:getSingleton():isDefined("SpaceBackgroundImage") then
	   CEGUI.ImageManager:getSingleton().addFromImageFile("SpaceBackgroundImage", "SpaceBackground.jpg")
	end
	-- Load some icon images for our test tree
	CEGUI.ImageManager:getSingleton():loadImageset("DriveIcons.imageset")

	-- here we will use a StaticImage as the root, then we can use it to place a background image
	local background = winMgr:createWindow(STATICIMAGE_NAME)

	-- set area rectangle
	background:setArea(CEGUI.PropertyHelper:stringToURect("{{0,0},{0,0},{1,0},{1,0}}"))
	-- disable frame and standard background
	background:setProperty("FrameEnabled", "false");
	background:setProperty("BackgroundEnabled", "false")
	-- set the background image
	background:setProperty("Image", "SpaceBackgroundImage")
	-- install this as the root GUI sheet
	context:setRootWindow(background)

	CEGUI.FontManager:getSingleton():createFromFile("DejaVuSans-12.font")

	TreeDemoWindow = winMgr:loadLayoutFromFile(LAYOUT_FILE_NAME)

	background:addChild(TreeDemoWindow)

	-- listen for key presses on the root window.
	background:subscribeEvent("KeyDown", "TreeDemo.handleRootKeyDown")

	local theTree = CEGUI.toTree(TreeDemoWindow:getChild(TreeID))
	theTree:initialise()
	theTree:subscribeEvent("SelectionChanged", "TreeDemo.handleEventSelectionChanged")
	theTree:subscribeEvent("BranchOpened", "TreeDemo.handleEventBranchOpened")
	theTree:subscribeEvent("BranchClosed", "TreeDemo.handleEventBranchClosed")

	-- activate the background window
	background:activate()

	local imgMgr = CEGUI.ImageManager:getSingleton()
	local iconArray = {
		imgMgr:get("DriveIcons/Artic"),
		imgMgr:get("DriveIcons/Black"),
		imgMgr:get("DriveIcons/Sunset"),
		imgMgr:get("DriveIcons/DriveStack"),
		imgMgr:get("DriveIcons/GlobalDrive"),
		imgMgr:get("DriveIcons/Blue"),
		imgMgr:get("DriveIcons/Lime"),
		imgMgr:get("DriveIcons/Silver"),
		imgMgr:get("DriveIcons/GreenCandy")
	}


	-- Create a top-most TreeCtrlEntry
	local newTreeCtrlEntryLvl1 = CEGUI.createTreeItem("Tree Item Level 1a")
	newTreeCtrlEntryLvl1:setIcon(imgMgr:get("DriveIcons/Black"))
	newTreeCtrlEntryLvl1:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
	--   newTreeCtrlEntryLvl1:setUserData((void *)someData);
	theTree:addItem(newTreeCtrlEntryLvl1)
	-- Create a second-level TreeCtrlEntry and attach it to the top-most TreeCtrlEntry
	local newTreeCtrlEntryLvl2 = CEGUI.createTreeItem("Tree Item Level 2a (1a)")
	newTreeCtrlEntryLvl2:setIcon(imgMgr:get("DriveIcons/Artic"))
	newTreeCtrlEntryLvl2:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
	newTreeCtrlEntryLvl1:addItem(newTreeCtrlEntryLvl2)
	-- Create a third-level TreeCtrlEntry and attach it to the above TreeCtrlEntry
	local newTreeCtrlEntryLvl3 = CEGUI.createTreeItem("Tree Item Level 3a (2a)");
	newTreeCtrlEntryLvl3:setIcon(imgMgr:get("DriveIcons/Blue"))
	newTreeCtrlEntryLvl3:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
	newTreeCtrlEntryLvl2:addItem(newTreeCtrlEntryLvl3)
	-- Create another third-level TreeCtrlEntry and attach it to the above TreeCtrlEntry
	newTreeCtrlEntryLvl3 = CEGUI.createTreeItem("Tree Item Level 3b (2a)")
	newTreeCtrlEntryLvl3:setIcon(imgMgr:get("DriveIcons/Lime"))
	newTreeCtrlEntryLvl3:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
	newTreeCtrlEntryLvl2:addItem(newTreeCtrlEntryLvl3)
	-- Create another second-level TreeCtrlEntry and attach it to the top-most TreeCtrlEntry
	newTreeCtrlEntryLvl2 = CEGUI.createTreeItem("Tree Item Level 2b (1a)")
	newTreeCtrlEntryLvl2:setIcon(imgMgr:get("DriveIcons/Sunset"))
	newTreeCtrlEntryLvl2:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
	newTreeCtrlEntryLvl1:addItem(newTreeCtrlEntryLvl2)
	-- Create another second-level TreeCtrlEntry and attach it to the top-most TreeCtrlEntry
	newTreeCtrlEntryLvl2 = CEGUI.createTreeItem("Tree Item Level 2c (1a)")
	newTreeCtrlEntryLvl2:setIcon(imgMgr:get("DriveIcons/Silver"))
	newTreeCtrlEntryLvl2:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
	newTreeCtrlEntryLvl1:addItem(newTreeCtrlEntryLvl2)

	-- Create another top-most TreeCtrlEntry
	newTreeCtrlEntryLvl1 = CEGUI.createTreeItem("Tree Item Level 1b")
	newTreeCtrlEntryLvl1:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
	newTreeCtrlEntryLvl1:setIcon(imgMgr:get("DriveIcons/DriveStack"))
	newTreeCtrlEntryLvl1:setDisabled(true); -- Let's disable this one just to be sure it works
	theTree:addItem(newTreeCtrlEntryLvl1)
	-- Create a second-level TreeCtrlEntry and attach it to the top-most TreeCtrlEntry
	newTreeCtrlEntryLvl2 = CEGUI.createTreeItem("Tree Item Level 2a (1b)")
	newTreeCtrlEntryLvl2:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
	newTreeCtrlEntryLvl1:addItem(newTreeCtrlEntryLvl2)
	-- Create another second-level TreeCtrlEntry and attach it to the top-most TreeCtrlEntry
	newTreeCtrlEntryLvl2 = CEGUI.createTreeItem("Tree Item Level 2b (1b)")
	newTreeCtrlEntryLvl2:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
	newTreeCtrlEntryLvl1:addItem(newTreeCtrlEntryLvl2)

	newTreeCtrlEntryLvl1 = CEGUI.createTreeItem("Tree Item Level 1c")
	newTreeCtrlEntryLvl1:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
	theTree:addItem(newTreeCtrlEntryLvl1)

	-- Now let's create a whole bunch of items automatically
	local levelIndex = 3
	local childIndex
	local childCount
	local iconIndex
	local itemText
	while levelIndex < 10 do
		idepthIndex = 0;
		itemText = "Tree Item Level "..levelIndex.." Depth "..idepthIndex
		newTreeCtrlEntryLvl1 = CEGUI.createTreeItem(itemText)
		-- Set a random icon for the item.  Sometimes blank (on purpose).
		iconIndex = randInt(1, #iconArray + 1)
		if iconIndex < #iconArray then 
			newTreeCtrlEntryLvl1:setIcon(iconArray[iconIndex])
		end
		newTreeCtrlEntryLvl1:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
		theTree:addItem(newTreeCtrlEntryLvl1)
		newTreeCtrlEntryParent = newTreeCtrlEntryLvl1

		childIndex = 0;
		childCount = randInt(0, 3);
		while childIndex < childCount do

			itemText = "Tree Item Level "..levelIndex.." Depth "..(idepthIndex + 1).." Child "..(childIndex + 1)
			newTreeCtrlEntryLvl2 = CEGUI.createTreeItem(itemText)
			-- Set a random icon for the item.  Sometimes blank (on purpose).
			iconIndex = randInt(1, #iconArray + 1)
			if iconIndex < #iconArray then
				newTreeCtrlEntryLvl2:setIcon(iconArray[iconIndex])
			end
			newTreeCtrlEntryLvl2:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
			newTreeCtrlEntryParent:addItem(newTreeCtrlEntryLvl2)
			childIndex = childIndex + 1
		end

		while idepthIndex < 15 do
			itemText = "Tree Item Level "..levelIndex.." Depth "..(idepthIndex + 1)
			newTreeCtrlEntryLvl2 = CEGUI.createTreeItem(itemText)
			-- Set a random icon for the item.  Sometimes blank (on purpose).
			iconIndex = randInt(1, #iconArray + 1)
			if iconIndex < #iconArray then
				newTreeCtrlEntryLvl2:setIcon(iconArray[iconIndex])
			end
			newTreeCtrlEntryLvl2:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
			newTreeCtrlEntryParent:addItem(newTreeCtrlEntryLvl2)
			newTreeCtrlEntryParent = newTreeCtrlEntryLvl2

			childIndex = 0;
			childCount = randInt(0, 3);
			while childIndex < childCount do
				itemText = "Tree Item Level "..levelIndex.." Depth "..(idepthIndex + 1).." Child "..(childIndex + 1)
				newTreeCtrlEntryLvl2 = CEGUI.createTreeItem(itemText)
				-- Set a random icon for the item.  Sometimes blank (on purpose).
				iconIndex = randInt(1, #iconArray + 1)
				if iconIndex < #iconArray then
				   newTreeCtrlEntryLvl2:setIcon(iconArray[iconIndex]);
				end
				newTreeCtrlEntryLvl2:setSelectionBrushImage(IMAGES_FILE_NAME..BRUSH_NAME)
				newTreeCtrlEntryParent:addItem(newTreeCtrlEntryLvl2)
				childIndex = childIndex + 1
			end

		 	idepthIndex = idepthIndex + 1
		end
		levelIndex = levelIndex + 1
	end
	return true
end

function TreeDemo.handleEventSelectionChanged(args)
	local treeArgs = CEGUI.toTreeEventArgs(args)
	local editBox = CEGUI.toEditbox(TreeDemoWindow:getChild(EditBoxID))

	-- Three different ways to get the item selected.
	--   TreeCtrlEntry *selectedItem = theTree:getFirstSelectedItem();      -- the first selection in the list (may be more)
	--   TreeCtrlEntry *selectedItem = theTree:getLastSelectedItem();       -- the last (time-wise) selected by the user
	local selectedItem = treeArgs.treeItem                                  -- the actual item that caused this event

	if selectedItem then
		-- -- A convoluted way to get the item text.
		-- -- Just here to test findFirstItemWithText.
		-- selectedItem = theTree:findFirstItemWithText(selectedItem:getText())
		-- if selectedItem then
		-- 	editBox:setText("Selected: "..selectedItem:getText())
		-- else
		-- 	editBox:setText("findItemWithText failed!")
		-- end

		-- The simple way to do it.
		editBox:setText("Selected: "..selectedItem:getText());

	else
		editBox:setText("None Selected")
	end
	return true
end

function TreeDemo.handleRootKeyDown(args)
	local key = CEGUI.toKeyEventArgs(args).scancode
	return key == CEGUI.Key.F12
end

function TreeDemo.handleEventBranchOpened(args)
	local treeArgs = CEGUI.toTreeEventArgs(args)
	local editBox = CEGUI.toEditbox(TreeDemoWindow:getChild(EditBoxID))
	editBox:setText("Opened: "..treeArgs.treeItem:getText())
	return true
end

function TreeDemo.handleEventBranchClosed(args)
	local treeArgs = CEGUI.toTreeEventArgs(args)
	local editBox = CEGUI.toEditbox(TreeDemoWindow:getChild(EditBoxID))
	editBox:setText("Closed: "..treeArgs.treeItem:getText())
	return true
end