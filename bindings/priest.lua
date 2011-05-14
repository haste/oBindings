if(select(2, UnitClass'player') ~= 'PRIEST') then return end

local _, bindings = ...


local healBase = {
	's|Prayer of Mending',
	[3] = 's|Prayer of Healing',
	[5] = 's|Smite',
	[6] = 's|Renew',
	[7] = 's|Hymn of Hope',

	shift = {
		[3] = 's|Shadow Word: Pain',
		[4] = 's|Holy Nova',

		F5 = 's|Power Word: Fortitude',
		F6 = 's|Shadow Protection',
	},

	alt = {
		's|Dispel Magic',
		's|Cure Disease',
	},

	ctrl = {
		[[m|/cast [nopet] Shadowfiend
/petattack
/cast Shadowcrawl]],
's|Mind Control',

		C = 's|Psychic Scream'
	},

	W = 's|Power Word: Shield',
	G = 's|Fade',
	C = 'm|/use 14',
	Q = 's|Mass Dispel',
	X = 's|Shoot',
	A = 's|Binding Heal',

	['`'] = 's|Power Word: Barrier',

	F5 = 's|Power Word: Fortitude',
	F6 = 's|Shadow Protection',
	F7 = 's|Fear Ward',
	F11 = 's|Resurrection',
	F12 = [[m|/clearfocus [modifier:alt][@focus,dead][@focus,help][@focus,noexists]
/focus [@focus,noexists]
/cast [@focus]Shackle Undead]]
}

local disc = {
	[2] = 's|Penance',
	[4] = 's|Holy Fire',

	V = 's|Inner Will',
	H = 's|Power Infusion',

	shift = {
		[3] = 's|Archangel',
	},

	ctrl = {
		[3] = 's|Pain Suppression',
	},
}

local holy = {
	[2] = 's|Circle of Healing',
	[4] = 's|Divine Hymn',

	V = 's|Inner Will',
	['`'] = 's|Leap of Faith',

	BUTTON4 = 's|Lightwell',
	BUTTON5 = 's|Chakra',

	ctrl = {
		[3] = 's|Guardian Spirit',
		[4] = 'm|/click ActionButton1',
	},
}

local shadow = {
	"s|Shadow Word: Death",
	"s|Shadow Word: Pain",
	"s|Vampiric Touch",
	"m|/cast [nochanneling:Mind Flay] Mind Flay",
	"m|/cast [nochanneling:Mind Flay] Mind Blast",
	"s|Dispersion",

	V = 's|Inner Fire',
	A = 's|Mind Spike',

	BUTTON4 = 's|Mind Sear',
	BUTTON5 = 's|Shadowform',

	shift = {
		"s|Devouring Plague",
		"s|Shadow Word: Pain (Rank 1)",
		's|Archangel',
		"s|Flash Heal",
		"s|Greater Heal",
		V = "s|Vampiric Embrace",
	},

	alt = {
		[1] = "s|Dispel Magic",
		[2] = "s|Cure Disease",
	},

	ctrl = {
		[[m|/cast [nopet] Shadowfiend
/petattack
/cast Shadowcrawl]],

		[2] = "s|Mind Control",
		C = 's|Psychic Scream',
	},

	W = "s|Power Word: Shield",
	G = "s|Fade",
	C = "m|/use 14",
	D = "s|Mana Burn",
	Q = "s|Mass Dispel",
	V = "s|Inner Fire",
	X = "s|Shoot",

	F5 = "s|Power Word: Fortitude",
	F6 = "s|Shadow Protection",
	F7 = "s|Fear Ward",
	F11 = "s|Resurrection",
	F12 = [[m|/clearfocus [modifier:alt][@focus,dead][@focus,help][@focus,noexists]
/focus [@focus,noexists]
/cast [@focus]Shackle Undead]],
}

oBindings:RegisterKeyBindings('Discipline', bindings.base, healBase, disc)
oBindings:RegisterKeyBindings('Holy', bindings.base, healBase, holy)
oBindings:RegisterKeyBindings('Shadow', bindings.base, shadow)
