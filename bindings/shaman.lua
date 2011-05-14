if(select(2, UnitClass'player') ~= 'SHAMAN') then return end

local _, bindings = ...

local elemental = {
	's|Lightning Bolt',
	's|Chain Lightning',

	[4] = 's|Flame Shock',
	[5] = 's|Elemental Mastery',

	V = 's|Water Shield',

	BUTTON4 = 's|Totemic Recall',
	BUTTON5 = 's|Call of the Elements',

	shift = {
		V = 's|Flametongue Weapon',
	},
}

oBindings:RegisterKeyBindings('Elemental', bindings.base, elemental)
