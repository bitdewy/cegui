require("Echo.Binding")

CEGUI.WindowManager:getSingleton():subscribeEvent("WindowLayoutLoaded", "windowLayoutLoadedHandler")
