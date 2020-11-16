/mob/living/simple_animal/hostile/retaliate/diona_nymph
	name = "diona nymph"
	desc = "A tiny sentient plant. Its genetic code is quite unstable, so it might be able to evolve, given the chance to collect blood samples from humanoids around it."
	icon_state = "nymph"
	icon_living = "nymph"
	icon_dead = "nymph_dead"
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST)
	emote_see = list("hops in a circle.", "shakes.")
	speak = list("rustles","creaks")
	initial_language_holder = /datum/language_holder/plantnymph
	
	speak_chance = 1
	turns_per_move = 1
	maxHealth = 20
	health = 20
	damage_coeff = list(BRUTE = 1, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 1, OXY = 1)
	obj_damage = 0
	melee_damage = 3
	attack_same = 2
	
	attacktext = "bites"
	response_help  = "pets"
	response_disarm = "pokes"
	response_harm   = "splats"
	unique_name = TRUE
	density = FALSE
	ventcrawler = VENTCRAWLER_ALWAYS
	faction = list("plants", "vines")
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/plant = 1)
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	gold_core_spawnable = FRIENDLY_SPAWN
	playable = TRUE
	var/list/donors = list()
	
	var/info_text = "You are a <span class='danger'>diona nymph</span>, a sentient plant. You can collect blood \
					samples from humanoids by biting them. As you gain more and more blood samples from \
					<span class='danger'>different creatures</span> you'll understand creatures around you more and eventually evolve into an adult diona. \
					You can also feed on pests and weeds in hydroponic trays and soil to replenish your health."

/mob/living/simple_animal/hostile/retaliate/diona_nymph/AttackingTarget()
	if(istype(target, /obj/machinery/hydroponics))
		var/obj/machinery/hydroponics/T = target
		visible_message("[src] starts feeding on pests and weeds inside [T].", "<span class='notice'>You feed on pests and weeds inside [T].</span>")
		if(do_after_mob(src, T, 30))
			T.weedlevel = 0
			T.pestlevel = 0
			T.update_icon()
			adjustBruteLoss(-5)
		return
	if(!mind)
		return ..()
	else if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.dna.species && NOBLOOD in H.dna.species.species_traits)
			to_chat(src, "<span class='warning'>This creature has no blood!</span>")
		else if(H.dna && !(H.dna in donors))
			to_chat(src, "<span class='notice'>This collect a sample of [H]'s blood!</span>")
			donors += H.dna
			spawn(rand(0,20)) update_progression(donors.len)
	return ..()

/mob/living/simple_animal/hostile/retaliate/diona_nymph/proc/update_progression(stage)
	if(stat == DEAD)
		return
	switch(stage)
		if(1)
			to_chat(src, "<span class='notice'>The blood seeps into your small form, and you draw out the echoes of memories and personality from it, working them into your budding mind.</span>")
		if(2)
			to_chat(src, "<span class='notice'>You feel your awareness expand, and realize you know how to understand the creatures around you.</span>")
			grant_language(/datum/language/common, TRUE, FALSE, LANGUAGE_MIND)
		if(3)
			to_chat(src, "<span class='notice'>More blood seeps into you, continuing to expand your growing collection of memories.</span>")
		if(4)
			to_chat(src, "<span class='notice'>You feel your vocal range expand, and realize you know how to speak with the creatures around you.</span>")
			grant_language(/datum/language/common, TRUE, TRUE, LANGUAGE_MIND)
		if(5)
			visible_message("<span class='warning'>[src] erupts in a shower of shed bark and twigs!</span>", "<span class='notice'>You erupt in a shower of shed bark and twigs, attaining your adult form!</span>")
			var/mob/living/carbon/human/H = new /mob/living/carbon/human(loc)
			H.set_species(/datum/species/diona)
			mind.transfer_to(H)
			qdel(src)

/mob/living/simple_animal/hostile/retaliate/diona_nymph/attack_ghost(mob/dead/observer/user)
	. = ..()
	give_to_ghost(user, TRUE, TRUE)
