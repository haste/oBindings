local _, bindings = ...

bindings.base = {
	F = "MOVEFORWARD",
	R = "TURNLEFT",
	S = "MOVEBACKWARD",
	T = "TURNRIGHT",

	B = "OPENALLBAGS",

	[';'] = "TOGGLESPELLBOOK",

	["CTRL-V"] = "m|/mount",

	F8 = "m|/run ReloadUI()",
	F9 = "TOGGLECHARACTER0",
	F10 = "TOGGLETALENTS",
}
