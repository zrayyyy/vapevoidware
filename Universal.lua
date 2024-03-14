local GuiLibrary = shared.GuiLibrary
local vapeonlineresponse = true
if shared == nil then
	getgenv().shared = {} 
end
--task.spawn(function()
--	task.wait(10)
--	if not vapeonlineresponse and not isfile("vape/Voidware/oldvape/Universal.lua") then 
--		GuiLibrary.CreateNotification("Voidware", "The Connection to Github is taking a while. If vape doesn't load within 15 seconds, please reinject.", 10)
--	end
--end)

repeat task.wait() until pcall(function() return game.HttpGet end)

if isfile("vape/Voidware/oldvape/Bedwars.lua") then
	local manualfileload = pcall(function() loadstring(readfile("vape/Voidware/oldvape/Universal.lua"))() end)
	if not manualfileload then 
		loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Universal.lua"))()
	end
else
	loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Universal.lua"))()
end
vapeonlineresponse = true
local vapeAssert = function(argument, title, text, duration, hault, moduledisable, module) 
	if not argument then
    local suc, res = pcall(function()
    local notification = GuiLibrary.CreateNotification(title or "Voidware", text or "Failed to call function.", duration or 20, "assets/WarningNotification.png")
    notification.IconLabel.ImageColor3 = Color3.new(220, 0, 0)
    notification.Frame.Frame.ImageColor3 = Color3.new(220, 0, 0)
    if moduledisable and (module and GuiLibrary.ObjectsThatCanBeSaved[module.."OptionsButton"].Api.Enabled) then GuiLibrary.ObjectsThatCanBeSaved[module.."OptionsButton"].Api.ToggleButton(false) end
    end)
    if hault then while true do task.wait() end end
end
end
local identifyexecutor = identifyexecutor or function() return "Unknown" end
local getconnections = getconnections or function() return {} end
local hookfunction = hookfunction or function() return "shit exploit" end
local httprequest = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	return {Body = tab.Method == "GET" and game:HttpGet(tab.Url, true) or "shit exploit", Headers = {["content-type"] = "application/json"}, StatusCode = 404}
end
local queueonteleport = syn and syn.queue_on_teleport or queue_on_teleport or function() return "shit exploit" end
local setclipboard = setclipboard or function(data) writefile("clipboard.txt", data) return "shit exploit" end
local delfolder = delfolder or function() end
local delfile = delfile or function(file) writefile(file, "") end
local antiguibypass = GuiLibrary.SelfDestruct
local httpService = game:GetService("HttpService")
local playersService = game:GetService("Players")
local textService = game:GetService("TextService")
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local lightingService = game:GetService("Lighting")
local textChatService = game:GetService("TextChatService")
local runService = game:GetService("RunService")
local replicatedStorageService = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer
local vapeConnections = {}
local vapeCachedAssets = {}
local vapeTargetInfo = shared.VapeTargetInfo
local vapeInjected = true
local VoidwareFunctions = {WhitelistLoaded = false, WhitelistRefreshEvent = Instance.new("BindableEvent")}
local VoidwareLibraries = {}
local inputService = game:GetService("UserInputService")
local platform = game:GetService("UserInputService"):GetPlatform()
local VoidwareWhitelistStore = {
	Hash = "voidwaremoment",
	BlacklistTable = {},
	Tab = {},
	Rank = "Standard",
	Priority = {
		DEFAULT = 0,
		STANDARD = 1,
		BETA = 1.5,
		INF = 2,
		OWNER = 3
	},
	RankChangeEvent = Instance.new("BindableEvent"),
	chatstrings = {
		voidwaremoment = "Voidware",
		voidwarelitemoment = "Voidware Lite"
	},
	LocalPlayer = {Rank = "STANDARD", Attackable = true, Priority = 1, TagText = "VOIDWARE USER", TagColor = "0000FF", TagHidden = true, HWID = "ABCDEFG", Accounts = {}, BlacklistedProducts = {}, UID = 0},
	Players = {}
}
local tags = {}
local VoidwareStore = {
	maindirectory = "vape/Voidware",
	VersionInfo = {
        MainVersion = "3.3",
        PatchVersion = "0",
        Nickname = "Universal Update V2",
		BuildType = "Stable",
		VersionID = "3.3"
    },
	FolderTable = {"vape/Voidware", "vape/Voidware/data"},
	SystemFiles = {"vape/NewMainScript.lua", "vape/MainScript.lua", "vape/GuiLibrary.lua", "vape/Universal.lua"},
	watermark = function(text) return ("[Voidware] "..text) end,
	Tweening = false,
	TimeLoaded = tick(),
	CurrentPing = 0,
	HumanoidDied = Instance.new("BindableEvent"),
	MobileInUse = (platform == Enum.Platform.Android or platform == Enum.Platform.IOS) and true or false,
	vapePrivateCommands = {},
	Enums = {},
	jumpTick = tick(),
	entityIDs = shared.VoidwareStore and type(shared.VoidwareStore.entityIDs) == "table" and shared.VoidwareStore.entityIDs or {fakeIDs = {}},
	oldchatTabs = {
		oldchanneltab = nil,
		oldchannelfunc = nil,
		oldchanneltabs = {}
	},
	AverageFPS = 60,
	FrameRate = 60,
	AliveTick = tick(),
	DeathFunction = nil,
	vapeupdateroutine = nil,
	entityTable = {},
	objectraycast = RaycastParams.new()
}
VoidwareStore.FolderTable = {"vape/Voidware", VoidwareStore.maindirectory, VoidwareStore.maindirectory.."/".."data"}
local VoidwareGlobe = {ConfigUsers = {}, BlatantModules = {}, Messages = {}, GameFinished = false, WhitelistChatSent = {}, HookedFunctions = {}, UpdateTargetInfo = function() end, targetInfo = {Target = {}}, clones = {}}
local VoidwareQueueStore = shared.VoidwareQueueStore and type(shared.VoidwareQueueStore) == "string" and httpService:JSONDecode(shared.VoidwareQueueStore) or {lastServers = {}}
VoidwareStore.objectraycast.FilterType = Enum.RaycastFilterType.Include
shared.VoidwareQueueStore = nil
task.spawn(function()
	repeat 
	if not shared.VoidwareStore or type(shared.VoidwareStore) ~= "table" then 
		shared.VoidwareStore = VoidwareGlobe
	end
	task.wait()
	until not vapeInjected
end)

if not shared.VoidwareStore or type(shared.VoidwareStore) ~= "table" then 
	shared.VoidwareStore = VoidwareGlobe
end

table.insert(vapeConnections, lplr.OnTeleport:Connect(function()
	if shared.VoidwareStore.ModuleType ~= "Universal" then 
		return 
	end
	if not shared.VoidwareQueueStore or type(shared.VoidwareQueueStore) ~= "table" then 
		shared.VoidwareQueueStore = VoidwareQueueStore
	end
	local queuestore = shared.VoidwareQueueStore
	local success, newqueuestore = pcall(function() return httpService:JSONEncode(queuestore) end)
	if success and newqueuestore then
		queueonteleport('shared.VoidwareQueueStore = "'..newqueuestore..'"')
	end
end))

shared.VoidwareStore.ModuleType = "Universal"
local VoidwareRank = VoidwareWhitelistStore.Rank
local VoidwarePriority = VoidwareWhitelistStore.Priority

local localInventory = {hotbar = {}, backpack = {}}
task.spawn(function()
	repeat task.wait() until shared.VapeFullyLoaded
	VoidwareStore.TimeLoaded = tick()
end)

for i,v in pairs(playersService:GetPlayers()) do 
	local GenerateGUID = false
	for i2, v2 in pairs(VoidwareStore.entityIDs) do 
		if v2 == v.UserId then
			GenerateGUID = true 
		end
	end 
	if not GenerateGUID then
		local generatedid = httpService:GenerateGUID(true)
		VoidwareStore.entityIDs[generatedid] = v.UserId
	end
end

local function isDescendantOfCharacter(object, npcblacklist)
	if not object then return false end 
	for i,v in pairs(playersService:GetPlayers()) do 
		if v.Character and object:IsDescendantOf(v.Character) then
			return true
		end
	end
	for i,v in pairs(VoidwareStore.entityTable) do
		if v.PrimaryPart and v.Parent and object:IsDescendantOf(v) and not npcblacklist then 
			return true
		end 
	end
	return false
end


task.spawn(function()
	repeat task.wait()
	   shared.VoidwareStore.entityIDs = VoidwareStore.entityIDs
	until (shared.VoidwareStore and shared.VoidwareStore.ModuleType ~= "Universal" or not vapeInjected)
end)

table.insert(vapeConnections, playersService.PlayerAdded:Connect(function(plr)
	local GenerateGUID = false
	for i2, v2 in pairs(VoidwareStore.entityIDs) do 
		if v2 == plr.UserId then
			GenerateGUID = true 
			break
		end
	end
	if not GenerateGUID then 
		local generatedid = httpService:GenerateGUID(true)
		VoidwareStore.entityIDs[generatedid] = plr.UserId
	end
end))

local function antikickbypass(data, watermark)
	local bypassed = true
	pcall(function() task.spawn(GuiLibrary.SelfDestruct) end)
	task.spawn(function() settings().Network.IncomingReplicationLag = math.huge end)
	task.spawn(function() 
		lplr:Kick(data or "Voidware has requested player disconnect.") 
		if watermark then
		pcall(function() game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ErrorPrompt.TitleFrame.ErrorTitle.Text = "Voidware Error" end)
		end
		bypassed = false 
	end)
	task.wait(0.2)
	pcall(function() bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer() end)
	task.wait(1.5)
	if bypassed then
	task.spawn(function() game:Shutdown() end)
	end
	task.wait(1.5)
	for i,v in pairs(lplr.PlayerGui:GetChildren()) do 
		v.Parent = game:GetService("CoreGui")
	end
	task.spawn(function() lplr:Destroy() end) 
	task.wait(1.5)
	if lplr then 
	repeat print() until false
	end
end

local function isEnabled(toggle)
	if not toggle then return false end
	toggle = GuiLibrary.ObjectsThatCanBeSaved[toggle.."OptionsButton"] and GuiLibrary.ObjectsThatCanBeSaved[toggle.."OptionsButton"].Api
	return toggle and toggle.Enabled or false
end

table.insert(vapeConnections, lplr.OnTeleport:Connect(function()
	if not shared.VoidwareQueueStore or type(shared.VoidwareQueueStore) ~= "table" then 
		shared.VoidwareQueueStore = VoidwareQueueStore
	end
	local oldstore = shared.VoidwareQueueStore
	queueonteleport('shared.VoidwareQueueStore = '..oldstore)
end))

function VoidwareFunctions:GetLocalEntityID(player)
	for i,v in pairs(VoidwareStore.entityIDs) do 
		if v == player.UserId then 
			return i
		end
	end
	return nil
end

function VoidwareFunctions:CreateLocalTag(player, text, color)
	local plr = VoidwareFunctions:GetLocalEntityID(player or lplr)
	if plr then
		tags[plr] = {}
		tags[plr].Text = text
		tags[plr].Color = color 
		return tags[plr]
	end
	return nil
end

function VoidwareFunctions:GetLocalTag(player)
	local plr = VoidwareFunctions:GetLocalEntityID(player or lplr)
	if plr and tags[plr] then
		return {Text = tags[plr].Text ~= "" and "["..tags[plr].Text.."]" or "", Color = tags[plr].Color or "FFFFFF"}
	end
	return {Text = "", Color = "FFFFFF"}
end

function VoidwareFunctions:LoadTime()
	if shared.VapeFullyLoaded then
		return (tick() - VoidwareStore.TimeLoaded)
	else
		return 0
	end
end

function VoidwareFunctions:GetMainDirectory()
	for i,v in pairs({"vape", "vape/Voidware"}) do 
		if not isfolder(v) then 
			makefolder(v)
		end
	end
	if not isfolder(VoidwareStore.maindirectory) then 
		makefolder(VoidwareStore.maindirectory)
	end
	return VoidwareStore.maindirectory or "vape/Voidware"
end

local function betterhttpget(url)
	local supportedexploit, body = syn and syn.request or http_requst or request or fluxus and fluxus.request, ""
	if supportedexploit then
		local data = httprequest({Url = url, Method = "GET"})
		if data.Body then
			body = data.Body
		else
			return game:HttpGet(url, true)
		end
	else
		body = game:HttpGet(url, true)
	end
	return body
end

local isfile = isfile or function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end

function VoidwareFunctions:GetPlayerType(plr)
	if not VoidwareFunctions.WhitelistLoaded then return "DEFAULT", true, 0, "SPECIAL USER", "FFFFFF", true, 0, false, "ABCDEFGH" end
	plr = plr or lplr
	local tab = VoidwareWhitelistStore.Players[plr.UserId]
	if tab == nil then
		return "DEFAULT", true, 0, "SPECIAL USER", "FFFFFF", true, 0, false, "ABCDEFGH"
	else
		tab.Priority = VoidwarePriority[tab.Rank:upper()]
		return tab.Rank, tab.Attackable, tab.Priority, tab.TagText, tab.TagColor, tab.TagHidden, tab.UID, tab.HWID
	end
end

function VoidwareFunctions:GetCommitHash(repo)
	local commit, repo = "main", repo or "Voidware"
	local req, res = pcall(function() return game:HttpGet("https://github.com/Erchobg/"..repo) end)
	if not req or not res then return commit end
	for i,v in pairs(res:split("\n")) do 
	   if v:find("commit") and v:find("fragment") then 
		  local str = v:split("/")[5]
		  commit = str:sub(0, v:split("/")[5]:find('"') - 1)
		   break
	   end
   end
   return commit
end
function VoidwareFunctions:GetFile(file, online, path, silent)
	local repo = VoidwareStore.VersionInfo.BuildType == "Beta" and "VoidwareBeta" or "Voidware"
	local directory = VoidwareFunctions:GetMainDirectory()
	if not isfolder(directory) then makefolder(directory) end
	local existent = pcall(function() return readfile(path or directory.."/"..file) end)
	local voidwarever = "main"
	local str = string.split(file, "/") or {}
	local lastfolder = nil
	local foldersplit2
	if not existent and not online then
		if not silent then
		   task.spawn(GuiLibrary.CreateNotification, "Voidware", "Downloading "..directory.."/"..file, 1.5)
		end
		voidwarever = VoidwareFunctions:GetCommitHash(repo)
		local github, data = pcall(function() return betterhttpget("https://raw.githubusercontent.com/Erchobg/"..repo.."/"..voidwarever.."/"..file, true) end)
		if github and data ~= "404: Not Found" then
		VoidwareFunctions:GetMainDirectory()
		if #str > 0 and not path and data ~= "404: Not Found" then
		for i,v in pairs(str) do
			local foldersplit = lastfolder ~= nil and directory.."/"..lastfolder.."/" or ""
			foldersplit2 = string.gsub(foldersplit, directory.."/", "")
			local str2 = string.split(v, ".") or {}
			if #str2 == 1 then
				if not isfolder(directory..foldersplit2..v) then
					makefolder(directory.."/"..foldersplit2..v)
				end
				lastfolder = v and foldersplit2..v or lastfolder
			end
		end
	end
			data = file:find(".lua") and "-- Voidware Custom Vape Signed File\n"..data or data
			writefile(path or directory.."/"..file, data)
		else
			vapeAssert(false, "Voidware", "Failed to download "..directory.."/"..file.." | "..data, 60)
			return error("[Voidware] Failed to download "..directory.."/"..file.." | "..data)
		end
	end
	return online and betterhttpget("https://raw.githubusercontent.com/Erchobg/"..repo.."/"..voidwarever.."/"..file) or readfile(path or directory.."/"..file)
end

task.spawn(function()
	repeat 
	for i,v in pairs({"base64", "Hex2Color3"}) do 
		task.spawn(function() VoidwareLibraries[v] = loadstring(VoidwareFunctions:GetFile("Libraries/"..v..".lua"))() end)
	end
	task.wait(5)
	until not vapeInjected
end)

function VoidwareFunctions:RunFromLibrary(tablename, func, argstable)
	if VoidwareLibraries[tablename] == nil then repeat task.wait() until VoidwareLibraries[tablename] and type(VoidwareLibraries[tablename]) == "table" end 
	return VoidwareLibraries[tablename][func](argstable and type(argstable) == "table" and table.unpack(argstable) or argstable or nil)
end

VoidwareStore.vapeupdateroutine = coroutine.create(function()
	repeat
	if not vapeInjected then break end
	local success, response = pcall(function()
	local vaperepoinfo = betterhttpget("https://github.com/7GrandDadPGN/VapeV4ForRoblox")
	for i,v in pairs(vaperepoinfo:split("\n")) do 
	    if v:find("commit") and v:find("fragment") then 
	    local str = v:split("/")[5]
	    return str:sub(0, v:split("/")[5]:find('"') - 1)
	    end
	end
end)
if (isfile("vape/commithash.txt") and readfile("vape/commithash.txt") ~= response or not isfile("vape/commithash.txt") or not isfile("vape/Voidware/oldvape/Universal.lua")) then
		if VoidwareFunctions:GetPlayerType() == "OWNER" and success then 
			if response ~= "main" then 
				if not isfolder("vape") then makefolder("vape") end
				pcall(writefile, "vape/commithash.txt", response)
			end
			local newvape = betterhttpget("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..response.."/Universal.lua")
			if newvape ~= "404: Not Found" then 
			VoidwareFunctions:GetMainDirectory()
			if not isfolder("vape/Voidware/oldvape") then makefolder("vape/Voidware/oldvape") end
			pcall(writefile, "vape/Voidware/oldvape/Universal.lua", newvape)
			end
		end
	end
	task.wait(5)
 until not vapeInjected
end)

pcall(coroutine.resume, VoidwareStore.vapeupdateroutine)

task.spawn(function()
	local lastrank = VoidwareWhitelistStore.Rank:upper()
	repeat
	VoidwareRank = VoidwareWhitelistStore.Rank:upper()
	if VoidwareRank ~= lastrank then
		VoidwareWhitelistStore.RankChangeEvent:Fire(VoidwareRank)
		lastrank = VoidwareRank
	end
	task.wait()
	until not vapeInjected
end)


function VoidwareFunctions:SpecialInGame()
	local specialtable = {}
	for i,v in pairs(playersService:GetPlayers()) do
		if v ~= lplr and ({VoidwareFunctions:GetPlayerType(v)})[3] > 1.5 then
			table.insert(specialtable, v)
		end
	end
	return #specialtable > 0 and specialtable
end

function VoidwareFunctions:GetClientUsers()
	local users = {}
	for i,v in pairs(playersService:GetPlayers()) do
		if v ~= lplr and table.find(shared.VoidwareStore.ConfigUsers, v) then
			table.insert(users, plr)
		end
	end
	return users
end

function VoidwareFunctions:RefreshWhitelist()
	local commit, hwidstring = VoidwareFunctions:GetCommitHash("whitelist"), string.split(HWID, "-")[5]
	local suc, whitelist = pcall(function() return httpService:JSONDecode(betterhttpget("https://raw.githubusercontent.com/Erchobg/whitelist/"..commit.."/maintab.json")) end)
	local attributelist = {"Rank", "Attackable", "TagText", "TagColor", "TagHidden", "UID"}
	local defaultattributelist = {Rank = "DEFAULT", Attackable = true, Priority = 1, TagText = "VOIDWARE USER", TagColor = "FFFFFF", TagHidden = true, UID = 0, HWID = "ABCDEFGH"}
	if suc and whitelist then
		for i,v in pairs(whitelist) do
			if i == hwidstring and not table.find(v.BlacklistedProducts, VoidwareWhitelistStore.Hash) then 
				VoidwareWhitelistStore.Rank = v.Rank:upper()
				VoidwareWhitelistStore.Tab = v
				VoidwareWhitelistStore.Players[lplr.UserId] = v
				VoidwareWhitelistStore.LocalPlayer = v
				VoidwareWhitelistStore.LocalPlayer.HWID = i
				VoidwareWhitelistStore.Players[lplr.UserId].HWID = i
				VoidwareWhitelistStore.Players[lplr.UserId].Priority = VoidwareRank[v.Rank:upper()]
			end
			for i2, v2 in pairs(playersService:GetPlayers()) do
				if VoidwareWhitelistStore.Players[v2.UserId] == nil then
				   VoidwareWhitelistStore.Players[v2.UserId] = defaultattributelist
			        if table.find(v.Accounts, tostring(v2.UserId)) and not table.find(v.BlacklistedProducts, VoidwareWhitelistStore.Hash) then
					 VoidwareWhitelistStore.Players[v2.UserId] = v
					if VoidwarePriority[VoidwareWhitelistStore.Rank:upper()] >= VoidwarePriority[v.Rank] then
					 VoidwareWhitelistStore.Players[v2.UserId].Attackable = true
					end
			       end
			   end
		    end
		end
		table.insert(vapeConnections, playersService.PlayerAdded:Connect(function(v2)
			for i,v in pairs(whitelist) do
				if VoidwareWhitelistStore.Players[v2.UserId] == nil then
					VoidwareWhitelistStore.Players[v2.UserId] = defaultattributelist
					 if table.find(v.Accounts, tostring(v2.UserId)) and not table.find(v.BlacklistedProducts, VoidwareWhitelistStore.Hash) then
					 VoidwareWhitelistStore.Players[v2.UserId] = v
					 if VoidwarePriority[VoidwareWhitelistStore.Rank:upper()] >= VoidwarePriority[v.Rank] then
						VoidwareWhitelistStore.Players[v2.UserId].Attackable = true
					end
					  VoidwareWhitelistStore.HWID = i
					end
				end
			end
		end))
		table.insert(vapeConnections, playersService.PlayerRemoving:Connect(function(v2)
			if VoidwareWhitelistStore.Players[v2.UserId] ~= nil then
				VoidwareWhitelistStore.Players[v2.UserId] = nil
			end
		end))
	end
	return suc, whitelist
end

task.spawn(function()
	local response = false
	local whitelistloaded, err
	task.spawn(function()
		whitelistloaded, err = VoidwareFunctions:RefreshWhitelist()
		response = true
	end)
	task.delay(15, function() if not response then whitelistloaded, err = VoidwareFunctions:RefreshWhitelist() response = true end end)
	repeat task.wait() until response
	if not whitelistloaded then
		task.spawn(error, "[Voidware] Failed to load whitelist functions: "..err)
	end
	task.wait(0.3)
	VoidwareFunctions.WhitelistLoaded = true
end)

task.spawn(function()
	repeat
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
	if ({VoidwareFunctions:GetPlayerType()})[3] < 1.5 and VoidwareStore.VersionInfo.BuildType == "Beta" then
		antikickbypass("This build of Voidware is currently restricted for you", true)
	end
	if ({VoidwareFunctions:GetPlayerType()})[3] < 1.5 and VoidwareStore.VersionInfo.BuildType ~= "Beta" then
		pcall(delfolder, VoidwareFunctions:GetMainDirectory().."/beta")
	end
until not vapeInjected
end)

task.spawn(function()
	local blacklist = false
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
	pcall(function()
	repeat
	if shared.VoidwareStore.ModuleType ~= "Universal" then return end
	local suc, tab = pcall(function() return httpService:JSONDecode(betterhttpget("raw.githubusercontent.com/Erchobg/whitelist/"..VoidwareFunctions:GetCommitHash("whitelist").."/blacklist.json")) end)
	if suc then
		blacklist = false
		for i,v in pairs(tab) do
			if HWID:find(i) or i == tostring(lplr.UserId) or lplr.Name:find(i) then
				blacklist = true
				if v.Priority and v.Priority > 1 then
				   antikickbypass(v.Error, true)
				else
					if not isfile(VoidwareStore.maindirectory.."/kickdata.vw") or readfile(VoidwareStore.maindirectory.."/kickdata.vw") ~= tostring(v.ID) then
						if not isfolder("vape") then makefolder("vape") end
						if not isfolder("vape/Voidware") then makefolder("vape/Voidware") end
						if not isfolder(VoidwareStore.maindirectory) then makefolder(VoidwareStore.maindirectory) end
						pcall(writefile, VoidwareStore.maindirectory.."/kickdata.vw", tostring(v.ID))
						antikickbypass(v.Error, true)
					end
				end
			end
		end
		if not blacklist then
			pcall(delfile, VoidwareStore.maindirectory.."/kickdata.vw")
		end
	end
	task.wait(10)
	until not vapeInjected
end)
end)

local function GetCurrentProfile()
	local profile = "default"
	if isfile("vape/Profiles/6872274481.vapeprofiles.txt") then
		pcall(function()
		local profiledata = readfile("vape/Profiles/6872274481.vapeprofiles.txt")
		local data = httpService:JSONDecode(profiledata)
		for i,v in pairs(data) do
			if v.Selected == true then
				profile = i
			end
		end
	end)
	end
	return profile
end

if GetCurrentProfile() == "Ghost" then
	VoidwareWhitelistStore.Hash = "voidwarelitemoment"
end

local function sendchatmessage(message) 
	message = message or ""
	if textChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		textChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(message)
	else
		replicatedStorageService.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
	end
end

local function sendprivatemessage(player, message)
	message = message or ""
	if player then
		if textChatService.ChatVersion == Enum.ChatVersion.TextChatService then
			local oldchannel = textChatService.ChatInputBarConfiguration.TargetTextChannel
			local whisperchannel = game:GetService("RobloxReplicatedStorage").ExperienceChat.WhisperChat:InvokeServer(player.UserId)
			if whisperchannel then
				whisperchannel:SendAsync(VoidwareWhitelistStore.Hash)
				textChatService.ChatInputBarConfiguration.TargetTextChannel = oldchannel
			end
		else
			replicatedStorageService.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w "..player.Name.." "..message, "All")
		end
	end
end

local function voidwareNewPlayer(plr)
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
	plr = plr or lplr
	if ({VoidwareFunctions:GetPlayerType(plr)})[3] > 1.5 and not ({VoidwareFunctions:GetPlayerType(plr)})[6] then
		local tagtext, tagcolor = ({VoidwareFunctions:GetPlayerType(plr)})[4], ({VoidwareFunctions:GetPlayerType(plr)})[5]
		VoidwareFunctions:CreateLocalTag(plr, tagtext, tagcolor)
	end
	if plr ~= lplr and ({VoidwareFunctions:GetPlayerType()})[3] < 2 and ({VoidwareFunctions:GetPlayerType(plr)})[3] > 1.5 then
		task.wait(5)
		sendprivatemessage(plr, VoidwareWhitelistStore.Hash)
	end
end

task.spawn(function()
	local oldwhitelists = {}
	for i,v in pairs(playersService:GetPlayers()) do
		task.spawn(voidwareNewPlayer, v)
		oldwhitelists[v] = VoidwarePriority[({VoidwareFunctions:GetPlayerType(v)})[3]]
	end
	
	table.insert(vapeConnections, playersService.PlayerAdded:Connect(function(v)
		oldwhitelists[v] = VoidwarePriority[({VoidwareFunctions:GetPlayerType(v)})[3]]
		task.spawn(voidwareNewPlayer, v)
	end))
	
	table.insert(vapeConnections, VoidwareFunctions.WhitelistRefreshEvent.Event:Connect(function()
	for i,v in pairs(playersService:GetPlayers()) do
		if ({VoidwareFunctions:GetPlayerType(v)}) ~= oldwhitelists[v] then
		task.spawn(voidwareNewPlayer, v)
		end
	end
	end))
end)

for i,v in pairs(playersService:GetPlayers()) do
	task.spawn(voidwareNewPlayer, v)
end

table.insert(vapeConnections, playersService.PlayerAdded:Connect(function(v)
	task.spawn(voidwareNewPlayer, v)
end))

table.insert(vapeConnections, playersService.PlayerRemoving:Connect(function(v)
	if table.find(shared.VoidwareStore.ConfigUsers, v) then
		table.remove(shared.VoidwareStore.ConfigUsers, v)
	end
end))


table.insert(vapeConnections, workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	gameCamera = workspace.CurrentCamera or workspace:FindFirstChildWhichIsA("Camera")
end))

