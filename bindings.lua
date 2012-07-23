local print = function(...)
	return print('|cff33ff99oBindings:|r', ...)
end

local printf = function(f, ...)
	return print(f:format(...))
end

local states = {
	'alt|[mod:alt]',
	'ctrl|[mod:ctrl]',
	'shift|[mod:shift]',

	'possess|[vehicleui]',

	-- No bar1 as that's our default anyway.
	'bar2|[bar:2]',
	'bar3|[bar:3]',
	'bar4|[bar:4]',
	'bar5|[bar:5]',
	'bar6|[bar:6]',

	'stealth|[form:1]',
	'shadowDance|[form:3]',

	'shadow|[stance:1]',

	'bear|[form:1]',
	'cat|[form:3]',
	'moonkin|[form:5]',

	-- Currently no way to detect if it's Prowl or other forms of stealth (Shadowmeld)
	'prowl|[form:3,stealth]',

	'battle|[stance:1]',
	'defensive|[stance:2]',
	'berserker|[stance:3]',

	'demon|[form:1]',

	--[[
		Monk information:

		If specced Windwalker, the approperiate stance is "Fierce Tiger" on [stance:1], and is the only stance
		If specced Mistweaver, the approperiate stance is "Wise Serpent" on [stance:2], and also has "Fierce Tiger" on [stance:2]
		If specced Brewmaster, the approperiate stance is "Sturdy Ox" on [stance:1], and also has "Fierce Tiger" on [stance:2]

		The below names are most likely temporary
	--]]
	'mainStance|[stance:1]',
	'altStance|[stance:2]',
}
-- it won't change anyway~
local numStates = #states

local hasState = function(st)
	for i=1,numStates do
		local state, data = string.split('|', states[i], 2)
		if(state == st) then
			return data
		end
	end
end

local _NAME = ...
local _NS = CreateFrame'Frame'
_G[_NAME] = _NS

local _BINDINGS = {}
local _BUTTONS = {}

local _CALLBACKS = {}

local _STATE = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
local _BASE = 'base'

function _STATE:Callbacks(state)
	for _, func in next, _CALLBACKS do
		func(self, state)
	end
end

_STATE:SetAttribute("_onstate-page", [[
   control:ChildUpdate('state-changed', newstate)
   control:CallMethod('Callbacks', newstate)
]])

function _NS:RegisterKeyBindings(name, ...)
	local bindings = {}
	
	for i=1, select('#', ...) do
		local tbl = select(i, ...)
		for key, action in next, tbl do
			if(type(action) == 'table') then
				for mod, modAction in next, action do
					if(not bindings[key]) then
						bindings[key] = {}
					end

					bindings[key][mod] = modAction
				end
			else
				bindings[key] = action
			end
		end
	end

	_BINDINGS[name] = bindings
end

function _NS:RegisterCallback(func)
	table.insert(_CALLBACKS, func)
end

local createButton = function(key)
	if(_BUTTONS[key]) then
		return _BUTTONS[key]
	end

	local btn = CreateFrame("Button", 'oBindings' .. key, _STATE, "SecureActionButtonTemplate");
	btn:SetAttribute('_childupdate-state-changed', [[
	   local type = message and self:GetAttribute('ob-' .. message .. '-type') or self:GetAttribute('ob-base-type')

	   -- It's possible to have buttons without a default state.
	   if(type) then
	      local attr, attrData = strsplit(',', (
	         message and self:GetAttribute('ob-' .. message .. '-attribute') or
	         self:GetAttribute('ob-base-attribute')
	      ), 2)
	      self:SetAttribute('type',type)
	      self:SetAttribute(attr, attrData)
	  end
	]])

	if(tonumber(key)) then
		btn:SetAttribute('ob-possess-type', 'action')
		btn:SetAttribute('ob-possess-attribute', 'action,' .. (key + 132))
	end

	_BUTTONS[key] = btn
	return btn
end

local clearButton = function(btn)
	for i=1, numStates do
		local key = string.split('|', states[i], 2)
		if(key ~= 'possess') then
			btn:SetAttribute(string.format('ob-%s-type', key), nil)
			key = (key == 'macro' and 'macrotext') or key
			btn:SetAttribute(string.format('ob-%s-attribute', key), nil)
		end
	end
end

local typeTable = {
	s = 'spell',
	i = 'item',
	m = 'macro',
}

local bindKey = function(key, action, mod)
	local modKey
	if(mod and (mod == 'alt' or mod == 'ctrl' or mod == 'shift')) then
		modKey = mod:upper() .. '-' .. key
	end

	local ty, action = string.split('|', action)
	if(not action) then
		SetBinding(modKey or key, ty)
	else
		local btn = createButton(key)
		ty = typeTable[ty]

		btn:SetAttribute(string.format('ob-%s-type', mod or 'base'), ty)
		ty = (ty == 'macro' and 'macrotext') or ty
		btn:SetAttribute(string.format('ob-%s-attribute', mod or 'base'), ty .. ',' .. action)

		SetBindingClick(modKey or key, btn:GetName())
	end
end

function _NS:LoadBindings(name)
	local bindings = _BINDINGS[name]

	if(bindings and self.activeBindings ~= name) then
		self.activeBindings = name
		for _, btn in next, _BUTTONS do
			clearButton(btn)
		end

		for key, action in next, bindings do
			if(type(action) ~= 'table') then
				bindKey(key, action)
			elseif(hasState(key)) then
				for modKey, action in next, action do
					bindKey(modKey, action, key)
				end
			end
		end

		local _states = ''
		for i=1, numStates do
			local key,state = string.split('|', states[i], 2)
			if(bindings[key] or key == 'possess') then
				_states = _states .. state .. key .. ';'
			end
		end

		RegisterStateDriver(_STATE, "page", _states .. _BASE)
		_STATE:Execute(([[
		   local state = '%s'
		   control:ChildUpdate('state-changed', state)
		   control:CallMethod('Callbacks', state)
		]]):format(_STATE:GetAttribute'state-page'))
	end
end

_NS:SetScript('OnEvent', function(self, event, ...)
	return self[event](self, event, ...)
end)

function _NS:ADDON_LOADED(event, addon)
	-- For the possess madness.
	if(addon == _NAME) then
		for i=0,9 do
			createButton(i)
		end

		self:UnregisterEvent(event)
		self.ADDON_LOADED = nil
	end
end
_NS:RegisterEvent"ADDON_LOADED"

function _NS:PLAYER_TALENT_UPDATE()
	local spec = GetSpecialization()
	if(not spec) then return end

	local _, specName = GetSpecializationInfo(spec)
	if(specName) then
		self:UnregisterEvent'PLAYER_TALENT_UPDATE'

		if(_BINDINGS[specName]) then
			print('Switching to set:', specName)
			self:LoadBindings(specName)
		else
			print('Unable to find any bindings.')
		end
	end
end
_NS:RegisterEvent"PLAYER_TALENT_UPDATE"

local specGroup
function _NS:ACTIVE_TALENT_GROUP_CHANGED(event, active)
	if(specGroup == active) then return end

	specGroup = active
	self:PLAYER_TALENT_UPDATE()
end
_NS:RegisterEvent"ACTIVE_TALENT_GROUP_CHANGED"
