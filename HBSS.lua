local TweenService = game:GetService("TweenService")
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "option"
ScreenGui.Parent = game:GetService("CoreGui")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 1
MainFrame.Parent = ScreenGui
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "Do you want to load the legacy?"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.Code
Title.TextSize = 18
Title.TextTransparency = 1
Title.Parent = MainFrame

local function createOption(name, iconId, pos, text)
    local Container = Instance.new("Frame")
    local Icon = Instance.new("ImageLabel")
    local Button = Instance.new("TextButton")
    local BtnCorner = Instance.new("UICorner")

    Container.Size = UDim2.new(0, 150, 0, 150)
    Container.Position = pos
    Container.BackgroundTransparency = 1
    Container.Parent = MainFrame
    Icon.Size = UDim2.new(0, 60, 0, 60)
    Icon.Position = UDim2.new(0.5, -30, 0.1, 0)
    Icon.Image = iconId
    Icon.BackgroundTransparency = 1
    Icon.ImageTransparency = 1
    Icon.Parent = Container
    Button.Size = UDim2.new(0, 120, 0, 40)
    Button.Position = UDim2.new(0.5, -60, 0.6, 0)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Text = text
    Button.Font = Enum.Font.Code
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 16
    Button.AutoButtonColor = true
    Button.TextTransparency = 1
    Button.BackgroundTransparency = 1
    Button.Parent = Container
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Button

    return Button, Icon
end

local YesBtn, OldIcon = createOption("Yes", "rbxassetid://132214308111067", UDim2.new(0.05, 0, 0.2, 0), "YES (Old)")
local NoBtn, NewIcon = createOption("No", "rbxassetid://7734056878", UDim2.new(0.55, 0, 0.2, 0), "NO (New)")

local tw = function()
    local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(MainFrame, info, {BackgroundTransparency = 0}):Play()
    task.wait(0.2)
    TweenService:Create(Title, info, {TextTransparency = 0}):Play()
    TweenService:Create(OldIcon, info, {ImageTransparency = 0}):Play()
    TweenService:Create(NewIcon, info, {ImageTransparency = 0}):Play()
    TweenService:Create(YesBtn, info, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
    TweenService:Create(NoBtn, info, {TextTransparency = 0, BackgroundTransparency = 0}):Play()
end

local function get(url)
    local info = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    TweenService:Create(MainFrame, info, {BackgroundTransparency = 1}):Play()
    for _, v in pairs(MainFrame:GetDescendants()) do
        if v:IsA("TextLabel") or v:IsA("TextButton") then
            TweenService:Create(v, info, {TextTransparency = 1, BackgroundTransparency = 1}):Play()
        elseif v:IsA("ImageLabel") then
            TweenService:Create(v, info, {ImageTransparency = 1}):Play()
        end
    end
    task.wait(0.4)
    ScreenGui:Destroy()
    loadstring(game:HttpGet(url))()
end

YesBtn.MouseButton1Click:Connect(function()
    get("https://raw.githubusercontent.com/hm5650/HBSS/refs/heads/main/HBSS_Old.lua")
end)

NoBtn.MouseButton1Click:Connect(function()
    get("https://raw.githubusercontent.com/hm5650/HBSS/refs/heads/main/HBSS_New.lua")
end)

tw()
