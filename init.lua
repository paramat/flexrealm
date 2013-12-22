-- flexrealm 0.2.12 by paramat
-- For latest stable Minetest and back to 0.4.8
-- Depends default
-- Licenses: code WTFPL, textures CC BY-SA

-- Variables

local flex = false -- 3D noise flexy realm
local flat = true -- Normal flat realm
local vertical = false -- Vertical flat realm facing south
local invert = false -- Inverted flat realm
local dyson = false -- Dyson sphere
local planet = false -- Planet sphere
local tube = false -- East-West tube world

local light = false -- Layer of light emitting airlike nodes following terrain
local noflow = false -- Use non-flowing water in realms other than 'flat'

local limit = {
	XMIN = -33000, -- Limits for all realm types
	XMAX = 33000,
	YMIN = -32,
	YMAX = 33000,
	ZMIN = -33000,
	ZMAX = 33000,
}

-- Flexy realm
local GFAC = 10 -- Density gradient factor (noise4 multiplier). Reduce for higher hills

local TERRS = 96 -- Terrain scale for all realms below
-- Normal and inverted flat realms
local FLATY = 5048 -- Surface y
-- Vertical flat realm facing south
local VERTZ = 0 -- Surface z
-- Dyson sphere and planet sphere
local SPHEX = 0 -- Centre x
local SPHEZ = 0 -- ..z
local SPHEY = 15048 -- ..y 
local SPHER = 10000 -- Surface radius
-- Cylinder
local CYLZ = 0 -- Axis z
local CYLY = 6048 -- ..y 
local CYLR = 1000 -- Surface radius

-- Large scale density field 'grad'
local ICET = 0.05 --  -- Ice density threshold
local SAAV = 0 --  -- Sandline average density threshold
local SAAM = 0.06 --  -- Sandline density threshold amplitude
local SARA = 0.02 --  -- Sandline density threshold randomness
local DUGT = -0.03 --  -- Dune grass density threshold
local ROCK = -0.6 --  -- Rocky terrain density threshold
local CLLT = -0.9 --  -- Cloud low density threshold
local CLHT = -0.895 --  -- Cloud high density threshold
-- Terrain density field 'density = terno + grad'
local DEPT = 2 --  -- Realm depth density threshold
local SSLT1 = 0.20 --  -- Sandstone strata low density threshold1
local SSHT1 = 0.25 --  -- Sandstone strata high density threshold1
local SSLT2 = 0.30 --  -- Sandstone strata low density threshold2
local SSHT2 = 0.40 --  -- Sandstone strata high density threshold2
local SSLT3 = 0.50 --  -- Sandstone strata low density threshold3
local SSHT3 = 0.55 --  -- Sandstone strata high density threshold3
local STOT = 0.10 --  -- Stone density threshold at sea level
local DIRT = 0.05 --  -- Dirt density threshold
local TRET = 0.01 --  -- Tree growth density threshold, links tree density to soil depth
local LELT = -0.22 --  -- LEAN (Light Emitting Airlike Node) low density threshold
local LEHT = -0.18 --  -- LEAN high density threshold

local FITS = 0 --  -- Fissure threshold at surface. Controls size of fissure entrances at surface
local FEXP = 0.1 --  -- Fissure expansion rate under surface

local OCHA = 7*7*7 --  -- Ore 1/x chance per stone node

local HTET = 0.1 --  -- Desert / savanna / rainforest temperature noise threshold.
local LTET = -0.5 --  -- Tundra / taiga temperature noise threshold.
local HWET = 0.1 --  -- Wet grassland / rainforest wetness noise threshold.
local LWET = -0.5 --  -- Tundra / dry grassland / desert wetness noise threshold.
local BIOR = 0.03 --  -- Biome noise randomness for blend dithering

local flora = {
	ATCHA = 49, --  -- Apple tree maximum 1/x chance per surface node
	PTCHA = 49, --  -- Pine tree maximum 1/x chance per surface node
	STCHA = 529, --  -- Savanna tree maximum 1/x chance per surface node
	JTCHA = 25, --  -- Jungle tree maximum 1/x chance per surface node
	DEGCHA = 9, --  -- Grass 1/x chance per surface node
	SAGCHA = 5, --  -- Savanna grass 1/x chance per surface node
	DRGCHA = 3, --  -- Dry grassland grass 1/x chance per surface node
	WEGCHA = 3, --  -- Wet grassland grass 1/x chance per surface node
	DUGCHA = 5, --  -- Dune grass 1/x chance per surface node
	PAPCHA = 3, --  -- Papyrus 1/x chance per surface swamp water node
}

