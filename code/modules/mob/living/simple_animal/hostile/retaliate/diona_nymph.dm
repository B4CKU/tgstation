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
	turns_per_move = 5
	maxHealth = 20
	health = 20
	damage_coeff = list(BRUTE = 1, BURN = 2, TOX = 1, CLONE = 1, STAMINA = 1, OXY = 1)
	melee_damage = 3
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

/mob/living/simple_animal/hostile/retaliate/diona_nymph/attack_ghost(mob/dead/observer/user)
	. = ..()
	give_to_ghost(user, TRUE, TRUE)
