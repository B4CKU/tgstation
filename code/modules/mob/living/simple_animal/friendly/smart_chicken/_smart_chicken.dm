#define CHICKEN_HANDS_LAYER 1
#define CHICKEN_HEAD_LAYER 2
#define CHICKEN_TOTAL_LAYERS 2

/mob/living/simple_animal/chicken/smart
	possible_a_intents = list(INTENT_HELP, INTENT_HARM)
	health = 30
	maxHealth = 30
	held_items = list(null, null)
	dextrous = TRUE
	dextrous_hud_type = /datum/hud/dextrous/chicken
	
	var/obj/item/back
	var/obj/item/head
	var/list/chicken_overlays[CHICKEN_TOTAL_LAYERS]

/mob/living/simple_animal/chicken/smart/examine(mob/user)
	. = list("<span class='info'>*---------*\nThis is [icon2html(src, user)] \a <b>[src]</b>!")

	//Hands
	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT))
			. += "It has [I.get_examine_string(user)] in its [get_held_index_name(get_held_index_of_item(I))]."

	//Cosmetic hat - provides no function other than looks
	if(head && !(head.item_flags & ABSTRACT))
		. += "It's wearing [head.get_examine_string(user)] on its head."

	//Back
	if(back && !(back.item_flags & ABSTRACT))
		. += "It's wearing [back.get_examine_string(user)] on its back."

	//Braindead
	if(!client && stat != DEAD)
		. += "It has a blank, absent-minded stare and appears completely unresponsive to anything."

	//Damaged
	if(health != maxHealth)
		if(health > maxHealth * 0.33) //Between maxHealth and about a third of maxHealth, between 30 and 10 for normal chicken
			. += "<span class='warning'>It has minor bruising.</span>"
		else //otherwise, below about 33%
			. += "<span class='boldwarning'>It has severe bruising!</span>"

	//Dead
	if(stat == DEAD)
		if(!client)
			. += "<span class='deadsay'>It's limp and unresponsive; there are no signs of life and its soul has departed...</span>"
		else
			. += "<span class='deadsay'>It's limp and unresponsive; there are no signs of life...</span>"
	. += "*---------*</span>"