-- flexrealm 0.1.3 by paramat
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

local GFAC = 6 --  -- Density gradient factor, reduce for higher hills

local ICET = 0.005 --  -- Ice density threshold noise4
local SANT = -0.005 --  -- Beach top threshold noise4
local SANR = -0.002 --  -- Beach top threshold randomness noise4
local ALIT = -0.005 --  -- Airlike density threshold noise4
local CLLT = -0.1 --  -- Cloud low density threshold noise4
local CLHT = -0.099 --  -- Cloud high density threshold noise4

local DEPT = 1 --  -- Realm depth density threshold noise1
local SSHT = 0.55 --  -- Sandstone strata high density threshold noise1
local SSLT = 0.45 --  -- Sandstone strata low density threshold noise1
local STOT = 0.15 --  -- Stone density threshold noise1
local DIRT = 0.05 --  -- Dirt density threshold noise1
local TRET = 0.01 --  -- Tree growth density threshold noise1, links tree density to soil depth
local LELT = -0.2 --  -- LEAN low density threshold noise1
local LEHT = -0.15 --  -- LEAN high density threshold noise1

local FITS = 0 --  -- Fissure threshold at surface, noise3. Controls size of fissures and amount / size of fissure entrances at surface
local FEXP = 0.1 --  -- Fissure expansion rate under surface

local OCHA = 7*7*7 --  -- Ore 1/x chance per stone node

local DEST = 2 --  -- Desert threshold noise 2
local TAIT = 2 --  -- Taiga threshold noise 2
local BIOR = 0.05 --  -- Biome noise randomness for blend dithering noise 2

local TCHA = 49 --  -- Tree maximum 1/x chance per grass or snowblock

local LINT = 17 --  -- LEAN abm interval
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
	persist = 0.3
}

-- Stuff

flexrealm = {}

dofile(minetest.get_modpath("flexrealm").."/nodes.lua")
dofile(minetest.get_modpath("flexrealm").."/functions.lua")

-- Abm

minetest.register_abm({
	nodenames = {"flexrealm:leanoff"},
	interval = LINT,
	chance = LCHA,
	action = function(pos, node)
		minetest.add_node(pos,{name="flexrealm:lean"})
	end,
})

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
	local c_sastone = minetest.get_content_id("default:sandstone")
	local c_needles = minetest.get_content_id("default:needles")
	
	local c_flrairlike = minetest.get_content_id("flexrealm:airlike")
	local c_flrgrass = minetest.get_content_id("flexrealm:grass")
	local c_flrsand = minetest.get_content_id("flexrealm:sand")
	local c_flrdesand = minetest.get_content_id("flexrealm:desand")
	local c_flrstone = minetest.get_content_id("flexrealm:stone")
	local c_flrdestone = minetest.get_content_id("flexrealm:destone")
	local c_flrleanoff = minetest.get_content_id("flexrealm:leanoff")
	local c_flrcloud = minetest.get_content_id("flexrealm:cloud")
	local c_flrneedles = minetest.get_content_id("flexrealm:needles")
	
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
		if noise2 > DEST + (math.random() - 0.5) * BIOR then
			desert = true
		elseif noise2 < TAIT + (math.random() - 0.5) * BIOR then
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
			if density >= SSLT and density <= SSHT then
				data[vi] = c_sastone
			elseif desert then
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
			if noise4 >= SANT + (math.random() - 0.5) * SANR then
				if taiga and density < DIRT and noise4 <= 0 then -- snowy beach
					data[vi] = c_snowblock
				else
					data[vi] = c_flrsand
				end
			elseif nofis then -- fine materials cut by fissures
				if desert then
					data[vi] = c_flrdesand
				else
					if density >= DIRT then
						data[vi] = c_dirt
					else
						local tree = false
						if math.random(TCHA) == 2 then
							if density <= TRET -- surface node, links trees to soil depth
							and x-x0 >= 1 and x1 - x >= 1
							and y-y0 >= 1 and y1 - y >= 1
							and z-z0 >= 1 and z1 - z >= 1 then
								tree = true
							end
						end
						if taiga then
							if tree then
								flexrealm_pinetree(x, y, z, ni, nvals4, area, data, c_tree, c_flrneedles, c_snowblock)
							else
								data[vi] = c_snowblock
							end
						else
							if tree then
								flexrealm_appletree(x, y, z, ni, nvals4, area, data, c_tree, c_leaves, c_apple)
							else
								data[vi] = c_flrgrass
							end
						end
					end
				end
			end
		elseif taiga and noise4 > 0 and noise4 <= ICET and density < 0 then
			if nodid == c_air then
				data[vi] = c_ice
			end
		elseif noise4 > 0 and density < 0 then
			if nodid == c_air then
				data[vi] = c_watsource
			end
		elseif noise4 >= ALIT and noise4 <= 0 and density < 0 then
			if nodid == c_air then
				data[vi] = c_flrairlike
			end
		elseif density >= LELT and density <= LEHT then
			if nodid == c_air then
				data[vi] = c_flrleanoff
			end
		elseif noise4 >= CLLT and noise4 <= CLHT 
		and ((density >= -1.2 and density <= -1.1) 
		or (density >= -1.0 and density <= -0.9) 
		or (density >= -0.8 and density <= -0.7)) then
			if nodid == c_air then
				data[vi] = c_flrcloud
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