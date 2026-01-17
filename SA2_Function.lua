local plrs = game:GetService("Players")
local lplr = plrs.LocalPlayer
local Camera = workspace.CurrentCamera
local WorldToScreen = Camera.WorldToScreenPoint
local GetPlayers = plrs.GetPlayers
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local mouse = lplr:GetMouse()
local UserInputService = game:GetService("UserInputService")
local GetMouseLocation = UserInputService.GetMouseLocation

-- Replace the loaded functions with a version that doesn't use WorldToScreen
local func = {
    GetScreenPosition = function(Vector)
        -- Return nil for screen position since we're not using it
        return nil, false
    end,
    
    IsTool = function(Tool)
        return Tool:IsA("Tool")
    end,
    
    IsAlive = function(Plr)
        return Plr.Character and Plr.Character:FindFirstChild("Humanoid") and Plr.Character.Humanoid.Health > 0
    end,
    
    TeamCheck = function(Plr)
        return Plr.Team ~= lplr.Team
    end,
    
    GetMousePosition = function()
        return GetMouseLocation(UserInputService)
    end,
    
    GetGun = function(Plr)
        local Character = lplr.Character
        if not Character then return end
        for _,v in ipairs(Character:GetChildren()) do
            if functions.IsTool(v) then
                return v
            end
        end
    end,
    
    HitChance = function(Percentage)
        Percentage = math.floor(Percentage)
        local chance = math.floor(Random.new().NextNumber(Random.new(),0,1) * 100) / 100
        return chance <= Percentage / 100
    end,
    
    Direction = function(Origin, Pos)
        return (Pos - Origin).Unit * 1000
    end
}
