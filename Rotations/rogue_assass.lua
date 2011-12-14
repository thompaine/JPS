function rogue_assass(self)
	--jpganis+simcraft original, modified by thakkrad.
	local cp = GetComboPoints("player")
	local rupture_duration = jps.debuffDuration("rupture")
	local snd_duration = jps.buffDuration("slice and dice")
	local recuperate_duration = jps.buffDuration("recuperate")
	local energy = UnitMana("player")
	local targetClass = UnitClass("target")
	local me = "player"
	local focus = "focus"
	local shouldDisarm = targetClass == "Warrior" or targetClass == "Rogue" or targetClass == "Death Knight"
	local shouldCloak = targetClass == "Warlock" or targetClass == "Priest" or targetClass == "Mage"
	local feared = jps.debuff("intimidating shout","player") or jps.debuff("howl of terror","player") or jps.debuff("psychic scream","player")
	local r = RunMacroText
	local pvptrink = "/use 14"
	local mh, _, _, oh, _, _, te, _, _ =GetWeaponEnchantInfo()
	local mhp = "/use Wound Poison\n/use 16"
	local ohp = "/use Deadly Poison\n/use 17"
	local tep = "/use Mind-Numbing Poison\n/use 18"
	
	local spellTable =
	{
		-- Set Me Up.
		-- Applies the PVP Poisons to the three weapons.
		{ {"macro", ohp },	not oh},
		{ {"macro", tep },	not te},
		{ {"macro", mhp },	not mh},
		
		-- Break Fear with PVP Trinket
		{ {"macro","/use pvptrink"}, feared},
		
		{ "envenom", jps.LastCast == "cold blood" },
		{ "vendetta" },
		{ "smoke bomb",	jps.hp() < 0.4 },
		{ "slice and dice", not jps.buff("slice and dice") },
		{ "Cloak of Shadows",	shouldCloak and jps.cd("cloak of shadows") ==0 },
		{ "Dismantle",		shouldDisarm and jps.cd("dismantle") == 0 },
		{ "Combat Readiness",       shouldDisarm and jps.cd("combat readiness") == 0 },
		{ "Recuperate", not jps.buff("recuperate") },
		{ "Evasion",		jps.hp() < 0.6 and not ub("player","evasion") },
		{ "Kick",		jps.Interrupts and jps.shouldKick("target") and jps.cd("kick") == 0 },
		{ "stoneform", jps.hp() < 0.6 or jps.debuff("rip","player") },
		{ "rupture", rupture_duration <  2 },
		{ "cold blood", cp == 5 },
		{ "envenom", cp >= 4 and not jps.buff("envenom") },
		{ "envenom", cp >= 4 and energy >= 90 },
		{ "envenom", cp >= 2 and snd_duration < 3 },
		{ "mutilate",	"onCD" },
		--{ "vanish", energy > 50 and not jps.buff("overkill") },
	}

	return parseSpellTable( spellTable )
end
