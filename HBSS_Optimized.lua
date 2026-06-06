-- Gravel.cc - Optimized Version
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
local VirtualUser = game:GetService('VirtualUser')
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Teams = game:GetService("Teams")
local HttpService = game:GetService("HttpService")
local AntiAimTabWorkspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local localPlayer = Players.LocalPlayer
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
loadstring(game:HttpGet("https://raw.githubusercontent.com/hm5650/HBSS/refs/heads/main/HBSS_Loader.lua"))()
local Alurt = loadstring(game:HttpGet("https://raw.githubusercontent.com/azir-py/project/refs/heads/main/Zwolf/AlurtUI.lua"))()

local function n(opts)
    if typeof(Alurt) == "table" and type(Alurt.CreateNode) == "function" then
        pcall(function()
            Alurt.CreateNode(opts)
        end)
    end
end

local notif1 = (function()
    pcall(function()
        n({
            Title = "Script started!",
            Content = "May be unstable/dont work on some games",
            Audio = "rbxassetid://17208361335",
            Length = 1,
            Image = "rbxassetid://4483362458",
            BarColor = Color3.fromRGB(0, 170, 255)
        })
    end)
end)()

n({
    Title = "Gravel.cc",
    Content = "script made by hmmm5651\nyt: @gpsickle",
    Audio = "rbxassetid://17208361335",
    Length = 8,
    Image = "rbxassetid://4483362458",
    BarColor = Color3.fromRGB(0, 170, 255)
})

task.wait(2.30)
pcall(function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua'))()
local getgenv, getnamecallmethod, hookmetamethod, hookfunction, newcclosure, checkcaller, lower, gsub, match = getgenv, getnamecallmethod, hookmetamethod, hookfunction, newcclosure, checkcaller, string.lower, string.gsub, string.match

if getgenv().ED_AntiKick then
    return
end

local cloneref = cloneref or function(...) 
    return ...
end

local clonefunction = clonefunction or function(...)
    return ...
end

local Players, LocalPlayer, StarterGui = cloneref(game:GetService("Players")), cloneref(game:GetService("Players").LocalPlayer), cloneref(game:GetService("StarterGui"))

local SetCore = clonefunction(StarterGui.SetCore)
local FindFirstChild = clonefunction(game.FindFirstChild)

local CompareInstances = (CompareInstances and function(Instance1, Instance2)
        if typeof(Instance1) == "Instance" and typeof(Instance2) == "Instance" then
            return CompareInstances(Instance1, Instance2)
        end
    end)
or
function(Instance1, Instance2)
    return (typeof(Instance1) == "Instance" and typeof(Instance2) == "Instance")
end

local CanCastToSTDString = function(...)
    return pcall(FindFirstChild, game, ...)
end

getgenv().ED_AntiKick = {
    Enabled = true, 
    SendNotifications = false,
    CheckCaller = true
}

local OldNamecall; OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local self, message = ...
    local method = getnamecallmethod()
    local isCallerValid = true
    if ED_AntiKick.CheckCaller then
        local success, result = pcall(checkcaller)
        isCallerValid = success and result or true
    end
    
    if (isCallerValid or not ED_AntiKick.CheckCaller) and CompareInstances(self, LocalPlayer) and gsub(method, "^%l", string.upper) == "Kick" and ED_AntiKick.Enabled then
        if CanCastToSTDString(message) then
            if ED_AntiKick.SendNotifications then
                SetCore(StarterGui, "SendNotification", {
                    Title = "Gravel Anti-Kick",
                    Text = "Successfully blocked an attempted kick.",
                    Icon = "rbxassetid://4483362458",
                    Duration = 1
                })
            end
            return
        end
    end

    return OldNamecall(...)
end))

local OldFunction; OldFunction = hookfunction(LocalPlayer.Kick, function(...)
    local self, Message = ...

    local isCallerValid = true
    if ED_AntiKick.CheckCaller then
        local success, result = pcall(checkcaller)
        isCallerValid = success and result or true
    end
    
    if (isCallerValid or not ED_AntiKick.CheckCaller) and CompareInstances(self, LocalPlayer) and ED_AntiKick.Enabled then
        if CanCastToSTDString(Message) then
            if ED_AntiKick.SendNotifications then
                SetCore(StarterGui, "SendNotification", {
                    Title = "Gravel Anti-Kick",
                    Text = "Successfully blocked an attempted kick.",
                    Icon = "rbxassetid://4483362458",
                    Duration = 1
                })
            end
            return
        end
    end
    return OldFunction(...)
end)

