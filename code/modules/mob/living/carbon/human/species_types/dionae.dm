/datum/species/diona
	// A sentient plant, created by growing a diona node. These regain health in light, and begin to wither in darkness.
	name = "Diona"
	id = "diona"
	species_traits = list(NO_UNDERWEAR)
	inherent_traits = list(TRAIT_ALWAYS_CLEAN,TRAIT_NOGUNS)
	inherent_factions = list("plants", "vines")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	speedmod = 1.75
	armor = 25
	burnmod = 2.0
	heatmod = 1.25
	punchdamage = 10
	no_equip = list(SLOT_WEAR_MASK, SLOT_WEAR_SUIT, SLOT_GLOVES, SLOT_SHOES, SLOT_W_UNIFORM, SLOT_S_STORE)
	nojumpsuit = 1
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/plant
	disliked_food = MEAT | DAIRY
	liked_food = VEGETABLES | FRUIT | GRAIN
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC
	species_language_holder = /datum/language_holder/plant
	limbs_id = "diona"

/datum/species/diona/spec_life(mob/living/carbon/human/H) //podpeople copypasta below
	if(H.stat == DEAD)
		return
	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	if(isturf(H.loc)) //else, there's considered to be no light
		var/turf/T = H.loc
		light_amount = min(1,T.get_lumcount()) - 0.5
		H.adjust_nutrition(light_amount * 10)
		if(H.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
			H.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL)
		if(light_amount > 0.2) //if there's enough light, heal
			H.heal_overall_damage(1,1, 0, BODYPART_ORGANIC)
			H.adjustToxLoss(-1)
			H.adjustOxyLoss(-1)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		H.take_overall_damage(2,0)

/datum/species/diona/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/toxin/plantbgone)
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		return 1

/datum/species/diona/on_hit(obj/item/projectile/P, mob/living/carbon/human/H)
	switch(P.type)
		if(/obj/item/projectile/energy/floramut)
			if(prob(15))
				H.rad_act(rand(30,80))
				H.Paralyze(100)
				H.visible_message("<span class='warning'>[H] writhes in pain as [H.p_their()] vacuoles boil.</span>", "<span class='userdanger'>You writhe in pain as your vacuoles boil!</span>", "<span class='italics'>You hear the crunching of leaves.</span>")
				if(prob(80))
					H.easy_randmut(NEGATIVE+MINOR_NEGATIVE)
				else
					H.easy_randmut(POSITIVE)
				H.randmuti()
				H.domutcheck()
			else
				H.adjustFireLoss(rand(5,15))
				H.show_message("<span class='userdanger'>The radiation beam singes you!</span>")
		if(/obj/item/projectile/energy/florayield)
			H.set_nutrition(min(H.nutrition+30, NUTRITION_LEVEL_FULL))
