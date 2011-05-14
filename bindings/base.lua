local _, bindings = ...

bindings.base = {
	F = "MOVEFORWARD",
	R = "STRAFELEFT",
	S = "MOVEBACKWARD",
	T = "STRAFERIGHT",

	B = "OPENALLBAGS",

	[';'] = "TOGGLESPELLBOOK",

	ctrl = {
		V = 'm|/mount'
	},

	F8 = "m|/run ReloadUI()",
	F9 = "TOGGLECHARACTER0",
	F10 = "TOGGLETALENTS",
}
