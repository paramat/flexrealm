function flexrealm_appletree(x, y, z, nodrot, area, data, p2data)
	local c_tree = minetest.get_content_id("default:tree")
	local c_apple = minetest.get_content_id("default:apple")
	local c_leaves = minetest.get_content_id("flexrealm:leaves")
	if nodrot == 12 then
		for i = -1, 5 do
			if i >= 3 and i <= 5 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i + 1, y + j, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(5) ~= 2 then
						data[vil] = c_leaves
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x + i, y, z)
			data[vit] = c_tree
			p2data[vit] = nodrot
		end
	elseif nodrot == 16 then
		for i = -1, 5 do
			if i >= 3 and i <= 5 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x - i - 1, y + j, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(5) ~= 2 then
						data[vil] = c_leaves
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x - i, y, z)
			data[vit] = c_tree
			p2data[vit] = nodrot
		end
	elseif nodrot == 0 then
		for j = -1, 5 do
			if j >= 3 and j <= 5 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y + j + 1, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(5) ~= 2 then
						data[vil] = c_leaves
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x, y + j, z)
			data[vit] = c_tree
			p2data[vit] = nodrot
		end
	elseif nodrot == 20 then
		for j = -1, 5 do
			if j >= 3 and j <= 5 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y - j - 1, z + k)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(5) ~= 2 then
						data[vil] = c_leaves
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x, y - j, z)
			data[vit] = c_tree
			p2data[vit] = nodrot
		end
	elseif nodrot == 4 then
		for k = -1, 5 do
			if k >= 3 and k <= 5 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z + k + 1)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(5) ~= 2 then
						data[vil] = c_leaves
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x, y, z + k)
			data[vit] = c_tree
			p2data[vit] = nodrot
		end
	elseif nodrot == 8 then
		for k = -1, 5 do
			if k >= 3 and k <= 5 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z - k - 1)
					if math.random(48) == 2 then
						data[vil] = c_apple
					elseif math.random(5) ~= 2 then
						data[vil] = c_leaves
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x, y, z - k)
			data[vit] = c_tree
			p2data[vit] = nodrot
		end
	end
end


function flexrealm_pinetree(x, y, z, nodrot, area, data, p2data)
	local c_tree = minetest.get_content_id("default:pinetree")
	local c_needles = minetest.get_content_id("flexrealm:pine_needles")
	local c_snowblock = minetest.get_content_id("default:snowblock")
end


function flexrealm_jungletree(x, y, z, nodrot, area, data, p2data)
	local c_juntree = minetest.get_content_id("default:jungletree")
	local c_junleaf = minetest.get_content_id("flexrealm:jungleleaves")
	if nodrot == 12 then
		for i = -4, 17 do
			if i == 11 or i == 12 or i == 16 or i == 17 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y + j, z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_junleaf
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x + i, y, z)
			data[vit] = c_juntree
			p2data[vit] = nodrot
		end
	elseif nodrot == 16 then
		for i = -4, 17 do
			if i == 11 or i == 12 or i == 16 or i == 17 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x - i, y + j, z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_junleaf
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x - i, y, z)
			data[vit] = c_juntree
			p2data[vit] = nodrot
		end
	elseif nodrot == 0 then
		for j = -4, 17 do
			if j == 11 or j == 12 or j == 16 or j == 17 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y + j, z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_junleaf
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x, y + j, z)
			data[vit] = c_juntree
			p2data[vit] = nodrot
		end
	elseif nodrot == 20 then
		for j = -4, 17 do
			if j == 11 or j == 12 or j == 16 or j == 17 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y - j, z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_junleaf
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x, y - j, z)
			data[vit] = c_juntree
			p2data[vit] = nodrot
		end
	elseif nodrot == 4 then
		for k = -4, 17 do
			if k == 11 or k == 12 or k == 16 or k == 17 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z + k)
					if math.random(4) ~= 2 then
						data[vil] = c_junleaf
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x, y, z + k)
			data[vit] = c_juntree
			p2data[vit] = nodrot
		end
	elseif nodrot == 8 then
		for k = -4, 17 do
			if k == 11 or k == 12 or k == 16 or k == 17 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z - k)
					if math.random(4) ~= 2 then
						data[vil] = c_junleaf
						p2data[vil] = nodrot
					end
				end
				end
			end
			local vit = area:index(x, y, z - k)
			data[vit] = c_juntree
			p2data[vit] = nodrot
		end
	end
end


function flexrealm_grass(x, y, z, nodrot, area, data, p2data)
	local c_grass1 = minetest.get_content_id("default:grass_1")
	local c_grass2 = minetest.get_content_id("default:grass_2")
	local c_grass3 = minetest.get_content_id("default:grass_3")
	local c_grass4 = minetest.get_content_id("default:grass_4")
	local c_grass5 = minetest.get_content_id("default:grass_5")
	local via
	if nodrot == 12 then
		via = area:index(x + 1, y, z)
	elseif nodrot == 16 then
		via = area:index(x - 1 , y, z)
	elseif nodrot == 0 then	
		via = area:index(x, y + 1, z)
	elseif nodrot == 20 then
		via = area:index(x, y - 1, z)
	elseif nodrot == 4 then
		via = area:index(x, y, z + 1)
	elseif nodrot == 8 then
		via = area:index(x, y, z - 1)
	end
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