local networkownerswitch = tick()
local isnetworkowner = isnetworkowner or function(part)
	local suc, res = pcall(function() return gethiddenproperty(part, "NetworkOwnershipRule") end)
	if suc and res == Enum.NetworkOwnership.Manual then 
		sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
		networkownerswitch = tick() + 8
	end
	return networkownerswitch <= tick()
end
local vapeAssetTable = {["vape/assets/VapeCape.png"] = "rbxassetid://13380453812", ["vape/assets/ArrowIndicator.png"] = "rbxassetid://13350766521"}
local getcustomasset = getsynasset or getcustomasset or function(location) return vapeAssetTable[location] or "" end
local synapsev3 = syn and syn.toast_notification and "V3" or ""
local worldtoscreenpoint = function(pos)
	if synapsev3 == "V3" then 
		local scr = worldtoscreen({pos})
		return scr[1] - Vector3.new(0, 36, 0), scr[1].Z > 0
	end
	return gameCamera.WorldToScreenPoint(gameCamera, pos)
end
local worldtoviewportpoint = function(pos)
	if synapsev3 == "V3" then 
		local scr = worldtoscreen({pos})
		return scr[1], scr[1].Z > 0
	end
	return gameCamera.WorldToViewportPoint(gameCamera, pos)
end

local function vapeGithubRequest(scripturl)
	if not isfile("vape/"..scripturl) then
		local suc, res = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..readfile("vape/commithash.txt").."/"..scripturl, true) end)
		assert(suc, res)
		assert(res ~= "404: Not Found", res)
		if scripturl:find(".lua") then res = "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..res end
		writefile("vape/"..scripturl, res)
	end
	return readfile("vape/"..scripturl)
end

local function downloadVapeAsset(path)
	if not isfile(path) then
		task.spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
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
		local suc, req = pcall(function() return vapeGithubRequest(path:gsub("vape/assets", "assets")) end)
        if suc and req then
		    writefile(path, req)
        else
            return ""
        end
	end
	if not vapeCachedAssets[path] then vapeCachedAssets[path] = getcustomasset(path) end
	return vapeCachedAssets[path] 
end

local function warningNotification(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary.CreateNotification(title or "Voidware", text or "Successfully called function", delay or 7, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Value)
		frame.Frame.Frame.ImageColor3 = Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Value)
		return frame
	end)
	return (suc and res)
end

local function InfoNotification(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary.CreateNotification(title or "Voidware", text or "Successfully called function", delay or 7, "assets/InfoNotification.png")
		return frame
	end)
	return (suc and res)
end

local function CustomNotification(title, delay, text, icon, color)
	local suc, res = pcall(function()
		local frame = GuiLibrary.CreateNotification(title or "Voidware", text or "Thanks you for using Voidware "..lplr.Name.."!", delay or 5.6, icon or "assets/InfoNotification.png")
		frame.Frame.Frame.ImageColor3 = color and Hex2Color3(color) or Color3.new()
		return frame
	end)
	return (suc and res)
end

local announcements = {}
function VoidwareFunctions:Announcement(tab)
	tab = tab or {}
	tab.Text = tab.Text or ""
	tab.Duration = tab.Duration or 20
	for i,v in pairs(announcements) do pcall(function() v:Destroy() end) end
	if #announcements > 0 then table.clear(announcements) end
	local announcemainframe = Instance.new("Frame")
	announcemainframe.Position = UDim2.new(0.2, 0, -5, 0.1)
	announcemainframe.Size = UDim2.new(0, 1227, 0, 62)
	announcemainframe.Parent = GuiLibrary.MainGui
	local announcemaincorner = Instance.new("UICorner")
	announcemaincorner.CornerRadius = UDim.new(0, 20)
	announcemaincorner.Parent = announcemainframe
	local announceuigradient = Instance.new("UIGradient")
	announceuigradient.Parent = announcemainframe
	announceuigradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 0, 0)), ColorSequenceKeypoint.new(0.4, Color3.fromRGB(135, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 0)),})
	announceuigradient.Enabled = true
	local announceiconframe = Instance.new("Frame")
	announceiconframe.BackgroundColor3 = Color3.fromRGB(106, 0, 0)
	announceiconframe.BorderColor3 = Color3.fromRGB(85, 0, 0)
	announceiconframe.Position = UDim2.new(0.007, 0, 0.097, 0)
	announceiconframe.Size = UDim2.new(0, 58, 0, 50)
	announceiconframe.Parent = announcemainframe
	local annouceiconcorner = Instance.new("UICorner")
	annouceiconcorner.CornerRadius = UDim.new(0, 20)
	annouceiconcorner.Parent = announceiconframe
	local announcevoidwareicon = Instance.new("ImageButton")
	announcevoidwareicon.Parent = announceiconframe
	announcevoidwareicon.Image = "rbxassetid://13391474085"
	announcevoidwareicon.Position = UDim2.new(-0, 0, 0, 0)
	announcevoidwareicon.Size = UDim2.new(0, 59, 0, 50)
	announcevoidwareicon.BackgroundTransparency = 1
	local announcetextfont = Font.new("rbxasset://fonts/families/Ubuntu.json")
	announcetextfont.Weight = Enum.FontWeight.Bold
	local announcemaintext = Instance.new("TextButton")
	announcemaintext.Text = tab.Text
	announcemaintext.FontFace = announcetextfont
	announcemaintext.TextXAlignment = Enum.TextXAlignment.Left
	announcemaintext.BackgroundTransparency = 1
	announcemaintext.TextSize = 30
	announcemaintext.AutoButtonColor = false
	announcemaintext.Position = UDim2.new(0.063, 0, 0.097, 0)
	announcemaintext.Size = UDim2.new(0, 1140, 0, 50)
	announcemaintext.RichText = true
	announcemaintext.TextColor3 = Color3.fromRGB(255, 255, 255)
	announcemaintext.Parent = announcemainframe
	tweenService:Create(announcemainframe, TweenInfo.new(1), {Position = UDim2.new(0.2, 0, 0.042, 0.1)}):Play()
	local sound = Instance.new("Sound")
	sound.PlayOnRemove = true
	sound.SoundId = "rbxassetid://6732495464"
	sound.Parent = announcemainframe
	sound:Destroy()
	local function announcementdestroy()
		local sound = Instance.new("Sound")
		sound.PlayOnRemove = true
		sound.SoundId = "rbxassetid://6732690176"
		sound.Parent = announcemainframe
		sound:Destroy()
		announcemainframe:Destroy()
	end
	announcemaintext.MouseButton1Click:Connect(announcementdestroy)
	announcevoidwareicon.MouseButton1Click:Connect(announcementdestroy)
	game:GetService("Debris"):AddItem(announcemainframe, tab.Duration)
	table.insert(announcements, announcemainframe)
	return announcemainframe
end


local function runFunction(func) func() end
local function runcode(func) func() end

local function isFriend(plr, recolor)
	if GuiLibrary.ObjectsThatCanBeSaved["Use FriendsToggle"].Api.Enabled then
		local friend = table.find(GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.ObjectList, plr.Name)
		friend = friend and GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.ObjectListEnabled[friend]
		if recolor then
			friend = friend and GuiLibrary.ObjectsThatCanBeSaved["Recolor visualsToggle"].Api.Enabled
		end
		return friend
	end
	return nil
end

local function isTarget(plr)
	local friend = table.find(GuiLibrary.ObjectsThatCanBeSaved.TargetsListTextCircleList.Api.ObjectList, plr.Name)
	friend = friend and GuiLibrary.ObjectsThatCanBeSaved.TargetsListTextCircleList.Api.ObjectListEnabled[friend]
	return friend
end

local function isVulnerable(plr)
	return plr.Humanoid.Health > 0 and not plr.Character.FindFirstChildWhichIsA(plr.Character, "ForceField")
end

local function getPlayerColor(plr)
	if isFriend(plr, true) then
		return Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Friends ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Friends ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Friends ColorSliderColor"].Api.Value)
	end
	return tostring(plr.TeamColor) ~= "White" and plr.TeamColor.Color
end

local entityLibrary = loadstring(vapeGithubRequest("Libraries/entityHandler.lua"))()
shared.vapeentity = entityLibrary
do
	entityLibrary.selfDestruct()
	table.insert(vapeConnections, GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.FriendRefresh.Event:Connect(function()
		entityLibrary.fullEntityRefresh()
	end))
	table.insert(vapeConnections, GuiLibrary.ObjectsThatCanBeSaved["Teams by colorToggle"].Api.Refresh.Event:Connect(function()
		entityLibrary.fullEntityRefresh()
	end))
	local oldUpdateBehavior = entityLibrary.getUpdateConnections
	entityLibrary.getUpdateConnections = function(newEntity)
		local oldUpdateConnections = oldUpdateBehavior(newEntity)
		table.insert(oldUpdateConnections, {Connect = function() 
			newEntity.Friend = isFriend(newEntity.Player) and true
			newEntity.Target = isTarget(newEntity.Player) and true
			return {Disconnect = function() end}
		end})
		return oldUpdateConnections
	end
	entityLibrary.isPlayerTargetable = function(plr)
		if isFriend(plr) then return false end
		if (not GuiLibrary.ObjectsThatCanBeSaved["Teams by colorToggle"].Api.Enabled) then return true end
		if (not lplr.Team) then return true end
		if (not plr.Team) then return true end
		if plr.Team ~= lplr.Team then return true end
        return #plr.Team:GetPlayers() == playersService.NumPlayers
	end
	entityLibrary.fullEntityRefresh()
	entityLibrary.LocalPosition = Vector3.zero

	task.spawn(function()
		local postable = {}
		repeat
			task.wait()
			if entityLibrary.isAlive then
				table.insert(postable, {Time = tick(), Position = entityLibrary.character.HumanoidRootPart.Position})
				if #postable > 100 then 
					table.remove(postable, 1)
				end
				local closestmag = 9e9
				local closestpos = entityLibrary.character.HumanoidRootPart.Position
				local currenttime = tick()
				for i, v in pairs(postable) do 
					local mag = 0.1 - (currenttime - v.Time)
					if mag < closestmag and mag > 0 then
						closestmag = mag
						closestpos = v.Position
					end
				end
				entityLibrary.LocalPosition = closestpos
			end
		until not vapeInjected
	end)
end

local function calculateMoveVector(cameraRelativeMoveVector)
	local c, s
	local _, _, _, R00, R01, R02, _, _, R12, _, _, R22 = gameCamera.CFrame:GetComponents()
	if R12 < 1 and R12 > -1 then
		c = R22
		s = R02
	else
		c = R00
		s = -R01*math.sign(R12)
	end
	local norm = math.sqrt(c*c + s*s)
	return Vector3.new(
		(c*cameraRelativeMoveVector.X + s*cameraRelativeMoveVector.Z)/norm,
		0,
		(c*cameraRelativeMoveVector.Z - s*cameraRelativeMoveVector.X)/norm
	)
end

local raycastWallProperties = RaycastParams.new()
local function raycastWallCheck(char, checktable)
	if not checktable.IgnoreObject then 
		checktable.IgnoreObject = raycastWallProperties
		local filter = {lplr.Character, gameCamera}
		for i,v in pairs(entityLibrary.entityList) do 
			if v.Targetable then 
				table.insert(filter, v.Character)
			end 
		end
		for i,v in pairs(checktable.IgnoreTable or {}) do 
			table.insert(filter, v)
		end
		raycastWallProperties.FilterDescendantsInstances = filter
	end
	local ray = workspace.Raycast(workspace, checktable.Origin, (char[checktable.AimPart].Position - checktable.Origin), checktable.IgnoreObject)
	return not ray
end

local function EntityNearPosition(distance, checktab)
	checktab = checktab or {}
	if entityLibrary.isAlive then
		local sortedentities = {}
		for i, v in pairs(entityLibrary.entityList) do -- loop through playersService
			if not v.Targetable then continue end
            if isVulnerable(v) then -- checks
				local playerPosition = v.RootPart.Position
				local mag = (entityLibrary.character.HumanoidRootPart.Position - playerPosition).magnitude
				if checktab.Prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - playerPosition).magnitude
				end
                if mag <= distance then -- mag check
					table.insert(sortedentities, {entity = v, Magnitude = v.Target and -1 or mag})
                end
            end
        end
		table.sort(sortedentities, function(a, b) return a.Magnitude < b.Magnitude end)
		for i, v in pairs(sortedentities) do 
			if checktab.WallCheck then
				if not raycastWallCheck(v.entity, checktab) then continue end
			end
			return v.entity
		end
	end
end

local function EntityNearMouse(distance, checktab)
	checktab = checktab or {}
    if entityLibrary.isAlive then
		local sortedentities = {}
		local mousepos = inputService.GetMouseLocation(inputService)
		for i, v in pairs(entityLibrary.entityList) do
			if not v.Targetable then continue end
            if isVulnerable(v) then
				local vec, vis = worldtoscreenpoint(v[checktab.AimPart].Position)
				local mag = (mousepos - Vector2.new(vec.X, vec.Y)).magnitude
                if vis and mag <= distance then
					table.insert(sortedentities, {entity = v, Magnitude = v.Target and -1 or mag})
                end
            end
        end
		table.sort(sortedentities, function(a, b) return a.Magnitude < b.Magnitude end)
		for i, v in pairs(sortedentities) do 
			if checktab.WallCheck then
				if not raycastWallCheck(v.entity, checktab) then continue end
			end
			return v.entity
		end
    end
end

local function AllNearPosition(distance, amount, checktab)
	local returnedplayer = {}
	local currentamount = 0
	checktab = checktab or {}
    if entityLibrary.isAlive then
		local sortedentities = {}
		for i, v in pairs(entityLibrary.entityList) do
			if not v.Targetable then continue end
            if isVulnerable(v) then
				local playerPosition = v.RootPart.Position
				local mag = (entityLibrary.character.HumanoidRootPart.Position - playerPosition).magnitude
				if checktab.Prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - playerPosition).magnitude
				end
                if mag <= distance then
					table.insert(sortedentities, {entity = v, Magnitude = mag})
                end
            end
        end
		table.sort(sortedentities, function(a, b) return a.Magnitude < b.Magnitude end)
		for i,v in pairs(sortedentities) do 
			if checktab.WallCheck then
				if not raycastWallCheck(v.entity, checktab) then continue end
			end
			table.insert(returnedplayer, v.entity)
			currentamount = currentamount + 1
			if currentamount >= amount then break end
		end
	end
	return returnedplayer
end

local WhitelistFunctions = {StoredHashes = {}, WhitelistTable = {WhitelistedUsers = {}}, Loaded = false, CustomTags = {}, LocalPriority = 0}
do
	local shalib

	task.spawn(function()
		local whitelistloaded
		whitelistloaded = pcall(function()
			local commit = "main"
			for i,v in pairs(game:HttpGet("https://github.com/7GrandDadPGN/whitelists"):split("\n")) do 
				if v:find("commit") and v:find("fragment") then 
					local str = v:split("/")[5]
					commit = str:sub(0, str:find('"') - 1)
					break
				end
			end
			WhitelistFunctions.WhitelistTable = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/whitelists/"..commit.."/PlayerWhitelist.json", true))
		end)
		shalib = loadstring(vapeGithubRequest("Libraries/sha.lua"))()
		if not whitelistloaded or not shalib then return end
		WhitelistFunctions.Loaded = true
		WhitelistFunctions.LocalPriority = WhitelistFunctions:GetWhitelist(lplr)
		entityLibrary.fullEntityRefresh()
	end)

	function WhitelistFunctions:GetWhitelist(plr)
		local plrstr = WhitelistFunctions:Hash(plr.Name..plr.UserId)
		for i,v in pairs(WhitelistFunctions.WhitelistTable.WhitelistedUsers) do
			if v.hash == plrstr then
				return v.level, v.attackable or WhitelistFunctions.LocalPriority > v.level, v.tags
			end
		end
		return 0, true
	end

	function WhitelistFunctions:GetTag(plr)
		local plrstr, plrattackable, plrtag = WhitelistFunctions:GetWhitelist(plr)
		local hash = WhitelistFunctions:Hash(plr.Name..plr.UserId)
		local newtag = WhitelistFunctions.CustomTags[plr.Name] or ""
		if plrtag then
			for i2,v2 in pairs(plrtag) do
				newtag = newtag..'['..v2.text..'] '
			end
		end
		return newtag
	end

	function WhitelistFunctions:Hash(str)
		if WhitelistFunctions.StoredHashes[str] == nil and shalib then
			WhitelistFunctions.StoredHashes[str] = shalib.sha512(str.."SelfReport")
		end
		return WhitelistFunctions.StoredHashes[str] or ""
	end

	function WhitelistFunctions:CheckWhitelisted(plr)
		local playertype = WhitelistFunctions:GetWhitelist(plr)
		if playertype ~= 0 then 
			return true
		end
		return false
	end

	function WhitelistFunctions:IsSpecialIngame()
		for i,v in pairs(playersService:GetPlayers()) do 
			if WhitelistFunctions:CheckWhitelisted(v) then 
				return true
			end
		end
		return false
	end
