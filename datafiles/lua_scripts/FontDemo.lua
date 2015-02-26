FontDemo = {}
FontDemo.__index = FontDemo

local root
local d_fontNameOptions = {}
local d_languageToTextMap = {}
local d_languageToFontMap = {}
local LangListSize = 12

local LangList =
{
    -- A list of strings in different languages
    -- Feel free to add your own language here (UTF-8 ONLY!)...
    {
        Language = 'Sandbox',
        Font = 'DejaVuSans-12',
        Text = [[Try out writing text in any language here. The used font can be changed on the right.\n
            You can create new fonts if needed. The new font will be set as font for the selected text/language...\n
            You can also edit the fonts that are part of this demo or the ones you created here (however, this demo won't allow to change the fonts of the other demos)\n
            Important: When you switch to a font the FIRST time, it takes some time to load it. Especially for fonts with asian characters this load time might be noticable.!]]
    },
    {
        Language = 'European characters using DejaVuSans font',
        Font = 'DejaVuSans-12',
        Text = [[Try Catching The Brown Fox While It's Jumping Over The Lazy Dog\n\n
            Supports nearly all European unicode characters, including cyrillic:\n
            bokmål, česky, русский, српски / srpski, slovenščina, latviešu, Tiếng Việt, etc.\n
            ¥¤£¢©®ÐÆ\nÄÜÖäüöß\nēĒŗŖūŪīĪāĀšŠģĢķĶļĻžŽčČņŅ\nøØæÆåÅèâïÀÁÂƒéíóúÉÍÓÚõç¿ñÑ\nускоряющпризв]]
    },
    {
        Language = 'European characters using Junicode font',
        Font = 'Junicode-14',
        Text = [[Try Catching The Brown Fox While It's Jumping Over The Lazy Dog\n\n
            Supports most European unicode characters, but for example no cyrillic:\n
            bokmål, česky, slovenščina, latviešu, Tiếng Việt, etc.\n
            ¥¤£¢©®ÐÆ\nÄÜÖäüöß\nēĒŗŖūŪīĪāĀšŠģĢķĶļĻžŽčČņŅ\nøØæÆåÅèâïÀÁÂƒéíóúÉÍÓÚõç¿ñÑ]]
    },
    {
        Language = 'Korean/Chinese/Japanese using Batang font',
        Font = 'Batang-18',
        Text = [[
                    日本語を選択\n
                    トリガー検知\n
                    鉱石備蓄不足\n\n\n\n\n

                    早發白帝城 (李白)\n\n

                    朝辭白帝彩雲間，\n
                    千里江陵一日還。\n
                    兩岸猿聲啼不住，\n
                    輕舟己過萬重山。\n\n\n\n\n
 
                    이몸이/죽고죽어/일백번/고쳐죽어/\n
                    백골이/진퇴되어/넋이라도/있고없고/\n
                    임 향한/일편단심이야/가실 줄이/있으랴/]]
    },
    {
        Language = 'Hebrew using TnuaLibre font',
        Font = 'TnuaLibre-12',
        Text = [[תנועה \n
            חופשי ** אבגד  \n
            1234]]
    },
    {
        Language = 'Old German using Fette UNZ Fraktur font',
        Font = 'FetteUNZFraktur-20',
        Text = [[Heute back ich, morgen brau ich,\n
            Übermorgen hol ich mir der Königin ihr Kind;\n
            Ach, wie gut, dass niemand weiß,\n
            dass ich Rumpelstilzchen heiß]]
    },
    {
        Language = 'Latin using Old Fell Type font',
        Font = 'FellType-12.5',
        Text = [[☞Non nobis, non nobis, Domine\n
            Sed nomini tuo da gloriam.☜\n
                Ð]]
    },
    {
        Language = 'Handwriting font',
        Font = 'GreatVibes-22',
        Text = [[Dear Gooby,\n\n
            Handwriting is nice when you don't have to do it yourself.\n\n
            Regards, Uncle Dolan.]]
    },
    {
        Language = 'RichStyle Icons font',
        Font = 'RichStyle-22',
        Text = '+ - ? B I W Y f n t ℹ ⇦ ⇧ ⇨ ⇩ ⌘ ☎ ☐ ☑ ⚖ ⚙ ⚠ ⛏ ✎ ✑ ✓ ✔ ✕ ✖ ❝ ❞ ➡ ⬀ ⬁ ⬂ ⬃ ⬅ ⬆ ⬇ ⬈ ⬉ ⬊ ⬋                       '
    },  
    {
        Language = 'Old Runic writing using Futhark Adapted font',
        Font = 'FutharkAdapted-18',
        Text = [[Somehow, although he is the smallest office boy around the place, none of the other lads pick on him. Scuffling and fighting almost has ceased since Kerensky came to work. That's only one of the nicknames of Leo Kobreen, and was assigned to him because of a considerable facial resemblance to the perpetually fleeing Russian statesman, and, too, because both wore quite formal standing collars.]]
    },
    {
        Language = 'Klingon using pIqaD HaSta font',
        Font = 'Klingon-pIqaD-HaSta-24',
        Text = [[  \n\n\n
                     \n
                     \n
              ]]
    },
    {
        Language = 'Pixel style font using Mizufalp font',
        Font = 'mizufalp-12',
        Text = [[Mechanic: Somebody set up us the bomb.\n
            Operator: Main screen turn on.\n
            CATS: All your base are belong to us.\n
            CATS: You have no chance to survive make your time.]]
    }
}

-- Sample sub-class for ListboxTextItem that auto-sets the selection brush
-- image.  This saves doing it manually every time in the code.
local MyListItem = function (text, itemID)
    local item = CEGUI.createListboxTextItem(text, itemID)
    item:setSelectionBrushImage('Vanilla-Images/GenericBrush')
    return item
end

function FontDemo.initialize(args)

    local context = CEGUI.toGUIContextEventArgs(args).context

    -- we will use of the WindowManager.
    local winMgr = CEGUI.WindowManager:getSingleton()

    -- load scheme and set up defaults
    CEGUI.SchemeManager:getSingleton():createFromFile('VanillaSkin.scheme')
    context:getMouseCursor():setDefaultImage('Vanilla-Images/MouseArrow')

    -- Create a custom font which we use to draw the list items. This custom
    -- font won't get effected by the scaler and such.
    local fontManager = CEGUI.FontManager:getSingleton()
    local font = fontManager:createFromFile('DejaVuSans-12.font')
    -- Set it as the default
    context:setDefaultFont(font)

    -- load all the fonts (if they are not loaded yet)
    -- fontManager:createAll('*.font', 'fonts')

    -- Fill list with all loaded font names
    FontDemo.retrieveLoadedFontNames(false)

    -- Now that we know about all existing fonts we will initialise
    -- the fonts we wanna use for this demo hardcoded
    FontDemo.initialiseDemoFonts()

    -- Fill list with all new and thus editable font names
    FontDemo.retrieveLoadedFontNames(true)

    -- Fill list with all available font type file names
    FontDemo.retrieveFontFileNames()

    -- set tooltip styles (by default there is none)
    context:setDefaultTooltipType('Vanilla/Tooltip')

    -- Load the GUI layout and attach it to the context as root window
    root = winMgr:loadLayoutFromFile('FontDemo.layout')
    context:setRootWindow(root)

    --Here we create a font and apply it to the renew font name button
    local buttonFont = fontManager:createFreeTypeFont('DejaVuSans-14', 14, true, 'DejaVuSans.ttf',
        CEGUI.Font:getDefaultResourceGroup(), CEGUI.ASM_Vertical, CEGUI.Sizef(1280.0, 720.0))
    d_renewFontNameButton = CEGUI.toPushButton(root:getChild('FontDemoWindow/FontCreator/RenewNameButton'))
    d_renewFontNameButton:setFont(buttonFont)

    root:getChild('FontDemoWindow/FontCreator/FontSizeLabel')

    --Subscribe click event for renewing font name based on font file name and size
    d_renewFontNameButton:subscribeEvent('Clicked', 'FontDemo.handleRenewFontNameButtonClicked')

    -- Get the editbox where we display the text
    d_textDisplayMultiLineEditbox = CEGUI.toMultiLineEditbox(root:getChild('FontDemoWindow/MultiLineTextWindow'))
    d_textDisplayMultiLineEditbox:subscribeEvent('TextChanged', 'FontDemo.handleTextMultiLineEditboxTextChanged')

    --Get the font editor info label and apply an animation to it for blending out
    FontDemo.initialiseFontEditorInfoLabel()

    --Initialise the options we have for setting autoScale for fonts as strings
    FontDemo.initialiseAutoScaleOptionsArray()

    --Initialise the Map that connects Language/Text strings with the actual text we will display in the MultiLineEditbox
    FontDemo.initialiseLangToTextMap()

    -- Initialise the font creator window + its subwindows
    FontDemo.initialiseFontCreator()

    -- Initialise the widget to select fonts and its items
    FontDemo.initialiseFontSelector()

    -- Initialise the widget to select the different language texts the relative items for each
    FontDemo.initialiseTextSelector()

    --Subscribe font selection event
    d_fontSelector:subscribeEvent('SelectionChanged', 'FontDemo.handleFontSelectionChanged')

    d_textSelector:setItemSelectState(0, true)

    return true
end

function FontDemo:handleFontCreationButtonClicked(args)
    local fontMgr = CEGUI.FontManager:getSingleton()

    local fontName = d_fontNameEditbox:getText()
    local fontNameExists = fontMgr:isDefined(fontName)
    if fontNameExists or not fontName then
        d_fontEditorInfoLabel:setText('Font name already in use.')
        return true
    end

    local fontFileName = d_fontFileNameSelector:getSelectedItem():getText()

    local fontSizeString = d_fontSizeEditbox:getText()
    local fontSize = CEGUI.PropertyHelper:stringToFloat(fontSizeString)
    if fontSize == 0.0 then
        return true
    end

    local antiAlias = d_fontAntiAliasCheckbox:isSelected()

    local autoScaleMode = FontDemo.getAutoScaleMode()

    local pos = CEGUI.String:new_local(fontFileName):rfind('.imageset')
    if pos ~= -1 then
        local createdFont = fontMgr.createPixmapFont(fontName, fontFileName, CEGUI.Font:getDefaultResourceGroup(), autoScaleMode,
            CEGUI.Sizef(1280.0, 720.0), CEGUI.XREA_THROW)
    else
        local createdFont = fontMgr.createFreeTypeFont(fontName, fontSize, antiAlias, fontFileName, CEGUI.Font:getDefaultResourceGroup(), autoScaleMode, 
            CEGUI.Sizef(1280.0, 720.0), CEGUI.XREA_THROW)
    end

    local item = MyListItem(fontName, 0)
    d_fontSelector:addItem(item)
    d_fontSelector:setItemSelectState(item, true)

    return true
end

function FontDemo.handleFontEditButtonClicked(args)
    local fontMgr = CEGUI.FontManager:getSingleton()

    local fontName = d_fontNameEditbox:getText()
    local fontNameExists = fontMgr:isDefined(fontName)
    if not fontNameExists then
        d_fontEditorInfoLabel:setText('A font with this name does not exist.')
        return true
    end

    local font = fontMgr:get(fontName)

    if font:isPropertyPresent('PointSize') then
        local fontSizeString = d_fontSizeEditbox:getText()
        local fontSize = CEGUI.PropertyHelper:stringToFloat(fontSizeString)
        if fontSize ~= 0.0 then
            font:setProperty('PointSize', fontSizeString)
        end
    end

    if font:isPropertyPresent('Antialiased') then
        local antiAlias = d_fontAntiAliasCheckbox:isSelected()
        font:setProperty('Antialiased', CEGUI.PropertyHelper:boolToString(antiAlias))
    end

    local autoScaleMode = FontDemo.getAutoScaleMode()
    font:setAutoScaled(autoScaleMode)

    return true
end

function FontDemo.handleFontSelectionChanged(args)
    --Change font of the selected language/text sample
    if d_textSelector:getFirstSelectedItem() and d_fontSelector:getFirstSelectedItem() then
        local index = d_textSelector:getFirstSelectedItem():getID()
        
        d_languageToFontMap[LangList[index].Language] = d_fontSelector:getFirstSelectedItem():getText()
    end

    --Change the font creatore fields according to the font
    if d_fontSelector:getFirstSelectedItem() then
        local fontName = d_fontSelector:getFirstSelectedItem():getText()

        if FontManager:getSingleton():isDefined(fontName) then
            local font = CEGUI.FontManager:getSingleton():get(fontName)

            d_textDisplayMultiLineEditbox:setFont(font)

            d_fontNameEditbox:setText(font:getName())

            local autoScaleMode = font:getAutoScaled()
            local autoScaleString = d_autoScaleOptionsArray[autoScaleMode]
            d_fontAutoScaleCombobox:getEditbox():setText(autoScaleString)
            d_fontAutoScaleCombobox:selectListItemWithEditboxText()

            if font:isPropertyPresent('Antialiased') then
                local fontAntiAlias = font:getProperty('Antialiased')
                d_fontAntiAliasCheckbox:enable()
                d_fontAntiAliasCheckbox:setSelected(CEGUI.PropertyHelper:stringToBool(fontAntiAlias))
            else
                d_fontAntiAliasCheckbox:disable()
            end

            if font:isPropertyPresent('PointSize') then
                local fontPointSize = font:getProperty('PointSize')
                d_fontSizeEditbox:enable()
                d_fontSizeEditbox:setText(fontPointSize)
            else
                d_fontSizeEditbox:disable()
            end

            d_fontFileNameSelector:setText(font:getFileName())

            checkIfEditButtonShouldBeDisabled(font)

            --Change the font colour for pixmap fonts
            if font:getTypeName() == 'Pixmap' then
                local col = CEGUI.Colour:new_local(1, 1, 1, 1)
                local crect = CEGUI.ColourRect(col)
                d_textDisplayMultiLineEditbox:setProperty('NormalTextColour', CEGUI.PropertyHelper:colourRectToString(crect))
            else
            	local col = CEGUI.Colour:new_local(0, 0, 0, 1)
                local crect = CEGUI.ColourRect(col)
                d_textDisplayMultiLineEditbox:setProperty('NormalTextColour', CEGUI.PropertyHelper:colourRectToString(crect))
            end
        end
    end

    return true
end

function FontDemo.handleTextSelectionChanged(args)
    if d_textSelector:getFirstSelectedItem() then
        local index = d_textSelector:getFirstSelectedItem():getID()

        d_textDisplayMultiLineEditbox:setText(d_languageToTextMap[LangList[index].Language])

        FontDemo.changeFontSelectorFontSelection(d_languageToFontMap[LangList[index].Language])
    end

    return true
end

function FontDemo.handleTextMultiLineEditboxTextChanged(args)
    if d_textSelector:getFirstSelectedItem() then
        local index = d_textSelector:getFirstSelectedItem():getID()

        d_languageToTextMap[LangList[index].Language] = d_textDisplayMultiLineEditbox:getText()
    end

    return true
end

function FontDemo.handleFontFileNameSelectionChanged(args)
    FontDemo.generateNewFontName()
    return true
end

function FontDemo.handleRenewFontNameButtonClicked(args)
    FontDemo.generateNewFontName()
    return true
end

function FontDemo.initialiseAutoScaleOptionsArray()
    --AutoScale options in the enum order
    d_autoScaleOptionsArray = {
    	'Disabled',
    	'Vertical',
    	'Horizontal',
    	'Minimum',
    	'Maximum',
    	'Both'
	}
end

function FontDemo.retrieveLoadedFontNames(areEditable)
    local fontManager = CEGUI.FontManager:getSingleton()
    local fi = fontManager:getIterator()

    while not fi:isAtEnd() do
        local font = fontManager:get(fi:key())

        if not d_fontNameOptions[font:getProperty('Name')] then
            d_fontNameOptions[font:getProperty('Name')] = areEditable
        end
        fi:next()
    end
end

function FontDemo.retrieveFontFileNames()
    d_fontFileNameOptions = {}
    local fontManager = CEGUI.FontManager:getSingleton()
    local fi = fontManager:getIterator()
    local index = 1
    while not fi:isAtEnd() do
        local font = fontManager:get(fi:key())
        d_fontFileNameOptions[index] = font:getProperty('Name')
        index = index + 1
        fi:next()
    end
end

function FontDemo.initialiseFontFileNameCombobox()
    --Select a font file name if any are present
    if #d_fontFileNameOptions > 0 then
        -- Add the font file names to the listbox
        for i = 1, #d_fontFileNameOptions do
            local fileName = d_fontFileNameOptions[i]
            d_fontFileNameSelector:addItem(MyListItem(fileName, i))  
        end

        d_fontFileNameSelector:getListboxItemFromIndex(0):setSelected(true)
        d_fontFileNameSelector:getEditbox():setText(d_fontFileNameSelector:getListboxItemFromIndex(0):getText())
    end
end

function FontDemo.initialiseFontCreator()
    d_fontFileNameSelector = CEGUI.toCombobox(root:getChild('FontDemoWindow/FontCreator/FontFileCombobox'))
    d_fontNameEditbox = CEGUI.toEditbox(root:getChild('FontDemoWindow/FontCreator/FontNameEditbox'))
    d_fontSizeEditbox = CEGUI.toEditbox(root:getChild('FontDemoWindow/FontCreator/FontSizeEditbox'))
    d_fontAutoScaleCombobox = CEGUI.toCombobox(root:getChild('FontDemoWindow/FontCreator/AutoScaleCombobox'))
    d_fontAntiAliasCheckbox = CEGUI.toToggleButton(root:getChild('FontDemoWindow/FontCreator/AntiAliasingCheckbox'))
    d_fontCreationButton = CEGUI.toPushButton(root:getChild('FontDemoWindow/FontCreator/CreationButton'))
    d_fontEditButton = CEGUI.toPushButton(root:getChild('FontDemoWindow/FontCreator/EditButton'))

    d_fontFileNameSelector:subscribeEvent('SelectionAccepted', 'FontDemo.handleFontFileNameSelectionChanged')

    d_fontCreationButton:subscribeEvent('Clicked', 'FontDemo.handleFontCreationButtonClicked')
    d_fontEditButton:subscribeEvent('Clicked', 'FontDemo.handleFontEditButtonClicked')

    FontDemo.initialiseFontFileNameCombobox()
    FontDemo.initialiseAutoScaleCombobox()

end

function FontDemo.initialiseFontSelector()
    d_fontSelector = CEGUI.toListbox(root:getChild('FontDemoWindow/FontSelector'))

    d_fontSelector:setSortingEnabled(true)

    --Select a font file name if any are present
    if #d_fontNameOptions > 0 then
    	for k, v in pairs(d_fontNameOptions) do
    		d_fontSelector:addItem(MyListItem(k, 0))
    	end
    end

    d_fontSelector:handleUpdatedItemData()
end

function FontDemo.initialiseTextSelector()
    d_textSelector = CEGUI.toListbox(root:getChild('FontDemoWindow/TextSelector'))
    d_textSelector:subscribeEvent('SelectionChanged', 'FontDemo.handleTextSelectionChanged')

    for i = 1, LangListSize do
    	d_textSelector:addItem(MyListItem(LangList[i].Language, i))
        d_languageToFontMap[LangList[i].Language] = LangList[i].Font
    end
end

function FontDemo.changeFontSelectorFontSelection(font)
    while d_fontSelector:getFirstSelectedItem() do
        d_fontSelector:setItemSelectState(d_fontSelector:getFirstSelectedItem(), false)
    end

    local itemCount = d_fontSelector:getItemCount()
    for i = 1, itemCount do
    	local item = d_fontSelector:getListboxItemFromIndex(i)
    	local itemFontName = item:getText()
    	if itemFontName == font then
    		d_fontSelector:setItemSelectState(item, true)
    		return
    	end
    end
end

function FontDemo.initialiseLangToTextMap()
	for i = 1, LangListSize do
		d_languageToTextMap[LangList[i].Language] = LangList[i].Text
	end
end

function FontDemo.generateNewFontName()
    local fileName = d_fontFileNameSelector:getText()
    local pointSize = d_fontSizeEditbox:getText()

    local fontName = fileName .. '-' .. pointSize

    d_fontNameEditbox:setText(fontName)
end

function FontDemo.initialiseAutoScaleCombobox()
    for i = 1, #d_autoScaleOptionsArray do
    	local itemText = d_autoScaleOptionsArray[i]
    	d_fontAutoScaleCombobox:addItem(MyListItem(itemText, i))
    end
end

function FontDemo.getAutoScaleMode()
    local autoScaleString = d_fontAutoScaleCombobox:getSelectedItem():getText()

    for i = 1, #d_autoScaleOptionsArray do
    	if autoScaleString == d_autoScaleOptionsArray[i] then
            return i
        end
    end
    return 0
end

function FontDemo.findFontOption(fontName)
    for k, v in pairs(d_fontNameOptions) do
    	if k == fontName then
    		return v
    	end
    end
    return true
end

function FontDemo.initialiseFontEditorInfoLabel()
    d_fontEditorInfoLabel = root:getChild('FontDemoWindow/FontCreator/InfoLabel')

    --Create fadeout animation
    local anim = CEGUI.AnimationManager:getSingleton():createAnimation('ErrorDisplayAndFadeout')
    anim:setDuration(5)
    anim:setReplayMode(CEGUI.Animation.RM_Once)

    -- this affector changes YRotation and interpolates keyframes with float interpolator
    local affector = anim:createAffector('Alpha', 'float')
    affector:createKeyFrame(0.0, '1.0')
    affector:createKeyFrame(4.0, '1.0')
    affector:createKeyFrame(5.0, '0.0', CEGUI.KeyFrame.P_QuadraticDecelerating)

    --anim:defineAutoSubscription(CEGUI:Window:EventTextChanged, 'Stop');
    anim:defineAutoSubscription('TextChanged', 'Start')

    local instance = CEGUI.AnimationManager:getSingleton():instantiateAnimation(anim)
    -- after we instantiate the animation, we have to set its target window
    instance:setTargetWindow(d_fontEditorInfoLabel)

    -- at this point, you can start this instance and see the results
    instance:start()
end

function FontDemo.checkIfEditButtonShouldBeDisabled(font)
    local isEditable = findFontOption(font:getName())

    if not isEditable then
        d_fontEditButton:disable()
        d_fontEditButton:setTooltipText([[This demo won't allow editing of\n
            fonts that were created outside the demo or\n
            were loaded from .font files]])
    else
        d_fontEditButton:enable()
        d_fontEditButton:setTooltipText('')
    end
end

function FontDemo.initialiseDemoFonts()
    local fontManager = CEGUI.FontManager:getSingleton()
    fontManager:createFreeTypeFont('Junicode-14', 14, true, 'Junicode.ttf',
        CEGUI.Font:getDefaultResourceGroup(), CEGUI.ASM_Vertical, CEGUI.Sizef(1280.0, 720.0))

    fontManager:createFreeTypeFont('Klingon-pIqaD-HaSta-24', 24, true, 'Klingon-pIqaD-HaSta.ttf',
        CEGUI.Font:getDefaultResourceGroup(), CEGUI.ASM_Vertical, CEGUI.Sizef(1280.0, 720.0))

    fontManager:createFreeTypeFont('TnuaLibre-12', 12, true, 'Tnua-Libre.ttf',
        CEGUI.Font:getDefaultResourceGroup(), CEGUI.ASM_Vertical, CEGUI.Sizef(1280.0, 720.0))

    fontManager:createFreeTypeFont('RichStyle-22', 22.5, true, 'RichStyle.ttf',
        CEGUI.Font:getDefaultResourceGroup(), CEGUI.ASM_Vertical, CEGUI.Sizef(1280.0, 720.0))

    fontManager:createFreeTypeFont('FetteUNZFraktur-20', 20.0, true, 'FetteClassicUNZFraktur.ttf',
        CEGUI.Font:getDefaultResourceGroup(), CEGUI.ASM_Disabled, CEGUI.Sizef(1280.0, 720.0))

    fontManager:createFreeTypeFont('GreatVibes-22', 22, true, 'GreatVibes-Regular.ttf',
        CEGUI.Font:getDefaultResourceGroup(), CEGUI.ASM_Disabled, CEGUI.Sizef(1280.0, 720.0))

    fontManager:createFreeTypeFont('FellType-12.5', 12.5, true, 'IMFePIrm29P.ttf',
        CEGUI.Font:getDefaultResourceGroup(), CEGUI.ASM_Disabled, CEGUI.Sizef(1280.0, 720.0))

    fontManager:createFreeTypeFont('FutharkAdapted-18', 18, true, 'Futhark Adapted.ttf',
        CEGUI.Font:getDefaultResourceGroup(), CEGUI.ASM_Disabled, CEGUI.Sizef(1280.0, 720.0))

    fontManager:createFreeTypeFont('mizufalp-12', 12, true, 'mizufalp.ttf',
        CEGUI.Font:getDefaultResourceGroup(), CEGUI.ASM_Disabled, CEGUI.Sizef(1280.0, 720.0))
end
