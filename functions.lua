function flexrealm_appletree(x, y, z, treedir, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_apple = minetest.get_content_id("default:apple")
	local c_leaves = minetest.get_content_id("default:leaves")
	if treedir == 1 then
		for i = -1, 5 do
			if i >= 3 and i <= 5 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i + 1, y + j, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x + i, y, z)
			data[vit] = c_tree
		end
	elseif treedir == 2 then
		for i = -1, 5 do
			if i >= 3 and i <= 5 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x - i - 1, y + j, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x - i, y, z)
			data[vit] = c_tree
		end
	elseif treedir == 3 then
		for j = -1, 5 do
			if j >= 3 and j <= 5 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y + j + 1, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x, y + j, z)
			data[vit] = c_tree
		end
	elseif treedir == 4 then
		for j = -1, 5 do
			if j >= 3 and j <= 5 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y - j - 1, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x, y - j, z)
			data[vit] = c_tree
		end
	elseif treedir == 5 then
		for k = -1, 5 do
			if k >= 3 and k <= 5 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z + k + 1)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x, y, z + k)
			data[vit] = c_tree
		end
	elseif treedir == 6 then
		for k = -1, 5 do
			if k >= 3 and k <= 5 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z - k - 1)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(2) == 2 then
						data[vil] = c_leaves
					end
				end
				end
			end
			local vit = area:index(x, y, z - k)
			data[vit] = c_tree
		end
	end
end

