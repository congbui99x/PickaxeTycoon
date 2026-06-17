-- =============================================
-- PICKAXE TYCOON - ANDROID OPTIMIZED
-- Chạy trên: Delta, Arceus X, Hydrogen, Vega X (Android)
-- Tác giả: Công Bùi
-- =============================================

local player = game.Players.LocalPlayer
local character = player.Character
local rootPart = character and character:FindFirstChild("HumanoidRootPart")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- ============ CẤU HÌNH ============
local Settings = {
    AutoCollect = true,
    AutoDeposit = true,
    AutoUpgrade = true,
    AutoBuy = true,
    AutoChest = true,
    AutoMerge = true,
    AutoSell = true,
    CollectDelay = 0.3,
    UpgradeThreshold = 100,
}

-- ============ HÀM LẤY PLOT ============
local function getMyPlot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _, plot in pairs(plots:GetChildren()) do
        local sign = plot:FindFirstChild("Sign")
        if sign then
            local surface = sign:FindFirstChild("Surface")
            if surface then
                local gui = surface:FindFirstChild("SurfaceGui")
                if gui then
                    local nameText = gui:FindFirstChild("NameText")
                    if nameText and nameText:IsA("TextLabel") and nameText.Text == player.Name then
                        return plot
                    end
                end
            end
        end
    end
    return nil
end

-- ============ FIRE TOUCH ============
local function fireTouch(part)
    if not part or not rootPart then return end
    pcall(function()
        firetouchinterest(rootPart, part, 0)
        task.wait()
        firetouchinterest(rootPart, part, 1)
    end)
end

-- ============ TÌM NÚT ============
local function getButton(plot, name)
    if not plot then return nil end
    local sell = plot:FindFirstChild("Sell")
    if not sell then return nil end
    local container = sell:FindFirstChild(name)
    if not container then return nil end
    local btn = container:FindFirstChild("Button")
    if btn and btn:IsA("BasePart") then return btn end
    return nil
end

local function getUpgradeButton(plot)
    if not plot then return nil end
    local upgrades = plot:FindFirstChild("Upgrades")
    if not upgrades then return nil end
    for _, upgrade in pairs(upgrades:GetChildren()) do
        if upgrade:IsA("Model") then
            local click = upgrade:FindFirstChild("Click")
            if click then
                local btn = click:FindFirstChild("Button")
                if btn and btn:IsA("BasePart") then return btn end
            end
        end
    end
    return nil
end

local function getPickaxeButton()
    local shop = workspace:FindFirstChild("Shop")
    if not shop then return nil end
    local pickaxe = shop:FindFirstChild("Pickaxe")
    if not pickaxe then return nil end
    local btn = pickaxe:FindFirstChild("Button")
    if btn and btn:IsA("BasePart") then return btn end
    return nil
end

local function getChestButton()
    local chests = workspace:FindFirstChild("Chests")
    if not chests then return nil end
    for _, chest in pairs(chests:GetChildren()) do
        local btn = chest:FindFirstChild("Button")
        if btn and btn:IsA("BasePart") then return btn end
    end
    return nil
end

local function getMergeButton()
    local merge = workspace:FindFirstChild("Merge")
    if not merge then return nil end
    local btn = merge:FindFirstChild("Button")
    if btn and btn:IsA("BasePart") then return btn end
    return nil
end

local function getSellButton()
    local sellArea = workspace:FindFirstChild("SellArea")
    if not sellArea then return nil end
    local btn = sellArea:FindFirstChild("Button")
    if btn and btn:IsA("BasePart") then return btn end
    return nil
end

-- ============ AUTO FUNCTIONS ============
local function autoCollect()
    while Settings.AutoCollect do
        local plot = getMyPlot()
        if plot then
            local btn = getButton(plot, "CollectButton")
            if btn then fireTouch(btn) end
        end
        task.wait(Settings.CollectDelay)
    end
