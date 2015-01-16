require("Echo.Binding")

local winMgr = CEGUI.WindowManager:getSingleton()
winMgr:subscribeEvent("WindowLayoutLoaded", "onWindowLayoutLoaded")
winMgr:subscribeEvent("WindowDestroyed", "onWindowDestroyed")