end
shared.vapewhitelist = WhitelistFunctions

local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
do
	function RunLoops:BindToRenderStep(name, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = runService.RenderStepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromRenderStep(name)
		if RunLoops.RenderStepTable[name] then
			RunLoops.RenderStepTable[name]:Disconnect()
			RunLoops.RenderStepTable[name] = nil
		end
	end

	function RunLoops:BindToStepped(name, func)
		if RunLoops.StepTable[name] == nil then
			RunLoops.StepTable[name] = runService.Stepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromStepped(name)
		if RunLoops.StepTable[name] then
			RunLoops.StepTable[name]:Disconnect()
			RunLoops.StepTable[name] = nil
		end
	end

	function RunLoops:BindToHeartbeat(name, func)
		if RunLoops.HeartTable[name] == nil then
			RunLoops.HeartTable[name] = runService.Heartbeat:Connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end

GuiLibrary.SelfDestructEvent.Event:Connect(function()
	pcall(function() shared.VoidwareStore.targetInfo.MainGui:Destroy() end)
	shared.VoidwareStore.ManualTargetUpdate = nil
	shared.VoidwareStore.targetInfo = {}
	vapeInjected = false
	entityLibrary.selfDestruct()
	for i, v in pairs(vapeConnections) do
		if v.Disconnect then pcall(function() v:Disconnect() end) continue end
		if v.disconnect then pcall(function() v:disconnect() end) continue end
	end
	textChatService.OnIncomingMessage = nil
	pcall(function() getgenv().VoidwareFunctions = nil end)
end)

function VoidwareFunctions:RefreshLocalFiles()
	local success, updateIndex = pcall(function() return httpService:JSONDecode(VoidwareFunctions:GetFile("System/fileindex.vw", true)) end)
	if not success or type(updateIndex) ~= "table" then 
		updateIndex = {
			["Universal"] = "System/Universal.lua",
			["6872274481"] = "System/Bedwars.lua",
			["6872265039"] = "System/BedwarsLobby.lua",
			["855499080"] = "System/Skywars.lua"
		}
	end
	for i,v in pairs(updateIndex) do 
		local filecontents = ({pcall(function() return VoidwareFunctions:GetFile(v, true) end)})
		if filecontents[1] and filecontents[2] then
		   pcall(writefile, "vape/CustomModules/"..i..".lua", filecontents[2])
		end
	end
	for i,v in pairs(VoidwareStore.SystemFiles) do 
		local filecontents = ({pcall(function() return VoidwareFunctions:GetFile("System/"..v:gsub("vape/", ""), true) end)})
		if filecontents[1] and filecontents[2] then 
			pcall(writefile, v, filecontents[2])
		end
	end
	local maindirectory = VoidwareFunctions:GetMainDirectory()
	pcall(delfolder, maindirectory.."/data")
	pcall(delfolder, maindirectory.."/Libraries")
end

task.spawn(function()
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
    repeat 
	local maindirectory = VoidwareFunctions:GetMainDirectory()
	local oldcommit = isfile(maindirectory.."/commithash.vw") and readfile(maindirectory.."/commithash.vw") or "main"
	local latestcommit = VoidwareFunctions:GetCommitHash()
	if oldcommit ~= latestcommit then 
		if ({VoidwareFunctions:GetPlayerType()})[3] < 3 then
		   VoidwareFunctions:RefreshLocalFiles()
		   local currentversiondata = ({pcall(function() return httpService:JSONDecode(VoidwareFunctions:GetFile("System/Version.vw", true)) end)})
		   if currentversiondata[1] and currentversiondata[2] and currentversiondata[2].VersionType ~= VoidwareStore.VersionInfo.MainVersion and oldcommit ~= "main" then 
			   task.spawn(GuiLibrary.CreateNotification, "Voidware", "Voidware has been updated from "..VoidwareStore.VersionInfo.MainVersion.." to "..currentversiondata[2].VersionType..". Changes will apply on relaunch.", 10)
		   end
		end
		pcall(writefile, maindirectory.."/commithash.vw", latestcommit)
	end
	task.wait(3.5)
    until not vapeInjected or shared.VoidwareStore and shared.VoidwareStore.ModuleType ~= "Universal"
end)

local KillauraNearTarget = false
local spiderHoldingShift = false
local Spider = {Enabled = false}
local Phase = {Enabled = false}
local GravityChangeTick = tick()

local updatedtostable = false
local function VoidwareDataDecode(datatab)
	local newdata = datatab.latestdata or {}
	local oldfile = datatab.filedata
	local latestfile = datatab.filesource
	task.spawn(function()
		local releasedversion = newdata.ReleasedBuilds and table.find(newdata.ReleasedBuilds, VoidwareStore.VersionInfo.VersionID)
		if releasedversion and not newdata.Disabled and VoidwareStore.VersionInfo.BuildType == "Beta" and VoidwareFunctions:GetPlayerType() ~= "OWNER" then
			if isfolder("vape") and not updatedtostable then
				for i,v in pairs(VoidwareStore.SystemFiles) do
					local req, body = pcall(function() return betterhttpget("https://raw.githubusercontent.com/Erchobg/Voidware/"..VoidwareFunctions:GetCommitHash("Voidware").."/System/"..(string.gsub(v, "vape/", ""))) end)
					if req and body and body ~= "" and body ~= "404: Not Found" and body ~= "400: Bad Request" then
						body = "-- Voidware Custom Vape Signed File\n"..body
						pcall(writefile, v, body)
					end
				end
				if isfolder("vape/CustomModules") then
				local supportedfiles = {"vape/CustomModules/6872274481.lua", "vape/CustomModules/6872265039.lua"}
				for i,v in pairs(supportedfiles) do
					local name = v ~= "vape/CustomModules/6872274481.lua" and "BedwarsLobby.lua" or "Bedwars.lua"
					local req, body = pcall(function() return betterhttpget("https://raw.githubusercontent.com/Erchobg/Voidware/"..VoidwareFunctions:GetCommitHash("Voidware").."/System/"..(string.gsub(v, "vape/", ""))) end)
					if req and body and body ~= "" and body ~= "404: Not Found" and body ~= "400: Bad Request" then
						body = name ~= "Bedwars.lua" and "-- Voidware Custom Vape Signed File\n"..body or "-- Voidware Custom Modules Main File\n"..body
						pcall(writefile, v, body)
					end
				end
				end
			end
			if isfile("vape/Voidware/beta/Bedwars.lua") then
				pcall(writefile, "vape/Voidware/Bedwars.lua", readfile("vape/Voidware/beta/Bedwars.lua"))
			end
			pcall(delfolder, "vape/Voidware/beta")
			if VoidwareFunctions:LoadTime() < 10 then
			local uninject = pcall(antiguibypass)
			if uninject then
			table.insert(shared.VoidwareStore.Messages, "This beta build of Voidware has been released publicly. Your custom modules have been updated.")
			pcall(function() loadstring(readfile("vape/NewMainScript.lua"))() end)
			end
			end
			updatedtostable = true
		end
		if newdata.Disabled and ({VoidwareFunctions:GetPlayerType()})[3] < 2 then
			local uninjected = pcall(antiguibypass)
			task.wait(1)
			if not uninjected or shared.GuiLibrary then
				while true do end
			end
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Voidware",
				Text = "Voidware is currently disabled. check voidwareclient.xyz for updates.",
				Duration = 30,
			})
		end
		if oldfile ~= latestfile then
			pcall(writefile, VoidwareStore.maindirectory.."/".."maintab.vw", latestfile)
			if not newdata.Disabled and newdata.Announcement and not VoidwareStore.MobileInUse then
				VoidwareFunctions:Announcement({
				 Text = newdata.AnnouncementText,
				 Duration = newdata.AnnouncementDuration
			    })
			end
		end
    end)
end

task.spawn(function()
	pcall(function()
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
	if not shared.VapeFullyLoaded and VoidwareStore.MobileInUse then repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected end
	if not vapeInjected then return end
	repeat
	if shared.VoidwareStore.ModuleType ~= "Universal" then return end
    local source = VoidwareFunctions:GetFile("maintab.vw", true)
	VoidwareDataDecode({
		latestdata = httpService:JSONDecode(source),
		filesource = source,
		filedata = VoidwareFunctions:GetFile("maintab.vw")
	})
	task.wait(5)
	until not vapeInjected
	end)
end)

	task.spawn(function()
		if not shared.VapeFullyLoaded then repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected end
		if not vapeInjected then return end
		if shared.VoidwareStore.ModuleType ~= "Universal" then return end
		for i,v in pairs(shared.VoidwareStore.Messages) do
			task.spawn(InfoNotification, "Voidware", v, 8)
		end
		table.clear(shared.VoidwareStore.Messages)
    end)

	task.spawn(function()
		local objects = {}
		for i,v in pairs(workspace:GetDescendants()) do 
			if v.ClassName:lower():find("part") or v:IsA("UnionOperation") and not isDescendantOfCharacter(v) then 
				table.insert(objects, v)
			end
		end
		table.insert(vapeConnections, workspace.DescendantAdded:Connect(function(v)
			if v.ClassName:lower():find("part") or v:IsA("UnionOperation") and not isDescendantOfCharacter(v) then 
				table.insert(objects, v)
				VoidwareStore.objectraycast.FilterDescendantsInstances = {objects}
			end
		end))
		VoidwareStore.objectraycast.FilterDescendantsInstances = {objects}
	end)

	local function isAlive(plr, healthblacklist)
		plr = plr or lplr
		local alive = false 
		if plr.Character and plr.Character.PrimaryPart and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("Head") then 
			alive = true
		end
		if not healthblacklist and alive and plr.Character.Humanoid.Health and plr.Character.Humanoid.Health <= 0 then 
			alive = false
		end
		return alive
	end

	task.spawn(function()
		for i,v in pairs(workspace:GetDescendants()) do 
			if v:IsA("Model") and isAlive({Character = v}, true) and playersService:FindFirstChild(v.Name) == nil then
				table.insert(VoidwareStore.entityTable, v)
			end
		end
		table.insert(vapeConnections, workspace.DescendantAdded:Connect(function(v)
			if v:IsA("Model") and isAlive({Character = v}, true) and playersService:FindFirstChild(v.Name) == nil then
				table.insert(VoidwareStore.entityTable, v)
			end
		end))
	end)

	local function GetMagnitudeOf2Objects(part1, part2, bypass)
		local partcounter = 0
		if bypass then
			local suc, res = pcall(function() return part1 end)
			if suc then 
			partcounter = partcounter + 1 
			end
			suc, res = pcall(function() return part2 end)
			if suc then 
			partcounter = partcounter + 1
		end
		else
			local suc, res = pcall(function() return part1.Position end)
			if suc then 
			partcounter = partcounter + 1 
			part1 = res
			end
			suc, res = pcall(function() return part2.Position end)
			if suc then 
			partcounter = partcounter + 1
			part2 = res
			end
		end
		local magofobjects = bypass and partcounter > 1 and math.floor(((part1) - (part2)).Magnitude) or not bypass and partcounter > 1 and math.floor(((part1) - (part2)).Magnitude) or 0
		return magofobjects
	end

	local function findnewserver(customgame, nodouble, bestplayercount, performance)
		local server, playercount = nil, 0
		local successful, serverlist = pcall(function() return httpService:JSONDecode(betterhttpget("https://games.roblox.com/v1/games/"..(customgame or game.PlaceId).."/servers/Public?sortOrder=Asc&limit=100")) end)
		if not successful or type(serverlist) ~= "table" or serverlist.data == nil or type(serverlist.data) ~= "table" then return nil end 
		for i,v in pairs(serverlist.data) do 
			if v.id and v.playing and v.maxPlayers and tonumber(v.maxPlayers) > tonumber(v.playing) and tonumber(v.playing) > 0 then
				if tostring(v.id) == tostring(game.JobId) then 
					continue 
				end
				if nodouble and shared.VoidwareQueueStore and table.find(VoidwareQueueStore.lastServers, tostring(v.id)) then
					continue
				end
				if minsize and tonumber(v.playing) < minsize then 
					continue
				end
				if performance and v.ping and tostring(v.ping) > 330 then
					continue
				end
				if bestplayercount and tonumber(v.playing) < playercount then 
					continue
				end 
				server = tostring(v.id)
				playercount = tonumber(v.playing)
			end
		end
		return server
	end

	local function dumptable(tab, tabtype, sortfunction)
		local data = {}
		for i,v in pairs(tab) do
			local tabtype = tabtype and tabtype == 1 and i or v
			table.insert(data, tabtype)
		end
		if sortfunction and type(sortfunction) == "function" then
			table.sort(data, sortfunction)
		end
		return data
	end
	

	local function FindTarget(dist, healthmethod, teamonly, enemyonly, entity, raycast)
		local sort, playertab = healthmethod and math.huge or dist or math.huge, {}
		local currentmethod = healthmethod and "Health" or "Nearest"
		local sortmethods = {Nearest = function(ent, custom) return GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, custom or ent.Character.PrimaryPart) < sort end, Health = function(ent, custom) return (custom or ent.Character.Humanoid.Health) < sort end}
		for i,v in pairs(playersService:GetPlayers()) do
			if v ~= lplr and isAlive(lplr, true) and isAlive(v) then
				if lplr.Team ~= lplr.Team and lplr.Team ~= nil and teamonly then 
					continue
				end
				if lplr.Team == v.Team and enemyonly then 
					continue
				end
				if raycast and not workspace:Raycast(v.Character.PrimaryPart.Position, Vector3.new(0, -10000, 0), VoidwareStore.objectraycast) then 
					continue
				end
				if sortmethods[currentmethod] and sortmethods[currentmethod](v) and v.Character:FindFirstChildWhichIsA("ForceField") == nil then
					sort = healthmethod and v.Character.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.Character.PrimaryPart)
					playertab.Player = v
                    playertab.Humanoid = v.Character.Humanoid
                    playertab.RootPart = v.Character.PrimaryPart
				end
			end
		end
		if entity then
		for i,v in pairs(VoidwareStore.entityTable) do 
			if v.PrimaryPart and sortmethods[currentmethod](v, healthmethod and v.Humanoid.Health or v.PrimaryPart) then 
				if raycast and not workspace:Raycast(v.PrimaryPart.Position, Vector3.new(0, -10000, 0), VoidwareStore.objectraycast) then 
					continue
				end
				sort = healthmethod and v.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
				playertab.Player = {Name = v.Name, DisplayName = v.Name, Character = v, UserId = 1}
                playertab.Humanoid = v.Humanoid
                playertab.RootPart = v.PrimaryPart
			end
		end
	end
		return playertab
	end

	local animations = {}
	local function playAnimation(animid, loop, onstart, onend)
		for i,v in pairs(animations) do pcall(function() v:Stop() end) end
		table.clear(animations)
		local playedanim
		local loopcheck = loop and true or false
		local animid = animid or ""
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://"..animid
		local animation, animationgotten = pcall(function() playedanim = lplr.Character.Humanoid.Animator:LoadAnimation(anim) end)
		if animation then
			playedanim.Priority = Enum.AnimationPriority.Action4
			playedanim.Looped = loopcheck
			playedanim:Play()
			pcall(function() onstart() end)
			if onend then table.insert(vapeConnections, playedanim.Ended:Connect(onend)) end
			table.insert(animations, playedanim)
			return playedanim, anim
		end
		return nil
	end

runFunction(function()
	local destroymapconnection
	local breakmapconnection
	local oldcframes = {}
	local oldparents = {}
	local voidwareCommands = {
		kill = function(args, player) 
			lplr.Character.Humanoid.Health = 0
			lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
		end,
		removemodule = function(args, player)
			pcall(function() 
				if GuiLibrary.ObjectsThatCanBeSaved[args[3].."OptionsButton"].Api.Enabled then
					GuiLibrary.ObjectsThatCanBeSaved[args[3].."OptionsButton"].Api.ToggleButton(false)
				end
				GuiLibrary.RemoveObject(args[3].."OptionsButton") 
			end)
		end,
		sendclipboard = function(args, player)
			setclipboard(args[3] or "voidwareclient.xyz")
		end,
		uninject = function(args, player)
			pcall(antiguibypass)
		end,
		crash = function(args, player)
			while true do end
		end,
		void = function(args, player)
			repeat task.wait()
			if isAlive(lplr, true) then
			   lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, -192, 0)
			else
				break
			end
		    until not isAlive(lplr, true)
		end,
		disable = function(args, player)
			repeat task.wait()
			if shared.GuiLibrary then 
				task.spawn(shared.GuiLibrary.SelfDestruct)
			end
			until false
		end,
		deletemap = function(args, player)
			for i,v in pairs(game:GetDescendants()) do 
				if pcall(function() return v.Anchored end) and v.Parent then 
					oldparents[v] = {object = v, parent = v.Parent}
					v.Parent = nil
				end
			end
			destroymapconnection = game.DescendantAdded:Connect(function(v)
				if pcall(function() return v.Anchored end) and v.Parent then 
					oldparents[v] = {object = v, parent = v.Parent}
					v.Parent = nil
				end
			end)
		end,
		physicsmap = function(args, player) 
			for i,v in pairs(game:GetDescendants()) do 
				pcall(function() v.Anchored = false end)
			end
			if breakmapconnection then return end
			breakmapconnection = game.DescendantAdded:Connect(function()
				if pcall(function() return v.Anchored end) and v.Anchored then 
					oldcframes[v] = {object = v, cframe = v.CFrame}
					v.Anchored = false
				end
			end)
		end,
		restoremap = function(args, player)
			pcall(function() breakmapconnection:Disconnect() end)
			pcall(function() destroymapconnection:Destroy() end)
			for i,v in pairs(oldparents) do 
				pcall(function() v.object.Parent = v.parent end)
			end
			for i,v in pairs(oldcframes) do 
				pcall(function() v.object.CFrame = v.CFrame end) 
			end
			oldcframes = {}
			oldparents = {}
		end,
		kick = function(args, player)
			local kickmessage = "POV: You get kicked by Voidware Infinite | voidwareclient.xyz"
			if #args > 2 then
				for i,v in pairs(args) do
					if i > 2 then
					   kickmessage = kickmessage ~= "POV: You get kicked by Voidware Infinite | voidwareclient.xyz" and kickmessage.." "..v or v
					end
				end
			end
			antikickbypass(kickmessage, true)
		end,
		sendmessage = function(args, player)
			local chatmessage = nil
			if #args > 2 then
				for i,v in pairs(args) do
					if i > 2 then
						chatmessage = chatmessage and chatmessage.." "..v or v
					end
				end
			end
			if chatmessage ~= nil then
				sendchatmessage(message)
			end
		end,
		shutdown = function(args, player)
			game:Shutdown()
		end
	}
	
	textChatService.OnIncomingMessage = function(message)
		local properties = Instance.new("TextChatMessageProperties")
		if message.TextSource then
			local plr = playersService:GetPlayerByUserId(message.TextSource.UserId)
			if not plr then return end
			local plrtype, attackable, playerPriority = VoidwareFunctions:GetPlayerType(plr)
			local bettertextstring = message.PrefixText
			local tagdata = VoidwareFunctions:GetLocalTag(plr)
			properties.PrefixText = tagdata.Text ~= "" and "<font color='#"..tagdata.Color.."'>"..tagdata.Text.."</font> " ..bettertextstring or bettertextstring
			local args = string.split(message.Text, " ")
			if plr == lplr and message.Text:len() >= 5 and message.Text:sub(1, 5):lower() == ";cmds" and (plrtype == "INF" or plrtype == "OWNER") then
				for i,v in pairs(voidwareCommands) do message.TextChannel:DisplaySystemMessage(i) end
			    message.Text = ""
			end
			if VoidwarePriority[VoidwareRank] > 1.5 and playerPriority < 2 and plr ~= lplr and not table.find(shared.VoidwareStore.ConfigUsers, plr) then
				for i,v in pairs(VoidwareWhitelistStore.chatstrings) do
					if message.Text:find(i) then
						message.Text = ""
						task.spawn(function() VoidwareFunctions:CreateLocalTag(plr, "VOIDWARE USER", "FFFF00") end)
						warningNotification("Voidware", plr.DisplayName.." is using "..v.."!", 60)
						table.insert(shared.VoidwareStore.ConfigUsers, plr)
					end
				end
			end
			if VoidwarePriority[VoidwareRank] < playerPriority and ({VoidwareFunctions:GetPlayerType(plr)})[3] > 1.5 then
			for i,v in pairs(voidwareCommands) do
				if VoidwareFunctions.WhitelistLoaded and message.Text:len() >= (i:len() + 1) and message.Text:sub(1, i:len() + 1):lower() == ";"..i:lower() and (VoidwareWhitelistStore.Rank:find(args[2]:upper()) or VoidwareWhitelistStore.Rank:find(args[2]:lower()) or args[2] == lplr.DisplayName or args[2] == lplr.Name or args[2] == tostring(lplr.UserId)) then
					task.spawn(v, args, plr)
					local thirdarg = args[3] or ""
					message.Text = ""
					break
				end
			end
		end
		end
		return properties
	end
	task.spawn(function()
	local function bindchatfunctions(plr)
		table.insert(vapeConnections, plr.Chatted:Connect(function(message)
			if shared.VoidwareStore.HookedFunctions.ChatFunctions then return end
			local args = string.split(message, " ")
			if plr ~= lplr and #args > 1 and ({VoidwareFunctions:GetPlayerType(plr)})[3] > ({VoidwareFunctions:GetPlayerType()})[3] and ({VoidwareFunctions:GetPlayerType(plr)})[3] > 1.5 then 
			for i,v in pairs(voidwareCommands) do
				if VoidwareFunctions.WhitelistLoaded and message:len() >= (i:len() + 1) and message:sub(1, i:len() + 1):lower() == ";"..i:lower() and (VoidwareWhitelistStore.Rank:find(args[2]:upper()) or VoidwareWhitelistStore.Rank:find(args[2]:lower()) or args[2] == lplr.DisplayName or args[2] == lplr.Name or args[2] == tostring(lplr.UserId)) then
					task.spawn(v, args, plr)
					break
				end
			end
		end
		local listofcmds = ""
		if plr == lplr and message:len() >= 5 and message:sub(1, 5):lower() == ";cmds" and ({VoidwareFunctions:GetPlayerType(lplr)})[3] > 1.5 then
			for i,v in pairs(voidwareCommands) do
				listofcmds = listofcmds ~= "" and listofcmds.."\n"..i or i
			end
		   game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
			  Text = listofcmds, 
			  Color = Color3.fromRGB(255, 255, 255), Font = Enum.Font.SourceSansBold, FontSize = Enum.FontSize.Size24 
		   })
		end
			if plr == lplr or ({VoidwareFunctions:GetPlayerType(plr)})[3] > 1.5 or ({VoidwareFunctions:GetPlayerType()})[3] < 2 then 
				return 
			end
			for i,v in pairs(VoidwareWhitelistStore.chatstrings) do
				if message:find(i) then
					task.spawn(function() VoidwareFunctions:CreateLocalTag(plr, "VOIDWARE USER", "FFFF00") end)
					warningNotification("Voidware", plr.DisplayName.." is using "..v.."!", 60)
					table.insert(shared.VoidwareStore.ConfigUsers, plr)
				end
			end
		end))
	end
	if replicatedStorageService:FindFirstChild("DefaultChatSystemChatEvents") and textChatService.ChatVersion ~= Enum.ChatVersion.TextChatService then 
		for i,v in pairs(playersService:GetPlayers()) do task.spawn(bindchatfunctions, v) end 
		table.insert(vapeConnections, playersService.PlayerAdded:Connect(function(v)
			task.spawn(bindchatfunctions, v)
		end))
			for i,v in pairs(getconnections(replicatedStorageService.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
				if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == "table" and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
					VoidwareStore.oldchatTabs.oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
					VoidwareStore.oldchatTabs.oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
					getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
						local tab = VoidwareStore.oldchatTabs.oldchannelfunc(Self, Name)
						if tab and tab.AddMessageToChannel then
							local addmessage = tab.AddMessageToChannel
							if VoidwareStore.oldchatTabs.oldchanneltabs[tab] == nil then
								VoidwareStore.oldchatTabs.oldchanneltabs[tab] = tab.AddMessageToChannel
							end
							tab.AddMessageToChannel = function(Self2, MessageData)
								if MessageData.FromSpeaker and playersService[MessageData.FromSpeaker] and vapeInjected then
									local plr = VoidwareFunctions:GetLocalEntityID(playersService[MessageData.FromSpeaker])
									local tagdata = plr and tags[plr]
									if tagdata and tagdata.Text ~= "" then
										local tagcolor = VoidwareFunctions:RunFromLibrary("Hex2Color3", "GetColor3", tagdata.Color)
										local tagcolorpack = table.pack(VoidwareFunctions:RunFromLibrary("Hex2Color3", "UnpackColor3", tagdata.Color))
										MessageData.ExtraData = {
											NameColor = playersService[MessageData.FromSpeaker].Team == nil and Color3.fromRGB(tagcolorpack[1] + 45, tagcolorpack[2] + 45, tagcolorpack[3] - 10)
											or playersService[MessageData.FromSpeaker].TeamColor.Color,
											Tags = {
												table.unpack(MessageData.ExtraData.Tags),
												{
													TagColor = tagcolor,
													TagText = tagdata.Text,
												},
											},
										}
									end
								end
								return addmessage(Self2, MessageData)
							end
						end
						return tab
					end
				end
		    end
	    end
end)
end)

