-- NOVA SCRIPTOR V20.0: ANIME WARRIORS III 
-- UI Style: MacOS + Toggle Switches
-- Edition: CÔNG BÙI VIP - Auto Farm & Kill Aura

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")

-- 1. TẠO GIAO DIỆN MACOS STYLE (Chống tàng hình UI)
local UI_Name = "CongBui_AW3_UI"
local guiParent = pcall(function() return gethui() end) and gethui() -- NOVA SCRIPTOR V20.1: ANIME WARRIORS III (FIXED M1 & TELEPORT)
-- UI Style: MacOS + Toggle Switches
-- Edition: CÔNG BÙI VIP - Lock Target Combat

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")

-- 1. TẠO GIAO DIỆN MACOS STYLE
local UI_Name = "CongBui_AW3_UI"
local guiParent = pcall(function() return gethui() end) and gethui() or CoreGui

if guiParent:FindFirstChild(UI_Name) then
    guiParent[UI_Name]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = UI_Name
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = guiParent

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 420)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 50, 150) 
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "💎 CÔNG BÙI VIP | AW3 FIXED"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.Parent = TopBar

local function createDot(color, posX, name)
    local dot = Instance.new("TextButton")
    dot.Name = name
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = UDim2.new(0, posX, 0.5, -7)
    dot.BackgroundColor3 = color
    dot.Text = ""
    dot.Parent = TopBar
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    return dot
end

local RedBtn = createDot(Color3.fromRGB(255, 95, 86), 15, "Red_Close")
local YellowBtn = createDot(Color3.fromRGB(255, 189, 46), 35, "Yellow_Logo")
local GreenBtn = createDot(Color3.fromRGB(39, 201, 63), 55, "Green_Min")

local LogoBtn = Instance.new("ImageButton")
LogoBtn.Size = UDim2.new(0, 50, 0, 50)
LogoBtn.Position = UDim2.new(0.5, -25, 0.5, -25)
LogoBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LogoBtn.Image = "rbxassetid://10886071850"
LogoBtn.Visible = false
LogoBtn.Draggable = true
LogoBtn.Parent = ScreenGui
local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(1, 0)
LogoCorner.Parent = LogoBtn

local isMinimized = false
RedBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
GreenBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 360, 0, 40), "Out", "Quad", 0.3, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 360, 0, 420), "Out", "Quad", 0.3, true)
    end
end)
YellowBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    LogoBtn.Visible = true
end)
LogoBtn.MouseButton1Click:Connect(function()
    LogoBtn.Visible = false
    MainFrame.Visible = true
end)

local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, -20, 1, -55)
ContentContainer.Position = UDim2.new(0, 10, 0, 45)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ScrollBarThickness = 3
ContentContainer.Parent = MainFrame
-- NOVA SCRIPTOR V20.1: ANIME WARRIORS III (FIXED M1 & TELEPORT)
-- UI Style: MacOS + Toggle Switches
-- Edition: CÔNG BÙI VIP - Lock Target Combat

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")

-- 1. TẠO GIAO DIỆN MACOS STYLE
local UI_Name = "CongBui_AW3_UI"
local guiParent = pcall(function() return gethui() end) and gethui() or CoreGui

if guiParent:FindFirstChild(UI_Name) then
    guiParent[UI_Name]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = UI_Name
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = guiParent

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 420)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 50, 150) 
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "💎 CÔNG BÙI VIP | AW3 FIXED"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.Parent = TopBar

local function createDot(color, posX, name)
    local dot = Instance.new("TextButton")
    dot.Name = name
    dot.Size = UDim2.new(0, 14, 0, 14)
    dot.Position = UDim2.new(0, posX, 0.5, -7)
    dot.BackgroundColor3 = color
    dot.Text = ""
    dot.Parent = TopBar
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    return dot
end

