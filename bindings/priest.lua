if(select(2, UnitClass'player') ~= 'PRIEST') then return end

local _, bindings = ...

local healBase = {
	's|Prayer of Mending',
	[3] = 's|Prayer of Healing',
	[4] = 's|Holy Fire',
	[5] = 's|Smite',
	[6] = 's|Renew',
	[7] = 's|Hymn of Hope',

	shift = {
		[4] = 's|Holy Nova',

		F5 = 's|Prayer of Fortitude',
		F6 = 's|Prayer of Spirit',
		F7 = 's|Prayer of Shadow Protection',
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
	V = 's|Inner Fire',
	X = 's|Shoot',
	A = 's|Binding Heal',

	F5 = 's|Power Word: Fortitude',
	F6 = 's|Divine Spirit',
	F7 = 's|Fear Ward',
	F11 = 's|Resurrection',
	F12 = [[m|/clearfocus [modifier:alt][@focus,dead][@focus,help][@focus,noexists]
/focus [@focus,noexists]
/cast [@focus]Shackle Undead]]
}

local disc = {
	[2] = 's|Penance',
	H = 's|Power Infusion',

	ctrl = {
		[3] = 's|Pain Suppression',
	},
}

local holy = {
	[2] = 's|Circle of Healing',

	ctrl = {
		[3] = 's|Guardian Spirit',
	},
}

oBindings:RegisterKeyBindings('Discipline', bindings.base, healBase, disc)
oBindings:RegisterKeyBindings('Holy', bindings.base, healBase, holy)
