--[[-------------------------------------------------------------------------
  Copyright (c) 2007, Trond A Ekseth
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

      * Redistributions of source code must retain the above copyright
        notice, this list of conditions and the following disclaimer.
      * Redistributions in binary form must reproduce the above
        copyright notice, this list of conditions and the following
        disclaimer in the documentation and/or other materials provided
        with the distribution.
      * Neither the name of oForcedBindings nor the names of its contributors
        may be used to endorse or promote products derived from this
        software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
---------------------------------------------------------------------------]]

local addon = CreateFrame"Frame"
local _G = getfenv(0)
local i = 0
local class = select(2, UnitClass"player")
local profiles = {
	PRIEST = "shadow",
	ROGUE = "combatd",
	WARLOCK = "affliction",
}
local profile = profiles[class]
local keys = {
	base = [=[
E		= c|MOVEFORWARD|
S		= c|TURNLEFT|
D		= c|MOVEBACKWARD|
F		= c|TURNRIGHT|
F8		= m|/run ReloadUI()|
F9		= c|TOGGLECHARACTER0|
	]=],
	PRIEST = {
		shadow = [=[
1		= s|Mind Flay|
2		= s|Shadow Word: Pain|
3		= s|Mind Blast|
4		= s|Flash Heal|
5		= s|Renew|
6		= s|Heal|
F5		= s|Power Word: Fortitude|
F6		= s|Shadow Protection|
F7		= s|Fear Ward|
F11		= s|Resurrection|
F12		= s|Shackle Undead|
W		= s|Power Word: Shield|
R		= s|Desperate Prayer|
T		= s|Fade|
G		= s|Mana Burn|
V		= s|Inner Fire|
X		= s|Shoot|
^-C		= s|Psychic Scream|
A-1		= s|Dispel Magic|
A-2		= s|Abolish Disease|
		]=],
	},
	-- TODO:
	WARLOCK = {
		combatd = [=[
		]=],
	},
	ROGUE = {
		affliction = [=[
		]=],
	},
}

local angrymob = function(key, mod, action)
	key = key:gsub("^A%-", "ALT-"):gsub("^%^%-", "CTRL-")
	if(mod == "m") then
		local m = CreateFrame("Button", "oRapeMacro"..i+1, UIParent, "SecureActionButtonTemplate")
		m:SetAttribute("*type*", "macro")
		m:SetAttribute("macrotext", action)
		i = i + 1

		SetBindingClick(key, m:GetName())
	elseif(mod == "c") then
		SetBinding(key, action)
	elseif(mod == "i") then
		SetBindingItem(key, action)
	elseif(mod == "s") then
		SetBindingSpell(key, action)
	end
end

addon:SetScript("OnEvent", function()
	for key, mod, action in keys.base:gmatch"(.-)\t\t=%s(.)|(.-)|\n" do
		angrymob(key, mod, action)
	end

	for key, mod, action in keys[class][profile]:gmatch"(.-)\t\t=%s(.)|(.-)|\n" do
		angrymob(key, mod, action)
	end
end)

addon:RegisterEvent"PLAYER_LOGIN"