local LINT = 17 --  -- LEAN abm interval
local LCHA = 32*32 --  -- LEAN abm 1/x chance

-- Noise parameters

-- 3D noise 1 for terrain

local np_terrain = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = 92,
	octaves = 5,
	persist = 0.6
}

-- 3D noise 5 for terrain alt

local np_alter = {
	offset = 0,
	scale = 1,
	spread = {x=414, y=414, z=414},
	seed = -3911,
	octaves = 6,
	persist = 0.6
}

-- 3D noise 7 for smooth terrain

local np_smooth = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 800911,
	octaves = 5,
	persist = 0.4
}

-- 3D noise 8 for terrain blend

local np_terblen = {
	offset = 0,
	scale = 1,
	spread = {x=414, y=414, z=414},
	seed = -440002,
	octaves = 2,
	persist = 0.5
}

-- 3D noise 6 for faults and rivers

local np_fault = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 14440002,
	octaves = 5,
	persist = 0.6
}

-- 3D noise 2 for temperature

local np_temp = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 9130,
	octaves = 1,
	persist = 0.5
}

-- 3D noise 9 for humidity

local np_humid = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = -55500,
	octaves = 1,
	persist = 0.5
}

-- 3D noise 3 for fissures

local np_fissure = {
	offset = 0,
	scale = 1,
	spread = {x=104, y=104, z=104},
	seed = 186000048881,
	octaves = 4,
	persist = 0.5
}

-- 3D noise 4 for large scale density gradient