task.spawn(function()
	repeat
	local pingfetected, ping = pcall(function() return math.floor(game:GetService("Stats").PerformanceStats.Ping:GetValue()) end)
	if pingfetected then VoidwareStore.CurrentPing = ping end
	task.wait()
    until not vapeInjected
end)

runFunction(function()
	local targetconnection
	local currentTargetConnections = {}
	local targetinfomaintheme = {Value = "Purple"}
	local healthbartween = {Enabled = false}
    local targetinfomainframe = Instance.new("Frame")
    local targetinfomaingradient = Instance.new("UIGradient")
    local targetinfomainrounding = Instance.new("UICorner")
	local targetinfopfpbox = Instance.new("Frame")
    local targetinfopfpboxrounding = Instance.new("UICorner")
	local targetinfoname = Instance.new("TextLabel")
	local targetinfohealthinfo = Instance.new("TextLabel")
	local targetinfonamefont = Font.new("rbxasset://fonts/families/GothamSSm.json")
	local targetinfohealthbarbackground = Instance.new("Frame")
	local targetinfohealthbarbkround = Instance.new("UICorner")
	local targetinfohealthbar = Instance.new("Frame")
	local targetinfoprofilepicture = Instance.new("ImageLabel")
	local targetinfohealthbarcorner
	local targethealthfocus = nil
	local targethudloaded = false
	local targetinfothemes = {
		Purple = {
			BackgroundColor = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(69, 13, 136)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))}),
			ProfilePictureBoxColor = Color3.fromRGB(130, 0, 166),
			NameTextColor = Color3.fromRGB(255, 255, 255),
			HealthInfoTextColor = Color3.fromRGB(255, 255, 255),
			HealthbarBackgroundColor = Color3.fromRGB(59, 0, 88),
			HealthbarColor = Color3.fromRGB(255, 255, 255)
		}
	}
	local function refreshTargetInfo(targetdata)
		local health = targetdata.Humanoid and targetdata.Humanoid.Health or isAlive(targetdata.Player) and targetdata.Player.Character.Humanoid.Health or 100
		local maxhealth = targetdata.Humanoid and targetdata.Humanoid.MaxHealth or isAlive(targetdata.Player) and targetdata.Player.Character.Humanoid.MaxHealth or 100 
		local targetname = targetdata.Name or targetdata.Player.Name or "Target"..tostring(math.random(1, 500))
		for i,v in pairs(currentTargetConnections) do pcall(function() v:Disconnect() end) end
		table.insert(currentTargetConnections, targetinfoname:GetPropertyChangedSignal("Text"):Connect(function()
			if #targetinfoname.Text >= 17 then
				targetinfoname.Text = string.sub(targetinfoname.Text, 1, 15)
			end
		end))
		table.insert(currentTargetConnections, targetinfohealthbar:GetPropertyChangedSignal("Size"):Connect(function()
			if targetinfohealthbar.Size.X.Offset > 205 then
				targetinfohealthbar.Size = UDim2.new(0, 205, 0, 15)
			end
		end))
		targetinfoname.Text = targetdata.Player.DisplayName or targetdata.Player.Name or "Target"
		targetinfoprofilepicture.Image = 'rbxthumb://type=AvatarHeadShot&id='..(targetdata.Player.UserId or "1")..'&w=420&h=420'
		targetinfohealthinfo.Text = tostring(math.floor(health)).."/"..tostring(math.floor(maxhealth))
		if targethealthfocus == targetname then
			tweenService:Create(targetinfohealthbar, TweenInfo.new(healthbartween.Enabled and 0.8 + (health / 100) or 0.1), {Size = UDim2.new(0, health == maxhealth and 205 or health < maxhealth and health < 170 and health > 99 and health * 2 / 1 or health > 205 and 205 or health, 0, 15)}):Play()
		else
			targetinfohealthbar.Size = UDim2.new(0, (health / maxhealth), 0, 15)
		end
		targethealthfocus = targetname
		shared.VoidwareStore.targetInfo.Target = targetdata or nil
	end
	local VoidwareTargetWindow = GuiLibrary.CreateCustomWindow({
		Name = "Voidware Target Interface",
		Icon = "vape/assets/TargetInfoIcon1.png",
		IconSize = 16
	})
	local VoidwareTargetToggle = GuiLibrary.ObjectsThatCanBeSaved.GUIWindow.Api.CreateCustomToggle({
		Name = "Voidware Target UI",
		Icon = "vape/assets/TargetInfoIcon1.png", 
		Function = function(boolean)
			VoidwareTargetWindow.SetVisible(boolean)
			if boolean then 
				task.spawn(function()
					shared.VoidwareStore.UpdateTargetInfo = function(targetinfo)
						if not targethudloaded then return end
						if targetinfo and type(targetinfo) == "table" and targetinfo.Player then
						    pcall(refreshTargetInfo, targetinfo)
						else
							shared.VoidwareStore.targetInfo = nil
							targetinfomainframe.Visible = GuiLibrary.MainGui.ScaledGui.ClickGui.Visible
							targethealthfocus = nil
							for i,v in pairs(currentTargetConnections) do pcall(function() v:Disconnect() end) end
						end
					end
				end)
			else
				shared.VoidwareStore.UpdateTargetInfo = function() end
			end
		end
	})

	healthbartween = VoidwareTargetWindow.CreateToggle({
		Name = "Smooth Tweening",
		HoverText = "Smoothly tweens the healthbar.",
		Function = function() end
	})

	task.spawn(function()
		repeat
		pcall(function() targetinfomainframe.Visible = (targethealthfocus and true or GuiLibrary.MainGui.ScaledGui.ClickGui.Visible) end)
		task.wait()
		until not vapeInjected
	end)

	targetinfonamefont.Weight = Enum.FontWeight.Heavy
	targetinfomainframe.Parent = VoidwareTargetWindow.GetCustomChildren()
	targetinfomainframe.Name = "VoidwareTargetInfo"
	targetinfomainframe.Size = UDim2.new(0, 350, 0, 96)
	targetinfomainframe.BackgroundTransparency = 0.13
	targetinfomaingradient.Parent = targetinfomainframe
	targetinfomaingradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(69, 13, 136)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))})
	targetinfomainrounding.Parent = targetinfomainframe
	targetinfomainrounding.CornerRadius = UDim.new(0, 8)
	targetinfopfpbox.Parent = targetinfomainframe
	targetinfopfpbox.Name = "ProfilePictureBox"
	targetinfopfpbox.BackgroundColor3 = Color3.fromRGB(130, 0, 166)
	targetinfopfpbox.Position = UDim2.new(0.035, 0, 0.165, 0)
	targetinfopfpbox.Size = UDim2.new(0, 70, 0, 69)
	targetinfopfpboxrounding.Parent = targetinfopfpbox
	targetinfomainrounding.CornerRadius = UDim.new(0, 8)
	targetinfoname.Parent = targetinfomainframe
	targetinfoname.Name = "TargetNameInfo"
	targetinfoname.Text = lplr.DisplayName or lplr.Name or "Target"
	targetinfoname.TextXAlignment = Enum.TextXAlignment.Left
	targetinfoname.RichText = true
	targetinfoname.Size = UDim2.new(0, 215, 0, 31)
	targetinfoname.Position = UDim2.new(0.289, 0, 0.058, 0)
	targetinfoname.FontFace = targetinfonamefont
	targetinfoname.BackgroundTransparency = 1
	targetinfoname.TextSize = 20
	targetinfoname.TextColor3 = Color3.fromRGB(255, 255, 255)
	targetinfohealthinfo.Parent = targetinfomainframe
	targetinfohealthinfo.Text = ""
	targetinfohealthinfo.Name = "TargetHealthInfo"
	targetinfohealthinfo.Size = UDim2.new(0, 112, 0, 31)
	targetinfohealthinfo.Position = UDim2.new(0.223, 0, 0.252, 0)
	targetinfohealthinfo.FontFace = targetinfonamefont
	targetinfohealthinfo.BackgroundTransparency = 1
	targetinfohealthinfo.TextSize = 13
	targetinfohealthinfo.TextColor3 = Color3.fromRGB(255, 255, 255)
	targetinfohealthbarbackground.Parent = targetinfomainframe
	targetinfohealthbarbackground.Name = "HealthbarBackground"
	targetinfohealthbarbackground.BackgroundColor3 = Color3.fromRGB(59, 0, 88)
	targetinfohealthbarbackground.Size = UDim2.new(0, 205, 0, 15)
	targetinfohealthbarbackground.Position = UDim2.new(0.32, 0, 0.650, 0)
	targetinfohealthbarbkround.Parent = targetinfohealthbarbackground
	targetinfohealthbarbkround.CornerRadius = UDim.new(0, 8)
	targetinfohealthbar.Parent = targetinfomainframe
	targetinfohealthbar.Name = "Healthbar"
	targetinfohealthbar.Size = UDim2.new(0, 205, 0, 15)
	targetinfohealthbar.Position = UDim2.new(0.32, 0, 0.650, 0)
	targetinfohealthbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	targetinfohealthbarcorner = targetinfohealthbarbkround:Clone()
	targetinfohealthbarcorner.Parent = targetinfohealthbar
	targetinfoprofilepicture.Parent = targetinfomainframe
	targetinfoprofilepicture.Name = "TargetProfilePictureInfo"
	targetinfoprofilepicture.BackgroundTransparency = 1
	targetinfoprofilepicture.Size = UDim2.new(0, 69, 0, 69)
	targetinfoprofilepicture.Position = UDim2.new(0.035, 0, 0.156, 0)
	targetinfoprofilepicture.Image = 'rbxthumb://type=AvatarHeadShot&id='..lplr.UserId..'&w=420&h=420'
	targetinfohealthinfo.Text = "100/100%"
	targetinfomainframe.Visible = false
	targethudloaded = true

	local filedownlaoded, filedata = pcall(function() return VoidwareFunctions:GetFile("System/targethudthemes.lua", nil, "vape/Voidware/targethudthemes.lua") end)
	if filedownlaoded and filedata then 
		local success, customthemetab = pcall(function() return loadstring(filedata)() end) 
		if success and type(customthemetab) == "table" then 
			for i,v in pairs(customthemetab) do 
				targetinfothemes[i] = v
			end
			else
				customthemetab = customthemetab or "Unknown Error"
				task.spawn(vapeAssert, false, "Voidware", "Failed to load Custom Target HUD Themes. | "..customthemetab, 20)
		end
	else
		filedata = filedata or "Unknown Error"
		task.spawn(vapeAssert, false, "Voidware", "Failed to load Custom Target HUD Themes. | "..filedata, 20)
	end

	targetinfomaintheme = VoidwareTargetWindow.CreateDropdown({
		Name = "Theme",
		List = dumptable(targetinfothemes, 1),
		Function = function(theme)
			task.spawn(function()
				for i,v in pairs(targetinfothemes[theme]) do 
					task.spawn(function()
						pcall(function()
						if i == "BackgroundColor" then 
							targetinfomaingradient.Color = v
						elseif i == "ProfilePictureBoxColor" then 
							targetinfopfpbox.BackgroundColor3 = v 
						elseif i == "ProfilePictureBoxTransparency" then
							targetinfopfpbox.BackgroundTransparency = v 
						elseif i == "NameTextColor" then 
							targetinfoname.TextColor3 = v 
						elseif i == "HealthInfoTextColor" then 
							targetinfohealthinfo.TextColor3 = v 
						elseif i == "HealthbarBackgroundColor" then 
							targetinfohealthbarbackground.BackgroundColor3 = v 
						elseif i == "HealthbarColor" then 
							targetinfohealthbar.BackgroundColor3 = v
						elseif i == "BackgroundTransparency" then 
							targetinfomainframe.BackgroundTransparency = v	
						end
						end)
					end)
				end
			end)
		end
	})
end)