function flexrealm_pinetree(x, y, z, treedir, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_flrneedles = minetest.get_content_id("flexrealm:needles")
	local c_snowblock = minetest.get_content_id("default:snowblock")
	if treedir == 1 then
		for i = -2, 11 do
		for j = -1, 1 do
		for k = -1, 1 do
			local vi = area:index(x + i, y + j, z + k)
			if i >= 2 and i <= 4 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif i == 5 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				elseif j * k == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif i >= 6 and i <= 7 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				elseif j * k == 0 then
					data[vi] = c_flrneedles
				end
			elseif i == 8 then
				if j == 0 and k == 0 then
					data[vi] = c_flrneedles
				elseif j * k == 0 then
					data[vi] = c_snowblock
				end
			elseif j == 0 and k == 0 then
				if i <= 1 then
					data[vi] = c_tree
				elseif i == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	elseif treedir == 2 then
		for i = -2, 11 do
		for j = -1, 1 do
		for k = -1, 1 do
			local vi = area:index(x - i, y + j, z + k)
			if i >= 2 and i <= 4 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif i == 5 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				elseif j * k == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif i >= 6 and i <= 7 then
				if j == 0 and k == 0 then
					data[vi] = c_tree
				elseif j * k == 0 then
					data[vi] = c_flrneedles
				end
			elseif i == 8 then
				if j == 0 and k == 0 then
					data[vi] = c_flrneedles
				elseif j * k == 0 then
					data[vi] = c_snowblock
				end
			elseif j == 0 and k == 0 then
				if i <= 1 then
					data[vi] = c_tree
				elseif i == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	elseif treedir == 3 then
		for j = -2, 11 do
		for i = -1, 1 do
		for k = -1, 1 do
			local vi = area:index(x + i, y + j, z + k)
			if j >= 2 and j <= 4 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif j == 5 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				elseif i * k == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif j >= 6 and j <= 7 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				elseif i * k == 0 then
					data[vi] = c_flrneedles
				end
			elseif j == 8 then
				if i == 0 and k == 0 then
					data[vi] = c_flrneedles
				elseif i * k == 0 then
					data[vi] = c_snowblock
				end
			elseif i == 0 and k == 0 then
				if j <= 1 then
					data[vi] = c_tree
				elseif j == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	elseif treedir == 4 then
		for j = -2, 11 do
		for i = -1, 1 do
		for k = -1, 1 do
			local vi = area:index(x + i, y - j, z + k)
			if j >= 2 and j <= 4 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif j == 5 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				elseif i * k == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif j >= 6 and j <= 7 then
				if i == 0 and k == 0 then
					data[vi] = c_tree
				elseif i * k == 0 then
					data[vi] = c_flrneedles
				end
			elseif j == 8 then
				if i == 0 and k == 0 then
					data[vi] = c_flrneedles
				elseif i * k == 0 then
					data[vi] = c_snowblock
				end
			elseif i == 0 and k == 0 then
				if j <= 1 then
					data[vi] = c_tree
				elseif j == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	elseif treedir == 5 then
		for k = -2, 11 do
		for i = -1, 1 do
		for j = -1, 1 do
			local vi = area:index(x + i, y + j, z + k)
			if k >= 2 and k <= 4 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif k == 5 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				elseif i * j == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif k >= 6 and k <= 7 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				elseif i * j == 0 then
					data[vi] = c_flrneedles
				end
			elseif k == 8 then
				if i == 0 and j == 0 then
					data[vi] = c_flrneedles
				elseif i * j == 0 then
					data[vi] = c_snowblock
				end
			elseif i == 0 and j == 0 then
				if k <= 1 then
					data[vi] = c_tree
				elseif k == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	elseif treedir == 6 then
		for k = -2, 11 do
		for i = -1, 1 do
		for j = -1, 1 do
			local vi = area:index(x + i, y + j, z - k)
			if k >= 2 and k <= 4 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				else
					data[vi] = c_flrneedles
				end
			elseif k == 5 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				elseif i * j == 0 then
					data[vi] = c_flrneedles
				else
					data[vi] = c_snowblock
				end
			elseif k >= 6 and k <= 7 then
				if i == 0 and j == 0 then
					data[vi] = c_tree
				elseif i * j == 0 then
					data[vi] = c_flrneedles
				end
			elseif k == 8 then
				if i == 0 and j == 0 then
					data[vi] = c_flrneedles
				elseif i * j == 0 then
					data[vi] = c_snowblock
				end
			elseif i == 0 and j == 0 then
				if k <= 1 then
					data[vi] = c_tree
				elseif k == 11 then
					data[vi] = c_snowblock
				else
					data[vi] = c_flrneedles
				end
			end		
		end
		end
		end
	end
end

function flexrealm_savannatree(x, y, z, treedir, area, data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_flrsavleaf = minetest.get_content_id("flexrealm:savleaf")
	if treedir == 1 then
		for i = -2, 6 do
			if i >= 5 then
				for j = -3, 3 do
				for k = -3, 3 do
					local vil = area:index(x + i + 1, y + j, z + k)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x + i, y, z)
			data[vit] = c_tree
		end
	elseif treedir == 2 then
		for i = -2, 6 do
			if i >= 5 then
				for j = -3, 3 do
				for k = -3, 3 do
					local vil = area:index(x - i - 1, y + j, z + k)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x - i, y, z)
			data[vit] = c_tree
		end
	elseif treedir == 3 then
		for j = -2, 6 do
			if j >= 5 then
				for i = -3, 3 do
				for k = -3, 3 do
					local vil = area:index(x + i, y + j + 1, z + k)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x, y + j, z)
			data[vit] = c_tree
		end
	elseif treedir == 4 then
		for j = -2, 6 do
			if j >= 5 then
				for i = -3, 3 do
				for k = -3, 3 do
					local vil = area:index(x + i, y - j - 1, z + k)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x, y - j, z)
			data[vit] = c_tree
		end
	elseif treedir == 5 then
		for k = -2, 6 do
			if k >= 5 then
				for i = -3, 3 do
				for j = -3, 3 do
					local vil = area:index(x + i, y + j, z + k + 1)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x, y, z + k)
			data[vit] = c_tree
		end
	elseif treedir == 6 then
		for k = -2, 6 do
			if k >= 5 then
				for i = -3, 3 do
				for j = -3, 3 do
					local vil = area:index(x + i, y + j, z - k - 1)
					if math.random(2) == 2 then
						data[vil] = c_flrsavleaf
					end
				end
				end
			end
			local vit = area:index(x, y, z - k)
			data[vit] = c_tree
		end
	end
end