local np_dengrad = {
	offset = 0,
	scale = 1,
	spread = {x=828, y=828, z=828},
	seed = 80000002222208,
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
	if minp.x < limit.XMIN or maxp.x > limit.XMAX
	or minp.y < limit.YMIN or maxp.y > limit.YMAX
	or minp.z < limit.ZMIN or maxp.z > limit.ZMAX then
		return
	end
	
	local t1 = os.clock()
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	print ("[flexrealm] chunk minp ("..x0.." "..y0.." "..z0..")")
	local sidelen = x1 - x0 + 1 -- chunk side length
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
	local c_apple = minetest.get_content_id("default:apple")
	local c_leaves = minetest.get_content_id("default:leaves")
	local c_tree = minetest.get_content_id("default:tree")
	local c_snowblock = minetest.get_content_id("default:snowblock")
	local c_ice = minetest.get_content_id("default:ice")
	local c_sastone = minetest.get_content_id("default:sandstone")
	local c_needles = minetest.get_content_id("default:needles")
	local c_juntree = minetest.get_content_id("default:jungletree")
	local c_jungrass = minetest.get_content_id("default:junglegrass")
	local c_grass = minetest.get_content_id("default:grass_3")
	local c_dryshrub = minetest.get_content_id("default:dry_shrub")
	local c_watsour = minetest.get_content_id("default:water_source")
	local c_papyrus = minetest.get_content_id("default:papyrus")
	local c_dirt = minetest.get_content_id("default:dirt")
	
	local c_flrdirt = minetest.get_content_id("flexrealm:dirt")
	local c_flrgrass = minetest.get_content_id("flexrealm:grass")
	local c_flrsand = minetest.get_content_id("flexrealm:sand")
	local c_flrdesand = minetest.get_content_id("flexrealm:desand")
	local c_flrstone = minetest.get_content_id("flexrealm:stone")
	local c_flrdestone = minetest.get_content_id("flexrealm:destone")
	local c_flrleanoff = minetest.get_content_id("flexrealm:leanoff")
	local c_flrcloud = minetest.get_content_id("flexrealm:cloud")
	local c_flrneedles = minetest.get_content_id("flexrealm:needles")
	local c_flrdrygrass = minetest.get_content_id("flexrealm:drygrass")
	local c_flrfrograss = minetest.get_content_id("flexrealm:frograss")
	local c_flrperfrost = minetest.get_content_id("flexrealm:perfrost")
	local c_flrsavleaf = minetest.get_content_id("flexrealm:savleaf")
	local c_flrjunleaf = minetest.get_content_id("flexrealm:junleaf")
	local c_flrwatzero = minetest.get_content_id("flexrealm:watzero")
	local c_flrwatfour = minetest.get_content_id("flexrealm:watfour")
	local c_flrswatzero = minetest.get_content_id("flexrealm:swatzero")
	local c_flrswatfour = minetest.get_content_id("flexrealm:swatfour")
	
	local nvals1 = minetest.get_perlin_map(np_terrain, chulens):get3dMap_flat(minpos)
	local nvals2 = minetest.get_perlin_map(np_temp, chulens):get3dMap_flat(minpos)
	local nvals3 = minetest.get_perlin_map(np_fissure, chulens):get3dMap_flat(minpos)
	if flex then
		local nvals4 = minetest.get_perlin_map(np_dengrad, chulens):get3dMap_flat(minpos)
	end
	local nvals5 = minetest.get_perlin_map(np_alter, chulens):get3dMap_flat(minpos)
	local nvals6 = minetest.get_perlin_map(np_fault, chulens):get3dMap_flat(minpos)
	local nvals7 = minetest.get_perlin_map(np_smooth, chulens):get3dMap_flat(minpos)
	local nvals8 = minetest.get_perlin_map(np_terblen, chulens):get3dMap_flat(minpos)
	local nvals9 = minetest.get_perlin_map(np_humid, chulens):get3dMap_flat(minpos)
	
	local ni = 1
	for z = z0, z1 do
	for y = y0, y1 do
	local vi = area:index(x0, y, z) -- LVM index for first node in x row
	for x = x0, x1 do -- for each node do
		local nodid = data[vi] -- node
		
		local terno
		local grad
		local noise6 = nvals6[ni] -- faults
		local noise8 = nvals8[ni] -- terrain blend
		local terblen = math.min(math.abs(noise8) * 2, 1) -- terrain blend with smooth
		if noise6 >= -0.4 and noise6 <= 0.4 then
			terno = (nvals1[ni] + nvals5[ni]) / 2 * (1 - terblen) + nvals7[ni] * terblen
		else
			terno = (nvals1[ni] - nvals5[ni]) / 2 * (1 - terblen) - nvals7[ni] * terblen
		end
		if flex then
			local noise4 = nvals4[ni]
			grad = noise4 * GFAC
		elseif flat then
			grad = (FLATY - y) / TERRS
		elseif vertical then
			grad = (z - VERTZ) / TERRS
		elseif invert then
			grad = (y - FLATY) / TERRS
		elseif dyson or planet then
			local nodrad = math.sqrt((x - SPHEX) ^ 2 + (y - SPHEY) ^ 2 + (z - SPHEZ) ^ 2)
			if dyson then
				grad = (nodrad - SPHER) / TERRS
			else -- planet
				grad = (SPHER - nodrad) / TERRS
			end
		
		elseif tube then
			local nodrad = math.sqrt((y - CYLY) ^ 2 + (z - CYLZ) ^ 2)
			grad = (nodrad - CYLR) / TERRS
		end
		local density = terno + grad -- terrain density field
		
		if grad >= -1 and density <= DEPT then -- if realm then
		
			local desert = false -- desert biome
			local savanna = false -- savanna biome
			local raforest = false -- rainforest biome
			local wetgrass = false -- wet grassland biome
			local drygrass = false -- dry grassland biome
			local deforest = false -- deciduous forest biome
			local tundra = false -- tundra biome
			local taiga = false -- taiga forest biome
			if density > 0 or grad > 0 then -- if terrain or water calculate biome
				local temp = nvals2[ni] + grad
				local humid = nvals9[ni] + grad
				if temp > HTET + (math.random() - 0.5) * BIOR then
					if humid > HWET + (math.random() - 0.5) * BIOR then
						raforest = true
					elseif humid < LWET + (math.random() - 0.5) * BIOR then
						desert = true
					else
						savanna = true
					end
				elseif temp < LTET + (math.random() - 0.5) * BIOR then
					if humid < LWET + (math.random() - 0.5) * BIOR then
						tundra = true
					else
						taiga = true
					end
				elseif humid > HWET + (math.random() - 0.5) * BIOR then
					wetgrass = true
				elseif humid < LWET + (math.random() - 0.5) * BIOR then
					drygrass = true
				else
					deforest = true
				end
			end
		
			local nofis = false
			if density > 0 then -- if terrain then set nofis
				if math.abs(nvals3[ni]) > FITS + density ^ 0.5 * FEXP then
					nofis = true
				end
			end
			
			-- if surface node away from chunk boundary get up direction
			local tree = false
			local treedir
			if density <= TRET -- surface node
			and x-x0 >= 1 and x1 - x >= 1
			and y-y0 >= 1 and y1 - y >= 1
			and z-z0 >= 1 and z1 - z >= 1 then
				tree = true
			end
			if tree then
				local sphedis = SPHER * 0.707 
				local cyldis = CYLR * 0.707 
				if vertical then
					treedir = 6
				elseif invert then
					treedir = 4
				elseif flex then
					local nxp = nvals4[ni + 1] -- 1 east
					local nxn = nvals4[ni - 1] -- 2 west
					local nyp = nvals4[ni + 80] -- 3 up
					local nyn = nvals4[ni - 80] -- 4 down
					local nzp = nvals4[ni + 6400] -- 5 north
					local nzn = nvals4[ni - 6400] -- 6 south
					local nlo = math.min(nxp, nxn, nyp, nyn, nzp, nzn)
					if nxp == nlo then
						treedir = 1
					elseif nxn == nlo then
						treedir = 2
					elseif nyp == nlo then
						treedir = 3
					elseif nyn == nlo then
						treedir = 4
					elseif nzp == nlo then
						treedir = 5
					else
						treedir = 6
					end
				elseif dyson then
					if SPHEY - y > sphedis then
						treedir = 3
					elseif y - SPHEY > sphedis then
						treedir = 4
					elseif SPHEX - x > sphedis then
						treedir = 1
					elseif x - SPHEX > sphedis then
						treedir = 2
					elseif SPHEZ - z  > sphedis then
						treedir = 5
					else
						treedir = 6
					end
				elseif planet then
					if y - SPHEY > sphedis then
						treedir = 3
					elseif SPHEY - y > sphedis then
						treedir = 4
					elseif x - SPHEX > sphedis then
						treedir = 1
					elseif SPHEX - x > sphedis then
						treedir = 2
					elseif z - SPHEZ > sphedis then
						treedir = 5
					else
						treedir = 6
					end
				elseif tube then
					if CYLY - y > cyldis then
						treedir = 3
					elseif y - CYLY > cyldis then
						treedir = 4
					elseif CYLZ - z > cyldis then
						treedir = 5
					else
						treedir = 6
					end
				else -- flat realm
					treedir = 3
				end
			end
				
			local stot = STOT * (1 - grad / ROCK) -- thin fine materials with altitude
			
			local noise6abs = math.abs(noise6) -- rivers
			if noise6abs <= 0.03 * (1 - (density / 0.25) ^ 2)
			and grad <= 0.12 and (density > 0 or grad > 0) then
				if grad > 0.1 and density > 0 then
					data[vi] = c_flrsand
				elseif (density >= 0.1 and not desert) or grad > 0 then -- dry river in deserts
					if tundra or taiga then
						data[vi] = c_ice
					else
						if noflow then
							data[vi] = c_flrwatzero
						else
							data[vi] = c_flrwatfour
						end
					end
				end
			elseif noise6abs > 0.03 * (1 - (density / 0.25) ^ 2) -- riverbed sand
			and noise6abs <= 0.04 * (1 - (density / 0.3) ^ 2)
			and grad < 0.12 and density >= 0.1 then
				data[vi] = c_flrsand
			elseif (density >= stot and density <= DEPT and nofis) then -- stone cut by fissures
				if (density >= SSLT1 and density <= SSHT1)
				or (density >= SSLT2 and density <= SSHT2)
				or (density >= SSLT3 and density <= SSHT3) then
					data[vi] = c_sastone
				elseif desert then
					data[vi] = c_flrdestone
				elseif math.random(OCHA) == 2 then -- ores
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
			elseif density > 0 and density < stot then -- fine materials
				if grad >= SAAV + noise8 * SAAM + (math.random() - 0.5) * SARA then -- sand, beach, dunes
					if taiga and density < DIRT and grad <= 0 then -- snowy beach
						data[vi] = c_snowblock
					else
						data[vi] = c_flrsand
						if tree and grad < DUGT and math.random(flora.DUGCHA) == 2 then
							flexrealm_dryshrub(x, y, z, treedir, area, data, c_dryshrub, vi)
						end
					end
				elseif nofis or (not nofis and grad > 0) then -- fine materials cut by fissures above sea level only
					if density >= DIRT then
						if desert then
							data[vi] = c_flrdesand
						elseif tundra then
							data[vi] = c_flrperfrost
						elseif drygrass or savanna then
							data[vi] = c_flrdirt -- doesnt turn to green grass
						else
							data[vi] = c_dirt
						end
					else -- else surface nodes
						if taiga then
							if tree and math.random(flora.PTCHA) == 2 then
								flexrealm_pinetree(x, y, z, treedir, area, data, c_tree, c_flrneedles, c_snowblock)
							else
								data[vi] = c_snowblock
							end
						elseif deforest then
							data[vi] = c_flrgrass
							if tree and math.random(flora.ATCHA) == 2 then
								flexrealm_appletree(x, y, z, treedir, area, data, c_tree, c_leaves, c_apple)
							elseif tree and grad <= 0 and math.random(flora.DEGCHA) == 2 then
								flexrealm_grass(x, y, z, treedir, area, data, c_grass, vi)
							end
						elseif savanna then
							data[vi] = c_flrdrygrass
							if tree and math.random(flora.STCHA) == 2 then
								flexrealm_savannatree(x, y, z, treedir, area, data, c_tree, c_flrsavleaf)
							elseif tree and grad <= 0 and math.random(flora.SAGCHA) == 2 then
								flexrealm_dryshrub(x, y, z, treedir, area, data, c_dryshrub, vi)
							end
						elseif raforest then
							if tree and math.random(flora.JTCHA) == 2 then
								flexrealm_jungletree(x, y, z, treedir, area, data, c_juntree, c_flrjunleaf)
							else
								data[vi] = c_flrgrass
							end
						elseif drygrass then
							data[vi] = c_flrdrygrass
							if tree and grad <= 0 and math.random(flora.DRGCHA) == 2 then
								flexrealm_dryshrub(x, y, z, treedir, area, data, c_dryshrub, vi)
							end
						elseif wetgrass then
							data[vi] = c_flrgrass
							if tree and grad <= 0 and math.random(flora.WEGCHA) == 2 then
								flexrealm_jungrass(x, y, z, treedir, area, data, c_jungrass, vi)
							end
						elseif tundra then
							data[vi] = c_flrfrograss
						elseif desert then
							data[vi] = c_flrdesand
						end
					end
				end
			elseif taiga and grad > 0 and grad <= ICET and density <= 0 then -- ice sheets
				if nodid == c_air then
					data[vi] = c_ice
				end
			elseif grad > 0 and density <= 0 then
				if nodid == c_air then
					if noise8 > 0.2 and density > -0.01 + (math.random() - 0.5) * 0.005 and grad < 0.02
					and (desert or savanna or raforest) then
						if noflow then -- swampwater
							data[vi] = c_flrswatzero
						else
							data[vi] = c_flrswatfour
						end
						if math.random(flora.PAPCHA) == 2 then -- papyrus
							flexrealm_papyrus(x, y, z, treedir, area, data, c_papyrus, vi)
						end 
					elseif noflow then -- water
						data[vi] = c_flrwatzero
					else
						data[vi] = c_flrwatfour
					end
				end
			elseif not nofis and grad > 0 and density > 0 and density < DEPT
			and ((noise6 > -0.45 and noise6 < -0.35) or (noise6 > 0.35 and noise6 < 0.45)) then
				data[vi] = c_flrsand -- sand blocking fissures in faults below water level
			elseif light and density >= LELT and density <= LEHT and math.random(8) == 2 then
				if nodid == c_air then -- light emitting air nodes
					data[vi] = c_flrleanoff
				end
			elseif grad >= CLLT and grad <= CLHT -- clouds
			and ((density >= -1.1 and density <= -1.07)
			or (density >= -0.93 and density <= -0.9)) then
				if nodid == c_air then
					data[vi] = c_flrcloud
				end
			end
		end
		ni = ni + 1
		vi = vi + 1
	end
	end
	end
	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
	local chugent = math.ceil((os.clock() - t1) * 1000)
	print ("[flexrealm] "..chugent.." ms")
end)