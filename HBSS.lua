-- Gravel.cc
repeat wait() until game:IsLoaded()

for _, v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
    v:Disable()
end

for _, v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
    v:Disable()
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Teams = game:GetService("Teams")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local localPlayer = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
local bg = Instance.new("Frame")
local center = Instance.new("Frame")
local brand = Instance.new("TextLabel")
local loadingText = Instance.new("TextLabel")
local bar = Instance.new("TextLabel")
local icon = Instance.new("ImageLabel")
local aspect = Instance.new("UIAspectRatioConstraint")
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "FakeLoader"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 2147483647
gui.Parent = PlayerGui
bg.Size = UDim2.fromScale(1, 1)
bg.BackgroundColor3 = Color3.new(0, 0, 0)
bg.BackgroundTransparency = 1
bg.Parent = gui
center.Size = UDim2.fromScale(0.3, 0.4)
center.Position = UDim2.fromScale(0.5, 0.5)
center.AnchorPoint = Vector2.new(0.5, 0.5)
center.BackgroundTransparency = 1
center.Parent = bg
icon.Size = UDim2.fromScale(0.5, 0.5)
icon.Position = UDim2.fromScale(0.5, 0.10)
icon.AnchorPoint = Vector2.new(0.5, 0.5)
icon.Image = "rbxassetid://7734056878"
icon.BackgroundTransparency = 1
icon.ImageTransparency = 1
icon.ScaleType = Enum.ScaleType.Fit
icon.Parent = center
aspect.AspectRatio = 1
aspect.Parent = icon
brand.Size = UDim2.fromScale(1, 0.15)
brand.Position = UDim2.fromScale(0.5, 0.42)
brand.AnchorPoint = Vector2.new(0.5, 0.5)
brand.Text = "Gravel.cc"
brand.Font = Enum.Font.Code
brand.TextSize = 22
brand.TextColor3 = Color3.fromRGB(200, 200, 200)
brand.TextTransparency = 1
brand.BackgroundTransparency = 1
brand.Parent = center
loadingText.Size = UDim2.fromScale(1, 0.15)
loadingText.Position = UDim2.fromScale(0.5, 0.6)
loadingText.AnchorPoint = Vector2.new(0.5, 0.5)
loadingText.Text = "Loading"
loadingText.Font = Enum.Font.Code
loadingText.TextSize = 18
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.TextTransparency = 1
loadingText.BackgroundTransparency = 1
loadingText.Parent = center
bar.Size = UDim2.fromScale(1, 0.15)
bar.Position = UDim2.fromScale(0.5, 0.75)
bar.AnchorPoint = Vector2.new(0.5, 0.5)
bar.Font = Enum.Font.Code
bar.TextSize = 18
bar.TextColor3 = Color3.fromRGB(255, 255, 255)
bar.TextTransparency = 1
bar.BackgroundTransparency = 1
bar.Text = "[                    ]"
bar.Parent = center

local fadeIn = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

TweenService:Create(bg, fadeIn, {BackgroundTransparency = 0.1}):Play()
TweenService:Create(icon, fadeIn, {ImageTransparency = 0}):Play()
TweenService:Create(brand, fadeIn, {TextTransparency = 0}):Play()
TweenService:Create(loadingText, fadeIn, {TextTransparency = 0}):Play()
TweenService:Create(bar, fadeIn, {TextTransparency = 0}):Play()

task.spawn(function()
    local totalBars = 20
    local filled = 0
    local maxDuration = 3.25
    local startTime = tick()
    local elapsed = 0
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9120299810"
    sound.Volume = 0.5
    sound.Parent = SoundService
    
    while elapsed < maxDuration do
        task.wait(math.random(10, 30) / 100)
        elapsed = tick() - startTime
        
        local targetFilled = math.min(totalBars, math.floor((elapsed / maxDuration) * totalBars))
        
        if targetFilled > filled then
            for i = filled + 1, targetFilled do
                sound:Play()
            end
            filled = targetFilled
        elseif math.random() < 0.75 and filled < totalBars then
            sound:Play()
            filled = math.min(totalBars, filled + 1)
        end

        local visual = string.rep("|", filled)
        local empty = string.rep(" ", totalBars - filled)
        bar.Text = "[" .. visual .. empty .. "]"
        if math.random() < 0.3 then
            loadingText.Text = "Loading."
        elseif math.random() < 0.6 then
            loadingText.Text = "Loading.."
        else
            loadingText.Text = "Loading..."
        end
    end

    filled = totalBars
    bar.Text = "[" .. string.rep("|", totalBars) .. "]"
    loadingText.Text = "Loaded"

    task.wait(0.6)
    sound:Destroy()
    local fadeOut = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

    TweenService:Create(bg, fadeOut, {BackgroundTransparency = 1}):Play()
    TweenService:Create(icon, fadeOut, {ImageTransparency = 1}):Play()
    TweenService:Create(brand, fadeOut, {TextTransparency = 1}):Play()
    TweenService:Create(loadingText, fadeOut, {TextTransparency = 1}):Play()
    TweenService:Create(bar, fadeOut, {TextTransparency = 1}):Play()

    task.wait(1)
    gui:Destroy()
end)
task.wait(2.30)
local function Hook_Adonis(metadefs)
	for _ , tbl in metadefs do
		for i, func in tbl do
			if type(func) == "function" and islclosure(func) then
				local dummy_func = function()
					return pcall(coroutine.close, coroutine.running())
				end
				hookfunction(func, dummy_func)
			end
		end
	end
end
local function Init_Bypass()
	for i, v in getgc(true) do
		if
			typeof(v) == "table"
			and rawget(v, "indexInstance")
			and rawget(v, "newindexInstance")
			and rawget(v, "namecallInstance")
			and type(rawget(v,"newindexInstance")) == "table"
		then
			if v["newindexInstance"][1] == "kick" then
				Hook_Adonis(v)
			end
		end
	end
end

task.spawn(Init_Bypass)

local ValidTargetParts = {"Head", "HumanoidRootPart", "Torso", "UpperTorso", "LowerTorso", "RightUpperArm", "LeftUpperArm", "RightLowerArm", "LeftLowerArm", "RightHand", "LeftHand", "RightUpperLeg", "LeftUpperLeg", "RightLowerLeg", "LeftLowerLeg", "RightFoot", "LeftFoot"}
local mouse = plr:GetMouse()
local Camera = workspace.CurrentCamera
local FindFirstChild = game.FindFirstChild
local GetPlayers = plrs.GetPlayers
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local wasEnabledBeforeDeath = false
local wasESPEnabledBeforeDeath = false  -- Add this lin
local respawnLock = false
local lastCharacter = nil
local camera = workspace.CurrentCamera
local aimbot360LoopRunning = false
local aimbot360LoopTask = nil
local desyncHook = nil
local gui = {}
local patcher = true
local patcherwait = 0.3

local FindTool = loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/HBSS/refs/heads/main/SA2_FindTool.lua"))()
local func = loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/HBSS/refs/heads/main/SA2_Function.lua"))()
local lastTargetUpdate = 0

-- random stuff lololol
local config = {
    startsa = false,
    fovsize = 120,
    predic = 1,
    hbtrans = 1,
    SA2_Enabled = false,
    SA2_Method = "Raycast",
    SA2_TeamTarget = "Enemies",
    SA2_Wallcheck = false,
    SA2_TargetPart = "Head",
    SA2_HitChance = 100,
    SA2_FovRadius = 100,
    SA2_FovVisible = true,
    SA2_FovTransparency = 0.90,
    SA2_FovColor = Color3.new(0, 0, 0),
    SA2_FovColourTarget = Color3.new(1, 1, 0),
    SA2_FovIsTargeted = false,
    SA2_ThreeSixtyMode = false,
    SA2_GetTarget = "Closest",
    SA2_currentTarget = nil,
    SA2_TArea = 35,
    currentTarget = nil,
    espc = Color3.fromRGB(255, 182, 193),
    esptargetc = Color3.fromRGB(255, 255, 0),
    espteamc = Color3.fromRGB(0, 255, 0),
    rfd = false,
    eme = true,
    wallc = false,
    bodypart = "Head",
    espon = false,
    prefTextESP = false,
    highlightesp = false,
    prefHighlightESP = false,
    prefBoxESP = false,
    prefHealthESP = false,
    prefColorByHealth = false,
    espMasterEnabled = false,
    prefHeadDotESP = false,
    lineESPEnabled = false,
    lineESPOnlyTarget = false,
    lineStartPosition = "Center",
    lineColor = Color3.fromRGB(255, 255, 255),
    lineThickness = 1,
    lineESPData = {},
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
    targetMode = "Enemies",
    centerLocked = {},
    hitchance = 100,
    hotkeyConnection = nil,
    maxExpansion = math.huge,
    aimbotEnabled = false,
    aimbotFOVSize = 70,
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
    hitboxColor = Color3.fromRGB(255, 255, 255),
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
    antiAimOrbitEnabled = false,
    antiAimOrbitSpeed = 5,
    antiAimOrbitRadius = 5,
    antiAimOrbitHeight = 0,
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
    autoFarmMinRange = 0,
    autoFarmMaxRange = 50,
    autoFarmOriginalPositions = {}, 
    autoFarmWallCheck = false,
    aimbot360Enabled = false,
    aimbot360OriginalFOV = 100,
    gp = 200,
    targetSeenMode = "Switch",
    targetSeenSwitchRate = 0.2,
    lastTargetSwitchTime = 0,
    targetSeenTargets = {},
    aimbot360Omnidirectional = true,
    aimbot360BehindRange = 180,
    aimbot360WasEnabled = false,
    masterTarget = "Players",
    clientMasterEnabled = false,
    clientWalkSpeed = 16,
    clientJumpPower = 50,
    clientNoclip = false,
    clientCFrameWalkEnabled = false,
    clientCFrameSpeed = 1,
    clientConnections = {},
    clientOriginals = {},
    _tpwalking = false,
    clientWalkEnabled = false,
    clientJumpEnabled = false,
    clientNoclipEnabled = false,
    clientCFrameWalkToggle = false,
    masterGetTarget = "Closest",
    aimbotGetTarget = "Closest",
    silentGetTarget = "Closest",
    antiAimGetTarget = "Closest",
    autoFarmPartClaimStarted = false,
    autoFarmLastRefresh = 0,
    desyncEnabled = false,
    desyncToggleEnabled = false,
    customDesyncEnabled = false,
    desyncX = 0,
    desyncY = 0,
    desyncZ = -2,
    desyncLoc = CFrame.new(),
    nextGenRepEnabled = false,
    nextGenRepDesiredState = false,
    ignoreForcefield = true,
    QuickToggles = false,
    keybinds = {
        silentaim = "E",
        aimbot = "Q",
        autofarm = "F",
        antiaim = "L",
        hitbox = "G",
        esp = "Z",
        client = "V",
        silentaimwallcheck = "B",
        aimbotwallcheck = "H",
        silentaimhk = "R",
        silentaimhkwallcheck = "T",
    },
    holdkeyToggle = {
        enabled = false,
        modifier = "RCtrl"
    },
    holdkeystates = {}
}


local function hasForcefield(character)
    if not character then return false end
    
    if config.ignoreForcefield == false then
        return false
    end
    
    local forcefield = character:FindFirstChildOfClass("ForceField")
    if forcefield then return true end
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("ForceField") then
            return true
        elseif child.Name:lower():find("shield") or 
               child.Name:lower():find("forcefield") or
               child.Name:lower():find("invincible") or
               child.Name:lower():find("invulnerable") then
            if child:IsA("BasePart") or child:IsA("Model") or child:IsA("Folder") then
                for _, descendant in ipairs(child:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or 
                       descendant:IsA("Beam") or 
                       descendant:IsA("Trail") then
                        return true
                    end
                end
            end
            return true
        end
    end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if humanoid.MaxHealth == math.huge or humanoid.Health == math.huge then
            return true
        end
        
        if humanoid:GetState() == Enum.HumanoidStateType.Physics then
            return true
        end
    end
    
    return false
end

local function GetRandomTargetPart()
    return ValidTargetParts[math.random(1, #ValidTargetParts)]
end
local function GetActualTargetPart()
    if config.SA2_TargetPart == "Random" then
        return GetRandomTargetPart()
    end
    return config.SA2_TargetPart
end

local function ArePlayersSameTeam(player1, player2)
    if not player1 or not player2 then return false end
    
    local team1 = player1.Team
    local team2 = player2.Team
    if not team1 or not team2 then return false end
    
    return team1 == team2
end

local function ShouldTargetPlayer(targetPlayer)
    if targetPlayer == plr then return false end
    
    if config.SA2_TeamTarget == "All" then
        return true
    elseif config.SA2_TeamTarget == "Enemies" then
        return not ArePlayersSameTeam(plr, targetPlayer)
    elseif config.SA2_TeamTarget == "Teams" then
        return ArePlayersSameTeam(plr, targetPlayer)
    end
    
    return false
end

local IsPlayerVisible = function(Player)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = plr.Character
    
    if not (PlayerCharacter or LocalPlayerCharacter) then return end
    
    local actualTargetPart = GetActualTargetPart()
    local PlayerRoot = FindFirstChild(PlayerCharacter, actualTargetPart) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    
    if not PlayerRoot then return end
    
    local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)
    
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

local function syncSilentAimWithMaster()
    if config.masterTeamTarget == "All" then
        config.SA2_TeamTarget = "All"
    elseif config.SA2_TeamTarget ~= config.masterTeamTarget and 
           config.masterTeamTarget ~= nil then
        if not config.SA2_TeamTarget then
            config.SA2_TeamTarget = config.masterTeamTarget
        end
    end
    
    if config.masterGetTarget then
        config.silentGetTarget = config.masterGetTarget
        config.SA2_GetTarget = config.masterGetTarget
    end
end

local function GetClosestPlayer()
    if respawnLock or not plr.Character then
        if config.SA2_currentTarget then
            config.SA2_currentTarget = nil
            updateESPColors()
        end
        return nil
    end
    
    local Closest = nil
    local ShortestDistance = math.huge
    local LowestHealth = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local allTargets = {}
    
    for _, Player in next, GetPlayers(plrs) do
        if Player == plr then continue end
        if not ShouldTargetPlayer(Player) then continue end
        
        local Character = Player.Character
        if not Character then continue end
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not Humanoid or Humanoid.Health <= 0 then continue end
        if config.SA2_Wallcheck and not IsPlayerVisible(Player) then continue end
        
        local bodyPartsToCheck = {"HumanoidRootPart", "Head", "Torso", "UpperTorso"}
        local foundPart = nil
        
        for _, partName in ipairs(bodyPartsToCheck) do
            local bodyPart = FindFirstChild(Character, partName)
            if bodyPart then
                foundPart = bodyPart
                break
            end
        end
        
        if not foundPart then continue end
        local screenPos, onScreen = func.GetScreenPosition(foundPart.Position)
        if not onScreen then continue end
        screenPos = screenPos + Vector2.new(0, config.SA2_TArea)
        
        local distToFov = (screenCenter - screenPos).Magnitude
        if distToFov > config.SA2_FovRadius then continue end
        
        local worldDist = (Camera.CFrame.Position - foundPart.Position).Magnitude
        
        if config.SA2_ThreeSixtyMode then
            OnScreen = true
            ScreenPosition = screenCenter
        end
        
        local distanceToCenter = onScreen and (screenCenter - screenPos).Magnitude or math.huge
        
        table.insert(allTargets, {
            player = Player,
            character = Character,
            part = foundPart,
            humanoid = Humanoid,
            health = Humanoid.Health,
            screenPos = screenPos,
            onScreen = onScreen,
            distanceToCenter = distanceToCenter,
            worldDist = worldDist
        })
    end
    
    if #allTargets == 0 then
        if config.SA2_currentTarget then
            config.SA2_currentTarget = nil
            updateESPColors()
        end
        return nil
    end
    
    if config.SA2_ThreeSixtyMode then
        local newClosestPlayer = nil
        for _, target in ipairs(allTargets) do
            if target.worldDist < ShortestDistance then
                ShortestDistance = target.worldDist
                local actualTargetPart = GetActualTargetPart()
                Closest = target.character[actualTargetPart] or target.part
                newClosestPlayer = target.player
            end
        end
        if newClosestPlayer ~= config.SA2_currentTarget then
            config.SA2_currentTarget = newClosestPlayer
            updateESPColors()
        end
        
        return Closest
    end
    
    local newClosestPlayer = nil
    local getTargetMethod = config.masterGetTarget or config.SA2_GetTarget or "Closest"
    
    if getTargetMethod == "Lowest Health" then
        for _, target in ipairs(allTargets) do
            if target.onScreen and target.health < LowestHealth then
                LowestHealth = target.health
                local actualTargetPart = GetActualTargetPart()
                Closest = target.character[actualTargetPart] or target.part
                newClosestPlayer = target.player
            end
        end
    elseif getTargetMethod == "TargetSeen" then
        local targetsInFOV = {}
        
        for _, target in ipairs(allTargets) do
            if target.onScreen and target.distanceToCenter <= config.SA2_FovRadius then
                table.insert(targetsInFOV, target)
            end
        end
        
        if #targetsInFOV > 0 then
            if config.targetSeenMode == "Switch" then
                local currentTime = tick()
                if currentTime - config.lastTargetSwitchTime >= config.targetSeenSwitchRate then
                    config.lastTargetSwitchTime = currentTime
                    
                    if not config.SA2_currentTarget then
                        local closestInFOV = nil
                        local closestDist = math.huge
                        for _, target in ipairs(targetsInFOV) do
                            if target.distanceToCenter < closestDist then
                                closestDist = target.distanceToCenter
                                closestInFOV = target
                            end
                        end
                        if closestInFOV then
                            local actualTargetPart = GetActualTargetPart()
                            Closest = closestInFOV.character[actualTargetPart] or closestInFOV.part
                            config.SA2_currentTarget = closestInFOV.player
                            newClosestPlayer = closestInFOV.player
                        end
                    else
                        local currentIndex = nil
                        for i, target in ipairs(targetsInFOV) do
                            if target.player == config.SA2_currentTarget then
                                currentIndex = i
                                break
                            end
                        end
                        
                        if currentIndex then
                            local nextIndex = (currentIndex % #targetsInFOV) + 1
                            local nextTarget = targetsInFOV[nextIndex]
                            local actualTargetPart = GetActualTargetPart()
                            Closest = nextTarget.character[actualTargetPart] or nextTarget.part
                            config.SA2_currentTarget = nextTarget.player
                            newClosestPlayer = nextTarget.player
                        else
                            local closestInFOV = nil
                            local closestDist = math.huge
                            for _, target in ipairs(targetsInFOV) do
                                if target.distanceToCenter < closestDist then
                                    closestDist = target.distanceToCenter
                                    closestInFOV = target
                                end
                            end
                            if closestInFOV then
                                local actualTargetPart = GetActualTargetPart()
                                Closest = closestInFOV.character[actualTargetPart] or closestInFOV.part
                                config.SA2_currentTarget = closestInFOV.player
                                newClosestPlayer = closestInFOV.player
                            end
                        end
                    end
                else
                    if config.SA2_currentTarget then
                        for _, target in ipairs(targetsInFOV) do
                            if target.player == config.SA2_currentTarget then
                                local actualTargetPart = GetActualTargetPart()
                                Closest = target.character[actualTargetPart] or target.part
                                newClosestPlayer = target.player
                                break
                            end
                        end
                    end
                end
            elseif config.targetSeenMode == "All" then
                local closestInFOV = nil
                local closestDist = math.huge
                for _, target in ipairs(targetsInFOV) do
                    if target.distanceToCenter < closestDist then
                        closestDist = target.distanceToCenter
                        closestInFOV = target
                    end
                end
                if closestInFOV then
                    local actualTargetPart = GetActualTargetPart()
                    Closest = closestInFOV.character[actualTargetPart] or closestInFOV.part
                    config.SA2_currentTarget = closestInFOV.player
                    newClosestPlayer = closestInFOV.player
                end
            end
        else
            config.SA2_currentTarget = nil
            newClosestPlayer = nil
        end
    else
        for _, target in ipairs(allTargets) do
            if target.onScreen and target.distanceToCenter <= config.SA2_FovRadius and target.distanceToCenter < ShortestDistance then
                local actualTargetPart = GetActualTargetPart()
                Closest = target.character[actualTargetPart] or target.part
                ShortestDistance = target.distanceToCenter
                newClosestPlayer = target.player
            end
        end
    end
    
    if newClosestPlayer ~= config.SA2_currentTarget then
        config.SA2_currentTarget = newClosestPlayer
        updateESPColors()
    end
    
    return Closest
end
local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    if respawnLock then
        return OldNamecall(...)
    end
    
    local Method = getnamecallmethod()
    local Args = {...}
    local self = Args[1]
    local chance = func.HitChance(config.SA2_HitChance)
    
    if config.SA2_Enabled and self == workspace and not checkcaller() then
        if not config.SA2_ThreeSixtyMode and not chance then
            config.SA2_FovIsTargeted = false
            return OldNamecall(...)
        end
        
        local HitPart = GetClosestPlayer()
        if HitPart then
            config.SA2_FovIsTargeted = true
            if config.SA2_Method == "All" then
                if Method == "FindPartOnRayWithIgnoreList" or Method == "FindPartOnRayWithWhitelist" or Method == "FindPartOnRay" or Method == "findPartOnRay" or Method == "Raycast" then
                    local A_Origin = Args[2].Origin or Args[2]
                    local Direction = func.Direction(A_Origin, HitPart.Position)
                    if Method == "Raycast" then
                        Args[3] = Direction
                    else
                        Args[2] = Ray.new(A_Origin, Direction)
                    end
                    return OldNamecall(unpack(Args))
                end
            elseif Method == "FindPartOnRayWithIgnoreList" and config.SA2_Method == "FindPartOnRayWithIgnoreList" then
                local A_Ray = Args[2]
                local Origin = A_Ray.Origin
                local Direction = func.Direction(Origin, HitPart.Position)
                Args[2] = Ray.new(Origin, Direction)
                return OldNamecall(unpack(Args))
            elseif Method == "FindPartOnRayWithWhitelist" and config.SA2_Method == "FindPartOnRayWithWhitelist" then
                local A_Ray = Args[2]
                local Origin = A_Ray.Origin
                local Direction = func.Direction(Origin, HitPart.Position)
                Args[2] = Ray.new(Origin, Direction)
                return OldNamecall(unpack(Args))
            elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") and config.SA2_Method == "FindPartOnRay" then
                local A_Ray = Args[2]
                local Origin = A_Ray.Origin
                local Direction = func.Direction(Origin, HitPart.Position)
                Args[2] = Ray.new(Origin, Direction)
                return OldNamecall(unpack(Args))
            elseif Method == "Raycast" and config.SA2_Method == "Raycast" then
                local A_Origin = Args[2]
                Args[3] = func.Direction(A_Origin, HitPart.Position)
                return OldNamecall(unpack(Args))
            end
        else
            config.SA2_FovIsTargeted = false
        end
    end
    return OldNamecall(...)
end))

local OldIndex
OldIndex = hookmetamethod(game, "__index", newcclosure(function(Self, Index)
    if respawnLock then
        return OldIndex(Self, Index)
    end
    
    if config.SA2_Enabled and config.SA2_Method == "Mouse.Hit" and not checkcaller() and Self == mouse and Index == "Hit" then
        local HitPart = GetClosestPlayer()
        if HitPart then
            config.SA2_FovIsTargeted = true
            return HitPart.CFrame
        else
            config.SA2_FovIsTargeted = false
        end
    end
    return OldIndex(Self, Index)
end))
local ScreenGui = Instance.new("ScreenGui")
local CircleFrame = Instance.new("Frame")
local UIStroke = Instance.new("UIStroke")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "FOVSys"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.IgnoreGuiInset = true

CircleFrame.Name = "FOVCircle"
CircleFrame.Parent = ScreenGui
CircleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
CircleFrame.BackgroundColor3 = config.SA2_FovColor
CircleFrame.BackgroundTransparency = 1
CircleFrame.BorderSizePixel = 0

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = CircleFrame

UIStroke.Color = config.SA2_FovColor
UIStroke.Thickness = 1
UIStroke.Transparency = 1 - config.SA2_FovTransparency
UIStroke.Parent = CircleFrame
RunService.RenderStepped:Connect(function()
    local viewportSize = Camera.ViewportSize
    if viewportSize.X == 0 then return end
    
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    
    if respawnLock then
        CircleFrame.Visible = false
        return
    end
    if config.SA2_Enabled and config.SA2_FovVisible and not config.SA2_ThreeSixtyMode then
        local currentTarget = GetClosestPlayer()
        
        CircleFrame.Visible = true
        CircleFrame.Position = UDim2.new(0, screenCenter.X, 0, screenCenter.Y)
        CircleFrame.Size = UDim2.new(0, config.SA2_FovRadius * 2, 0, config.SA2_FovRadius * 2)
        
        local targetColor = currentTarget and config.SA2_FovColourTarget or config.SA2_FovColor
        UIStroke.Color = targetColor
        UIStroke.Transparency = 1 - config.SA2_FovTransparency
    else
        CircleFrame.Visible = false
    end
end)

local function isSilentAimTargetingPlayer(targetPlayer)
    if not config.SA2_Enabled then
        return false
    end
    
    local currentTarget = GetClosestPlayer()
    if not currentTarget then
        return false
    end
    local targetChar = currentTarget.Parent
    if not targetChar or not targetChar:IsA("Model") then
        return false
    end
    local player = Players:GetPlayerFromCharacter(targetChar)
    return player == targetPlayer
end

local function isPlayerBeingTargeted(targetPlayer)
    if isSilentAimTargetingPlayer(targetPlayer) then
        return true, "silentaim_hk"
    end
    if config.currentTarget == targetPlayer then
        return true, "silentaim"
    end
    if config.aimbotCurrentTarget == targetPlayer then
        return true, "aimbot"
    end
    
    return false, nil
end
local function calculateDiameter(worldDist, screenRadius, cam)
    if not cam then cam = workspace.CurrentCamera end
    if not cam then return 0.1 end
    
    local viewportSize = cam.ViewportSize
    local H = viewportSize.Y
    local vFovDeg = cam.FieldOfView
    local vFovRad = math.rad(vFovDeg)
    local halfVFov = vFovRad / 2
    local alpha = (screenRadius / (H / 2)) * halfVFov
    local worldHalf = worldDist * math.tan(alpha)
    local worldFull = worldHalf * 2
    return math.max(0.01, worldFull)
end

local function nextgenrep(state)
    config.nextGenRepDesiredState = state
    if state and not config.antiAimEnabled then
        return
    end
    
    if state then
        setfflag("NextGenReplicatorEnabledWrite4", "false")
        task.wait(0.1)
        setfflag("NextGenReplicatorEnabledWrite4", "true")
        config.nextGenRepEnabled = true
    else
        setfflag("NextGenReplicatorEnabledWrite4", "false")
        config.nextGenRepEnabled = false
        config.nextGenRepDesiredState = false
    end
end

local function nextgenrep2(state)
    if state then
        setfflag("NextGenReplicatorEnabledWrite4", "false")
        task.wait(0.1)
        setfflag("NextGenReplicatorEnabledWrite4", "true")
    else
        setfflag("NextGenReplicatorEnabledWrite4", "false")
    end
end

local function isHoldKeyDown()
    if not config.holdkeyToggle.enabled then
        return true
    end
    local modifier = config.holdkeyToggle.modifier or "RCtrl"
    
    if modifier == "RCtrl" then
        return UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
    elseif modifier == "LCtrl" then
        return UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
    elseif modifier == "RShift" then
        return UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
    elseif modifier == "LShift" then
        return UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
    end
    
    return false
end

local function canTriggerKeybind()
    if config.holdkeyToggle.enabled then
        return isHoldKeyDown()
    end
    return true
end

local function updateHoldkeyState()
    if not config.holdkeyToggle.enabled then
        config.holdkeyStates = {}
    end
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))()
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

