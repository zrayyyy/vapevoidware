local httpservice = game:GetService('HttpService')

local guiprofiles = {}
local profilesfetched
local downloadedprofiles = {}

local function vapeGithubRequest(scripturl)
	if not isfile('vape/'..scripturl) then
		local suc, res = pcall(function() return game:HttpGet('https://raw.githubusercontent.com/Erchobg/vapevoidware/'..readfile('vape/commithash.txt')..'/'..scripturl, true) end)
		assert(suc, res)
		assert(res ~= '404: Not Found', res)
		if scripturl:find('.lua') then res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n'..res end
		writefile('vape/'..scripturl, res)
	end
	return readfile('vape/'..scripturl)
end

local GuiLibrary = {
    MainGui = ""
}

local gui = Instance.new("ScreenGui")
	gui.Name = "idk"
	gui.DisplayOrder = 999
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	gui.OnTopOfCoreBlur = true
	gui.ResetOnSpawn = false
	gui.Parent = game:GetService("Players").LocalPlayer.PlayerGui
	GuiLibrary["MainGui"] = gui

local function downloadVapeProfile(path)
	if not isfile(path) then
		task.spawn(function()
			local textlabel = Instance.new('TextLabel')
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = 'Downloading '..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary.MainGui
			repeat task.wait() until isfile(path)
			textlabel:Destroy()
		end)
		local suc, req = pcall(function() return vapeGithubRequest(path:gsub('vape/Profiles', 'Profiles')) end)
        if suc and req then
		    writefile(path, req)
        else
            return ''
        end
	end
	return downloadedprofiles[path] 
end

task.spawn(function()
    local res = game:HttpGet('https://api.github.com/repos/Erchobg/vapevoidware/contents/Profiles')
    if res ~= '404: Not Found' then 
        for i,v in next, httpservice:JSONDecode(res) do 
            task.wait()
            if type(v) == 'table' and v.name then 
                table.insert(guiprofiles, v.name) 
            end
        end
    end
    profilesfetched = true
end)

repeat task.wait() until profilesfetched

for i, v in pairs(guiprofiles) do
    downloadVapeProfile('vape/Profiles/'..v)
end

writefile('vape/Libraries/profilesinstalled.ren', 'yes')

return print("testing")

--return loadstring(vapeGithubRequest("MainScript.lua"))()