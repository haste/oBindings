--[[-------------------------------------------------------------------------
  Copyright (c) 2007-2008, Trond A Ekseth
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

local wotlk = select(4, GetBuildInfo()) >= 3e4

local _G = getfenv(0)
local print = function(msg) ChatFrame1:AddMessage("|cff33ff99oBindings:|r "..tostring(msg)) end
local printf = function(f, ...) print(f:format(...)) end

local addon = CreateFrame"Frame"
local m = 1
local base, keys
local class = select(2, UnitClass"player")
local macros = {}

local angrymob = function(key, mod, action)
	if(type(key) == "number") then
		SetBinding(key, "ACTIONBUTTON"..key)
		return
	end

	key = key:gsub("^A%-", "ALT-"):gsub("^%^%-", "CTRL-"):gsub("^S%-", "SHIFT-")
	if(mod == "m") then
		local macro = CreateFrame("Button", "oRapeMacro"..m, UIParent, "SecureActionButtonTemplate")
		macro:SetAttribute("*type*", "macro")
		macro:SetAttribute("macrotext", action)
		m = m + 1

		SetBindingClick(key, macro:GetName())
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
		oBindingsDB = str
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
		for key, action in pairs(base) do
			local mod, action = action:match"(.-)|(.*)$"
			angrymob(key, mod, action)
		end
	end

	if(not (keys and keys[oBindingsDB])) then return end
	for key, action in pairs(keys[oBindingsDB]) do
		local mod, action = action:match"(.-)|(.*)$"
		if(type(key) == "number") then
			if(mod == "s") then
				PickupSpell(action)
			elseif(mod == "M") then
				local gl, ch = GetNumMacros()
				for i=1, ch do
					local offset  = wotlk and 36 or 18
					if('oB-'..action == GetMacroInfo(offset + i)) then
						PickupMacro(offset + i)
						break
					end
				end

				if(GetCursorInfo() ~= "macro") then
					for i=1, gl do
						if(action == GetMacroInfo(i)) then
							PickupMacro(i)
							break
						end
					end
				end
			elseif(mod == "m") then
				if(not macros[action]) then
					local key = 'oB-'..key
					local offset  = wotlk and 36 or 18
					local start = offset + select(2, GetNumMacros())
					for i=start, offset, -1 do
						if(GetMacroInfo(i) == key) then
							DeleteMacro(i)
						end
					end
					local id = CreateMacro(key, 1, action, 1, 1)
					PickupMacro(id)
					macros[action] = id
				else
					PickupMacro(macros[action])
				end
			elseif(mod == "i") then
				PickupItem(action)
			end

			PlaceAction(key)
			ClearCursor()

			if(key < 10 and key > 0) then
				angrymob(key)
			end
		else
			angrymob(key, mod, action)
		end
	end
end

addon.ADDON_LOADED = function(self, event, addon)
	if(addon:match"oBindings") then
		if(self.keys) then
			keys = self.keys[class]
			base = self.keys.base
		end

		if(not oBindingsDB and keys) then
			for k in pairs(keys) do
				_G.oBindingsDB = k
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
