if(select(2, UnitClass'player') ~= 'WARLOCK') then return end

local _, bindings = ...

local affliction = {
	's|Drain Life',
	's|Drain Soul',
	's|Unstable Affliction',
	's|Corruption',
	's|Life Tap',
	's|Haunt',

	['`'] = 'm|/use [mod:alt]Demonic Circle: Summon;[nomod:alt]Demonic Circle: Teleport',

	A = 's|Shadowflame',
	Z = 's|Soul Harvest',
	P = 's|Death Coil',
	W = 's|Fear',
	X = 's|Shoot',
	Q = 's|Shadowburn',
	G = 's|Soulshatter',
	V = 's|Demon Soul',
	D = 'm|/target Obnoxious Fiend',

	F1 = 's|Summon Imp',
	F2 = 's|Summon Voidwalker',
	F3 = 's|Summon Succubus',
	F4 = 's|Summon Felhunter',

	F7 = 's|Fel Armor',
	F8 = 's|Dark Intent',

	F11 = 's|Ritual of Summoning',
	F12 = 's|Enslave Demon',

	BUTTON4 = 'm|/petattack',
	BUTTON5 = 'm|/swapactionbar 1 2',

	shift = {
		's|Immolate',
		's|Corruption',
		's|Shadow Bolt',

		V = 's|Shadow Ward',
	},

	alt = {
		's|Seed of Corruption',
		's|Shadowfury',
	},

	ctrl = {
		C = 's|Howl of Terror'
	},

	bar2 = {
		's|Bane of Agony',
		's|Bane of Doom',
		's|Bane of Havoc',
		's|Curse of the Elements',
		's|Curse of Tongues',
	},
}

local destruction = {
	's|Incinerate',
	's|Conflagrate',
	's|Chaos Bolt',
	's|Soul Fire',
	's|Life Tap',

	['`'] = 'm|/use [mod:alt]Demonic Circle: Summon;[nomod:alt]Demonic Circle: Teleport',

	A = 's|Shadowflame',
	Z = 's|Soul Harvest',
	P = 's|Death Coil',
	W = 's|Fear',
	X = 's|Shoot',
	Q = 's|Shadowburn',
	G = 's|Soulshatter',
	V = 's|Demon Soul',
	D = 'm|/target Obnoxious Fiend',

	F1 = 's|Summon Imp',
	F2 = 's|Summon Voidwalker',
	F3 = 's|Summon Succubus',
	F4 = 's|Summon Felhunter',

	F7 = 's|Fel Armor',
	F8 = 's|Dark Intent',

	F11 = 's|Ritual of Summoning',
	F12 = 's|Enslave Demon',


	shift = {
		's|Immolate',
		's|Corruption',

		V = 's|Shadow Ward',
	},

	alt = {
		's|Seed of Corruption',
		's|Shadowfury',
	},

	ctrl = {
		C = 's|Howl of Terror'
	},

	bar2 = {
		's|Bane of Agony',
		's|Bane of Doom',
		's|Bane of Havoc',
		's|Curse of the Elements',
		's|Curse of Tongues',
	},
}

local demonology = {
	's|Incinerate',
	"s|Hand of Gul'dan",
	's|Shadow Bolt',
	's|Soul Fire',
	's|Life Tap',

	['`'] = 'm|/use [mod:alt]Demonic Circle: Summon;[nomod:alt]Demonic Circle: Teleport',

	A = 's|Shadowflame',
	Z = 's|Soul Harvest',
	P = 's|Death Coil',
	W = 's|Fear',
	X = 's|Shoot',
	Q = 's|Shadowburn',
	G = 's|Soulshatter',
	V = 's|Demon Soul',
	D = 'm|/target Obnoxious Fiend',

	F1 = 's|Summon Imp',
	F2 = 's|Summon Voidwalker',
	F3 = 's|Summon Succubus',
	F4 = 's|Summon Felhunter',
	F5 = 's|Summon Felguard',

	F7 = 's|Fel Armor',
	F8 = 's|Dark Intent',

	F11 = 's|Ritual of Summoning',
	F12 = 's|Enslave Demon',

	BUTTON4 = 'm|/petattack',
	BUTTON5 = 'm|/swapactionbar 1 2',

	shift = {
		's|Immolate',
		's|Corruption',
		"s|Hand of Gul'dan",
		"s|Immolation Aura",

		V = 's|Metamorphosis',
	},

	alt = {
		's|Seed of Corruption',
		's|Shadowfury',
	},

	ctrl = {
		C = 's|Howl of Terror'
	},

	bar2 = {
		's|Bane of Agony',
		's|Bane of Doom',
		's|Bane of Havoc',
		's|Curse of the Elements',
		's|Curse of Tongues',
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
oBindings:RegisterKeyBindings('Destruction', bindings.base, destruction)
oBindings:RegisterKeyBindings('Demonology', bindings.base, demonology)
