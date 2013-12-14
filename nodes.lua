minetest.register_node("flexrealm:airlike", {
	description = "FLR airlike",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("flexrealm:lean", {
	description = "FLR LEAN",
	drawtype = "airlike",
	paramtype = "light",
	light_source = 14,
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	buildable_to = true,
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("flexrealm:leanoff", {
	description = "FLR LEAN Off",
	drawtype = "airlike",
	paramtype = "light",
	light_source = 14,
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	buildable_to = true,
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("flexrealm:grass", {
	description = "FLR Grass",
	tiles = {"default_grass.png"},
	groups = {crumbly=3,soil=1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_node("flexrealm:frograss", {
	description = "FLR Frosty Grass",
	tiles = {"flexrealm_frograss.png"},
	groups = {crumbly=2},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.6},
	}),
})

minetest.register_node("flexrealm:sand", {
	description = "FLR Sand",
	tiles = {"default_sand.png"},
	groups = {crumbly=3, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("flexrealm:desand", {
	description = "FLR Desert Sand",
	tiles = {"default_desert_sand.png"},
	groups = {crumbly=3, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("flexrealm:stone", {
	description = "FLR Stone",
	tiles = {"default_stone.png"},
	groups = {cracky=3, stone=1},
	drop = "default:cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flexrealm:destone", {
	description = "FLR Desert Stone",
	tiles = {"default_desert_stone.png"},
	groups = {cracky=3, stone=1},
	drop = "default:desert_stone",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flexrealm:cloud", {
	description = "FLR Cloud",
	drawtype = "glasslike",
	tiles = {"flexrealm_cloud.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	post_effect_color = {a=23, r=241, g=248, b=255},
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("flexrealm:needles", {
	description = "FLR Pine Needles",
	tiles = {"flexrealm_needles.png"},
	groups = {snappy=3, leafdecay=3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:drygrass", {
	description = "FLR Dry Grass",
	tiles = {"flexrealm_drygrass.png"},
	groups = {crumbly=3,soil=1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_node("flexrealm:perfrost", {
	description = "FLR Permafrost",
	tiles = {"flexrealm_perfrost.png"},
	groups = {crumbly=1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("flexrealm:savleaf", {
	description = "FLR Savanna Tree Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"flexrealm_savleaf.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=4, flammable=2, leaves=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:junleaf", {
	description = "FLR Jungletree Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_jungleleaves.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=4, flammable=2, leaves=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("flexrealm:watflow", {
	description = "FLR Flowing Water",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	alpha = WATER_ALPHA,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "flexrealm:watflow",
	liquid_alternative_source = "flexrealm:watsour",
	liquid_viscosity = WATER_VISC,
	freezemelt = "default:snow",
	liquid_renewable = false,
	liquid_range = 0,
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1, freezes=1, melt_around=1},
})

minetest.register_node("flexrealm:watsour", {
	description = "FLR Water Source",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "liquid",
	tiles = {
		{name="default_water_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "flexrealm:watflow",
	liquid_alternative_source = "flexrealm:watsour",
	liquid_viscosity = WATER_VISC,
	freezemelt = "default:ice",
	liquid_renewable = false,
	liquid_range = 0,
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, freezes=1},
})