local RedBtn = createDot(Color3.fromRGB(255, 95, 86), 15, "Red_Close")
local YellowBtn = createDot(Color3.fromRGB(255, 189, 46), 35, "Yellow_Logo")
local GreenBtn = createDot(Color3.fromRGB(39, 201, 63), 55, "Green_Min")

local LogoBtn = Instance.new("ImageButton")
LogoBtn.Size = UDim2.new(0, 50, 0, 50)
LogoBtn.Position = UDim2.new(0.5, -25, 0.5, -25)
LogoBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LogoBtn.Image = "rbxassetid://10886071850"
LogoBtn.Visible = false
LogoBtn.Draggable = true
LogoBtn.Parent = ScreenGui
local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(1, 0)
LogoCorner.Parent = LogoBtn

local isMinimized = false
RedBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
GreenBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 360, 0, 40), "Out", "Quad", 0.3, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 360, 0, 420), "Out", "Quad", 0.3, true)
    end
end)
YellowBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    LogoBtn.Visible = true
end)
LogoBtn.MouseButton1Click:Connect(function()
    LogoBtn.Visible = false
    MainFrame.Visible = true
end)

local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, -20, 1, -55)
ContentContainer.Position = UDim2.new(0, 10, 0, 45)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ScrollBarThickness = 3
ContentContainer.Parent = MainFrame
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = ContentContainer

local Config = { AutoFarm = false, KillAura = false, GodMode = false }

local function CreateToggle(name, text, configKey)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Frame.Parent = ContentContainer
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local ToggleBg = Instance.new("TextButton")
    ToggleBg.Size = UDim2.new(0, 46, 0, 24)
    ToggleBg.Position = UDim2.new(1, -60, 0.5, -12)
    ToggleBg.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    ToggleBg.Text = ""
    ToggleBg.Parent = Frame
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 20, 0, 20)
    Knob.Position = UDim2.new(0, 2, 0.5, -10)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = ToggleBg

    ToggleBg.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        if Config[configKey] then
            ToggleBg.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
            Knob:TweenPosition(UDim2.new(1, -22, 0.5, -10), "Out", "Quad", 0.2, true)
        else
            ToggleBg.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
            Knob:TweenPosition(UDim2.new(0, 2, 0.5, -10), "Out", "Quad", 0.2, true)
        end
    end)
end

CreateToggle("T1", "⚔️ M1 Auto Farm (Sửa lỗi kẹt)", "AutoFarm")
CreateToggle("T2", "💥 Kill Aura (Spam Skill)", "KillAura")
CreateToggle("T3", "🚀 God Mode (WalkSpeed)", "GodMode")

-- 2. LOGIC HACK (FIXED M1 & AIM)
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

local function getClosestMob()
    local closestMob = nil
    local shortestDistance = math.huge
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            local hum = obj.Humanoid
            -- Kiểm tra đúng là quái (Máu > 0 và không phải là NPC bất tử)
            if hum.Health > 0 and hum.MaxHealth > 10 and not Players:GetPlayerFromCharacter(obj) then
                local distance = (char.HumanoidRootPart.Position - obj.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestMob = obj
                end
            end
        end
    end
    return closestMob
end

-- Dùng Heartbeat thay vì RenderStepped để mượt vật lý hơn
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    if Config.AutoFarm then
        local target = getClosestMob()
        if target and target:FindFirstChild("HumanoidRootPart") then
            local targetPos = target.HumanoidRootPart.Position
            
            -- FIX: Teleport ra đằng trước mặt quái (đứng trên không xíu để né đòn) và HƯỚNG MẶT VÀO NÓ
            hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 3), targetPos)
            
            -- FIX: Ép đánh bằng cách giả lập click chuột trái liên tục (M1 Combat)
            VirtualUser:ClickButton1(Vector2.new(9999, 9999))
        end
    end

    if Config.GodMode then
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = 60 end
    end
end)

print("[NOVA] V20.1 - FIXED M1 AUTO FARM LOADED!")
