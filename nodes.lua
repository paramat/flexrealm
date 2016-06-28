minetest.register_node("flexrealm:dirt", {
	description = "Flexrealm Dirt",
	tiles = {"default_dirt.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("flexrealm:grass", {
	description = "Flexrealm Grass",
	tiles = {"default_grass.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("flexrealm:sand", {
	description = "Flexrealm Sand",
	tiles = {"default_sand.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("flexrealm:desand", {
	description = "Flexrealm Desert Sand",
	tiles = {"default_desert_sand.png"},
	groups = {crumbly = 3, sand = 1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("flexrealm:stone", {
	description = "Flexrealm Stone",
	tiles = {"default_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "default:cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flexrealm:destone", {
	description = "Flexrealm Desert Stone",
	tiles = {"default_desert_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "default:desert_stone",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flexrealm:perfrost", {
	description = "Flexrealm Permafrost",
	tiles = {"flexrealm_perfrost.png"},
	groups = {crumbly = 1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("flexrealm:cloud", {
	description = "Flexrealm Cloud",
	drawtype = "glasslike",
	tiles = {"flexrealm_cloud.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	floodable = true,
	post_effect_color = {a = 23, r = 241, g = 248, b = 255},
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("flexrealm:leaves", {
	description = "Flexrealm Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:cactus", {
	description = "Flexrealm Cactus",
	tiles = {"default_cactus_top.png", "default_cactus_top.png", "default_cactus_side.png"},
	paramtype2 = "facedir",
	groups = {snappy = 1, choppy = 3, flammable = 2},
	drop = "default:cactus",
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

-- Zero range liquids

minetest.register_node("flexrealm:watzero", {
	description = "Flexrealm Water Source",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "liquid",
	tiles = {
		{
			name = "default_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
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
	liquid_alternative_flowing = "flexrealm:watzero",
	liquid_alternative_source = "flexrealm:watzero",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = false,
	liquid_range = 0,
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {water = 3, liquid = 3, puts_out_fire = 1},
})

minetest.register_node("flexrealm:lavazero", {
	description = "Flexrealm Lava Source",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "liquid",
	tiles = {
		{
			name = "default_lava_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "flexrealm:lavazero",
	liquid_alternative_source = "flexrealm:lavazero",
	liquid_viscosity = LAVA_VISC,
	liquid_renewable = false,
	liquid_range = 0,
	damage_per_second = 8,
	post_effect_color = {a = 192, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1},
})