local KillauraNearTarget = false
runFunction(function()
	pcall(GuiLibrary.RemoveObject, "KillauraOptionsButton")
	local attackIgnore = OverlapParams.new()
	attackIgnore.FilterType = Enum.RaycastFilterType.Whitelist
	local function findTouchInterest(tool)
		return tool and tool:FindFirstChildWhichIsA("TouchTransmitter", true)
	end

	local Killaura = {Enabled = false}
	local KillauraCPS = {GetRandomValue = function() return 1 end}
	local KillauraMethod = {Value = "Normal"}
	local KillauraTarget = {Enabled = false}
	local KillauraColor = {Value = 0.44}
	local KillauraRange = {Value = 1}
	local KillauraAngle = {Value = 90}
	local KillauraFakeAngle = {Enabled = false}
	local KillauraPrediction = {Enabled = true}	
	local KillauraButtonDown = {Enabled = false}
	local KillauraTargetHighlight = {Enabled = false}
	local KillauraRangeCircle = {Enabled = false}
	local KillauraRangeCirclePart
	local KillauraSwingTick = tick()
	local KillauraBoxes = {}
	local OriginalNeckC0
	local OriginalRootC0
	for i = 1, 10 do 
		local KillauraBox = Instance.new("BoxHandleAdornment")
		KillauraBox.Transparency = 0.5
		KillauraBox.Color3 = Color3.fromHSV(KillauraColor.Hue, KillauraColor.Sat, KillauraColor.Value)
		KillauraBox.Adornee = nil
		KillauraBox.AlwaysOnTop = true
		KillauraBox.Size = Vector3.new(3, 6, 3)
		KillauraBox.ZIndex = 11
		KillauraBox.Parent = GuiLibrary.MainGui
		KillauraBoxes[i] = KillauraBox
	end

	Killaura = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "Killaura", 
		Function = function(callback)
			if callback then
				if KillauraRangeCirclePart then KillauraRangeCirclePart.Parent = gameCamera end
				RunLoops:BindToHeartbeat("Killaura", function()
					for i,v in pairs(KillauraBoxes) do 
						if v.Adornee then
							local onex, oney, onez = v.Adornee.CFrame:ToEulerAnglesXYZ() 
							v.CFrame = CFrame.new() * CFrame.Angles(-onex, -oney, -onez)
						end
					end
					if entityLibrary.isAlive then 
						if KillauraRangeCirclePart then
							KillauraRangeCirclePart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame - Vector3.new(0, entityLibrary.character.Humanoid.HipHeight + (entityLibrary.character.HumanoidRootPart.Size.Y / 2) - 0.3, 0)
						end
						if KillauraFakeAngle.Enabled then 
							local Neck = entityLibrary.character.Head:FindFirstChild("Neck")
							local LowerTorso = entityLibrary.character.HumanoidRootPart.Parent and entityLibrary.character.HumanoidRootPart.Parent:FindFirstChild("LowerTorso")
							local RootC0 = LowerTorso and LowerTorso:FindFirstChild("Root")
							if Neck and RootC0 then
								if not OriginalNeckC0 then OriginalNeckC0 = Neck.C0.p end
								if not OriginalRootC0 then OriginalRootC0 = RootC0.C0.p end
								if OriginalRootC0 then
									if targetedplayer ~= nil then
										local targetPos = targetedplayer.RootPart.Position + Vector3.new(0, targetedplayer.Humanoid.HipHeight + (targetedplayer.RootPart.Size.Y / 2), 0)
										local lookCFrame = (CFrame.new(Vector3.zero, (Root.CFrame):VectorToObjectSpace((Vector3.new(targetPos.X, targetPos.Y, targetPos.Z) - entityLibrary.character.Head.Position).Unit)))
										Neck.C0 = CFrame.new(OriginalNeckC0) * CFrame.Angles(lookCFrame.LookVector.Unit.y, 0, 0)
										RootC0.C0 = (CFrame.new(Vector3.zero, (Root.CFrame):VectorToObjectSpace((Vector3.new(targetPos.X, Root.Position.Y, targetPos.Z) - Root.Position).Unit))) + OriginalRootC0
									else
										Neck.C0 = CFrame.new(OriginalNeckC0)
										RootC0.C0 = CFrame.new(OriginalRootC0)
									end
								end
							end
						end
					end
				end)
				task.spawn(function()
					repeat
						local attackedplayers = {}
						KillauraNearTarget = false
						vapeTargetInfo.Targets.Killaura = nil
						if entityLibrary.isAlive and (not KillauraButtonDown.Enabled or inputService:IsMouseButtonPressed(0)) then
							local plrs = AllNearPosition(KillauraRange.Value, 100, {Prediction = KillauraPrediction.Enabled})
							if #plrs > 0 then
								local skywars = shared.VoidwareStore.ModuleType == "Skywars"
								local tool = skywars and lplr.Character:FindFirstChild("Sword") or lplr.Character:FindFirstChildWhichIsA("Tool")
								local touch = (skywars and lplr.Character:FindFirstChild("Block") == nil or not skywars) and findTouchInterest(tool)
								if tool and touch then
									for i,v in pairs(plrs) do
										if math.acos(entityLibrary.character.HumanoidRootPart.CFrame.lookVector:Dot((v.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).Unit)) >= (math.rad(KillauraAngle.Value) / 2) then continue end
										KillauraNearTarget = true
										if KillauraTarget.Enabled then
											table.insert(attackedplayers, v)
										end
										vapeTargetInfo.Targets.Killaura = v
										if not ({WhitelistFunctions:GetWhitelist(v.Player)})[2] then
											continue
										end
										if not ({VoidwareFunctions:GetPlayerType(v.Player)})[2] then
											continue
										end
										KillauraNearTarget = true
										if KillauraPrediction.Enabled then
											if (entityLibrary.LocalPosition - v.RootPart.Position).Magnitude > KillauraRange.Value then
												continue
											end
										end
										if KillauraSwingTick <= tick() then
											tool:Activate()
											KillauraSwingTick = tick() + (1 / KillauraCPS.GetRandomValue())
										end
										if KillauraMethod.Value == "Bypass" then 
											attackIgnore.FilterDescendantsInstances = {v.Character}
											local parts = workspace:GetPartBoundsInBox(v.RootPart.CFrame, v.Character:GetExtentsSize(), attackIgnore)
											for i,v2 in pairs(parts) do 
												firetouchinterest(touch.Parent, v2, 1)
												firetouchinterest(touch.Parent, v2, 0)
											end
										elseif KillauraMethod.Value == "Normal" then
											for i,v2 in pairs(v.Character:GetChildren()) do 
												if v2:IsA("BasePart") then
													firetouchinterest(touch.Parent, v2, 1)
													firetouchinterest(touch.Parent, v2, 0)
												end
											end
										else
											firetouchinterest(touch.Parent, v.RootPart, 1)
											firetouchinterest(touch.Parent, v.RootPart, 0)
										end
									end
								end
							end
						end
						for i,v in pairs(KillauraBoxes) do 
							local attacked = attackedplayers[i]
							v.Adornee = attacked and attacked.RootPart
						end
						task.wait()
					until not Killaura.Enabled
				end)
			else
				RunLoops:UnbindFromHeartbeat("Killaura") 
                KillauraNearTarget = false
				vapeTargetInfo.Targets.Killaura = nil
				for i,v in pairs(KillauraBoxes) do v.Adornee = nil end
				if KillauraRangeCirclePart then KillauraRangeCirclePart.Parent = nil end
			end
		end,
		HoverText = "Attack players around you\nwithout aiming at them."
	})
	KillauraMethod = Killaura.CreateDropdown({
		Name = "Mode",
		List = {"Normal", "Bypass", "Root Only"},
		Function = function() end
	})
	KillauraCPS = Killaura.CreateTwoSlider({
		Name = "Attacks per second",
		Min = 1,
		Max = 20,
		Default = 8,
		Default2 = 12
	})
	KillauraRange = Killaura.CreateSlider({
		Name = "Attack range",
		Min = 1,
		Max = 150, 
		Function = function(val) 
			if KillauraRangeCirclePart then 
				KillauraRangeCirclePart.Size = Vector3.new(val * 0.7, 0.01, val * 0.7)
			end
		end
	})
	KillauraAngle = Killaura.CreateSlider({
		Name = "Max angle",
		Min = 1,
		Max = 360, 
		Function = function(val) end,
		Default = 90
	})
	KillauraColor = Killaura.CreateColorSlider({
		Name = "Target Color",
		Function = function(hue, sat, val) 
			for i,v in pairs(KillauraBoxes) do 
				v.Color3 = Color3.fromHSV(hue, sat, val)
			end
			if KillauraRangeCirclePart then 
				KillauraRangeCirclePart.Color = Color3.fromHSV(hue, sat, val)
			end
		end,
		Default = 1
	})
	KillauraButtonDown = Killaura.CreateToggle({
		Name = "Require mouse down", 
		Function = function() end
	})
	KillauraTarget = Killaura.CreateToggle({
        Name = "Show target",
        Function = function(callback) end,
		HoverText = "Shows a red box over the opponent."
    })
	KillauraPrediction = Killaura.CreateToggle({
		Name = "Prediction",
		Function = function() end
	})
	KillauraFakeAngle = Killaura.CreateToggle({
        Name = "Face target",
        Function = function() end,
		HoverText = "Makes your character face the opponent."
    })
	KillauraRangeCircle = Killaura.CreateToggle({
		Name = "Range Visualizer",
		Function = function(callback)
			if callback then 
				KillauraRangeCirclePart = Instance.new("MeshPart")
				KillauraRangeCirclePart.MeshId = "rbxassetid://3726303797"
				KillauraRangeCirclePart.Color = Color3.fromHSV(KillauraColor.Hue, KillauraColor.Sat, KillauraColor.Value)
				KillauraRangeCirclePart.CanCollide = false
				KillauraRangeCirclePart.Anchored = true
				KillauraRangeCirclePart.Material = Enum.Material.Neon
				KillauraRangeCirclePart.Size = Vector3.new(KillauraRange.Value * 0.7, 0.01, KillauraRange.Value * 0.7)
				KillauraRangeCirclePart.Parent = gameCamera
			else
				if KillauraRangeCirclePart then 
					KillauraRangeCirclePart:Destroy()
					KillauraRangeCirclePart = nil
				end
			end
		end
	})

	runFunction(function()
		pcall(GuiLibrary.RemoveObject, "NameTagsOptionsButton")
		pcall(function() GuiLibrary.MainGui.NameTagsFolder:Destroy() end)
		local function floorNameTagPosition(pos)
			return Vector2.new(math.floor(pos.X), math.floor(pos.Y))
		end
	
		local function removeTags(str)
			str = str:gsub("<br%s*/>", "\n")
			return (str:gsub("<[^<>]->", ""))
		end
	
		local NameTagsFolder = Instance.new("Folder")
		NameTagsFolder.Name = "NameTagsFolder"
		NameTagsFolder.Parent = GuiLibrary.MainGui
		local nametagsfolderdrawing = {}
		local NameTagsColor = {Value = 0.44}
		local NameTagsDisplayName = {Enabled = false}
		local NameTagsExtra = {Enabled = false}
		local NameTagsHealth = {Enabled = false}
		local NameTagsDistance = {Enabled = false}
		local NameTagsBackground = {Enabled = true}
		local NameTagsScale = {Value = 10}
		local NameTagsFont = {Value = "SourceSans"}
		local NameTagsTeammates = {Enabled = true}
		local fontitems = {"SourceSans"}
		local nametagstrs = {}
		local nametagsizes = {}
	
		local nametagfuncs1 = {
			Normal = function(plr)
				if NameTagsTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
				local thing = Instance.new("TextLabel")
				thing.BackgroundColor3 = Color3.new()
				thing.BorderSizePixel = 0
				thing.Visible = false
				thing.RichText = true
				thing.AnchorPoint = Vector2.new(0.5, 1)
				thing.Name = plr.Player.Name
				thing.Font = Enum.Font[NameTagsFont.Value]
				thing.TextSize = 14 * (NameTagsScale.Value / 10)
				thing.BackgroundTransparency = NameTagsBackground.Enabled and 0.5 or 1
				local forcefield = isAlive(plr.Player) and plr.Player.Character:FindFirstChildWhichIsA("ForceField")
				nametagstrs[plr.Player] = WhitelistFunctions:GetTag(plr.Player)..(VoidwareFunctions:GetLocalTag(plr.Player).Text)..(NameTagsDisplayName.Enabled and plr.Player.DisplayName or plr.Player.Name)
				if NameTagsHealth.Enabled then
					local color = Color3.fromHSV(math.clamp(plr.Humanoid.Health / plr.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
					nametagstrs[plr.Player] = nametagstrs[plr.Player]..' <font color="rgb('..tostring(math.floor(color.R * 255))..','..tostring(math.floor(color.G * 255))..','..tostring(math.floor(color.B * 255))..')">'..math.round(plr.Humanoid.Health).."</font>"
				end
				if NameTagsDistance.Enabled then 
					nametagstrs[plr.Player] = '<font color="rgb(85, 255, 85)">[</font><font color="rgb(255, 255, 255)">%s</font><font color="rgb(85, 255, 85)">]</font> '..nametagstrs[plr.Player]
				end
				local nametagSize = textService:GetTextSize(removeTags(nametagstrs[plr.Player]), thing.TextSize, thing.Font, Vector2.new(100000, 100000))
				thing.Size = UDim2.new(0, nametagSize.X + 4, 0, nametagSize.Y)
				thing.Text = nametagstrs[plr.Player]
				thing.TextColor3 = getPlayerColor(plr.Player) or Color3.fromHSV(NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
				thing.Parent = NameTagsFolder
				nametagsfolderdrawing[plr.Player] = {entity = plr, Main = thing}
			end,
			Drawing = function(plr)
				if NameTagsTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
				local thing = {Main = {}, entity = plr}
				thing.Main.Text = Drawing.new("Text")
				thing.Main.Text.Size = 17 * (NameTagsScale.Value / 10)
				thing.Main.Text.Font = (math.clamp((table.find(fontitems, NameTagsFont.Value) or 1) - 1, 0, 3))
				thing.Main.Text.ZIndex = 2
				thing.Main.BG = Drawing.new("Square")
				thing.Main.BG.Filled = true
				thing.Main.BG.Transparency = 0.5
				thing.Main.BG.Visible = NameTagsBackground.Enabled
				thing.Main.BG.Color = Color3.new()
				thing.Main.BG.ZIndex = 1
				nametagstrs[plr.Player] = WhitelistFunctions:GetTag(plr.Player)..(VoidwareFunctions:GetLocalTag(plr.Player).Text)..(NameTagsDisplayName.Enabled and plr.Player.DisplayName or plr.Player.Name)
				if NameTagsHealth.Enabled then
					local color = Color3.fromHSV(math.clamp(plr.Humanoid.Health / plr.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
					nametagstrs[plr.Player] = nametagstrs[plr.Player]..' '..math.round(plr.Humanoid.Health)
				end
				if NameTagsDistance.Enabled then 
					nametagstrs[plr.Player] = '[%s] '..nametagstrs[plr.Player]
				end
				thing.Main.Text.Text = nametagstrs[plr.Player]
				thing.Main.BG.Size = Vector2.new(thing.Main.Text.TextBounds.X + 4, thing.Main.Text.TextBounds.Y)
				thing.Main.Text.Color = getPlayerColor(plr.Player) or Color3.fromHSV(NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
				nametagsfolderdrawing[plr.Player] = thing
			end
		}
	
		local nametagfuncs2 = {
			Normal = function(ent)
				local v = nametagsfolderdrawing[ent]
				nametagsfolderdrawing[ent] = nil
				if v then 
					v.Main:Destroy()
				end
			end,
			Drawing = function(ent)
				local v = nametagsfolderdrawing[ent]
				nametagsfolderdrawing[ent] = nil
				if v then 
					for i2,v2 in pairs(v.Main) do
						pcall(function() v2.Visible = false v2:Remove() end)
					end
				end
			end
		}
	
		local nametagupdatefuncs = {
			Normal = function(ent)
				local v = nametagsfolderdrawing[ent.Player]
				if v then 
					nametagstrs[ent.Player] = WhitelistFunctions:GetTag(ent.Player)..(VoidwareFunctions:GetLocalTag(ent.Player).Text)..(NameTagsDisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name)
					if NameTagsHealth.Enabled then
						local color = Color3.fromHSV(math.clamp(ent.Humanoid.Health / ent.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
						nametagstrs[ent.Player] = nametagstrs[ent.Player]..' <font color="rgb('..tostring(math.floor(color.R * 255))..','..tostring(math.floor(color.G * 255))..','..tostring(math.floor(color.B * 255))..')">'..math.round(ent.Humanoid.Health).."</font>"
					end
					if NameTagsDistance.Enabled then 
						nametagstrs[ent.Player] = '<font color="rgb(85, 255, 85)">[</font><font color="rgb(255, 255, 255)">%s</font><font color="rgb(85, 255, 85)">]</font> '..nametagstrs[ent.Player]
					end
					local nametagSize = textService:GetTextSize(removeTags(nametagstrs[ent.Player]), v.Main.TextSize, v.Main.Font, Vector2.new(100000, 100000))
					v.Main.Size = UDim2.new(0, nametagSize.X + 4, 0, nametagSize.Y)
					v.Main.Text = nametagstrs[ent.Player]
				end
			end,
			Drawing = function(ent)
				local v = nametagsfolderdrawing[ent.Player]
				if v then 
					nametagstrs[ent.Player] = WhitelistFunctions:GetTag(ent.Player)..(VoidwareFunctions:GetLocalTag(ent.Player))..(NameTagsDisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name)
					if NameTagsHealth.Enabled then
						nametagstrs[ent.Player] = nametagstrs[ent.Player]..' '..math.round(ent.Humanoid.Health)
					end
					if NameTagsDistance.Enabled then 
						nametagstrs[ent.Player] = '[%s] '..nametagstrs[ent.Player]
						v.Main.Text.Text = entityLibrary.isAlive and string.format(nametagstrs[ent.Player], math.floor((entityLibrary.character.HumanoidRootPart.Position - ent.RootPart.Position).Magnitude)) or nametagstrs[ent.Player]
					else
						v.Main.Text.Text = nametagstrs[ent.Player]
					end
					v.Main.BG.Size = Vector2.new(v.Main.Text.TextBounds.X + 4, v.Main.Text.TextBounds.Y)
					v.Main.Text.Color = getPlayerColor(ent.Player) or Color3.fromHSV(NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
				end
			end
		}
	
		local nametagcolorfuncs = {
			Normal = function(hue, sat, value)
				local color = Color3.fromHSV(hue, sat, value)
				for i,v in pairs(nametagsfolderdrawing) do 
					v.Main.TextColor3 = getPlayerColor(v.entity.Player) or color
				end
			end,
			Drawing = function(hue, sat, value)
				local color = Color3.fromHSV(hue, sat, value)
				for i,v in pairs(nametagsfolderdrawing) do 
					v.Main.Text.Color = getPlayerColor(v.entity.Player) or color
				end
			end
		}
	
		local nametagloop = {
			Normal = function()
				for i,v in pairs(nametagsfolderdrawing) do 
					local headPos, headVis = worldtoscreenpoint((v.entity.RootPart:GetRenderCFrame() * CFrame.new(0, v.entity.Head.Size.Y + v.entity.RootPart.Size.Y, 0)).Position)
					if not headVis then 
						v.Main.Visible = false
						continue
					end
					if NameTagsDistance.Enabled and entityLibrary.isAlive then
						local mag = math.floor((entityLibrary.character.HumanoidRootPart.Position - v.entity.RootPart.Position).Magnitude)
						local stringsize = tostring(mag):len()
						if nametagsizes[v.entity.Player] ~= stringsize then 
							local nametagSize = textService:GetTextSize(removeTags(string.format(nametagstrs[v.entity.Player], mag)), v.Main.TextSize, v.Main.Font, Vector2.new(100000, 100000))
							v.Main.Size = UDim2.new(0, nametagSize.X + 4, 0, nametagSize.Y)
						end
						nametagsizes[v.entity.Player] = stringsize
						v.Main.Text = string.format(nametagstrs[v.entity.Player], mag)
					end
					v.Main.Position = UDim2.new(0, headPos.X, 0, headPos.Y)
					v.Main.Visible = true
				end
			end,
			Drawing = function()
				for i,v in pairs(nametagsfolderdrawing) do 
					local headPos, headVis = worldtoscreenpoint((v.entity.RootPart:GetRenderCFrame() * CFrame.new(0, v.entity.Head.Size.Y + v.entity.RootPart.Size.Y, 0)).Position)
					if not headVis then 
						v.Main.Text.Visible = false
						v.Main.BG.Visible = false
						continue
					end
					if NameTagsDistance.Enabled and entityLibrary.isAlive then
						local mag = math.floor((entityLibrary.character.HumanoidRootPart.Position - v.entity.RootPart.Position).Magnitude)
						local stringsize = tostring(mag):len()
						v.Main.Text.Text = string.format(nametagstrs[v.entity.Player], mag)
						if nametagsizes[v.entity.Player] ~= stringsize then 
							v.Main.BG.Size = Vector2.new(v.Main.Text.TextBounds.X + 4, v.Main.Text.TextBounds.Y)
						end
						nametagsizes[v.entity.Player] = stringsize
					end
					v.Main.BG.Position = Vector2.new(headPos.X - (v.Main.BG.Size.X / 2), (headPos.Y + v.Main.BG.Size.Y))
					v.Main.Text.Position = v.Main.BG.Position + Vector2.new(2, 0)
					v.Main.Text.Visible = true
					v.Main.BG.Visible = NameTagsBackground.Enabled
				end
			end
		}
	
		local methodused
	
		local NameTags = {Enabled = false}
		NameTags = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
			Name = "NameTags", 
			Function = function(callback) 
				if callback then
					methodused = NameTagsDrawing.Enabled and "Drawing" or "Normal"
					if nametagfuncs2[methodused] then
						table.insert(NameTags.Connections, entityLibrary.entityRemovedEvent:Connect(nametagfuncs2[methodused]))
					end
					if nametagfuncs1[methodused] then
						local addfunc = nametagfuncs1[methodused]
						for i,v in pairs(entityLibrary.entityList) do 
							if nametagsfolderdrawing[v.Player] then nametagfuncs2[methodused](v.Player) end
							addfunc(v)
						end
						table.insert(NameTags.Connections, entityLibrary.entityAddedEvent:Connect(function(ent)
							if nametagsfolderdrawing[ent.Player] then nametagfuncs2[methodused](ent.Player) end
							addfunc(ent)
						end))
					end
					if nametagupdatefuncs[methodused] then
						table.insert(NameTags.Connections, entityLibrary.entityUpdatedEvent:Connect(nametagupdatefuncs[methodused]))
						for i,v in pairs(entityLibrary.entityList) do 
							nametagupdatefuncs[methodused](v)
						end
					end
					if nametagcolorfuncs[methodused] then 
						table.insert(NameTags.Connections, GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.FriendColorRefresh.Event:Connect(function()
							nametagcolorfuncs[methodused](NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
						end))
					end
					if nametagloop[methodused] then 
						RunLoops:BindToRenderStep("NameTags", nametagloop[methodused])
					end
				else
					RunLoops:UnbindFromRenderStep("NameTags")
					if nametagfuncs2[methodused] then
						for i,v in pairs(nametagsfolderdrawing) do 
							nametagfuncs2[methodused](i)
						end
					end
				end
			end,
			HoverText = "Renders nametags on entities through walls."
		})
		for i,v in pairs(Enum.Font:GetEnumItems()) do 
			if v.Name ~= "SourceSans" then 
				table.insert(fontitems, v.Name)
			end
		end
		NameTagsFont = NameTags.CreateDropdown({
			Name = "Font",
			List = fontitems,
			Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		})
		NameTagsColor = NameTags.CreateColorSlider({
			Name = "Player Color", 
			Function = function(hue, sat, val) 
				if NameTags.Enabled and nametagcolorfuncs[methodused] then 
					nametagcolorfuncs[methodused](hue, sat, val)
				end
			end
		})
		NameTagsScale = NameTags.CreateSlider({
			Name = "Scale",
			Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
			Default = 10,
			Min = 1,
			Max = 50
		})
		NameTagsBackground = NameTags.CreateToggle({
			Name = "Background", 
			Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
			Default = true
		})
		NameTagsDisplayName = NameTags.CreateToggle({
			Name = "Use Display Name", 
			Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
			Default = true
		})
		NameTagsHealth = NameTags.CreateToggle({
			Name = "Health", 
			Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end
		})
		NameTagsDistance = NameTags.CreateToggle({
			Name = "Distance", 
			Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end
		})
		NameTagsTeammates = NameTags.CreateToggle({
			Name = "Teammates", 
			Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
			Default = true
		})
		NameTagsDrawing = NameTags.CreateToggle({
			Name = "Drawing",
			Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		})
	end)

	task.spawn(function()
		repeat task.wait()
		pcall(shared.VoidwareStore.UpdateTargetInfo, vapeTargetInfo.Targets.Killaura)
		until not vapeInjected or shared.VoidwareStore.ManualTargetUpdate
	end)
end)


local function switchItem(item, single)
	local didswitch = false
	if not lplr.Character then return didswitch end
	for i,v in pairs(localInventory.backpack) do 
		if v:IsA("Tool") and v.Name == item and localInventory.hotbar[v.Name] == nil then
			v.Parent = lplr.Character
			didswitch = true
			break
		end
	end
	if didswitch and single then 
		for i,v in pairs(localInventory.hotbar) do 
			if v.Name ~= item then
				v.Parent = lplr.Backpack
			end
		end
	end
	return didswitch
end

local function unequipItem(item)
	local didunequip = nil 
	for i,v in pairs(localInventory.hotbar) do 
		if v.Name == item then
			v.Parent = lplr.Backpack
			didunequip = true
		end
	end
	return didunequip
end

local function getItem(item, inventory)
	inventory = inventory or localInventory.hotbar
	for i,v in pairs(inventory) do
		if v.Name == item then
			return v
		end
	end
	return nil
end

task.spawn(function()
	repeat
		local inventory = {hotbar = {}, backpack = {}}
		if lplr.Character then 
			for i,v in pairs(lplr.Character:GetChildren()) do 
				if v:IsA("Tool") then 
					table.insert(inventory.hotbar, v)
				end
			end
		end
		if lplr:FindFirstChild("Backpack") then 
			for i,v in pairs(lplr.Backpack:GetChildren()) do 
				if v:IsA("Tool") then 
					table.insert(inventory.backpack, v)
				end
			end
	    end
	localInventory = inventory
	task.wait()
	until not vapeInjected
end)

pcall(function() getgenv().VoidwareFunctions = VoidwareFunctions end)

runFunction(function()
	local LightingTheme = {Enabled = false}
	local LightingThemeType = {Value = "LunarNight"}
	local themesky
	local themeobjects = {}
	local oldthemesettings = {
		Ambient = lightingService.Ambient,
		FogEnd = lightingService.FogEnd,
		FogStart = lightingService.FogStart,
		OutdoorAmbient = lightingService.OutdoorAmbient,
	}
	local themetable = {
		Purple = function()
			if themesky then
                themesky.SkyboxBk = "rbxassetid://8539982183"
                themesky.SkyboxDn = "rbxassetid://8539981943"
                themesky.SkyboxFt = "rbxassetid://8539981721"
                themesky.SkyboxLf = "rbxassetid://8539981424"
                themesky.SkyboxRt = "rbxassetid://8539980766"
                themesky.SkyboxUp = "rbxassetid://8539981085"
				lightingService.Ambient = Color3.fromRGB(170, 0, 255)
				themesky.MoonAngularSize = 0
                themesky.SunAngularSize = 0
                themesky.StarCount = 3e3
			end
		end,
		Galaxy = function()
			if themesky then
                themesky.SkyboxBk = "rbxassetid://159454299"
                themesky.SkyboxDn = "rbxassetid://159454296"
                themesky.SkyboxFt = "rbxassetid://159454293"
                themesky.SkyboxLf = "rbxassetid://159454293"
                themesky.SkyboxRt = "rbxassetid://159454293"
                themesky.SkyboxUp = "rbxassetid://159454288"
                lightingService.FogEnd = 200
                lightingService.FogStart = 0
				themesky.SunAngularSize = 0
				lightingService.OutdoorAmbient = Color3.fromRGB(172, 18, 255)
			end
		end,
		BetterNight = function()
			if themesky then
				themesky.SkyboxBk = "rbxassetid://155629671"
                themesky.SkyboxDn = "rbxassetid://12064152"
                themesky.SkyboxFt = "rbxassetid://155629677"
                themesky.SkyboxLf = "rbxassetid://155629662"
                themesky.SkyboxRt = "rbxassetid://155629666"
                themesky.SkyboxUp = "rbxassetid://155629686"
				lightingService.FogColor = Color3.new(0, 20, 64)
				themesky.SunAngularSize = 0
			end
		end,
		BetterNight2 = function()
			if themesky then
				themesky.SkyboxBk = "rbxassetid://248431616"
                themesky.SkyboxDn = "rbxassetid://248431677"
                themesky.SkyboxFt = "rbxassetid://248431598"
                themesky.SkyboxLf = "rbxassetid://248431686"
                themesky.SkyboxRt = "rbxassetid://248431611"
                themesky.SkyboxUp = "rbxassetid://248431605"
				themesky.StarCount = 3000
			end
		end,
		MagentaOrange = function()
			if themesky then
				themesky.SkyboxBk = "rbxassetid://566616113"
                themesky.SkyboxDn = "rbxassetid://566616232"
                themesky.SkyboxFt = "rbxassetid://566616141"
                themesky.SkyboxLf = "rbxassetid://566616044"
                themesky.SkyboxRt = "rbxassetid://566616082"
                themesky.SkyboxUp = "rbxassetid://566616187"
				themesky.StarCount = 3000
			end
		end,
		Purple2 = function()
			if themesky then
				themesky.SkyboxBk = "rbxassetid://8107841671"
				themesky.SkyboxDn = "rbxassetid://6444884785"
				themesky.SkyboxFt = "rbxassetid://8107841671"
				themesky.SkyboxLf = "rbxassetid://8107841671"
				themesky.SkyboxRt = "rbxassetid://8107841671"
				themesky.SkyboxUp = "rbxassetid://8107849791"
				themesky.SunTextureId = "rbxassetid://6196665106"
				themesky.MoonTextureId = "rbxassetid://6444320592"
				themesky.MoonAngularSize = 0
			end
		end,
		Galaxy2 = function()
			if themesky then
				themesky.SkyboxBk = "rbxassetid://14164368678"
				themesky.SkyboxDn = "rbxassetid://14164386126"
				themesky.SkyboxFt = "rbxassetid://14164389230"
				themesky.SkyboxLf = "rbxassetid://14164398493"
				themesky.SkyboxRt = "rbxassetid://14164402782"
				themesky.SkyboxUp = "rbxassetid://14164405298"
				themesky.SunTextureId = "rbxassetid://8281961896"
				themesky.MoonTextureId = "rbxassetid://6444320592"
				themesky.SunAngularSize = 0
				themesky.MoonAngularSize = 0
				lightingService.OutdoorAmbient = Color3.fromRGB(172, 18, 255)
			end
		end,
		Pink = function()
			if themesky then
		    themesky.SkyboxBk = "rbxassetid://271042516"
			themesky.SkyboxDn = "rbxassetid://271077243"
			themesky.SkyboxFt = "rbxassetid://271042556"
			themesky.SkyboxLf = "rbxassetid://271042310"
			themesky.SkyboxRt = "rbxassetid://271042467"
			themesky.SkyboxUp = "rbxassetid://271077958"
		end
	end,
	Purple3 = function()
		if themesky then
			themesky.SkyboxBk = "rbxassetid://433274085"
			themesky.SkyboxDn = "rbxassetid://433274194"
			themesky.SkyboxFt = "rbxassetid://433274131"
			themesky.SkyboxLf = "rbxassetid://433274370"
			themesky.SkyboxRt = "rbxassetid://433274429"
			themesky.SkyboxUp = "rbxassetid://433274285"
            lightingService.FogColor = Color3.new(170, 0, 255)
            lightingService.FogEnd = 200
            lightingService.FogStart = 0
		end
	end,
	DarkishPink = function()
		if themesky then
			themesky.SkyboxBk = "rbxassetid://570555736"
			themesky.SkyboxDn = "rbxassetid://570555964"
			themesky.SkyboxFt = "rbxassetid://570555800"
			themesky.SkyboxLf = "rbxassetid://570555840"
			themesky.SkyboxRt = "rbxassetid://570555882"
			themesky.SkyboxUp = "rbxassetid://570555929"
		end
	end,
	Space = function()
		themesky.MoonAngularSize = 0
		themesky.SunAngularSize = 0
		themesky.SkyboxBk = "rbxassetid://166509999"
		themesky.SkyboxDn = "rbxassetid://166510057"
		themesky.SkyboxFt = "rbxassetid://166510116"
		themesky.SkyboxLf = "rbxassetid://166510092"
		themesky.SkyboxRt = "rbxassetid://166510131"
		themesky.SkyboxUp = "rbxassetid://166510114"
	end,
	Galaxy3 = function()
		themesky.MoonAngularSize = 0
		themesky.SunAngularSize = 0
		themesky.SkyboxBk = "rbxassetid://14543264135"
		themesky.SkyboxDn = "rbxassetid://14543358958"
		themesky.SkyboxFt = "rbxassetid://14543257810"
		themesky.SkyboxLf = "rbxassetid://14543275895"
		themesky.SkyboxRt = "rbxassetid://14543280890"
		themesky.SkyboxUp = "rbxassetid://14543371676"
	end,
	NetherWorld = function()
		themesky.MoonAngularSize = 0
		themesky.SunAngularSize = 0
		themesky.SkyboxBk = "rbxassetid://14365019002"
		themesky.SkyboxDn = "rbxassetid://14365023350"
		themesky.SkyboxFt = "rbxassetid://14365018399"
		themesky.SkyboxLf = "rbxassetid://14365018705"
		themesky.SkyboxRt = "rbxassetid://14365018143"
		themesky.SkyboxUp = "rbxassetid://14365019327"
	end,
	Nebula = function()
		themesky.MoonAngularSize = 0
		themesky.SunAngularSize = 0
		themesky.SkyboxBk = "rbxassetid://5260808177"
		themesky.SkyboxDn = "rbxassetid://5260653793"
		themesky.SkyboxFt = "rbxassetid://5260817288"
		themesky.SkyboxLf = "rbxassetid://5260800833"
		themesky.SkyboxRt = "rbxassetid://5260811073"
		themesky.SkyboxUp = "rbxassetid://5260824661"
		lightingService.Ambient = Color3.fromRGB(170, 0, 255)
	end,
	PurpleNight = function()
		if themesky then
		themesky.MoonAngularSize = 0
		themesky.SunAngularSize = 0
		themesky.SkyboxBk = "rbxassetid://5260808177"
		themesky.SkyboxDn = "rbxassetid://5260653793"
		themesky.SkyboxFt = "rbxassetid://5260817288"
		themesky.SkyboxLf = "rbxassetid://5260800833"
		themesky.SkyboxRt = "rbxassetid://5260800833"
		themesky.SkyboxUp = "rbxassetid://5084576400"
		lightingService.Ambient = Color3.fromRGB(170, 0, 255)
		end
	end,
	Aesthetic = function()
		if themesky then
		themesky.MoonAngularSize = 0
		themesky.SunAngularSize = 0
		themesky.SkyboxBk = "rbxassetid://1417494030"
		themesky.SkyboxDn = "rbxassetid://1417494146"
		themesky.SkyboxFt = "rbxassetid://1417494253"
		themesky.SkyboxLf = "rbxassetid://1417494402"
		themesky.SkyboxRt = "rbxassetid://1417494499"
		themesky.SkyboxUp = "rbxassetid://1417494643"
		end
	end,
	Aesthetic2 = function()
		if themesky then
		themesky.MoonAngularSize = 0
		themesky.SunAngularSize = 0
		themesky.SkyboxBk = "rbxassetid://600830446"
		themesky.SkyboxDn = "rbxassetid://600831635"
		themesky.SkyboxFt = "rbxassetid://600832720"
		themesky.SkyboxLf = "rbxassetid://600886090"
		themesky.SkyboxRt = "rbxassetid://600833862"
		themesky.SkyboxUp = "rbxassetid://600835177"
		end
	end,
	Pastel = function()
		if themesky then
		themesky.SunAngularSize = 0
		themesky.MoonAngularSize = 0
		themesky.SkyboxBk = "rbxassetid://2128458653"
		themesky.SkyboxDn = "rbxassetid://2128462480"
		themesky.SkyboxFt = "rbxassetid://2128458653"
		themesky.SkyboxLf = "rbxassetid://2128462027"
		themesky.SkyboxRt = "rbxassetid://2128462027"
		themesky.SkyboxUp = "rbxassetid://2128462236"
		end
	end,
	PurpleClouds = function()
		if themesky then
		themesky.SkyboxBk = "rbxassetid://570557514"
		themesky.SkyboxDn = "rbxassetid://570557775"
		themesky.SkyboxFt = "rbxassetid://570557559"
		themesky.SkyboxLf = "rbxassetid://570557620"
		themesky.SkyboxRt = "rbxassetid://570557672"
		themesky.SkyboxUp = "rbxassetid://570557727"
		lightingService.Ambient = Color3.fromRGB(172, 18, 255)
		end
	end,
	BetterSky = function()
		if themesky then
		themesky.SkyboxBk = "rbxassetid://591058823"
		themesky.SkyboxDn = "rbxassetid://591059876"
		themesky.SkyboxFt = "rbxassetid://591058104"
		themesky.SkyboxLf = "rbxassetid://591057861"
		themesky.SkyboxRt = "rbxassetid://591057625"
		themesky.SkyboxUp = "rbxassetid://591059642"
		end
	end,
	BetterNight3 = function()
		if themesky then
		themesky.MoonTextureId = "rbxassetid://1075087760"
		themesky.SkyboxBk = "rbxassetid://2670643994"
		themesky.SkyboxDn = "rbxassetid://2670643365"
		themesky.SkyboxFt = "rbxassetid://2670643214"
		themesky.SkyboxLf = "rbxassetid://2670643070"
		themesky.SkyboxRt = "rbxassetid://2670644173"
		themesky.SkyboxUp = "rbxassetid://2670644331"
		themesky.MoonAngularSize = 1.5
		themesky.StarCount = 500
        pcall(function()
		local MoonColorCorrection = Instance.new("ColorCorrection")
		table.insert(themeobjects, MoonColorCorrection)
		MoonColorCorrection.Enabled = true
		MoonColorCorrection.TintColor = Color3.fromRGB(189, 179, 178)
		MoonColorCorrection.Parent = workspace
		local MoonBlur = Instance.new("BlurEffect")
		table.insert(themeobjects, MoonBlur)
		MoonBlur.Enabled = true
		MoonBlur.Size = 9
		MoonBlur.Parent = workspace
		local MoonBloom = Instance.new("BloomEffect")
		table.insert(themeobjects, MoonBloom)
		MoonBloom.Enabled = true
		MoonBloom.Intensity = 100
		MoonBloom.Size = 56
		MoonBloom.Threshold = 5
		MoonBloom.Parent = workspace
        end)
		end
	end,
	Orange = function()
		if themesky then
		themesky.SkyboxBk = "rbxassetid://150939022"
		themesky.SkyboxDn = "rbxassetid://150939038"
		themesky.SkyboxFt = "rbxassetid://150939047"
		themesky.SkyboxLf = "rbxassetid://150939056"
		themesky.SkyboxRt = "rbxassetid://150939063"
		themesky.SkyboxUp = "rbxassetid://150939082"
		end
	end,
	DarkMountains = function()
		if themesky then
			themesky.SkyboxBk = "rbxassetid://5098814730"
			themesky.SkyboxDn = "rbxassetid://5098815227"
			themesky.SkyboxFt = "rbxassetid://5098815653"
			themesky.SkyboxLf = "rbxassetid://5098816155"
			themesky.SkyboxRt = "rbxassetid://5098820352"
			themesky.SkyboxUp = "rbxassetid://5098819127"
		end
	end,
	FlamingSunset = function()
		if themesky then
		themesky.SkyboxBk = "rbxassetid://415688378"
		themesky.SkyboxDn = "rbxassetid://415688193"
		themesky.SkyboxFt = "rbxassetid://415688242"
		themesky.SkyboxLf = "rbxassetid://415688310"
		themesky.SkyboxRt = "rbxassetid://415688274"
		themesky.SkyboxUp = "rbxassetid://415688354"
		end
	end,
	NewYork = function()
		if themesky then
		themesky.SkyboxBk = "rbxassetid://11333973069"
		themesky.SkyboxDn = "rbxassetid://11333969768"
		themesky.SkyboxFt = "rbxassetid://11333964303"
		themesky.SkyboxLf = "rbxassetid://11333971332"
		themesky.SkyboxRt = "rbxassetid://11333982864"
		themesky.SkyboxUp = "rbxassetid://11333967970"
		themesky.SunAngularSize = 0
		end
	end,
	Aesthetic3 = function()
		if themesky then
		themesky.SkyboxBk = "rbxassetid://151165214"
		themesky.SkyboxDn = "rbxassetid://151165197"
		themesky.SkyboxFt = "rbxassetid://151165224"
		themesky.SkyboxLf = "rbxassetid://151165191"
		themesky.SkyboxRt = "rbxassetid://151165206"
		themesky.SkyboxUp = "rbxassetid://151165227"
		end
	end,
	FakeClouds = function()
		if themesky then
		themesky.SkyboxBk = "rbxassetid://8496892810"
		themesky.SkyboxDn = "rbxassetid://8496896250"
		themesky.SkyboxFt = "rbxassetid://8496892810"
		themesky.SkyboxLf = "rbxassetid://8496892810"
		themesky.SkyboxRt = "rbxassetid://8496892810"
		themesky.SkyboxUp = "rbxassetid://8496897504"
		themesky.SunAngularSize = 0
		end
	end,
	LunarNight = function()
		if themesky then
			themesky.SkyboxBk = "rbxassetid://187713366"
			themesky.SkyboxDn = "rbxassetid://187712428"
			themesky.SkyboxFt = "rbxassetid://187712836"
			themesky.SkyboxLf = "rbxassetid://187713755"
			themesky.SkyboxRt = "rbxassetid://187714525"
			themesky.SkyboxUp = "rbxassetid://187712111"
			themesky.SunAngularSize = 0
			themesky.StarCount = 0
		end
	end,
	PitchDark = function()
		themesky.StarCount = 0
		lightingService.TimeOfDay = "00:00:00"
		table.insert(LightingTheme.Connections, lightingService:GetPropertyChangedSignal("TimeOfDay"):Connect(function() -- brookhaven moment
			pcall(function()
			themesky.StarCount = 0
			lightingService.TimeOfDay = "00:00:00"
			end)
		end))
	end
}

LightingTheme = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
	Name = "LightingTheme",
	HoverText = "Add a whole new look to your game.",
	ExtraText = function() return LightingThemeType.Value end,
	Function = function(callback) 
		if callback then 
			task.spawn(function()
				task.wait()
				themesky = Instance.new("Sky")
				local success, err = pcall(themetable[LightingThemeType.Value])
				err = err and " | "..err or ""
				vapeAssert(success, "LightingTheme", "Failed to load the "..LightingThemeType.Value.." theme."..err, 5)
				themesky.Parent = success and lightingService or nil
				table.insert(LightingTheme.Connections, lightingService.ChildAdded:Connect(function(v)
					if success and v:IsA("Sky") then 
						v.Parent = nil
					end
				end))
			end)
		else
			if themesky then 
				themesky = pcall(function() themesky:Destroy() end)
				for i,v in pairs(themeobjects) do 
					pcall(function() v:Destroy() end)
				end
				table.clear(themeobjects)
				for i,v in pairs(lightingService:GetChildren()) do 
					if v:IsA("Sky") and themesky then 
						pcall(function()
							v.Parent = nil 
							v.Parent = lightingService
						end)
					end
				end
				for i,v in pairs(oldthemesettings) do 
					pcall(function() lightingService[i] = v end)
				end
			end
			themesky = nil
		end
	end
})
LightingThemeType = LightingTheme.CreateDropdown({
	Name = "Theme",
	List = dumptable(themetable, 1),
	Function = function()
		if LightingTheme.Enabled then 
			LightingTheme.ToggleButton(false)
			LightingTheme.ToggleButton(false)
		end
	end
})
end)

runFunction(function()
	local BubbleChat = {Enabled = false}
	local BubbleChatEnabled = {Enabled = true}
	local BubbleColorToggle = {Enabled = true}
	local BubbleTextSizeToggle = {Enabled = false}
	local BubbleDurationToggle = {Enabled = false}
	local BubbleTextColorToggle = {Enabled = false}
	local BubbleTextSize = {Value = 16}
	local BubbleColor = {Hue = 0, Sat = 0, Value = 0}
	local BubbleTextColor = {Hue = 0, Sat = 0, Value = 0}
	local oldbubblesettings = {
		Color = nil,
		TextSize = nil,
		Duration = nil,
		TextColor = nil
	}
	BubbleChat = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "ChatBubble",
		Approved = true,
		Function = function(callback)
			if callback then
				task.spawn(function()
					vapeAssert(replicatedStorageService:FindFirstChild("DefaultChatSystemChatEvents") == nil, "ChatBubble", "Legacy Chat System not supported.", 7, true, true, "ChatBubble")
					if oldbubblesettings.Color == nil then
					oldbubblesettings.Color = textChatService.BubbleChatConfiguration.BackgroundColor3
					end
					if oldbubblesettings.TextSize == nil then
						oldbubblesettings.TextSize = textChatService.BubbleChatConfiguration.TextSize
					end
					if oldbubblesettings.Duration == nil then
						oldbubblesettings.Duration = textChatService.BubbleChatConfiguration.BubbleDuration
					end
					if oldbubblesettings.TextColor == nil then
						oldbubblesettings.TextColor = textChatService.BubbleChatConfiguration.TextColor3
					end
					if BubbleColorToggle.Enabled then
					textChatService.BubbleChatConfiguration.BackgroundColor3 = Color3.fromHSV(BubbleColor.Hue, BubbleColor.Sat, BubbleColor.Value)
					end
					if BubbleTextSizeToggle.Enabled then
					textChatService.BubbleChatConfiguration.TextSize = BubbleTextSize.Value
					end
					if BubbleDurationToggle.Enabled then
					textChatService.BubbleChatConfiguration.BubbleDuration = BubbleDuration.Value
					end
					if BubbleTextColorToggle.Enabled then
						textChatService.BubbleChatConfiguration.TextColor3 = Color3.fromHSV(BubbleTextColor.Hue, BubbleTextColor.Sat, BubbleTextColor.Value)
					end
				end)
			else
				textChatService.BubbleChatConfiguration.BackgroundColor3 = oldbubblesettings.Color
				textChatService.BubbleChatConfiguration.TextSize = oldbubblesettings.TextSize
				textChatService.BubbleChatConfiguration.BubbleDuration = oldbubblesettings.Duration
				textChatService.BubbleChatConfiguration.TextColor3 = oldbubblesettings.TextColor
			end
		end,
		HoverText = "Customizable the bubble chat experience."
	})
	BubbleColorToggle = BubbleChat.CreateToggle({
		Name = "Background Color",
		HoverText = "apply a custom background color\nto chat bubbles.",
		Default = true,
		Function = function(callback)
			if BubbleChat.Enabled then
				BubbleChat.ToggleButton(false)
				BubbleChat.ToggleButton(false)
			end
		   pcall(function() BubbleColor.Object.Visible = callback end) 
		end
	})
	BubbleTextSizeToggle = BubbleChat.CreateToggle({
		Name = "Bubble Text Size",
		Function = function(callback)
			if BubbleChat.Enabled then
				BubbleChat.ToggleButton(false)
				BubbleChat.ToggleButton(false)
			end 
			pcall(function() BubbleTextSize.Object.Visible = callback end) 
		end
	})
	BubbleTextColorToggle = BubbleChat.CreateToggle({
		Name = "Bubble Text Color",
		Function = function(callback) 
			if BubbleChat.Enabled then
				BubbleChat.ToggleButton(false)
				BubbleChat.ToggleButton(false)
			end
		   pcall(function() BubbleTextColor.Object.Visible = callback end) 
		end
	})
	BubbleDurationToggle = BubbleChat.CreateToggle({
		Name = "Bubble Duration",
		Function = function(callback) 
			if BubbleChat.Enabled then
			BubbleChat.ToggleButton(false)
			BubbleChat.ToggleButton(false)
		end
		pcall(function() BubbleDuration.Object.Visible = callback end) 
	end
	})
	BubbleDuration = BubbleChat.CreateSlider({
		Name = "Duration",
		Min = 10,
		Max = 60,
		Function = function(val) 
		if BubbleChat.Enabled and BubbleDurationToggle.Enabled then
			textChatService.BubbleChatConfiguration.BubbleDuration = val
		end
	end
	})
	BubbleTextSize = BubbleChat.CreateSlider({
		Name = "Text Size",
		Min = 15,
		Max = 30,
		Function = function(val) 
		if BubbleChat.Enabled and BubbleTextSizeToggle.Enabled then
			textChatService.BubbleChatConfiguration.TextSize = val
		end
	end
	})
	BubbleColor = BubbleChat.CreateColorSlider({
		Name = "Bubble Color",
		Function = function(h, s, v)
			if BubbleChat.Enabled and BubbleColorToggle.Enabled then
				textChatService.BubbleChatConfiguration.BackgroundColor3 = Color3.fromHSV(h, s, v)
			end
		end
	})
	BubbleTextColor = BubbleChat.CreateColorSlider({
		Name = "Text Color",
		Function = function(h, s, v)
			if BubbleChat.Enabled and BubbleTextColorToggle.Enabled then
				textChatService.BubbleChatConfiguration.TextColor3 = Color3.fromHSV(h, s, v)
			end
		end
	})
	BubbleColor.Object.Visible = BubbleColorToggle.Enabled
	BubbleTextSize.Object.Visible = BubbleTextSizeToggle.Enabled
	BubbleDuration.Object.Visible = BubbleDurationToggle.Enabled
	BubbleTextColor.Object.Visible = BubbleTextColorToggle.Enabled
end)


runFunction(function()
	local PingDetector = {Enabled = false}
	local PingDetectorMaxping = {Value = 10000}
	local PingDetectorLeave = {Enabled = false}
	local pingdetected = false
	PingDetector = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "PingDetector",
		HoverText = "run actions whenever your pings reaches/goes over a certain level.",
		Function = function(callback)
			if callback then
				task.spawn(function()
					if not shared.VapeFullyLoaded then repeat task.wait() until shared.VapeFullyLoaded task.wait(5) end
					RunLoops:BindToHeartbeat("PingDetector", function()
						if pingdetected then return end
						if VoidwareStore.CurrentPing >= PingDetectorMaxping.Value then
							local pingstring = VoidwareStore.CurrentPing == PingDetectorMaxping.Value and "at" or "over"
							pingdetected = true
							warningNotification("PingDetector", "Your Game Ping is "..pingstring.." "..VoidwareStore.CurrentPing)
							if PingDetectorLeave.Enabled and PingDetectorMaxping.Value > 200 then
								local newserver = nil
								repeat newserver = findnewserver(nil, nil, nil, true) until newserver 
								game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, newserver, lplr)
							end
						end
					end)
				end)
			end
		end
	})
	PingDetectorMaxping = PingDetector.CreateSlider({
		Name = "Ping",
		Min = 60,
		Max = 10000,
		Default = 1000,
		Function = function() end
	})
	PingDetectorLeave = PingDetector.CreateToggle({
		Name = "ServerHop",
		HoverText = "Switches servers on detection.",
		Function = function() end
	})
end)

