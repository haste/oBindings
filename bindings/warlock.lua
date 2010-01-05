if(select(2, UnitClass'player') ~= 'WARLOCK') then return end

local _, bindings = ...

local affliction = {
	's|Haunt',
	's|Shadow Bolt',
	's|Drain Soul',
	's|Corruption',
	's|Unstable Affliction',
	's|Life Tap',

	P = 's|Death Coil',
	G = 's|Soulshatter',
	V = 's|Fel Armor',
	C = 's|Enslave Demon',
	X = 's|Shoot',
	W = 's|Fear',
	D = 's|Health Funnel',

	BUTTON5 = 'm|/swapactionbar 1 2',

	F12 = 's|Banish',

	alt = {
		's|Seed of Corruption',
		's|Drain Life',
		's|Drain Mana',
	},

	shift = {
		V = 's|Shadow Ward',
	},

	ctrl = {
		's|Summon Imp',
		's|Summon Voidwalker',
		's|Summon Succubus',
		's|Summon Felhunter',

		C = 's|Howl of Terror',
	},

	bar2 = {
		's|Curse of Agony',
		's|Curse of Weakness',
		's|Curse of the Elements',
		's|Curse of Tongues',
		's|Curse of Doom',
	},
}

oBindings:RegisterCallback(function(self, state)
	if(oPanel and oPanel.fade) then
		if(state == 'bar2') then
			oPanel.fade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .35, .25, 1)
		elseif(state == 'base') then
			oPanel.fade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .35, 1)
		end
	end
end)

oBindings:RegisterKeyBindings('Affliction', bindings.base, affliction)