function flexrealm_jungletree(x, y, z, treedir, area, data)
	local c_juntree = minetest.get_content_id("default:jungletree")
	local c_flrjunleaf = minetest.get_content_id("flexrealm:junleaf")
	if treedir == 1 then
		for i = -4, 17 do
			if i == 11 or i == 17 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i + math.random(0, 1), y + j, z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x + i, y, z)
			data[vit] = c_juntree
		end
	elseif treedir == 2 then
		for i = -4, 17 do
			if i == 11 or i == 17 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x - i - math.random(0, 1), y + j, z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x - i, y, z)
			data[vit] = c_juntree
		end
	elseif treedir == 3 then
		for j = -4, 17 do
			if j == 11 or j == 17 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y + j + math.random(0, 1), z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x, y + j, z)
			data[vit] = c_juntree
		end
	elseif treedir == 4 then
		for j = -4, 17 do
			if j == 3 or j == 17 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y - j - math.random(0, 1), z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x, y - j, z)
			data[vit] = c_juntree
		end
	elseif treedir == 5 then
		for k = -4, 17 do
			if k == 3 or k == 17 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z + k + math.random(0, 1))
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x, y, z + k)
			data[vit] = c_juntree
		end
	elseif treedir == 6 then
		for k = -4, 17 do
			if k == 11 or k == 17 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z - k - math.random(0, 1))
					if math.random(4) ~= 2 then
						data[vil] = c_flrjunleaf
					end
				end
				end
			end
			local vit = area:index(x, y, z - k)
			data[vit] = c_juntree
		end
	end
end


function flexrealm_randgrass(data, via)
		local c_grass1 = minetest.get_content_id("default:grass_1")
		local c_grass2 = minetest.get_content_id("default:grass_2")
		local c_grass3 = minetest.get_content_id("default:grass_3")
		local c_grass4 = minetest.get_content_id("default:grass_4")
		local c_grass5 = minetest.get_content_id("default:grass_5")
		local rand = math.random(5)
		if rand == 1 then
			data[via] = c_grass1
		elseif rand == 2 then
			data[via] = c_grass2
		elseif rand == 3 then
			data[via] = c_grass3
		elseif rand == 4 then
			data[via] = c_grass4
		else
			data[via] = c_grass5
		end
end

function flexrealm_grass(x, y, z, treedir, area, data)
	if treedir == 1 then
		local via = area:index(x + 1, y, z)
		flexrealm_randgrass(data, via)
	elseif treedir == 2 then
		local via = area:index(x - 1 , y, z)
		flexrealm_randgrass(data, via)
	elseif treedir == 3 then	
		local via = area:index(x, y + 1, z)
		flexrealm_randgrass(data, via)
	elseif treedir == 4 then
		local via = area:index(x, y - 1, z)
		flexrealm_randgrass(data, via)
	elseif treedir == 5 then
		local via = area:index(x, y, z + 1)
		flexrealm_randgrass(data, via)
	elseif treedir == 6 then
		local via = area:index(x, y, z - 1)
		flexrealm_randgrass(data, via)
	end
end


function flexrealm_dryshrub(x, y, z, treedir, area, data)
	local c_dryshrub = minetest.get_content_id("default:dry_shrub")
	if treedir == 1 then
		local via = area:index(x + 1, y, z)
		data[via] = c_dryshrub
	elseif treedir == 2 then
		local via = area:index(x - 1, y, z)
		data[via] = c_dryshrub
	elseif treedir == 3 then	
		local via = area:index(x , y + 1, z)
		data[via] = c_dryshrub
	elseif treedir == 4 then
		local via = area:index(x , y - 1, z)
		data[via] = c_dryshrub
	elseif treedir == 5 then
		local via = area:index(x , y , z + 1)
		data[via] = c_dryshrub
	elseif treedir == 6 then
		local via = area:index(x , y , z - 1)
		data[via] = c_dryshrub
	end
end

function flexrealm_jungrass(x, y, z, treedir, area, data)
	local c_jungrass = minetest.get_content_id("default:junglegrass")
	if treedir == 1 then
		local via = area:index(x + 1, y, z)
		data[via] = c_jungrass
	elseif treedir == 2 then
		data[via] = c_jungrass
	elseif treedir == 3 then	
		local via = area:index(x , y + 1, z)
		data[via] = c_jungrass
	elseif treedir == 4 then
		local via = area:index(x , y - 1, z)
		data[via] = c_jungrass
	elseif treedir == 5 then
		local via = area:index(x , y , z + 1)
		data[via] = c_jungrass
	elseif treedir == 6 then
		local via = area:index(x , y , z - 1)
		data[via] = c_jungrass
	end
end

