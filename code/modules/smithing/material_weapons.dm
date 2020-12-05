//Rodzaje broni
//sztylet - krótki miecz - długi miecz - greatsword
//

/obj/item/melee/forged
	name = "generic forged weapon"
	desc = "A generic item you should never see."
	icon_state = "sabre"
	item_state = "sabre"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'

/obj/item/melee/forged/dagger
	name = "generic forged dagger"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/melee/forged/shortsword
	name = "generic forged shortsword"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/melee/forged/longsword //copypasta z dwuręcznych broni, dopóki nikt nie przerobi dwuręczności na komponent
	name = "generic forged longsword"
	w_class = WEIGHT_CLASS_BULKY
	var/wielded = 0
	var/force_unwielded = 0
	var/force_wielded = 0
	var/block_power_wielded = 0
	var/block_power_unwielded = 0
	var/wieldsound = null
	var/unwieldsound = null

/obj/item/twohanded/proc/unwield(mob/living/carbon/user, show_message = TRUE)
	if(!wielded || !user)
		return
	wielded = 0

	if(!isnull(force_unwielded))
		force = force_unwielded

	if(!isnull(block_power_unwielded))
		block_power = block_power_unwielded

	var/sf = findtext(name, " (Wielded)", -10)//10 == length(" (Wielded)")
	if(sf)
		name = copytext(name, 1, sf)
	else //something wrong
		name = "[initial(name)]"
	update_icon()
	if(user.get_item_by_slot(SLOT_BACK) == src)
		user.update_inv_back()
	else
		user.update_inv_hands()
	if(show_message)
		if(iscyborg(user))
			to_chat(user, "<span class='notice'>You free up your module.</span>")
		else
			to_chat(user, "<span class='notice'>You are now carrying [src] with one hand.</span>")
	if(unwieldsound)
		playsound(loc, unwieldsound, 50, 1)
	var/obj/item/twohanded/offhand/O = user.get_inactive_held_item()
	if(O && istype(O))
		O.unwield()
	return

/obj/item/twohanded/proc/wield(mob/living/carbon/user)
	if(wielded)
		return
	if(ismonkey(user))
		to_chat(user, "<span class='warning'>It's too heavy for you to wield fully.</span>")
		return
	if(user.get_inactive_held_item())
		to_chat(user, "<span class='warning'>You need your other hand to be empty!</span>")
		return
	if(user.get_num_arms() < 2)
		to_chat(user, "<span class='warning'>You don't have enough intact hands.</span>")
		return
	wielded = 1
	if(force_wielded)
		force = force_wielded
	if(block_power_wielded)
		block_power = block_power_wielded
	name = "[name] (Wielded)"
	update_icon()
	if(iscyborg(user))
		to_chat(user, "<span class='notice'>You dedicate your module to [src].</span>")
	else
		to_chat(user, "<span class='notice'>You grab [src] with both hands.</span>")
	if (wieldsound)
		playsound(loc, wieldsound, 50, 1)
	var/obj/item/twohanded/offhand/O = new(user) ////Let's reserve his other hand~
	O.name = "[name] - offhand"
	O.desc = "Your second grip on [src]."
	O.wielded = TRUE
	user.put_in_inactive_hand(O)
	return

/obj/item/twohanded/dropped(mob/user)
	. = ..()
	//handles unwielding a twohanded weapon when dropped as well as clearing up the offhand
	if(!wielded)
		return
	unwield(user)

/obj/item/twohanded/update_icon()
	return

/obj/item/twohanded/attack_self(mob/user)
	. = ..()
	if(wielded) //Trying to unwield it
		unwield(user)
	else //Trying to wield it
		wield(user)

/obj/item/twohanded/equip_to_best_slot(mob/M)
	if(..())
		unwield(M)
		return

/obj/item/twohanded/equipped(mob/user, slot)
	..()
	if(!user.is_holding(src) && wielded)
		unwield(user)

/obj/item/melee/forged/greatsword
	name = "generic forged greatsword"
	w_class = WEIGHT_CLASS_HUGE