local print = function(...)
	return print('|cff33ff99oBindings:|r', ...)
end

local printf = function(f, ...)
	return print(f:format(...))
end

local states = {
	alt = '[mod:alt]',
	ctrl = '[mod:ctrl]',
	shift = '[mod:shift]',

	-- No bar1 as that's our default anyway.
	bar2 = '[bar:2]',
	bar3 = '[bar:3]',
	bar4 = '[bar:4]',
	bar5 = '[bar:5]',
	bar6 = '[bar:6]',

	possess = '[bonusbar:5]',

	stealth = '[bonusbar:1,stealth]',
	shadowDance = '[form:3]',

	shadow = '[bonusbar:1]',
}

local _NAME = ...
local _NS = CreateFrame'Frame'

local _BINDINGS = {}
local _BUTTONS = {}

local _STATE = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
local _BASE = 'base'

_STATE:SetAttribute("_onstate-page", [[
   control:ChildUpdate('state-changed', newstate)
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
	      ))
	      self:SetAttribute('type',type)
	      self:SetAttribute(attr, attrData)
	  end
	]])

	if(tonumber(key)) then
		btn:SetAttribute('ob-possess-type', 'action')
		btn:SetAttribute('ob-possess-attribute', 'action,' .. (key + 120))
	end

	_BUTTONS[key] = btn
	return btn
end

local clearButton = function(key)
	local btn = _BUTTONS[key]
	if(btn) then
		for key in next, states do
			if(key ~= 'possess') then
				btn:SetAttribute(string.format('ob-%s-type', key), nil)
				key = (key == 'macro' and 'macrotext') or key
				btn:SetAttribute(string.format('ob-%s-attribute', key), nil)
			end
		end
	end
end

local typeTable = {
	s = 'spell',
	i = 'item',
	m = 'macro',
}

local bindKey = function(key, action, mod)
	if(mod) then
		key = mod:upper() .. '-' .. key
	end

	local ty, action = string.split('|', action)
	if(not action) then
		SetBinding(key, ty)
	else
		local btn = createButton(key)
		ty = typeTable[ty]

		btn:SetAttribute('ob-base-type', ty)
		ty = (ty == 'macro' and 'macrotext') or ty
		btn:SetAttribute('ob-base-attribute', ty .. ',' .. action)

		SetBindingClick(key, btn:GetName())
	end
end

function _NS:LoadBindings(name)
	local bindings = _BINDINGS[name]
	local _states = ''

	if(bindings) then
		for _, btn in next, _BUTTONS do
			clearButton(btn)
		end

		for key, action in next, bindings do
			if(type(action) ~= 'table') then
				bindKey(key, action)
			elseif(states[key]) then
				_states = _states .. states[key] .. key .. ';'
				for modKey, action in next, action do
					bindKey(modKey, action, key)
				end
			end
		end
	else
		print('No bindings found')
	end

	RegisterStateDriver(_STATE, "page", _states .. states.possess .. 'possess;' .. _BASE)
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
	end
end

function _NS:UPDATE_BINDINGS(event)
	self:UnregisterEvent'UPDATE_BINDINGS'
	self:LoadBindings(oBindingsDB)
end

_NS:RegisterEvent"UPDATE_BINDINGS"
_NS:RegisterEvent"ADDON_LOADED"

_G[_NAME] = _NS
