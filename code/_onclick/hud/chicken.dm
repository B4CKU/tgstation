/datum/hud/dextrous/chicken/New(mob/owner)
	..()
	var/obj/screen/inventory/inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "back"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = ui_chicken_storage
	inv_box.slot_id = SLOT_BACK
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /obj/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.screen_loc = ui_chicken_head
	inv_box.slot_id = SLOT_HEAD
	inv_box.hud = src
	static_inventory += inv_box

	for(var/obj/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv.hud = src
			inv_slots[inv.slot_id] = inv
			inv.update_icon()


/datum/hud/dextrous/chicken/persistent_inventory_update()
	if(!mymob)
		return
	var/mob/living/simple_animal/chicken/smart/D = mymob //todo

	if(hud_shown)
		if(D.back)
			D.back.screen_loc = ui_chicken_storage
			D.client.screen += D.back
		if(D.head)
			D.head.screen_loc = ui_chicken_head
			D.client.screen += D.head
	else
		if(D.back)
			D.back.screen_loc = null
		if(D.head)
			D.head.screen_loc = null

	..()
