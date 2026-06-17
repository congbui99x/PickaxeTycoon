-- ============================================================
-- PICKAXE TYCOON ⛏️ – SCRIPT CHUYÊN BIỆT CHO Popular Marketplace
-- Tác giả: Công Bùi
-- Hỗ trợ: Android / iOS (Delta, Arceus X, Hydrogen, ScriptWare)
-- TÍNH NĂNG: Auto Collect, Deposit, Upgrade, Buy, Chest, Merge, Sell
-- LƯU Ý: Script KHÔNG tự bật. Bạn bật/tắt qua GUI.
-- ============================================================

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local VIM = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

-- ========== CẤU HÌNH MẶC ĐỊNH (TẤT CẢ ĐỀU TẮT) ==========
local Settings = {
    AutoCollect = false,
    AutoDeposit = false,
    AutoUpgrade = false,
    AutoBuy = false,
    AutoChest = false,
    AutoMerge = false,
    AutoSell = false,
    ClickDelay = 0.3,
}

-- ========== HÀM LẤY PLOT CỦA BẠN ==========
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

-- ========== HÀM CLICK BẰNG VIRTUAL INPUT ==========
local function clickPart(part)
    if not part then return end
    pcall(function()
        local cam = workspace.CurrentCamera
        local pos = part.Position
        local vec, onScreen = cam:WorldToScreenPoint(pos)
        if onScreen then
            VIM:SendMouseButtonEvent(vec.X, vec.Y, 0, true, game, 0)
            task.wait(0.05)
            VIM:SendMouseButtonEvent(vec.X, vec.Y, 0, false, game, 0)
        end
    end)
end

-- ========== TÌM NÚT TRONG PLOT ==========
local function getButton(plot, name)
    if not plot then return nil end
    local sell = plot:FindFirstChild("Sell")
    if not sell then return nil end
    local container = sell:FindFirstChild(name)
    if not container then return nil end
    return container:FindFirstChild("Button")
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
    return pickaxe:FindFirstChild("Button")
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
    return merge:FindFirstChild("Button")
end

local function getSellButton()
    local sellArea = workspace:FindFirstChild("SellArea")
    if not sellArea then return nil end
    return sellArea:FindFirstChild("Button")
end

-- ========== CÁC LUỒNG AUTO (CHỈ CHẠY KHI BẬT) ==========
local function autoCollect()
    while true do
        if Settings.AutoCollect then
            local plot = getMyPlot()
            if plot then
                local btn = getButton(plot, "CollectButton")
                if btn then clickPart(btn) end
            end
        end
        task.wait(Settings.ClickDelay)
    end
end

local function autoDeposit()
    while true do
        if Settings.AutoDeposit then
            local plot = getMyPlot()
            if plot then
                local btn = getButton(plot, "DepositButton")
                if btn then clickPart(btn) end
            end
        end
        task.wait(1)
    end
end

local function autoUpgrade()
    while true do
        if Settings.AutoUpgrade then
            local plot = getMyPlot()
            if plot then
                local btn = getUpgradeButton(plot)
                if btn then clickPart(btn) end
            end
        end
        task.wait(2)
    end
end

local function autoBuyPickaxe()
    while true do
        if Settings.AutoBuy then
            local btn = getPickaxeButton()
            if btn then clickPart(btn) end
        end
        task.wait(5)
    end
end

local function autoChest()
    while true do
        if Settings.AutoChest then
            local btn = getChestButton()
            if btn then clickPart(btn) end
        end
        task.wait(10)
    end
end

local function autoMerge()
    while true do
        if Settings.AutoMerge then
            local btn = getMergeButton()
            if btn then clickPart(btn) end
        end
        task.wait(3)
    end
end

local function autoSell()
    while true do
        if Settings.AutoSell then
            local btn = getSellButton()
            if btn then clickPart(btn) end
        end
        task.wait(2)
    end
end

-- ========== TẠO GUI (BẬT/TẮT THỦ CÔNG) ==========
local function createGUI()
    local sg = Instance.new("ScreenGui")
    sg.Name = "PickaxeGUI"
    sg.Parent = player.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 230, 0, 340)
    frame.Position = UDim2.new(0, 10, 0.5, -170)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = sg

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
    title.Text = "⛏️ PICKAXE TYCOON"
    title.TextColor3 = Color3.fromRGB(255, 200, 50)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 28, 0, 28)
    close.Position = UDim2.new(1, -33, 0, 3)
    close.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    close.Text = "✕"
    close.TextColor3 = Color3.fromRGB(255, 255, 255)
    close.TextScaled = true
    close.Font = Enum.Font.GothamBold
    close.Parent = frame
    close.MouseButton1Click:Connect(function() sg:Destroy() end)

    local toggles = {
        {"💰 Collect", "AutoCollect", 48},
        {"🏦 Deposit", "AutoDeposit", 85},
        {"⬆️ Upgrade", "AutoUpgrade", 122},
        {"🛒 Buy Pickaxe", "AutoBuy", 159},
        {"🎁 Chest", "AutoChest", 196},
        {"🔗 Merge", "AutoMerge", 233},
        {"💲 Sell", "AutoSell", 270},
    }

    for _, t in ipairs(toggles) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 30)
        btn.Position = UDim2.new(0.05, 0, 0, t[3])
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
        btn.Text = (Settings[t[2]] and "✅ " or "🔲 ") .. t[1]
        btn.TextColor3 = Color3.fromRGB(200, 200, 230)
        btn.TextScaled = true
        btn.Font = Enum.Font.Gotham
        btn.Parent = frame
        btn.MouseButton1Click:Connect(function()
            Settings[t[2]] = not Settings[t[2]]
            btn.Text = (Settings[t[2]] and "✅ " or "🔲 ") .. t[1]
        end)
    end

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 22)
    status.Position = UDim2.new(0, 0, 1, -24)
    status.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    status.BackgroundTransparency = 0.5
    status.Text = "🟢 SCRIPT SẴN SÀNG"
    status.TextColor3 = Color3.fromRGB(100, 255, 100)
    status.TextScaled = true
    status.Font = Enum.Font.Gotham
    status.Parent = frame
end

-- ========== KHỞI ĐỘNG ==========
print("⛏️ Pickaxe Tycoon Script – Công Bùi")
print("📱 Chạy trên Android / iOS")
print("🟢 SCRIPT ĐÃ SẴN SÀNG – Bật/Tắt qua GUI")

task.wait(2)

-- Chạy tất cả các luồng (nhưng chỉ hoạt động khi bật)
task.spawn(autoCollect)
task.spawn(autoDeposit)
task.spawn(autoUpgrade)
task.spawn(autoBuyPickaxe)
task.spawn(autoChest)
task.spawn(autoMerge)
task.spawn(autoSell)

-- Tạo GUI
createGUI()

print("✅ GUI đã xuất hiện. Bật chức năng bạn muốn!")
print("🟡 Tất cả chức năng đều TẮT mặc định.")
