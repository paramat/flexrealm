minetest.register_node("flexrealm:dirt", {
	description = "Flexrealm Dirt",
	tiles = {"default_dirt.png"},
	groups = {crumbly=3,soil=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("flexrealm:grass", {
	description = "Flexrealm Grass",
	tiles = {"default_grass.png"},
	groups = {crumbly=3,soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_node("flexrealm:sand", {
	description = "Flexrealm Sand",
	tiles = {"default_sand.png"},
	groups = {crumbly=3, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("flexrealm:desand", {
	description = "Flexrealm Desert Sand",
	tiles = {"default_desert_sand.png"},
	groups = {crumbly=3, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("flexrealm:stone", {
	description = "Flexrealm Stone",
	tiles = {"default_stone.png"},
	groups = {cracky=3, stone=1},
	drop = "default:cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flexrealm:destone", {
	description = "Flexrealm Desert Stone",
	tiles = {"default_desert_stone.png"},
	groups = {cracky=3, stone=1},
	drop = "default:desert_stone",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("flexrealm:perfrost", {
	description = "Flexrealm Permafrost",
	tiles = {"flexrealm_perfrost.png"},
	groups = {crumbly=1},
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
	post_effect_color = {a=23, r=241, g=248, b=255},
	groups = {not_in_creative_inventory=1},
})

-- Rotated nodes

minetest.register_node("flexrealm:leaves", {
	description = "Flexrealm Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, flammable=2, leaves=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:jungleleaves", {
	description = "Flexrealm Jungle Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"default_jungleleaves.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, flammable=2, leaves=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:pine_needles",{
	description = "Flexrealm Pine Needles",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_pine_needles.png"},
	waving = 1,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, flammable=2, leaves=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:cactus", {
	description = "Flexrealm Cactus",
	tiles = {"default_cactus_top.png", "default_cactus_top.png", "default_cactus_side.png"},
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=3,flammable=2},
	drop = "default:cactus",
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("flexrealm:papyrus", {
	description = "Flexrealm Papyrus",
	drawtype = "plantlike",
	tiles = {"default_papyrus.png"},
	inventory_image = "default_papyrus.png",
	wield_image = "default_papyrus.png",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	groups = {snappy=3,flammable=2},
	drop = "default:papyrus",
	sounds = default.node_sound_leaves_defaults(),
})

for i=1,5 do
	minetest.register_node("flexrealm:grass_"..i, {
		description = "Flexrealm Grass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"default_grass_"..i..".png"},
		inventory_image = "default_grass_"..i..".png",
		wield_image = "default_grass_"..i..".png",
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		buildable_to = true,
		groups = {snappy=3,flammable=3,flora=1,attached_node=1,not_in_creative_inventory=1},
		sounds = default.node_sound_leaves_defaults(),
	})
end

minetest.register_node("flexrealm:dry_shrub", {
	description = "Flexrealm Dry Shrub",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.0,
	tiles = {"default_dry_shrub.png"},
	inventory_image = "default_dry_shrub.png",
	wield_image = "default_dry_shrub.png",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=3,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:junglegrass", {
	description = "Flexrealm Jungle Grass",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"default_junglegrass.png"},
	inventory_image = "default_junglegrass.png",
	wield_image = "default_junglegrass.png",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:rose", {
	description = "Flexrealm Rose",
	drawtype = "plantlike",
	tiles = { "flowers_rose.png" },
	inventory_image = "flowers_rose.png",
	wield_image = "flowers_rose.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_red=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:tulip", {
	description = "Flexrealm Tulip",
	drawtype = "plantlike",
	tiles = { "flowers_tulip.png" },
	inventory_image = "flowers_tulip.png",
	wield_image = "flowers_tulip.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_orange=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:dandelion_yellow", {
	description = "Flexrealm Yellow Dandelion",
	drawtype = "plantlike",
	tiles = { "flowers_dandelion_yellow.png" },
	inventory_image = "flowers_dandelion_yellow.png",
	wield_image = "flowers_dandelion_yellow.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:geranium", {
	description = "Flexrealm Blue Geranium",
	drawtype = "plantlike",
	tiles = { "flowers_geranium.png" },
	inventory_image = "flowers_geranium.png",
	wield_image = "flowers_geranium.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_blue=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:viola", {
	description = "Flexrealm Viola",
	drawtype = "plantlike",
	tiles = { "flowers_viola.png" },
	inventory_image = "flowers_viola.png",
	wield_image = "flowers_viola.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_violet=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("flexrealm:dandelion_white", {
	description = "Flexrealm White Dandelion",
	drawtype = "plantlike",
	tiles = { "flowers_dandelion_white.png" },
	inventory_image = "flowers_dandelion_white.png",
	wield_image = "flowers_dandelion_white.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_white=1},
	sounds = default.node_sound_leaves_defaults(),
})

-- Zero range liquids

minetest.register_node("flexrealm:watzero", {
	description = "Flexrealm Water Source",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "liquid",
	tiles = {
		{
			name="default_water_source_animated.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=2.0,
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
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("flexrealm:swatzero", {
	description = "Flexrealm Swamp Water Source",
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

minetest.register_node("flexrealm:lavazero", {
	description = "Flexrealm Lava Source",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "liquid",
	tiles = {
		{
			name="default_lava_source_animated.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0,
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
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1},
})

