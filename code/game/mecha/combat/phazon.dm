//GENERYCZNY PHAZON - nie powinien być dostępny w grze
/obj/mecha/combat/phazon
	desc = "This is a Phazon exosuit. The pinnacle of scientific research and pride of Nanotrasen, it uses cutting edge bluespace technology and expensive materials."
	name = "\improper Phazon"
	icon_state = "phazon"
	step_in = 2
	dir_in = 2 //Facing South.
	step_energy_drain = 3
	max_integrity = 200
	deflect_chance = 30
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 50, "fire" = 100, "acid" = 100)
	max_temperature = 25000
	infra_luminosity = 3
	wreckage = /obj/structure/mecha_wreckage/phazon
	add_req_access = 1
	internal_damage_threshold = 25
	force = 15
	max_equip = 3
	phase_state = "phazon-phase"

/obj/mecha/combat/phazon/GrantActions(mob/living/user, human_occupant = 0)
	..()
	switch_damtype_action.Grant(user, src)

/obj/mecha/combat/phazon/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	switch_damtype_action.Remove(user)

//BLUESPACE PHAZON - stary pre-reworkowy phazon
/obj/mecha/combat/phazon/bluespace
	name = "\improper Bluespace Phazon"
	
/obj/mecha/combat/phazon/bluespace/examine(mob/user)
	. = ..()
	. += "This one has a bluespace anomaly core attached and can phase through walls."

/obj/mecha/combat/phazon/bluespace/GrantActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Grant(user, src)

/obj/mecha/combat/phazon/bluespace/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Remove(user)

//GRAVITATIONAL PHAZON - jego umiejętność utrudnia poruszanie się istotom dookoła
/obj/mecha/combat/phazon/grav
	name = "\improper Gravitational Phazon"
	
/obj/mecha/combat/phazon/grav/examine(mob/user)
	. = ..()
	. += "This one has a gravitational anomaly core attached and can phase through walls."

/obj/mecha/combat/phazon/grav/GrantActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Grant(user, src)

/obj/mecha/combat/phazon/grav/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Remove(user)

//VORTEX PHAZON - jego umiejętność tworzy swój duplikat który idzie na wprost. ponowne użycie sprawia ze duplikat atakuje. po krótkim czasie znika
/obj/mecha/combat/phazon/vortex
	name = "\improper Vortex Phazon"
	
/obj/mecha/combat/phazon/vortex/examine(mob/user)
	. = ..()
	. += "This one has a vortex anomaly core attached and can phase through walls."

/obj/mecha/combat/phazon/vortex/GrantActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Grant(user, src)

/obj/mecha/combat/phazon/vortex/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Remove(user)

//PYROCLASTIC PHAZON - o wiele bardziej odporny na ogień, nie mam pomysłu na umiejętność
/obj/mecha/combat/phazon/pyro
	name = "\improper Pyroclastic Phazon"

/obj/mecha/combat/phazon/pyro/examine(mob/user)
	. = ..()
	. += "This one has a pyroclastic anomaly core attached and can phase through walls."

/obj/mecha/combat/phazon/pyro/GrantActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Grant(user, src)

/obj/mecha/combat/phazon/pyro/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Remove(user)

//FLUX PHAZON - szybszy, potrafi się szybko teleportować na krótkie dystanse
/obj/mecha/combat/phazon/flux
	name = "\improper Flux Phazon"
	
/obj/mecha/combat/phazon/flux/examine(mob/user)
	. = ..()
	. += "This one has a flux anomaly core attached and can phase through walls."

/obj/mecha/combat/phazon/flux/GrantActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Grant(user, src)

/obj/mecha/combat/phazon/flux/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	phasing_action.Remove(user)


