///////////////////
//CHICKEN VISUALS//
///////////////////
//Chicken overlays
//Chicken visuals


#define CHICKEN_ITEM_SHIFT_Y -3

/mob/living/simple_animal/chicken/smart/proc/apply_overlay(cache_index)
	if((. = chicken_overlays[cache_index]))
		add_overlay(.)


/mob/living/simple_animal/chicken/smart/proc/remove_overlay(cache_index)
	var/I = chicken_overlays[cache_index]
	if(I)
		cut_overlay(I)
		chicken_overlays[cache_index] = null


/mob/living/simple_animal/chicken/smart/update_inv_hands()
	remove_overlay(CHICKEN_HANDS_LAYER)
	var/list/hands_overlays = list()

	var/obj/item/l_hand = get_item_for_held_index(1)
	var/obj/item/r_hand = get_item_for_held_index(2)

	var/y_shift = CHICKEN_ITEM_SHIFT_Y

	if(r_hand)

		var/r_state = r_hand.item_state
		if(!r_state)
			r_state = r_hand.icon_state

		var/mutable_appearance/r_hand_overlay = r_hand.build_worn_icon(state = r_state, default_layer = CHICKEN_HANDS_LAYER, default_icon_file = r_hand.righthand_file, isinhands = TRUE)
		if(y_shift)
			r_hand_overlay.pixel_y += y_shift

		hands_overlays += r_hand_overlay

		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			r_hand.layer = ABOVE_HUD_LAYER
			r_hand.plane = ABOVE_HUD_PLANE
			r_hand.screen_loc = ui_hand_position(get_held_index_of_item(r_hand))
			client.screen |= r_hand

	if(l_hand)

		var/l_state = l_hand.item_state
		if(!l_state)
			l_state = l_hand.icon_state

		var/mutable_appearance/l_hand_overlay = l_hand.build_worn_icon(state = l_state, default_layer = CHICKEN_HANDS_LAYER, default_icon_file = l_hand.lefthand_file, isinhands = TRUE)
		if(y_shift)
			l_hand_overlay.pixel_y += y_shift

		hands_overlays += l_hand_overlay

		if(client && hud_used && hud_used.hud_version != HUD_STYLE_NOHUD)
			l_hand.layer = ABOVE_HUD_LAYER
			l_hand.plane = ABOVE_HUD_PLANE
			l_hand.screen_loc = ui_hand_position(get_held_index_of_item(l_hand))
			client.screen |= l_hand


	if(hands_overlays.len)
		chicken_overlays[CHICKEN_HANDS_LAYER] = hands_overlays
	apply_overlay(CHICKEN_HANDS_LAYER)


/mob/living/simple_animal/chicken/smart/proc/update_inv_back_chicken()
	if(back && client && hud_used && hud_used.hud_shown)
		back.screen_loc = ui_chicken_storage
		client.screen += back


/mob/living/simple_animal/chicken/smart/update_inv_head()
	remove_overlay(CHICKEN_HEAD_LAYER)

	if(head)
		if(client && hud_used && hud_used.hud_shown)
			head.screen_loc = ui_chicken_head
			client.screen += head
		var/used_head_icon = 'icons/mob/head.dmi'
		/*if(istype(head, /obj/item/clothing/mask)) YEEET
			used_head_icon = 'icons/mob/mask.dmi'*/
		var/mutable_appearance/head_overlay = head.build_worn_icon(state = head.icon_state, default_layer = CHICKEN_HEAD_LAYER, default_icon_file = used_head_icon)
		head_overlay.pixel_y -= 15

		chicken_overlays[CHICKEN_HEAD_LAYER] = head_overlay

	apply_overlay(CHICKEN_HEAD_LAYER)

/mob/living/simple_animal/chicken/smart/regenerate_icons()
	// Chicken only have 4 slots, which in this specific instance
	// is a small blessing.
	update_inv_hands()
	update_inv_head()
	update_inv_back_chicken()
