-- flexrealm 0.4.3

-- Variables

local flat = false -- Normal flat realm
local vertical = false -- Vertical flat realm facing south
local invert = false -- Inverted flat realm
local planet = false -- Planet sphere
local dysonsphere = false -- Dyson sphere
local tube = true -- East-West tube world / O'Neill space colony
local cube = false -- Planet cube
local dysoncube = false -- Dyson cube

local limit = {
	XMIN = -33000, -- Limits for all realm types
	XMAX = 33000,
	YMIN = -33000,
	YMAX = 33000,
	ZMIN = -33000,
	ZMAX = 33000,
}

local TERRS = 64 -- Terrain scale for all realms below
-- Normal and inverted flat realms
local FLATY = 0 -- Surface y
-- Vertical flat realm facing south
local VERTZ = 0 -- Surface z
-- Dyson sphere and planet sphere
local SPHEX = 0 -- Centre x
local SPHEZ = 0 -- ..z
local SPHEY = 0 -- ..y 
local SPHER = 512 -- Surface radius
-- Tube realm
local TUBEZ = 0 -- Axis z
local TUBEY = 0 -- ..y
local TUBER = 512 -- Surface radius
local TUBEX = 4000 -- Endcap base +-x
local TUBED = 512 -- Endcap dish depth
-- Cube and dyson cube realm
local CUBEX = 0 -- Centre x
local CUBEZ = 0 -- ..z
local CUBEY = 0 -- ..y 
local CUBER = 512 -- Surface radius

-- Noise thresholds for density gradient 'grad'
local DEPT = 2 -- Realm +-depth density threshold
local ROCK = -1 -- Rocky terrain density threshold
local CLOLOT = -0.9 -- Cloud low density threshold
local CLOHIT = -0.89 -- Cloud high density threshold
-- Noise thresholds for density field 'density'
local TSAND = -0.04 -- Sand density threshold
local TSTONE = 0.09 -- Stone density threshold at sea level
local TDIRT = 0.03 -- Dirt density threshold
local TSURF = 0.02 -- Surface density threshold for flora generation

-- Other parameters
local TFIS = 0.02 -- Fissure width nose threshold
local OCHA = 7*7*7 -- Ore 1/x chance per stone node
local TCLOUD = 0.5 -- Cloud threshold, -2 = overcast, 2 = no cloud
local HITET = 0.4 -- High temperature noise threshold
local LOTET = -0.4 -- Low temperature noise threshold
local ICETET = -0.8 -- Icesheet / glacier temperature threshold
local HUT = 0 --  -- Humidity noise threshold

local flora = {
	APPCHA = 49, -- Apple tree maximum 1/x chance per surface node
	FLOCHA = 47 ^ 2, -- Flower 1/x chance per surface node
	GRACHA = 9, -- Grass 1/x chance per surface node
	PINCHA = 49, -- Pine tree maximum 1/x chance per surface node
	JUTCHA = 16, -- Jungle tree maximum 1/x chance per surface node
	JUGCHA = 16, -- Jungle tree maximum 1/x chance per surface node
	PAPCHA = 3, -- Papyrus 1/x chance per surface swamp water node
	CACCHA = 361, -- Cactus 1/x chance per surface node
}

-- Noise parameters

-- 3D noise for terrain

local np_terrain = {
	offset = 0,
	scale = 1,
	spread = {x=384, y=384, z=384},
	seed = 92,
	octaves = 5,
	persist = 0.63
}

-- 3D noise for smooth terrain

local np_smooth = {
	offset = 0,
	scale = 1,
	spread = {x=621, y=621, z=621},
	seed = 800911,
	octaves = 4,
	persist = 0.4
}

-- 3D noise for terrain blend

local np_terblen = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = -440002,
	octaves = 3,
	persist = 0.4
}

-- 3D noise for faults and rivers

local np_fault = {
	offset = 0,
	scale = 1,
	spread = {x=384, y=384, z=384},
	seed = 14440002,
	octaves = 4,
	persist = 0.5
}

-- 3D noise for temperature

local np_temp = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = 9130,
	octaves = 3,
	persist = 0.4
}

-- 3D noise for humidity

local np_humid = {
	offset = 0,
	scale = 1,
	spread = {x=256, y=256, z=256},
	seed = -55500,
	octaves = 3,
	persist = 0.4
}