end

local function autoDeposit()
    while Settings.AutoDeposit do
        local plot = getMyPlot()
        if plot then
            local btn = getButton(plot, "DepositButton")
            if btn then fireTouch(btn) end
        end
        task.wait(1)
    end
end

local function autoUpgrade()
    while Settings.AutoUpgrade do
        local plot = getMyPlot()
        if plot then
            local btn = getUpgradeButton(plot)
            if btn then fireTouch(btn) end
        end
        task.wait(2)
    end
end

local function autoBuyPickaxe()
    while Settings.AutoBuy do
        local btn = getPickaxeButton()
        if btn then fireTouch(btn) end
        task.wait(5)
    end
end

local function autoChest()
    while Settings.AutoChest do
        local btn = getChestButton()
        if btn then fireTouch(btn) end
        task.wait(10)
    end
end

local function autoMerge()
    while Settings.AutoMerge do
        local btn = getMergeButton()
        if btn then fireTouch(btn) end
        task.wait(3)
    end
end

local function autoSell()
    while Settings.AutoSell do
        local btn = getSellButton()
        if btn then fireTouch(btn) end
        task.wait(2)
    end
end

-- ============ GUI ANDROID ============
local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PickaxeGUI"
    screenGui.Parent = player.PlayerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 320)
    frame.Position = UDim2.new(0, 10, 0.5, -160)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
    title.Text = "⛏️ PICKAXE TYCOON"
    title.TextColor3 = Color3.fromRGB(255, 200, 50)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame
    
    -- Close
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Position = UDim2.new(1, -33, 0, 1)
    closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = frame
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    local toggles = {
        {name = "Collect", key = "AutoCollect", y = 40},
        {name = "Deposit", key = "AutoDeposit", y = 75},
        {name = "Upgrade", key = "AutoUpgrade", y = 110},
        {name = "Buy Pickaxe", key = "AutoBuy", y = 145},
        {name = "Chest", key = "AutoChest", y = 180},
        {name = "Merge", key = "AutoMerge", y = 215},
        {name = "Sell", key = "AutoSell", y = 250},
    }
    
    for _, toggle in ipairs(toggles) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 28)
        btn.Position = UDim2.new(0.05, 0, 0, toggle.y)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        btn.BackgroundTransparency = 0.2
        btn.Text = (Settings[toggle.key] and "✅ " or "🔲 ") .. toggle.name
        btn.TextColor3 = Color3.fromRGB(200, 200, 220)
        btn.TextScaled = true
        btn.Font = Enum.Font.Gotham
        btn.Parent = frame
        
        btn.MouseButton1Click:Connect(function()
            Settings[toggle.key] = not Settings[toggle.key]
            btn.Text = (Settings[toggle.key] and "✅ " or "🔲 ") .. toggle.name
            btn.BackgroundColor3 = Settings[toggle.key] and Color3.fromRGB(30, 70, 30) or Color3.fromRGB(35, 35, 55)
        end)
    end
    
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 20)
    status.Position = UDim2.new(0, 0, 1, -22)
    status.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    status.BackgroundTransparency = 0.5
    status.Text = "✅ Running"
    status.TextColor3 = Color3.fromRGB(100, 255, 100)
    status.TextScaled = true
    status.Font = Enum.Font.Gotham
    status.Parent = frame
    
    return screenGui
end

-- ============ KHỞI ĐỘNG ============
print("⛏️ Pickaxe Tycoon - Android Script")
print("👤 Công Bùi")

task.wait(2)

task.spawn(autoCollect)
task.spawn(autoDeposit)
task.spawn(autoUpgrade)
task.spawn(autoBuyPickaxe)
task.spawn(autoChest)
task.spawn(autoMerge)
task.spawn(autoSell)

createGUI()

print("✅ Script đã khởi động thành công!")
print("📱 Android Optimized - Nhấn GUI để tắt/bật")