if not math.clamp then
    function math.clamp(x, a, b)
        if x < a then return a end
        if x > b then return b end
        return x
    end
end

local function updateTeamTargetModes()
    local masterTeamSelection = config.masterTeamTarget or "Enemies"
    
    if masterTeamSelection == "All" then
        config.targetMode = "All"
        config.aimbotTeamTarget = "All"
        config.hitboxTeamTarget = "All"
        config.antiAimTarget = "All"
    else
        config.targetMode = masterTeamSelection
        config.aimbotTeamTarget = masterTeamSelection
        config.hitboxTeamTarget = masterTeamSelection
        config.antiAimTarget = masterTeamSelection
    end
    if config.masterGetTarget then
        config.aimbotGetTarget = config.masterGetTarget
        config.silentGetTarget = config.masterGetTarget
        config.antiAimGetTarget = config.masterGetTarget
    end

    if config.espMasterEnabled then
        local targetsToRemove = {}
        for target, _ in pairs(config.espData) do
            table.insert(targetsToRemove, target)
        end
        for _, target in ipairs(targetsToRemove) do
            removeESPLabel(target)
        end
        
        local targetsToRemoveHigh = {}
        for target, _ in pairs(config.highlightData) do
            table.insert(targetsToRemoveHigh, target)
        end
        for _, target in ipairs(targetsToRemoveHigh) do
            removeHighlightESP(target)
        end
        
        local targets = getAllTargets()
        for _, target in ipairs(targets) do
            if addesp(target) then
                if config.prefTextESP or config.prefBoxESP or config.prefHealthESP or config.prefHeadDotESP then
                    makeesp(target)
                end
                if config.prefHighlightESP and getTargetCharacter(target) then
                    high(target)
                end
            end
        end
    end
    applyhb()
    config.aimbotCurrentTarget = nil
    config.currentTarget = nil
    updateESPColors()
end


local function applyESPMaster(state)
    config.espMasterEnabled = state

    if not state then
        for target in pairs(config.espData) do
            removeESPLabel(target)
        end

        for target in pairs(config.highlightData) do
            removeHighlightESP(target)
        end
        
        for target in pairs(config.lineESPData) do
            removeLineESP(target)
        end

        config.espon = false
        config.highlightesp = false
    else
        if config.prefHighlightESP then
            for _, target in ipairs(getAllTargets()) do
                if addesp(target) and getTargetCharacter(target) then
                    high(target)
                end
            end
        end

        if config.prefTextESP or config.prefBoxESP or
           config.prefHealthESP or config.prefHeadDotESP then
            for _, target in ipairs(getAllTargets()) do
                if addesp(target) then
                    makeesp(target)
                end
            end
        end
        
        task.spawn(function()
            task.wait(0.1)
            updateLineESP()
            updateESPColors()
        end)

        config.espon = config.prefTextESP
        config.highlightesp = config.prefHighlightESP
    end

    updateESPColors()
end

RunService.RenderStepped:Connect(function()
    local currentTime = tick()
    if currentTime - lastTargetUpdate > 0.6 then
        lastTargetUpdate = currentTime
        updateESPColors()
    end
end)

local function pc()
    local plr = game.Players.LocalPlayer
    task.spawn(function()
        while true do
            pcall(function()
                plr.ReplicationFocus = workspace
                plr.MaximumSimulationRadius = math.huge
                plr.SimulationRadius = config.gp
            end)
            task.wait(0.1)
        end
    end)
end

local function isNPCModel(model)
    if not model or not model:IsA("Model") then return false end
    if Players:GetPlayerFromCharacter(model) then return false end
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health ~= nil then
        if model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head") then
            return true
        end
    end
    return false
end

local function getAllTargets(getTargetSeen)
    local targets = {}

    if config.masterTarget == "Players" or config.masterTarget == "Both" then
        for _, pl in ipairs(Players:GetPlayers()) do
            if pl ~= localPlayer then
                if getTargetSeen then
                    local char = getTargetCharacter(pl)
                    if char then
                        local head = char:FindFirstChild("Head")
                        local root = char:FindFirstChild("HumanoidRootPart")
                        local targetPos = (head or root) and (head or root).Position
                        
                        if targetPos then
                            local screenPos, onScreen = camera:WorldToViewportPoint(targetPos)
                            if onScreen and screenPos.Z > 0 then
                                local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                                local screenVec = Vector2.new(screenPos.X, screenPos.Y)
                                local distPx = (screenVec - center).Magnitude
                                
                                local fovSize = config.masterGetTarget == "TargetSeen" and config.fovsize or config.aimbotFOVSize
                                if distPx <= fovSize then
                                    table.insert(targets, pl)
                                end
                            end
                        end
                    end
                else
                    table.insert(targets, pl)
                end
            end
        end
    end

    if config.masterTarget == "NPCs" or config.masterTarget == "Both" then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Model") and isNPCModel(obj) then
                if not Players:GetPlayerFromCharacter(obj) then
                    if getTargetSeen then
                        local head = obj:FindFirstChild("Head")
                        local root = obj:FindFirstChild("HumanoidRootPart")
                        local targetPos = (head or root) and (head or root).Position
                        
                        if targetPos then
                            local screenPos, onScreen = camera:WorldToViewportPoint(targetPos)
                            if onScreen and screenPos.Z > 0 then
                                local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                                local screenVec = Vector2.new(screenPos.X, screenPos.Y)
                                local distPx = (screenVec - center).Magnitude
                                
                                local fovSize = config.masterGetTarget == "TargetSeen" and config.fovsize or config.aimbotFOVSize
                                if distPx <= fovSize then
                                    table.insert(targets, obj)
                                end
                            end
                        end
                    else
                        table.insert(targets, obj)
                    end
                end
            end
        end
    end

    return targets
end

local function getTargetCharacter(target)
    if not target then return nil end
    if typeof(target) == "Instance" then
        if target:IsA("Player") then
            return target.Character
        elseif target:IsA("Model") then
            return target
        end
    end
    return nil
end

local function getTargetName(target)
    if not target then return "Unknown" end
    if typeof(target) == "Instance" then
        return target.Name
    end
    return tostring(target)
end

local function isTeammate(p)
    if not (localPlayer and p) then return false end
    if typeof(p) == "Instance" and p:IsA("Player") then
        if localPlayer.Team and p.Team then
            return localPlayer.Team == p.Team
        end
    end
    return false
end
local function addesp(targetPlayer)
    if not targetPlayer then return false end
    
    if (config.masterTarget == "NPCs" or config.masterTarget == "Both") and 
       typeof(targetPlayer) == "Instance" and targetPlayer:IsA("Model") then
        return true
    end
    
    if typeof(targetPlayer) == "Instance" and targetPlayer:IsA("Player") then
        if targetPlayer == localPlayer then return false end
        
        local mode = config.masterTeamTarget or "Enemies"
        if mode == "Enemies" then
            return not isTeammate(targetPlayer)
        elseif mode == "Teams" then
            return isTeammate(targetPlayer)
        elseif mode == "All" then
            return true
        else
            return not isTeammate(targetPlayer)
        end
    end
    
    return false
end

local function plralive(target)
    if not target then return false end

    if typeof(target) == "Instance" and target:IsA("Player") then
        local character = target.Character
        if not character then return false end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        return humanoid.Health > 0
    end

    if typeof(target) == "Instance" and target:IsA("Model") then
        local humanoid = target:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        return humanoid.Health > 0
    end

    return false
end

local function saveTargetOriginalPosition(target)
    local targetChar = getTargetCharacter(target)
    if not targetChar then return end
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    
    config.autoFarmOriginalPositions[target] = {
        position = targetRoot.Position,
        cframe = targetRoot.CFrame,
        timestamp = tick()
    }
end

local function restoreTargetOriginalPosition(target)
    local targetChar = getTargetCharacter(target)
    if not targetChar then return end
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    
    local savedData = config.autoFarmOriginalPositions[target]
    if savedData then
        pcall(function()
            targetRoot.CFrame = savedData.cframe
        end)
        config.autoFarmOriginalPositions[target] = nil
    end
end

local function canSeeTarget(target)
    if not config.autoFarmWallCheck then
        return true
    end
    
    local targetChar = getTargetCharacter(target)
    if not targetChar or not localPlayer.Character then return false end
    
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Head")
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart") or localPlayer.Character:FindFirstChild("Head")
    
    if not targetRoot or not localRoot then return false end
    
    local sourcePos = localRoot.Position
    local targetPos = targetRoot.Position
    local distance = (sourcePos - targetPos).Magnitude
    local rayDirection = (targetPos - sourcePos)
    local ray = Ray.new(sourcePos, rayDirection.Unit * rayDirection.Magnitude)
    
    local ignoreList = {localPlayer.Character}
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            table.insert(ignoreList, player.Character)
        end
    end
    
    local hit, position = Workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
    
    if hit then
        local hitParent = hit.Parent
        local isTarget = hitParent == targetChar or hitParent.Parent == targetChar
        
        if not isTarget then
            local distanceToHit = (position - sourcePos).Magnitude
            local distanceToTarget = rayDirection.Magnitude
            
            if distanceToHit < distanceToTarget - 2 then
                return false
            end
        end
    end
    
    return true
end

local function getValidAutoFarmTargets()
    local validTargets = {}
    local localRoot = localPlayer.Character and (localPlayer.Character:FindFirstChild("HumanoidRootPart") or localPlayer.Character:FindFirstChild("Head"))
    
    if not localRoot then return validTargets end
    
    local candidates = getAllTargets()
    for _, t in ipairs(candidates) do
        if t ~= localPlayer and plralive(t) then
            local shouldTarget = false
            if config.masterTarget == "NPCs" then
                if typeof(t) == "Instance" and t:IsA("Model") then
                    shouldTarget = true
                else
                    shouldTarget = false
                end
            elseif config.masterTarget == "Players" then
                if typeof(t) == "Instance" and t:IsA("Player") then
                    if not isTeammate(t) or config.masterTeamTarget == "All" then
                        shouldTarget = true
                    else
                        shouldTarget = false
                    end
                else
                    shouldTarget = false
                end
            elseif config.masterTarget == "Both" then
                shouldTarget = true
            end

            if shouldTarget then
                local humanoid = nil
                local char = getTargetCharacter(t)
                if char then
                    humanoid = char:FindFirstChildOfClass("Humanoid")
                    
                    if config.ignoreForcefield and hasForcefield(char) then
                        shouldTarget = false
                    end
                end
                if shouldTarget and humanoid and humanoid.Health > 0 then
                    if not config.autoFarmCompleted[t] then
                        local targetRoot = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head"))
                        if targetRoot then
                            local distance = (localRoot.Position - targetRoot.Position).Magnitude
                            local withinRange = true
                            if config.autoFarmMinRange > 0 and distance < config.autoFarmMinRange then
                                withinRange = false
                            end
                            if config.autoFarmMaxRange > 0 and distance > config.autoFarmMaxRange then
                                withinRange = false
                            end
                            local isVisible = true
                            if config.autoFarmWallCheck then
                                isVisible = canSeeTarget(t)
                            end
                            
                            if withinRange and isVisible then
                                table.insert(validTargets, t)
                            end
                        end
                    end
                end
            end
        end
    end

    table.sort(validTargets, function(a, b)
        local charA = getTargetCharacter(a)
        local charB = getTargetCharacter(b)
        local rootA = charA and (charA:FindFirstChild("HumanoidRootPart") or charA:FindFirstChild("Head"))
        local rootB = charB and (charB:FindFirstChild("HumanoidRootPart") or charB:FindFirstChild("Head"))
        
        if not localRoot then return false end
        if not rootA then return false end
        if not rootB then return true end
        
        local distA = (localRoot.Position - rootA.Position).Magnitude
        local distB = (localRoot.Position - rootB.Position).Magnitude
        
        return distA < distB
    end)
    
    return validTargets
end


local function tptocrossWithAlignment(target)
    local targetChar = getTargetCharacter(target)
    if not targetChar or not localPlayer.Character or not camera then 
        return false 
    end
    
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local targetHead = targetChar:FindFirstChild("Head")
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot or not localRoot then return false end
    if not canSeeTarget(target) then
        return false
    end
    local distance = (localRoot.Position - targetRoot.Position).Magnitude
    if config.autoFarmMinRange > 0 and distance < config.autoFarmMinRange then
        return false
    end
    
    if config.autoFarmMaxRange > 0 and distance > config.autoFarmMaxRange then
        return false
    end
    
    if not config.autoFarmOriginalPositions[target] then
        saveTargetOriginalPosition(target)
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
local function checkTargetHealth(target)
    if not target then return false end
    local char = getTargetCharacter(target)
    if not char then return false end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    if hasForcefield(char) then
        return false
    end
    
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

            if not config.autoFarmPartClaimStarted then
                config.autoFarmPartClaimStarted = true
                pcall(pc)
            else
                if tick() - (config.autoFarmLastRefresh or 0) > 2 then
                    config.autoFarmLastRefresh = tick()
                    pcall(function()
                        if localPlayer then
                            localPlayer.ReplicationFocus = workspace
                            localPlayer.SimulationRadius = config.gp
                        end
                    end)
                end
            end

            return
        end
        
        if config.currentAutoFarmTarget then
            local char = getTargetCharacter(config.currentAutoFarmTarget)
            if char and hasForcefield(char) then
                restoreTargetOriginalPosition(config.currentAutoFarmTarget)
                config.autoFarmCompleted[config.currentAutoFarmTarget] = true
                config.currentAutoFarmTarget = nil
            end
        end
        
        if not config.currentAutoFarmTarget or config.autoFarmCompleted[config.currentAutoFarmTarget] then
            for i = config.autoFarmIndex, #validTargets do
                local target = validTargets[i]
                if not config.autoFarmCompleted[target] then
                    local char = getTargetCharacter(target)
                    if char and not hasForcefield(char) then
                        config.currentAutoFarmTarget = target
                        config.autoFarmIndex = i
                        break
                    else
                        config.autoFarmCompleted[target] = true
                    end
                end
            end
            
            if not config.currentAutoFarmTarget then
                config.autoFarmIndex = 1
                for _, target in ipairs(validTargets) do
                    if not config.autoFarmCompleted[target] then
                        local char = getTargetCharacter(target)
                        if char and not hasForcefield(char) then
                            config.currentAutoFarmTarget = target
                            break
                        end
                    end
                end
            end
        end
        
        if config.currentAutoFarmTarget and getTargetCharacter(config.currentAutoFarmTarget) then
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
local function teleportTargetToLocalPlayerFront(target)
    local targetChar = getTargetCharacter(target)
    if not targetChar or not localPlayer.Character then 
        return false 
    end
    
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot or not localRoot then return false end
    
    if not canSeeTarget(target) then
        return false
    end
    
    local distance = (localRoot.Position - targetRoot.Position).Magnitude
    
    if config.autoFarmMinRange > 0 and distance < config.autoFarmMinRange then
        return false
    end
    
    if config.autoFarmMaxRange > 0 and distance > config.autoFarmMaxRange then
        return false
    end
    
    local localCFrame = localRoot.CFrame
    local frontOffset = localCFrame.LookVector * config.autoFarmDistance
    local frontPos = localRoot.Position + frontOffset
    frontPos = Vector3.new(frontPos.X, targetRoot.Position.Y, frontPos.Z)
    
    pcall(function()
        targetRoot.CFrame = CFrame.new(frontPos, localRoot.Position)
    end)
    
    return true