runFunction(function()
	local VapePrivateDetector = {Enabled = false}
	local VPLeave = {Enabled = false}
	local alreadydetected = {}
	VapePrivateDetector = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "VapePrivateDetector",
		Function = function(callback)
			if callback then
				task.spawn(function()
					if not WhitelistFunctions.Loaded then 
						repeat task.wait() until WhitelistFunctions.Loaded or not VapePrivateDetector.Enabled
					end
					if not VapePrivateDetector.Enabled then 
						return 
					end
					for i,v in pairs(playersService:GetPlayers()) do
						if v ~= lplr then
							local rank = WhitelistFunctions:GetWhitelist(v)
							if rank > 0 and not table.find(alreadydetected, v) then
								local rankstring = rank == 1 and "Private Member" or rank > 1 and "Owner"
								warningNotification("VapePrivateDetector", "Vape "..rankstring.." Detected! | "..v.DisplayName, 120)
								table.insert(alreadydetected, v)
								if VPLeave.Enabled then
									local newserver = nil
									repeat newserver = findnewserver() until newserver 
									game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, newserver, lplr)
								end
							end
						end
					end
					table.insert(VapePrivateDetector.Connections, playersService.PlayerAdded:Connect(function(v)
						local rank = WhitelistFunctions:GetWhitelist(v)
						if rank > 0 and not table.find(alreadydetected, v) then
						local rankstring = rank == 1 and "Private Member" or rank > 1 and "Owner"
						warningNotification("VapePrivateDetector", "Vape "..rankstring.." Detected! | "..v.DisplayName, 120)
						table.insert(alreadydetected, v)
						if VPLeave.Enabled then
							local newserver = nil
							repeat newserver = findnewserver() until newserver 
							game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, newserver, lplr)
						end
						end
					end))
				end)
			end
		end
	})
	VPLeave = VapePrivateDetector.CreateToggle({
		Name = "ServerHop",
		HoverText = "switches servers on detection.",
		Function = function() end
	})
	task.spawn(function()
		repeat task.wait() until WhitelistFunctions.Loaded 
		if WhitelistFunctions:GetWhitelist(lplr) ~= 0 then 
			pcall(GuiLibrary.RemoveObject, "VapePrivateDetectorOptionsButton")
		end
	end)
