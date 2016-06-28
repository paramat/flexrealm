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