end

local function stopAutoFarm()
    if config.autoFarmLoop then
        config.autoFarmLoop:Disconnect()
        config.autoFarmLoop = nil
    end
    
    for target, _ in pairs(config.autoFarmOriginalPositions) do
        if target and getTargetCharacter(target) then
            restoreTargetOriginalPosition(target)
        end
    end
    
    config.currentAutoFarmTarget = nil
    config.autoFarmIndex = 1
    config.autoFarmCompleted = {}
    config.autoFarmOriginalPositions = {}
    config.autoFarmEnabled = false
    config.autoFarmPartClaimStarted = false
    config.autoFarmLastRefresh = 0
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

local function teleportAboveTarget(target)
    local targetChar = getTargetCharacter(target)
    if not targetChar or not localPlayer.Character then return end
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
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
    
    config.currentAntiAimTarget = target
    config.isTeleported = true
end

local function teleportBehindTarget(target)
    local targetChar = getTargetCharacter(target)
    if not targetChar or not localPlayer.Character then return end
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
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
    
    config.currentAntiAimTarget = target
    config.isTeleported = true
end
local function findClosestEnemy()
    if not localPlayer.Character then return nil end
    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    
    local best = nil
    local bestMetric = nil
    local mode = config.antiAimGetTarget or config.masterGetTarget or "Closest"
    local potentialTargets = {}
    local targetsInView = {}
    
    for _, t in ipairs(getAllTargets()) do
        if t ~= localPlayer and plralive(t) then
            local shouldTarget = false
            
            if config.masterTarget == "NPCs" then
                if typeof(t) == "Instance" and t:IsA("Model") then
                    shouldTarget = true
                end
            elseif config.masterTarget == "Players" then
                if typeof(t) == "Instance" and t:IsA("Player") then
                    if config.masterTeamTarget == "Enemies" then
                        shouldTarget = not isTeammate(t)
                    elseif config.masterTeamTarget == "Teams" then
                        shouldTarget = isTeammate(t)
                    elseif config.masterTeamTarget == "All" then
                        shouldTarget = true
                    end
                end
            elseif config.masterTarget == "Both" then
                shouldTarget = true
            end
            
            if shouldTarget then
                local tgtChar = getTargetCharacter(t)
                local playerRoot = tgtChar and (tgtChar:FindFirstChild("HumanoidRootPart") or tgtChar:FindFirstChild("Head"))
                local humanoid = tgtChar and tgtChar:FindFirstChildOfClass("Humanoid")
                if config.ignoreForcefield and tgtChar and hasForcefield(tgtChar) then
                    shouldTarget = false
                end
                
                if shouldTarget and playerRoot and humanoid and humanoid.Health > 0 then
                    local distance = (localRoot.Position - playerRoot.Position).Magnitude
                    local health = humanoid.Health
                    local isInView = true
                    if mode == "TargetSeen" then
                        local camera = workspace.CurrentCamera
                        local screenPos, onScreen = camera:WorldToViewportPoint(playerRoot.Position)
                        isInView = onScreen and screenPos.Z > 0
                    end
                    
                    local targetData = {
                        target = t,
                        char = tgtChar,
                        root = playerRoot,
                        humanoid = humanoid,
                        distance = distance,
                        health = health,
                        isInView = isInView
                    }
                    
                    table.insert(potentialTargets, targetData)
                    if isInView then
                        table.insert(targetsInView, targetData)
                    end
                end
            end
        end
    end
    if #potentialTargets > 0 then
        if mode == "TargetSeen" then
            if #targetsInView > 0 then
                if config.targetSeenMode == "Switch" then
                    local currentTime = tick()
                    if currentTime - config.lastTargetSwitchTime >= config.targetSeenSwitchRate then
                        config.lastTargetSwitchTime = currentTime
                        
                        if not config.currentAntiAimTarget then
                            table.sort(targetsInView, function(a, b)
                                return a.distance < b.distance
                            end)
                            best = targetsInView[1].target
                        else
                            local currentIndex = nil
                            for i, target in ipairs(targetsInView) do
                                if target.target == config.currentAntiAimTarget then
                                    currentIndex = i
                                    break
                                end
                            end
                            
                            if currentIndex then
                                local nextIndex = (currentIndex % #targetsInView) + 1
                                best = targetsInView[nextIndex].target
                            else
                                table.sort(targetsInView, function(a, b)
                                    return a.distance < b.distance
                                end)
                                best = targetsInView[1].target
                            end
                        end
                    else
                        best = config.currentAntiAimTarget
                    end
                else
                    table.sort(targetsInView, function(a, b)
                        return a.distance < b.distance
                    end)
                    best = targetsInView[1].target
                end
            else
                return nil
            end
        elseif mode == "Lowest Health" then
            table.sort(potentialTargets, function(a, b)
                return a.health < b.health
            end)
            best = potentialTargets[1].target
        else
            table.sort(potentialTargets, function(a, b)
                return a.distance < b.distance
            end)
            best = potentialTargets[1].target
        end
    end
    
    return best
end
local function antiAimUpdate()
    if not config.antiAimEnabled then
        if config.isTeleported then
            returnToOriginalPosition()
        end
        return
    end
    if config.antiAimOrbitEnabled then
        local closestEnemy = findClosestEnemy()
        if closestEnemy and getTargetCharacter(closestEnemy) then
            local targetChar = getTargetCharacter(closestEnemy)
            local targetPart = targetChar:FindFirstChild("Head") or targetChar:FindFirstChild("HumanoidRootPart")
            if targetPart and localPlayer.Character then
                config.currentAntiAimTarget = closestEnemy
                if not config.originalPosition then
                    local localRoot = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if localRoot then
                        config.originalPosition = localRoot.Position
                    end
                end
                local tpos = targetPart.Position
                local angle = tick() * (config.antiAimOrbitSpeed or 8)
                local radius = config.antiAimOrbitRadius or 5
                local height = config.antiAimOrbitHeight or 0
                local offset = Vector3.new(math.cos(angle) * radius, height, math.sin(angle) * radius)
                local newPos = tpos + offset
                pcall(function()
                    local localRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if localRoot then
                        localRoot.CFrame = CFrame.new(newPos, tpos)
                    end
                    if camera and targetPart then
                        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetPart.Position)
                    end
                end)
                config.isTeleported = true
            end
        else
            if config.isTeleported then
                returnToOriginalPosition()
            end
            config.currentAntiAimTarget = nil
        end
        return
    end
    if config.antiAimAbovePlayer then
        local closestEnemy = findClosestEnemy()
        if closestEnemy then
            teleportAboveTarget(closestEnemy)
        else
            if config.isTeleported then
                returnToOriginalPosition()
            end
        end
        return
    end
    
    if config.antiAimBehindPlayer then
        local closestEnemy = findClosestEnemy()
        if closestEnemy then
            teleportBehindTarget(closestEnemy)
        else
            if config.isTeleported then
                returnToOriginalPosition()
            end
        end
        return
    end
    
    if config.raycastAntiAim then
        local wasTargeted = false
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and plralive(player) then
                local shouldCheck = true
                if config.antiAimGetTarget == "TargetSeen" then
                    local tgtChar = getTargetCharacter(player)
                    if tgtChar then
                        local camera = workspace.CurrentCamera
                        local head = tgtChar:FindFirstChild("Head") or tgtChar:FindFirstChild("HumanoidRootPart")
                        if head then
                            local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
                            shouldCheck = onScreen and screenPos.Z > 0
                        else
                            shouldCheck = false
                        end
                    end
                end
                
                if shouldCheck then
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
        end
        
        if not wasTargeted and config.isTeleported then
            returnToOriginalPosition()
        end
    end
end
local function getDesyncOffset()
    if config.customDesyncEnabled then
        local x = tonumber(config.desyncX) or 0
        local y = tonumber(config.desyncY) or 0
        local z = tonumber(config.desyncZ) or 0
        return CFrame.new(x, y, z)
    else
        local ping = localPlayer:GetNetworkPing() * 1000
        if ping < 100 then return CFrame.new(0, 0, -2)
        elseif ping <= 170 then return CFrame.new(0, 0, -2.7)
        else return CFrame.new(0, 0, -3.7) end
    end
end
local function desyncUpdate()
    if not config.antiAimEnabled or not config.desyncEnabled or not localPlayer.Character then return end
    
    local character = localPlayer.Character
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    config.desyncLoc = root.CFrame
    
    local offset = getDesyncOffset()
    local newCFrame = config.desyncLoc * offset
    root.CFrame = newCFrame
    
    RunService.RenderStepped:Wait()
    root.CFrame = config.desyncLoc
end
local function setupDesyncHook()
    if desyncHook then return end
    
    desyncHook = hookmetamethod(game, "__index", newcclosure(function(self, key)
        if config.desyncEnabled and not checkcaller() and 
           key == "CFrame" and 
           localPlayer.Character and 
           self == localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return config.desyncLoc
        end
        return desyncHook(self, key)
    end))
end

task.spawn(function()
    task.wait(2)
    setupDesyncHook()
end)

local function RFD(targetPlayer)
    local char = getTargetCharacter(targetPlayer)
    if not char then return end
    local head = char:FindFirstChild("Head")
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
    if not targetPlayer or not getTargetCharacter(targetPlayer) then return end
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

    local character = getTargetCharacter(targetPlayer)
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

local function createLineESP(targetPlayer)
    if config.lineESPData[targetPlayer] then
        removeLineESP(targetPlayer)
    end
    
    local line = Drawing.new("Line")
    line.Thickness = config.lineThickness
    line.Color = config.lineColor
    line.Visible = false
    
    config.lineESPData[targetPlayer] = {
        drawing = line,
        visible = false
    }
    
    return line
end


local function removeLineESP(targetPlayer)
    if config.lineESPData[targetPlayer] then
        if config.lineESPData[targetPlayer].drawing then
            config.lineESPData[targetPlayer].drawing:Remove()
        end
        config.lineESPData[targetPlayer] = nil
    end
end

local function getLineStartPosition()
    local viewportSize = camera.ViewportSize
    
    if config.lineStartPosition == "Bottom" then
        return Vector2.new(viewportSize.X / 2, viewportSize.Y)
    elseif config.lineStartPosition == "Top" then
        return Vector2.new(viewportSize.X / 2, 0)
    elseif config.lineStartPosition == "BottomLeft" then
        return Vector2.new(0, viewportSize.Y)
    elseif config.lineStartPosition == "BottomRight" then
        return Vector2.new(viewportSize.X, viewportSize.Y)
    elseif config.lineStartPosition == "TopLeft" then
        return Vector2.new(0, 0)
    elseif config.lineStartPosition == "TopRight" then
        return Vector2.new(viewportSize.X, 0)
    else
        return Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    end
end
local function updateLineESP()
    if not config.espMasterEnabled or not config.lineESPEnabled then
        for targetPlayer, data in pairs(config.lineESPData) do
            if data.drawing then
                data.drawing.Visible = false
            end
        end
        return
    end
    
    for _, target in ipairs(getAllTargets()) do
        if addesp(target) and plralive(target) then
            local char = getTargetCharacter(target)
            if char then
                local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
                if root then
                    local pos, onScreen = camera:WorldToViewportPoint(root.Position)
                    
                    if onScreen and pos.Z > 0 then
                        local screenPos = Vector2.new(pos.X, pos.Y)
                        local shouldDrawLine = false
                        
                        if config.lineESPOnlyTarget then
                            local isTargeted = isPlayerBeingTargeted(target)
                            shouldDrawLine = isTargeted
                        else
                            shouldDrawLine = true
                        end
                        
                        if shouldDrawLine then
                            local lineData = config.lineESPData[target]
                            if not lineData then
                                createLineESP(target)
                                lineData = config.lineESPData[target]
                            end
                            
                            if lineData and lineData.drawing then
                                local line = lineData.drawing
                                
                                line.From = getLineStartPosition()
                                line.To = screenPos
                                line.Visible = true
                                line.Thickness = config.lineThickness
                                
                                local isTargeted = isPlayerBeingTargeted(target)
                                if isTargeted then
                                    line.Color = Color3.fromRGB(255, 255, 0)
                                else
                                    line.Color = config.lineColor
                                end
                            end
                        else
                            local lineData = config.lineESPData[target]
                            if lineData and lineData.drawing then
                                lineData.drawing.Visible = false
                            end
                        end
                    else
                        local lineData = config.lineESPData[target]
                        if lineData and lineData.drawing then
                            lineData.drawing.Visible = false
                        end
                    end
                end
            end
        else
            removeLineESP(target)
        end
    end
    local toRemove = {}
    for targetPlayer, _ in pairs(config.lineESPData) do
        local found = false
        for _, target in ipairs(getAllTargets()) do
            if target == targetPlayer then
                found = true
                break
            end
        end
        if not found then
            table.insert(toRemove, targetPlayer)
        end
    end
    
    for _, targetPlayer in ipairs(toRemove) do
        removeLineESP(targetPlayer)
    end
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
    if not targetPlayer then return end
    local data = config.espData[targetPlayer]
    if not data then return end
    if data.connection then
        pcall(function() data.connection:Disconnect() end)
        data.connection = nil
    end
    
    if data.screenGui and data.screenGui.Parent then
        pcall(function() data.screenGui:Destroy() end)
    end
    
    config.espData[targetPlayer] = nil
end

local function healthColor(humanoid)
    if not humanoid then return config.espc end
    local maxH = humanoid.MaxHealth or 100
    local health = math.clamp(humanoid.Health / maxH, 0, 1)
    local r = 1 - health
    local g = health
    return Color3.new(r, g, 0)
