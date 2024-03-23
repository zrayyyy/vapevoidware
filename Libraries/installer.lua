local httpservice = game:GetService('HttpService')
local guiprofiles = {}
local profilesfetched = false
local profilesdownloaded = false
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
task.spawn(function()
    local res = game:HttpGet('https://api.github.com/repos/Erchobg/vapevoidware/contents/Profiles')
    if res ~= '404: Not Found' then 
        for i,v in next, httpservice:JSONDecode(res) do 
            if type(v) == 'table' and v.name then 
                table.insert(guiprofiles, v.name) 
            end
        end
    end
    profilesfetched = true
    print("step 1 done")
end)

repeat task.wait() until profilesfetched == true

task.spawn(function()
    print("step 2 done")
    for i,v in pairs(guiprofiles) do 
        print("step 3 done")
        local res = game:HttpGet('https://raw.githubusercontent.com/Erchobg/vapevoidware/main/Profiles/'..v)
        task.wait()
        if res ~= '404: Not Found' then 
            print("error detected")
            if not isfolder('vape/Profiles') then 
                makefolder("vape/Profiles")
            end
            writefile('vape/Profiles/'..v, res) 
        end
    end
    profilesdownloaded = true
    print("final step done")
end)

repeat task.wait() until profilesdownloaded == true
print("hmmm")

writefile('vape/Libraries/profilesinstalled.ren', 'yes')

return print("testing")

--return loadstring(vapeGithubRequest("MainScript.lua"))()