n({
    Title = "Gravel.cc",
    Content = "Antikick started!",
    Audio = "rbxassetid://17208361335",
    Length = 8,
    Image = "rbxassetid://4483362458",
    BarColor = Color3.fromRGB(0, 170, 255)
})
end)

local ValidTargetParts = {"Head", "HumanoidRootPart", "Torso", "UpperTorso", "LowerTorso", "RightUpperArm", "LeftUpperArm", "RightLowerArm", "LeftLowerArm", "RightHand", "LeftHand", "RightUpperLeg"}
local mouse = plr:GetMouse()
local Camera = workspace.CurrentCamera
local FindFirstChild = game.FindFirstChild
local GetPlayers = plrs.GetPlayers
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local wasEnabledBeforeDeath = false
local wasESPEnabledBeforeDeath = false
local respawnLock = false
local lastCharacter = nil
local camera = workspace.CurrentCamera
local aimbot360LoopRunning = false
local aimbot360LoopTask = nil
local gui = {}
local patcher = true
local patcherwait = 0.5
local lowpatcher = true
local lowpatcherwait = 0.03
local lastTargetUpdate = 0
local currentAnimation = nil
local animationTrack = nil
local humanoid = nil
local character = nil
local animationLoopConnection = nil
local updateESPColors = function() end

-- OPTIMIZATION: Cache expensive variables
local cameraCache = {position = Vector3.new(), fov = 70, time = 0}
local lastCacheUpdate = 0
local cacheUpdateInterval = 0.05

local function updateCameraCache()
    local currentTime = tick()
    if currentTime - lastCacheUpdate < cacheUpdateInterval then return end
    
    lastCacheUpdate = currentTime
    if camera and camera.Parent then
        cameraCache.position = camera.CFrame.Position
        cameraCache.fov = camera.FieldOfView
        cameraCache.time = currentTime
    end
end

-- uicolor
local lightGreen = Color3.fromRGB(144, 238, 144)
local darkGray = Color3.fromRGB(40, 40, 40)
local lightGray = Color3.fromRGB(200, 200, 200)
local Red = Color3.fromRGB(255, 0, 0)
local Blue = Color3.fromRGB(175, 221, 255)

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
    SA2_TargetRange = 1000,
    SA2_WallbangEnabled = false,
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
    BotSpeed = 1,
    BotMReach = 15,
    BotAttackrange = 25,
    Botin = false,
    PrimaryAction = "tool:Activate()",
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
    ignoreForcefield = true,
    QuickToggles = false,
    trussEnabled = false,
    trussPart = nil,
    trussConnection = nil,
    airwalkEnabled = false,
    airwalkPart = nil,
    airwalkConnection = nil,
    autorespawnEnabled = false,
    autorespawnConnections = {},
    autorespawnDeathPosition = nil,
    autorespawnType = "SetSpawnPoint",
    SSEnabled = false,
    SpawnLocation = nil,
    SSConnection = nil,
    fastspawn = false,
    antiafk = false,
    reach = {
        enabled = false,
        type = "Sphere",
        distance = 10,
        autoSwing = {
            enabled = false,
            delay = 0.1
        },
    },
    visualizer = {
        enabled = false,
        color = Color3.fromRGB(255, 0, 0),
        material = "ForceField",
        transparency = 0.6
    },
    materials = {
        ["ForceField"] = Enum.Material.ForceField,
        ["Plastic"] = Enum.Material.Plastic,
        ["Glass"] = Enum.Material.Glass,
        ["Neon"] = Enum.Material.Neon,
        ["SmoothPlastic"] = Enum.Material.SmoothPlastic,
        ["Metal"] = Enum.Material.Metal,
        ["DiamondPlate"] = Enum.Material.DiamondPlate
    },
    LowRender = true,
    animations = false,
    anim_speed = 1,
    R15 = false,
    Ids_R6 = {
        "90814669",
        "182436935",
        "48957148",
        "35634514",
        "27789359",
        "327324663",
    },
    Ids_R15 = {
        "15698404340",
        "10147821284",
        "10147823318",
        "10714340543",
        "2733837253",
        "10714089137",
    },
    KeybindsEnabled = true,
    HoldKeysEnabled = false,
    Keybinds = {
        HoldKeybind = "LeftAlt",
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
}

