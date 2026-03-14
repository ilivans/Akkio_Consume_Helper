-- Akkio's Consume Helper - Data Table
-- This file contains all the buff definitions and their corresponding icons
-- Global table to store all buff data

Akkio_Consume_Helper_Data = {}

Akkio_Consume_Helper_Data.allBuffs = {

  { header = true,                               name = "Class Buffs" },
  { name = "Power Word: Fortitude",              icon = "Interface\\Icons\\Spell_Holy_WordFortitude",    buffIcon = "Interface\\Icons\\Spell_Holy_WordFortitude",       raidbuffIcon = "Interface\\Icons\\Spell_Holy_PrayerOfFortitude",         canBeAnounced = true, spellID = 1243},
  { name = "Divine Spirit",                      icon = "Interface\\Icons\\Spell_Holy_DivineSpirit",     buffIcon = "Interface\\Icons\\Spell_Holy_DivineSpirit",        raidbuffIcon = "Interface\\Icons\\Spell_Holy_PrayerofSpirit",            canBeAnounced = true, spellID = 14752},
  { name = "Arcane Intellect",                   icon = "Interface\\Icons\\Spell_Holy_MagicalSentry",    buffIcon = "Interface\\Icons\\Spell_Holy_MagicalSentry",       raidbuffIcon = "Interface\\Icons\\Spell_Holy_ArcaneIntellect",           canBeAnounced = true, spellID = 1459},
  { name = "Mark of the wild",                   icon = "Interface\\Icons\\Spell_Nature_Regeneration",   buffIcon = "Interface\\Icons\\Spell_Nature_Regeneration",                                                                               canBeAnounced = true, spellID = 1126},
  { name = "Thorns",                             icon = "Interface\\Icons\\Spell_Nature_Thorns",         buffIcon = "Interface\\Icons\\Spell_Nature_Thorns",                                                                                     canBeAnounced = true, spellID = 16877},
  { name = "Emerald Blessing",                   icon = "Interface\\Icons\\spell_nature_protectionformnature", buffIcon = "Interface\\Icons\\spell_nature_protectionformnature",                                                                 canBeAnounced = true, spellID = 57108},
  { name = "Battle Shout",                       icon = "Interface\\Icons\\Ability_Warrior_BattleShout", buffIcon = "Interface\\Icons\\Ability_Warrior_BattleShout",                                                                             canBeAnounced = true, spellID = 25959},
  { name = "Blessing of Sanctuary",              icon = "Interface\\Icons\\Spell_Nature_LightningShield",buffIcon = "Interface\\Icons\\Spell_Nature_LightningShield",   raidbuffIcon = "Interface\\Icons\\Spell_Nature_LightningShield",         canBeAnounced = true, spellID = 20204},
  { name = "Blessing of Salvation",              icon = "Interface\\Icons\\Spell_Holy_SealOfSalvation",  buffIcon = "Interface\\Icons\\Spell_Holy_SealOfSalvation",     raidbuffIcon = "Interface\\Icons\\Spell_Holy_GreaterBlessingofSalvation",canBeAnounced = true, spellID = 1038},
  { name = "Blessing of Might",                  icon = "Interface\\Icons\\Spell_Holy_FistOfJustice",    buffIcon = "Interface\\Icons\\Spell_Holy_FistOfJustice",       raidbuffIcon = "Interface\\Icons\\Spell_Holy_GreaterBlessingofKings",    canBeAnounced = true, spellID = 19740},
  { name = "Blessing of Wisdom",                 icon = "Interface\\Icons\\Spell_Holy_SealOfWisdom",     buffIcon = "Interface\\Icons\\Spell_Holy_SealOfWisdom",        raidbuffIcon = "Interface\\Icons\\Spell_Holy_GreaterBlessingofWisdom",   canBeAnounced = true, spellID = 19742},
  { name = "Blessing of Kings",                  icon = "Interface\\Icons\\Spell_Magic_Magearmor",       buffIcon = "Interface\\Icons\\Spell_Magic_MageArmor",          raidbuffIcon = "Interface\\Icons\\Spell_Magic_GreaterBlessingofKings",   canBeAnounced = true, spellID = 20217},
  { name = "Blessing of Light",                  icon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02",buffIcon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02",   raidbuffIcon = "Interface\\Icons\\Spell_Holy_GreaterBlessingofLight",    canBeAnounced = true, spellID = 19977},
  { name = "Void Stone",                         icon = "Interface\\Icons\\inv_enchant_voidsphere",      buffIcon = "Interface\\Icons\\inv_enchant_voidsphere",         raidbuffIcon = "Interface\\Icons\\inv_enchant_voidsphere",               canBeAnounced = true, spellID = 52751},

  { header = true,                               name = "Flasks" },
  { name = "Flask of the Titans",                icon = "Interface\\Icons\\INV_Potion_62",               buffIcon = "Interface\\Icons\\INV_Potion_62",                                                                                           canBeAnounced = false, duration = 7200, itemID = 13510 },
  { name = "Flask of Supreme Power",             icon = "Interface\\Icons\\INV_Potion_41",               buffIcon = "Interface\\Icons\\INV_Potion_41",                                                                                           canBeAnounced = false, duration = 7200, itemID = 13512 },
  { name = "Flask of Distilled Wisdom",          icon = "Interface\\Icons\\INV_Potion_97",               buffIcon = "Interface\\Icons\\INV_Potion_97",                                                                                           canBeAnounced = false, duration = 7200, itemID = 13511 },
                                  
  { header = true,                               name = "Elixirs & Concoctions" },
  { name = "Elixir of the Mongoose",             icon = "Interface\\Icons\\Inv_potion_32",               buffIcon = "Interface\\Icons\\INV_Potion_32",                                                                                           canBeAnounced = false, duration = 3600, itemID = 13452 },
  { name = "Elixir of Fortitude",                icon = "Interface\\Icons\\Inv_potion_43",               buffIcon = "Interface\\Icons\\INV_Potion_44",                                                                                           canBeAnounced = false, duration = 3600, itemID = 3825 },
  { name = "Elixir of Giants",                   icon = "Interface\\Icons\\Inv_Potion_61",               buffIcon = "Interface\\Icons\\INV_Potion_61",                                                                                           canBeAnounced = false, duration = 3600, itemID = 9206 },
  { name = "Elixir of Superior Defense",         icon = "Interface\\Icons\\Inv_Potion_66",               buffIcon = "Interface\\Icons\\INV_Potion_86",                                                                                           canBeAnounced = false, duration = 3600, itemID = 13445 },
  { name = "Elixir of Greater Intellect",        icon = "Interface\\Icons\\INV_Potion_124",              buffIcon = "Interface\\Icons\\inv_potion_124",                                                                                          canBeAnounced = false, duration = 3600, itemID = 9179 },
  { name = "Dreamshard Elixir",                  icon = "Interface\\Icons\\INV_Potion_113",              buffIcon = "Interface\\Icons\\inv_potion_113",                                                                                          canBeAnounced = false, duration = 3600, itemID = 61224 },
  { name = "Greater Arcane Elixir",              icon = "Interface\\Icons\\Inv_Potion_25",               buffIcon = "Interface\\Icons\\INV_Potion_25",                                                                                           canBeAnounced = false, duration = 3600, itemID = 13454 },
  { name = "Elixir of Shadow Power",             icon = "Interface\\Icons\\Inv_Potion_46",               buffIcon = "Interface\\Icons\\INV_Potion_46",                                                                                           canBeAnounced = false, duration = 3600, itemID = 9264 },
  { name = "Elixir of Greater Firepower",        icon = "Interface\\Icons\\Inv_Potion_60",               buffIcon = "Interface\\Icons\\INV_Potion_60",                                                                                           canBeAnounced = false, duration = 3600, itemID = 21546 },
  { name = "Elixir of Greater Arcane Power",     icon = "Interface\\Icons\\Inv_Potion_81",               buffIcon = "Interface\\Icons\\Spell_Holy_FlashHeal",                                                                                    canBeAnounced = false, duration = 3600, itemID = 55048 },
  { name = "Elixir of Greater Frost Power",      icon = "Interface\\Icons\\Inv_Potion_13",               buffIcon = "Interface\\Icons\\INV_Potion_03",                                                                                           canBeAnounced = false, duration = 3600, itemID = 55046 },
  { name = "Elixir of Greater Nature Power",     icon = "Interface\\Icons\\inv_potion_106",              buffIcon = "Interface\\Icons\\inv_potion_106",                                                                                          canBeAnounced = false, duration = 3600, itemID = 50237 },
  { name = "Elixir of Frost Power",              icon = "Interface\\Icons\\INV_Potion_115",              buffIcon = "Interface\\Icons\\INV_Potion_03",                                                                                           canBeAnounced = false, duration = 1800, itemID = 17708 },
  { name = "Concoction of the Emerald Mongoose", icon = "Interface\\Icons\\inv_blue_gold_elixir_2",      buffIcon = "Interface\\Icons\\inv_blue_gold_elixir_2",                                                                                  canBeAnounced = false, duration = 3600, itemID = 47410 },
  { name = "Concoction of the Arcane Giant",     icon = "Interface\\Icons\\inv_yellow_purple_elixir_2",  buffIcon = "Interface\\Icons\\inv_yellow_purple_elixir_2",                                                                              canBeAnounced = false, duration = 3600, itemID = 47412 },
  { name = "Concoction of the Dreamwater",       icon = "Interface\\Icons\\inv_green_pink_elixir_1",     buffIcon = "Interface\\Icons\\inv_green_pink_elixir_1",                                                                                 canBeAnounced = false, duration = 1200, itemID = 47414 },

  { header = true,                               name = "Juju" },
  { name = "Juju Might",                         icon = "Interface\\Icons\\INV_Misc_MonsterScales_07",   buffIcon = "Interface\\Icons\\INV_Misc_MonsterScales_07",                                                                               canBeAnounced = false, duration = 1800, itemID = 12460 },
  { name = "Juju Power",                         icon = "Interface\\Icons\\INV_Misc_MonsterScales_11",   buffIcon = "Interface\\Icons\\INV_Misc_MonsterScales_11",                                                                               canBeAnounced = false, duration = 1800, itemID = 12451 },
  { name = "Juju Flurry",                        icon = "Interface\\Icons\\INV_Misc_MonsterScales_17",   buffIcon = "Interface\\Icons\\INV_Misc_MonsterScales_17",                                                                               canBeAnounced = false, duration = 20, itemID = 12450 },

  { header = true,                               name = "Special Potions & Consumables" },
  { name = "Spirit of Zanza",                    icon = "Interface\\Icons\\INV_Potion_30",               buffIcon = "Interface\\Icons\\INV_Potion_30",                                                                                           canBeAnounced = false, duration = 7200, itemID = 20079 },
  { name = "Mageblood Potion",                   icon = "Interface\\Icons\\Inv_Potion_45",               buffIcon = "Interface\\Icons\\INV_Potion_45",                                                                                           canBeAnounced = false, duration = 3600, itemID = 20007 },
  { name = "Major Troll's Blood Potion",         icon = "Interface\\Icons\\INV_Potion_80",               buffIcon = "Interface\\Icons\\INV_Potion_79",                                                                                           canBeAnounced = false, duration = 3600, itemID = 20004 },
  { name = "Gizzard Gum",                        icon = "Interface\\Icons\\inv_misc_food_30",            buffIcon = "Interface\\Icons\\Spell_Fire_Incinerate",                                                                                   canBeAnounced = false, duration = 3600, itemID = 8424 },
  { name = "Ground Scorpok Assay",               icon = "Interface\\Icons\\INV_Misc_Dust_07",            buffIcon = "Interface\\Icons\\Spell_Nature_ForceOfNature",                                                                              canBeAnounced = false, duration = 3600, itemID = 8412 },
  { name = "R.O.I.D.S.",                         icon = "Interface\\Icons\\INV_Stone_15",                buffIcon = "Interface\\Icons\\Spell_Nature_Strength",                                                                                   canBeAnounced = false, duration = 3600, itemID = 8410 },
  { name = "Cerebral Cortex Compound",           icon = "Interface\\Icons\\INV_Potion_119",              buffIcon = "Interface\\Icons\\Spell_Nature_Purge",                                                                                      canBeAnounced = false, duration = 3600, itemID = 8423 },
  { name = "Gift of Arthas",                     icon = "Interface\\Icons\\Inv_Potion_28",               buffIcon = "Interface\\Icons\\Spell_Shadow_FingerOfDeath",                                                                              canBeAnounced = false, duration = 1800, itemID = 9088 },
  { name = "Dreamtonic",                         icon = "Interface\\Icons\\INV_Potion_114",              buffIcon = "Interface\\Icons\\inv_potion_114",                                                                                          canBeAnounced = false, duration = 1200, itemID = 61423 },
  { name = "Winterfall Firewater",               icon = "Interface\\Icons\\INV_Potion_92",               buffIcon = "Interface\\Icons\\INV_Potion_92",                                                                                           canBeAnounced = false, duration = 1200, itemID = 12820 },

  { header = true,                               name = "Weapon Enchants" },
  { name = "Dense Sharpening Stone",             icon = "Interface\\Icons\\INV_Stone_SharpeningStone_05",buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 12404 },
  { name = "Dense Sharpening Stone",             icon = "Interface\\Icons\\INV_Stone_SharpeningStone_05",buffIcon = "weapon_enchant_oh", raidbuffIcon = "weapon_enchant_oh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "offhand", itemID = 12404 },
  { name = "Elemental Sharpening Stone",         icon = "Interface\\Icons\\INV_Stone_02",                buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 18262 },
  { name = "Elemental Sharpening Stone",         icon = "Interface\\Icons\\INV_Stone_02",                buffIcon = "weapon_enchant_oh", raidbuffIcon = "weapon_enchant_oh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "offhand", itemID = 18262 },
  { name = "Brilliant Mana Oil",                 icon = "Interface\\Icons\\INV_Potion_100",              buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 20748 },
  { name = "Brilliant Wizard Oil",               icon = "Interface\\Icons\\INV_Potion_105",              buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 20749 },
  { name = "Blessed Weapon Coating",             icon = "Interface\\Icons\\INV_Potion_95",               buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 23123 },
  { name = "Blessed Weapon Coating",             icon = "Interface\\Icons\\INV_Potion_95",               buffIcon = "weapon_enchant_oh", raidbuffIcon = "weapon_enchant_oh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "offhand", itemID = 23123 },
  { name = "Shadowoil",                          icon = "Interface\\Icons\\INV_Potion_106",              buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 3824 },
  { name = "Shadowoil",                          icon = "Interface\\Icons\\INV_Potion_106",              buffIcon = "weapon_enchant_oh", raidbuffIcon = "weapon_enchant_oh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "offhand", itemID = 3824 },
  { name = "Deadly Poison",                      icon = "Interface\\Icons\\Ability_Rogue_Dualweild",     buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 2892 },
  { name = "Deadly Poison",                      icon = "Interface\\Icons\\Ability_Rogue_Dualweild",     buffIcon = "weapon_enchant_oh", raidbuffIcon = "weapon_enchant_oh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "offhand", itemID = 2892 },
  { name = "Instant Poison",                     icon = "Interface\\Icons\\Ability_Poisons",             buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 6947 },
  { name = "Instant Poison",                     icon = "Interface\\Icons\\Ability_Poisons",             buffIcon = "weapon_enchant_oh", raidbuffIcon = "weapon_enchant_oh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "offhand", itemID = 6947 },
  { name = "Consecrated Sharpening Stone",       icon = "Interface\\Icons\\INV_Stone_SharpeningStone_02",buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 23122 },
  { name = "Consecrated Sharpening Stone",       icon = "Interface\\Icons\\INV_Stone_SharpeningStone_02",buffIcon = "weapon_enchant_oh", raidbuffIcon = "weapon_enchant_oh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "offhand", itemID = 23122 },
  { name = "Blessed Wizard Oil",                 icon = "Interface\\Icons\\INV_Potion_138",              buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 23123 },
  { name = "Frost Oil",                          icon = "Interface\\Icons\\INV_potion_130",              buffIcon = "weapon_enchant_mh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 3829 },
  { name = "Frost Oil",                          icon = "Interface\\Icons\\INV_potion_130",              buffIcon = "weapon_enchant_oh", raidbuffIcon = "weapon_enchant_oh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "offhand", itemID = 3829 },
  { name = "Lesser Mana Oil",                    icon = "Interface\\Icons\\INV_Potion_99",               buffIcon = "weapon_enchant_oh", raidbuffIcon = "weapon_enchant_mh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "mainhand", itemID = 20747 },
  { name = "Lesser Mana Oil",                    icon = "Interface\\Icons\\INV_Potion_99",               buffIcon = "weapon_enchant_oh", raidbuffIcon = "weapon_enchant_oh",                                                                     canBeAnounced = false, isWeaponEnchant = true, slot = "offhand", itemID = 20747 },

  { header = true,                               name = "Food & Drinks" },
  { name = "Smoked Desert Dumplings",            icon = "Interface\\Icons\\Inv_Misc_Food_64",            buffIcon = "Interface\\Icons\\Spell_Misc_Food",                                                                                         canBeAnounced = false, duration = 900, itemID = 20452 },
  { name = "Grilled Squid",                      icon = "Interface\\Icons\\Inv_Misc_Fish_13",            buffIcon = "Interface\\Icons\\INV_Gauntlets_19",                                                                                        canBeAnounced = false, duration = 600, itemID = 13928 },
  { name = "Nightfin Soup",                      icon = "Interface\\Icons\\Inv_Drink_17",                buffIcon = "Interface\\Icons\\Spell_Nature_Manaregentotem",                                                                             canBeAnounced = false, duration = 600, itemID = 13931 },
  { name = "Runn Tum Tuber Surprise",            icon = "Interface\\Icons\\Inv_Misc_Food_63",            buffIcon = "Interface\\Icons\\INV_Misc_Organ_03",                                                                                       canBeAnounced = false, duration = 600, itemID = 18254 },
  { name = "Lobster Stew",                       icon = "Interface\\Icons\\INV_Drink_24",                buffIcon = "Interface\\Icons\\Spell_Misc_Food",                                                                                         canBeAnounced = false, duration = 900, itemID = 13933 },
  { name = "Dirge's Kickin' Chimaerok Chops",    icon = "Interface\\Icons\\Inv_Misc_Food_65",            buffIcon = "Interface\\Icons\\INV_Boots_Plate_03",                                                                                      canBeAnounced = false, duration = 900, itemID = 21023 },
  { name = "Gurubashi Gumbo",                    icon = "Interface\\Icons\\INV_Misc_Food_64",            buffIcon = "Interface\\Icons\\Spell_Misc_Food",                                                                                         canBeAnounced = false, duration = 900, itemID = 53015 },
  { name = "Le Fishe Au Chocolat",               icon = "Interface\\Icons\\INV_Misc_Fishe_Au_Chocolate", buffIcon = "Interface\\Icons\\Spell_Misc_Food",                                                                                         canBeAnounced = false, duration = 900, itemID = 84040 },
  { name = "Sweet Mountain Berry",               icon = "Interface\\Icons\\INV_Misc_Food_40",            buffIcon = "Interface\\Icons\\INV_Boots_Plate_03",                                                                                      canBeAnounced = false, duration = 600, itemID = 51714 },
  { name = "Sour Mountain Berry",                icon = "Interface\\Icons\\INV_Misc_Food_74",            buffIcon = "Interface\\Icons\\INV_Gauntlets_19",                                                                                        canBeAnounced = false, duration = 600, itemID = 51711 },
  { name = "Danonzo's Tel'Abim Medley",          icon = "Interface\\Icons\\INV_Misc_Food_73",            buffIcon = "Interface\\Icons\\Spell_Misc_Food",                                                                                         canBeAnounced = false, duration = 900, itemID = 60978 },
  { name = "Danonzo's Tel'Abim Surprise",        icon = "Interface\\Icons\\inv_misc_food_92",            buffIcon = "Interface\\Icons\\Spell_Misc_Food",                                                                                         canBeAnounced = false, duration = 900, itemID = 60976 },
  { name = "Danonzo's Tel'Abim Delight",         icon = "Interface\\Icons\\INV_Drink_21",                buffIcon = "Interface\\Icons\\Spell_Misc_Food",                                                                                         canBeAnounced = false, duration = 900, itemID = 60977 },
  { name = "Dragonbreath Chili",                 icon = "Interface\\Icons\\INV_Drink_23",                buffIcon = "Interface\\Icons\\Spell_Fire_Incinerate",                                                                                   canBeAnounced = false, duration = 600, itemID = 12217 },
  { name = "Hardened Mushroom",                  icon = "Interface\\Icons\\INV_mushroom_15",             buffIcon = "Interface\\Icons\\INV_Boots_Plate_03",                                                                                      canBeAnounced = false, duration = 900, itemID = 51717 },
  { name = "Power Mushroom",                     icon = "Interface\\Icons\\INV_mushroom_14",             buffIcon = "Interface\\Icons\\Spell_Misc_Food",                                                                                         canBeAnounced = false, duration = 900, itemID = 51720 },

  { header = true,                               name = "Alcoholic Beverages" },
  { name = "Rumsey Rum Black Label",             icon = "Interface\\Icons\\INV_Drink_04",               buffIcon = "Interface\\Icons\\INV_Drink_04",                                                                                             canBeAnounced = false, duration = 900, itemID = 21151 },
  { name = "Medivh's Merlot",                    icon = "Interface\\Icons\\INV_Drink_Waterskin_05",     buffIcon = "Interface\\Icons\\INV_Drink_04",                                                                                             canBeAnounced = false, duration = 900, itemID = 61174 },
  { name = "Medivh's Merlot Blue",               icon = "Interface\\Icons\\INV_Drink_Waterskin_01",     buffIcon = "Interface\\Icons\\INV_Drink_19",                                                                                             canBeAnounced = false, duration = 900, itemID = 61175 },
  { name = "Gordok Green Grog",                  icon = "Interface\\Icons\\INV_Drink_03",               buffIcon = "Interface\\Icons\\INV_Drink_03",                                                                                             canBeAnounced = false, duration = 900, itemID = 18269 },

  { header = true,                               name = "Resistance Potions" },
  { name = "Greater Nature Protection Potion",   icon = "Interface\\Icons\\INV_potion_22",               buffIcon = "Interface\\Icons\\Spell_Nature_SpiritArmor",                                                                                canBeAnounced = false, duration = 3600, itemID = 13458 },
  { name = "Nature Protection Potion",           icon = "Interface\\Icons\\INV_potion_06",               buffIcon = "Interface\\Icons\\Spell_Nature_SpiritArmor",                                                                                canBeAnounced = false, duration = 3600, itemID = 13458 },
  { name = "Greater Fire Protection Potion",     icon = "Interface\\Icons\\INV_potion_117",              buffIcon = "Interface\\Icons\\Spell_Fire_FireArmor",                                                                                    canBeAnounced = false, duration = 3600, itemID = 13458 },
  { name = "Fire Protection Potion",             icon = "Interface\\Icons\\INV_potion_16",               buffIcon = "Interface\\Icons\\Spell_Fire_FireArmor",                                                                                    canBeAnounced = false, duration = 3600, itemID = 13458 },
  { name = "Greater Frost Protection Potion",    icon = "Interface\\Icons\\INV_potion_20",               buffIcon = "Interface\\Icons\\Spell_Frost_FrostArmor02",                                                                                canBeAnounced = false, duration = 3600, itemID = 13458 },
  { name = "Frost Protection Potion",            icon = "Interface\\Icons\\INV_potion_13",               buffIcon = "Interface\\Icons\\Spell_Frost_FrostArmor02",                                                                                canBeAnounced = false, duration = 3600, itemID = 13458 },
  { name = "Greater Shadow Protection Potion",   icon = "Interface\\Icons\\INV_potion_23",               buffIcon = "Interface\\Icons\\Spell_Shadow_RagingScream",                                                                               canBeAnounced = false, duration = 3600, itemID = 13458 },
  { name = "Shadow Protection Potion",           icon = "Interface\\Icons\\INV_potion_44",               buffIcon = "Interface\\Icons\\Spell_Shadow_RagingScream",                                                                               canBeAnounced = false, duration = 3600, itemID = 13458 },
  { name = "Greater Arcane Protection Potion",   icon = "Interface\\Icons\\INV_potion_83",               buffIcon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02",                                                                            canBeAnounced = false, duration = 3600, itemID = 13458 },

  { header = true,                               name = "Combat Potions" },
  { name = "Nordanaar Herbal Tea",               icon = "Interface\\Icons\\inv_drink_waterskin_03",                                                                                                                                              canBeAnounced = false, duration = 0, itemID = 61675 }, -- Instant effect - no buff to track
  { name = "Potion of Quickness",                icon = "Interface\\Icons\\INV_Potion_08",               buffIcon = "Interface\\Icons\\Spell_Nature_Invisibilty",                                                                                canBeAnounced = false, duration = 30, itemID = 61181 },
  { name = "Mighty Rage Potion",                 icon = "Interface\\Icons\\INV_Potion_125",                                                                                                                                                      canBeAnounced = false, duration = 20, itemID = 13442 }, -- Instant effect - no buff to track
}

local _, playerClass = UnitClass("player")

local classBuffs = {

  MAGE = {
    { header = true, name = "Mage Self Buffs" },
    { name = "Mage Armor",                       icon = "Interface\\Icons\\Spell_MageArmor",             buffIcon = "Interface\\Icons\\Spell_MageArmor",                                                                                         canBeAnounced = false, duration = 1800, spellID = 22783 },
  },

  PRIEST = {
    { header = true, name = "Priest Self Buffs" },
    { name = "Inner Fire",                       icon = "Interface\\Icons\\Spell_Holy_InnerFire",        buffIcon = "Interface\\Icons\\Spell_Holy_InnerFire",                                                                                    canBeAnounced = false, duration = 600, spellID = 10952 },
  },

  PALADIN = {
    { header = true, name = "Paladin Self Buffs" },
    { name = "Righteous Fury",                   icon = "Interface\\Icons\\Spell_Holy_SealOfFury",       buffIcon = "Interface\\Icons\\Spell_Holy_SealOfFury",                                                                                   canBeAnounced = false, spellID = 25780 },
  },

  SHAMAN = {
    { header = true, name = "Shaman Self Buffs" },
    { name = "Lightning Shield",                 icon = "Interface\\Icons\\Spell_Nature_LightningShield",buffIcon = "Interface\\Icons\\Spell_Nature_LightningShield",                                                                            canBeAnounced = false, duration = 600, spellID = 10432 },
    { name = "Water Shield",                     icon = "Interface\\Icons\\Ability_Shaman_WaterShield",  buffIcon = "Interface\\Icons\\Ability_Shaman_WaterShield",                                                                              canBeAnounced = false, duration = 600, spellID = 51536 },
  },

  WARLOCK = {
    { header = true, name = "Warlock Self Buffs" },
    { name = "Demon Armor",                      icon = "Interface\\Icons\\Spell_Shadow_RagingScream",   buffIcon = "Interface\\Icons\\Spell_Shadow_RagingScream",                                                                               canBeAnounced = false, duration = 1800, spellID = 11735 },
    
  },
}

local addedHeader = false

if classBuffs[playerClass] then
  for _, buff in ipairs(classBuffs[playerClass]) do
    if buff.header and addedHeader then
      -- skip extra headers
    else
      table.insert(Akkio_Consume_Helper_Data.allBuffs, buff)
      addedHeader = addedHeader or buff.header
    end
  end
end

-- Cant find this buff in trutle wow database
 --{ name = "Juice Striped Melon",        icon = "Interface\\Icons\\INV_Misc_Food_09",           buffIcon = "Interface\\Icons\\INV_Misc_Food_09",                                                                                         canBeAnounced = false, duration = 600, itemID = 51721 },


 -- You can add more data tables here if needed
-- For example:
-- Akkio_Consume_Helper_Data.settings = {
--   updateTimer = 1,
--   defaultBuffs = {...}
-- }
