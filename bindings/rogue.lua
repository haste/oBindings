if(select(2, UnitClass'player') ~= 'ROGUE') then return end

local _, bindings = ...

local mutilate = {
	's|Mutilate',
	's|Backstab',
	's|Envenom',
	's|Kidney Shot',
	's|Dismantle',
	's|Cold Blood',
	's|Fan of Knives',

	P = 's|Evasion',
	D = 's|Kick',
	N = 's|Sprint',
	W = 's|Will of the Forsaken',
	X = 's|Throw',
	J = 's|Distract',
	C = 'm|/cast [@focus, help] Tricks of the Trade, [@target, help] Tricks of the Trade, [@targettarget, help] Tricks of the Trade',
	G = 's|Hunger for Blood',
	Q = 's|Slice and Dice',
	V = 's|Vanish',
	A = 's|Feint',

	BUTTON4 = 's|Cloak of Shadows',
	BUTTON5 = 's|Stealth',

	alt = {
		's|Rupture',
	},

	stealth = {
		's|Ambush',
		's|Cheap Shot',
		's|Sap',
		-- old habbit
		[5] = 's|Garrote',

		P = 's|Pick Pocket',
	},
}

oBindings:RegisterKeyBindings('51/18/2', bindings.base, mutilate)