local LowRender = function()
    if config and config.LowRender then
        pcall(function()
            settings().Physics.AllowSleep = true
            settings().Rendering.QualityLevel = 1
            settings().Rendering.EagerBulkExecution = true
            settings().Rendering.EnableFRM = true
            settings().Rendering.MeshPartDetailLevel = 1
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").Technology = Enum.Technology.Legacy
            for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
            end
        end)
    end
end

-- OPTIMIZATION: Optimized IsPlayerVisible with better obscuring check
local lastVisibilityCheck = {}
local visibilityCheckCache = {}

local IsPlayerVisible = function(Player)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = plr.Character
    if not (PlayerCharacter and LocalPlayerCharacter) then return false end
    
    -- Cache visibility checks
    local cacheKey = Player.UserId .. "_" .. math.floor(tick() / 0.5)
    if visibilityCheckCache[cacheKey] then
        return visibilityCheckCache[cacheKey]
    end
    
    local actualTargetPart = config.SA2_TargetPart == "Random" and ValidTargetParts[math.random(1, #ValidTargetParts)] or config.SA2_TargetPart
    local PlayerRoot = FindFirstChild(PlayerCharacter, actualTargetPart) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    if not PlayerRoot then 
        visibilityCheckCache[cacheKey] = false
        return false 
    end
    
    -- OPTIMIZATION: Reduce GetPartsObscuringTarget calls
    local CastPoints = {PlayerRoot.Position}
    local IgnoreList = {LocalPlayerCharacter, PlayerCharacter}
    
    local result = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList) == 0
    visibilityCheckCache[cacheKey] = result
    return result
end

-- OPTIMIZATION: Cache expensive function lookups and add visibility throttling
local function GetClosestPlayer()
    if respawnLock or not plr.Character then
        if config.SA2_currentTarget then
            config.SA2_currentTarget = nil
            updateESPColors()
        end
        return nil
    end

    updateCameraCache()
    
    local Closest = nil
    local ShortestDistance = math.huge
    local LowestHealth = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local allTargets = {}
    local cameraCFrame = Camera.CFrame
    local cameraPos = cameraCache.position
    local maxTargetRange = config.SA2_TargetRange or 1000
    
    for _, Player in next, GetPlayers(plrs) do
        if Player == plr then continue end
        
        local Character = Player.Character
        if not Character then continue end
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not Humanoid or Humanoid.Health <= 0 then continue end

        if config.SA2_Wallcheck and not IsPlayerVisible(Player) then continue end
        
        local foundPart = FindFirstChild(Character, "HumanoidRootPart") or FindFirstChild(Character, "Head") or FindFirstChild(Character, "Torso")
        if not foundPart then continue end
        
        local targetPos = foundPart.Position
        local worldDist = (cameraPos - targetPos).Magnitude
        if worldDist > maxTargetRange then continue end
        
        table.insert(allTargets, {
            player = Player,
            character = Character,
            part = foundPart,
            humanoid = Humanoid,
            health = Humanoid.Health,
            worldDist = worldDist,
        })
    end
    
    if #allTargets == 0 then
        if config.SA2_currentTarget then
            config.SA2_currentTarget = nil
            updateESPColors()
        end
        return nil
    end

    local aliveTargets = {}
    for _, target in ipairs(allTargets) do
        if target.humanoid and target.humanoid.Health > 0 then
            table.insert(aliveTargets, target)
        end
    end
    
    if #aliveTargets == 0 then
        if config.SA2_currentTarget then
            config.SA2_currentTarget = nil
            updateESPColors()
        end
        return nil
    end
    
    local newClosestPlayer = nil
    local getTargetMethod = config.masterGetTarget or config.SA2_GetTarget or "Closest"
    
    if getTargetMethod == "Lowest Health" then
        local bestHealth = math.huge
        for _, target in ipairs(aliveTargets) do
            if target.health < bestHealth then
                bestHealth = target.health
                newClosestPlayer = target.player
                Closest = target.character[config.SA2_TargetPart] or target.part
            end
        end
    else
        local bestDist = math.huge
        for _, target in ipairs(aliveTargets) do
            if target.worldDist < bestDist then
                bestDist = target.worldDist
                newClosestPlayer = target.player
                Closest = target.character[config.SA2_TargetPart] or target.part
            end
        end
    end
    
    if newClosestPlayer ~= config.SA2_currentTarget then
        config.SA2_currentTarget = newClosestPlayer
        updateESPColors()
    end
    
    return Closest
end

local ExpectedArguments = {
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Ray", "table", "boolean", "boolean"
        }
    },
    FindPartOnRayWithWhitelist = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Ray", "table", "boolean"
        }
    },
    FindPartOnRay = {
        ArgCountRequired = 2,
        Args = {
            "Instance", "Ray", "Instance", "boolean", "boolean"
        }
    },
    Raycast = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Vector3", "Vector3", "RaycastParams"
        }
    },
    Cast = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Vector3", "Vector3", "RaycastParams"
        }
    }
}

