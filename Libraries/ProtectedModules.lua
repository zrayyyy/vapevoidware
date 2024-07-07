local ProtectedModules = {}

local GuiLibrary
if shared.GuiLibrary then GuiLibrary = shared.GuiLibrary else warn("GuiLibrary not found!") end

local playersService = game:GetService("Players")
local textService = game:GetService("TextService")
local lightingService = game:GetService("Lighting")
local textChatService = game:GetService("TextChatService")
local inputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local collectionService = game:GetService("CollectionService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local replicatedStorageService = replicatedStorage
local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer

local function warningNotification(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary.CreateNotification(title, text, delay, "assets/InfoNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(255, 0, 255)
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

local vapeConnections
if shared.vapeConnections and type(shared.vapeConnections) == "table" then vapeConnections = shared.vapeConnections else vapeConnections = {} shared.vapeConnections = vapeConnections end

--[[local function run(func) func() end

local run
if getgenv().run then else run = function(func) func() end--]]

local Modules = {
    [6872274481] = function()
        run(function()
            local TweenService = game:GetService("TweenService")
            local playersService = game:GetService("Players")
            local lplr = playersService.LocalPlayer
            local vapeConnections
            if shared.vapeConnections and type(shared.vapeConnections) == "table" then vapeConnections = shared.vapeConnections else vapeConnections = {} shared.vapeConnections = vapeConnections end
            local function warningNotification(title, text, delay)
                local suc, res = pcall(function()
                    local frame = GuiLibrary.CreateNotification(title, text, delay, "assets/InfoNotification.png")
                    frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
                    return frame
                end)
                return (suc and res)
            end
            
            local tppos2
            local deathtpmod = {["Enabled"] = false}
            local TweenSpeed = 0.7
            local HeightOffset = 5
        
            local function teleportWithTween(char, destination)
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    destination = destination + Vector3.new(0, HeightOffset, 0)
                    local currentPosition = root.Position
                    if (destination - currentPosition).Magnitude > 0.5 then
                        local tweenInfo = TweenInfo.new(TweenSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
                        local goal = {CFrame = CFrame.new(destination)}
                        local tween = TweenService:Create(root, tweenInfo, goal)
                        tween:Play()
                        tween.Completed:Wait()
                    end
                end
            end
        
            local function killPlayer(player)
                local character = player.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.Health = 0
                    end
                end
            end
        
            local function onCharacterAdded(char)
                if tppos2 then 
                    task.spawn(function()
                        local root = char:WaitForChild("HumanoidRootPart", 9e9)
                        if root and tppos2 then 
                            teleportWithTween(char, tppos2)
                            tppos2 = nil
                        end
                    end)
                end
            end
        
            vapeConnections[#vapeConnections + 1] = lplr.CharacterAdded:Connect(onCharacterAdded)
        
            local function setTeleportPosition()
                local UserInputService = game:GetService("UserInputService")
                local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        
                if isMobile then
                    warningNotification("DeathTP", "Please tap on the screen to set TP position.", 3)
                    local connection
                    connection = UserInputService.TouchTapInWorld:Connect(function(inputPosition, processedByUI)
                        if not processedByUI then
                            local mousepos = lplr:GetMouse().UnitRay
                            local rayparams = RaycastParams.new()
                            rayparams.FilterDescendantsInstances = {workspace.Map, workspace:FindFirstChild("SpectatorPlatform")}
                            rayparams.FilterType = Enum.RaycastFilterType.Whitelist
                            local ray = workspace:Raycast(mousepos.Origin, mousepos.Direction * 10000, rayparams)
                            if ray then 
                                tppos2 = ray.Position 
                                warningNotification("DeathTP", "Set TP Position. Resetting to teleport...", 3)
                                killPlayer(lplr)
                            end
                            connection:Disconnect()
                            deathtpmod["ToggleButton"](false)
                        end
                    end)
                else
                    local mousepos = lplr:GetMouse().UnitRay
                    local rayparams = RaycastParams.new()
                    rayparams.FilterDescendantsInstances = {workspace.Map, workspace:FindFirstChild("SpectatorPlatform")}
                    rayparams.FilterType = Enum.RaycastFilterType.Whitelist
                    local ray = workspace:Raycast(mousepos.Origin, mousepos.Direction * 10000, rayparams)
                    if ray then 
                        tppos2 = ray.Position 
                        warningNotification("DeathTP", "Set TP Position. Resetting to teleport...", 3)
                        killPlayer(lplr)
                    end
                    deathtpmod["ToggleButton"](false)
                end
            end
        
            deathtpmod = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
                ["Name"] = "DeathTP",
                ["Function"] = function(calling)
                    if calling then
                        local canRespawn = function() end
                        canRespawn = function()
                            local success, response = pcall(function() 
                                return lplr.leaderstats.Bed.Value == '✅' 
                            end)
                            return success and response 
                        end
                        if not canRespawn() then 
                            warningNotification("DeathTP", "Unable to use DeathTP without bed!", 5)
                            deathtpmod.ToggleButton()
                        else
                            setTeleportPosition()
                        end
                    end
                end
            })
        end)
    end
}

ProtectedModules.LoadModules = function(gameId)
    if gameId then
        if type(gameId) == "number" then else gameId = tonumber(gameId) end
        if Modules[gameId] then Modules[gameId]() shared.vapeConnections = vapeConnections else warn("Unknown gameid! GameId: "..tostring(gameId)) end
    else
        warn("GameId not specified")
    end
end

return ProtectedModules