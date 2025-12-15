-- Gravel.cc
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Teams = game:GetService("Teams")
local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local gui = {}

local config = {
    Enabled = false,
    fovsize = 120,
    predic = 1,
    espc = Color3.fromRGB(255, 182, 193),
    esptargetc = Color3.fromRGB(255, 255, 0),
    espteamc = Color3.fromRGB(0, 255, 0),
    rfd = false,
    eme = true,
    wallc = false,
    bodypart = "Head",
    espEnabled = false,
    highlightesp = false,
    originalSizes = {},
    activeApplied = {},
    espData = {},
    highlightData = {},
    currentTarget = nil,
    targethbSizes = {},
    fovc = Color3.fromRGB(100, 0, 0),
    fovct = Color3.fromRGB(255, 255, 0),
    playerConnections = {},
    characterConnections = {},
    looprfd = false,
    targetMode = "Enemies",
    centerLocked = {},
    hitchance = 100,
    hotkeyConnection = nil,
    maxExpansion = math.huge,
    aimbotEnabled = false,
    aimbotFOVSize = 100,
    aimbotStrength = 0.5,
    aimbotWallCheck = false,
    aimbotTargetPart = "Head",
    aimbotTeamTarget = "Enemies",
    aimbotCurrentTarget = nil,
    aimbotFOVRing = nil,
    hitboxEnabled = false,
    hitboxSize = 10,
    hitboxTeamTarget = "Enemies",
    hitboxExpandedParts = {},
    hitboxOriginalSizes = {},
    hitboxLastSize = {},
    antiAimEnabled = false,
    raycastAntiAim = false,
    antiAimTPDistance = 3,
    antiAimAbovePlayer = false,
    antiAimAboveHeight = 10,
    antiAimBehindPlayer = false,
    antiAimBehindDistance = 5,
    originalPosition = nil,
    isTeleported = false,
    currentAntiAimTarget = nil,
    masterTeamTarget = "Enemies",
    autoFarmEnabled = false,
    autoFarmDistance = 10,
    autoFarmSpeed = 1,
    autoFarmTargets = {},
    currentAutoFarmTarget = nil,
    autoFarmLoop = nil,
    autoFarmIndex = 1,
    autoFarmCompleted = {},
    autoFarmTargetPart = "Head",
    autoFarmAlignToCrosshair = true,
    autoFarmVerticalOffset = 0,
    autoFarmOriginalPositions = {}, 
}

local Alurt = loadstring(game:HttpGet("https://raw.githubusercontent.com/azir-py/project/refs/heads/main/Zwolf/AlurtUI.lua"))()

local function safeNotify(opts)
    if typeof(Alurt) == "table" and type(Alurt.CreateNode) == "function" then
        pcall(function()
            Alurt.CreateNode(opts)
        end)
    end
end

local notif1 = (function()
    pcall(function()
        safeNotify({
            Title = "Script started!",
            Content = "May be unstable/dont work on some games",
            Audio = "rbxassetid://17208361335",
            Length = 3,
            Image = "rbxassetid://4483362458",
            BarColor = Color3.fromRGB(0, 170, 255)
        })
    end)
end)()

local lib
do
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/ACXUI/refs/heads/main/ACXUI"))()
    end)
    if success and result then
        lib = result
    else
        warn("SilentAim: failed to load external UI library, using fallback stub. Error:", result)
        lib = {}
        function lib:SetTitle() end
        function lib:SetIcon() end
        function lib:SetBackgroundColor() end
        function lib:SetCloseBtnColor() end
        function lib:SetTitleColor() end
        function lib:SetButtonsColor() end
        function lib:SetTheme() end
        function lib:AddToggle(_, callback, default)
            if callback then
                pcall(callback, default)
            end
        end
        function lib:AddComboBox(_, _, callback)
            if callback then
                pcall(callback, "Only enemies")
            end
        end
        function lib:AddInputBox(_, callback, _, default)
            if callback then
                pcall(callback, tostring(default))
            end
        end
    end
end

if not math.clamp then
    function math.clamp(x, a, b)
        if x < a then return a end
        if x > b then return b end
        return x
    end
end

local function updateTeamTargetModes()
    local masterSelection = config.masterTeamTarget or config.targetMode
    
    if masterSelection == "All" then
        config.targetMode = "All"
        config.aimbotTeamTarget = "All"
        config.hitboxTeamTarget = "All"
    else
        config.targetMode = masterSelection
        config.aimbotTeamTarget = masterSelection
        config.hitboxTeamTarget = masterSelection
    end
    
    if config.espEnabled then
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= localPlayer then
                removeESPLabel(pl)
                if addesp(pl) then
                    makeesp(pl)
                end
            end
        end
    end
    
    if config.highlightesp then
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= localPlayer then
                removeHighlightESP(pl)
                if addesp(pl) and pl.Character then
                    high(pl)
                end
            end
        end
    end
    applyhb()
    config.aimbotCurrentTarget = nil
    config.currentTarget = nil
    updateESPColors()
end


local function isTeammate(p)
    if not (localPlayer and p) then return false end
    if localPlayer.Team and p.Team then
        return localPlayer.Team == p.Team
    end
    return false
end

local function addesp(targetPlayer)
    if not targetPlayer then return false end
    if targetPlayer == localPlayer then return false end

    local mode = config.targetMode or "Enemies"
    if mode == "Enemies" then
        if isTeammate(targetPlayer) then
            return false
        else
            return true
        end
    elseif mode == "Teams" then
        return isTeammate(targetPlayer)
    elseif mode == "All" then
        return true
    else
        if isTeammate(targetPlayer) then
            return false
        else
            return true
        end
    end
end

local function plralive(targetPlayer)
    if not targetPlayer then return false end
    if targetPlayer == localPlayer then
        local character = targetPlayer.Character
        if not character then return false end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        return humanoid.Health > 0
    end
    local character = targetPlayer.Character
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    return humanoid.Health > 0
end


