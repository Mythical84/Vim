function loadFiles(dir)
	for folder in io.popen('ls -pa '..dir..' | grep /'):lines() do
		if (folder ~= './' and folder ~= '../') then
			loadFiles(folder)
		end
	end

	for file in io.popen('ls -pa '..dir..' | grep -v /'):lines() do
		if (file == 'pluginConfig.lua') then goto continue end
		if (dir == '/home/tyler/.config/nvim/lua') then
			require(file:sub(0, file:len()-4))
		else
			print(dir.sub(dir:gsub('/','.'), 31)..'.'..file)
		end
		::continue::
	end
end

loadFiles('/home/tyler/.config/nvim/lua')