function flexrealm_papyrus(x, y, z, treedir, area, data)
	local c_flrpapyrus = minetest.get_content_id("flexrealm:papyrus")
	local ph = math.random(1, 4)
	if treedir == 1 then
		for i = 1, ph do
			local vip = area:index(x + i, y, z)
			data[vip] = c_flrpapyrus
		end
	elseif treedir == 2 then
		for i = 1, ph do
			local vip = area:index(x - i, y, z)
			data[vip] = c_flrpapyrus
		end
	elseif treedir == 3 then
		for j = 1, ph do
			local vip = area:index(x, y + j, z)
			data[vip] = c_flrpapyrus
		end
	elseif treedir == 4 then
		for j = 1, ph do
			local vip = area:index(x, y - j, z)
			data[vip] = c_flrpapyrus
		end
	elseif treedir == 5 then
		for k = 1, ph do
			local vip = area:index(x, y, z + k)
			data[vip] = c_flrpapyrus
		end
	elseif treedir == 6 then
		for k = 1, ph do
			local vip = area:index(x, y, z - k)
			data[vip] = c_flrpapyrus
		end
	end
end

function flexrealm_randflower(data, via)
		local c_danwhi = minetest.get_content_id("flowers:dandelion_white")
		local c_danyel = minetest.get_content_id("flowers:dandelion_yellow")
		local c_rose = minetest.get_content_id("flowers:rose")
		local c_tulip = minetest.get_content_id("flowers:tulip")
		local c_geranium = minetest.get_content_id("flowers:geranium")
		local c_viola = minetest.get_content_id("flowers:viola")
		local rand = math.random(6)
		if rand == 1 then
			data[via] = c_danwhi
		elseif rand == 2 then
			data[via] = c_rose
		elseif rand == 3 then
			data[via] = c_tulip
		elseif rand == 4 then
			data[via] = c_danyel
		elseif rand == 5 then
			data[via] = c_geranium
		else
			data[via] = c_viola
		end
end

function flexrealm_flower(x, y, z, treedir, area, data)
	if treedir == 1 then
		local via = area:index(x + 1, y, z)
		flexrealm_randflower(data, via)
	elseif treedir == 2 then
		local via = area:index(x - 1, y, z)
		flexrealm_randflower(data, via)
	elseif treedir == 3 then	
		local via = area:index(x , y + 1, z)
		flexrealm_randflower(data, via)
	elseif treedir == 4 then
		local via = area:index(x , y - 1, z)
		flexrealm_randflower(data, via)
	elseif treedir == 5 then
		local via = area:index(x , y , z + 1)
		flexrealm_randflower(data, via)
	elseif treedir == 6 then
		local via = area:index(x , y , z - 1)
		flexrealm_randflower(data, via)
	end
end

function flexrealm_cactus(x, y, z, treedir, area, data)
	local c_flrcactus = minetest.get_content_id("flexrealm:cactus")
	if treedir == 1 then
		for i = -1, 5 do
		for j = -2, 2 do
			if j == 0 or i == 3 or (i == 4 and math.abs(j) == 2) then
				local vic = area:index(x + i, y + j, z)
				data[vic] = c_flrcactus
			end
		end
		end
	elseif treedir == 2 then
		for i = -1, 5 do
		for j = -2, 2 do
			if j == 0 or i == 3 or (i == 4 and math.abs(j) == 2) then
				local vic = area:index(x - i, y + j, z)
				data[vic] = c_flrcactus
			end
		end
		end
	elseif treedir == 3 then
		for j = -1, 5 do
		for i = -2, 2 do
			if i == 0 or j == 3 or (j == 4 and math.abs(i) == 2) then
				local vic = area:index(x + i, y + j, z)
				data[vic] = c_flrcactus
			end
		end
		end
	elseif treedir == 4 then
		for j = -1, 5 do
		for i = -2, 2 do
			if i == 0 or j == 3 or (j == 4 and math.abs(i) == 2) then
				local vic = area:index(x + i, y - j, z)
				data[vic] = c_flrcactus
			end
		end
		end
	elseif treedir == 5 then
		for k = -1, 5 do
		for i = -2, 2 do
			if i == 0 or k == 3 or (k == 4 and math.abs(i) == 2) then
				local vic = area:index(x + i, y, z + k)
				data[vic] = c_flrcactus
			end
		end
		end
	elseif treedir == 6 then
		for k = -1, 5 do
		for i = -2, 2 do
			if i == 0 or k == 3 or (k == 4 and math.abs(i) == 2) then
				local vic = area:index(x + i, y, z - k)
				data[vic] = c_flrcactus
			end
		end
		end
	end
end