local function saveTargetOriginalPosition(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    
    config.autoFarmOriginalPositions[targetPlayer] = {
        position = targetRoot.Position,
        cframe = targetRoot.CFrame,
        timestamp = tick()
    }
end

local function restoreTargetOriginalPosition(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    
    local savedData = config.autoFarmOriginalPositions[targetPlayer]
    if savedData then
        pcall(function()
            targetRoot.CFrame = savedData.cframe
        end)
        config.autoFarmOriginalPositions[targetPlayer] = nil
    end
end

local function getValidAutoFarmTargets()
    local validTargets = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and plralive(player) then
            local shouldTarget = false
            if config.masterTeamTarget == "Enemies" then
                shouldTarget = not isTeammate(player)
            elseif config.masterTeamTarget == "Teams" then
                shouldTarget = isTeammate(player)
            elseif config.masterTeamTarget == "All" then
                shouldTarget = true
            end
            
            if shouldTarget then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    if not config.autoFarmCompleted[player] then
                        table.insert(validTargets, player)
                    end
                end
            end
        end
    end
    table.sort(validTargets, function(a, b)
        local charA = a.Character
        local charB = b.Character
        local rootA = charA and charA:FindFirstChild("HumanoidRootPart")
        local rootB = charB and charB:FindFirstChild("HumanoidRootPart")
        local localRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if not localRoot then return false end
        if not rootA then return false end
        if not rootB then return true end
        
        local distA = (localRoot.Position - rootA.Position).Magnitude
        local distB = (localRoot.Position - rootB.Position).Magnitude
        
        return distA < distB
    end)
    
    return validTargets
end

local function tptocross(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not localPlayer.Character or not camera then 
        return false 
    end
    
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetHead = targetPlayer.Character:FindFirstChild("Head")
    if not targetRoot then return false end
    local targetPart = nil
    if config.autoFarmTargetPart == "Head" and targetHead then
        targetPart = targetHead
    else
        targetPart = targetRoot
    end
    
    if not targetPart then return false end
    local cameraPos = camera.CFrame.Position
    local cameraLook = camera.CFrame.LookVector
    local crosshairWorldPos = cameraPos + (cameraLook * config.autoFarmDistance)
    crosshairWorldPos = crosshairWorldPos + Vector3.new(0, config.autoFarmVerticalOffset, 0)
    local partOffset = targetPart.Position - targetRoot.Position
    local newRootPosition = crosshairWorldPos - partOffset
    pcall(function()
        targetRoot.CFrame = CFrame.new(newRootPosition)
        local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:MoveTo(cameraPos)
        end
    end)
    
    return true
end

local function tptocrossExact(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not localPlayer.Character or not camera then 
        return false 
    end
    
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetHead = targetPlayer.Character:FindFirstChild("Head")
    if not targetRoot then return false end
    
    local targetPart = nil
    if config.autoFarmTargetPart == "Head" and targetHead then
        targetPart = targetHead
    else
        targetPart = targetRoot
    end
    
    if not targetPart then return false end
    
    local viewportSize = camera.ViewportSize
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    local ray = camera:ScreenPointToRay(screenCenter.X, screenCenter.Y)
    local crosshairWorldPos = ray.Origin + (ray.Direction * config.autoFarmDistance)
    crosshairWorldPos = crosshairWorldPos + Vector3.new(0, config.autoFarmVerticalOffset, 0)
    local partOffset = targetPart.Position - targetRoot.Position
    local newRootPosition = crosshairWorldPos - partOffset
    pcall(function()
        targetRoot.CFrame = CFrame.new(newRootPosition)
        
        local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local lookAt = CFrame.new(targetRoot.Position, camera.CFrame.Position)
            targetRoot.CFrame = lookAt
        end
    end)
    
    return true
end
local function tptocrossWithAlignment(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not localPlayer.Character or not camera then 
        return false 
    end
    
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetHead = targetPlayer.Character:FindFirstChild("Head")
    if not targetRoot then return false end
    
    if not config.autoFarmOriginalPositions[targetPlayer] then
        saveTargetOriginalPosition(targetPlayer)
    end

    local cameraCFrame = camera.CFrame
    local forward = cameraCFrame.LookVector
    local cameraPos = cameraCFrame.Position
    local targetPos = cameraPos + (forward * config.autoFarmDistance)
    targetPos = targetPos + Vector3.new(0, config.autoFarmVerticalOffset, 0)
    local alignPart = nil
    if config.autoFarmTargetPart == "Head" and targetHead then
        alignPart = targetHead
    else
        alignPart = targetRoot
    end
    
    if not alignPart then return false end
    local offsetFromRoot = alignPart.Position - targetRoot.Position
    local newRootPos = targetPos - offsetFromRoot

    pcall(function()
        local directionToCamera = (cameraPos - newRootPos).Unit
        local lookAt = CFrame.new(newRootPos, newRootPos + directionToCamera)
        targetRoot.CFrame = lookAt
    end)
    
    return true
end


local function checkTargetHealth(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return false end
    local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    
    return humanoid.Health > 0
end
local function autoFarmProcess()
    if config.autoFarmLoop then
        config.autoFarmLoop:Disconnect()
        config.autoFarmLoop = nil
    end
    
    config.autoFarmLoop = RunService.Heartbeat:Connect(function()
        if not config.autoFarmEnabled or not localPlayer.Character or not camera then
            if config.autoFarmLoop then
                config.autoFarmLoop:Disconnect()
                config.autoFarmLoop = nil
            end
            return
        end

        local validTargets = getValidAutoFarmTargets()
        if #validTargets == 0 then
            config.currentAutoFarmTarget = nil
            config.autoFarmIndex = 1
            config.autoFarmCompleted = {}
            return
        end
        
        if not config.currentAutoFarmTarget or config.autoFarmCompleted[config.currentAutoFarmTarget] then
            for i = config.autoFarmIndex, #validTargets do
                local target = validTargets[i]
                if not config.autoFarmCompleted[target] then
                    config.currentAutoFarmTarget = target
                    config.autoFarmIndex = i
                    break
                end
            end
            
            if not config.currentAutoFarmTarget then
                config.autoFarmIndex = 1
                config.currentAutoFarmTarget = validTargets[1]
            end
            
            if config.currentAutoFarmTarget then
            end
        end
        
        if config.currentAutoFarmTarget and config.currentAutoFarmTarget.Character then
            if not checkTargetHealth(config.currentAutoFarmTarget) then
                restoreTargetOriginalPosition(config.currentAutoFarmTarget)
                config.autoFarmCompleted[config.currentAutoFarmTarget] = true
                config.currentAutoFarmTarget = nil
                return
            end
            
            if not config.autoFarmOriginalPositions[config.currentAutoFarmTarget] then
                saveTargetOriginalPosition(config.currentAutoFarmTarget)
            end

            local success = tptocrossWithAlignment(config.currentAutoFarmTarget)
            if not success then
                teleportTargetToLocalPlayerFront(config.currentAutoFarmTarget)
            end
        end
    end)
end

local function stopAutoFarm()
    if config.autoFarmLoop then
        config.autoFarmLoop:Disconnect()
        config.autoFarmLoop = nil
    end
    
    for targetPlayer, _ in pairs(config.autoFarmOriginalPositions) do
        if targetPlayer and targetPlayer.Character then
            restoreTargetOriginalPosition(targetPlayer)
        end
    end
    
    config.currentAutoFarmTarget = nil
    config.autoFarmIndex = 1
    config.autoFarmCompleted = {}
    config.autoFarmOriginalPositions = {}
    config.autoFarmEnabled = false
end

local function teleportTargetToLocalPlayerFront(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not localPlayer.Character then 
        return false 
    end
    
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot or not localRoot then return false end
    
    local localCFrame = localRoot.CFrame
    local frontOffset = localCFrame.LookVector * config.autoFarmDistance
    local frontPos = localRoot.Position + frontOffset
    frontPos = Vector3.new(frontPos.X, targetRoot.Position.Y, frontPos.Z)
    
    pcall(function()
        targetRoot.CFrame = CFrame.new(frontPos, localRoot.Position)
    end)
    
    return true
end

local function raycastFromPlayer(player)
    if not player or not player.Character then return false end
    local character = player.Character
    local head = character:FindFirstChild("Head")
    if not head then return false end
    
    local lookVector = head.CFrame.LookVector
    local rayOrigin = head.Position
    local rayDirection = lookVector * 1000
    local ray = Ray.new(rayOrigin, rayDirection)
    
    local ignoreList = {character}
    
    local hit, position = Workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
    
    if hit then
        local hitParent = hit.Parent
        if hitParent and hitParent:IsA("Model") then
            local hitPlayer = Players:GetPlayerFromCharacter(hitParent)
            if hitPlayer == localPlayer then
                return true, position, lookVector
            end
        end
    end
    
    return false, nil, nil
end

local function teleportLocalPlayer(direction, distance)
    if not localPlayer.Character then return end
    local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local currentPos = humanoidRootPart.Position
    local newPos = currentPos + (direction * distance)
    
    if not config.originalPosition then
        config.originalPosition = currentPos
    end
    
    pcall(function()
        humanoidRootPart.CFrame = CFrame.new(newPos)
    end)
    
    config.isTeleported = true
end

local function returnToOriginalPosition()
    if not config.originalPosition or not localPlayer.Character then return end
    local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    pcall(function()
        humanoidRootPart.CFrame = CFrame.new(config.originalPosition)
    end)
    
    config.originalPosition = nil
    config.isTeleported = false
    config.currentAntiAimTarget = nil
end

local function teleportAboveTarget(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not localPlayer.Character then return end
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot or not localRoot then return end
    
    local targetPos = targetRoot.Position
    local abovePos = targetPos + Vector3.new(0, config.antiAimAboveHeight, 0)
    
    if not config.originalPosition then
        config.originalPosition = localRoot.Position
    end
    
    pcall(function()
        localRoot.CFrame = CFrame.new(abovePos)
    end)
    
    config.currentAntiAimTarget = targetPlayer
    config.isTeleported = true
end

local function teleportBehindTarget(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not localPlayer.Character then return end
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot or not localRoot then return end
    
    local targetCFrame = targetRoot.CFrame
    local behindOffset = -targetCFrame.LookVector * config.antiAimBehindDistance
    local behindPos = targetRoot.Position + behindOffset
    
    if not config.originalPosition then
        config.originalPosition = localRoot.Position
    end
    
    pcall(function()
        localRoot.CFrame = CFrame.new(behindPos)
    end)
    
    config.currentAntiAimTarget = targetPlayer
    config.isTeleported = true
end


local function findClosestEnemy()
    if not localPlayer.Character then return nil end
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and plralive(player) then
            local shouldTarget = false
            if config.targetMode == "Enemies" then
                shouldTarget = not isTeammate(player)
            elseif config.targetMode == "Teams" then
                shouldTarget = isTeammate(player)
            elseif config.targetMode == "All" then
                shouldTarget = true
            end
            
            if shouldTarget then
                local playerRoot = player.Character:FindFirstChild("HumanoidRootPart")
                if playerRoot then
                    local distance = (localRoot.Position - playerRoot.Position).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

local function antiAimUpdate()
    if not config.antiAimEnabled then
        if config.isTeleported then
            returnToOriginalPosition()
        end
        return
    end
    
    if config.antiAimAbovePlayer then
        local closestEnemy = findClosestEnemy()
        if closestEnemy then
            teleportAboveTarget(closestEnemy)
        end
        return
    end
    
    if config.antiAimBehindPlayer then
        local closestEnemy = findClosestEnemy()
        if closestEnemy then
            teleportBehindTarget(closestEnemy)
        end
        return
    end
    if config.autoFarmEnabled then
        if config.isTeleported then
            returnToOriginalPosition()
        end
        return
    end
    
    if not config.antiAimEnabled then
        if config.isTeleported then
            returnToOriginalPosition()
        end
        return
    end
    if config.raycastAntiAim then
        local wasTargeted = false
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and plralive(player) then
                local isLooking, hitPosition, lookVector = raycastFromPlayer(player)
                if isLooking then
                    wasTargeted = true
                    config.currentAntiAimTarget = player
                    
                    local teleportDirection = Vector3.new(-lookVector.Z, 0, lookVector.X)
                    
                    if math.random(1, 2) == 1 then
                        teleportDirection = -teleportDirection
                    end
                    
                    teleportLocalPlayer(teleportDirection.Unit, config.antiAimTPDistance)
                    break
                end
            end
        end
        
        if not wasTargeted and config.isTeleported then
            returnToOriginalPosition()
        end
    end
end

local function RFD(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local character = targetPlayer.Character
    local head = character:FindFirstChild("Head")
    if head then
        for _, child in ipairs(head:GetChildren()) do
            if child:IsA("Decal") then
                local ok, t = pcall(function() return child.Texture end)
                local nameLower = tostring(child.Name):lower()
                local texLower = tostring(t or ""):lower()
                if nameLower == "face" or string.find(nameLower, "face") or string.find(texLower, "face") then
                    pcall(function() child:Destroy() end)
                end
            end
        end
    end
end

local function wallCheck(targetPos, sourcePos)
    if not config.wallc then
        return true
    end

    if (targetPos - sourcePos).Magnitude <= 0 then return true end

    local rayDirection = (targetPos - sourcePos)
    local ray = Ray.new(sourcePos, rayDirection.Unit * rayDirection.Magnitude)
    local ignoreList = {}

    if localPlayer and localPlayer.Character then
        table.insert(ignoreList, localPlayer.Character)
    end

    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer.Character then
            table.insert(ignoreList, otherPlayer.Character)
        end
    end

    local hit, position = Workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
    if hit and position then
        local distanceToTarget = (targetPos - sourcePos).Magnitude
        local distanceToHit = (position - sourcePos).Magnitude
        return distanceToHit >= (distanceToTarget - 2)
    end

    return true
end

local function high(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    if not addesp(targetPlayer) then return end

    if config.highlightData[targetPlayer] then
        local existing = config.highlightData[targetPlayer]
        if existing and existing.Parent then
            if targetPlayer == config.currentTarget or targetPlayer == config.aimbotCurrentTarget then
                existing.FillColor = config.esptargetc
            else
                existing.FillColor = config.espc
            end
            return
        else
            config.highlightData[targetPlayer] = nil
        end
    end

    local character = targetPlayer.Character
    if not character then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "PlayerHighlight"
    highlight.FillColor = config.espc
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.OutlineTransparency = 0
    local okDepth, _ = pcall(function() highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop end)
    if not okDepth then
    end
    highlight.Parent = character

    if targetPlayer == config.currentTarget or targetPlayer == config.aimbotCurrentTarget then
        highlight.FillColor = config.esptargetc
    else
        highlight.FillColor = config.espc
    end

    config.highlightData[targetPlayer] = highlight
end

local function removeHighlightESP(targetPlayer)
    if not targetPlayer then return end
    local h = config.highlightData[targetPlayer]
    if h and h.Parent then
        pcall(function() h:Destroy() end)
    end
    config.highlightData[targetPlayer] = nil
end

local function removeESPLabel(targetPlayer)
    if not targetPlayer or not config.espData[targetPlayer] then return end
    local data = config.espData[targetPlayer]
    if data.connection then
        pcall(function() data.connection:Disconnect() end)
    end
    if data.screenGui and data.screenGui.Parent then
        pcall(function() data.screenGui:Destroy() end)
    end
    config.espData[targetPlayer] = nil
end

local function makeesp(targetPlayer)
    if not targetPlayer then return end
    if not addesp(targetPlayer) then return end

    if config.espData[targetPlayer] then
        local data = config.espData[targetPlayer]
        if data and data.label and data.label.Parent then
            return
        else
            removeESPLabel(targetPlayer)
        end
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ESP_" .. targetPlayer.Name
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

    local label = Instance.new("TextLabel")
    label.Name = "ESPLabel"
    label.BackgroundTransparency = 1
    label.Text = targetPlayer.Name
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Visible = false
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Parent = screenGui

    label.TextColor3 = config.espc
    if targetPlayer == config.currentTarget or targetPlayer == config.aimbotCurrentTarget then
        label.TextColor3 = config.esptargetc
    end

    local function startUpdater()
        if not targetPlayer.Character then
            label.Visible = false
            return
        end
        local head = targetPlayer.Character:FindFirstChild("Head")
        if not head then
            label.Visible = false
            return
        end

        if config.espData[targetPlayer] and config.espData[targetPlayer].connection then
            pcall(function() config.espData[targetPlayer].connection:Disconnect() end)
        end

        local conn = RunService.RenderStepped:Connect(function()
            if not targetPlayer or not targetPlayer.Character or not head or not head.Parent then
                label.Visible = false
                return
            end

            if not addesp(targetPlayer) then
                label.Visible = false
                return
            end

            local headPosition = head.Position + Vector3.new(0, 2, 0)
            local screenPos, onScreen = camera:WorldToViewportPoint(headPosition)
            if onScreen then
                local absWidth = 200
                pcall(function()
                    if label.AbsoluteSize and label.AbsoluteSize.X and label.AbsoluteSize.X > 0 then
                        absWidth = label.AbsoluteSize.X
                    end
                end)
                label.Position = UDim2.new(0, screenPos.X - absWidth / 2, 0, screenPos.Y - 30)
                local distance = (camera.CFrame.Position - headPosition).Magnitude
                label.Text = string.format("%s [%d]", targetPlayer.Name, math.floor(distance))

                if targetPlayer == config.currentTarget or targetPlayer == config.aimbotCurrentTarget then
                    label.TextColor3 = config.esptargetc
                else
                    label.TextColor3 = config.espc
                end

                label.Visible = true
            else
                label.Visible = false
            end
        end)

        config.espData[targetPlayer] = {
            label = label,
            screenGui = screenGui,
            connection = conn
        }
    end

    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
        startUpdater()
    else
        spawn(function()
            if targetPlayer.Character then
                local head = targetPlayer.Character:WaitForChild("Head", 2)
                if head then
                    startUpdater()
                end
            end
        end)
    end
end

local function updateESPColors()
    for targetPlayer, data in pairs(config.espData) do
        if not targetPlayer or not data or not data.label then
            config.espData[targetPlayer] = nil
        else
            if not addesp(targetPlayer) then
                removeESPLabel(targetPlayer)
            else
                if targetPlayer == config.currentTarget or targetPlayer == config.aimbotCurrentTarget then
                    data.label.TextColor3 = config.esptargetc
                else
                    data.label.TextColor3 = config.espc
                end
            end
        end
    end

    for targetPlayer, highlight in pairs(config.highlightData) do
        if not targetPlayer or not highlight or not highlight.Parent then
            config.highlightData[targetPlayer] = nil
        else
            if not addesp(targetPlayer) then
                removeHighlightESP(targetPlayer)
            else
                if targetPlayer == config.currentTarget or targetPlayer == config.aimbotCurrentTarget then
                    highlight.FillColor = config.esptargetc
                else
                    highlight.FillColor = config.espc
                end
            end
        end
    end
end

local function toggleHighlightESP(enabled)
    config.highlightesp = enabled

    if enabled then
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            if addesp(targetPlayer) and targetPlayer.Character then
                high(targetPlayer)
            end
        end
    else
        for targetPlayer, _ in pairs(config.highlightData) do
            removeHighlightESP(targetPlayer)
        end
        config.highlightData = {}
    end
end

local function toggleESP(enabled)
    config.espEnabled = enabled

    if enabled then
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            if addesp(targetPlayer) then
                makeesp(targetPlayer)
            end
        end
    else
        for targetPlayer, _ in pairs(config.espData) do
            removeESPLabel(targetPlayer)
        end
        config.espData = {}
    end
end

local function removeAllFaceDecals()
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= localPlayer then
            RFD(targetPlayer)
        end
    end
end

local function saveOriginalPartInfo(targetPlayer, part)
    if not targetPlayer or not part then return end
    config.originalSizes[targetPlayer] = {
        partName = part.Name or "Head",
        size = part.Size,
    }
end

local function chooseBodyPartInstance(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return nil, "Head" end

    local char = targetPlayer.Character
    local bp = config.bodypart or "Head"

    if bp == "Head" then
        return char:FindFirstChild("Head"), "Head"
    elseif bp == "HumanoidRootPart" then
        return char:FindFirstChild("HumanoidRootPart"), "HumanoidRootPart"
    elseif bp == "Both" then
        local roll = math.random(1, 100)
        local primaryName, secondaryName
        if roll <= 85 then
            primaryName = "HumanoidRootPart"
            secondaryName = "Head"
        else
            primaryName = "Head"
            secondaryName = "HumanoidRootPart"
        end
        local primaryPart = char:FindFirstChild(primaryName)
        if primaryPart then
            return primaryPart, primaryName
        else
            local fallback = char:FindFirstChild(secondaryName)
            return fallback, secondaryName
        end
    else
        local found = char:FindFirstChild(bp) or char:FindFirstChild("Head")
        return found, (found and found.Name) or "Head"
    end
end

local function applySizeToPart(targetPlayer, targetDiameter, chosenPart)
    if not targetPlayer or not targetPlayer.Character or targetPlayer == localPlayer then return end
    if not plralive(targetPlayer) then return end

    local part = chosenPart
    local partName = nil
    if not part then
        part, partName = chooseBodyPartInstance(targetPlayer)
    else
        partName = part.Name
    end
    if not part then return end

    if not config.originalSizes[targetPlayer] then
        saveOriginalPartInfo(targetPlayer, part)
    end

    local expansionSize = Vector3.new(
        targetDiameter,
        targetDiameter,
        targetDiameter
    )

    local useExpanded = true
    local chance = math.clamp(tonumber(config.hitchance) or 100, 0, 100)
    if chance <= 0 then
        useExpanded = false
    elseif chance < 100 then
        if math.random(1, 100) <= chance then
            useExpanded = true
        else
            useExpanded = false
        end
    else
        useExpanded = true
    end

    if useExpanded then
        config.targethbSizes[targetPlayer] = expansionSize
    else
        local original = config.originalSizes[targetPlayer]
        if original and original.size then
            config.targethbSizes[targetPlayer] = original.size
        else
            config.targethbSizes[targetPlayer] = Vector3.new(0.05, 0.05, 0.05)
        end
    end

    config.activeApplied[targetPlayer] = true
end

local function restorePartForPlayer(targetPlayer)
    if not targetPlayer or targetPlayer == localPlayer then return end

    local char = targetPlayer.Character
    local original = config.originalSizes[targetPlayer]
    if not original then
        config.activeApplied[targetPlayer] = nil
        config.targethbSizes[targetPlayer] = nil
        return
    end

    local part = nil
    if char then
        part = char:FindFirstChild(original.partName) or char:FindFirstChild(config.bodypart) or char:FindFirstChild("Head")
    end

    if part and original.size then
        pcall(function()
            part.Size = original.size
            part.Transparency = 1
            part.CanCollide = false
            part.Massless = false
            if part:IsA("BasePart") then
                part.Velocity = Vector3.new(0, 0, 0)
                part.RotVelocity = Vector3.new(0, 0, 0)
            end
        end)
    end

    config.activeApplied[targetPlayer] = nil
    config.originalSizes[targetPlayer] = nil
    config.targethbSizes[targetPlayer] = nil
    config.centerLocked[targetPlayer] = nil
end

local function tnormalsize(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end  

    local char = targetPlayer.Character  
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")

    if torso and not config.hitboxOriginalSizes[targetPlayer] then
        config.hitboxOriginalSizes[targetPlayer] = {
            part = torso,
            size = torso.Size
        }
    end
end
local function expandhb(targetPlayer, size)
    if not targetPlayer or not targetPlayer.Character or targetPlayer == localPlayer then return end  
    if not plralive(targetPlayer) then return end  

    local char = targetPlayer.Character  
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")  
    if not torso then return end  

    tnormalsize(targetPlayer)
    local expansionSize = Vector3.new(size, size, size)
    config.hitboxLastSize[targetPlayer] = size

    config.hitboxExpandedParts[targetPlayer] = {
        part = torso,
        targetSize = expansionSize
    }
    
    if config.hitboxEnabled then
        pcall(function()
            torso.Size = expansionSize
            torso.Transparency = 0.9
            torso.CanCollide = false
            torso.Massless = true
        end)
    end
end

local function restoreTorso(targetPlayer)
    if not targetPlayer then return end  

    local original = config.hitboxOriginalSizes[targetPlayer]
    if original and original.part and original.part.Parent then
        pcall(function()
            original.part.Size = original.size
            original.part.Transparency = 0
            original.part.CanCollide = true
        end)
    end

    config.hitboxExpandedParts[targetPlayer] = nil
    config.hitboxOriginalSizes[targetPlayer] = nil
end

local function updateHitboxes()
    if not config.hitboxEnabled then  
        for player, _ in pairs(config.hitboxExpandedParts) do  
            restoreTorso(player)  
        end  
        return  
    end

    for player, data in pairs(config.hitboxExpandedParts) do
        if not player or not plralive(player) or not player.Character then
            restoreTorso(player)
        else
            local torso = player.Character:FindFirstChild("Torso") or player.Character:FindFirstChild("UpperTorso")
            if torso and data.targetSize then
                pcall(function()
                    torso.Size = data.targetSize
                    torso.Transparency = 0.9
                    torso.CanCollide = false
                    torso.Massless = true
                end)
            end
        end
    end
end

local function targethb(player)
    if not player or player == localPlayer then return false end  
    if not plralive(player) then return false end  

    local mode = config.hitboxTeamTarget or "Enemies"

    if mode == "Enemies" then
        return not isTeammate(player)
    elseif mode == "Teams" then
        return isTeammate(player)
    elseif mode == "All" then
        return true
    end

    return false
end

local function applyhb()
    if not config.hitboxEnabled then return end  

    for _, player in ipairs(Players:GetPlayers()) do  
        if targethb(player) then
            local size = config.hitboxSize
            config.hitboxLastSize[player] = size
            expandhb(player, size)
        else
            restoreTorso(player)
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        task.wait(0.3)

        if config.hitboxEnabled and targethb(player) then
            local size = config.hitboxSize
            config.hitboxLastSize[player] = size
            expandhb(player, size)
        end
    end)
end)

for _, player in ipairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function()
        task.wait(0.3)

        if config.hitboxEnabled and targethb(player) then
            local size = config.hitboxSize
            config.hitboxLastSize[player] = size
            expandhb(player, size)
        end
    end)
end

RunService.Heartbeat:Connect(updateHitboxes)

local function hb()
    for playerObj, targetSize in pairs(config.targethbSizes) do
        if playerObj and playerObj ~= localPlayer and playerObj.Character and plralive(playerObj) then
            local part = playerObj.Character:FindFirstChild(config.originalSizes[playerObj] and config.originalSizes[playerObj].partName) 
                         or playerObj.Character:FindFirstChild(config.bodypart) 
                         or playerObj.Character:FindFirstChild("Head")
            if not part then
                local p1 = playerObj.Character:FindFirstChild("HumanoidRootPart")
                local p2 = playerObj.Character:FindFirstChild("Head")
                part = p1 or p2
            end

            if part then
                local currentSize = part.Size
                local lerpAlpha = math.clamp(tonumber(config.predic) or 1, 0, 1)
                local newSize = currentSize:Lerp(targetSize, lerpAlpha)

                pcall(function()
                    part.Size = newSize
                    part.Transparency = 1
                    part.CanCollide = false
                    part.Massless = (part.Name ~= "HumanoidRootPart")
                end)
            end
        else
            if playerObj ~= localPlayer then
                restorePartForPlayer(playerObj)
            end
        end
    end
    
    updateHitboxes()
end

local function shouldTargetAimbot(player)
    if not player or player == localPlayer then return false end
    if not plralive(player) then return false end
    
    local mode = config.aimbotTeamTarget or "Enemies"
    if mode == "Enemies" then
        return not isTeammate(player)
    elseif mode == "Teams" then
        return isTeammate(player)
    elseif mode == "All" then
        return true
    end
    return false
end

local function aimbotWallCheck(targetPos, sourcePos)
    if not config.aimbotWallCheck then return true end
    
    if (targetPos - sourcePos).Magnitude <= 0 then return true end

    local rayDirection = (targetPos - sourcePos)
    local ray = Ray.new(sourcePos, rayDirection.Unit * rayDirection.Magnitude)
    local ignoreList = {}

    if localPlayer and localPlayer.Character then
        table.insert(ignoreList, localPlayer.Character)
    end

    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer.Character then
            table.insert(ignoreList, otherPlayer.Character)
        end
    end

    local hit, position = Workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
    if hit and position then
        local distanceToTarget = (targetPos - sourcePos).Magnitude
        local distanceToHit = (position - sourcePos).Magnitude
        return distanceToHit >= (distanceToTarget - 2)
    end

    return true
end

local function getAimbotTargetPart(player)
    if not player or not player.Character then return nil end
    
    local partName = config.aimbotTargetPart or "Head"
    local char = player.Character
    
    if partName == "Head" then
        return char:FindFirstChild("Head")
    elseif partName == "HumanoidRootPart" then
        return char:FindFirstChild("HumanoidRootPart")
    elseif partName == "Torso" then
        return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    else
        return char:FindFirstChild("Head")
    end
end

local function smoothAim(currentCFrame, targetCFrame, strength)
    strength = math.clamp(strength or 0.5, 0, 1)
    return currentCFrame:Lerp(targetCFrame, strength)
end

local function aimbotUpdate()
    if not config.aimbotEnabled then
        if config.aimbotCurrentTarget then
            config.aimbotCurrentTarget = nil
            updateESPColors()
        end
        return
    end
    
    if not camera then camera = workspace.CurrentCamera end
    if not camera then return end
    
    local viewportSize = camera.ViewportSize
    local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    local radiusPx = config.aimbotFOVSize
    
    local bestTarget = nil
    local bestScreenDist = math.huge
    local bestPart = nil
    
    for _, player in ipairs(Players:GetPlayers()) do
        if shouldTargetAimbot(player) and player.Character then
            local targetPart = getAimbotTargetPart(player)
            if targetPart then
                local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                if onScreen then
                    local screenVec = Vector2.new(screenPos.X, screenPos.Y)
                    local distPx = (screenVec - center).Magnitude
                    
                    if distPx <= radiusPx and distPx < bestScreenDist then
                        if aimbotWallCheck(targetPart.Position, camera.CFrame.Position) then
                            bestTarget = player
                            bestScreenDist = distPx
                            bestPart = targetPart
                        end
                    end
                end
            end
        end
    end
    
    if config.aimbotCurrentTarget ~= bestTarget then
        config.aimbotCurrentTarget = bestTarget
        updateESPColors()
    end
    
    if bestTarget and bestPart and localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            local targetPosition = bestPart.Position
            local currentCFrame = camera.CFrame
            local targetCFrame = CFrame.lookAt(currentCFrame.Position, targetPosition)
            
            local strength = math.clamp(config.aimbotStrength, 0, 1)
            if strength < 1 then
                targetCFrame = smoothAim(currentCFrame, targetCFrame, strength)
            end
            
            camera.CFrame = targetCFrame
        end
    end
end

local function aimbotfov()
    if config.aimbotFOVRing and config.aimbotFOVRing.Parent then
        config.aimbotFOVRing:Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AimbotFOVRing"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    local ringFrame = Instance.new("Frame")
    ringFrame.Name = "RingFrame"
    ringFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    ringFrame.Size = UDim2.new(0, config.aimbotFOVSize * 2, 0, config.aimbotFOVSize * 2)
    ringFrame.Position = UDim2.new(0.5, 0, 0.5, -28)
    ringFrame.BackgroundTransparency = 1
    ringFrame.Visible = config.aimbotEnabled
    ringFrame.Parent = screenGui
    
    local ringCorner = Instance.new("UICorner")
    ringCorner.CornerRadius = UDim.new(1, 0)
    ringCorner.Parent = ringFrame
    
    local ringStroke = Instance.new("UIStroke")
    ringStroke.Thickness = 1
    ringStroke.LineJoinMode = Enum.LineJoinMode.Round
    ringStroke.Color = Color3.fromRGB(255, 0, 0)
    ringStroke.Transparency = 0.3
    ringStroke.Parent = ringFrame
    
    config.aimbotFOVRing = {
        ScreenGui = screenGui,
        RingFrame = ringFrame,
        RingStroke = ringStroke
    }
    
    return config.aimbotFOVRing
end

local function updateAimbotFOVRing()
    if config.aimbotFOVRing and config.aimbotFOVRing.RingFrame then
        config.aimbotFOVRing.RingFrame.Size = UDim2.new(0, config.aimbotFOVSize * 2, 0, config.aimbotFOVSize * 2)
        config.aimbotFOVRing.RingFrame.Visible = config.aimbotEnabled
    end
end

RunService.Heartbeat:Connect(hb)
RunService.RenderStepped:Connect(aimbotUpdate)
RunService.Heartbeat:Connect(antiAimUpdate)

local function onRenderStep()
    if not camera or not camera.Parent then
        camera = workspace.CurrentCamera
        if not camera then return end
    end

    if not gui.RingHolder or not gui.RingStroke then return end

    if not config.Enabled then
        gui.RingHolder.Visible = false
        return
    else
        gui.RingHolder.Visible = true
    end

    local viewportSize = camera.ViewportSize
    local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    local radiusPx = config.fovsize

    if gui.RingHolder then
        local currentSize = gui.RingHolder.AbsoluteSize and gui.RingHolder.AbsoluteSize.X or (config.fovsize * 2)
        radiusPx = currentSize / 2
    end

    local best = nil
    local bestWorldDist = math.huge

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= localPlayer and pl.Character then
            local bodyPart, chosenName = chooseBodyPartInstance(pl)
            local humanoid = pl.Character:FindFirstChildOfClass("Humanoid")

            if bodyPart and humanoid and humanoid.Health > 0 then
                local mode = config.targetMode or "Enemies"
                local skip = false
                if mode == "Enemies" then
                    if isTeammate(pl) then
                        skip = true
                    end
                elseif mode == "Teams" then
                    if not isTeammate(pl) then
                        skip = true
                    end
                elseif mode == "All" then
                    skip = false
                end

                if not skip then
                    local screenPos3, onScreen = camera:WorldToViewportPoint(bodyPart.Position)
                    if onScreen then
                        local screenVec = Vector2.new(screenPos3.X, screenPos3.Y)
                        local distPx = (screenVec - center).Magnitude
                        if distPx <= radiusPx then
                            local cameraPos = camera.CFrame.Position
                            local targetPos = bodyPart.Position
                            if wallCheck(targetPos, cameraPos) then
                                local worldDist = (cameraPos - targetPos).Magnitude
                                if worldDist < bestWorldDist then
                                    best = {
                                        player = pl,
                                        part = bodyPart,
                                        partName = chosenName,
                                        screenDist = distPx,
                                        worldDist = worldDist,
                                        screenPos = screenVec,
                                        screenPos3 = screenPos3
                                    }
                                    bestWorldDist = worldDist
                                end
                            end
                        end
                    end
                end
            else
                if config.activeApplied[pl] then
                    restorePartForPlayer(pl)
                end
            end
        end
    end

    if best then
        gui.RingStroke.Color = config.fovct
    else
        gui.RingStroke.Color = config.fovc
    end

    if config.currentTarget ~= (best and best.player) then
        config.currentTarget = best and best.player
        updateESPColors()
    end

    for pl, _ in pairs(config.activeApplied) do
        if (not best) or pl ~= best.player or not plralive(pl) then
            restorePartForPlayer(pl)
        end
    end

    if best and plralive(best.player) then
        local diameter = (function()
            local viewportSize = camera.ViewportSize
            local H = viewportSize.Y
            local vFovDeg = camera.FieldOfView
            local vFovRad = math.rad(vFovDeg)
            local halfVFov = vFovRad / 2
            local alpha = (radiusPx / (H / 2)) * halfVFov
            local worldHalf = best.worldDist * math.tan(alpha)
            local worldFull = worldHalf * 2
            return worldFull
        end)()

        diameter = math.max(0.01, diameter)

        local localChar = localPlayer.Character
        local targetChar = best.player.Character
        local distance = math.huge

        if localChar and targetChar then
            local localRoot = localChar:FindFirstChild("HumanoidRootPart") or localChar:FindFirstChild("Head")
            local targetRoot = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Head")

            if localRoot and targetRoot then
                distance = (localRoot.Position - targetRoot.Position).Magnitude
            end
        end

        local studz = 5 
        if distance <= studz then
            diameter = math.max(0.05, math.min(0.1, diameter))
        else
            local ok, pixelRadius = pcall(function()
                local rightWorld = camera.CFrame:VectorToWorldSpace(Vector3.new(1, 0, 0)).Unit
                local upWorld = camera.CFrame:VectorToWorldSpace(Vector3.new(0, 1, 0)).Unit
                local worldHalf = diameter / 2
                --scriptmadebyhmmm5651
                local maxPixel = 0
                local samples = 16
                for i = 0, samples - 1 do
                    local angle = (i / samples) * 2 * math.pi
                    local offsetWorld = rightWorld * math.cos(angle) * worldHalf + upWorld * math.sin(angle) * worldHalf
                    local samplePointWorld = best.part.Position + offsetWorld
                    local sp, onScreenSample = camera:WorldToViewportPoint(samplePointWorld)
                    if onScreenSample then
                        local sampleScreen = Vector2.new(sp.X, sp.Y)
                        local d = (sampleScreen - best.screenPos).Magnitude
                        if d > maxPixel then
                            maxPixel = d
                        end
                    end
                end

                if maxPixel <= 0 then
                    return nil
                end

                return maxPixel
            end)

            if ok and pixelRadius and pixelRadius > 0 then
                local scale = best.screenDist / pixelRadius
                scale = math.clamp(scale, 1 / config.maxExpansion, config.maxExpansion)
                diameter = math.max(0.01, diameter * scale)
            end
        end

        diameter = math.max(0.01, diameter)
        if best.screenDist <= 1 then
            if not config.centerLocked[best.player] then
                config.centerLocked[best.player] = true
                applySizeToPart(best.player, diameter, best.part)
            else
                local prevSize = config.targethbSizes[best.player]
                if prevSize then
                    diameter = prevSize.X
                end
                applySizeToPart(best.player, diameter, best.part)
            end
        else
            config.centerLocked[best.player] = nil
            applySizeToPart(best.player, diameter, best.part)
        end

        if config.rfd then
            RFD(best.player)
        end
    end
end

local function setupDeathListener(targetPlayer)
    if targetPlayer == localPlayer then return end
    if not targetPlayer.Character then return end

    local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if config.characterConnections[targetPlayer] then
        pcall(function() config.characterConnections[targetPlayer]:Disconnect() end)
        config.characterConnections[targetPlayer] = nil
    end

    config.characterConnections[targetPlayer] = humanoid.HealthChanged:Connect(function(health)
        if health <= 0 then
            restorePartForPlayer(targetPlayer)
            restoreTorso(targetPlayer)
            if config.currentTarget == targetPlayer then
                config.currentTarget = nil
                updateESPColors()
            end
            if config.aimbotCurrentTarget == targetPlayer then
                config.aimbotCurrentTarget = nil
                updateESPColors()
            end
        end
    end)
end

local function cleanplrdata(targetPlayer)
    if not targetPlayer then return end

    config.autoFarmOriginalPositions[targetPlayer] = nil
    config.autoFarmCompleted[targetPlayer] = nil
    
    if config.currentAutoFarmTarget == targetPlayer then
        config.currentAutoFarmTarget = nil
    end

    restorePartForPlayer(targetPlayer)
    restoreTorso(targetPlayer)
    removeESPLabel(targetPlayer)
    removeHighlightESP(targetPlayer)

    if config.playerConnections[targetPlayer] then
        for _, conn in ipairs(config.playerConnections[targetPlayer]) do
            pcall(function() conn:Disconnect() end)
        end
        config.playerConnections[targetPlayer] = nil
    end

    if config.characterConnections[targetPlayer] then
        pcall(function() config.characterConnections[targetPlayer]:Disconnect() end)
        config.characterConnections[targetPlayer] = nil
    end

    config.activeApplied[targetPlayer] = nil
    config.originalSizes[targetPlayer] = nil
    config.targethbSizes[targetPlayer] = nil
    config.hitboxExpandedParts[targetPlayer] = nil
    config.hitboxOriginalSizes[targetPlayer] = nil

    if config.currentTarget == targetPlayer then
        config.currentTarget = nil
        updateESPColors()
    end
    if config.aimbotCurrentTarget == targetPlayer then
        config.aimbotCurrentTarget = nil
        updateESPColors()
    end
end

local function setupPlayerListeners(pl)
    if pl == localPlayer then return end
    if config.playerConnections[pl] then
        return
    end

    config.playerConnections[pl] = {}
    
    local charAddedConn = pl.CharacterAdded:Connect(function(char)
        task.wait(0.25)
        config.autoFarmOriginalPositions[pl] = nil
        config.autoFarmCompleted[pl] = nil
        
    end)
    table.insert(config.playerConnections[pl], charAddedConn)

    config.playerConnections[pl] = {}
    removeESPLabel(pl)
    removeHighlightESP(pl)

    if config.espEnabled and addesp(pl) then
        makeesp(pl)
    end
    if config.highlightesp and pl.Character and addesp(pl) then
        high(pl)
    end
    if config.rfd then
        RFD(pl)
    end

    local charAddedConn = pl.CharacterAdded:Connect(function(char)
        task.wait(0.25)
        setupDeathListener(pl)
        restorePartForPlayer(pl)
        restoreTorso(pl)

        removeESPLabel(pl)
        if config.espEnabled and addesp(pl) then
            task.wait(0.05)
            makeesp(pl)
        end

        removeHighlightESP(pl)
        if config.highlightesp and addesp(pl) then
            task.wait(0.05)
            high(pl)
        end

        if config.rfd then
            RFD(pl)
        end
    end)
    table.insert(config.playerConnections[pl], charAddedConn)

    local charRemovingConn = pl.CharacterRemoving:Connect(function(char)
        restorePartForPlayer(pl)
        restoreTorso(pl)
    end)
    table.insert(config.playerConnections[pl], charRemovingConn)

    local teamChangedConn = pl:GetPropertyChangedSignal("Team"):Connect(function()
        task.wait(0.05)
        if not addesp(pl) then
            removeESPLabel(pl)
            removeHighlightESP(pl)
        else
            if config.espEnabled then
                removeESPLabel(pl)
                if addesp(pl) then
                    makeesp(pl)
                end
            end
            if config.highlightesp and pl.Character then
                removeHighlightESP(pl)
                if addesp(pl) and pl.Character then
                    high(pl)
                end
            end
        end
    end)
    table.insert(config.playerConnections[pl], teamChangedConn)

    if pl.Character then
        setupDeathListener(pl)
    end
end

local function lrfd()
    if config.looprfd then return end
    config.looprfd = true

    task.spawn(function()
        while config.Enabled do
            removeAllFaceDecals()
            task.wait(0.5)
        end
        config.looprfd = false
    end)
end

local function makeui()
    lib:SetTitle("Gravel.cc")
    lib:SetIcon("http://www.roblox.com/asset/?id=132214308111067")
    lib:SetTheme("HighContrast")
    local T0 = lib:CreateTab("Main")
    local T1 = lib:CreateTab("SilentAim")
    local T2 = lib:CreateTab("Visuals")
    local T3 = lib:CreateTab("Aimbot")
    local T4 = lib:CreateTab("Hitbox")
    local T5 = lib:CreateTab("AntiAim")

    lib:Tab("Visuals")
    lib:AddToggle("Toggle Highlight ESP (V)", function(state)
        toggleHighlightESP(state)
        if state then
            safeNotify({
                Title = "Highlight ESP",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(0, 170, 255)
            })
        else
            safeNotify({
                Title = "Highlight ESP",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end, false)
    
    lib:AddToggle("Toggle Text ESP (Z)", function(state)
        toggleESP(state)
        if state then
            safeNotify({
                Title = "Text ESP",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(0, 170, 255)
            })
        else
            safeNotify({
                Title = "Text ESP",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end, false)
    lib:Tab("AntiAim")
    
    lib:AddToggle("Toggle AntiAim (L)", function(state)
        config.antiAimEnabled = state
        if not state then
            returnToOriginalPosition()
            safeNotify({
                Title = "AntiAim",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        else
            safeNotify({
                Title = "AntiAim",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 100, 0)
            })
        end
    end, false)
    
    lib:AddToggle("Raycast AntiAim", function(state)
        config.raycastAntiAim = state
        if state then
            config.antiAimAbovePlayer = false
            config.antiAimBehindPlayer = false
            safeNotify({
                Title = "Raycast AntiAim",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 170, 255)
            })
        else
            safeNotify({
                Title = "Raycast AntiAim",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end, false)
    
    lib:AddInputBox("Teleport Distance", function(text)
        local n = tonumber(text)
        if n and n > 0 then
            config.antiAimTPDistance = n
        end
        return tostring(config.antiAimTPDistance)
    end, "Enter Distance...", "3", {
        min = 1,
        max = 50,
        isNumber = true
    })
    
    lib:AddToggle("Above Player", function(state)
        config.antiAimAbovePlayer = state
        if state then
            config.raycastAntiAim = false
            config.antiAimBehindPlayer = false
            safeNotify({
                Title = "Above Player",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 170, 255)
            })
        else
            returnToOriginalPosition()
            safeNotify({
                Title = "Above Player",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end, false)
    
    lib:AddInputBox("Above Height", function(text)
        local n = tonumber(text)
        if n and n > 0 then
            config.antiAimAboveHeight = n
        end
        return tostring(config.antiAimAboveHeight)
    end, "Enter Height...", "10", {
        min = 1,
        max = 100,
        isNumber = true
    })
    
    lib:AddToggle("Behind Player", function(state)
        config.antiAimBehindPlayer = state
        if state then
            config.raycastAntiAim = false
            config.antiAimAbovePlayer = false
            safeNotify({
                Title = "Behind Player",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 170, 255)
            })
        else
            returnToOriginalPosition()
            safeNotify({
                Title = "Behind Player",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end, false)
    
    lib:AddInputBox("Behind Distance", function(text)
        local n = tonumber(text)
        if n and n > 0 then
            config.antiAimBehindDistance = n
        end
        return tostring(config.antiAimBehindDistance)
    end, "Enter Distance...", "5", {
        min = 1,
        max = 50,
        isNumber = true
    })
    lib:Tab("Aimbot")
    lib:AddToggle("Toggle Aimbot (G)", function(state)
        config.aimbotEnabled = state
        if config.aimbotFOVRing and config.aimbotFOVRing.RingFrame then
            config.aimbotFOVRing.RingFrame.Visible = state
        end
        
        if state then
            if not config.aimbotFOVRing then
                aimbotfov()
            end
            safeNotify({
                Title = "Aimbot",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(0, 255, 0)
            })
        else
            config.aimbotCurrentTarget = nil
            updateESPColors()
            safeNotify({
                Title = "Aimbot",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end, false)
    
    lib:AddComboBox("Team Target", {"Enemies", "Teams", "All"}, function(selection)
        if config.masterTeamTarget == "All" then
            return
        end
        
        config.aimbotTeamTarget = selection
        config.aimbotCurrentTarget = nil
        updateESPColors()
        if config.aimbotTeamTarget == "All" then
            config.masterTeamTarget = "All"
            updateTeamTargetModes()
        end
    end)
    
    lib:AddComboBox("Target Part", {"Head", "HumanoidRootPart", "Torso"}, function(selection)
        config.aimbotTargetPart = selection
    end)
    
    lib:AddInputBox("Aim Strength", function(text)
        local n = tonumber(text)
        if n and n >= 0 and n <= 1 then
            config.aimbotStrength = n
        end
        return tostring(config.aimbotStrength)
    end, "0-1", "0.5", {
        min = 0,
        max = 1,
        isNumber = true
    })
    
    lib:AddToggle("Wall Check (H)", function(state)
        config.aimbotWallCheck = state
        if state then
            safeNotify({
                Title = "Aimbot Wall Check",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(0, 170, 255)
            })
        else
            safeNotify({
                Title = "Aimbot Wall Check",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end, false)
    
    lib:AddInputBox("FOV Size", function(text)
        local n = tonumber(text)
        if n and n >= 1 then
            config.aimbotFOVSize = n
            updateAimbotFOVRing()
            return tostring(config.aimbotFOVSize)
        end
        return tostring(config.aimbotFOVSize)
    end, "Enter Value...", "100", {
        min = 1,
        max = 9999,
        isNumber = true
    })
    lib:Tab("Hitbox")
    lib:AddToggle("Toggle Hitbox (F)", function(state)
        config.hitboxEnabled = state
        if state then
            applyhb()
            safeNotify({
                Title = "Hitbox Expander",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(0, 255, 0)
            })
        else
            for player, _ in pairs(config.hitboxExpandedParts) do
                restoreTorso(player)
            end
            safeNotify({
                Title = "Hitbox Expander",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end, false)
    
lib:AddInputBox("Hitbox Size", function(text)
    local n = tonumber(text)
    if n and n > 0 then
        config.hitboxSize = n
        if config.hitboxEnabled then
            for player, data in pairs(config.hitboxExpandedParts) do
                if player and targethb(player) and data and data.part and data.part.Parent then
                    local newSize = Vector3.new(n, n, n)
                    data.targetSize = newSize
                    config.hitboxLastSize[player] = n
                    pcall(function()
                        data.part.Size = newSize
                    end)
                end
            end
        end
    end
    return tostring(config.hitboxSize)
end, "Enter Size...", "10", {
    min = 1,
    max = 99999,
    isNumber = true
})
    
    lib:AddComboBox("Team Target", {"Enemies", "Teams", "All"}, function(selection)
        if config.masterTeamTarget == "All" then
            return
        end
        
        config.hitboxTeamTarget = selection
        applyhb()
        
        if config.hitboxTeamTarget == "All" then
            config.masterTeamTarget = "All"
            updateTeamTargetModes()
        end
    end)
    lib:Tab("SilentAim")
    lib:AddToggle("Toggle SS (X)", function(state)
        config.Enabled = state

        if not config.Enabled then
            if gui.RingHolder then
                gui.RingHolder.Visible = false
            end
            for pl, _ in pairs(config.activeApplied) do
                restorePartForPlayer(pl)
            end
            safeNotify({
                Title = "SilentAim",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        else
            safeNotify({
                Title = "SilentAim",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(255, 100, 0)
            })
            if gui.RingHolder then
                gui.RingHolder.Visible = true
            end
            lrfd()
        end
    end, false)
    
    lib:AddToggle("Toggle Wall Check (B)", function(state)
        config.wallc = state
        if state then
            safeNotify({
                Title = "Wall Check",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(0, 170, 255)
            })
        else
            safeNotify({
                Title = "Wall Check",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end, false)

    lib:AddComboBox("Team Target", {"Enemies", "Teams", "All"}, function(selection)
        if config.masterTeamTarget == "All" then
            return
        end
        
        if selection == "Enemies" then
            config.targetMode = "Enemies"
        elseif selection == "Teams" then
            config.targetMode = "Teams"
        elseif selection == "All" then
            config.targetMode = "All"
        else
            config.targetMode = "Enemies"
        end
        
        if config.targetMode == "All" then
            config.masterTeamTarget = "All"
            updateTeamTargetModes()
        end
    end)

    lib:AddComboBox("Target Part", {"Head", "HumanoidRootPart", "Both"}, function(selection)
        for pl, _ in pairs(config.activeApplied) do
            restorePartForPlayer(pl)
        end
        if selection == "Head" then
            config.bodypart = "Head"
        elseif selection == "HumanoidRootPart" then
            config.bodypart = "HumanoidRootPart"
        elseif selection == "Both" then
            config.bodypart = "Both"
        else
            config.bodypart = "Head"
        end
    end)
    
    lib:AddInputBox("HitChance", function(text)
        local n = tonumber(text)
        if n and n >= 0 and n <= 100 then
            config.hitchance = n
        end
        return tostring(config.hitchance)
    end, "0-100", tostring(config.hitchance), {
        min = 0,
        max = 100,
        isNumber = true
    })
    
    lib:AddInputBox("FovSize", function(text)
        local n = tonumber(text)
        if n and n >= 1 then
            config.fovsize = n
            if gui.RingHolder then
                gui.RingHolder.Size = UDim2.new(0, math.max(8, config.fovsize * 2), 0, math.max(8, config.fovsize * 2))
            end
            return tostring(config.fovsize)
        else
            return tostring(config.fovsize)
        end
    end, "Enter Value...", tostring(config.fovsize), {
        min = 0,
        max = 211,
        isNumber = true
    })

    lib:Tab("Main")
    lib:AddComboBox("Master Team Target", {"Enemies", "Teams", "All"}, function(selection)
        if selection == "Enemies" then
            config.masterTeamTarget = "Enemies"
            config.targetMode = "Enemies"
        elseif selection == "Teams" then
            config.masterTeamTarget = "Teams"
            config.targetMode = "Teams"
        elseif selection == "All" then
            config.masterTeamTarget = "All"
            config.targetMode = "All"
        else
            config.masterTeamTarget = "Enemies"
            config.targetMode = "Enemies"
        end
        
        updateTeamTargetModes()
    end)

    lib:AddToggle("Toggle AutoFarm (P)", function(state)
        config.autoFarmEnabled = state
        
        if state then
            autoFarmProcess()
            safeNotify({
                Title = "AutoFarm",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 3,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 255, 0)
            })
        else
            stopAutoFarm()
            safeNotify({
                Title = "AutoFarm",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end, false)
    
    lib:AddComboBox("Align Part", {"Head", "HumanoidRootPart"}, function(selection)
        config.autoFarmTargetPart = selection
    end)
    
    lib:AddInputBox("TP Distance", function(text)
        local n = tonumber(text)
        if n and n >= 1 and n <= 100 then
            config.autoFarmDistance = n
        end
        return tostring(config.autoFarmDistance)
    end, "1-100", "10", {
        min = 1,
        max = 100,
        isNumber = true
    })
    
    lib:AddInputBox("Vertical Offset", function(text)
        local n = tonumber(text)
        if n then
            config.autoFarmVerticalOffset = n
        end
        return tostring(config.autoFarmVerticalOffset)
    end, "-50 to 50", "0", {
        min = -50,
        max = 50,
        isNumber = true
    })

    local fovScreenGui = Instance.new("ScreenGui")
    fovScreenGui.Name = "FOVToggleGui_Modern"
    fovScreenGui.ResetOnSpawn = false
    fovScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    fovScreenGui.Parent = localPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = fovScreenGui

    local ringHolder = Instance.new("Frame")
    ringHolder.Name = "RingHolder"
    ringHolder.AnchorPoint = Vector2.new(0.5, 0.5)
    ringHolder.Size = UDim2.new(0, config.fovsize * 2, 0, config.fovsize * 2)
    ringHolder.Position = UDim2.new(0.5, 0, 0.5, -28)
    ringHolder.BackgroundTransparency = 1
    ringHolder.Parent = mainFrame

    local ringCorner = Instance.new("UICorner")
    ringCorner.CornerRadius = UDim.new(1, 0)
    ringCorner.Parent = ringHolder

    local ringStroke = Instance.new("UIStroke")
    ringStroke.Thickness = 1
    ringStroke.LineJoinMode = Enum.LineJoinMode.Round
    ringStroke.Parent = ringHolder
    ringStroke.Color = Color3.fromRGB(200, 200, 255)
    ringStroke.Transparency = 0

    gui.ScreenGui = fovScreenGui
    gui.MainFrame = mainFrame
    gui.RingHolder = ringHolder
    gui.RingStroke = ringStroke
    gui.UI = lib
    aimbotfov()

    return lib
end

local notif1 = (function()
    pcall(function()
        safeNotify({
            Title = "Script loaded!",
            Content = "Script made by @hmmm5651\nYT: @gpsickle",
            Audio = "rbxassetid://17208361335",
            Length = 10,
            Image = "rbxassetid://4483362458",
            BarColor = Color3.fromRGB(0, 170, 255)
        })
    end)
end)()

local function init()
    makeui()

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= localPlayer then
            setupPlayerListeners(pl)
        end
    end

    Players.PlayerAdded:Connect(function(pl)
        if pl ~= localPlayer then
            setupPlayerListeners(pl)
        end
    end)
    Players.PlayerRemoving:Connect(function(pl)
        cleanplrdata(pl)
    end)

    RunService:BindToRenderStep("FOVhbUpdater_Modern", Enum.RenderPriority.First.Value, onRenderStep)

    if config.hotkeyConnection and config.hotkeyConnection.Connected then
        pcall(function() config.hotkeyConnection:Disconnect() end)
        config.hotkeyConnection = nil
    end

    config.hotkeyConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        local focused = UserInputService:GetFocusedTextBox()
        if focused then return end

        if input.UserInputType == Enum.UserInputType.Keyboard then
            local kc = input.KeyCode
            if kc == Enum.KeyCode.B then
                config.wallc = not config.wallc
                if config.wallc then
                    safeNotify({
                        Title = "Wall Check",
                        Content = "Enabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(0, 170, 255)
                    })
                else
                    safeNotify({
                        Title = "Wall Check",
                        Content = "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
            elseif kc == Enum.KeyCode.Z then
                toggleESP(not config.espEnabled)
                if config.espEnabled then
                    safeNotify({
                        Title = "Text ESP",
                        Content = "Enabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(0, 170, 255)
                    })
                else
                    safeNotify({
                        Title = "Text ESP",
                        Content = "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
            elseif kc == Enum.KeyCode.V then
                toggleHighlightESP(not config.highlightesp)
                if config.highlightesp then
                    safeNotify({
                        Title = "Highlight ESP",
                        Content = "Enabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(0, 170, 255)
                    })
                else
                    safeNotify({
                        Title = "Highlight ESP",
                        Content = "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
            elseif kc == Enum.KeyCode.P then
                config.autoFarmEnabled = not config.autoFarmEnabled
                
                if config.autoFarmEnabled then
                    autoFarmProcess()
                    safeNotify({
                        Title = "AutoFarm",
                        Content = "Enabled (Hotkey)" ..
                                 "\nAligning " .. config.autoFarmTargetPart .. " to crosshair",
                        Audio = "rbxassetid://17208361335",
                        Length = 3,
                        Image = "rbxassetid://4483362458",
                        BarColor = Color3.fromRGB(0, 255, 0)
                    })
                else
                    stopAutoFarm()
                    safeNotify({
                        Title = "AutoFarm",
                        Content = "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://4483362458",
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
            elseif kc == Enum.KeyCode.X then
                config.Enabled = not config.Enabled
                if not config.Enabled then
                    if gui.RingHolder then
                        gui.RingHolder.Visible = false
                    end
                    for pl, _ in pairs(config.activeApplied) do
                        restorePartForPlayer(pl)
                    end
                    safeNotify({
                        Title = "SilentAim",
                        Content = "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                else
                    if gui.RingHolder then
                        gui.RingHolder.Visible = true
                    end
                    lrfd()
                    safeNotify({
                        Title = "SilentAim",
                        Content = "Enabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(255, 100, 0)
                    })
                end
            elseif kc == Enum.KeyCode.G then
                config.aimbotEnabled = not config.aimbotEnabled
                if config.aimbotFOVRing and config.aimbotFOVRing.RingFrame then
                    config.aimbotFOVRing.RingFrame.Visible = config.aimbotEnabled
                end
                
                if config.aimbotEnabled then
                    if not config.aimbotFOVRing then
                        aimbotfov()
                    end
                    safeNotify({
                        Title = "Aimbot",
                        Content = "Enabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(0, 255, 0)
                    })
                else
                    config.aimbotCurrentTarget = nil
                    updateESPColors()
                    safeNotify({
                        Title = "Aimbot",
                        Content = "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
            elseif kc == Enum.KeyCode.H then
                config.aimbotWallCheck = not config.aimbotWallCheck
                if config.aimbotWallCheck then
                    safeNotify({
                        Title = "Aimbot Wall Check",
                        Content = "Enabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(0, 170, 255)
                    })
                else
                    safeNotify({
                        Title = "Aimbot Wall Check",
                        Content = "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
            elseif kc == Enum.KeyCode.F then
                config.hitboxEnabled = not config.hitboxEnabled
                if config.hitboxEnabled then
                    applyhb()
                    safeNotify({
                        Title = "Hitbox Expander",
                        Content = "Enabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(0, 255, 0)
                    })
                else
                    for player, _ in pairs(config.hitboxExpandedParts) do
                        restoreTorso(player)
                    end
                    safeNotify({
                        Title = "Hitbox Expander",
                        Content = "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://",
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
            elseif kc == Enum.KeyCode.L then
                config.antiAimEnabled = not config.antiAimEnabled
                if not config.antiAimEnabled then
                    returnToOriginalPosition()
                    safeNotify({
                        Title = "AntiAim",
                        Content = "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://4483362458",
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                else
                    safeNotify({
                        Title = "AntiAim",
                        Content = "Enabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://4483362458",
                        BarColor = Color3.fromRGB(255, 100, 0)
                    })
                end
            elseif kc == Enum.KeyCode.T then
                updateTeamTargetModes()
            end
        end
    end)
end
local function cleanup()
    pcall(function()
        RunService:UnbindFromRenderStep("FOVhbUpdater_Modern")
    end)
    stopAutoFarm()
    if config.hotkeyConnection then
        pcall(function() config.hotkeyConnection:Disconnect() end)
        config.hotkeyConnection = nil
    end

    for pl, _ in pairs(config.activeApplied) do
        restorePartForPlayer(pl)
    end
    
    for pl, _ in pairs(config.hitboxExpandedParts) do
        restoreTorso(pl)
    end

    for pl, _ in pairs(config.espData) do
        removeESPLabel(pl)
    end

    for pl, _ in pairs(config.highlightData) do
        removeHighlightESP(pl)
    end

    for pl, connections in pairs(config.playerConnections) do
        for _, conn in ipairs(connections) do
            pcall(function() conn:Disconnect() end)
        end
        config.playerConnections[pl] = nil
    end

    for pl, conn in pairs(config.characterConnections) do
        pcall(function() conn:Disconnect() end)
    end

    if gui and gui.ScreenGui and gui.ScreenGui.Parent then
        gui.ScreenGui:Destroy()
    end
    
    if config.aimbotFOVRing and config.aimbotFOVRing.ScreenGui and config.aimbotFOVRing.ScreenGui.Parent then
        config.aimbotFOVRing.ScreenGui:Destroy()
    end

    config.activeApplied = {}
    config.originalSizes = {}
    config.espData = {}
    config.highlightData = {}
    config.targethbSizes = {}
    config.playerConnections = {}
    config.characterConnections = {}
    config.centerLocked = {}
    config.currentAntiAimTarget = nil
    config.hitboxExpandedParts = {}
    config.hitboxOriginalSizes = {}
end

init()

return {
    cleanup = cleanup
}
-- fin