end)

runFunction(function()
	local AnimationChanger = {Enabled = false}
	local AnimFreeze = {Enabled = false}
	local AnimRun = {Value = "Robot"}
	local AnimWalk = {Value = "Robot"}
	local AnimJump = {Value = "Robot"}
	local AnimFall = {Value = "Robot"}
	local AnimIdle = {Value = "Robot"}
	local AnimIdleB = {Value = "Robot"}
	local Animate
	local oldanimations = {}
	local RunAnimations = {}
	local WalkAnimations = {}
	local FallAnimations = {}
	local JumpAnimations = {}
	local IdleAnimations = {}
	local IdleAnimationsB = {}
	local AnimList = {
		RunAnim = {
		["Cartoony"] = "http://www.roblox.com/asset/?id=10921082452",
		["Levitation"] = "http://www.roblox.com/asset/?id=10921135644",
		["Robot"] = "http://www.roblox.com/asset/?id=10921250460",
		["Stylish"] = "http://www.roblox.com/asset/?id=10921276116",
		["Superhero"] = "http://www.roblox.com/asset/?id=10921291831",
		["Zombie"] = "http://www.roblox.com/asset/?id=616163682",
		["Ninja"] = "http://www.roblox.com/asset/?id=10921157929",
		["Knight"] = "http://www.roblox.com/asset/?id=10921121197",
		["Mage"] = "http://www.roblox.com/asset/?id=10921148209",
		["Pirate"] = "http://www.roblox.com/asset/?id=750783738",
		["Elder"] = "http://www.roblox.com/asset/?id=10921104374",
		["Toy"] = "http://www.roblox.com/asset/?id=10921306285",
		["Bubbly"] = "http://www.roblox.com/asset/?id=10921057244",
		["Astronaut"] = "http://www.roblox.com/asset/?id=10921039308",
		["Vampire"] = "http://www.roblox.com/asset/?id=10921320299",
		["Werewolf"] = "http://www.roblox.com/asset/?id=10921336997",
		["Rthro"] = "http://www.roblox.com/asset/?id=10921261968",
		["Oldschool"] = "http://www.roblox.com/asset/?id=10921240218",
		["Toilet"] = "http://www.roblox.com/asset/?id=4417979645",
		["Rthro Heavy Run"] = "http://www.roblox.com/asset/?id=3236836670"
	},
	WalkAnim = {
		["Cartoony"] = "http://www.roblox.com/asset/?id=10921082452",
		["Levitation"] = "http://www.roblox.com/asset/?id=10921140719",
		["Robot"] = "http://www.roblox.com/asset/?id=10921255446",
		["Stylish"] = "http://www.roblox.com/asset/?id=10921283326",
		["Superhero"] = "http://www.roblox.com/asset/?id=10921298616",
		["Zombie"] = "http://www.roblox.com/asset/?id=10921355261",
		["Ninja"] = "http://www.roblox.com/asset/?id=10921162768",
		["Knight"] = "http://www.roblox.com/asset/?id=10921127095",
		["Mage"] = "http://www.roblox.com/asset/?id=10921152678",
		["Pirate"] = "http://www.roblox.com/asset/?id=750785693",
		["Elder"] = "http://www.roblox.com/asset/?id=10921111375",
		["Toy"] = "http://www.roblox.com/asset/?id=10921312010",
		["Bubbly"] = "http://www.roblox.com/asset/?id=10980888364",
		["Astronaut"] = "http://www.roblox.com/asset/?id=10921046031",
		["Vampire"] = "http://www.roblox.com/asset/?id=10921326949",
		["Werewolf"] = "http://www.roblox.com/asset/?id=10921342074",
		["Rthro"] = "http://www.roblox.com/asset/?id=10921269718",
		["Oldschool"] = "http://www.roblox.com/asset/?id=10921244891",
		["Ud'zal"] = "http://www.roblox.com/asset/?id=3303162967"
	},
	FallAnim = {
		["Cartoony"] = "http://www.roblox.com/asset/?id=10921077030",
		["Levitation"] = "http://www.roblox.com/asset/?id=10921136539",
		["Robot"] = "http://www.roblox.com/asset/?id=10921251156",
		["Stylish"] = "http://www.roblox.com/asset/?id=10921278648",
		["Superhero"] = "http://www.roblox.com/asset/?id=10921293373",
		["Zombie"] = "http://www.roblox.com/asset/?id=10921350320",
		["Ninja"] = "http://www.roblox.com/asset/?id=10921159222",
		["Knight"] = "http://www.roblox.com/asset/?id=10921122579",
		["Mage"] = "http://www.roblox.com/asset/?id=10921148939",
		["Pirate"] = "http://www.roblox.com/asset/?id=750780242",
		["Elder"] = "http://www.roblox.com/asset/?id=10921105765",
		["Toy"] = "http://www.roblox.com/asset/?id=10921307241",
		["Bubbly"] = "http://www.roblox.com/asset/?id=10921061530",
		["Astronaut"] = "http://www.roblox.com/asset/?id=10921040576",
		["Vampire"] = "http://www.roblox.com/asset/?id=10921321317",
		["Werewolf"] = "http://www.roblox.com/asset/?id=10921337907",
		["Rthro"] = "http://www.roblox.com/asset/?id=10921262864",
		["Oldschool"] = "http://www.roblox.com/asset/?id=10921241244"
	},
	JumpAnim = {
		["Cartoony"] = "http://www.roblox.com/asset/?id=10921078135",
		["Levitation"] = "http://www.roblox.com/asset/?id=10921137402",
		["Robot"] = "http://www.roblox.com/asset/?id=10921252123",
		["Stylish"] = "http://www.roblox.com/asset/?id=10921279832",
		["Superhero"] = "http://www.roblox.com/asset/?id=10921294559",
		["Zombie"] = "http://www.roblox.com/asset/?id=10921351278",
		["Ninja"] = "http://www.roblox.com/asset/?id=10921160088",
		["Knight"] = "http://www.roblox.com/asset/?id=10921123517",
		["Mage"] = "http://www.roblox.com/asset/?id=10921149743",
		["Pirate"] = "http://www.roblox.com/asset/?id=750782230",
		["Elder"] = "http://www.roblox.com/asset/?id=10921107367",
		["Toy"] = "http://www.roblox.com/asset/?id=10921308158",
		["Bubbly"] = "http://www.roblox.com/asset/?id=10921062673",
		["Astronaut"] = "http://www.roblox.com/asset/?id=10921042494",
		["Vampire"] = "http://www.roblox.com/asset/?id=10921322186",
		["Werewolf"] = "http://www.roblox.com/asset/?id=1083218792",
		["Rthro"] = "http://www.roblox.com/asset/?id=10921263860",
		["Oldschool"] = "http://www.roblox.com/asset/?id=10921242013",
	},
	Animation1 = {
		["Cartoony"] = "http://www.roblox.com/asset/?id=10921071918",
		["Levitation"] = "http://www.roblox.com/asset/?id=10921132962",
		["Robot"] = "http://www.roblox.com/asset/?id=10921248039",
		["Stylish"] = "http://www.roblox.com/asset/?id=10921272275",
		["Superhero"] = "http://www.roblox.com/asset/?id=10921288909",
		["Zombie"] = "http://www.roblox.com/asset/?id=10921344533",
		["Ninja"] = "http://www.roblox.com/asset/?id=10921155160",
		["Knight"] = "http://www.roblox.com/asset/?id=10921117521",
		["Mage"] = "http://www.roblox.com/asset/?id=10921144709",
		["Pirate"] = "http://www.roblox.com/asset/?id=750781874",
		["Elder"] = "http://www.roblox.com/asset/?id=10921101664",
		["Toy"] = "http://www.roblox.com/asset/?id=10921301576",
		["Bubbly"] = "http://www.roblox.com/asset/?id=10921054344",
		["Astronaut"] = "http://www.roblox.com/asset/?id=10921034824",
		["Vampire"] = "http://www.roblox.com/asset/?id=10921315373",
		["Werewolf"] = "http://www.roblox.com/asset/?id=10921330408",
		["Rthro"] = "http://www.roblox.com/asset/?id=10921258489",
		["Oldschool"] = "http://www.roblox.com/asset/?id=10921230744",
		["Toilet"] = "http://www.roblox.com/asset/?id=4417977954",
		["Ud'zal"] = "http://www.roblox.com/asset/?id=3303162274"
	},
	Animation2 = {
		["Cartoony"] = "http://www.roblox.com/asset/?id=10921072875",
		["Levitation"] = "http://www.roblox.com/asset/?id=10921133721",
		["Robot"] = "http://www.roblox.com/asset/?id=10921248831",
		["Stylish"] = "http://www.roblox.com/asset/?id=10921273958",
		["Superhero"] = "http://www.roblox.com/asset/?id=10921290167",
		["Zombie"] = "http://www.roblox.com/asset/?id=10921345304",
		["Ninja"] = "http://www.roblox.com/asset/?id=10921155867",
		["Knight"] = "http://www.roblox.com/asset/?id=10921118894",
		["Mage"] = "http://www.roblox.com/asset/?id=10921145797",
		["Pirate"] = "http://www.roblox.com/asset/?id=750782770",
		["Elder"] = "http://www.roblox.com/asset/?id=10921102574",
		["Toy"] = "http://www.roblox.com/asset/?id=10921302207",
		["Bubbly"] = "http://www.roblox.com/asset/?id=10921055107",
		["Astronaut"] = "http://www.roblox.com/asset/?id=10921036806",
		["Vampire"] = "http://www.roblox.com/asset/?id=10921316709",
		["Werewolf"] = "http://www.roblox.com/asset/?id=10921333667",
		["Rthro"] = "http://www.roblox.com/asset/?id=10921259953",
		["Oldschool"] = "http://www.roblox.com/asset/?id=10921232093",
		["Toilet"] = "http://www.roblox.com/asset/?id=4417978624",
		["Ud'zal"] = "http://www.roblox.com/asset/?id=3303162549",
	}
}
local function AnimateCharacter()
	Animate = lplr.Character or lplr.CharacterAdded:Wait()
	Animate = lplr.Character:WaitForChild("Animate")
	if AnimFreeze.Enabled and GetCurrentProfile() ~= "Ghost" then
		Animate.Enabled = false
	table.insert(AnimationChanger.Connections, lplr.Character.Humanoid.Animator.AnimationPlayed:Connect(function(anim)
		pcall(function() anim:Stop() end)
	end))
    end
	Animate.run.RunAnim.AnimationId = AnimList.RunAnim[AnimRun.Value]
	Animate.walk.WalkAnim.AnimationId = AnimList.WalkAnim[AnimWalk.Value]
	Animate.fall.FallAnim.AnimationId = AnimList.FallAnim[AnimFall.Value]
	Animate.jump.JumpAnim.AnimationId = AnimList.JumpAnim[AnimJump.Value]
	Animate.idle.Animation1.AnimationId = AnimList.Animation1[AnimIdle.Value]
	Animate.idle.Animation2.AnimationId = AnimList.Animation2[AnimIdleB.Value]
end
	AnimationChanger = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "AnimationChanger",
		Function = function(callback)
			if callback then
				task.spawn(function()
					if not isAlive() then repeat task.wait() until isAlive() end
					vapeAssert(lplr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15, "AnimationChanger", "R15 RigTypes only.", 7, true, true, "AnimationChanger")
					table.insert(AnimationChanger.Connections, lplr.CharacterAdded:Connect(function()
					if not isAlive() then repeat task.wait() until isAlive() end
					   pcall(AnimateCharacter)
					end))
					pcall(AnimateCharacter)
				end)
			else
				pcall(function() Animate.Enabled = true end)
				Animate = nil
			end
		end,
		HoverText = "customize your animations freely."
	})
	for i,v in pairs(AnimList.RunAnim) do table.insert(RunAnimations, i) end
	for i,v in pairs(AnimList.WalkAnim) do table.insert(WalkAnimations, i) end
	for i,v in pairs(AnimList.FallAnim) do table.insert(FallAnimations, i) end
	for i,v in pairs(AnimList.JumpAnim) do table.insert(JumpAnimations, i) end
	for i,v in pairs(AnimList.Animation1) do table.insert(IdleAnimations, i) end
	for i,v in pairs(AnimList.Animation2) do table.insert(IdleAnimationsB, i) end
	AnimRun = AnimationChanger.CreateDropdown({
		Name = "Run",
		List = RunAnimations,
		Function = function() 
			if AnimationChanger.Enabled then
				AnimationChanger.ToggleButton(false)
				AnimationChanger.ToggleButton(false)
			end
		end
	})
	AnimWalk = AnimationChanger.CreateDropdown({
		Name = "Walk",
		List = WalkAnimations,
		Function = function() 
			if AnimationChanger.Enabled then
				AnimationChanger.ToggleButton(false)
				AnimationChanger.ToggleButton(false)
			end
		end
	})
	AnimFall = AnimationChanger.CreateDropdown({
		Name = "Fall",
		List = FallAnimations,
		Function = function() 
			if AnimationChanger.Enabled then
				AnimationChanger.ToggleButton(false)
				AnimationChanger.ToggleButton(false)
			end
		end
	})
	AnimJump = AnimationChanger.CreateDropdown({
		Name = "Jump",
		List = JumpAnimations,
		Function = function() 
			if AnimationChanger.Enabled then
				AnimationChanger.ToggleButton(false)
				AnimationChanger.ToggleButton(false)
			end
		end
	})
	AnimIdle = AnimationChanger.CreateDropdown({
		Name = "Idle",
		List = IdleAnimations,
		Function = function() 
			if AnimationChanger.Enabled then
				AnimationChanger.ToggleButton(false)
				AnimationChanger.ToggleButton(false)
			end
		end
	})
	AnimIdleB = AnimationChanger.CreateDropdown({
		Name = "Idle 2",
		List = IdleAnimationsB,
		Function = function() 
			if AnimationChanger.Enabled then
				AnimationChanger.ToggleButton(false)
				AnimationChanger.ToggleButton(false)
			end
		end
	})
	AnimFreeze = AnimationChanger.CreateToggle({
		Name = "Freeze",
		HoverText = "Freezes all your animations",
		Function = function(callback)
			if AnimationChanger.Enabled then
				AnimationChanger.ToggleButton(false)
				AnimationChanger.ToggleButton(false)
			end
		end
	})
end)


runFunction(function()
	local attachexploit = {Enabled = false}
	local MaxAttachRange = {Value = 20}
	local attachexploitnpc = {Enabled = false}
	local attachexploitraycast = {Enabled = false}
	local attachexploitanimate = {Enabled = false}
	local playertween
	local target 
	attachexploit = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "PlayerAttach",
		NoSave = true,
		Function = function(callback)
			if callback then
				task.spawn(function()
					repeat
					target = FindTarget(MaxAttachRange.Value, nil, nil, nil, attachexploitnpc.Enabled, attachexploitraycast.Enabled)
					if not isAlive(lplr, true) or not target.RootPart or not isnetworkowner(lplr.Character.HumanoidRootPart) then
						attachexploit.ToggleButton(false)
						return
					end
					if lplr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then 
						lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					end
					if attachexploitanimate.Enabled then
						playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.23), {CFrame = target.RootPart.CFrame})
						playertween:Play()
					else
						lplr.Character.HumanoidRootPart.CFrame = target.RootPart.CFrame
					end
					task.wait()
					until not attachexploit.Enabled
				end)
			else
				pcall(function() playertween:Cancel() end)
				playertween = nil
				target = nil
			end
		end,
		HoverText = "Attach to the closest player in a certain range."
	})
	MaxAttachRange = attachexploit.CreateSlider({
		Name = "Max Range",
		Min = 10,
		Max = 50, 
		Function = function() end,
		Default = 20
	})
	attachexploitnpc = attachexploit.CreateToggle({
		Name = "NPC",
		HoverText = "Attaches to npcs designed by the game.",
		Function = function() end
	})
	attachexploitraycast = attachexploit.CreateToggle({
		Name = "Void Check",
		HoverText = "Doesn't target those in the void.",
		Function = function() end
	})
	attachexploitanimate = attachexploit.CreateToggle({
		Name = "Tween",
		HoverText = "Tweens u instead of teleporting",
		Function = function() end
	})
end)

runFunction(function()
	local Shader = {Enabled = false}
	local ShaderColor = {Hue = 0, Sat = 0, Value = 0}
	local ShaderTintSlider
	local ShaderBlur
	local ShaderTint
	local oldlightingsettings = {
		Brightness = lightingService.Brightness,
		ColorShift_Top = lightingService.ColorShift_Top,
		ColorShift_Bottom = lightingService.ColorShift_Bottom,
		OutdoorAmbient = lightingService.OutdoorAmbient,
		ClockTime = lightingService.ClockTime,
		ExposureCompensation = lightingService.ExposureCompensation,
		ShadowSoftness = lightingService.ShadowSoftness,
		Ambient = lightingService.Ambient
	}
	Shader = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
		Name = "RichShader",
		HoverText = "pro shader",
		Function = function(callback)
			if callback then 
				task.spawn(function()
					pcall(function()
					ShaderBlur = Instance.new("BlurEffect")
					ShaderBlur.Parent = lightingService
					ShaderBlur.Size = 4
					end)
					pcall(function()
						ShaderTint = Instance.new("ColorCorrectionEffect")
						ShaderTint.Parent = lightingService
						ShaderTint.Saturation = -0.2
						ShaderTint.TintColor = Color3.fromRGB(255, 224, 219)
					end)
					pcall(function()
						lightingService.ColorShift_Bottom = Color3.fromHSV(ShaderColor.Hue, ShaderColor.Sat, ShaderColor.Value)
						lightingService.ColorShift_Top = Color3.fromHSV(ShaderColor.Hue, ShaderColor.Sat, ShaderColor.Value)
						lightingService.OutdoorAmbient = Color3.fromHSV(ShaderColor.Hue, ShaderColor.Sat, ShaderColor.Value)
						lightingService.ClockTime = 8.7
						lightingService.FogColor = Color3.fromHSV(ShaderColor.Hue, ShaderColor.Sat, ShaderColor.Value)
						lightingService.FogEnd = 1000
						lightingService.FogStart = 0
						lightingService.ExposureCompensation = 0.24
						lightingService.ShadowSoftness = 0
						lightingService.Ambient = Color3.fromRGB(59, 33, 27)
					end)
				end)
			else
				pcall(function() ShaderBlur:Destroy() end)
				pcall(function() ShaderTint:Destroy() end)
				pcall(function()
				lightingService.Brightness = oldlightingsettings.Brightness
				lightingService.ColorShift_Top = oldlightingsettings.ColorShift_Top
				lightingService.ColorShift_Bottom = oldlightingsettings.ColorShift_Bottom
				lightingService.OutdoorAmbient = oldlightingsettings.OutdoorAmbient
				lightingService.ClockTime = oldlightingsettings.ClockTime
				lightingService.ExposureCompensation = oldlightingsettings.ExposureCompensation
				lightingService.ShadowSoftness = oldlightingsettings.ShadowSoftnesss
				lightingService.Ambient = oldlightingsettings.Ambient
				lightingService.FogColor = oldthemesettings.FogColor
				lightingService.FogStart = oldthemesettings.FogStart
				lightingService.FogEnd = oldthemesettings.FogEnd
				end)
			end
		end
	})	
	ShaderColor = Shader.CreateColorSlider({
		Name = "Main Color",
		Function = function(h, s, v)
			if Shader.Enabled then 
				pcall(function()
					lightingService.ColorShift_Bottom = Color3.fromHSV(h, s, v)
					lightingService.ColorShift_Top = Color3.fromHSV(h, s, v)
					lightingService.OutdoorAmbient = Color3.fromHSV(h, s, v)
					lightingService.FogColor = Color3.fromHSV(h, s, v)
				end)
			end
		end
	})
end)

