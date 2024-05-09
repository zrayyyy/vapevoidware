local function vapeGithubRequest(scripturl)
	if not isfile("vape/"..scripturl) then
		local suc, res = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/Erchobg/vapevoidware/"..readfile("vape/commithash.txt").."/"..scripturl, true) end)
		if not suc or res == "404: Not Found" then return nil end
		if scripturl:find(".lua") then res = "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..res end
		writefile("vape/"..scripturl, res)
	end
	return readfile("vape/"..scripturl)
end

local GuiLibrary = shared.GuiLibrary

local function customload(data, file)
	local success, err = pcall(function()
		loadstring(data)()
	end)
	if not success then
		GuiLibrary.SaveSettings = function() end
		task.spawn(error, "Vape - Failed to load "..file..".lua | "..err)
		pcall(function()
			local notification = GuiLibrary.CreateNotification("Failure loading "..file..".lua", err, 25, "assets/WarningNotification.png")
			notification.IconLabel.ImageColor3 = Color3.new(220, 0, 0)
			notification.Frame.Frame.ImageColor3 = Color3.new(220, 0, 0)
	    end)
	end
end

shared.CustomSaveVape = 6872274481
if isfile("vape/CustomModules/6872274481.lua") then
	customload(vapeGithubRequest("CustomModules/6872274481.lua"), "6872274481")
	--[[local suc, err = pcall(function() 
		loadstring(readfile("vape/CustomModules/6872274481.lua"))()
	end)
	if err then
		print(err)
	end--]]
else
	local publicrepo = vapeGithubRequest("CustomModules/6872274481.lua")
	if publicrepo then
		loadstring(publicrepo)()
	end
end