-- flexrealm 0.4.0

-- Variables

local flat = false -- Normal flat realm
local vertical = false -- Vertical flat realm facing south
local invert = false -- Inverted flat realm
local planet = true -- Planet sphere
local dysonsphere = false -- Dyson sphere
local tube = false -- East-West tube world / O'Neill space colony
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

local TERRS = 128 -- Terrain scale for all realms below
-- Normal and inverted flat realms
local FLATY = 0 -- Surface y
-- Vertical flat realm facing south
local VERTZ = 0 -- Surface z
-- Dyson sphere and planet sphere
local SPHEX = 0 -- Centre x
local SPHEZ = 0 -- ..z
local SPHEY = 0 -- ..y 
local SPHER = 128 -- Surface radius
-- Tube realm
local CYLZ = 0 -- Axis z
local CYLY = 0 -- ..y
local CYLR = 512 -- Surface radius
local CYLEX = 4000 -- Endcap base +-x
local CYLEW = 512 -- Endcap dish depth
-- Cube and dyson cube realm
local CUBEX = 0 -- Centre x
local CUBEZ = 0 -- ..z
local CUBEY = 0 -- ..y 
local CUBER = 512 -- Surface radius

-- Noise thresholds for density gradient 'grad'
local DEPT = 2 --  -- Realm +-depth density threshold
local ROCK = -1 --  -- Rocky terrain density threshold
local CLLT = -0.9 --  -- Cloud low density threshold
local CLHT = -0.89 --  -- Cloud high density threshold
-- Noise thresholds for density field 'density'
local STOT = 0.10 --  -- Stone density threshold at sea level
local DIRT = 0.05 --  -- Dirt density threshold
local TRET = 0.01 --  -- Tree growth density threshold

-- Other parameters
local TFIS = 0.02 -- Fissure width
local OCHA = 7*7*7 --  -- Ore 1/x chance per stone node
local TCLOUD = 0.5 --  -- Cloud threshold, -2 = overcast, 2 = no cloud
local HTET = 0.2 --  -- Desert / savanna / rainforest temperature noise threshold.
local LTET = -0.4 --  -- Tundra / taiga temperature noise threshold.
local HWET = 0.2 --  -- Wet grassland / rainforest wetness noise threshold.
local LWET = -0.4 --  -- Tundra / dry grassland / desert wetness noise threshold.
local BIOR = 0.02 --  -- Biome noise randomness for blend dithering

local flora = {
	ATCHA = 49, --  -- Apple tree maximum 1/x chance per surface node
	PTCHA = 49, --  -- Pine tree maximum 1/x chance per surface node
	STCHA = 529, --  -- Savanna tree maximum 1/x chance per surface node
	JTCHA = 16, --  -- Jungle tree maximum 1/x chance per surface node
	DEGCHA = 9, --  -- Grass 1/x chance per surface node
	SAGCHA = 5, --  -- Savanna grass 1/x chance per surface node
	DRGCHA = 5, --  -- Dry grassland grass 1/x chance per surface node
	WEGCHA = 5, --  -- Wet grassland grass 1/x chance per surface node
	DUGCHA = 5, --  -- Dune grass 1/x chance per surface node
	PAPCHA = 3, --  -- Papyrus 1/x chance per surface swamp water node
	DEFCHA = 47 ^ 2, --  -- Flower 1/x chance per surface node
	CACHA = 361, --  -- Cactus 1/x chance per surface node
}

-- Noise parameters

-- 3D noise for terrain

local np_terrain = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 92,
	octaves = 6,
	persist = 0.63
}

-- 3D noise for smooth terrain

local np_smooth = {
	offset = 0,
	scale = 1,
	spread = {x=828, y=828, z=828},
	seed = 800911,
	octaves = 5,
	persist = 0.4
}

-- 3D noise for terrain blend

local np_terblen = {
	offset = 0,
	scale = 1,
	spread = {x=670, y=670, z=670},
	seed = -440002,
	octaves = 3,
	persist = 0.33
}

-- 3D noise for faults and rivers

local np_fault = {
	offset = 0,
	scale = 1,
	spread = {x=512, y=512, z=512},
	seed = 14440002,
	octaves = 5,
	persist = 0.5
}