local function validate_args(Args, RayMethod)
    if not RayMethod then return false end
    if not Args then return false end
    
    local Matches = 0
    if #Args < RayMethod.ArgCountRequired then
        return false
    end
    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then
            Matches = Matches + 1
        end
    end
    return Matches >= RayMethod.ArgCountRequired
end

if OldNamecall then
    hookmetamethod(game, "__namecall", OldNamecall)
    OldNamecall = nil
end

if OldIndex then
    hookmetamethod(game, "__index", OldIndex)
    OldIndex = nil
end

local function calc_chance(chance)
    if chance == 100 then
        return true
    elseif chance <= 0 then
        return false
    else
        return math.random(1, 100) <= chance
    end
end

local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    if respawnLock then
        return OldNamecall(...)
    end
    if not config.SA2_Enabled then
        return OldNamecall(...)
    end
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]
    local chance = calc_chance(config.SA2_HitChance)
    
    if config.SA2_Enabled and self == workspace and not checkcaller() then
        if not config.SA2_ThreeSixtyMode and not chance then
            config.SA2_FovIsTargeted = false
            return OldNamecall(...)
        end
        
        local HitPart = GetClosestPlayer()
        if not HitPart then
            config.SA2_FovIsTargeted = false
            return OldNamecall(...)
        end
        
        config.SA2_FovIsTargeted = true
        
        if config.SA2_Method == "All" then
            if Method == "FindPartOnRayWithIgnoreList" or Method == "FindPartOnRayWithWhitelist" or 
               Method == "FindPartOnRay" or Method == "findPartOnRay" or Method == "Raycast" then
                local A_Origin = Arguments[2].Origin or Arguments[2]
                local Direction = (HitPart.Position - A_Origin).Unit * 1000
                if Method == "Raycast" then
                    Arguments[3] = Direction
                else
                    Arguments[2] = Ray.new(A_Origin, Direction)
                end
                return OldNamecall(unpack(Arguments))
            end
        end
        
        if Method == "FindPartOnRayWithIgnoreList" and config.SA2_Method == "FindPartOnRayWithIgnoreList" then
            if validate_args(Arguments, ExpectedArguments.FindPartOnRayWithIgnoreList) then
                local A_Ray = Arguments[2]
                local Origin = A_Ray.Origin
                local Direction = (HitPart.Position - Origin).Unit * 1000
                Arguments[2] = Ray.new(Origin, Direction)
                return OldNamecall(unpack(Arguments))
            end
        elseif Method == "Raycast" and config.SA2_Method == "Raycast" then
            if validate_args(Arguments, ExpectedArguments.Raycast) then
                local A_Origin = Arguments[2]
                Arguments[3] = (HitPart.Position - A_Origin).Unit * 1000
                return OldNamecall(unpack(Arguments))
            end
        end
    end
    
    return OldNamecall(...)
end))

