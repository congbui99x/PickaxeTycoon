-- NOVA SCRIPTOR V19.0: RNG AXE (Cập nhật 18/6/2026)
-- UI Style: MacOS (Red/Yellow/Green Dots) + Toggle Switches
-- Coder: Máy chơi game siêu hiện đại - Brand: CÔNG BÙI VIP

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")

-- 1. TẠO GIAO DIỆN MACOS STYLE (CHỐNG LỖI HIỂN THỊ IOS)
local UI_Name = "CongBui_AxeRNG_UI"
local guiParent = pcall(function() return gethui() end) and gethui() or CoreGui

if guiParent:FindFirstChild(UI_Name) then
    guiParent[UI_Name]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = UI_Name
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = guiParent

-- Khung chính (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true -- Nắm kéo tẹt ga
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(50, 50, 60)
UIStroke.Thickness = 1
UIStroke.Parent = MainFrame

-- Thanh tiêu đề (Top Bar)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 15)
TopBarCorner.Parent = TopBar

-- Fix viền dưới của TopBar cho nó vuông vắn với MainFrame
local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 10)
TopBarFix.Position = UDim2.new(0, 0, 1, -10)
TopBarFix.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "💎 CÔNG BÙI VIP | AXE RNG"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = TopBar

-- 3 NÚT MACOS (ĐỎ - VÀNG - XANH)
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

-- Logo tròn (Ẩn đi, chỉ hiện khi bấm Vàng)
local LogoBtn = Instance.new("ImageButton")
LogoBtn.Size = UDim2.new(0, 50, 0, 50)
LogoBtn.Position = UDim2.new(0.5, -25, 0.5, -25)
LogoBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
LogoBtn.Image = "rbxassetid://10886071850" -- Icon ngầu
LogoBtn.Visible = false
LogoBtn.Draggable = true
LogoBtn.Parent = ScreenGui

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(1, 0)
LogoCorner.Parent = LogoBtn

-- Vùng chứa chức năng (Scroll)
local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, -20, 1, -55)
ContentContainer.Position = UDim2.new(0, 10, 0, 45)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ScrollBarThickness = 4
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 400)
ContentContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ContentContainer

-- LOGIC 3 NÚT MACOS
local isMinimized = false
local isLogoMode = false

-- Đỏ: Tắt hẳn
RedBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Xanh lá: Thu gọn thành thanh ngang
GreenBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 350, 0, 40), "Out", "Quad", 0.3, true)
        ContentContainer.Visible = false
    else
        MainFrame:TweenSize(UDim2.new(0, 350, 0, 400), "Out", "Quad", 0.3, true)
        task.wait(0.3)
        ContentContainer.Visible = true
    end
end)

-- Vàng: Thu gọn thành Logo tròn
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


-- 2. HỆ THỐNG NÚT GẠT (TOGGLE SWITCHES) ĐỈNH CAO
local Config = {
    AutoRoll = false,
    AutoChop = false,
    AutoCollect = false,
    GodMode = false,
    FastAttack = false
}

local function CreateToggle(name, text, configKey)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.Parent = ContentContainer
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 8)
    FCorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    -- Nút gạt
    local ToggleBg = Instance.new("TextButton")
    ToggleBg.Size = UDim2.new(0, 45, 0, 22)
    ToggleBg.Position = UDim2.new(1, -55, 0.5, -11)
    ToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    ToggleBg.Text = ""
    ToggleBg.Parent = Frame
    
    local BgCorner = Instance.new("UICorner")
    BgCorner.CornerRadius = UDim.new(1, 0)
    BgCorner.Parent = ToggleBg
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = UDim2.new(0, 2, 0.5, -9)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Parent = ToggleBg
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    ToggleBg.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        if Config[configKey] then
            ToggleBg.BackgroundColor3 = Color3.fromRGB(39, 201, 63) -- Xanh lá bật
            Knob:TweenPosition(UDim2.new(1, -20, 0.5, -9), "Out", "Quad", 0.2, true)
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            ToggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 65) -- Tắt
            Knob:TweenPosition(UDim2.new(0, 2, 0.5, -9), "Out", "Quad", 0.2, true)
            Label.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end)
end

-- THÊM CÁC CHỨC NĂNG
CreateToggle("Toggle1", "🎲 Auto Roll (Quay Rìu)", "AutoRoll")
CreateToggle("Toggle2", "🪓 Auto Chop (Chặt Cây)", "AutoChop")
CreateToggle("Toggle3", "💰 Auto Collect (Hút Gỗ/Mật)", "AutoCollect")
CreateToggle("Toggle4", "⚡ Fast Attack (Chém Siêu Tốc)", "FastAttack")
CreateToggle("Toggle5", "🛡️ God Mode (Tốc độ & Nhảy)", "GodMode")

-- Tự động dãn khung cuộn
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)


-- 3. HỆ THỐNG LOGIC HACK (HOẠT ĐỘNG NGẦM 100%)

-- Chống AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Tìm Remotes một cách thông minh (Universal Bypass)
local gameRemotes = {}
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        table.insert(gameRemotes, v)
    end
end

RunService.RenderStepped:Connect(function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local char = LocalPlayer.Character
    local hrp = char.HumanoidRootPart
    local hum = char:FindFirstChild("Humanoid")

    -- 1. Auto Roll
    if Config.AutoRoll then
        for _, remote in ipairs(gameRemotes) do
            local name = string.lower(remote.Name)
            if string.find(name, "roll") or string.find(name, "spin") or string.find(name, "rng") then
                pcall(function() remote:FireServer() end)
            end
        end
    end

    -- 2. Auto Chop (Dùng Tool)
    if Config.AutoChop then
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then 
            tool:Activate() 
            if Config.FastAttack then
                -- Bơm thêm lệnh FireServer vào hệ thống đánh
                for _, remote in ipairs(gameRemotes) do
                    local n = string.lower(remote.Name)
                    if string.find(n, "hit") or string.find(n, "chop") or string.find(n, "swing") then
                        pcall(function() remote:FireServer() end)
                    end
                end
            end
        else
            -- Tự động cầm Rìu lên
            local bpTool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
            if bpTool and hum then hum:EquipTool(bpTool) end
        end
    end

    -- 3. Auto Collect
    if Config.AutoCollect then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                local objName = string.lower(obj.Name)
                if string.find(objName, "drop") or string.find(objName, "wood") or string.find(objName, "coin") or string.find(objName, "reward") then
                    firetouchinterest(hrp, obj, 0)
                    firetouchinterest(hrp, obj, 1)
                end
            end
        end
    end

    -- 4. God Mode (WalkSpeed / JumpPower)
    if Config.GodMode and hum then
        hum.WalkSpeed = 50
        hum.JumpPower = 100
    elseif hum and not Config.GodMode then
        if hum.WalkSpeed > 16 then hum.WalkSpeed = 16 end
        if hum.JumpPower > 50 then hum.JumpPower = 50 end
    end
end)

print("[NOVA] V19.0 MacOS Style UI Loaded Successfully!")
