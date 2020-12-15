/////////////////////
//CHICKEN INVENTORY//
/////////////////////
//Chicken inventory
//Chicken hands


/mob/living/simple_animal/chicken/smart/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	if(..())
		update_inv_hands()
		if(I == head)
			head = null
			update_inv_head()
		if(I == back)
			back = null
			update_inv_back_chicken()
		return 1
	return 0


/mob/living/simple_animal/chicken/smart/can_equip(obj/item/I, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	switch(slot)
		if(SLOT_HEAD)
			if(head)
				return 0
			if(!(I.slot_flags & ITEM_SLOT_HEAD))
				return 0
			return 1
		if(SLOT_BACK)
			if(back)
				return 0
			if(!(I.slot_flags & ITEM_SLOT_BACK))
				return 0
			return 1
	..()


/mob/living/simple_animal/chicken/smart/get_item_by_slot(slot_id)
	switch(slot_id)
		if(SLOT_HEAD)
			return head
		if(SLOT_BACK)
			return back
	return ..()


/mob/living/simple_animal/chicken/smart/equip_to_slot(obj/item/I, slot)
	if(!slot)
		return
	if(!istype(I))
		return

	var/index = get_held_index_of_item(I)
	if(index)
		held_items[index] = null
	update_inv_hands()

	if(I.pulledby)
		I.pulledby.stop_pulling()

	I.screen_loc = null // will get moved if inventory is visible
	I.forceMove(src)
	I.layer = ABOVE_HUD_LAYER
	I.plane = ABOVE_HUD_PLANE

	switch(slot)
		if(SLOT_HEAD)
			head = I
			update_inv_head()
		if(SLOT_BACK)
			back = I
			update_inv_back_chicken()
		else
			to_chat(src, "<span class='danger'>You are trying to equip this item to an unsupported inventory slot. Report this to a coder!</span>")
			return

	//Call back for item being equipped to the chicken
	I.equipped(src, slot)

/mob/living/simple_animal/chicken/smart/getBackSlot()
	return SLOT_BACK