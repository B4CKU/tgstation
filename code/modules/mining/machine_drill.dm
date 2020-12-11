/obj/machinery/mineral/drill
	name = "heavy-duty mining rig"
	desc = "Piece of heavy machinery designed to extract materials from the underground deposits."
	icon = 'icons/obj/machines/drill.dmi'
	icon_state = "drill"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/drill
	layer = BELOW_OBJ_LAYER
	var/bluespace_upgrade = FALSE
	var/list/ore_rates = list(/datum/material/iron = 0.6, /datum/material/glass = 0.6, /datum/material/copper = 0.4, /datum/material/plasma = 0.2,  /datum/material/silver = 0.2, /datum/material/gold = 0.1, /datum/material/titanium = 0.1, /datum/material/uranium = 0.1, /datum/material/diamond = 0.1)
	//var/list/ore_rates_common = list(/datum/material/iron = 0.6, /datum/material/glass = 0.6, /datum/material/copper = 0.4)
	//var/list/ore_rates_volatile = list(/datum/material/plasma = 0.2, /datum/material/uranium = 0.1)
	//var/list/ore_rates_noble = list(/datum/material/silver = 0.2, /datum/material/gold = 0.1, /datum/material/titanium = 0.1)
	//var/list/ore_rates_rare = list(/datum/material/diamond = 0.1, /datum/material/bluespace = 0.1)
	var/efficiency_coeff = 1	
	var/datum/component/remote_materials/materials

/obj/machinery/mineral/drill/Initialize(mapload)
	. = ..()
	materials = AddComponent(/datum/component/remote_materials, "bsm", mapload)
	RefreshParts()

/obj/machinery/mineral/drill/Destroy()
	drill_eject_mats()
	materials = null
	return ..()

/obj/machinery/mineral/drill/RefreshParts()
	efficiency_coeff = 1
	if(materials)
		var/total_storage = 0
		for(var/obj/item/stock_parts/matter_bin/M in component_parts)
			total_storage += M.rating * 75000
		materials.set_local_size(total_storage)
	/*var/total_rating = 1.2
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		total_rating = CLAMP(total_rating - (M.rating * 0.1), 0, 1)
	if(total_rating == 0)
		efficiency_coeff = INFINITY
	else
		efficiency_coeff = 1/total_rating*/

/obj/machinery/mineral/drill/multitool_act(mob/living/user, obj/item/multitool/M)
	if(!bluespace_upgrade)
		return FALSE
	if(istype(M))
		if(!M.buffer || !istype(M.buffer, /obj/machinery/ore_silo))
			to_chat(user, "<span class='warning'>You need to multitool the ore silo first.</span>")
			return FALSE

/obj/machinery/mineral/drill/examine(mob/user)
	. = ..()
	if(bluespace_upgrade)
		if(!materials?.silo)
			. += "<span class='notice'>No ore silo connected. Use a multi-tool to link an ore silo to this machine.</span>"
		else if(materials?.on_hold())
			. += "<span class='warning'>Ore silo access is on hold, please contact the quartermaster.</span>"
		else
			. += "<span class='notice'>It's connected to the ore silo.</span>"

/obj/machinery/mineral/drill/interact(mob/user)
	if(!drill_eject_mats())
		to_chat(user, "<span class='warning'>[src] can't eject materials from the silo!</span>")

/obj/machinery/mineral/drill/proc/drill_eject_mats(mob/user)
	if(materials?.silo)
		return FALSE
	var/datum/component/material_container/mat_container = materials.mat_container
	mat_container.retrieve_all()
	return TRUE

/obj/machinery/mineral/drill/process()
	//if(!materials?.silo || materials?.on_hold())
	//	return
	var/datum/component/material_container/mat_container = materials.mat_container
	if(!mat_container || panel_open || !powered())
		return
	var/datum/material/ore = pick(ore_rates)
	mat_container.insert_amount_mat((ore_rates[ore] * 1000), ore)