-- 3D noise for fissures

local np_fissure = {
	offset = 0,
	scale = 1,
	spread = {x=192, y=192, z=192},
	seed = 108881,
	octaves = 4,
	persist = 0.5
}

-- 3D noise for clouds

local np_cloud = {
	offset = 0,
	scale = 1,
	spread = {x=104, y=104, z=104},
	seed = 2113,
	octaves = 4,
	persist = 0.7
}

-- Stuff

dofile(minetest.get_modpath("flexrealm").."/nodes.lua")
dofile(minetest.get_modpath("flexrealm").."/functions.lua")

minetest.register_on_mapgen_init(function(mgparams)
	minetest.set_mapgen_params({mgname="singlenode", flags="nolight", water_level=-31000})
end)

minetest.register_on_joinplayer(function(player)
	minetest.setting_set("enable_clouds", "false")
end)
	
minetest.register_on_leaveplayer(function(player)
	minetest.setting_set("enable_clouds", "true")
end)

-- Initialize noise objects to nil

local nobj_terrain = nil
local nobj_smooth = nil
local nobj_terblen = nil
local nobj_fault = nil
local nobj_fissure = nil
local nobj_temp = nil
local nobj_humid = nil
local nobj_cloud = nil

-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.x < limit.XMIN or maxp.x > limit.XMAX
	or minp.y < limit.YMIN or maxp.y > limit.YMAX
	or minp.z < limit.ZMIN or maxp.z > limit.ZMAX then
		return
	end
	
	local t0 = os.clock()
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	
	local c_air = minetest.get_content_id("air")
	local c_meseblock = minetest.get_content_id("default:mese_block")
	local c_stodiam = minetest.get_content_id("default:stone_with_diamond")
	local c_stogold = minetest.get_content_id("default:stone_with_gold")
	local c_stocopp = minetest.get_content_id("default:stone_with_copper")
	local c_stoiron = minetest.get_content_id("default:stone_with_iron")
	local c_stocoal = minetest.get_content_id("default:stone_with_coal")
	local c_snowblock = minetest.get_content_id("default:snowblock")
	local c_ice = minetest.get_content_id("default:ice")
	local c_sastone = minetest.get_content_id("default:sandstone")
	
	local c_flrdirt = minetest.get_content_id("flexrealm:dirt")
	local c_flrgrass = minetest.get_content_id("flexrealm:grass")
	local c_flrsand = minetest.get_content_id("flexrealm:sand")
	local c_flrdesand = minetest.get_content_id("flexrealm:desand")
	local c_flrstone = minetest.get_content_id("flexrealm:stone")
	local c_flrdestone = minetest.get_content_id("flexrealm:destone")
	local c_flrcloud = minetest.get_content_id("flexrealm:cloud")
	local c_flrperfrost = minetest.get_content_id("flexrealm:perfrost")
	local c_flrwatzero = minetest.get_content_id("flexrealm:watzero")
	local c_flrswatzero = minetest.get_content_id("flexrealm:swatzero")
	local c_flrlavazero = minetest.get_content_id("flexrealm:lavazero")
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	local p2data = vm:get_param2_data()

	local sidelen = x1 - x0 + 1
	local facearea = sidelen ^ 2
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minpos = {x=x0, y=y0, z=z0}

	nobj_terrain = nobj_terrain or minetest.get_perlin_map(np_terrain, chulens)
	nobj_smooth  = nobj_smooth  or minetest.get_perlin_map(np_smooth, chulens)
	nobj_terblen = nobj_terblen or minetest.get_perlin_map(np_terblen, chulens)
	nobj_fault   = nobj_fault   or minetest.get_perlin_map(np_fault, chulens)
	nobj_fissure = nobj_fissure or minetest.get_perlin_map(np_fissure, chulens)
	nobj_temp    = nobj_temp    or minetest.get_perlin_map(np_temp, chulens)
	nobj_humid   = nobj_humid   or minetest.get_perlin_map(np_humid, chulens)
	nobj_cloud   = nobj_cloud   or minetest.get_perlin_map(np_cloud, chulens)

	local nvals_terrain = nobj_terrain:get3dMap_flat(minpos)
	local nvals_smooth  = nobj_smooth:get3dMap_flat(minpos)
	local nvals_terblen = nobj_terblen:get3dMap_flat(minpos)
	local nvals_fault   = nobj_fault:get3dMap_flat(minpos)
	local nvals_fissure = nobj_fissure:get3dMap_flat(minpos)
	local nvals_temp    = nobj_temp:get3dMap_flat(minpos)
	local nvals_humid   = nobj_humid:get3dMap_flat(minpos)
	local nvals_cloud   = nobj_cloud:get3dMap_flat(minpos)

	local ni = 1
	for z = z0, z1 do
	for y = y0, y1 do
	local vi = area:index(x0, y, z)
	for x = x0, x1 do
		local nodid = data[vi]
		-- terrain blend
		local n_fault = nvals_fault[ni]
		local n_terblen = nvals_terblen[ni]
		local terblen = math.min(math.abs(n_terblen) * 2, 1)
		local terno
		if n_fault >= -0.4 and n_fault <= 0.4 then
			terno = nvals_terrain[ni] * (1 - terblen) + nvals_smooth[ni] * terblen
		else
			terno = nvals_terrain[ni] * (1 - terblen) - nvals_smooth[ni] * terblen
		end
		-- noise gradient
		local grad, sphexr, spheyr, sphezr, tubeyr, tubezr, cubexr, cubeyr, cubezr
		if flat then
			grad = (FLATY - y) / TERRS
		elseif vertical then
			grad = (z - VERTZ) / TERRS
		elseif invert then
			grad = (y - FLATY) / TERRS
		elseif dysonsphere or planet then
			sphexr = x - SPHEX
			spheyr = y - SPHEY
			sphezr = z - SPHEZ
			local nodrad = math.sqrt(sphexr ^ 2 + spheyr ^ 2 + sphezr ^ 2)
			if dysonsphere then
				grad = (nodrad - SPHER) / TERRS
			else
				grad = (SPHER - nodrad) / TERRS
			end
		elseif tube then
			tubeyr = y - TUBEY
			tubezr = z - TUBEZ
			local nodrad = math.sqrt(tubeyr ^ 2 + tubezr ^ 2)
			grad = (nodrad - TUBER) / TERRS
		elseif cube or dysoncube then
			cubexr = x - CUBEX
			cubeyr = y - CUBEY
			cubezr = z - CUBEZ
			local noddis = math.max(math.abs(cubexr), math.abs(cubeyr), math.abs(cubezr))
			if dysoncube then
				grad = (noddis - CUBER) / TERRS
			else
				grad = (CUBER - noddis) / TERRS
			end
		end
		-- density field
		local density
		if tube then
			if math.abs(x) > TUBEX then -- endcaps
				local wall = ((math.abs(x) - TUBEX) / TUBED) ^ 2 * TUBER / TERRS
				density = terno + grad + wall
			else
				density = terno + grad
			end
		else
			density = terno + grad
		end
		-- thin fine materials with altitude
		local stot = TSTONE * (1 - grad / ROCK)
		local altprop = math.max(1 + grad, 0)
		-- get biome
		local desert = false -- desert biome
		local rainforest = false -- rainforest biome
		local grassland = false -- grassland biome
		local forest = false -- deciduous forest biome
		local tundra = false -- tundra biome
		local taiga = false -- taiga forest biome
		local temp = nvals_temp[ni] + grad
		local n_humid = nvals_humid[ni]
		local humid = n_humid + grad
		if density > 0 or grad > 0 then -- if terrain or water calculate biome
			if temp > HITET then
				if humid > HUT then
					rainforest = true
				else
					desert = true
				end
			elseif temp < LOTET then
				if humid < HUT then
					tundra = true
				else
					taiga = true
				end
			elseif humid > HUT then
				forest = true
			else
				grassland = true
			end
		end
		-- caves boolean
		local nofis = math.abs(nvals_fissure[ni]) > TFIS
		-- if surface node away from chunk boundary get up direction for flora
		local surf = false
		if density <= TSURF -- surface node
		and x > x0 and x < x1
		and y > y0 and y < y1
		and z > z0 and z < z1 then
			surf = true
		end
		-- nodrot 0 = y+, 4 = z+, 8 = z-, 12 = x+, 16 = x-, 20 = y-
		local nodrot
		if surf then
			if flat then
				nodrot = 0
			elseif vertical then
				nodrot = 8
			elseif invert then
				nodrot = 20
			elseif planet then
				if spheyr > math.abs(sphexr)
				and spheyr > math.abs(sphezr) then
					nodrot = 0
				elseif spheyr < -math.abs(sphexr)
				and spheyr < -math.abs(sphezr) then
					nodrot = 20
				elseif sphexr > math.abs(spheyr)
				and sphexr > math.abs(sphezr) then
					nodrot = 12
				elseif sphexr < -math.abs(spheyr)
				and sphexr < -math.abs(sphezr) then
					nodrot = 16
				elseif sphezr > math.abs(sphexr)
				and sphezr > math.abs(spheyr) then
					nodrot = 4
				elseif sphezr < -math.abs(sphexr)
				and sphezr < -math.abs(spheyr) then
					nodrot = 8
				end
			elseif dysonsphere then
				if spheyr > math.abs(sphexr)
				and spheyr > math.abs(sphezr) then
					nodrot = 20
				elseif spheyr < -math.abs(sphexr)
				and spheyr < -math.abs(sphezr) then
					nodrot = 0
				elseif sphexr > math.abs(spheyr)
				and sphexr > math.abs(sphezr) then
					nodrot = 16
				elseif sphexr < -math.abs(spheyr)
				and sphexr < -math.abs(sphezr) then
					nodrot = 12
				elseif sphezr > math.abs(sphexr)
				and sphezr > math.abs(spheyr) then
					nodrot = 8
				elseif sphezr < -math.abs(sphexr)
				and sphezr < -math.abs(spheyr) then
					nodrot = 4
				end
			elseif tube then
				if tubeyr > math.abs(tubezr) then
					nodrot = 20
				elseif tubeyr < -math.abs(tubezr) then
					nodrot = 0
				elseif tubezr > math.abs(tubeyr) then
					nodrot = 8
				elseif tubezr < -math.abs(tubeyr) then
					nodrot = 4
				end
			elseif cube then
				if cubeyr > math.abs(cubexr)
				and cubeyr > math.abs(cubezr) then
					nodrot = 0
				elseif cubeyr < -math.abs(cubexr)
				and cubeyr < -math.abs(cubezr) then
					nodrot = 20
				elseif cubexr > math.abs(cubeyr)
				and cubexr > math.abs(cubezr) then
					nodrot = 12
				elseif cubexr < -math.abs(cubeyr)
				and cubexr < -math.abs(cubezr) then
					nodrot = 16
				elseif cubezr > math.abs(cubexr)
				and cubezr > math.abs(cubeyr) then
					nodrot = 4
				elseif cubezr < -math.abs(cubexr)
				and cubezr < -math.abs(cubeyr) then
					nodrot = 8
				end
			elseif dysoncube then
				if cubeyr > math.abs(cubexr)
				and cubeyr > math.abs(cubezr) then
					nodrot = 20
				elseif cubeyr < -math.abs(cubexr)
				and cubeyr < -math.abs(cubezr) then
					nodrot = 0
				elseif cubexr > math.abs(cubeyr)
				and cubexr > math.abs(cubezr) then
					nodrot = 16
				elseif cubexr < -math.abs(cubeyr)
				and cubexr < -math.abs(cubezr) then
					nodrot = 12
				elseif cubezr > math.abs(cubexr)
				and cubezr > math.abs(cubeyr) then
					nodrot = 8
				elseif cubezr < -math.abs(cubexr)
				and cubezr < -math.abs(cubeyr) then
					nodrot = 4
				end
			end
		end
		-- mapgen
		local n_faultabs = math.abs(n_fault) -- rivers
		if n_faultabs <= 0.03 * (1 - (density / 0.25) ^ 2) * altprop
		and grad <= 0.12 and (density > 0 or grad > 0) then
			if grad > 0.1 and density > 0 then
				data[vi] = c_flrsand
			elseif density >= 0.1 or grad > 0 then
				if temp < ICETET then
					data[vi] = c_ice
				else
					data[vi] = c_flrwatzero
				end
			end
		elseif n_faultabs > 0.03 * (1 - (density / 0.25) ^ 2) * altprop -- river sand
		and n_faultabs <= 0.04 * (1 - (density / 0.3) ^ 2) * altprop
		and grad < 0.12 and density >= 0.1 then
			data[vi] = c_flrsand
		elseif (density >= stot and grad <= DEPT and nofis) then -- stone
			if (density >= 0.5 and density <= 0.55)
			or (density >= 0.3 and density <= 0.4)
			or (density >= 0.2 and density <= 0.25) then
				data[vi] = c_sastone
			elseif desert then
				data[vi] = c_flrdestone
			elseif math.random(OCHA) == 2 and density >= STOT then -- ores
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
			if grad >= TSAND then -- beaches
				data[vi] = c_flrsand -- sand
			elseif nofis or (not nofis and grad > 0) then -- fine materials cut by
				if density >= TDIRT then		-- fissures above sea level only
					if desert then
						data[vi] = c_flrdesand
					elseif tundra then
						data[vi] = c_flrperfrost
					else
						data[vi] = c_flrdirt
					end
				else -- else surface nodes
					if taiga then
						if surf and math.random(flora.PINCHA) == 2 then
							flexrealm_pinetree(x, y, z, nodrot, area, data, p2data)
						else
							data[vi] = c_snowblock
						end
					elseif tundra then
						data[vi] = c_snowblock
					elseif forest then
						data[vi] = c_flrgrass
						if surf and math.random(flora.APPCHA) == 2 then
							flexrealm_appletree(x, y, z, nodrot, area, data, p2data)
						elseif surf and math.random(flora.FLOCHA) == 2 then
							flexrealm_flower(x, y, z, nodrot, area, data, p2data)
						elseif surf and math.random(flora.GRACHA) == 2 then
							flexrealm_grass(x, y, z, nodrot, area, data, p2data)
						end
					elseif grassland then
						data[vi] = c_flrgrass
						if surf and math.random(flora.GRACHA) == 2 then
							flexrealm_grass(x, y, z, nodrot, area, data, p2data)
						end
					elseif rainforest then
						data[vi] = c_flrgrass
						if surf and math.random(flora.JUTCHA) == 2 then
							flexrealm_jungletree(x, y, z, nodrot, area, data, p2data)
						elseif surf and math.random(flora.JUGCHA) == 2 then
							flexrealm_jungrass(x, y, z, nodrot, area, data, p2data)
						end
					elseif desert then
						if surf and math.random(flora.CACCHA) == 2 then
							flexrealm_cactus(x, y, z, nodrot, area, data, p2data)
						else
							data[vi] = c_flrdesand
						end
					end
				end
			end
		elseif temp < ICETET and grad > 0 and grad <= 0.05 and density <= 0 then -- ice sheets
			if nodid == c_air then
				data[vi] = c_ice
			end
		elseif grad > 0 and density <= 0 then
			if nodid == c_air then
				if n_terblen > 0.2 and density > -0.01 + (math.random() - 0.5) * 0.005
				and grad < 0.02 and (desert or rainforest) then
					data[vi] = c_flrswatzero -- swampwater
					if math.random(flora.PAPCHA) == 2 then -- papyrus
						flexrealm_papyrus(x, y, z, nodrot, area, data, p2data)
					end
				else
					data[vi] = c_flrwatzero -- water
				end
			end
		elseif not nofis and grad > 0 and density > 0 and grad <= DEPT
		and ((n_fault > -0.45 and n_fault < -0.35) or (n_fault > 0.35 and n_fault < 0.45)) then
			data[vi] = c_flrsand -- sand blocking fissures in faults below water level
		elseif grad >= CLOLOT and grad <= CLOHIT then -- clouds
			local xrq = 16 * math.floor((x - x0) / 16)
			local yrq = 16 * math.floor((y - y0) / 16)
			local zrq = 16 * math.floor((z - z0) / 16)
			local qixyz = zrq * facearea + yrq * sidelen + xrq + 1
			if nvals_cloud[qixyz] > TCLOUD and grad < -0.895 + n_humid * 0.005 then
				data[vi] = c_flrcloud
			end
		end

		ni = ni + 1
		vi = vi + 1
	end
	end
	end
	
	vm:set_data(data)
	vm:set_param2_data(p2data)
	vm:calc_lighting()
	vm:write_to_map(data)
	vm:update_liquids()

	local chugent = math.ceil((os.clock() - t0) * 1000)
	print ("[flexrealm] "..chugent.." ms  minp ("..x0.." "..y0.." "..z0..")")
end)