runFunction(function()
	local PlayerTP = {Enabled = false}
	local PlayerTPSortMethod = {Value = "Distance"}
	local PlayerTPWhitelist = {Value = "All"}
	local PlayerTPDelayMethod = {Value = "Instant"}
	local PlayerTPMode = {Value = "Teleport"}
	local playertween
	local target = {}
	local isteleporting = false
	local function playertpteleportfunc()
		if not isAlive() then repeat task.wait() until isAlive() end
		target = FindTarget(nil, PlayerTPSortMethod.Value == "Health", PlayerTPWhitelist.Value == "Team", PlayerTPWhitelist.Value == "Enemy")
		if not target.RootPart then PlayerTP.ToggleButton(false) return end
		if lplr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then 
			lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			task.wait()
		end
		if PlayerTPMode.Value == "Teleport" then
			lplr.Character.HumanoidRootPart.CFrame = target.RootPart.CFrame
			PlayerTP.ToggleButton(false)
		else
			playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quad), {CFrame = CFrame.new(target.RootPart.Position) + Vector3.new(0, 2, 0)})
			playertween:Play()
			VoidwareStore.Tweening = true
			isteleporting = true
			playertween.Completed:Wait()
			VoidwareStore.Tweening = false
			isteleporting = false
			task.spawn(InfoNotification, "PlayerTP", "Tweened to "..target.Player.DisplayName..".", 7)
			PlayerTP.ToggleButton(false)
		end
	end
	PlayerTP = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
		Name = "PlayerTP",
		NoSave = true,
		Function = function(callback) 
			if callback then
				task.spawn(function()
					target = FindTarget(nil, PlayerTPSortMethod.Value == "Health", PlayerTPWhitelist.Value == "Team", PlayerTPWhitelist.Value == "Enemy")
					if not isAlive(lplr, true) and PlayerTPSortMethod.Value == "Instant" or not target.RootPart or isteleporting then PlayerTP.ToggleButton(false) return end
					if PlayerTPDelayMethod.Value == "Instant" then
						task.spawn(playertpteleportfunc)
					else
						if isAlive() then
							lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
							lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
						end
						table.insert(PlayerTP.Connections, lplr.CharacterAdded:Connect(playertpteleportfunc))
					end
				end)
			else
				pcall(function() playertween:Cancel() end)
				playertween = nil
			end
		end
	})
	PlayerTPSortMethod = PlayerTP.CreateDropdown({
		Name = "Method",
		List = {"Distance", "Health"},
		Function = function() end
	})
	PlayerTPWhitelist = PlayerTP.CreateDropdown({
		Name = "Whitelist",
		List = {"All", "Team", "Enemy"},
		Function = function() end
	})
	PlayerTPDelayMethod = PlayerTP.CreateDropdown({
		Name = "Delay Method",
		List = {"Instant", "Respawn"},
		Function = function() end
	})
	PlayerTPMode = PlayerTP.CreateDropdown({
		Name = "Teleport Method",
		List = {"Teleport", "Tween"},
		Function = function() end
	})
end)

runFunction(function()
	local FakeLag = {Enabled = false}
	local tweenmoduleEnabled
	local LagRepeatDelay = {Value = 0.20}
	FakeLag = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "FakeLag",
		HoverText = "real lag FE",
		Function = function(callback)
			if callback then
				task.spawn(function()
					local oldvalue = LagRepeatDelay.Value
					repeat task.wait(LagRepeatDelay.Value)
					if LagRepeatDelay.Value ~= oldvalue or not FakeLag.Enabled then return end
					pcall(function()
					if not GuiLibrary.ObjectsThatCanBeSaved.FlyOptionsButton.Api.Enabled and not VoidwareStore.Tweening then
					lplr.Character.HumanoidRootPart.Anchored = true
					task.wait(0.1)
					lplr.Character.HumanoidRootPart.Anchored = false
					else
					lplr.Character.HumanoidRootPart.Anchored = true
					end
					end)
					until not FakeLag.Enabled
				end)
			else
				pcall(function() lplr.Character.HumanoidRootPart.Anchored = false end)
			end
		end
	})
	LagRepeatDelay = FakeLag.CreateSlider({
		Name = "Delay",
		Min = 1,
		Max = 10,
		Function = function()
		if FakeLag.Enabled then
			FakeLag.ToggleButton(false)
			FakeLag.ToggleButton(false)
		 end
	 end
	})
 end)

 runFunction(function()
	local lastToggled = tick()
	local SmoothHighJump = {Enabled = false}
	local SmoothJumpTick = {Value = 5}
	local SmoothJumpTime = {Value = 1.2}
	local boostTick = 5
	SmoothHighJump = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
	Name = "BoostHighJump",
	Function = function(callback)
		if callback then
			task.spawn(function()
				if tick() >= lastToggled then 
					lastToggled = tick() + SmoothJumpTime.Value
				end
				repeat
				if not isAlive() or not isnetworkowner(entityLibrary.character.HumanoidRootPart) then
					 SmoothHighJump.ToggleButton(false) 
					 return 
				end
				if tick() > lastToggled then
					SmoothHighJump.ToggleButton(false) 
					return 
				end
				lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, boostTick, 0)
				boostTick = boostTick + SmoothJumpTick.Value
				if VoidwareStore.jumpTick <= tick() then
				   VoidwareStore.jumpTick = tick() + 3
				end
				task.wait()
				until not SmoothHighJump.Enabled
			end)
		else
			lastToggled = tick()
			VoidwareStore.jumpTick = tick() + (boostTick / 30)
			boostTick = 5
		end
	end
})
SmoothJumpTick = SmoothHighJump.CreateSlider({
	Name = "Power",
	Min = 2,
	Max = 10,
	Default = 3,
	Function = function() end
})
SmoothJumpTime = SmoothHighJump.CreateSlider({
	Name = "Time",
	Min = 0.2,
	Max = 2,
	Default = 1.2,
	Function = function() end
})
end)

runFunction(function()
	local FlyTP = {Enabled = false}
	local FlyTPVertical = {Value = 15}
	FlyTP = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "FlyTP",
		NoSave = true,
		Function = function(callback)
			if callback then 
				task.spawn(function()
					repeat 
					   if not isAlive() or not isnetworkowner(lplr.Character.HumanoidRootPart) then
						   FlyTP.ToggleButton(false) 
						   return 
					   end
					   if isEnabled("InfiniteFly") then 
						   FlyTP.ToggleButton(false)
						   return 
					   end
					  lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, FlyTPVertical.Value <= 0 and 0.01 or FlyTPVertical.Value, 0)
					  lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1, 0)
					  task.wait(0.1)
					until not FlyTP.Enabled
				end)
			end
		end
	})
	FlyTPVertical = FlyTP.CreateSlider({
		Name = "Vertical",
		Min = 15,
		Max = 60,
		Function = function() end
	})
end)

runFunction(function()
	local InfiniteYield = {Enabled = false}
	InfiniteYield = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "InfiniteYield",
		HoverText = "Loads the Infinite Yield script.",
		Function = function(callback)
			if callback then 
				task.spawn(function()
					loadstring(VoidwareFunctions:GetFile("data/BetterIY.lua"))()
				end)
			end
		end
	})
end)

runFunction(function()
	pcall(function()
	local Rejoin = GuiLibrary.ObjectsThatCanBeSaved.MatchMakingWindow.Api.CreateOptionsButton({
		Name = "Rejoin",
		Function = function(callback)
			if callback then
				task.spawn(function()
					game:GetService("TeleportService"):Teleport(game.PlaceId)
				end)
			end
		end
	})
end)
end)

runFunction(function()
	local InfiniteJump = {Enabled = false}
	local InfiniteJumpMode = {Value = "Hold"}
	local InfiniteJumpBoost = {Value = 2}
	InfiniteJump = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "InfiniteJump",
		HoverText = "Jump freely with no limitations.",
		Function = function(callback)
			if callback then
				task.spawn(function()
					table.insert(InfiniteJump.Connections, inputService.JumpRequest:Connect(function()
					if InfiniteJumpMode.Value == "Hold" then
						if isAlive(lplr) and isnetworkowner(lplr.Character.HumanoidRootPart) then
						   lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						   VoidwareStore.jumpTick = tick() + 0.30
						end
					end
				end))
				table.insert(InfiniteJump.Connections, inputService.InputBegan:Connect(function(input)
					if InfiniteJumpMode.Value == "Single" and input.KeyCode == Enum.KeyCode.Space and not inputService:GetFocusedTextBox() then
						if isAlive(lplr) and isnetworkowner(lplr.Character.HumanoidRootPart) then
						lplr.Character.HumanoidRootPart.Velocity = Vector3.new(lplr.Character.HumanoidRootPart.Velocity.X, (lplr.Character.Humanoid.JumpPower or 50) + InfiniteJumpBoost.Value, lplr.Character.HumanoidRootPart.Velocity.Z)
						VoidwareStore.jumpTick = tick() + (lplr.Character.Humanoid.JumpPower / 100)
						end
					end
				end))
			end)
		  end
	   end
	})
	if not VoidwareStore.MobileInUse then
	InfiniteJumpMode = InfiniteJump.CreateDropdown({
		Name = "Mode",
		List = {"Single", "Hold"},
		Function = function(callback) pcall(function() InfiniteJumpBoost.Object.Visible = callback == "Single" end) end
	})
    end 
	InfiniteJumpBoost = InfiniteJump.CreateSlider({
		Name = "Extra Jump Height",
		Min = 0,
		Max = 30,
		Default = 1,
		Function = function() end
	})
	InfiniteJumpBoost.Object.Visible = InfiniteJumpMode.Value == "Single"
end)

runFunction(function()
	local HealthNotifications = {Enabled = false}
	local HealthSlider = {Value = 50}
	local HealthSound = {Enabled = false}
	local oldhealth = 0
	local strikedhealth
	HealthNotifications = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "HealthNotifications",
		HoverText = "runs actions whenever your health was under threshold.",
		ExtraText = function() return "Vanilla" end,
		Function = function(callback)
			if callback then
				task.spawn(function()
					repeat task.wait() until isAlive()
					if not HealthNotifications.Enabled then return end
					table.insert(HealthNotifications.Connections, lplr.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
						if not isAlive() then return end
						local health = lplr.Character.Humanoid.Health
						local maxhealth = lplr.Character.Humanoid.MaxHealth
						if health == oldhealth then return end
						oldhealth = health
						if strikedhealth and health > strikedhealth then strikedhealth = nil end
						if strikedhealth and health <= strikedhealth then return end
						if health < maxhealth and health <= HealthSlider.Value then
							task.spawn(function()
								if not HealthSound.Enabled then return end
								local sound = Instance.new("Sound")
								sound.PlayOnRemove = true
								sound.SoundId = "rbxassetid://7396762708"
								sound:Destroy()
							end)
							strikedhealth = health + 10
							local healthcheck = health < HealthSlider.Value and "below" or "at"
							InfoNotification("HealthNotifications", "Your health is "..healthcheck.." "..HealthSlider.Value, 10)
						end
					end))
					table.insert(HealthNotifications.Connections, lplr.CharacterAdded:Connect(function()
						HealthNotifications.ToggleButton(false)
						HealthNotifications.ToggleButton(false)
					end))
				end)
			else
				strikedhealth = nil
				oldhealth = 0
			end
		end
	})
	HealthSlider = HealthNotifications.CreateSlider({
		Name = "Health",
		Min = 5,
		Max = 80,
		Default = 30,
		Function = function() end
	})
	HealthSound = HealthNotifications.CreateToggle({
		Name = "Sound",
		HoverText = "Plays an alarm sound on trigger.",
		Default = true,
		Function = function() end
	})
end)

runFunction(function()
	pcall(GuiLibrary.RemoveObject, "AntiLoggerOptionsButton")
	local AntiLogger = {Enabled = false}
	AntiLogger = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "AntiLogger",
		HoverText = "Stops most: IP loggers, and Discord webhooks.",
		Function = function(callback)
			if callback then
				task.spawn(function()
					if shared.AntiLogger then 
						return 
					end
					loadstring(VoidwareFunctions:GetFile("data/antilogger.lua"))()
				end)
			end
		end
	})
end)

runFunction(function()
	local AutoRejoin = {Enabled = false}
	local AutoRejoinServerSwitch = {Enabled = false}
	local AutoRejoinKick = {Enabled = false}
	local AutoRejoinSmallServers = {Enabled = false}
	local AutoRejoinsPlayersToRejoinOn = {Value = 1}
	local isfindingserver = false
	AutoRejoin = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "AutoRejoin",
		HoverText = "Automatically rejoins a server.",
		Function = function(callback)
			if callback then
				task.spawn(function()
					repeat task.wait() until shared.VapeFullyLoaded
					local kickoverlay = game:GetService("CoreGui"):WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay")
					if not AutoRejoin.Enabled then return end
					table.insert(AutoRejoin.Connections, kickoverlay.DescendantAdded:Connect(function(v)
						if v.Name == "ErrorMessage" then 
						local newserver = nil 
						repeat newserver = AutoRejoinServerSwitch.Enabled and findnewserver() or game.JobId and tostring(game.JobId) task.wait() until newserver
						InfoNotification("AutoRejoin", "Joining a new server..", 5)
						game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, newserver, lplr)
						end
					end))
					table.insert(AutoRejoin.Connections, runService.Heartbeat:Connect(function()
						if not AutoRejoinSmallServers.Enabled or isfindingserver then return end 
						if #playersService:GetPlayers() <= (AutoRejoinsPlayersToRejoinOn.Value + 1) then
							isfindingserver = true
							local newserver = nil
							InfoNotification("AutoRejoin", "Searching for a new server..", 5)
							repeat newserver = findnewserver(nil, nil, true) task.wait() until newserver
							if AutoRejoin.Enabled and AutoRejoinSmallServers.Enabled then
								InfoNotification("AutoRejoin", "Server Found! Joining..", 5)
								game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, newserver, lplr)
							end
						end
					end))
				end)
			end
		end
	})
	AutoRejoinSmallServers = AutoRejoin.CreateToggle({
		Name = "Switch Servers",
		HoverText = "Switches servers instead of rejoining",
		Default = true,
		Function = function() end
	})
	AutoRejoinSmallServers = AutoRejoin.CreateToggle({
		Name = "Server Size",
		HoverText = "Rejoins the game when the server\nreaches a certain player size.",
		Function = function(callback) 
			pcall(function() AutoRejoinsPlayersToRejoinOn.Object.Visible = callback end)
			if not callback then 
				isfindingserver = false 
			end
		end
	})
	AutoRejoinsPlayersToRejoinOn = AutoRejoin.CreateSlider({
		Name = "Amount of Players",
		Min = 0,
		Max = (tonumber(playersService.MaxPlayers) < 50 and tonumber(playersService.MaxPlayers) - 4) or 25,
		Function = function() end
	})
	AutoRejoinsPlayersToRejoinOn.Object.Visible = AutoRejoinSmallServers.Enabled
end)

runFunction(function()
	local ServerHop = {Enabled = false}
	local ServerHopBestServer = {Enabled = false}
	local isfindingserver = false
	ServerHop = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "ServerHop",
		HoverText = "Tempts to find and join a new server.",
		NoSave = true,
		Function = function(callback)
			if callback then 
				task.spawn(function()
					ServerHop.ToggleButton(false)
					if isfindingserver then 
						return 
					end
					local server = nil 
					InfoNotification("ServerHop", "Searching for a new server..", 10)
					repeat server = findnewserver(false, true, ServerHopBestServer.Enabled) until server 
					InfoNotification("ServerHop", "Server Found! Joining...", 10)
					game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server, lplr)
				end)
			end
		end
	})
	ServerHopBestServer = ServerHop.CreateToggle({
		Name = "Most Active",
		HoverText = "Picks the most active servers.",
		Default = true,
		Function = function() end
	})
end)

runFunction(function()
	local FPSBoost = {Enabled = false}
	local oldtextures = {}
	local oldmeshtextures = {}
	local oldspecialmeshtextures = {}
	local oldpartmaterials = {}
	local function applyfpsboostsettings(v)
		if v:IsA("Texture") then    
			oldtextures[v] = {object = v, texture = v.Texture}
			v.Texture = ""
			table.insert(FPSBoost.Connections, v:GetPropertyChangedSignal("Texture"):Connect(function()
				v.Texture = ""
			end))
		end
		if v:IsA("MeshPart") then 
			oldmeshtextures[v] = {object = v, texture = v.TextureID, material = v.Material}
			v.TextureID = ""
			table.insert(FPSBoost.Connections, v:GetPropertyChangedSignal("TextureID"):Connect(function()
				v.TextureID = ""
			end))
			v.Material = Enum.Material.SmoothPlastic
		end
		if v:IsA("SpecialMesh") then
			oldspecialmeshtextures[v] = {object = v, texture = v.TextureId}
			v.TextureId = ""
			table.insert(FPSBoost.Connections, v:GetPropertyChangedSignal("TextureId"):Connect(function()
				v.TextureId = ""
			end))
		end 
		if v:IsA("Part") then
			oldpartmaterials[v] = {object = v, color = v.Color, material = v.Material}
			v.Material = Enum.Material.SmoothPlastic
			v.Color = Color3.fromRGB(255, 255, 255)
			table.insert(FPSBoost.Connections, v:GetPropertyChangedSignal("Color"):Connect(function()
				v.Color = Color3.fromRGB(255, 255, 255)
			end))
		end
		if v:IsA("UnionOperation") then 
			oldpartmaterials[v] = {object = v, color = v.Color, material = v.Material}
			v.Material = Enum.Material.SmoothPlastic
			v.Color = Color3.fromRGB(255, 255, 255)
			table.insert(FPSBoost.Connections, v:GetPropertyChangedSignal("Color"):Connect(function()
				v.Color = Color3.fromRGB(255, 255, 255)
			end))
		end
	end
	FPSBoost = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "PerformanceBooster",
		HoverText = "Removes textures to give u a slight performance boost.",
		Function = function(callback)
			if callback then
				task.spawn(function()
					for i,v in pairs(workspace:GetDescendants()) do 
						if not isDescendantOfCharacter(v) then
						task.spawn(applyfpsboostsettings, v)
						end
					end
					table.insert(FPSBoost.Connections, workspace.DescendantAdded:Connect(function(object)
						if not isDescendantOfCharacter(v) then
						task.spawn(applyfpsboostsettings, object)
						end
					end))
				end)
			else
				for i,v in pairs(oldtextures) do 
					pcall(function() v.object.Texture = v.texture end)
					oldtextures[i] = nil
				end
				for i,v in pairs(oldspecialmeshtextures) do 
					pcall(function() v.object.TextureId = v.texture end)
					oldspecialmeshtextures[i] = nil
				end
				for i,v in pairs(oldmeshtextures) do 
					pcall(function() v.object.TextureID = v.texture end)
					pcall(function() v.object.Material = v.material end)
					oldmeshtextures[i] = nil
				end
				for i,v in pairs(oldpartmaterials) do 
					pcall(function() v.object.Color = v.color end)
					pcall(function() v.object.Material = v.material end)
					oldpartmaterials[i] = nil
				end
			end
		end
	})
end)

runFunction(function()
	local ChatTroll = {Enabled = false}
	local messageticks = {}
	local blacklistedwords = {"niga", "niger", "retard", "ah"}
	local saidmessages = {}
	local function bindchatfunction(plr)
		messageticks[plr] = tick()
		saidmessages[plr] = saidmessages[plr] or {}
		table.insert(ChatTroll.Connections, plr.Chatted:Connect(function(message)
			if isEnabled("ChatSpammer") then return end
			if messageticks[plr] and messageticks[plr] > tick() then 
				return 
			end
			if saidmessages[plr][message] then 
				return 
			end
			for i,v in pairs({"hack", "exploit"}) do 
				if message:lower():find(v) and (message:lower():find("i'm") or message:lower():find("me") or message:lower():find("i am")) then
					return 
				end
			end
			local newmessage = "["..plr.DisplayName.."]: "..message
			for i,v in pairs(blacklistedwords) do 
				if newmessage:lower():find(v:lower()) then 
					return
				end
			end
			sendchatmessage(newmessage:gsub("/w", "/privatemessage"))
			saidmessages[plr][message] = true
			messageticks[plr] = tick() + 0.45
		end))
	end
	ChatTroll = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "ChatTroll",
		HoverText = "Repeats others in chat.",
		Function = function(callback)
			if callback then
				task.spawn(function()
					if textChatService.ChatVersion == Enum.ChatVersion.TextChatService then 
						table.insert(ChatTroll.Connections, textChatService.MessageReceived:Connect(function(messagetab)
							task.wait(0.1)
							if isEnabled("ChatSpammer") then return end
							local plr = ({pcall(function() return playersService:GetPlayerByUserId(messagetab.TextSource.UserId) end)})[2]
							plr = type(plr) == "userdata" and plr or nil
							if plr and plr ~= lplr and messagetab.Text then 
								saidmessages[plr] = saidmessages[plr] or {}
								if messageticks[plr] and messageticks[plr] > tick() then 
									return 
								end
								if saidmessages[plr][messagetab.Text] then 
									return 
								end
								local newmessage = "["..plr.DisplayName.."]: "..messagetab.Text
								for i,v in pairs(blacklistedwords) do 
									if newmessage:lower():find(v:lower()) then 
										return
									end
								end
								sendchatmessage(newmessage:gsub("/w", "/privatemessage"))
								saidmessages[plr][messagetab.Text] = true
								messageticks[plr] = tick() + 0.45
							end
						end))
					else
						for i,v in pairs(playersService:GetPlayers()) do 
							if v ~= lplr then
								task.spawn(bindchatfunction, v)
						    end
						end
						table.insert(ChatTroll.Connections, playersService.PlayerAdded:Connect(bindchatfunction))
					end
				end)
			end
		end
	})
end)

runFunction(function()
	local cameraunlock = {Enabled = false}
	local cameraunlockdistance = {Value = 14}
	local oldzoomdistance = 14
	cameraunlock = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "CameraUnlocker",
		HoverText = "Unlock your camera's zoom distance.",
		Function = function(callback)
			if callback then
				task.spawn(function()
					local camera, attribute = pcall(function() return lplr.CameraMaxZoomDistance end)
					if not camera then repeat camera, attribute = pcall(function() return lplr.CameraMaxZoomDistance end) task.wait() until camera and attribute end
					oldzoomdistance = attribute
					lplr.CameraMaxZoomDistance = cameraunlockdistance.Value
				end)
			else
				pcall(function() lplr.CameraMaxZoomDistance = oldzoomdistance end)
			end
		end
	})
	oldzoomdistance = cameraunlock.CreateSlider({
		Name = "Zoom-Out Distance",
		Min = 14,
		Max = 1000,
		Function = function(callback) 
			if cameraunlock.Enabled then
			   pcall(function() lplr.CameraMaxZoomDistance = callback end) 
			end
		end
	})
end)

