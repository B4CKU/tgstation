/datum/species/duergar
	// A mysterious race of short golem-like people, born from stone thanks to the weird energies of the lavaland
	name = "Duergar" //plural - duergâr
	id = "duergar"
	species_traits = list(NOEYESPRITES,HAIR,FACEHAIR,LIPS,NOBLOOD,NOHUSK)
	default_features = list("mcolor" = "FFF", "wings" = "None")
	damage_overlay_type = "robotic"
	disliked_food = GRAIN | DAIRY | GROSS | MEAT
	liked_food = MINERAL 
	speedmod = 1.25
	armor = 15
	species_language_holder = /datum/language_holder/golem
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	var/obj/item/stack/sheet/sheet_eaten // rozważałem przetwarzanie tego w nowym żołądku, ale krasnoludy z augami/sztucznymi żołądkami traciłyby wtedy największy bonus swojej rasy

/datum/species/duergar/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	C.transform = C.transform.Scale(1, 0.8)
	ADD_TRAIT(C, TRAIT_ALCOHOL_TOLERANCE, "alcohol immune")
	RegisterSignal(C, "dwarf_mat", .proc/mat_set)

/datum/species/duergar/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.transform = C.transform.Scale(1, 1.25)
	REMOVE_TRAIT(C, TRAIT_ALCOHOL_TOLERANCE, "alcohol immune")
	UnregisterSignal(C, "dwarf_mat")

/datum/species/duergar/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(istype(chem, /datum/reagent/consumable/ethanol))
		digest_mats(H)
	return ..()

/datum/species/duergar/proc/digest_mats(mob/living/carbon/human/H)
	if(!sheet_eaten)
		return
	if(H.has_status_effect(/datum/status_effect/dwarf_material))
		return
	
	if(istype(sheet_eaten, /obj/item/stack/sheet/iron)) //TODO: ładniej to napisać, obsłużyć pozostałe rodzaje materiałów
		H.apply_status_effect(/datum/status_effect/dwarf_material/dwarf_iron)
	
	
	sheet_eaten = null

/datum/species/duergar/proc/mat_set(datum/source) //TODO: przekazuje reference do moba użytkownika, a nie zjedzonego materiału
	sheet_eaten = source

/datum/species/duergar/spec_life(mob/living/carbon/human/H)
	if(H.stat == DEAD)
		return
	if(H.health <= HEALTH_THRESHOLD_CRIT)
		H.take_overall_damage(6,0)
		if(prob(5))
			H.visible_message("<span class='warning'>[H]'s body slowly crumbles!</span>")
	if(H.nutrition < NUTRITION_LEVEL_STARVING - 50 && prob(10))
		H.take_overall_damage(6,0)
		H.visible_message("<span class='warning'>[H] writhes in pain as [H.p_their()] skin flakes off.</span>", "<span class='userdanger'>You writhe in pain as your skin flakes off!</span>", "<span class='italics'>You hear the crunching of gravel.</span>")

/datum/species/duergar/check_species_weakness(obj/item/weapon, mob/living/attacker)
	if(istype(weapon, /obj/item/pickaxe))
		return 1 //pickaxes deal 2x damage to duergâr, because of their mineral-like skin
	return 0

///////////////////////////////////////////////////////
/////////////////////STATUS EFFECTS////////////////////
///////////////////////////////////////////////////////
/datum/status_effect/dwarf_material
	id = "dwarf_material"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null
	duration = 1200
	var/message = "You shouldn't see this message."

/datum/status_effect/dwarf_material/on_apply()
	to_chat(owner,"<span class='notice'>[message]</span>")
	return ..()

// Iron
/datum/status_effect/dwarf_material/dwarf_iron
	id = "dwarf_iron"
	message = "Your skin feels hard."

/datum/status_effect/dwarf_material/dwarf_iron/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.physiology.brute_mod *= 0.9
		H.physiology.burn_mod *= 0.9
	return ..()

/datum/status_effect/dwarf_material/dwarf_iron/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.physiology.brute_mod /= 0.9
		H.physiology.burn_mod /= 0.9
	return ..()

// Titanium
/datum/status_effect/dwarf_material/dwarf_titanium
	id = "dwarf_iron"
	message = "Your skin feels heavy."

/datum/status_effect/dwarf_material/dwarf_titanium/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.physiology.brute_mod *= 0.8
		H.physiology.burn_mod *= 0.8
		H.add_movespeed_modifier("titanium", TRUE, 100, override=TRUE, multiplicative_slowdown=0.6, movetypes=GROUND)
	return ..()

/datum/status_effect/dwarf_material/dwarf_titanium/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.physiology.brute_mod /= 0.8
		H.physiology.burn_mod /= 0.8
		H.remove_movespeed_modifier("titanium")
	return ..()

// Plastitanium
/datum/status_effect/dwarf_material/dwarf_plastitanium
	id = "dwarf_iron"
	message = "Your skin feels cold."

/datum/status_effect/dwarf_material/dwarf_plastitanium/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.physiology.brute_mod *= 0.9
		H.physiology.burn_mod *= 0.7
		H.add_movespeed_modifier("plastitanium", TRUE, 100, override=TRUE, multiplicative_slowdown=0.3, movetypes=GROUND)
	return ..()

/datum/status_effect/dwarf_material/dwarf_plastitanium/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.physiology.brute_mod /= 0.9
		H.physiology.burn_mod /= 0.7
		H.remove_movespeed_modifier("plastitanium")
	return ..()
