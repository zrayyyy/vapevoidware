local httpservice = game:GetService('HttpService')

local stepcount = 0
local steps = {}
local titles = {}

local function writevapefile(file, data)
    writefile('vape/'..file, data)
end

local function registerStep(name, func)
    table.insert(steps, func)
    table.insert(titles, name)
    stepcount = #steps
end

local guiprofiles = {}
local profilesfetched

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
end)

registerStep('Getting Profiles...', function()
    repeat task.wait() until profilesfetched
end)

repeat task.wait() until profilesfetched

for i,v in next, guiprofiles do 
    registerStep('Downloading vape/Profiles/'..v, function()
        --if not installprofile then  [Needs testing]
        --    return 
        --end
        local res = game:HttpGet('https://raw.githubusercontent.com/Erchobg/vapevoidware/main/Profiles/'..v)
        task.wait()
        if res ~= '404: Not Found' then 
            writevapefile('Profiles/'..v, res) 
        end
    end)
end
writefile('vape/Libraries/profilesinstalled.ren', 'yes')

return print("testing")

--return loadstring(vapeGithubRequest("MainScript.lua"))()