end
local function makeesp(targetPlayer)
    if not targetPlayer then return end
    if not addesp(targetPlayer) then return end
    
    if config.espData[targetPlayer] then
        local oldData = config.espData[targetPlayer]
        if oldData.connection then
            pcall(function() oldData.connection:Disconnect() end)
        end
        if oldData.screenGui and oldData.screenGui.Parent then
            pcall(function() oldData.screenGui:Destroy() end)
        end
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ESP_" .. getTargetName(targetPlayer)
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

    local label = Instance.new("TextLabel")
    label.Name = "ESPLabel"
    label.BackgroundTransparency = 1
    label.Text = getTargetName(targetPlayer)
    label.TextSize = 6
    label.Font = Enum.Font.GothamBold
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Visible = false
    label.Size = UDim2.new(0, 200, 0, 20)
    label.AnchorPoint = Vector2.new(0.5, 1)
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Parent = screenGui

    local boxFrame = Instance.new("Frame")
    boxFrame.Name = "ESPBox"
    boxFrame.AnchorPoint = Vector2.new(0, 0)
    boxFrame.Size = UDim2.new(0, 0, 0, 0)
    boxFrame.Position = UDim2.new(0, 0, 0, 0)
    boxFrame.BackgroundTransparency = 0.6
    boxFrame.BorderSizePixel = 0
    boxFrame.Visible = false
    boxFrame.Parent = screenGui

    local boxOutline = Instance.new("UIStroke")
    boxOutline.Thickness = 1
    boxOutline.LineJoinMode = Enum.LineJoinMode.Round
    boxOutline.Color = config.espc
    boxOutline.Transparency = 0.1
    boxOutline.Parent = boxFrame

    local healthBg = Instance.new("Frame")
    healthBg.Name = "HealthBG"
    healthBg.AnchorPoint = Vector2.new(0, 0)
    healthBg.Size = UDim2.new(0, 4, 0, 0)
    healthBg.Position = UDim2.new(0, 0, 0, 0)
    healthBg.BackgroundTransparency = 0.6
    healthBg.BackgroundColor3 = Color3.fromRGB(0,0,0)
    healthBg.BorderSizePixel = 0
    healthBg.Visible = false
    healthBg.Parent = screenGui

    local healthFill = Instance.new("Frame")
    healthFill.Name = "HealthFill"
    healthFill.AnchorPoint = Vector2.new(0, 1)
    healthFill.Size = UDim2.new(1, 0, 0, 0)
    healthFill.Position = UDim2.new(0, 0, 1, 0)
    healthFill.BackgroundColor3 = Color3.fromRGB(0,255,0)
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBg

    local headDot = Instance.new("Frame")
    headDot.Name = "HeadDot"
    headDot.Size = UDim2.new(0, 6, 0, 6)
    headDot.AnchorPoint = Vector2.new(0.5, 0.5)
    headDot.BackgroundColor3 = config.espc
    headDot.BorderSizePixel = 0
    headDot.Visible = false
    headDot.Parent = screenGui
    local isTargetedBySA2 = config.SA2_Enabled and config.SA2_currentTarget == targetPlayer
    local isTargetedByRegular = config.currentTarget == targetPlayer
    local isTargetedByAimbot = config.aimbotCurrentTarget == targetPlayer
    local isTargeted = isTargetedBySA2 or isTargetedByRegular or isTargetedByAimbot
    
    label.TextColor3 = isTargeted and config.esptargetc or config.espc
    boxOutline.Color = isTargeted and config.esptargetc or config.espc
    headDot.BackgroundColor3 = isTargeted and config.esptargetc or config.espc
    
    local function startUpdater()
        if config.espData[targetPlayer] and config.espData[targetPlayer].connection then
            pcall(function() config.espData[targetPlayer].connection:Disconnect() end)
        end
        
        local conn = RunService.RenderStepped:Connect(function()
            local tchar = getTargetCharacter(targetPlayer)
            local charExists = tchar and tchar.Parent
            
            if not charExists then
                if label then label.Visible = false end
                if boxFrame then boxFrame.Visible = false end
                if healthBg then healthBg.Visible = false end
                if headDot then headDot.Visible = false end
                return
            end

            if not addesp(targetPlayer) then
                label.Visible = false
                boxFrame.Visible = false
                healthBg.Visible = false
                headDot.Visible = false
                return
            end

            local head = tchar:FindFirstChild("Head")
            local root = tchar:FindFirstChild("HumanoidRootPart") or tchar:FindFirstChild("Torso") or tchar:FindFirstChild("UpperTorso")
            if not head or not root then
                label.Visible = false
                boxFrame.Visible = false
                healthBg.Visible = false
                headDot.Visible = false
                return
            end

            local topPos = head.Position + Vector3.new(0, 0.4, 0)
            local bottomPos = root.Position - Vector3.new(0, 1.0, 0)
            local midPos = (topPos + bottomPos) * 0.5
            local topV3, onTop = camera:WorldToViewportPoint(topPos)
            local bottomV3, onBottom = camera:WorldToViewportPoint(bottomPos)
            local midV3, onMid = camera:WorldToViewportPoint(midPos)
            local onScreen = onTop and onBottom and onMid and topV3.Z > 0 and bottomV3.Z > 0 and midV3.Z > 0
            local topScreenY = topV3.Y
            local bottomScreenY = bottomV3.Y
            local centerX = midV3.X
            local heightPx = math.abs(bottomScreenY - topScreenY)
            if heightPx <= 2 then heightPx = 2 end
            local widthPx = math.clamp(heightPx * 0.45, 4, 400)

            local humanoid = tchar:FindFirstChildOfClass("Humanoid")
            local hpRatio = 1
            if humanoid then
                local maxH = humanoid.MaxHealth or 100
                if maxH > 0 then
                    hpRatio = math.clamp(humanoid.Health / maxH, 0, 1)
                end
            end

            local hpColor = Color3.new(1,1,1)
            if humanoid then
                hpColor = healthColor(humanoid)
            end

            local isTargetedBySA2 = config.SA2_Enabled and config.SA2_currentTarget == targetPlayer
            local isTargetedByRegular = config.currentTarget == targetPlayer
            local isTargetedByAimbot = config.aimbotCurrentTarget == targetPlayer
            local isTargeted = isTargetedBySA2 or isTargetedByRegular or isTargetedByAimbot

            if config.espMasterEnabled and config.prefTextESP then
                local text = string.format("%s [%d]", getTargetName(targetPlayer), humanoid and math.floor(humanoid.Health) or 0)
                label.Text = text

                local absWidth = 200
                pcall(function()
                    if label.TextBounds and label.TextBounds.X and label.TextBounds.X > 0 then
                        absWidth = label.TextBounds.X + 8
                    elseif label.AbsoluteSize and label.AbsoluteSize.X and label.AbsoluteSize.X > 0 then
                        absWidth = label.AbsoluteSize.X
                    end
                end)

                label.Size = UDim2.new(0, absWidth, 0, 18)
                label.Position = UDim2.new(0, centerX, 0, topScreenY - 4)
                label.Visible = onScreen
                if config.prefColorByHealth and humanoid then
                    label.TextColor3 = hpColor
                else
                    label.TextColor3 = isTargeted and config.esptargetc or config.espc
                end
            else
                label.Visible = false
            end

            if config.espMasterEnabled and config.prefBoxESP then
                boxFrame.Size = UDim2.new(0, widthPx, 0, math.max(2, heightPx))
                boxFrame.Position = UDim2.new(0, centerX - widthPx / 2, 0, topScreenY)
                boxFrame.Visible = onScreen
                boxFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                boxFrame.BackgroundTransparency = 0.7

                if config.prefColorByHealth and humanoid then
                    boxOutline.Color = hpColor
                else
                    boxOutline.Color = isTargeted and config.esptargetc or config.espc
                end
            else
                boxFrame.Visible = false
            end

            if config.espMasterEnabled and config.prefHealthESP and humanoid then
                healthBg.Size = UDim2.new(0, 4, 0, math.max(2, heightPx))
                healthBg.Position = UDim2.new(0, centerX + widthPx / 2 + 4, 0, topScreenY)
                healthBg.Visible = onScreen
                healthFill.Size = UDim2.new(1, 0, hpRatio, 0)
                healthFill.Position = UDim2.new(0, 0, 1, 0)
                healthFill.BackgroundColor3 = healthColor(humanoid)
            else
                healthBg.Visible = false
            end

            if config.espMasterEnabled and config.prefHeadDotESP and head then
                local headV3, onHead = camera:WorldToViewportPoint(head.Position)
                if onHead and headV3.Z > 0 then
                    headDot.Position = UDim2.new(0, headV3.X, 0, headV3.Y)
                    headDot.Visible = true
                    if config.prefColorByHealth and humanoid then
                        headDot.BackgroundColor3 = hpColor
                    else
                        headDot.BackgroundColor3 = isTargeted and config.esptargetc or config.espc
                    end
                else
                    headDot.Visible = false
                end
            else
                headDot.Visible = false
            end
        end)

        config.espData[targetPlayer] = {
            label = label,
            screenGui = screenGui,
            connection = conn,
            box = boxFrame,
            boxOutline = boxOutline,
            healthBG = healthBg,
            healthFill = healthFill,
            headDot = headDot
        }
    end

    local char = getTargetCharacter(targetPlayer)
    if char and (char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")) then
        startUpdater()
    else
        spawn(function()
            local c = getTargetCharacter(targetPlayer)
            if c then
                local okHead = c:WaitForChild("Head", 2)
                local okRoot = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
                if okHead or okRoot then
                    startUpdater()
                end
            end
        end)
    end
end
local function updateESPColors()
    local toRemove = {}
    for targetPlayer, data in pairs(config.espData) do
        if (not targetPlayer) or (not data) or (not data.label) then
            table.insert(toRemove, targetPlayer)
        else
            if not addesp(targetPlayer) then
                table.insert(toRemove, targetPlayer)
            else
                local tchar = getTargetCharacter(targetPlayer)
                local humanoid = tchar and tchar:FindFirstChildOfClass("Humanoid")
                local hpColor = (humanoid and config.prefColorByHealth) and healthColor(humanoid) or nil
                local isTargetedBySA2 = config.SA2_Enabled and config.SA2_currentTarget == targetPlayer
                local isTargetedByRegular = config.currentTarget == targetPlayer
                local isTargetedByAimbot = config.aimbotCurrentTarget == targetPlayer
                local isTargeted = isTargetedBySA2 or isTargetedByRegular or isTargetedByAimbot
                
                if data.label then
                    if config.espMasterEnabled and config.prefTextESP then
                        if isTargeted then
                            data.label.TextColor3 = Color3.fromRGB(255, 255, 0)
                        elseif hpColor then
                            data.label.TextColor3 = hpColor
                        else
                            data.label.TextColor3 = config.espc
                        end
                        data.label.Visible = true
                    else
                        data.label.Visible = false
                    end
                end
                if data.box then
                    if config.espMasterEnabled and config.prefBoxESP then
                        data.box.Visible = true
                        if data.boxOutline then
                            if isTargeted then
                                data.boxOutline.Color = Color3.fromRGB(255, 255, 0)
                            else
                                data.boxOutline.Color = hpColor or config.espc
                            end
                        end
                    else
                        data.box.Visible = false
                    end
                end
                if data.headDot then
                    if config.espMasterEnabled and config.prefHeadDotESP then
                        data.headDot.Visible = true
                        if isTargeted then
                            data.headDot.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                        elseif hpColor then
                            data.headDot.BackgroundColor3 = hpColor
                        else
                            data.headDot.BackgroundColor3 = config.espc
                        end
                    else
                        data.headDot.Visible = false
                    end
                end
            end
        end
    end

    for _, targetPlayer in ipairs(toRemove) do
        config.espData[targetPlayer] = nil
    end
    local toRemoveHighlights = {}
    for targetPlayer, highlight in pairs(config.highlightData) do
        if not targetPlayer or not highlight or not highlight.Parent then
            table.insert(toRemoveHighlights, targetPlayer)
        else
            if not addesp(targetPlayer) then
                table.insert(toRemoveHighlights, targetPlayer)
            else
                local isTargetedBySA2 = config.SA2_Enabled and config.SA2_currentTarget == targetPlayer
                local isTargetedByRegular = config.currentTarget == targetPlayer
                local isTargetedByAimbot = config.aimbotCurrentTarget == targetPlayer
                local isTargeted = isTargetedBySA2 or isTargetedByRegular or isTargetedByAimbot
                
                if isTargeted then
                    highlight.FillColor = Color3.fromRGB(255, 255, 0)
                else
                    highlight.FillColor = config.espc
                end
            end
        end
    end

    for _, targetPlayer in ipairs(toRemoveHighlights) do
        config.highlightData[targetPlayer] = nil
    end
    
    if config.espMasterEnabled and config.lineESPEnabled then
        updateLineESP()
    end
end
local function toggleHighlightESP(enabled)
    config.prefHighlightESP = enabled
    config.highlightesp = enabled and config.espMasterEnabled or false

    if config.espMasterEnabled and enabled then
        for _, target in ipairs(getAllTargets()) do
            if addesp(target) and getTargetCharacter(target) then
                high(target)
            end
        end
    else
        local targetsToRemove = {}
        for targetPlayer, _ in pairs(config.highlightData) do
            table.insert(targetsToRemove, targetPlayer)
        end
        for _, targetPlayer in ipairs(targetsToRemove) do
            removeHighlightESP(targetPlayer)
        end
    end
end

local function toggleTextESP(enabled)
    config.prefTextESP = enabled
    config.espon = enabled and config.espMasterEnabled or false

    if config.espMasterEnabled and enabled then
        for _, target in ipairs(getAllTargets()) do
            if addesp(target) then
                makeesp(target)
            end
        end
    else
        local targetsToRemove = {}
        for targetPlayer, _ in pairs(config.espData) do
            table.insert(targetsToRemove, targetPlayer)
        end
        for _, targetPlayer in ipairs(targetsToRemove) do
            removeESPLabel(targetPlayer)
        end
    end
end

local function toggleBoxESP(enabled)
    config.prefBoxESP = enabled
    if config.espMasterEnabled then
        for _, target in ipairs(getAllTargets()) do
            if addesp(target) then
                if not config.espData[target] then
                    makeesp(target)
                end
            end
        end
        updateESPColors()
    else
        local targetsToRemove = {}
        for targetPlayer, _ in pairs(config.espData) do
            table.insert(targetsToRemove, targetPlayer)
        end
        for _, targetPlayer in ipairs(targetsToRemove) do
            removeESPLabel(targetPlayer)
        end
    end
end

local function toggleHealthESP(enabled)
    config.prefHealthESP = enabled
    if config.espMasterEnabled then
        for _, target in ipairs(getAllTargets()) do
            if addesp(target) then
                if not config.espData[target] then
                    makeesp(target)
                end
            end
        end
        updateESPColors()
    end
end
local function updateLineESP()
    if not config.espMasterEnabled or not config.lineESPEnabled then
        for targetPlayer, data in pairs(config.lineESPData) do
            if data.drawing then
                data.drawing.Visible = false
            end
        end
        return
    end
    
    for _, target in ipairs(getAllTargets()) do
        if addesp(target) and plralive(target) then
            local char = getTargetCharacter(target)
            if char then
                local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
                if root then
                    local pos, onScreen = camera:WorldToViewportPoint(root.Position)
                    
                    if onScreen and pos.Z > 0 then
                        local screenPos = Vector2.new(pos.X, pos.Y)
                        local shouldDrawLine = false
                        
                        if config.lineESPOnlyTarget then
                            local isTargeted = isPlayerBeingTargeted(target)
                            shouldDrawLine = isTargeted
                        else
                            shouldDrawLine = true
                        end
                        
                        if shouldDrawLine then
                            local lineData = config.lineESPData[target]
                            if not lineData then
                                createLineESP(target)
                                lineData = config.lineESPData[target]
                            end
                            
                            if lineData and lineData.drawing then
                                local line = lineData.drawing
                                
                                line.From = getLineStartPosition()
                                line.To = screenPos
                                line.Visible = true
                                line.Thickness = config.lineThickness
                                local isTargeted = isPlayerBeingTargeted(target)
                                if isTargeted then
                                    line.Color = Color3.fromRGB(255, 255, 0)
                                else
                                    line.Color = config.lineColor
                                end
                            end
                        else
                            local lineData = config.lineESPData[target]
                            if lineData and lineData.drawing then
                                lineData.drawing.Visible = false
                            end
                        end
                    else
                        local lineData = config.lineESPData[target]
                        if lineData and lineData.drawing then
                            lineData.drawing.Visible = false
                        end
                    end
                end
            end
        else
            removeLineESP(target)
        end
    end
    local toRemove = {}
    for targetPlayer, _ in pairs(config.lineESPData) do
        local found = false
        for _, target in ipairs(getAllTargets()) do
            if target == targetPlayer then
                found = true
                break
            end
        end
        if not found then
            table.insert(toRemove, targetPlayer)
        end
    end
    
    for _, targetPlayer in ipairs(toRemove) do
        removeLineESP(targetPlayer)
    end
end
local function d()
    for _, target in ipairs(getAllTargets()) do
        RFD(target)
    end
end
local function espRefresher()
    if not config.espMasterEnabled then return end
    
    local currentESPData = {}
    for target, data in pairs(config.espData) do
        currentESPData[target] = true
    end
    
    for _, target in ipairs(getAllTargets()) do
        if addesp(target) then
            if not currentESPData[target] then
                if config.prefTextESP or config.prefBoxESP or config.prefHealthESP or config.prefHeadDotESP then
                    makeesp(target)
                end
                if config.prefHighlightESP and getTargetCharacter(target) then
                    high(target)
                end
            end
        else
            if currentESPData[target] then
                removeESPLabel(target)
                removeHighlightESP(target)
            end
            removeLineESP(target)
        end
    end
    updateESPColors()
end

local function saveOriginalPartInfo(targetPlayer, part)
    if not targetPlayer or not part then return end
    config.originalSizes[targetPlayer] = {
        partName = part.Name or "Head",
        size = part.Size,
    }
end

local function chooseBodyPartInstance(target)
    local char = getTargetCharacter(target)
    if not char then return nil, "Head" end

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
    local char = getTargetCharacter(targetPlayer)
    if not char or targetPlayer == localPlayer then return end
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

    local char = getTargetCharacter(targetPlayer)
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
    local char = getTargetCharacter(targetPlayer)
    if not char then return end  

    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")

    if torso and not config.hitboxOriginalSizes[targetPlayer] then
        config.hitboxOriginalSizes[targetPlayer] = {
            part = torso,
            size = torso.Size
        }
    end
end
local function expandhb(targetPlayer, size)
    if not targetPlayer then return end
    if targetPlayer == localPlayer then return end
    if not plralive(targetPlayer) then return end  
    
    if not config.hitboxEnabled then 
        restoreTorso(targetPlayer)
        return 
    end

    local char = getTargetCharacter(targetPlayer)
    if not char then return end
    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")  
    if not torso then return end  

    tnormalsize(targetPlayer)
    local expansionSize = Vector3.new(size, size, size)
    config.hitboxLastSize[targetPlayer] = size

    config.hitboxExpandedParts[targetPlayer] = {
        part = torso,
        targetSize = expansionSize,
        originalSize = config.hitboxOriginalSizes[targetPlayer] and config.hitboxOriginalSizes[targetPlayer].size or torso.Size
    }
    
    if config.hitboxEnabled then
        pcall(function()
            torso.Size = expansionSize
            torso.Transparency = 0.9
            torso.CanCollide = false
            torso.Massless = false
            if config.hitboxColor then
                torso.Color = config.hitboxColor
            else
                torso.Color = Color3.fromRGB(255, 255, 255)
            end
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
            original.part.CanCollide = false
        end)
    end

    config.hitboxExpandedParts[targetPlayer] = nil
    config.hitboxOriginalSizes[targetPlayer] = nil
end
local function updateHitboxes()
    if not config.hitboxEnabled then  
        local targetsToRemove = {}
        for player, _ in pairs(config.hitboxExpandedParts) do  
            table.insert(targetsToRemove, player)
        end
        for _, player in ipairs(targetsToRemove) do
            restoreTorso(player)
        end
        return  
    end

    local targetsToRemove = {}
    for player, data in pairs(config.hitboxExpandedParts) do
        if not player or not getTargetCharacter(player) then
            table.insert(targetsToRemove, player)
        else
            if not plralive(player) then
                restoreTorso(player)
                table.insert(targetsToRemove, player)
            else
                local torso = getTargetCharacter(player):FindFirstChild("Torso") or getTargetCharacter(player):FindFirstChild("UpperTorso")
                if torso and data.targetSize then
                    pcall(function()
                        torso.Size = data.targetSize
                        torso.Transparency = 0.9
                        torso.CanCollide = false
                        torso.Massless = true
                    end)
                else
                    table.insert(targetsToRemove, player)
                end
            end
        end
    end
    
    for _, player in ipairs(targetsToRemove) do
        restoreTorso(player)
    end
end

local function targethb(player)
    if not player or player == localPlayer then return false end  
    if not plralive(player) then return false end  
    local char = getTargetCharacter(player)
    if config.ignoreForcefield and char and hasForcefield(char) then return false end

    local mode = config.masterTeamTarget or "Enemies"

    if typeof(player) == "Instance" and player:IsA("Model") then
        if mode == "Teams" then
            return false
        end
        return true
    end

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
    if not config.hitboxEnabled then 
        local targetsToRemove = {}
        for player, _ in pairs(config.hitboxExpandedParts) do
            table.insert(targetsToRemove, player)
        end
        for _, player in ipairs(targetsToRemove) do
            restoreTorso(player)
        end
        return 
    end

    for _, target in ipairs(getAllTargets()) do  
        if targethb(target) then
            local size = config.hitboxSize
            local existing = config.hitboxExpandedParts[target]
            if not existing or existing.targetSize.X ~= size then
                config.hitboxLastSize[target] = size
                expandhb(target, size)
            end
        else
            restoreTorso(target)
        end
    end
end


local function hb()
    local targetsToRemove = {}
    for playerObj, targetSize in pairs(config.targethbSizes) do
        if playerObj and playerObj ~= localPlayer and getTargetCharacter(playerObj) and plralive(playerObj) then
            local part = getTargetCharacter(playerObj):FindFirstChild(config.originalSizes[playerObj] and config.originalSizes[playerObj].partName) 
                         or getTargetCharacter(playerObj):FindFirstChild(config.bodypart) 
                         or getTargetCharacter(playerObj):FindFirstChild("Head")
            if not part then
                local p1 = getTargetCharacter(playerObj):FindFirstChild("HumanoidRootPart")
                local p2 = getTargetCharacter(playerObj):FindFirstChild("Head")
                part = p1 or p2
            end

            if part then
                local currentSize = part.Size
                local lerpAlpha = math.clamp(tonumber(config.predic) or 1, 0, 1)
                local newSize = currentSize:Lerp(targetSize, lerpAlpha)

                pcall(function()
                    part.Size = newSize
                    part.Transparency = config.hbtrans
                    part.CanCollide = false
                    part.Massless = (part.Name ~= "HumanoidRootPart")
                end)
            end
        else
            if playerObj ~= localPlayer then
                table.insert(targetsToRemove, playerObj)
            end
        end
    end
    
    for _, playerObj in ipairs(targetsToRemove) do
        restorePartForPlayer(playerObj)
    end
    
    updateHitboxes()
end

local function handleHitboxForRespawnedPlayer(player)
    if not config.hitboxEnabled then return end
    
    if player.Character then
        task.wait(0.5)
        
        local char = player.Character
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if config.hitboxOriginalSizes[player] and config.hitboxOriginalSizes[player].part and config.hitboxOriginalSizes[player].part.Parent then
                restoreTorso(player)
            end
            
            if humanoid.Health > 0 and targethb(player) then
                expandhb(player, config.hitboxSize)
            end
            
            humanoid.Died:Connect(function()
                if config.hitboxEnabled then
                    restoreTorso(player)
                end
            end)
        end
    end
end

local function shouldTargetAimbot(target)
    if not target then return false end
    if target == localPlayer then return false end
    if not plralive(target) then return false end
    
    local char = getTargetCharacter(target)
    if config.ignoreForcefield and char and hasForcefield(char) then return false end
    
    if typeof(target) == "Instance" and target:IsA("Model") then
        if config.masterTarget == "NPCs" or config.masterTarget == "Both" then
            return true
        else
            return false
        end
    end

    local mode = config.masterTeamTarget or "Enemies"
    if mode == "Enemies" then
        return not isTeammate(target)
    elseif mode == "Teams" then
        return isTeammate(target)
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

local function getAimbotTargetPart(target)
    if not target then return nil end
    local partName = config.aimbotTargetPart or "Head"
    local char = getTargetCharacter(target)
    if not char then return nil end
    
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
    local fovRadius = config.aimbot360Enabled and math.huge or config.aimbotFOVSize
    local cameraCFrame = camera.CFrame
    local cameraPos = cameraCFrame.Position
    
    local potentialTargets = {}
    local allTargets = getAllTargets()
    
    for _, target in ipairs(allTargets) do
        if shouldTargetAimbot(target) then
            local targetPart = getAimbotTargetPart(target)
            if targetPart then
                local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                local screenVec = Vector2.new(screenPos.X, screenPos.Y)
                local distPx = (screenVec - center).Magnitude
                
                local inFOV = config.aimbot360Enabled or (onScreen and distPx <= fovRadius)
                
                if inFOV then
                    local worldDist = (targetPart.Position - cameraPos).Magnitude
                    local isVisible = aimbotWallCheck(targetPart.Position, cameraPos)
                    
                    local tgtChar = getTargetCharacter(target)
                    local hasFF = config.ignoreForcefield and tgtChar and hasForcefield(tgtChar)
                    
                    if isVisible and not hasFF then
                        local humanoid = tgtChar and tgtChar:FindFirstChildOfClass("Humanoid")
                        table.insert(potentialTargets, {
                            target = target,
                            part = targetPart,
                            worldDist = worldDist,
                            screenDist = distPx,
                            screenPos = screenVec,
                            humanoid = humanoid,
                            health = humanoid and humanoid.Health or math.huge,
                            inFOV = true
                        })
                    end
                end
            end
        end
    end
    local bestTarget = nil
    local targetingMode = config.aimbotGetTarget or config.masterGetTarget or "Closest"
    
    if #potentialTargets > 0 then
        if targetingMode == "TargetSeen" then
            local targetsInFOV = {}
            for _, target in ipairs(potentialTargets) do
                if target.inFOV then
                    table.insert(targetsInFOV, target)
                end
            end
            
            if #targetsInFOV > 0 then
                config.targetSeenTargets = targetsInFOV
                
                if config.targetSeenMode == "Switch" then
                    local currentTime = tick()
                    if currentTime - config.lastTargetSwitchTime >= config.targetSeenSwitchRate then
                        config.lastTargetSwitchTime = currentTime
                        
                        if not config.aimbotCurrentTarget then
                            table.sort(targetsInFOV, function(a, b)
                                return a.worldDist < b.worldDist
                            end)
                            bestTarget = targetsInFOV[1]
                        else
                            local currentIndex = nil
                            for i, target in ipairs(targetsInFOV) do
                                if target.target == config.aimbotCurrentTarget then
                                    currentIndex = i
                                    break
                                end
                            end
                            
                            if currentIndex then
                                local nextIndex = (currentIndex % #targetsInFOV) + 1
                                bestTarget = targetsInFOV[nextIndex]
                            else
                                table.sort(targetsInFOV, function(a, b)
                                    return a.worldDist < b.worldDist
                                end)
                                bestTarget = targetsInFOV[1]
                            end
                        end
                    else
                        if config.aimbotCurrentTarget then
                            for _, target in ipairs(targetsInFOV) do
                                if target.target == config.aimbotCurrentTarget then
                                    bestTarget = target
                                    break
                                end
                            end
                        end
                    end
                elseif config.targetSeenMode == "All" then
                    table.sort(targetsInFOV, function(a, b)
                        return a.worldDist < b.worldDist
                    end)
                    bestTarget = targetsInFOV[1]
                end
            end
        elseif targetingMode == "Lowest Health" then
            local lowestHealth = math.huge
            for _, target in ipairs(potentialTargets) do
                if target.health < lowestHealth then
                    lowestHealth = target.health
                    bestTarget = target
                end
            end
        else
            local closestDist = math.huge
            for _, target in ipairs(potentialTargets) do
                if target.worldDist < closestDist then
                    closestDist = target.worldDist
                    bestTarget = target
                end
            end
        end
    end
    
    local newTarget = bestTarget and bestTarget.target or nil
    if config.aimbotCurrentTarget ~= newTarget then
        config.aimbotCurrentTarget = newTarget
        updateESPColors()
    end
    
    if bestTarget and bestTarget.part and localPlayer.Character then
        local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            local targetPosition = bestTarget.part.Position
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
    if config.aimbotFOVRing and config.aimbotFOVRing.ScreenGui and config.aimbotFOVRing.ScreenGui.Parent then
        config.aimbotFOVRing.ScreenGui:Destroy()
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
    ringFrame.Visible = config.aimbotEnabled and not config.aimbot360Enabled
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
        if config.aimbot360Enabled and config.aimbotEnabled then
            config.aimbotFOVRing.RingFrame.Visible = false
        elseif config.aimbotEnabled then
            config.aimbotFOVRing.RingFrame.Size = UDim2.new(0, config.aimbotFOVSize * 2, 0, config.aimbotFOVSize * 2)
            config.aimbotFOVRing.RingFrame.Position = UDim2.new(0.5, 0, 0.5, -28)
            config.aimbotFOVRing.RingFrame.Visible = true
        else
            config.aimbotFOVRing.RingFrame.Visible = false
        end
    end
end
local function aimbot360UpdateLoop()
    if aimbot360LoopRunning then
        return
    end

    if not config.aimbotEnabled or not config.aimbot360Enabled then
        return
    end

    aimbot360LoopRunning = true
    aimbot360LoopTask = task.spawn(function()
        while aimbot360LoopRunning and config.aimbotEnabled and config.aimbot360Enabled do
            aimbotUpdate()
            task.wait(0.1)
        end

        aimbot360LoopRunning = false
        aimbot360LoopTask = nil
    end)
end
local function toggle360Aimbot(state)
    if state then
        if not config.aimbotEnabled then
            config.aimbot360Enabled = false
            return
        end

        if not config.aimbot360OriginalFOV then
            config.aimbot360OriginalFOV = config.aimbotFOVSize
        end
        
        config.aimbot360Enabled = true
        config.aimbotFOVSize = math.huge
        updateAimbotFOVRing()
        aimbot360UpdateLoop()

    else
        if config.aimbot360OriginalFOV then
            config.aimbotFOVSize = config.aimbot360OriginalFOV
            config.aimbot360OriginalFOV = nil
        end
        
        config.aimbot360Enabled = false
        updateAimbotFOVRing()
        aimbot360LoopRunning = false
        if aimbot360LoopTask then
            aimbot360LoopTask = nil
        end
    end
end
local function handleAimbotToggle(state)
    config.aimbotEnabled = state
    
    if state then
        if not config.aimbotFOVRing then
            aimbotfov()
        end
        
        if config.aimbot360Enabled then
            config.aimbotFOVSize = math.huge
            updateAimbotFOVRing()
            aimbot360UpdateLoop()
        end
        aimbotfov()
    else
        if config.aimbot360Enabled then
            aimbot360LoopRunning = false
            if aimbot360LoopTask then
                aimbot360LoopTask = nil
            end
        end
    end
    
    updateAimbotFOVRing()
end


local function aimbot360UpdateLoop()
    if aimbot360LoopRunning then
        return
    end

    if not config.aimbotEnabled then
        return
    end

    if not config.aimbot360Enabled then
        config.aimbot360Enabled = true
    end

    aimbot360LoopRunning = true

    aimbot360LoopTask = task.spawn(function()
        while aimbot360LoopRunning do
            if config.aimbotEnabled and config.aimbot360Enabled then
                aimbotUpdate()
            else
                aimbot360LoopRunning = false
                break
            end

            task.wait(0.1)
        end

        aimbot360LoopRunning = false
        aimbot360LoopTask = nil
    end)
end

RunService.Heartbeat:Connect(hb)
RunService.RenderStepped:Connect(aimbotUpdate)
RunService.Heartbeat:Connect(antiAimUpdate)
RunService.RenderStepped:Connect(function()
    aimbotUpdate()
    updateLineESP()
    desyncUpdate()
    hb()
end)

local function isMobileDevice()
    local ok, val = pcall(function() return UserInputService.TouchEnabled end)
    return ok and val
end
local function CreateQT()
    if gui.mobileGui and gui.mobileGui.ScreenGui and gui.mobileGui.ScreenGui.Parent then
        gui.mobileGui.ScreenGui.Enabled = true
        return
    elseif gui.mobileGui and gui.mobileGui.ScreenGui and not gui.mobileGui.ScreenGui.Parent then
        gui.mobileGui = nil
    end
    
    if gui.mobileGui and gui.mobileGui.ScreenGui and gui.mobileGui.ScreenGui.Parent then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GravelQT"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

    local function QuickToggle(name, positionX, positionY, getter, setter)
        local main = Instance.new("Frame")
        main.Size = UDim2.new(0, 120, 0, 40)
        main.Position = UDim2.new(0, positionX, 0, positionY)
        main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        main.BorderSizePixel = 0
        main.AnchorPoint = Vector2.new(0, 0)
        main.Active = true
        main.Draggable = true
        main.Parent = screenGui

        local mainCorner = Instance.new("UICorner")
        mainCorner.CornerRadius = UDim.new(0, 6)
        mainCorner.Parent = main
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -50, 1, 0)
        label.Position = UDim2.new(0, 8, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.Font = Enum.Font.GothamSemibold
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextYAlignment = Enum.TextYAlignment.Center
        label.Parent = main

        local toggleBg = Instance.new("Frame")
        toggleBg.Size = UDim2.new(0, 38, 0, 18)
        toggleBg.Position = UDim2.new(1, -44, 0.5, -9)
        toggleBg.BackgroundColor3 = getter() and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(15, 15, 15)
        toggleBg.BorderSizePixel = 0
        toggleBg.BackgroundTransparency = 0
        toggleBg.ClipsDescendants = false
        toggleBg.Parent = main

        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 9)
        toggleCorner.Parent = toggleBg
        local circle = Instance.new("Frame")
        circle.Size = UDim2.new(0, 16, 0, 16)
        circle.Position = getter() and UDim2.new(1, -18, 0, 1) or UDim2.new(0, 1, 0, 1)
        circle.BackgroundColor3 = getter() and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(60, 60, 60)
        circle.BorderSizePixel = 0
        circle.Parent = toggleBg

        local circleCorner = Instance.new("UICorner")
        circleCorner.CornerRadius = UDim.new(1, 0)
        circleCorner.Parent = circle
        local touchButton = Instance.new("TextButton")
        touchButton.Size = UDim2.new(0.4, 0, 0.5, 0)
        touchButton.Position = UDim2.new(0, 70, 0, 9)
        touchButton.BackgroundTransparency = 1
        touchButton.Text = ""
        touchButton.ZIndex = 10
        touchButton.Parent = main

        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local function toggleOn()
            local onTween = TweenService:Create(circle, tweenInfo, {
                Position = UDim2.new(1, -18, 0, 1),
                BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            })
            local bgOnTween = TweenService:Create(toggleBg, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            })
            onTween:Play()
            bgOnTween:Play()
        end

        local function toggleOff()
            local offTween = TweenService:Create(circle, tweenInfo, {
                Position = UDim2.new(0, 1, 0, 1),
                BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            })
            local bgOffTween = TweenService:Create(toggleBg, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            })
            offTween:Play()
            bgOffTween:Play()
        end
        local function toggle()
            local newState = not getter()
            setter(newState)
            
            if newState then
                toggleOn()
                if name == "Silent Aim (HB)" then
                    if gui.RingHolder then gui.RingHolder.Visible = true end
                elseif name == "Aim bot" then
                    handleAimbotToggle(true)
                elseif name == "Auto Farm" then
                    autoFarmProcess()
                elseif name == "Anti Aim" then
                elseif name == "Hit box" then
                    applyhb()
                elseif name == "Client Config" then
                    applyClientMaster(true)
                elseif name == "ESP" then
                    applyESPMaster(true)
                end
            else
                toggleOff()
                if name == "Silent Aim (HB)" then
                    if gui.RingHolder then gui.RingHolder.Visible = false end
                    for pl, _ in pairs(config.activeApplied) do
                        restorePartForPlayer(pl)
                    end
                elseif name == "Aim bot" then
                    handleAimbotToggle(false)
                elseif name == "Auto Farm" then
                    stopAutoFarm()
                elseif name == "Anti Aim" then
                    returnToOriginalPosition()
                elseif name == "Hit box" then
                    local targetsToRemove = {}
                    for pl, _ in pairs(config.hitboxExpandedParts) do
                        table.insert(targetsToRemove, pl)
                    end
                    for _, pl in ipairs(targetsToRemove) do
                        restoreTorso(pl)
                    end
                elseif name == "Client Config" then
                    applyClientMaster(false)
                elseif name == "ESP" then
                    applyESPMaster(false)
                end
            end
            
            label.Text = getter() and name .. "<" or name
        end

        local inputStartTime = 0
        local minPressTime = 0.05
        local inputStartPosition = nil
        local isPressing = false
        local wasPressedHere = false
        local function onInputBegan(input, gameProcessedEvent)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if not gameProcessedEvent then
                    isPressing = true
                    wasPressedHere = true
                    inputStartTime = tick()
                    inputStartPosition = input.Position
                    
                    if input.UserInputType == Enum.UserInputType.Touch then
                        local feedback = Instance.new("Frame")
                        feedback.Name = "TouchFeedback"
                        feedback.Size = UDim2.new(0, 40, 0, 40)
                        feedback.Position = UDim2.new(0, inputStartPosition.X - 20, 0, inputStartPosition.Y - 20)
                        feedback.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        feedback.BackgroundTransparency = 0.7
                        feedback.BorderSizePixel = 0
                        local corner = Instance.new("UICorner")
                        corner.CornerRadius = UDim.new(1, 0)
                        corner.Parent = feedback
                        feedback.Parent = screenGui
                        
                        local fadeOut = TweenService:Create(feedback, TweenInfo.new(0.3), {
                            BackgroundTransparency = 1,
                            Size = UDim2.new(0, 0, 0, 0)
                        })
                        fadeOut:Play()
                        fadeOut.Completed:Connect(function()
                            feedback:Destroy()
                        end)
                    end
                end
            end
        end
        local function onInputEnded(input, gameProcessedEvent)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if isPressing and wasPressedHere and not gameProcessedEvent then
                    local pressDuration = tick() - inputStartTime
                    local endPosition = input.Position
                    
                    local distanceMoved = 0
                    if inputStartPosition then
                        distanceMoved = (endPosition - inputStartPosition).Magnitude
                    end
                    
                    if pressDuration >= minPressTime and distanceMoved < 10 then
                        toggle()
                    end
                end
                isPressing = false
                wasPressedHere = false
                inputStartPosition = nil
            end
        end
        local function onInputChanged(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if isPressing and inputStartPosition then
                    local currentPosition = input.Position
                    local distanceMoved = (currentPosition - inputStartPosition).Magnitude
                    if distanceMoved > 20 then
                        wasPressedHere = false
                    end
                end
            end
        end
        toggleBg.InputBegan:Connect(function(...) onInputBegan(...) end)
        toggleBg.InputChanged:Connect(onInputChanged)
        toggleBg.InputEnded:Connect(function(...) onInputEnded(...) end)
        circle.InputBegan:Connect(function(...) onInputBegan(...) end)
        circle.InputChanged:Connect(onInputChanged)
        circle.InputEnded:Connect(function(...) onInputEnded(...) end)

        touchButton.InputBegan:Connect(function(...) onInputBegan(...) end)
        touchButton.InputChanged:Connect(onInputChanged)
        touchButton.InputEnded:Connect(function(...) onInputEnded(...) end)

        label.Text = getter() and name .. "<" or name
        
        return {
            main = main,
            touchButton = touchButton,
            toggleBg = toggleBg,
            circle = circle,
            label = label
        }
    end

    local buttons = {}
    local startX = 10
    local topRowY = 10
    local bottomRowY = 60
    local toggleWidth = 120
    local horizontalSpacing = 10
    
    buttons.SilentAim = QuickToggle("Silent Aim (HB)", startX, topRowY, 
        function() return config.startsa end, 
        function(v) config.startsa = v end)
    
    buttons.Hitbox = QuickToggle("Hit box", startX + (toggleWidth + horizontalSpacing) * 1, topRowY,
        function() return config.hitboxEnabled end,
        function(v) config.hitboxEnabled = v end)
    
    buttons.AntiAim = QuickToggle("Anti Aim", startX + (toggleWidth + horizontalSpacing) * 2, topRowY,
        function() return config.antiAimEnabled end,
        function(v) config.antiAimEnabled = v end)
    
    buttons.Aimbot = QuickToggle("Aim bot", startX + (toggleWidth + horizontalSpacing) * 3, topRowY,
        function() return config.aimbotEnabled end,
        function(v) handleAimbotToggle(v) end)
    
    buttons.ClientConfig = QuickToggle("Client Config", startX + (toggleWidth + horizontalSpacing) * 4, topRowY,
        function() return config.clientMasterEnabled end,
        function(v) applyClientMaster(v) end)
    
    local espX = startX + (toggleWidth + horizontalSpacing) * 0
    buttons.ESP = QuickToggle("ESP", espX, bottomRowY,
        function() return config.espMasterEnabled end,
        function(v) applyESPMaster(v) end)

local silentAimHKX = startX + (toggleWidth + horizontalSpacing) * 1
buttons.SilentAimHK = QuickToggle("SilentAim (HK)", silentAimHKX, bottomRowY,
    function() return config.SA2_Enabled end,
    function(v) 
        config.SA2_Enabled = v 
        if v then
            safeNotify({
                Title = "SilentAim HK",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 255, 0)
            })
        else
            safeNotify({
                Title = "SilentAim HK",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end)


    gui.mobileGui = {
        ScreenGui = screenGui,
        Buttons = buttons
    }

    if gui.RingHolder then
        gui.RingHolder.Visible = config.startsa
    end
    if config.aimbotFOVRing and config.aimbotFOVRing.RingFrame then
        config.aimbotFOVRing.RingFrame.Visible = config.aimbotEnabled and not config.aimbot360Enabled
    end
end
local function KillQT()
    if gui and gui.mobileGui and gui.mobileGui.ScreenGui then
        pcall(function()
            gui.mobileGui.ScreenGui:Destroy()
        end)
    end
    gui.mobileGui = nil
end
local function UpdateQT()
    if not isMobileDevice() then
        if gui.mobileGui and gui.mobileGui.ScreenGui then
            gui.mobileGui.ScreenGui.Enabled = false
        end
        return
    end
    
    if not config.QuickToggles then
        if gui.mobileGui and gui.mobileGui.ScreenGui then
            gui.mobileGui.ScreenGui.Enabled = false
        end
        return
    end
    
    if not gui.mobileGui or not gui.mobileGui.ScreenGui or not gui.mobileGui.ScreenGui.Parent then
        CreateQT()
        return
    end
    
    gui.mobileGui.ScreenGui.Enabled = true
    
    if gui.mobileGui.Buttons then
        local buttonStates = {
            SilentAim = config.startsa,
            Aimbot = config.aimbotEnabled,
            AutoFarm = config.autoFarmEnabled,
            AntiAim = config.antiAimEnabled,
            Hitbox = config.hitboxEnabled,
            ClientConfig = config.clientMasterEnabled,
            ESP = config.espMasterEnabled,
            SilentAimHK = config.SA2_Enabled
        }
        
        for buttonName, isEnabled in pairs(buttonStates) do
            local buttonData = gui.mobileGui.Buttons[buttonName]
            if buttonData and buttonData.label then
                buttonData.label.Text = isEnabled and buttonName .. "<" or buttonName
                
                if buttonData.toggleBg then
                    buttonData.toggleBg.BackgroundColor3 = isEnabled and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(15, 15, 15)
                end
                
                if buttonData.circle then
                    buttonData.circle.BackgroundColor3 = isEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(60, 60, 60)
                    buttonData.circle.Position = isEnabled and UDim2.new(1, -18, 0, 1) or UDim2.new(0, 1, 0, 1)
                end
            end
        end
    end
end
local function onRenderStep()
    if not camera or not camera.Parent then
        camera = workspace.CurrentCamera
        if not camera then return end
    end

    if not gui.RingHolder or not gui.RingStroke then return end

    if not config.startsa then
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

    local candidates = {}
    local allTargetsInFOV = {}
    
    for _, pl in ipairs(getAllTargets()) do
        local bodyPart, chosenName = chooseBodyPartInstance(pl)
        local humanoid = nil
        local char = getTargetCharacter(pl)
        if char then
            humanoid = char:FindFirstChildOfClass("Humanoid")
            
            if hasForcefield(char) then continue end
        end

        if bodyPart and humanoid and humanoid.Health > 0 then
            local skip = false
            local mode = config.masterTeamTarget or "Enemies"
            
            if mode == "Enemies" then
                if typeof(pl) == "Instance" and pl:IsA("Player") and isTeammate(pl) then
                    skip = true
                end
            elseif mode == "Teams" then
                if typeof(pl) == "Instance" and pl:IsA("Player") and not isTeammate(pl) then
                    skip = true
                end
            elseif mode == "All" then
                skip = false
            end

            if not skip then
                local topPos = bodyPart.Position
                local screenPos3, onScreen = camera:WorldToViewportPoint(topPos)
                if onScreen then
                    local screenVec = Vector2.new(screenPos3.X, screenPos3.Y)
                    local distPx = (screenVec - center).Magnitude

                    table.insert(allTargetsInFOV, {
                        player = pl,
                        part = bodyPart,
                        partName = chosenName,
                        screenDist = distPx,
                        worldDist = (camera.CFrame.Position - topPos).Magnitude,
                        screenPos = screenVec,
                        screenPos3 = screenPos3,
                        humanoid = humanoid,
                        inFOV = distPx <= radiusPx
                    })
                    
                    if distPx <= radiusPx then
                        local cameraPos = camera.CFrame.Position
                        local targetPos = bodyPart.Position
                        if wallCheck(targetPos, cameraPos) then
                            local worldDist = (cameraPos - targetPos).Magnitude
                            table.insert(candidates, {
                                player = pl,
                                part = bodyPart,
                                partName = chosenName,
                                screenDist = distPx,
                                worldDist = worldDist,
                                screenPos = screenVec,
                                screenPos3 = screenPos3,
                                humanoid = humanoid
                            })
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

    local best = nil
    if config.silentGetTarget == "TargetSeen" then
        local targetsInFOV = {}
        for _, target in ipairs(allTargetsInFOV) do
            if target.inFOV then
                local cameraPos = camera.CFrame.Position
                local targetPos = target.part.Position
                if wallCheck(targetPos, cameraPos) then
                    table.insert(targetsInFOV, target)
                end
            end
        end
        config.targetSeenTargets = targetsInFOV
        
        if #targetsInFOV > 0 then
            if config.targetSeenMode == "Switch" then
                local currentTime = tick()
                if currentTime - config.lastTargetSwitchTime >= config.targetSeenSwitchRate then
                    config.lastTargetSwitchTime = currentTime
                    if not config.currentTarget then
                        local randomIndex = math.random(1, #targetsInFOV)
                        best = targetsInFOV[randomIndex]
                    else
                        local currentIndex = nil
                        for i, target in ipairs(targetsInFOV) do
                            if target.player == config.currentTarget then
                                currentIndex = i
                                break
                            end
                        end
                        
                        if currentIndex then
                            local nextIndex = (currentIndex % #targetsInFOV) + 1
                            best = targetsInFOV[nextIndex]
                        else
                            local randomIndex = math.random(1, #targetsInFOV)
                            best = targetsInFOV[randomIndex]
                        end
                    end
                else
                    if config.currentTarget then
                        for _, target in ipairs(targetsInFOV) do
                            if target.player == config.currentTarget then
                                best = target
                                break
                            end
                        end
                    end
                end
            elseif config.targetSeenMode == "All" then
                for _, target in ipairs(targetsInFOV) do
                    if target.player ~= config.currentTarget then
                        local diameter = calculateDiameter(target.worldDist, radiusPx, camera)
                        applySizeToPart(target.player, diameter, target.part)
                    end
                end
                local closestDist = math.huge
                for _, target in ipairs(targetsInFOV) do
                    if target.worldDist < closestDist then
                        closestDist = target.worldDist
                        best = target
                    end
                end
            end
        else
            best = nil
        end
    else
        if #candidates > 0 then
            if config.silentGetTarget == "Lowest Health" then
                local bestHealth = math.huge
                for _, c in ipairs(candidates) do
                    local h = c.humanoid and c.humanoid.Health or math.huge
                    if best == nil or h < bestHealth then
                        bestHealth = h
                        best = c
                    end
                end
            else
                local bestWorldDist = math.huge
                for _, c in ipairs(candidates) do
                    if c.worldDist < bestWorldDist then
                        bestWorldDist = c.worldDist
                        best = c
                    end
                end
            end
        end
    end

    if best then
        gui.RingStroke.Color = config.fovct or config.fovc
    else
        gui.RingStroke.Color = config.fovc
    end
    if config.currentTarget ~= (best and best.player) then
        config.currentTarget = best and best.player
        updateESPColors()
    end

    local targetsToRemove = {}
    for pl, _ in pairs(config.activeApplied) do
        local shouldRemove = true
        
        if best and pl == best.player then
            shouldRemove = false
        elseif config.silentGetTarget == "TargetSeen" and config.targetSeenMode == "All" then
            local stillInFOV = false
            for _, target in ipairs(config.targetSeenTargets or {}) do
                if target.player == pl then
                    stillInFOV = true
                    break
                end
            end
            shouldRemove = not stillInFOV
        end
        
        if shouldRemove or not plralive(pl) then
            table.insert(targetsToRemove, pl)
        end
    end
    
    for _, pl in ipairs(targetsToRemove) do
        restorePartForPlayer(pl)
    end

    if best and plralive(best.player) then
        local function calculateDiameter(worldDist, screenRadius, cam)
            local viewportSize = cam.ViewportSize
            local H = viewportSize.Y
            local vFovDeg = cam.FieldOfView
            local vFovRad = math.rad(vFovDeg)
            local halfVFov = vFovRad / 2
            local alpha = (screenRadius / (H / 2)) * halfVFov
            local worldHalf = worldDist * math.tan(alpha)
            local worldFull = worldHalf * 2
            return math.max(0.01, worldFull)
        end
        
        local diameter = calculateDiameter(best.worldDist, radiusPx, camera)
        diameter = math.max(0.01, diameter)

        local localChar = localPlayer.Character
        local targetChar = getTargetCharacter(best.player)
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
    
    if config.silentGetTarget == "TargetSeen" and config.targetSeenMode == "All" then
        for _, target in ipairs(config.targetSeenTargets or {}) do
            if target.player ~= (best and best.player) and plralive(target.player) then
                local diameter = calculateDiameter(target.worldDist, radiusPx, camera)
                diameter = math.max(0.01, diameter)
                applySizeToPart(target.player, diameter, target.part)
            end
        end
    end
end

local function getClosestVictim()
    if not Options.TargetPart.Value then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        if Toggles.TeamCheck.Value and Player.Team == LocalPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end
        
        if config.ignoreForcefield and hasForcefield(Character) then continue end
        
        if Toggles.VisibleCheck.Value and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or Options.Radius.Value or 2000) then
            Closest = ((Options.TargetPart.Value == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[Options.TargetPart.Value])
            DistanceToMouse = Distance
        end
    end
    return Closest
end

local function keyNameFromInput(input)
    if not input or not input.KeyCode then return nil end
    local name = tostring(input.KeyCode)
    local keyName = name:match("Enum.KeyCode.(.+)") or name
    return keyName
end

local function normalizeKeyString(k)
    if not k then return nil end
    local s = tostring(k)
    local matchName = s:match("Enum.KeyCode.(.+)")
    if matchName then return matchName:upper() end
    return s:upper()
end
local function applyKeybindAction(key, fromHotkeySystem)
    local keyUpper = normalizeKeyString(key)
    if not keyUpper then return false end
    
    local isMobile = isMobileDevice()
    local guiOpen = gui.mobileGui and gui.mobileGui.ScreenGui and gui.mobileGui.ScreenGui.Enabled
    
    if isMobile and guiOpen and gui.mobileGui.Frame and gui.mobileGui.Frame.Size.Y.Offset > 100 then
        return false
    end
    if fromHotkeySystem and config.holdkeyToggle.enabled then
        if not isHoldKeyDown() then
            return false
        end
    end
    
    for action, bound in pairs(config.keybinds) do
        if bound and normalizeKeyString(bound) == keyUpper then
            local currentTime = tick()
            local lastTrigger = config.holdkeyStates[action] or 0
            
            if currentTime - lastTrigger < 0.2 then
                return true
            end
            
            config.holdkeyStates[action] = currentTime
            local source = fromHotkeySystem and "Keybind" or "UI"
            
            if action == "silentaimhb" then
                config.startsa = not config.startsa
                if not config.startsa then
                    if gui.RingHolder then gui.RingHolder.Visible = false end
                    local targetsToRemove = {}
                    for pl, _ in pairs(config.activeApplied) do
                        table.insert(targetsToRemove, pl)
                    end
                    for _, pl in ipairs(targetsToRemove) do
                        restorePartForPlayer(pl)
                    end
                    safeNotify({
                        Title = "SilentAim (HB)", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                else
                    if gui.RingHolder then gui.RingHolder.Visible = true end
                    safeNotify({
                        Title = "SilentAim (HB)", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(0, 255, 0)
                    })
                end
                UpdateQT()
                return true
            elseif action == "aimbot" then
                local wasEnabled = config.aimbotEnabled
                handleAimbotToggle(not config.aimbotEnabled)
                if config.aimbotEnabled and not wasEnabled then
                    safeNotify({
                        Title = "Aimbot", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(0, 255, 0)
                    })
                elseif not config.aimbotEnabled and wasEnabled then
                    safeNotify({
                        Title = "Aimbot", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
                UpdateQT()
                return true
            elseif action == "silentaimhk" then
                config.SA2_Enabled = not config.SA2_Enabled
                if config.SA2_Enabled then
                    safeNotify({
                        Title = "SilentAim (HK)", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(0, 255, 0)
                    })
                else
                    safeNotify({
                        Title = "SilentAim (HK)", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
                UpdateQT()
                return true
            elseif action == "silentaimhkwallcheck" then
                config.SA2_Wallcheck = not config.SA2_Wallcheck
                if config.SA2_Wallcheck then
                    safeNotify({
                        Title = "SilentAim (HK) Wall Check", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(0, 170, 255)
                    })
                else
                    safeNotify({
                        Title = "SilentAim (HK) Wall Check", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
                UpdateQT()
                return true
            elseif action == "autofarm" then
                config.autoFarmEnabled = not config.autoFarmEnabled
                if config.autoFarmEnabled then
                    autoFarmProcess()
                    safeNotify({
                        Title = "AutoFarm", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(0, 255, 0)
                    })
                else
                    stopAutoFarm()
                    safeNotify({
                        Title = "AutoFarm", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
                UpdateQT()
                return true
            elseif action == "antiaim" then
                config.antiAimEnabled = not config.antiAimEnabled
                if not config.antiAimEnabled then
                    returnToOriginalPosition()
                    safeNotify({
                        Title = "AntiAim", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                else
                    safeNotify({
                        Title = "AntiAim", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 100, 0)
                    })
                end
                UpdateQT()
                return true
            elseif action == "hitbox" then
                config.hitboxEnabled = not config.hitboxEnabled
                if config.hitboxEnabled then
                    applyhb()
                    safeNotify({
                        Title = "Hitbox", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(0, 255, 0)
                    })
                else
                    local targetsToRemove = {}
                    for player, _ in pairs(config.hitboxExpandedParts) do
                        table.insert(targetsToRemove, player)
                    end
                    for _, player in ipairs(targetsToRemove) do
                        restoreTorso(player)
                    end
                    safeNotify({
                        Title = "Hitbox", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
                UpdateQT()
                return true
            elseif action == "esp" then
                config.espMasterEnabled = not config.espMasterEnabled
                applyESPMaster(config.espMasterEnabled)
                if config.espMasterEnabled then
                    safeNotify({
                        Title = "ESP Master", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(0, 170, 255)
                    })
                else
                    safeNotify({
                        Title = "ESP Master", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
                UpdateQT()
                return true
            elseif action == "client" then
                config.clientMasterEnabled = not config.clientMasterEnabled
                applyClientMaster(config.clientMasterEnabled)
                if config.clientMasterEnabled then
                    safeNotify({
                        Title = "Client Config", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(0, 170, 255)
                    })
                else
                    safeNotify({
                        Title = "Client Config", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
                UpdateQT()
                return true
            elseif action == "silentaimwallcheck" then
                config.wallc = not config.wallc
                if config.wallc then
                    safeNotify({
                        Title = "SilentAim Wall Check", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(0, 170, 255)
                    })
                else
                    safeNotify({
                        Title = "SilentAim Wall Check", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
                return true
            elseif action == "aimbotwallcheck" then
                config.aimbotWallCheck = not config.aimbotWallCheck
                if config.aimbotWallCheck then
                    safeNotify({
                        Title = "Aimbot Wall Check", 
                        Content = "Enabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(0, 170, 255)
                    })
                else
                    safeNotify({
                        Title = "Aimbot Wall Check", 
                        Content = "Disabled (" .. source .. ")",
                        Audio = "rbxassetid://17208361335",
                        Length = 1, 
                        Image = "rbxassetid://4483362458", 
                        BarColor = Color3.fromRGB(255, 0, 0)
                    })
                end
                return true
            end
        end
    end
    return false
end

local function setupDeathListener(targetPlayer)
    local char = getTargetCharacter(targetPlayer)
    if not char then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if config.characterConnections[targetPlayer] then
        pcall(function() config.characterConnections[targetPlayer]:Disconnect() end)
        config.characterConnections[targetPlayer] = nil
    end

    config.characterConnections[targetPlayer] = humanoid.Died:Connect(function()
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
    removeLineESP(targetPlayer)

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
        for _, conn in ipairs(config.playerConnections[pl]) do
            pcall(function() conn:Disconnect() end)
        end
    end
    
    config.playerConnections[pl] = {}
    
    local function updateESPForPlayer()
        if config.espMasterEnabled then
            removeESPLabel(pl)
            removeHighlightESP(pl)
            
            if config.prefTextESP or config.prefBoxESP or config.prefHealthESP or config.prefHeadDotESP then
                if addesp(pl) then
                    makeesp(pl)
                end
            end
            
            if config.prefHighlightESP and pl.Character then
                if addesp(pl) then
                    high(pl)
                end
            end
        end
    end
    
    updateESPForPlayer()
    
    local charAddedConn = pl.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        
        setupDeathListener(pl)
        removeESPLabel(pl)
        removeHighlightESP(pl)
        task.wait(0.1)
        
        if config.hitboxEnabled and targethb(pl) then
            task.wait(0.2)
            expandhb(pl, config.hitboxSize)
        end
        
        if config.espMasterEnabled then
            if config.prefTextESP or config.prefBoxESP or config.prefHealthESP or config.prefHeadDotESP then
                if addesp(pl) then
                    makeesp(pl)
                end
            end
            
            if config.prefHighlightESP then
                if addesp(pl) and pl.Character then
                    high(pl)
                end
            end
        end
    end)
    table.insert(config.playerConnections[pl], charAddedConn)
    
    local charRemovingConn = pl.CharacterRemoving:Connect(function(char)
        removeESPLabel(pl)
        removeHighlightESP(pl)
        restoreTorso(pl)
    end)
    table.insert(config.playerConnections[pl], charRemovingConn)
    
    local teamChangedConn = pl:GetPropertyChangedSignal("Team"):Connect(function()
        task.wait(0.05)
        updateESPForPlayer()
        if config.hitboxEnabled then
            if targethb(pl) then
                expandhb(pl, config.hitboxSize)
            else
                restoreTorso(pl)
            end
        end
    end)
    table.insert(config.playerConnections[pl], teamChangedConn)
    
    if pl.Character then
        setupDeathListener(pl)
        if config.hitboxEnabled and targethb(pl) then
            task.wait(0.1)
            expandhb(pl, config.hitboxSize)
        end
    end
end
local function safeGetCharacter()
    if not localPlayer then return nil end
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    return character, humanoid, rootPart
end

local function TpWalkStart()
    if config._tpwalking then return end
    config._tpwalking = true

    task.spawn(function()
        while config._tpwalking and localPlayer and localPlayer.Character and localPlayer.Character.Parent do
            local character, humanoid, rootPart = safeGetCharacter()
            if not humanoid or humanoid.Health <= 0 or not rootPart then
                task.wait(0.1)
            else
                local delta = RunService.Heartbeat:Wait()
                if humanoid.MoveDirection.Magnitude > 0 then
                    local moveDirection = humanoid.MoveDirection.Unit
                    local velocity = moveDirection * (config.clientCFrameSpeed or 1) * 50
                    pcall(function()
                        rootPart.CFrame = rootPart.CFrame + velocity * delta
                    end)
                end
            end
            task.wait()
        end
        config._tpwalking = false
    end)
end

local function TpWalkStop()
    config._tpwalking = false
end

local _noclipConn
local function startNoclip()
    if _noclipConn then return end
    _noclipConn = RunService.Stepped:Connect(function()
        local char = localPlayer.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                pcall(function() part.CanCollide = false end)
            end
        end
    end)
    config.clientConnections.noclip = _noclipConn
end

local function stopNoclip()
    if _noclipConn then
        pcall(function() _noclipConn:Disconnect() end)
        _noclipConn = nil
        config.clientConnections.noclip = nil
    end
end

local function applyClientWalkSpeed(val)
    local character, humanoid = safeGetCharacter()
    if humanoid then
        if config.clientOriginals.WalkSpeed == nil then
            config.clientOriginals.WalkSpeed = humanoid.WalkSpeed
        end
        pcall(function() humanoid.WalkSpeed = val end)
    end
end

local function applyClientJumpPower(val)
    local character, humanoid = safeGetCharacter()
    if humanoid then
        if config.clientOriginals.JumpPower == nil then
            config.clientOriginals.JumpPower = humanoid.JumpPower or humanoid.JumpHeight or 0
        end
        pcall(function()
            if humanoid.JumpPower ~= nil then
                humanoid.JumpPower = val
            else
                humanoid.JumpHeight = val
            end
        end)
    end
end

local function restoreClientValues()
    local character, humanoid = safeGetCharacter()
    if humanoid then
        if config.clientOriginals.WalkSpeed then
            pcall(function() humanoid.WalkSpeed = config.clientOriginals.WalkSpeed end)
            config.clientOriginals.WalkSpeed = nil
        end
        if config.clientOriginals.JumpPower then
            pcall(function()
                if humanoid.JumpPower ~= nil then
                    humanoid.JumpPower = config.clientOriginals.JumpPower
                else
                    humanoid.JumpHeight = config.clientOriginals.JumpPower
                end
            end)
            config.clientOriginals.JumpPower = nil
        end
    end
    if config.clientCFrameWalkEnabled then
        TpWalkStop()
        config.clientCFrameWalkEnabled = false
    end
    if config.clientNoclip then
        stopNoclip()
        config.clientNoclip = false
    end
end

local function applyClientMaster(state)
    if config.clientMasterEnabled == state then
        return
    end
    config.clientMasterEnabled = state

    if state then
        if config.clientNoclipEnabled then
            startNoclip()
            config.clientNoclip = true
        end
        if config.clientCFrameWalkToggle then
            TpWalkStart()
            config.clientCFrameWalkEnabled = true
        end
        if config.clientWalkEnabled and config.clientWalkSpeed and config.clientWalkSpeed > 0 then
            applyClientWalkSpeed(config.clientWalkSpeed)
        end
        if config.clientJumpEnabled and config.clientJumpPower and config.clientJumpPower > 0 then
            applyClientJumpPower(config.clientJumpPower)
        end
        safeNotify({
            Title = "Client Master",
            Content = "Client features enabled",
            Audio = "rbxassetid://17208361335",
            Length = 1,
            Image = "rbxassetid://4483362458",
            BarColor = Color3.fromRGB(0, 170, 255)
        })
    else
        restoreClientValues()
        safeNotify({
            Title = "Client Master",
            Content = "Client features disabled",
            Audio = "rbxassetid://17208361335",
            Length = 1,
            Image = "rbxassetid://4483362458",
            BarColor = Color3.fromRGB(255, 0, 0)
        })
    end
end

local isPC = not UserInputService.TouchEnabled
local dang = isPC and UDim2.new(0, 600, 0, 450) or UDim2.new(0.7, 0, 0.9, 0)

local Window = Library:Window({
    Title = "Gravel.cc",
    Desc = "by hmmm5651",
    Icon = 7734056878,
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.K,
        Size = dang,
    },
    CloseUIButton = {
        Enabled = true,
        Text = "Gravel.cc",
    }
})

-- Main Tab
local MainTab = Window:Tab({Title = "Main", Icon = "hammer"}) do
    MainTab:Section({Title = "MainTab Settings"})
    MainTab:Section({Title = "Global"})
MainTab:Dropdown({
    Title = "Team Target",
    Desc = "Select Target Team",
    List = {"Enemies", "Teams", "All"},
    Value = "Enemies",
    Callback = function(Option)
        config.masterTeamTarget = Option
        if Option == "All" then
            config.targetMode = "All"
            config.aimbotTeamTarget = "All"
            config.hitboxTeamTarget = "All"
            config.SA2_TeamTarget = "All"
            config.antiAimTarget = "All"
        else
            config.targetMode = Option
            config.aimbotTeamTarget = Option
            config.hitboxTeamTarget = Option
            config.SA2_TeamTarget = Option
            config.antiAimTarget = Option
        end
        
        updateTeamTargetModes()
        syncSilentAimWithMaster()
    end
})
    MainTab:Dropdown({
        Title = "TargetType",
        Desc = "Select target type",
        List = {"Players", "NPCs", "Both"},
        Value = "Players",
        Callback = function(Option)
            config.masterTarget = Option
        end
    })
MainTab:Dropdown({
    Title = "GetTarget",
    Desc = "Target selection method",
    List = {"Closest", "Lowest Health", "TargetSeen"},
    Value = config.masterGetTarget or "Closest",
    Callback = function(Option)
        config.masterGetTarget = Option
        config.aimbotGetTarget = Option
        config.silentGetTarget = Option
        config.antiAimGetTarget = Option
        config.SA2_GetTarget = Option
        syncSilentAimWithMaster()
    end
})

    MainTab:Textbox({
        Title = "Targetseen Switch Rate",
        Desc = "Time between target switches (seconds)",
        Placeholder = "0.2",
        Value = tostring(config.targetSeenSwitchRate or 0.2),
        ClearTextOnFocus = false,
        Callback = function(text)
            local n = tonumber(text)
            if n and n > 0 then
                config.targetSeenSwitchRate = n
            end
        end
    })
MainTab:Toggle({
    Title = "Ignore Forcefield",
    Desc = "Skip targets with forcefields",
    Value = config.ignoreForcefield or true,
    Callback = function(v)
        config.ignoreForcefield = v
    end
})
    MainTab:Section({Title = "Utilities"})
    
    MainTab:Toggle({
        Title = "Toggle AutoFarm ('F')",
        Desc = "Enable/disable auto farm",
        Value = config.autoFarmEnabled or false,
        Callback = function(v)
            config.autoFarmEnabled = v
            if v then
                autoFarmProcess()
                safeNotify({
                    Title = "AutoFarm",
                    Content = "Enabled",
                    Audio = "rbxassetid://17208361335",
                    Length = 2,
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
        end
    })
MainTab:Toggle({
    Title = "Autofarm Wall Check",
    Desc = "Prevent teleporting targets behind walls",
    Value = config.autoFarmWallCheck or false,
    Callback = function(v)
        config.autoFarmWallCheck = v
        if v then
            safeNotify({
                Title = "Autofarm Wall Check",
                Content = "Enabled - Targets behind walls will be ignored",
                Audio = "rbxassetid://17208361335",
                Length = 2,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 170, 255)
            })
        else
            safeNotify({
                Title = "Autofarm Wall Check",
                Content = "Disabled - Will teleport targets even behind walls",
                Audio = "rbxassetid://17208361335",
                Length = 2,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 100, 0)
            })
        end
    end
})
    MainTab:Toggle({
        Title = "QuickToggles",
        Desc = "Show/hide QuickToggles GUI",
        Value = config.QuickToggles or false,
        Callback = function(v)
            config.QuickToggles = v
            if not v then
                KillQT()
            end
        end
    })
    
    MainTab:Button({
        Title = "Partclaim",
        Desc = "Use if NPC mode isn't working well",
        Callback = function()
            pc()
            safeNotify({
                Title = "PartClaim",
                Content = "Refreshed",
                Audio = "rbxassetid://17208361335",
                Length = 3,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 255, 0)
            })
        end
    })
    
    MainTab:Dropdown({
        Title = "Align Part (Autofarm)",
        Desc = "Part to align with crosshair",
        List = {"Head", "HumanoidRootPart"},
        Value = config.autoFarmTargetPart or "Head",
        Callback = function(Option)
            config.autoFarmTargetPart = Option
        end
    })
    
    MainTab:Slider({
        Title = "GetPart (Partclaim)",
        Desc = "Part replication distance",
        Min = 0,
        Max = 1000,
        Rounding = 0,
        Value = config.gp or 200,
        Callback = function(val)
            config.gp = val
        end
    })
    

MainTab:Slider({
    Title = "TP Max Range (Autofarm)",
    Desc = "Maximum distance to teleport targets",
    Min = 0,
    Max = 999999999,
    Rounding = 0,
    Value = config.autoFarmMaxRange or 50,
    Callback = function(val)
        config.autoFarmMaxRange = val
    end
})

    MainTab:Slider({
        Title = "TP Distance (Autofarm)",
        Desc = "Teleport distance for autofarm",
        Min = 1,
        Max = 100,
        Rounding = 0,
        Value = config.autoFarmDistance or 10,
        Callback = function(val)
            config.autoFarmDistance = val
        end
    })
    
    MainTab:Slider({
        Title = "Vertical Offset (Autofarm)",
        Desc = "Vertical offset for autofarm",
        Min = -50,
        Max = 50,
        Rounding = 0,
        Value = config.autoFarmVerticalOffset or 0,
        Callback = function(val)
            config.autoFarmVerticalOffset = val
        end
    })

    MainTab:Section({Title = "Keybinds [might not work well]"})

    MainTab:Toggle({
        Title = "Holdkey Toggle",
        Desc = "[Re-Toggle When HK Type is Changed]",
        Value = config.holdkeyToggle.enabled or false,
        Callback = function(v)
            config.holdkeyToggle.enabled = v
            updateHoldkeyState()
            if v then
                safeNotify({
                    Title = "Holdkey",
                    Content = "Enabled - Hold " .. config.holdkeyToggle.modifier .. " + key to toggle",
                    Length = 2,
                    Image = "rbxassetid://4483362458",
                    BarColor = Color3.fromRGB(0, 170, 255)
                })
            else
                safeNotify({
                    Title = "Holdkey",
                    Content = "Disabled",
                    Length = 1,
                    Image = "rbxassetid://4483362458",
                    BarColor = Color3.fromRGB(255, 0, 0)
                })
            end
        end
    })

    MainTab:Dropdown({
        Title = "Holdkey Type",
        Desc = "Select modifier key for holdkey toggle",
        List = {"RCtrl", "LCtrl", "RShift", "LShift"},
        Value = config.holdkeyToggle.modifier or "RCtrl",
        Callback = function(Option)
            config.holdkeyToggle.modifier = Option
            if config.holdkeyToggle.enabled then
            end
        end
    })

    local function createKeybindButton(name, defaultKey, configKey)
        MainTab:Textbox({
            Title = name .. " Keybind",
            Desc = config.holdkeyToggle.enabled and 
                   "Hold " .. config.holdkeyToggle.modifier .. " + press key then click set" or
                   "Press the key then click set",
            Placeholder = defaultKey,
            Value = config.keybinds[configKey] or defaultKey,
            ClearTextOnFocus = false,
            Callback = function(text)
                config.keybinds[configKey] = text:upper()
                safeNotify({
                    Title = "Keybind",
                    Content = config.holdkeyToggle.enabled and 
                             "Assigned " .. name .. ": " .. config.holdkeyToggle.modifier .. " + " .. text:upper() or
                             "Assigned " .. name .. ": " .. text:upper(),
                    Length = 1,
                    Image = "rbxassetid://4483362458"
                })
            end
        })
    end

    createKeybindButton("SilentAim (HB)", "E", "silentaim")
    createKeybindButton("Aimbot", "Q", "aimbot")
    createKeybindButton("AutoFarm", "F", "autofarm")
    createKeybindButton("AntiAim", "L", "antiaim")
    createKeybindButton("Hitbox", "G", "hitbox")
    createKeybindButton("ESP", "Z", "esp")
    createKeybindButton("Client Config", "V", "client")
    createKeybindButton("SilentAim Wall Check", "B", "silentaimwallcheck")
    createKeybindButton("Aimbot Wall Check", "H", "aimbotwallcheck")
    createKeybindButton("SilentAim (HK)", "R", "silentaimhk")
    createKeybindButton("SilentAim (HK) Wall Check", "T", "silentaimhkwallcheck")
    
    MainTab:Section({Title = "Optimization"})
    local CodeBlock = MainTab:Code({
        Title = "Optimization [copy code and execute]",
        Code = [[
--  you adjust stuff here
local Config = {
    NETWORK_OPTIMIZATION = true,
    REDUCE_REPLICATION = true,
    THROTTLE_REMOTE_EVENTS = true,
    OPTIMIZE_CHAT = true,
    DISABLE_UNNECESSARY_GUI = true,
    STREAMING_ENABLED = true,
    REDUCE_PLAYER_REPLICATION_DISTANCE = 100,
    THROTTLE_SOUNDS = true,
    DESTROY_EMITTERS = true,
    REMOVE_GRASS = true,
    CORE = true,
    FPS_MONITOR = true,
    OPTIZ = true,
    OPTIMIZATION_INTERVAL = 10,
    MIN_INTERVAL = 3,
    MAX_DISTANCE = 50,
    PERFORMANCE_MONITORING = true,
    FPS_THRESHOLD = 30,
    GRAY_SKY_ENABLED = true,
    GRAY_SKY_ID = "rbxassetid://114666145996289",
    FULL_BRIGHT_ENABLED = true,
    SMOOTH_PLASTIC_ENABLED = true,
    COLLISION_GROUP_NAME = "OptimizedParts",
    OPTIMIZE_PHYSICS = true,
    DISABLE_CONSTRAINTS = true,
    THROTTLE_PARTICLES = true,
    THROTTLE_TEXTURES = true,
    REMOVE_ANIMATIONS = true,
    LOW_POLY_CONVERSION = true,
    SELECTIVE_TEXTURE_REMOVAL = true,
    PRESERVE_IMPORTANT_TEXTURES = true,
    IMPORTANT_TEXTURE_KEYWORDS = {"sign", "ui", "hud", "menu", "button", "fence"},
    QUALITY_LEVEL = 1,
    FPS_CAP = 1000,
    MEMORY_CLEANUP_THRESHOLD = 500,
}

local Optiz = loadstring(game:HttpGet('https://raw.githubusercontent.com/hm5650/Optiz/refs/heads/main/Optiz.lua'))()(OptizConfig)]]
    })
    MainTab:Slider({
        Title = "Updaters speed",
        Desc = "Increase performance when increased costs Accuracy",
        Min = 0,
        Max = 50,
        Rounding = 0,
        Value = patcherwait or 0.3,
        Callback = function(val)
            patcherwait = val
        end
    })
MainTab:Toggle({
    Title = "Updaters",
    Desc = "Stops other Updaters when disabled Increases performance. Might cause features to not work",
    Value = patcher or true,
    Callback = function(v)
        patcher = v
    end
})
end

-- Visuals Tab
local VisualsTab = Window:Tab({Title = "Visuals", Icon = "eye"}) do
    VisualsTab:Section({Title = "ESP Master"})
    
    VisualsTab:Toggle({
        Title = "Toggle ESP ('Z')",
        Desc = "Enable/disable all ESP features",
        Value = config.espMasterEnabled or false,
        Callback = function(v)
            applyESPMaster(v)
            if v then
                safeNotify({
                    Title = "ESP Master",
                    Content = "ESP Enabled",
                    Audio = "rbxassetid://17208361335",
                    Length = 1,
                    Image = "rbxassetid://4483362458",
                    BarColor = Color3.fromRGB(0, 170, 255)
                })
            else
                safeNotify({
                    Title = "ESP Master",
                    Content = "ESP Disabled",
                    Audio = "rbxassetid://17208361335",
                    Length = 1,
                    Image = "rbxassetid://4483362458",
                    BarColor = Color3.fromRGB(255, 0, 0)
                })
            end
        end
    })
    
    VisualsTab:Section({Title = "ESP Components"})
    
    VisualsTab:Toggle({
        Title = "Toggle Highlight ESP",
        Desc = "Enable player highlight",
        Value = config.prefHighlightESP or false,
        Callback = function(v)
            toggleHighlightESP(v)
            espRefresher()
        end
    })
    
    VisualsTab:Toggle({
        Title = "Toggle Text ESP",
        Desc = "Show player names/health",
        Value = config.prefTextESP or false,
        Callback = function(v)
            toggleTextESP(v)
            espRefresher()
        end
    })
    
    VisualsTab:Toggle({
        Title = "Toggle Box ESP",
        Desc = "Show bounding boxes",
        Value = config.prefBoxESP or false,
        Callback = function(v)
            toggleBoxESP(v)
            espRefresher()
        end
    })
    
    VisualsTab:Toggle({
        Title = "Toggle Health ESP",
        Desc = "Show health bars",
        Value = config.prefHealthESP or false,
        Callback = function(v)
            toggleHealthESP(v)
            espRefresher()
        end
    })
    
    VisualsTab:Toggle({
        Title = "Toggle Head Dot ESP",
        Desc = "Show head indicators",
        Value = config.prefHeadDotESP or false,
        Callback = function(v)
            config.prefHeadDotESP = v
            if config.espMasterEnabled then
                for _, target in ipairs(getAllTargets()) do
                    if addesp(target) and not config.espData[target] then
                        makeesp(target)
                    end
                end
                updateESPColors()
            end
            espRefresher()
        end
    })
    

    VisualsTab:Toggle({
        Title = "Toggle Tracer ESP",
        Desc = "Draw lines to targets",
        Value = config.lineESPEnabled or false,
        Callback = function(v)
            config.lineESPEnabled = v
            if not v then
                for target, _ in pairs(config.lineESPData) do
                    removeLineESP(target)
                end
            end
            espRefresher()
        end
    })
    
    VisualsTab:Toggle({
        Title = "Tracer ESP Only Targets",
        Desc = "Only show lines when targeting with aimbot/silent aim",
        Value = config.lineESPOnlyTarget or false,
        Callback = function(v)
            config.lineESPOnlyTarget = v
            espRefresher()
        end
    })
    
    VisualsTab:Dropdown({
        Title = "Tracer Start Position",
        Desc = "Where lines start from on screen",
        List = {"Center", "Bottom", "Top", "BottomLeft", "BottomRight", "TopLeft", "TopRight"},
        Value = config.lineStartPosition or "Center",
        Callback = function(Option)
            config.lineStartPosition = Option
        end
    })
    
    
VisualsTab:Toggle({
    Title = "ESP Colour Based On Health",
    Desc = "Dynamic color based on health",
    Value = config.prefColorByHealth or false,
    Callback = function(v)
        config.prefColorByHealth = v
        updateESPColors()
        espRefresher()
    end
})
VisualsTab:Toggle({
    Title = "Full Bright",
    Desc = "Enable/disable full bright (no lighting)",
    Value = false,
    Callback = function(v)
        if v then
            local lighting = game:GetService("Lighting")
            fullBrightSettings = {
                Ambient = lighting.Ambient,
                Brightness = lighting.Brightness,
                ClockTime = lighting.ClockTime,
                FogEnd = lighting.FogEnd,
                GlobalShadows = lighting.GlobalShadows,
                OutdoorAmbient = lighting.OutdoorAmbient
            }

            lighting.Ambient = Color3.fromRGB(255, 255, 255)
            lighting.Brightness = 2
            lighting.FogEnd = 100000
            lighting.GlobalShadows = false
            lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            
            lighting.ClockTime = 14
            
            safeNotify({
                Title = "Full Bright",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 2,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 255, 0)
            })
        else
            if fullBrightSettings then
                local lighting = game:GetService("Lighting")
                for property, value in pairs(fullBrightSettings) do
                    lighting[property] = value
                end
                fullBrightSettings = nil
            end
            
            safeNotify({
                Title = "Full Bright",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end
})
end

-- AntiAim Tab
local AntiAimTab = Window:Tab({Title = "AntiAim", Icon = "shield"}) do
    AntiAimTab:Section({Title = "[ Bad Injectors might work here ]"})
    AntiAimTab:Section({Title = "[ This might not work on every game ]"})
    AntiAimTab:Section({Title = "AntiAim Master"})
    
AntiAimTab:Toggle({
    Title = "Toggle AntiAim ('L')",
    Desc = "Enable/disable AntiAim",
    Value = config.antiAimEnabled or false,
    Callback = function(v)
        config.antiAimEnabled = v
        if config.desyncEnabled ~= nil then
            config.desyncEnabled = v and config.desyncToggleEnabled
        end
        
        if not v then
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
            if config.nextGenRepDesiredState then
                task.spawn(function()
                    task.wait(0.5)
                    if config.antiAimEnabled and config.nextGenRepDesiredState and not config.nextGenRepEnabled then
                        nextgenrep(true)
                    end
                end)
            end
            
            safeNotify({
                Title = "AntiAim",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 100, 0)
            })
        end
    end
})

    
    AntiAimTab:Section({Title = "AntiAim Modes"})
    
    AntiAimTab:Toggle({
        Title = "Raycast AntiAim",
        Desc = "Teleport when targeted",
        Value = config.raycastAntiAim or false,
        Callback = function(v)
            config.raycastAntiAim = v
            if v then
                config.antiAimAbovePlayer = false
                config.antiAimBehindPlayer = false
                config.antiAimOrbitEnabled = false
            end
        end
    })
    
    AntiAimTab:Toggle({
        Title = "Above Player",
        Desc = "Teleport above target",
        Value = config.antiAimAbovePlayer or false,
        Callback = function(v)
            config.antiAimAbovePlayer = v
            if v then
                config.raycastAntiAim = false
                config.antiAimBehindPlayer = false
                config.antiAimOrbitEnabled = false
            else
                returnToOriginalPosition()
            end
        end
    })
    
    AntiAimTab:Toggle({
        Title = "Behind Player",
        Desc = "Teleport behind target",
        Value = config.antiAimBehindPlayer or false,
        Callback = function(v)
            config.antiAimBehindPlayer = v
            if v then
                config.raycastAntiAim = false
                config.antiAimAbovePlayer = false
                config.antiAimOrbitEnabled = false
            else
                returnToOriginalPosition()
            end
        end
    })
    
    AntiAimTab:Toggle({
        Title = "Orbit Players",
        Desc = "Orbit around nearest target",
        Value = config.antiAimOrbitEnabled or false,
        Callback = function(v)
            config.antiAimOrbitEnabled = v
            if v then
                config.raycastAntiAim = false
                config.antiAimAbovePlayer = false
                config.antiAimBehindPlayer = false
                if not config.antiAimEnabled then
                    config.antiAimEnabled = true
                end
            else
                returnToOriginalPosition()
            end
        end
    })
    
    AntiAimTab:Section({Title = "AntiAim Settings"})
    
    AntiAimTab:Textbox({
        Title = "Teleport Distance (Raycast)",
        Desc = "Distance to teleport when targeted",
        Placeholder = "3",
        Value = tostring(config.antiAimTPDistance or 3),
        ClearTextOnFocus = false,
        Callback = function(text)
            local n = tonumber(text)
            if n and n > 0 then
                config.antiAimTPDistance = n
            end
        end
    })
    
    AntiAimTab:Textbox({
        Title = "Above Height (Above Player)",
        Desc = "Height above target",
        Placeholder = "10",
        Value = tostring(config.antiAimAboveHeight or 10),
        ClearTextOnFocus = false,
        Callback = function(text)
            local n = tonumber(text)
            if n and n > 0 then
                config.antiAimAboveHeight = n
            end
        end
    })
    
    AntiAimTab:Textbox({
        Title = "Behind Distance (Behind Player)",
        Desc = "Distance behind target",
        Placeholder = "5",
        Value = tostring(config.antiAimBehindDistance or 5),
        ClearTextOnFocus = false,
        Callback = function(text)
            local n = tonumber(text)
            if n and n > 0 then
                config.antiAimBehindDistance = n
            end
        end
    })
    
    AntiAimTab:Textbox({
        Title = "Orbit Speed (Orbit)",
        Desc = "Angular speed multiplier",
        Placeholder = "5",
        Value = tostring(config.antiAimOrbitSpeed or 5),
        ClearTextOnFocus = false,
        Callback = function(text)
            local n = tonumber(text)
            if n and n > 0 then
                config.antiAimOrbitSpeed = n
            end
        end
    })
    
    AntiAimTab:Textbox({
        Title = "Orbit Radius (Orbit)",
        Desc = "Distance from target",
        Placeholder = "5",
        Value = tostring(config.antiAimOrbitRadius or 5),
        ClearTextOnFocus = false,
        Callback = function(text)
            local n = tonumber(text)
            if n and n >= 0 then
                config.antiAimOrbitRadius = n
            end
        end
    })
    
    AntiAimTab:Textbox({
        Title = "Orbit Height (Orbit)",
        Desc = "Vertical offset",
        Placeholder = "0",
        Value = tostring(config.antiAimOrbitHeight or 0),
        ClearTextOnFocus = false,
        Callback = function(text)
            local n = tonumber(text)
            if n then
                config.antiAimOrbitHeight = n
            end
        end
    })
    AntiAimTab:Section({Title = "Network Settings"})
    
    AntiAimTab:Toggle({
        Title = "Enable Desync",
        Desc = "Enable/disable desync",
        Value = config.desyncToggleEnabled or false,
        Callback = function(v)
            config.desyncToggleEnabled = v
            config.desyncEnabled = v and config.antiAimEnabled
        end
    })
    
    AntiAimTab:Toggle({
        Title = "Modify Desync Offset",
        Desc = "Use custom desync offset instead of ping-based",
        Value = config.customDesyncEnabled or false,
        Callback = function(v)
            config.customDesyncEnabled = v
        end
    })
    
    AntiAimTab:Textbox({
        Title = "Desync X Offset",
        Desc = "X-axis desync offset",
        Placeholder = "0",
        Value = tostring(config.desyncX or 0),
        ClearTextOnFocus = false,
        Callback = function(text)
            local n = tonumber(text)
            if n then
                config.desyncX = n
            end
        end
    })
    
    AntiAimTab:Textbox({
        Title = "Desync Y Offset",
        Desc = "Y-axis desync offset",
        Placeholder = "0",
        Value = tostring(config.desyncY or 0),
        ClearTextOnFocus = false,
        Callback = function(text)
            local n = tonumber(text)
            if n then
                config.desyncY = n
            end
        end
    })
    
    AntiAimTab:Textbox({
        Title = "Desync Z Offset",
        Desc = "Z-axis desync offset",
        Placeholder = "-2",
        Value = tostring(config.desyncZ or -2),
        ClearTextOnFocus = false,
        Callback = function(text)
            local n = tonumber(text)
            if n then
                config.desyncZ = n
            end
        end
    })

AntiAimTab:Toggle({
    Title = "Lock Serverside",
    Desc = "Locks you in Servers not in the client (You would still get killed in the server but not in the client)",
    Value = config.nextGenRepDesiredState or false,
    Callback = function(v)
        nextgenrep(v)
    end
})

end
-- Aimbot Tab
local AimbotTab = Window:Tab({Title = "Aimbot", Icon = "crosshair"}) do
    AimbotTab:Section({Title = "[ Bad Injectors might work here ]"})
    AimbotTab:Section({Title = "Aimbot Master"})
    
AimbotTab:Toggle({
    Title = "Toggle Aimbot ('Q')",
    Desc = "Enable/disable aimbot",
    Value = config.aimbotEnabled or false,
    Callback = function(v)
        handleAimbotToggle(v)
        if v then
            safeNotify({
                Title = "Aimbot",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 255, 0)
            })
        else
            safeNotify({
                Title = "Aimbot",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end
})
    
    AimbotTab:Section({Title = "Aimbot Settings"})
    
    AimbotTab:Toggle({
        Title = "WallCheck AB ('B')",
        Desc = "Check for walls",
        Value = config.aimbotWallCheck or false,
        Callback = function(v)
            config.aimbotWallCheck = v
        end
    })
    
    AimbotTab:Toggle({
        Title = "360° Aimbot",
        Desc = "Target in all directions",
        Value = config.aimbot360Enabled or false,
        Callback = function(v)
            toggle360Aimbot(v)
        end
    })
    AimbotTab:Dropdown({
        Title = "Target Part",
        Desc = "Part to aim at",
        List = {"Head", "HumanoidRootPart", "Torso"},
        Value = config.aimbotTargetPart or "Head",
        Callback = function(Option)
            config.aimbotTargetPart = Option
        end
    })
    AimbotTab:Slider({
        Title = "Aim Strength",
        Desc = "Smoothing strength",
        Min = 0,
        Max = 1,
        Rounding = 1,
        Value = config.aimbotStrength or 0.5,
        Callback = function(val)
            config.aimbotStrength = val
        end
    })
    
    AimbotTab:Slider({
        Title = "FOV Size",
        Desc = "Aimbot field of view",
        Min = 1,
        Max = 500,
        Rounding = 0,
        Value = config.aimbotFOVSize or 70,
        Callback = function(val)
            config.aimbotFOVSize = val
            updateAimbotFOVRing()
        end
    })
end

-- SilentAim Tab
local SilentAimTab = Window:Tab({Title = "SilentAim (HB)", Icon = "circle"}) do
    SilentAimTab:Section({Title = "[ Hitbox Based ]"})
    SilentAimTab:Section({Title = "[ Bad Injectors might work here ]"})
    SilentAimTab:Section({Title = "[ This might not work on every game ]"})
    SilentAimTab:Section({Title = "SilentAim Master"})
    
SilentAimTab:Toggle({
    Title = "Toggle SilentAim (HB) ('E')",
    Desc = "Enable/disable silent aim",
    Value = config.startsa or false,
    Callback = function(v)
        config.startsa = v
        if not v then
            if gui.RingHolder then
                gui.RingHolder.Visible = false
            end
            local targetsToRemove = {}
            for pl, _ in pairs(config.activeApplied) do
                table.insert(targetsToRemove, pl)
            end
            for _, pl in ipairs(targetsToRemove) do
                restorePartForPlayer(pl)
            end
            safeNotify({
                Title = "SilentAim",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        else
            if gui.RingHolder then
                gui.RingHolder.Visible = true
            end
            safeNotify({
                Title = "SilentAim",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 100, 0)
            })
        end
    end
})
    
    SilentAimTab:Section({Title = "SilentAim Settings"})
    
    SilentAimTab:Toggle({
        Title = "WallCheck SA (B)",
        Desc = "Check for walls",
        Value = config.wallc or false,
        Callback = function(v)
            config.wallc = v
        end
    })
    SilentAimTab:Dropdown({
        Title = "Target Part",
        Desc = "Part to target",
        List = {"Head", "HumanoidRootPart", "Both"},
        Value = config.bodypart or "Head",
        Callback = function(Option)
            local targetsToRemove = {}
            for pl, _ in pairs(config.activeApplied) do
                table.insert(targetsToRemove, pl)
            end
            for _, pl in ipairs(targetsToRemove) do
                restorePartForPlayer(pl)
            end
            config.bodypart = Option
        end
    })
    
    SilentAimTab:Slider({
        Title = "HitChance",
        Desc = "Chance to hit target",
        Min = 0,
        Max = 100,
        Rounding = 0,
        Suffix = "%",
        Value = config.hitchance or 100,
        Callback = function(val)
            config.hitchance = val
        end
    })
    
    SilentAimTab:Slider({
        Title = "FovSize",
        Desc = "Silent aim field of view",
        Min = 1,
        Max = 500,
        Rounding = 0,
        Value = config.fovsize or 120,
        Callback = function(val)
            config.fovsize = val
            if gui.RingHolder then
                gui.RingHolder.Size = UDim2.new(0, math.max(8, config.fovsize * 2), 0, math.max(8, config.fovsize * 2))
            end
        end
    })
    SilentAimTab:Slider({
        Title = "Hitbox Transparency",
        Desc = "SilentAim Hitbox Transparency",
        Min = 0,
        Max = 1,
        Rounding = 1,
        Value = config.fovsize or 120,
        Callback = function(val)
            config.hbtrans = val
        end
    })
end
-- SilentAimTab 2
local SilentAimTab2 = Window:Tab({Title = "SilentAim (HK)", Icon = "target"}) do
    SilentAimTab2:Section({Title = "[ Hooked Based ]"})
    SilentAimTab2:Section({Title = "[ NPC & ignoreforcefield support doesn't work here :( ]"})
    SilentAimTab2:Section({Title = "[ Good Injectors are recommend ]"})
    SilentAimTab2:Section({Title = "[ This might not work on every game ]"})
    SilentAimTab2:Section({Title = "SilentAim Master"})
    SilentAimTab2:Toggle({
        Title = "Toggle SilentAim (HK) ('R')",
        Desc = "Enable/disable silent aim",
        Value = config.SA2_Enabled or false,
        Callback = function(v)
            config.SA2_Enabled = v
            safeNotify({
                Title = "Silent Aim",
                Content = "Silent Aim " .. (v and "Enabled" or "Disabled"),
                Audio = "rbxassetid://17208361335",
                Length = 3,
                Image = "rbxassetid://4483362458",
                BarColor = v and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            })
        end
    })
    SilentAimTab2:Section({Title = "SilentAim Settings"})
    SilentAimTab2:Toggle({
        Title = "WallCheck ('T')",
        Desc = "Check for walls before targeting",
        Value = config.SA2_Wallcheck or false,
        Callback = function(v)
            config.SA2_Wallcheck = v
        end
    })
    SilentAimTab2:Toggle({
        Title = "360 Mode",
        Desc = "Enable silent aim in all directions",
        Value = config.SA2_ThreeSixtyMode or false,
        Callback = function(v)
            config.SA2_ThreeSixtyMode = v
        end
    })

    SilentAimTab2:Dropdown({
        Title = "Aim Method",
        List = {"Raycast", "FindPartOnRay", "FindPartOnRayWithWhitelist", "FindPartOnRayWithIgnoreList", "Mouse.Hit", "All"},
        Value = config.SA2_Method or "Raycast",
        Callback = function(choice)
            config.SA2_Method = choice
        end
    })
    SilentAimTab2:Dropdown({
        Title = "Target Part",
        List = {"Head", "HumanoidRootPart"},
        Value = config.SA2_TargetPart or "Head",
        Callback = function(choice)
            config.SA2_TargetPart = choice
            safeNotify({
                Title = "Target Part",
                Content = "Targeting: " .. choice,
                Audio = "rbxassetid://17208361335",
                Length = 3,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 255, 0)
            })
        end
    })
    
    SilentAimTab2:Slider({
        Title = "Hit Chance",
        Desc = "Accuracy percentage",
        Min = 0,
        Max = 100,
        Rounding = 0,
        Value = config.SA2_HitChance or 100,
        Callback = function(val)
            config.SA2_HitChance = val
        end
    })
    
    SilentAimTab2:Slider({
        Title = "FOV Radius",
        Desc = "Field of View size",
        Min = 0,
        Max = 500,
        Rounding = 0,
        Value = config.SA2_FovRadius or 100,
        Callback = function(val)
            config.SA2_FovRadius = val
        end
    })
end

-- Hitbox Tab
local HitboxTab = Window:Tab({Title = "Hitbox", Icon = "box"}) do
    HitboxTab:Section({Title = "[ Bad Injectors might work here ]"})
    HitboxTab:Section({Title = "[ This might not work on every game ]"})
    HitboxTab:Section({Title = "Hitbox Master"})
    
HitboxTab:Toggle({
    Title = "Toggle Hitbox ('G')",
    Desc = "Expand hitboxes",
    Value = config.hitboxEnabled or false,
    Callback = function(v)
        config.hitboxEnabled = v
        if v then
            applyhb()
            safeNotify({
                Title = "Hitbox",
                Content = "Enabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(0, 255, 0)
            })
        else
            for player, _ in pairs(config.hitboxExpandedParts) do
                restoreTorso(player)
            end
            config.hitboxExpandedParts = {}
            safeNotify({
                Title = "Hitbox",
                Content = "Disabled",
                Audio = "rbxassetid://17208361335",
                Length = 1,
                Image = "rbxassetid://4483362458",
                BarColor = Color3.fromRGB(255, 0, 0)
            })
        end
    end
})
    
    HitboxTab:Section({Title = "Hitbox Settings"})
    
    HitboxTab:Dropdown({
        Title = "Team Target",
        Desc = "Select target team preference",
        List = {"Enemies", "Teams", "All"},
        Value = config.hitboxTeamTarget or "Enemies",
        Callback = function(Option)
            if config.masterTeamTarget == "All" then return end
            config.hitboxTeamTarget = Option
            applyhb()
        end
    })
    
    HitboxTab:Slider({
        Title = "Hitbox Size",
        Desc = "Size of expanded hitboxes",
        Min = 1,
        Max = 500,
        Rounding = 0,
        Value = config.hitboxSize or 10,
        Callback = function(val)
            config.hitboxSize = val
            if config.hitboxEnabled then
                for player, data in pairs(config.hitboxExpandedParts) do
                    if player and targethb(player) and data and data.part and data.part.Parent then
                        local newSize = Vector3.new(val, val, val)
                        data.targetSize = newSize
                        config.hitboxLastSize[player] = val
                        pcall(function()
                            data.part.Size = newSize
                        end)
                    end
                end
            end
        end
    })
end

-- Client Tab
local ClientTab = Window:Tab({Title = "Client", Icon = "user"}) do
    ClientTab:Section({Title = "Client Master"})
    
    ClientTab:Toggle({
        Title = "Enable Client Configuration ('V')",
        Desc = "Enable/disable all client features",
        Value = config.clientMasterEnabled or false,
        Callback = function(v)
            applyClientMaster(v)
        end
    })
    
    ClientTab:Section({Title = "Client Features"})
    
    ClientTab:Toggle({
        Title = "Noclip",
        Desc = "Walk through walls",
        Value = config.clientNoclipEnabled or false,
        Callback = function(v)
            config.clientNoclipEnabled = v
            if config.clientMasterEnabled then
                if v then
                    startNoclip()
                    config.clientNoclip = true
                else
                    stopNoclip()
                    config.clientNoclip = false
                end
            else
                stopNoclip()
                config.clientNoclip = false
            end
        end
    })
    
    ClientTab:Toggle({
        Title = "Enable WalkSpeed",
        Desc = "Custom walk speed",
        Value = config.clientWalkEnabled or false,
        Callback = function(v)
            config.clientWalkEnabled = v
            if config.clientMasterEnabled and v then
                applyClientWalkSpeed(config.clientWalkSpeed or 16)
            end
        end
    })
    
    ClientTab:Toggle({
        Title = "Enable JumpPower",
        Desc = "Custom jump power",
        Value = config.clientJumpEnabled or false,
        Callback = function(v)
            config.clientJumpEnabled = v
            if config.clientMasterEnabled and v then
                applyClientJumpPower(config.clientJumpPower or 50)
            end
        end
    })
    
    ClientTab:Toggle({
        Title = "CFrame Walk",
        Desc = "Smooth CFrame movement",
        Value = config.clientCFrameWalkToggle or false,
        Callback = function(v)
            config.clientCFrameWalkToggle = v
            if config.clientMasterEnabled then
                if v then
                    TpWalkStart()
                    config.clientCFrameWalkEnabled = true
                else
                    TpWalkStop()
                    config.clientCFrameWalkEnabled = false
                end
            else
                TpWalkStop()
                config.clientCFrameWalkEnabled = false
            end
        end
    })
    
    ClientTab:Section({Title = "Client Values"})
    
    ClientTab:Slider({
        Title = "WalkSpeed Value",
        Desc = "Custom walk speed value",
        Min = 0,
        Max = 500,
        Rounding = 0,
        Value = config.clientWalkSpeed or 16,
        Callback = function(val)
            config.clientWalkSpeed = val
            if config.clientMasterEnabled and config.clientWalkEnabled then
                applyClientWalkSpeed(val)
            end
        end
    })
    
    ClientTab:Slider({
        Title = "JumpPower Value",
        Desc = "Custom jump power value",
        Min = 0,
        Max = 500,
        Rounding = 0,
        Value = config.clientJumpPower or 50,
        Callback = function(val)
            config.clientJumpPower = val
            if config.clientMasterEnabled and config.clientJumpEnabled then
                applyClientJumpPower(val)
            end
        end
    })
    
    ClientTab:Slider({
        Title = "CFrame Walk Speed",
        Desc = "CFrame movement speed",
        Min = 0,
        Max = 500,
        Rounding = 0,
        Value = config.clientCFrameSpeed or 1,
        Callback = function(val)
            config.clientCFrameSpeed = val
        end
    })
end
Window:Line()

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
ringStroke.Color = config.fovc or Color3.fromRGB(200, 200, 255)
ringStroke.Transparency = 0

gui.ScreenGui = fovScreenGui
gui.MainFrame = mainFrame
gui.RingHolder = ringHolder
gui.RingStroke = ringStroke
aimbotfov()

safeNotify({
    Title = "Gravel.cc",
    Content = "script made by hmmm5651\nyt: @gpsickle",
    Audio = "rbxassetid://17208361335",
    Length = 5,
    Image = "rbxassetid://4483362458",
    BarColor = Color3.fromRGB(0, 170, 255)
})

local function isCtrlDown()
    local leftCtrl = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
    local rightCtrl = UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
    return leftCtrl or rightCtrl
end

local function isShiftDown()
    local leftShift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
    local rightShift = UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
    return leftShift or rightShift
end

local function SetupRespawnHandler()
    plr.CharacterAdded:Connect(function(character)
        if respawnLock then
            wait(1.5)
            
            local humanoid = character:WaitForChild("Humanoid", 5)
            if humanoid and humanoid.Health > 0 then
                if wasEnabledBeforeDeath then
                    config.SA2_Enabled = true
                end
                
                if wasESPEnabledBeforeDeath then
                    config.espMasterEnabled = true
                end
                
                respawnLock = false
                wasEnabledBeforeDeath = false
                wasESPEnabledBeforeDeath = false
            end
        end
    end)
    
    plr.CharacterRemoving:Connect(function(character)
        if config.SA2_Enabled then
            wasEnabledBeforeDeath = true
        end
        
        if config.espMasterEnabled then
            wasESPEnabledBeforeDeath = true
        end
        
        config.SA2_Enabled = false
        config.espMasterEnabled = false
        respawnLock = true
    end)
    
    local function trackHumanoidDeath()
        if plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Died:Connect(function()
                    if config.SA2_Enabled then
                        wasEnabledBeforeDeath = true
                    end
                    
                    if config.espMasterEnabled then
                        wasESPEnabledBeforeDeath = true
                    end
                    
                    config.SA2_Enabled = false
                    config.espMasterEnabled = false
                    respawnLock = true
                end)
            end
        end
    end
    
    if plr.Character then
        trackHumanoidDeath()
    end
    
    plr.CharacterAdded:Connect(function()
        wait(0.5)
        trackHumanoidDeath()
    end)
end

local function init()
    pc()
    SetupRespawnHandler()
    syncSilentAimWithMaster()
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
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= localPlayer then
            setupPlayerListeners(pl)
            if config.hitboxEnabled and targethb(pl) then
                task.spawn(function()
                    task.wait(0.5)
                    expandhb(pl, config.hitboxSize)
                end)
            end
        end
    end
    Players.PlayerAdded:Connect(function(pl)
        if pl ~= localPlayer then
            setupPlayerListeners(pl)
            
            if config.hitboxEnabled then
                pl.CharacterAdded:Connect(function(char)
                    task.wait(0.5)
                    if targethb(pl) then
                        expandhb(pl, config.hitboxSize)
                    end
                end)
                
                if pl.Character and targethb(pl) then
                    task.wait(0.5)
                    expandhb(pl, config.hitboxSize)
                end
            end
        end
    end)
    
    Players.PlayerRemoving:Connect(function(pl)
        cleanplrdata(pl)
    end)
    
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= localPlayer then
            setupPlayerListeners(pl)
            if config.espMasterEnabled then
                if config.prefTextESP or config.prefBoxESP or config.prefHealthESP then
                    if addesp(pl) then
                        makeesp(pl)
                    end
                end
                if config.prefHighlightESP and pl.Character then
                    if addesp(pl) then
                        high(pl)
                    end
                end
            end
        end
    end
    
    Players.PlayerAdded:Connect(function(pl)
        if pl ~= localPlayer then
            setupPlayerListeners(pl)
            task.wait(0.5)
            
            if config.espMasterEnabled then
                if config.prefTextESP or config.prefBoxESP or config.prefHealthESP then
                    if addesp(pl) then
                        makeesp(pl)
                    end
                end
                if config.prefHighlightESP and pl.Character then
                    if addesp(pl) then
                        high(pl)
                    end
                end
            end
        end
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
            local keyName = keyNameFromInput(input)
            local kc = input.KeyCode
            if keyName then
                local matched = applyKeybindAction(keyName, true)
                if matched then return end
            end
            
            if isCtrlDown() then
                if kc == Enum.KeyCode.Z then
                    config.espMasterEnabled = not config.espMasterEnabled
                    applyESPMaster(config.espMasterEnabled)
                    safeNotify({
                        Title = "ESP Master",
                        Content = config.espMasterEnabled and "Enabled (Hotkey)" or "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://4483362458",
                        BarColor = config.espMasterEnabled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 0, 0)
                    })
                elseif kc == Enum.KeyCode.F then
                    config.autoFarmEnabled = not config.autoFarmEnabled
                    if config.autoFarmEnabled then
                        autoFarmProcess()
                        safeNotify({
                            Title = "AutoFarm",
                            Content = "Enabled (Hotkey)\nAligning " .. config.autoFarmTargetPart .. " to crosshair",
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
                elseif kc == Enum.KeyCode.E then
                    config.startsa = not config.startsa
                    if not config.startsa then
                        if gui.RingHolder then gui.RingHolder.Visible = false end
                        local targetsToRemove = {}
                        for pl, _ in pairs(config.activeApplied) do
                            table.insert(targetsToRemove, pl)
                        end
                        for _, pl in ipairs(targetsToRemove) do
                            restorePartForPlayer(pl)
                        end
                        safeNotify({
                            Title = "SilentAim (HB)",
                            Content = "Disabled (Hotkey)",
                            Audio = "rbxassetid://17208361335",
                            Length = 1,
                            Image = "rbxassetid://4483362458",
                            BarColor = Color3.fromRGB(255, 0, 0)
                        })
                    else
                        if gui.RingHolder then gui.RingHolder.Visible = true end
                        lrfd()
                        safeNotify({
                            Title = "SilentAim (HB)",
                            Content = "Enabled (Hotkey)",
                            Audio = "rbxassetid://17208361335",
                            Length = 1,
                            Image = "rbxassetid://4483362458",
                            BarColor = Color3.fromRGB(255, 100, 0)
                        })
                    end
                elseif kc == Enum.KeyCode.R then
                    config.SA2_Enabled = not config.SA2_Enabled
                    safeNotify({
                        Title = "SilentAim (HK)",
                        Content = config.SA2_Enabled and "Enabled (Hotkey)" or "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://4483362458",
                        BarColor = config.SA2_Enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                    })
                elseif kc == Enum.KeyCode.T then
                    config.SA2_Wallcheck = not config.SA2_Wallcheck
                    safeNotify({
                        Title = "SilentAim (HK) Wall Check",
                        Content = config.SA2_Wallcheck and "Enabled (Hotkey)" or "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://4483362458",
                        BarColor = config.SA2_Wallcheck and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 0, 0)
                    })
                elseif kc == Enum.KeyCode.Q then
                    handleAimbotToggle(not config.aimbotEnabled)
                    safeNotify({
                        Title = "Aimbot",
                        Content = config.aimbotEnabled and "Enabled (Hotkey)" or "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://4483362458",
                        BarColor = config.aimbotEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                    })
                elseif kc == Enum.KeyCode.H then
                    config.aimbotWallCheck = not config.aimbotWallCheck
                    safeNotify({
                        Title = "Aimbot Wall Check",
                        Content = config.aimbotWallCheck and "Enabled (Hotkey)" or "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://4483362458",
                        BarColor = config.aimbotWallCheck and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 0, 0)
                    })
                elseif kc == Enum.KeyCode.G then
                    config.hitboxEnabled = not config.hitboxEnabled
                    if config.hitboxEnabled then
                        applyhb()
                        safeNotify({
                            Title = "Hitbox",
                            Content = "Enabled (Hotkey)",
                            Audio = "rbxassetid://17208361335",
                            Length = 1,
                            Image = "rbxassetid://4483362458",
                            BarColor = Color3.fromRGB(0, 255, 0)
                        })
                    else
                        local targetsToRemove = {}
                        for player, _ in pairs(config.hitboxExpandedParts) do
                            table.insert(targetsToRemove, player)
                        end
                        for _, player in ipairs(targetsToRemove) do
                            restoreTorso(player)
                        end
                        safeNotify({
                            Title = "Hitbox",
                            Content = "Disabled (Hotkey)",
                            Audio = "rbxassetid://17208361335",
                            Length = 1,
                            Image = "rbxassetid://4483362458",
                            BarColor = Color3.fromRGB(255, 0, 0)
                        })
                    end
                elseif kc == Enum.KeyCode.V then
                    config.clientMasterEnabled = not config.clientMasterEnabled
                    applyClientMaster(config.clientMasterEnabled)
                    safeNotify({
                        Title = "Client Config",
                        Content = config.clientMasterEnabled and "Enabled (Hotkey)" or "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://4483362458",
                        BarColor = config.clientMasterEnabled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 0, 0)
                    })
                elseif kc == Enum.KeyCode.L then
                    config.antiAimEnabled = not config.antiAimEnabled
                    if not config.antiAimEnabled then
                        returnToOriginalPosition()
                    end
                    safeNotify({
                        Title = "AntiAim",
                        Content = config.antiAimEnabled and "Enabled (Hotkey)" or "Disabled (Hotkey)",
                        Audio = "rbxassetid://17208361335",
                        Length = 1,
                        Image = "rbxassetid://4483362458",
                        BarColor = config.antiAimEnabled and Color3.fromRGB(255, 100, 0) or Color3.fromRGB(255, 0, 0)
                    })
                end
            end
        end
    end)
end
local function cleanup()
    pcall(function()
        RunService:UnbindFromRenderStep("FOVhbUpdater_Modern")
    end)
    
    if config.nextGenRepEnabled then
        setfflag("NextGenReplicatorEnabledWrite4", "false")
        config.nextGenRepEnabled = false
        config.nextGenRepDesiredState = false
    end
    
    stopAutoFarm()
    KillQT()
    if config.hotkeyConnection then
        pcall(function() config.hotkeyConnection:Disconnect() end)
        config.hotkeyConnection = nil
    end
    if desyncHook then
        pcall(function()
        end)
    end
    aimbot360LoopRunning = false
    if aimbot360LoopTask then
        aimbot360LoopTask = nil
    end
    if config.aimbot360Enabled then
        toggle360Aimbot(false)
    end

    local targetsToRemove = {}
    for pl, _ in pairs(config.espData) do
        table.insert(targetsToRemove, pl)
    end
    for _, pl in ipairs(targetsToRemove) do
        removeESPLabel(pl)
    end

    local targetsToRemoveHigh = {}
    for pl, _ in pairs(config.highlightData) do
        table.insert(targetsToRemoveHigh, pl)
    end
    for _, pl in ipairs(targetsToRemoveHigh) do
        removeHighlightESP(pl)
    end
    
    for pl, _ in pairs(config.lineESPData) do
        removeLineESP(pl)
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

    if gui.mobileGui and gui.mobileGui.ScreenGui then
        gui.mobileGui.ScreenGui:Destroy()
    end

    config.desyncEnabled = false
    config.desyncToggleEnabled = false
    config.customDesyncEnabled = false
    config.desyncLoc = CFrame.new()
    config.activeApplied = {}
    config.originalSizes = {}
    config.espData = {}
    config.highlightData = {}
    config.lineESPData = {}
    config.targethbSizes = {}
    config.playerConnections = {}
    config.characterConnections = {}
    config.centerLocked = {}
    config.currentAntiAimTarget = nil
    config.hitboxExpandedParts = {}
    config.hitboxOriginalSizes = {}
    config.holdkeyStates = {}
    config.holdkeyToggle.enabled = false
    config.nextGenRepEnabled = false
    config.nextGenRepDesiredState = false
    restoreClientValues()
end

task.spawn(function()
    while patcher do
        UpdateQT()
        d()
        espRefresher()
        applyhb()
        aimbotfov()
        updateAimbotFOVRing()
        if config.nextGenRepDesiredState then
            if config.antiAimEnabled then
                if not config.nextGenRepEnabled then
                    pcall(function()
                        setfflag("NextGenReplicatorEnabledWrite4", "false")
                        task.wait(0.1)
                        setfflag("NextGenReplicatorEnabledWrite4", "true")
                        config.nextGenRepEnabled = true
                    end)
                else
                    pcall(function()
                        setfflag("NextGenReplicatorEnabledWrite4", "true")
                    end)
                end
            else
                if config.nextGenRepEnabled then
                    setfflag("NextGenReplicatorEnabledWrite4", "false")
                    config.nextGenRepEnabled = false
                end
            end
        else
            if config.nextGenRepEnabled then
                setfflag("NextGenReplicatorEnabledWrite4", "false")
                config.nextGenRepEnabled = false
            end
        end
        
        local toRemove = {}
        for player, data in pairs(config.hitboxExpandedParts) do
            if not player or not getTargetCharacter(player) or not plralive(player) then
                table.insert(toRemove, player)
            elseif not targethb(player) then
                table.insert(toRemove, player)
            end
        end
        
        for _, player in ipairs(toRemove) do
            restoreTorso(player)
        end
        
        local lineToRemove = {}
        for player, _ in pairs(config.lineESPData) do
            local found = false
            for _, target in ipairs(getAllTargets()) do
                if target == player then
                    found = true
                    break
                end
            end
            if not found then
                table.insert(lineToRemove, player)
            end
        end
        
        for _, player in ipairs(lineToRemove) do
            removeLineESP(player)
        end
        task.wait(patcherwait)
    end
end)


init()

return config
-- fin

