/datum/species/duergar
	name = "Duergar" //plural - duergâr
	id = "duergar"
	
	species_traits = list(NOEYESPRITES,HAIR,FACEHAIR,LIPS,NOBLOOD,NOHUSK)
	default_features = list("mcolor" = "FFF", "wings" = "None")
	damage_overlay_type = "robotic"
	
	disliked_food = GRAIN | DAIRY | GROSS | MEAT
	liked_food = MINERAL 
	
	speedmod = 1.3
	armor = 15
	
	species_language_holder = /datum/language_holder/golem
	
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT

/datum/species/duergar/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	C.transform = C.transform.Scale(1, 0.8)
	ADD_TRAIT(C, TRAIT_ALCOHOL_TOLERANCE, "alcohol immune")

/datum/species/duergar/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.transform = C.transform.Scale(1, 1.25)
	REMOVE_TRAIT(C, TRAIT_ALCOHOL_TOLERANCE, "alcohol immune")

/datum/species/duergar/spec_life(mob/living/carbon/human/H)
	if(H.stat == DEAD)
		return
	if(H.health <= HEALTH_THRESHOLD_CRIT)
		H.take_overall_damage(6,0)
		if(prob(5))
			H.visible_message("<span class='warning'>[H]'s mineral body slowly crumbles!</span>")
	if(H.nutrition < NUTRITION_LEVEL_STARVING - 50 && prob(10))
		H.take_overall_damage(6,0)
		H.visible_message("<span class='warning'>[H] writhes in pain as [H.p_their()] skin flakes off.</span>", "<span class='userdanger'>You writhe in pain as your skin flakes off!</span>", "<span class='italics'>You hear the crunching of gravel.</span>")

/datum/species/duergar/check_species_weakness(obj/item/weapon, mob/living/attacker)
	if(istype(weapon, /obj/item/pickaxe))
		return 1 //pickaxes deal 2x damage to duergâr
	return 0

