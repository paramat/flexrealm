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