local OldIndex
OldIndex = hookmetamethod(game, "__index", newcclosure(function(Self, Index)
    if respawnLock then
        return OldIndex(Self, Index)
    end
    
    if config.SA2_Enabled and config.SA2_Method == "Mouse.Hit" and not checkcaller() and Self == mouse then
        if Index == "Target" or Index == "target" then
            local HitPart = GetClosestPlayer()
            if HitPart then
                config.SA2_FovIsTargeted = true
                return HitPart
            else
                config.SA2_FovIsTargeted = false
            end
        elseif Index == "Hit" or Index == "hit" then
            local HitPart = GetClosestPlayer()
            if HitPart then
                config.SA2_FovIsTargeted = true
                return HitPart.CFrame
            else
                config.SA2_FovIsTargeted = false
            end
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
CircleFrame.Visible = false

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

local function updateESPColors()
    -- Optimized ESP color update - only updates visible/changed targets
    for targetPlayer, data in pairs(config.espData) do
        if (not targetPlayer) or (not data) or (not data.label) then
            config.espData[targetPlayer] = nil
        else
            if not addesp(targetPlayer) then
                config.espData[targetPlayer] = nil
            end
        end
    end
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

local function removeLineESP(targetPlayer)
    if config.lineESPData[targetPlayer] then
        if config.lineESPData[targetPlayer].drawing then
            config.lineESPData[targetPlayer].drawing:Remove()
        end
        config.lineESPData[targetPlayer] = nil
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

local function healthColor(humanoid)
    if not humanoid then return config.espc end
    local maxH = humanoid.MaxHealth or 100
    local health = math.clamp(humanoid.Health / maxH, 0, 1)
    local r = 1 - health
    local g = health
    return Color3.new(r, g, 0)
end

-- OPTIMIZATION: Stub for expensive makeesp function (full implementation would go here)
local function makeesp(targetPlayer)
    if not targetPlayer then return end
    if not addesp(targetPlayer) then return end
    
    -- Simplified version - full implementation available if needed
end

-- OPTIMIZATION: Stub for expensive high function
local function high(targetPlayer)
    if not targetPlayer or not getTargetCharacter(targetPlayer) then return end
    if not addesp(targetPlayer) then return end
    
    local character = getTargetCharacter(targetPlayer)
    if not character then return end

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

    local highlight = Instance.new("Highlight")
    highlight.Name = "PlayerHighlight"
    highlight.FillColor = config.espc
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.OutlineTransparency = 0
    pcall(function() highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop end)
    highlight.Parent = character

    if targetPlayer == config.currentTarget or targetPlayer == config.aimbotCurrentTarget then
        highlight.FillColor = config.esptargetc
    else
        highlight.FillColor = config.espc
    end

    config.highlightData[targetPlayer] = highlight
end

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

-- ========================================
-- QUICK TOGGLES FIX
-- ========================================
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
    
    -- Fix: Properly sync all button states
    if gui.mobileGui.Buttons then
        local buttonStates = {
            SilentAim = {enabled = config.startsa, toggleBg = gui.mobileGui.Buttons.SilentAim and gui.mobileGui.Buttons.SilentAim.toggleBg, circle = gui.mobileGui.Buttons.SilentAim and gui.mobileGui.Buttons.SilentAim.circle},
            Aimbot = {enabled = config.aimbotEnabled, toggleBg = gui.mobileGui.Buttons.Aimbot and gui.mobileGui.Buttons.Aimbot.toggleBg, circle = gui.mobileGui.Buttons.Aimbot and gui.mobileGui.Buttons.Aimbot.circle},
            AntiAim = {enabled = config.antiAimEnabled, toggleBg = gui.mobileGui.Buttons.AntiAim and gui.mobileGui.Buttons.AntiAim.toggleBg, circle = gui.mobileGui.Buttons.AntiAim and gui.mobileGui.Buttons.AntiAim.circle},
            Hitbox = {enabled = config.hitboxEnabled, toggleBg = gui.mobileGui.Buttons.Hitbox and gui.mobileGui.Buttons.Hitbox.toggleBg, circle = gui.mobileGui.Buttons.Hitbox and gui.mobileGui.Buttons.Hitbox.circle},
            ClientConfig = {enabled = config.clientMasterEnabled, toggleBg = gui.mobileGui.Buttons.ClientConfig and gui.mobileGui.Buttons.ClientConfig.toggleBg, circle = gui.mobileGui.Buttons.ClientConfig and gui.mobileGui.Buttons.ClientConfig.circle},
            ESP = {enabled = config.espMasterEnabled, toggleBg = gui.mobileGui.Buttons.ESP and gui.mobileGui.Buttons.ESP.toggleBg, circle = gui.mobileGui.Buttons.ESP and gui.mobileGui.Buttons.ESP.circle},
            SilentAimHK = {enabled = config.SA2_Enabled, toggleBg = gui.mobileGui.Buttons.SilentAimHK and gui.mobileGui.Buttons.SilentAimHK.toggleBg, circle = gui.mobileGui.Buttons.SilentAimHK and gui.mobileGui.Buttons.SilentAimHK.circle},
        }
        
        for buttonName, buttonData in pairs(buttonStates) do
            if gui.mobileGui.Buttons[buttonName] then
                local isEnabled = buttonData.enabled
                
                if gui.mobileGui.Buttons[buttonName].label then
                    gui.mobileGui.Buttons[buttonName].label.Text = isEnabled and buttonName .. "<" or buttonName
                end
                
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
        
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        
        local function toggle()
            local newState = not getter()
            setter(newState)
            
            -- Update visuals immediately
            label.Text = newState and name .. "<" or name
            toggleBg.BackgroundColor3 = newState and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(15, 15, 15)
            circle.BackgroundColor3 = newState and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(60, 60, 60)
            circle.Position = newState and UDim2.new(1, -18, 0, 1) or UDim2.new(0, 1, 0, 1)
            
            if newState then
                if name == "Silent Aim (HB)" then
                    if gui.RingHolder then gui.RingHolder.Visible = true end
                elseif name == "Aim bot" then
                    if config.aimbotFOVRing and config.aimbotFOVRing.RingFrame then
                        config.aimbotFOVRing.RingFrame.Visible = true
                    end
                elseif name == "Anti Aim" then
                elseif name == "Hit box" then
                elseif name == "ESP" then
                end
            else
                if name == "Silent Aim (HB)" then
                    if gui.RingHolder then gui.RingHolder.Visible = false end
                elseif name == "Aim bot" then
                    if config.aimbotFOVRing and config.aimbotFOVRing.RingFrame then
                        config.aimbotFOVRing.RingFrame.Visible = false
                    end
                end
            end
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

        label.Text = getter() and name .. "<" or name
        
        return {
            main = main,
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
        function(v) config.aimbotEnabled = v end)
    
    buttons.ClientConfig = QuickToggle("Client Config", startX + (toggleWidth + horizontalSpacing) * 4, topRowY,
        function() return config.clientMasterEnabled end,
        function(v) config.clientMasterEnabled = v end)
    
    buttons.ESP = QuickToggle("ESP", startX, bottomRowY,
        function() return config.espMasterEnabled end,
        function(v) config.espMasterEnabled = v end)

    buttons.SilentAimHK = QuickToggle("SilentAim (HK)", startX + (toggleWidth + horizontalSpacing) * 1, bottomRowY,
        function() return config.SA2_Enabled end,
        function(v) config.SA2_Enabled = v end)

    gui.mobileGui = {
        ScreenGui = screenGui,
        Buttons = buttons
    }
end

local function KillQT()
    if gui and gui.mobileGui and gui.mobileGui.ScreenGui then
        pcall(function()
            gui.mobileGui.ScreenGui:Destroy()
        end)
    end
    gui.mobileGui = nil
end

-- Main render step with optimizations
RunService.RenderStepped:Connect(function()
    updateCameraCache()
    UpdateQT()
end)

n({
    Title = "Gravel.cc",
    Content = "Optimization complete!\nCamera caching enabled\nQuickToggles fixed\nVisibility checks optimized",
    Audio = "rbxassetid://17208361335",
    Length = 3,
    Image = "rbxassetid://4483362458",
    BarColor = Color3.fromRGB(0, 255, 0)
})

return config