-- 3D noise for temperature

local np_temp = {
	offset = 0,
	scale = 1,
	spread = {x=1024, y=1024, z=1024},
	seed = 9130,
	octaves = 2,
	persist = 0.33
}

-- 3D noise for humidity

local np_humid = {
	offset = 0,
	scale = 1,
	spread = {x=1024, y=1024, z=1024},
	seed = -55500,
	octaves = 2,
	persist = 0.33
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
	local c_watsour = minetest.get_content_id("default:water_source")
	local c_dirt = minetest.get_content_id("default:dirt")
	local c_clay = minetest.get_content_id("default:clay")
	
	local c_flrdirt = minetest.get_content_id("flexrealm:dirt")
	local c_flrgrass = minetest.get_content_id("flexrealm:grass")
	local c_flrsand = minetest.get_content_id("flexrealm:sand")
	local c_flrdesand = minetest.get_content_id("flexrealm:desand")
	local c_flrstone = minetest.get_content_id("flexrealm:stone")
	local c_flrdestone = minetest.get_content_id("flexrealm:destone")
	local c_flrcloud = minetest.get_content_id("flexrealm:cloud")
	local c_flrdrygrass = minetest.get_content_id("flexrealm:drygrass")
	local c_flrfrograss = minetest.get_content_id("flexrealm:frograss")
	local c_flrperfrost = minetest.get_content_id("flexrealm:perfrost")
	local c_flrwatzero = minetest.get_content_id("flexrealm:watzero")
	local c_flrwatfour = minetest.get_content_id("flexrealm:watfour")
	local c_flrswatzero = minetest.get_content_id("flexrealm:swatzero")
	local c_flrswatfour = minetest.get_content_id("flexrealm:swatfour")
	local c_flrlavazero = minetest.get_content_id("flexrealm:lavazero")
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()

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
	local nodrot = 4 -- set to upside down to place non-flowing water before updir
	for z = z0, z1 do			-- is recalculated for node at ni = 6482
	for y = y0, y1 do
	local vi = area:index(x0, y, z)
	for x = x0, x1 do
		local nodid = data[vi]
		local density
		local terno
		local grad
		local cubexr, cubeyr, cubezr
		-- terrain blend
		local n_fault = nvals_fault[ni]
		local n_terblen = nvals_terblen[ni]
		local terblen = math.min(math.abs(n_terblen) * 2, 1)
		if n_fault >= -0.4 and n_fault <= 0.4 then
			terno = nvals_terrain[ni] * (1 - terblen) + nvals_smooth[ni] * terblen
		else
			terno = nvals_terrain[ni] * (1 - terblen) - nvals_smooth[ni] * terblen
		end
		-- noise gradient
		if flat then
			grad = (FLATY - y) / TERRS
		elseif vertical then
			grad = (z - VERTZ) / TERRS
		elseif invert then
			grad = (y - FLATY) / TERRS
		elseif dysonsphere or planet then
			local nodrad =
			math.sqrt((x - SPHEX) ^ 2 + (y - SPHEY) ^ 2 + (z - SPHEZ) ^ 2)
			if dysonsphere then
				grad = (nodrad - SPHER) / TERRS
			else
				grad = (SPHER - nodrad) / TERRS
			end
		elseif tube then
			local nodrad = math.sqrt((y - CYLY) ^ 2 + (z - CYLZ) ^ 2)
			grad = (nodrad - CYLR) / TERRS
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
		if tube then
			if math.abs(x) > CYLEX then -- endcaps
				local wall = ((math.abs(x) - CYLEX) / CYLEW) ^ 2 * CYLR / TERRS
				density = terno + grad + wall
			else
				density = terno + grad
			end
		else
			density = terno + grad
		end
		-- thin fine materials with altitude
		local stot = STOT * (1 - grad / ROCK)
		local altprop = math.max(1 + grad, 0)
		-- get biome
		local temp, humid
		local n_humid = nvals_humid[ni]
		local desert = false -- desert biome
		local savanna = false -- savanna biome
		local raforest = false -- rainforest biome
		local wetgrass = false -- wet grassland biome
		local drygrass = false -- dry grassland biome
		local deforest = false -- deciduous forest biome
		local tundra = false -- tundra biome
		local taiga = false -- taiga forest biome
		if density > 0 or grad > 0 then -- if terrain or water calculate biome
			temp = nvals_temp[ni] + grad
			humid = n_humid + grad
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
		-- caves boolean
		local nofis = math.abs(nvals_fissure[ni]) > TFIS
		-- if surface node away from chunk boundary get up direction for trees
		local tree = false
		if density <= TRET -- surface node
		and x > x0 and x < x1
		and y > y0 and y < y1
		and z > z0 and z < z1 then
			tree = true
		end
		if tree or ni == facearea + sidelen + 2 then -- set treedir at first non-border
			local sphedis = SPHER * 0.707 		-- node for water selection
			local cyldis = CYLR * 0.707 
			if flat then
				nodrot = 3
			elseif vertical then
				nodrot = 6
			elseif invert then
				nodrot = 4
			elseif dysonsphere then
				if SPHEY - y > sphedis then
					nodrot = 3
				elseif y - SPHEY > sphedis then
					nodrot = 4
				elseif SPHEX - x > sphedis then
					nodrot = 1
				elseif x - SPHEX > sphedis then
					nodrot = 2
				elseif SPHEZ - z  > sphedis then
					nodrot = 5
				else
					nodrot = 6
				end
			elseif planet then
				if y - SPHEY > sphedis then
					nodrot = 3
				elseif SPHEY - y > sphedis then
					nodrot = 4
				elseif x - SPHEX > sphedis then
					nodrot = 1
				elseif SPHEX - x > sphedis then
					nodrot = 2
				elseif z - SPHEZ > sphedis then
					nodrot = 5
				else
					nodrot = 6
				end
			elseif tube then
				if CYLY - y > cyldis then
					nodrot = 3
				elseif y - CYLY > cyldis then
					nodrot = 4
				elseif CYLZ - z > cyldis then
					nodrot = 5
				else
					nodrot = 6
				end
			elseif cube then
				if cubeyr > math.abs(cubexr)
				and cubeyr > math.abs(cubezr) then
					nodrot = 3
				elseif cubeyr < -math.abs(cubexr)
				and cubeyr < -math.abs(cubezr) then
					nodrot = 4
				elseif cubexr > math.abs(cubeyr)
				and cubexr > math.abs(cubezr) then
					nodrot = 1
				elseif cubexr < -math.abs(cubeyr)
				and cubexr < -math.abs(cubezr) then
					nodrot = 2
				elseif cubezr > math.abs(cubexr)
				and cubezr > math.abs(cubeyr) then
					nodrot = 5
				elseif cubezr < -math.abs(cubexr)
				and cubezr < -math.abs(cubeyr) then
					nodrot = 6
				end
			elseif dysoncube then
				if cubeyr > math.abs(cubexr)
				and cubeyr > math.abs(cubezr) then
					nodrot = 4
				elseif cubeyr < -math.abs(cubexr)
				and cubeyr < -math.abs(cubezr) then
					nodrot = 3
				elseif cubexr > math.abs(cubeyr)
				and cubexr > math.abs(cubezr) then
					nodrot = 2
				elseif cubexr < -math.abs(cubeyr)
				and cubexr < -math.abs(cubezr) then
					nodrot = 1
				elseif cubezr > math.abs(cubexr)
				and cubezr > math.abs(cubeyr) then
					nodrot = 6
				elseif cubezr < -math.abs(cubexr)
				and cubezr < -math.abs(cubeyr) then
					nodrot = 5
				end
			else
				nodrot = 3
			end
		end
		-- mapgen
		local n_faultabs = math.abs(n_fault) -- rivers
		if n_faultabs <= 0.03 * (1 - (density / 0.25) ^ 2) * altprop
		and grad <= 0.12 and (density > 0 or grad > 0) then
			if grad > 0.1 and density > 0 then
				data[vi] = c_flrsand
			elseif (density >= 0.1 and not desert) or grad > 0 then
				if tundra or taiga then		 -- dry river in deserts
					data[vi] = c_ice
				else
					if nodrot == 3 then
						data[vi] = c_flrwatfour
					else
						data[vi] = c_flrwatzero
					end
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
			if grad >= -0.04 + n_terblen * 0.08 then -- beaches
				if taiga and density < DIRT and grad <= 0 then -- snowy beach
					data[vi] = c_snowblock
				elseif deforest and grad > 0.05 and grad < 0.057 then -- clay
					data[vi] = c_clay
				else
					data[vi] = c_flrsand -- sand
					if tree and grad < -0.03
					and math.random(flora.DUGCHA) == 2 then
						flexrealm_dryshrub(x, y, z, treedir, area, data)
					end
				end
			elseif nofis or (not nofis and grad > 0) then -- fine materials cut by
				if density >= DIRT then		-- fissures above sea level only
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
							flexrealm_pinetree(x, y, z, nodrot, area, data)
						else
							data[vi] = c_snowblock
						end
					elseif deforest then
						data[vi] = c_flrgrass
						if tree and math.random(flora.ATCHA) == 2 then
							flexrealm_appletree(x, y, z, nodrot, area, data)
						elseif tree and grad <= 0
						and math.random(flora.DEFCHA) == 2 then
							flexrealm_flower(x, y, z, nodrot, area, data)
						elseif tree and grad <= 0
						and math.random(flora.DEGCHA) == 2 then
							flexrealm_grass(x, y, z, nodrot, area, data)
						end
					elseif savanna then
						data[vi] = c_flrdrygrass
						if tree and math.random(flora.STCHA) == 2 then
							flexrealm_savannatree(x, y, z, nodrot, area, data)
						elseif tree and grad <= 0
						and math.random(flora.SAGCHA) == 2 then
							flexrealm_dryshrub(x, y, z, nodrot, area, data)
						end
					elseif raforest then
						if tree and math.random(flora.JTCHA) == 2 then
							flexrealm_jungletree(x, y, z, nodrot, area, data)
						else
							data[vi] = c_flrgrass
						end
					elseif drygrass then
						data[vi] = c_flrdrygrass
						if tree and grad <= 0
						and math.random(flora.DRGCHA) == 2 then
							flexrealm_dryshrub(x, y, z, nodrot, area, data)
						end
					elseif wetgrass then
						data[vi] = c_flrgrass
						if tree and grad <= 0
						and math.random(flora.WEGCHA) == 2 then
							if math.random(3) == 2 then
								flexrealm_grass(x, y, z, nodrot, area, data)
							else
								flexrealm_jungrass(x, y, z, nodrot, area, data)
							end
						end
					elseif tundra then
						data[vi] = c_flrfrograss
					elseif desert then
						if tree and humid > LWET - 0.2
						and math.random(flora.CACHA) == 2 then
							flexrealm_cactus(x, y, z, nodrot, area, data)
						else
							data[vi] = c_flrdesand
						end
					end
				end
			end
		elseif taiga and grad > 0 and grad <= 0.05 and density <= 0 then -- ice sheets
			if nodid == c_air then
				data[vi] = c_ice
			end
		elseif grad > 0 and density <= 0 then
			if nodid == c_air then
				if n_terblen > 0.2 and density > -0.01 + (math.random() - 0.5) * 0.005
				and grad < 0.02 and (desert or savanna or raforest) then
					if nodrot == 3 then -- swampwater
						data[vi] = c_flrswatfour
					else
						data[vi] = c_flrswatzero
					end
					if math.random(flora.PAPCHA) == 2 then -- papyrus
						flexrealm_papyrus(x, y, z, treedir, area, data)
					end 
				elseif nodrot == 3 then -- water
					data[vi] = c_flrwatfour
				else
					data[vi] = c_flrwatzero
				end
			end
		elseif not nofis and grad > 0 and density > 0 and grad <= DEPT
		and ((n_fault > -0.45 and n_fault < -0.35) or (n_fault > 0.35 and n_fault < 0.45)) then
			data[vi] = c_flrsand -- sand blocking fissures in faults below water level
		elseif grad >= CLLT and grad <= CLHT then -- clouds
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
	vm:calc_lighting()
	vm:write_to_map(data)
	vm:update_liquids()

	local chugent = math.ceil((os.clock() - t0) * 1000)
	print ("[flexrealm] "..chugent.." ms  minp ("..x0.." "..y0.." "..z0..")")
end)
