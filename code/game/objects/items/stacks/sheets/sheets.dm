/obj/item/stack/sheet
	name = "sheet"
	lefthand_file = 'icons/mob/inhands/misc/sheets_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/sheets_righthand.dmi'
	full_w_class = WEIGHT_CLASS_NORMAL
	force = 5
	throwforce = 5
	max_amount = 50
	throw_speed = 1
	throw_range = 3
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "smashed")
	novariants = FALSE
	var/perunit = MINERAL_MATERIAL_AMOUNT
	var/sheettype = null //this is used for girders in the creation of walls/false walls
	var/point_value = 0 //turn-in value for the gulag stacker - loosely relative to its rarity.

/obj/item/reagent_containers/food/snacks/material
	name = "temporary duergar material snack item"
	desc = "If you're reading this it means I messed up. This is related to dwarves eating minerals and I didn't know a better way to do it than making a new food object."
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("minerals" = 1)
	foodtype = MINERAL

/obj/item/stack/sheet/attack(mob/M, mob/user, def_zone) //TODO: ograniczyć które rodzaje materiałów możemy jeść
	if(user.a_intent != INTENT_HARM && isdwarf(M))
		var/obj/item/reagent_containers/food/snacks/material/material_as_food = new
		material_as_food.name = name
		if(material_as_food.attack(M, user, def_zone))
			use(1)
		qdel(material_as_food)
	else
		return ..()