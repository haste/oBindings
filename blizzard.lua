-- Stolen from Tuller's Dominos (again), with some changes
IconIntroTracker:UnregisterAllEvents()
MainMenuExpBar:UnregisterAllEvents()
OverrideActionBar:UnregisterAllEvents()
ActionBarController:UnregisterAllEvents()
ActionBarController:RegisterEvent'UPDATE_EXTRA_ACTIONBAR'

MainMenuBarArtFrame:UnregisterAllEvents()
MainMenuBarArtFrame:RegisterEvent'CURRENCY_DISPLAY_UPDATE'
MainMenuBarArtFrame:RegisterEvent'UNIT_LEVEL'

MainMenuBar:Hide()
