-- Stolen from Tuller's Dominos, with some changes.
local noop = Multibar_EmptyFunc
MultiActionBar_Update = noop
MultiActionBar_UpdateGrid = noop
ShowBonusActionBar = noop

UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarRight'] = nil
UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarLeft'] = nil
UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarBottomLeft'] = nil
UIPARENT_MANAGED_FRAME_POSITIONS['MultiBarBottomRight'] = nil
UIPARENT_MANAGED_FRAME_POSITIONS['MainMenuBar'] = nil
UIPARENT_MANAGED_FRAME_POSITIONS['ShapeshiftBarFrame'] = nil
UIPARENT_MANAGED_FRAME_POSITIONS['PossessBarFrame'] = nil
UIPARENT_MANAGED_FRAME_POSITIONS['PETACTIONBAR_YPOS'] = nil

MainMenuBar:UnregisterAllEvents()
MainMenuBar:Hide()

MainMenuBarArtFrame:UnregisterEvent('PLAYER_ENTERING_WORLD')
MainMenuBarArtFrame:UnregisterEvent('BAG_UPDATE') --needed to display stuff on the backpack button
MainMenuBarArtFrame:UnregisterEvent('ACTIONBAR_PAGE_CHANGED')
--      MainMenuBarArtFrame:UnregisterEvent('KNOWN_CURRENCY_TYPES_UPDATE') --needed to display the token tab
--      MainMenuBarArtFrame:UnregisterEvent('CURRENCY_DISPLAY_UPDATE')
MainMenuBarArtFrame:UnregisterEvent('ADDON_LOADED')
MainMenuBarArtFrame:UnregisterEvent('UNIT_ENTERING_VEHICLE')
MainMenuBarArtFrame:UnregisterEvent('UNIT_ENTERED_VEHICLE')
MainMenuBarArtFrame:UnregisterEvent('UNIT_EXITING_VEHICLE')
MainMenuBarArtFrame:UnregisterEvent('UNIT_EXITED_VEHICLE')
MainMenuBarArtFrame:Hide()

MainMenuExpBar:UnregisterAllEvents()
MainMenuExpBar:Hide()

ShapeshiftBarFrame:UnregisterAllEvents()
ShapeshiftBarFrame:Hide()

BonusActionBarFrame:UnregisterAllEvents()
BonusActionBarFrame:Hide()

PossessBarFrame:UnregisterAllEvents()
PossessBarFrame:Hide()

hooksecurefunc('TalentFrame_LoadUI', function()
	PlayerTalentFrame:UnregisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
end)
