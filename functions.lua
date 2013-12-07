function flexrealm_appletree(x, y, z, ni, nvals4, area, data, c_tree, c_leaves, c_apple)
	local treedir = 6
	local nxp = nvals4[ni + 1] -- x positive, direction 1
	local nxn = nvals4[ni - 1] -- x negative, 2
	local nyp = nvals4[ni + 80] -- 3
	local nyn = nvals4[ni - 80] -- 4
	local nzp = nvals4[ni + 6400] -- 5
	local nzn = nvals4[ni - 6400] -- 6
	local nlo = nzn
	if nxp < nlo then
		treedir = 1
		nlo = nxp
	end
	if nxn < nlo then
		treedir = 2
		nlo = nxn
	end
	if nyp < nlo then
		treedir = 3
		nlo = nyp
	end
	if nyn < nlo then
		treedir = 4
		nlo = nyn
	end
	if nzp < nlo then
		treedir = 5
		nlo = nzp
	end
	if nzn < nlo then
		treedir = 6
	end
	--treedir = 3 -- y+ for testing
	if treedir == 1 then
		for i = 0, 5 do
			if i >= 3 and i <= 5 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i + 1, y + j, z + k)
					if math.random(24) == 2 then
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
		for i = 0, 5 do
			if i >= 3 and i <= 5 then
				for j = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x - i - 1, y + j, z + k)
					if math.random(24) == 2 then
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
		for j = 0, 5 do
			if j >= 3 and j <= 5 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y + j + 1, z + k)
					if math.random(24) == 2 then
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
		for j = 0, 5 do
			if j >= 3 and j <= 5 then
				for i = -2, 2 do
				for k = -2, 2 do
					local vil = area:index(x + i, y - j - 1, z + k)
					if math.random(24) == 2 then
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
		for k = 0, 5 do
			if k >= 3 and k <= 5 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z + k + 1)
					if math.random(24) == 2 then
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
		for k = 0, 5 do
			if k >= 3 and k <= 5 then
				for i = -2, 2 do
				for j = -2, 2 do
					local vil = area:index(x + i, y + j, z - k - 1)
					if math.random(24) == 2 then
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

function flexrealm_pinetree(x, y, z, ni, nvals4, area, data, c_tree, c_flrneedles, c_snowblock)
	local treedir = 6
	local nxp = nvals4[ni + 1] -- x positive, direction 1
	local nxn = nvals4[ni - 1] -- x negative, 2
	local nyp = nvals4[ni + 80] -- 3
	local nyn = nvals4[ni - 80] -- 4
	local nzp = nvals4[ni + 6400] -- 5
	local nzn = nvals4[ni - 6400] -- 6
	local nlo = nzn
	if nxp < nlo then
		treedir = 1
		nlo = nxp
	end
	if nxn < nlo then
		treedir = 2
		nlo = nxn
	end
	if nyp < nlo then
		treedir = 3
		nlo = nyp
	end
	if nyn < nlo then
		treedir = 4
		nlo = nyn
	end
	if nzp < nlo then
		treedir = 5
		nlo = nzp
	end
	if nzn < nlo then
		treedir = 6
	end
	--treedir = 3 -- y+ for testing
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