function flexrealm_dryshrub(x, y, z, nodrot, area, data, p2data)
	local c_dryshrub = minetest.get_content_id("default:dry_shrub")
	local via
	if nodrot == 12 then
		via = area:index(x + 1, y, z)
	elseif nodrot == 16 then
		via = area:index(x - 1, y, z)
	elseif nodrot == 0 then	
		via = area:index(x , y + 1, z)
	elseif nodrot == 20 then
		via = area:index(x , y - 1, z)
	elseif nodrot == 4 then
		via = area:index(x , y , z + 1)
	elseif nodrot == 8 then
		via = area:index(x , y , z - 1)
	end
	data[via] = c_dryshrub
end


function flexrealm_jungrass(x, y, z, nodrot, area, data, p2data)
	local c_jungrass = minetest.get_content_id("default:junglegrass")
	local via
	if nodrot == 12 then
		via = area:index(x + 1, y, z)
	elseif nodrot == 16 then
		via = area:index(x - 1, y, z)
	elseif nodrot == 0 then	
		via = area:index(x , y + 1, z)
	elseif nodrot == 20 then
		via = area:index(x , y - 1, z)
	elseif nodrot == 4 then
		via = area:index(x , y , z + 1)
	elseif nodrot == 8 then
		via = area:index(x , y , z - 1)
	end
	data[via] = c_jungrass
end


function flexrealm_papyrus(x, y, z, nodrot, area, data, p2data)
	local c_papyrus = minetest.get_content_id("default:papyrus")
	local ph = math.random(2, 5)
	if nodrot == 12 then
		for i = 1, ph do
			local vip = area:index(x + i, y, z)
			data[vip] = c_papyrus
		end
	elseif nodrot == 16 then
		for i = 1, ph do
			local vip = area:index(x - i, y, z)
			data[vip] = c_papyrus
		end
	elseif nodrot == 0 then
		for j = 1, ph do
			local vip = area:index(x, y + j, z)
			data[vip] = c_papyrus
		end
	elseif nodrot == 20 then
		for j = 1, ph do
			local vip = area:index(x, y - j, z)
			data[vip] = c_papyrus
		end
	elseif nodrot == 4 then
		for k = 1, ph do
			local vip = area:index(x, y, z + k)
			data[vip] = c_papyrus
		end
	elseif nodrot == 8 then
		for k = 1, ph do
			local vip = area:index(x, y, z - k)
			data[vip] = c_papyrus
		end
	end
end


function flexrealm_flower(x, y, z, nodrot, area, data, p2data)
	local c_danwhi = minetest.get_content_id("flowers:dandelion_white")
	local c_danyel = minetest.get_content_id("flowers:dandelion_yellow")
	local c_rose = minetest.get_content_id("flowers:rose")
	local c_tulip = minetest.get_content_id("flowers:tulip")
	local c_geranium = minetest.get_content_id("flowers:geranium")
	local c_viola = minetest.get_content_id("flowers:viola")
	local via
	if nodrot == 12 then
		via = area:index(x + 1, y, z)
	elseif nodrot == 16 then
		via = area:index(x - 1, y, z)
	elseif nodrot == 0 then	
		via = area:index(x , y + 1, z)
	elseif nodrot == 20 then
		via = area:index(x , y - 1, z)
	elseif nodrot == 4 then
		via = area:index(x , y , z + 1)
	elseif nodrot == 8 then
		via = area:index(x , y , z - 1)
	end
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


function flexrealm_cactus(x, y, z, nodrot, area, data, p2data)
	local c_cactus = minetest.get_content_id("flexrealm:cactus")
	if nodrot == 12 then
		for i = -1, 5 do
		for j = -2, 2 do
			if j == 0 or i == 3 or (i == 4 and math.abs(j) == 2) then
				local vic = area:index(x + i, y + j, z)
				data[vic] = c_cactus
				p2data[vic] = nodrot
			end
		end
		end
	elseif nodrot == 16 then
		for i = -1, 5 do
		for j = -2, 2 do
			if j == 0 or i == 3 or (i == 4 and math.abs(j) == 2) then
				local vic = area:index(x - i, y + j, z)
				data[vic] = c_cactus
				p2data[vic] = nodrot
			end
		end
		end
	elseif nodrot == 0 then
		for j = -1, 5 do
		for i = -2, 2 do
			if i == 0 or j == 3 or (j == 4 and math.abs(i) == 2) then
				local vic = area:index(x + i, y + j, z)
				data[vic] = c_cactus
				p2data[vic] = nodrot
			end
		end
		end
	elseif nodrot == 20 then
		for j = -1, 5 do
		for i = -2, 2 do
			if i == 0 or j == 3 or (j == 4 and math.abs(i) == 2) then
				local vic = area:index(x + i, y - j, z)
				data[vic] = c_cactus
				p2data[vic] = nodrot
			end
		end
		end
	elseif nodrot == 4 then
		for k = -1, 5 do
		for i = -2, 2 do
			if i == 0 or k == 3 or (k == 4 and math.abs(i) == 2) then
				local vic = area:index(x + i, y, z + k)
				data[vic] = c_cactus
				p2data[vic] = nodrot
			end
		end
		end
	elseif nodrot == 8 then
		for k = -1, 5 do
		for i = -2, 2 do
			if i == 0 or k == 3 or (k == 4 and math.abs(i) == 2) then
				local vic = area:index(x + i, y, z - k)
				data[vic] = c_cactus
				p2data[vic] = nodrot
			end
		end
		end
	end
end
