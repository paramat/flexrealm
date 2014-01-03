minetest.register_node("flexrealm:dirt", {
	description = "FLR Dirt",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults(),
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

minetest.register_node("flexrealm:cactus", {
	description = "FLR Cactus",
	tiles = {"default_cactus_top.png", "default_cactus_top.png", "default_cactus_side.png"},
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {snappy=1,choppy=3,flammable=2},
	drop = "default:cactus",
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("flexrealm:papyrus", {
	description = "FLR Papyrus",
	drawtype = "plantlike",
	tiles = {"default_papyrus.png"},
	inventory_image = "default_papyrus.png",
	wield_image = "default_papyrus.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=3,flammable=2},
	drop = "default:papyrus",
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:watzero", {
	description = "FLR Water Source Range 0",
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
	liquid_alternative_flowing = "flexrealm:watzero",
	liquid_alternative_source = "flexrealm:watzero",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = false,
	liquid_range = 0,
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("flexrealm:watfour", {
	description = "FLR Water Source Range 3",
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
	liquid_alternative_source = "flexrealm:watfour",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = false,
	liquid_range = 3,
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("flexrealm:watflow", {
	description = "FLR Flowing Water Range 3",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	special_tiles = {
		{
			image="default_water_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="default_water_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
	},
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
	liquid_alternative_source = "flexrealm:watfour",
	liquid_viscosity = WATER_VISC,
	liquid_renewable = false,
	liquid_range = 3,
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

minetest.register_node("flexrealm:swatzero", {
	description = "FLR Swamp Water Source Range 0",
	inventory_image = minetest.inventorycube("flexrealm_swatzero.png"),
	tiles = {"flexrealm_swatzero.png"},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "flexrealm:swatzero",
	liquid_alternative_source = "flexrealm:swatzero",
	liquid_viscosity = 2,
	liquid_renewable = false,
	liquid_range = 0,
	post_effect_color = {a=128, r=31, g=56, b=8},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("flexrealm:swatfour", {
	description = "FLR Swamp Water Source Range 4",
	inventory_image = minetest.inventorycube("flexrealm_swatzero.png"),
	tiles = {"flexrealm_swatzero.png"},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "flexrealm:swatflow",
	liquid_alternative_source = "flexrealm:swatfour",
	liquid_viscosity = 2,
	liquid_renewable = false,
	liquid_range = 3,
	post_effect_color = {a=128, r=31, g=56, b=8},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("flexrealm:swatflow", {
	description = "FLR Flowing Swamp Water Range 4",
	inventory_image = minetest.inventorycube("flexrealm_swatzero.png"),
	drawtype = "flowingliquid",
	tiles = {"flexrealm_swatzero.png"},
	special_tiles = {
		{
			image="flexrealm_swatflowanim.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="flexrealm_swatflowanim.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "flexrealm:swatflow",
	liquid_alternative_source = "flexrealm:swatfour",
	liquid_viscosity = 2,
	liquid_renewable = false,
	liquid_range = 3,
	post_effect_color = {a=128, r=31, g=56, b=8},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

minetest.register_node("flexrealm:lavazero", {
	description = "FLR Lava Source Range 0",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "liquid",
	tiles = {
		{name="default_lava_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
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
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1},
})