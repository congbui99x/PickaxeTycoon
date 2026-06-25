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
local guiParent = pcall(function() return gethui() end) and gethui() or CoreGui

if guiParent:FindFirstChild(UI_Name) then
    guiParent[UI_Name]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = UI_Name
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = guiParent

-- Khung chính
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
UIStroke.Color = Color3.fromRGB(80, 50, 150) -- Viền tím Anime VIP
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Thanh tiêu đề
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar
local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 10)
TopBarFix.Position = UDim2.new(0, 0, 1, -10)
TopBarFix.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "💎 CÔNG BÙI VIP | ANIME WARRIORS III"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.Parent = TopBar

-- 3 Nút MacOS
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

-- Logo thu gọn
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
local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(80, 50, 150)
LogoStroke.Thickness = 2
LogoStroke.Parent = LogoBtn

-- Logic 3 Nút
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
    LogoBtn.Position = UDim2.new(0, MainFrame.AbsolutePosition.X, 0, MainFrame.AbsolutePosition.Y)
end)
LogoBtn.MouseButton1Click:Connect(function()
    LogoBtn.Visible = false
    MainFrame.Position = UDim2.new(0, LogoBtn.AbsolutePosition.X, 0, LogoBtn.AbsolutePosition.Y)
    MainFrame.Visible = true
end)

-- Vùng chứa tính năng
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

-- Nút Gạt Toggles
local Config = {
    AutoFarm = false,
    KillAura = false,
    AutoSummon = false,
    GodMode = false
}

local function CreateToggle(name, text, configKey)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Frame.Parent = ContentContainer
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 8)
    FCorner.Parent = Frame
    
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
    local BgCorner = Instance.new("UICorner")
    BgCorner.CornerRadius = UDim.new(1, 0)
    BgCorner.Parent = ToggleBg
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 20, 0, 20)
    Knob.Position = UDim2.new(0, 2, 0.5, -10)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = ToggleBg
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    ToggleBg.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        if Config[configKey] then
            ToggleBg.BackgroundColor3 = Color3.fromRGB(138, 43, 226) -- Tím khi bật
            Knob:TweenPosition(UDim2.new(1, -22, 0.5, -10), "Out", "Quad", 0.2, true)
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            ToggleBg.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
            Knob:TweenPosition(UDim2.new(0, 2, 0.5, -10), "Out", "Quad", 0.2, true)
            Label.TextColor3 = Color3.fromRGB(220, 220, 220)
        end
    end)
end

CreateToggle("T1", "⚔️ Auto Farm (Di chuyển tới quái)", "AutoFarm")
CreateToggle("T2", "💥 Kill Aura (Đánh lan xung quanh)", "KillAura")
CreateToggle("T3", "🎲 Auto Summon (Spam Gacha)", "AutoSummon")
CreateToggle("T4", "🚀 Flash Movement (Tốc độ x3)", "GodMode")

ContentContainer.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)

-- 2. HỆ THỐNG LOGIC HACK (Bypass Anti-Cheat)

-- Chống kick AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Lọc cổng tấn công & gacha
local attackRemotes = {}
local summonRemotes = {}
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local name = string.lower(v.Name)
        if string.find(name, "attack") or string.find(name, "combat") or string.find(name, "damage") or string.find(name, "hit") or string.find(name, "skill") then
            table.insert(attackRemotes, v)
        end
        if string.find(name, "summon") or string.find(name, "roll") or string.find(name, "spin") then
            table.insert(summonRemotes, v)
        end
    end
end

-- Tìm quái vật gần nhất
local function getClosestMob()
    local closestMob = nil
    local shortestDistance = math.huge
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local hrp = char.HumanoidRootPart

    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= char and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 and obj:FindFirstChild("HumanoidRootPart") then
            -- Loại bỏ player khác
            if not Players:GetPlayerFromCharacter(obj) then
                local distance = (hrp.Position - obj.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestMob = obj
                end
            end
        end
    end
    return closestMob
end

-- Vòng lặp chính
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local hum = char:FindFirstChild("Humanoid")

    -- Auto Farm Mobs
    if Config.AutoFarm then
        local target = getClosestMob()
        if target and target:FindFirstChild("HumanoidRootPart") then
            -- Dịch chuyển ra sau lưng quái 3 studs để né đòn
            hrp.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
            
            -- Tự động chém nếu có công cụ
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end

    -- Kill Aura (Đánh mọi thứ xung quanh)
    if Config.KillAura then
        for _, remote in ipairs(attackRemotes) do
            pcall(function() remote:FireServer() end)
        end
        VirtualUser:ClickButton1(Vector2.new(9999, 9999))
    end

    -- Auto Summon
    if Config.AutoSummon then
        for _, remote in ipairs(summonRemotes) do
            pcall(function() remote:FireServer(1) end) -- Thử mua x1
            pcall(function() remote:FireServer(10) end) -- Thử mua x10
        end
    end

    -- God Mode / Tốc chạy
    if Config.GodMode and hum then
        hum.WalkSpeed = 60
    elseif hum and not Config.GodMode then
        if hum.WalkSpeed > 16 then hum.WalkSpeed = 16 end
    end
end)

print("[NOVA] V20.0 Anime Warriors III Ready!")
