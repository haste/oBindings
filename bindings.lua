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
      * Neither the name of oBindings nor the names of its contributors
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

local _G = getfenv(0)
local print = function(msg) ChatFrame1:AddMessage("|cff33ff99oBindings:|r "..tostring(msg)) end
local printf = function(f, ...) print(f:format(...)) end

local addon = CreateFrame"Frame"
local db
local i = 0
local base, keys
local class = select(2, UnitClass"player")

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

local slashHandler = function(str)
	if(keys[str]) then
		db = str
		print"You probably want to reload your UI now..."
	else
		if(keys) then
			local profiles
			for k in pairs(keys) do
				profiles = (profiles and ", " or "")..k
			end
			printf("[%s] is an invalid profile. Valid profiles: %s", str, profiles)
		else
			print"No profiles found."
		end
	end
end

addon.PLAYER_LOGIN = function(self, event)
	if(base) then
		for key, mod, action in base:gmatch"(.-)\t\t=%s(.)|(.-)|\n" do
			angrymob(key, mod, action)
		end
	end

	if(not (keys and keys[db])) then return end
	for key, mod, action in keys[db]:gmatch"(.-)\t\t=%s(.)|(.-)|\n" do
		angrymob(key, mod, action)
	end
end

addon.ADDON_LOADED = function(self, event, addon)
	if(addon:match"oBindings") then
		db = _G.oBindingsDB

		if(self.keys) then
			keys = self.keys[class]
			base = self.keys.base
		end

		if(not db and keys and keys[db]) then
			for k in pairs(keys[db]) do
				db = k
				_G.oBindingsDB = db
				break
			end
		end
	end
end

addon:SetScript("OnEvent", function(self, event, ...)
	self[event](self, event, ...)
end)

addon:RegisterEvent"PLAYER_LOGIN"
addon:RegisterEvent"ADDON_LOADED"

_G.SlashCmdList['OBINDINGS_SETPROFILE'] = slashHandler
_G.SLASH_OBINDINGS_SETPROFILE1 = '/ob'
_G.oBindings = addon
