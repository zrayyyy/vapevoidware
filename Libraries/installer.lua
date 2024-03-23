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
    print("step 1 done")
end)

repeat task.wait() until profilesfetched

task.spawn(function()
    for i,v in next, guiprofiles do 
        local res = game:HttpGet('https://raw.githubusercontent.com/Erchobg/vapevoidware/main/Profiles/'..v)
        task.wait()
        if res ~= '404: Not Found' then 
            writevapefile('Profiles/'..v, res) 
        end
    end
end)

return shared.profilesinstalled == true