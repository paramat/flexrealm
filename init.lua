-- flexvrealm 0.1.0 by paramat
-- For latest stable Minetest and back to 0.4.8
-- Depends default
-- Licenses: code WTFPL, textures CC BY-SA

-- Variables

local XMIN = -33000 -- Approximate limits
local XMAX = 33000
local YMIN = -32
local YMAX = 33000
local ZMIN = -33000
local ZMAX = 33000

local GFAC = 7 -- Gradient factor
local SANT = -0.005 -- Beach top noise4 threshold
local DEPT = 1 --  -- Realm depth density threshold
local STOT = 0.15 --  -- Stone density threshold
local DIRT = 0.05 --  -- Dirt density threshold
local FITS = 0 --  -- Fissure noise3 threshold at surface. Controls size of fissures and amount / size of fissure entrances at surface
local FEXP = 0.1 --  -- Fissure expansion rate under surface
local TCHA = 121 --  -- Apple tree maximum 1/x chance per grass node
local ACHA = 17 --  -- Apple 1/x chance per leaf node
local CCHA = 529 --  -- Cactus maximum 1/x chance per desert sand node
local OCHA = 7*7*7 --  -- Ore 1/x chance per stone node
local LINT = 23 --  -- LEAN abm interval
local LCHA = 32*32 --  -- LEAN abm 1/x chance

-- Noise parameters

-- 3D noise 1 for terrain

local np_terrain = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = -83928935,
	octaves = 5,
	persist = 0.6
}

-- 3D noise 2 for biomes and cactus/tree areas

local np_biome = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = 555989881,
	octaves = 3,
	persist = 0.5
}

-- 3D noise 3 for fissures

local np_fissure = {
	offset = 0,
	scale = 1,
	spread = {x=64, y=64, z=64},
	seed = -188881,
	octaves = 4,
	persist = 0.5
}

-- 3D noise 4 for density gradient

local np_dengrad = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 800000022222,
	octaves = 3,
	persist = 0.33
}

-- Nodes

minetest.register_node("flexrealm:airlike", {
	description = "FLR airlike",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = true,
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
	pointable = true,
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
	pointable = true,
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

-- Abm

minetest.register_abm({
	nodenames = {"flexrealm:leanoff"},
	interval = LINT,
	chance = LCHA,
	action = function(pos, node)
		minetest.add_node(pos,{name="flexrealm:lean"})
	end,
})

-- Stuff

flexrealm = {}

-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.x < XMIN or maxp.x > XMAX
	or minp.y < YMIN or maxp.y > YMAX
	or minp.z < ZMIN or maxp.z > ZMAX then
		return
	end
	
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local sidelen = x1 - x0 + 1 -- chunk side length
	local vplanarea = sidelen ^ 2 -- vertical plane area, used if calculating index from x y z
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minpos = {x=x0, y=y0, z=z0}
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	
	local c_air = minetest.get_content_id("air")
	local c_meseblock = minetest.get_content_id("default:mese_block")
	local c_stodiam = minetest.get_content_id("default:stone_with_diamond")
	local c_stogold = minetest.get_content_id("default:stone_with_gold")
	local c_stocopp = minetest.get_content_id("default:stone_with_copper")
	local c_stoiron = minetest.get_content_id("default:stone_with_iron")
	local c_stocoal = minetest.get_content_id("default:stone_with_coal")
	local c_cactus = minetest.get_content_id("default:cactus")
	local c_dirt = minetest.get_content_id("default:dirt")
	local c_watsource = minetest.get_content_id("default:water_source")
	local c_apple = minetest.get_content_id("default:apple")
	local c_leaves = minetest.get_content_id("default:leaves")
	local c_tree = minetest.get_content_id("default:tree")
	local c_snowblock = minetest.get_content_id("default:snowblock")
	local c_ice = minetest.get_content_id("default:ice")
	local c_flrairlike = minetest.get_content_id("flexrealm:airlike")
	local c_flrgrass = minetest.get_content_id("flexrealm:grass")
	local c_flrsand = minetest.get_content_id("flexrealm:sand")
	local c_flrdesand = minetest.get_content_id("flexrealm:desand")
	local c_flrstone = minetest.get_content_id("flexrealm:stone")
	local c_flrdestone = minetest.get_content_id("flexrealm:destone")
	local c_flrleanoff = minetest.get_content_id("flexrealm:leanoff")
	
	local nvals1 = minetest.get_perlin_map(np_terrain, chulens):get3dMap_flat(minpos)
	local nvals2 = minetest.get_perlin_map(np_biome, chulens):get3dMap_flat(minpos)
	local nvals3 = minetest.get_perlin_map(np_fissure, chulens):get3dMap_flat(minpos)
	local nvals4 = minetest.get_perlin_map(np_dengrad, chulens):get3dMap_flat(minpos)
	
	local ni = 1
	for z = z0, z1 do
	for y = y0, y1 do
	for x = x0, x1 do -- for each node do
		local vi = area:index(x, y, z) -- LVM index for node
		local nodid = data[vi] -- node
		local nofis = false
		local desert = false
		local forest = false
		local taiga = false
		local noise2 = nvals2[ni]
		if noise2 > 0.4 then
			desert = true
		elseif noise2 < -0.4 then
			taiga = true
		else
			forest = true
		end
		local noise4 = nvals4[ni]
		local grad = noise4 * GFAC -- gradient
		local density = nvals1[ni] + grad -- noisy gradient
		if math.abs(nvals3[ni]) > FITS + density ^ 0.5 * FEXP then -- if no fissure then
			nofis = true
		end
		if density >= STOT and density <= DEPT and nofis then -- stone cut by fissures
			if desert then
				data[vi] = c_flrdestone
			elseif math.random(OCHA) == 2 then
				local osel = math.random(34)
				if osel == 34 then
					data[vi] = c_meseblock -- revenge!
				elseif osel >= 31 then
					data[vi] = c_stodiam
				elseif osel >= 28 then
					data[vi] = c_stogold
				elseif osel >= 19 then
					data[vi] = c_stocopp
				elseif osel >= 10 then
					data[vi] = c_stoiron
				else
					data[vi] = c_stocoal
				end
			else
				data[vi] = c_flrstone
			end
		elseif density > 0 and density < STOT then -- fine materials not cut by fissures
			if noise4 >= SANT then
				data[vi] = c_flrsand
			elseif nofis then -- fine materials cut by fissures
				if desert then
					data[vi] = c_flrdesand
				else
					if density >= DIRT then
						data[vi] = c_dirt
					else
						if taiga then
							data[vi] = c_snowblock
						else
							data[vi] = c_flrgrass
						end
					end
				end
			end
		elseif taiga and noise4 > 0 and noise4 <= 0.005 and density < 0 then
			if nodid == c_air then
				data[vi] = c_ice
			end
		elseif noise4 > 0 and density < 0 then
			if nodid == c_air then
				data[vi] = c_watsource
			end
		elseif noise4 >= -0.005 and noise4 <= 0 and density < 0 then
			if nodid == c_air then
				data[vi] = c_flrairlike
			end
		elseif density >= -0.2 and density <= -0.15 then
			if nodid == c_air then
				data[vi] = c_flrleanoff
			end
		end
		ni = ni + 1
	end
	end
	end
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
end)