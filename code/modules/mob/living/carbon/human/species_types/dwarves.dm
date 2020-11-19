/datum/species/duergar
	name = "Duergar" //plural - duergâr
	id = "duergar"
	
	species_traits = list(NOEYESPRITES,HAIR,FACEHAIR,LIPS,NOBLOOD)
	default_features = list("mcolor" = "FFF", "wings" = "None")
	damage_overlay_type = "robotic"
	
	disliked_food = GRAIN | DAIRY | GROSS | MEAT
	liked_food = MINERAL 
	
	speedmod = 1.3
	armor = 15

	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT

/datum/species/duergar/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	C.transform = C.transform.Scale(1, 0.8)
	ADD_TRAIT(C, TRAIT_ALCOHOL_TOLERANCE, "alcohol immune")

/datum/species/duergar/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.transform = C.transform.Scale(1, 0.8)
	REMOVE_TRAIT(C, TRAIT_ALCOHOL_TOLERANCE, "alcohol immune")

/datum/species/duergar/check_species_weakness(obj/item/weapon, mob/living/attacker)
	if(istype(weapon, /obj/item/pickaxe))
		return 1 //pickaxes deal 2x damage to duergâr
	return 0

