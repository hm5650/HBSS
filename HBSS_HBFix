local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    return
end
local function processCharacter(character)
    if not character or character ~= LocalPlayer.Character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
        local head = character:FindFirstChild("Head")
        
        if rootPart then
            rootPart.CanCollide = false
            rootPart.Massless = true
        end
        
        if torso then
            torso.CanCollide = false
            torso.Massless = true
        end
        
        if head then
            head.CanCollide = false
            head.Massless = true
        end
    end
end
RunService.RenderStepped:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character then
                processCharacter(character)
            end
        end
    end
end)
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- Wait a moment for character to fully load
        task.wait(0.1)
        if player ~= LocalPlayer then
            processCharacter(character)
        end
    end)
end)
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        local character = player.Character
        if character then
            processCharacter(character)
        end
    end
end
