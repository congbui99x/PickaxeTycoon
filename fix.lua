-- =============================================
-- SCRIPT TỔNG QUÁT CHO GAME MÔ PHỎNG
-- Tác giả: Công Bùi
-- Tự động quét và tương tác với nút trong game
-- =============================================

local player = game.Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- ============ CẤU HÌNH ============
local Settings = {
    AutoFarm = true,
    AutoCollect = true,
    AutoUpgrade = true,
    AutoClick = true,
    ClickDelay = 0.2,
}

-- ============ TÌM NÚT THEO TỪ KHÓA ============
local function findButtonsByText(keywords)
    local results = {}
    local allObjects = game:GetDescendants()
    for _, obj in pairs(allObjects) do
        if obj:IsA("TextButton") or obj:IsA("ImageButton") then
            local text = obj.Text or obj.Name or ""
            for _, kw in ipairs(keywords) do
                if string.find(string.lower(text), string.lower(kw)) then
                    table.insert(results, obj)
                    break
                end
            end
        end
        if obj:IsA("BasePart") and obj.Name:find("Button") then
            table.insert(results, obj)
        end
    end
    return results
end

-- ============ CLICK NÚT ============
local function clickButton(button)
    if not button then return end
    pcall(function()
        if button:IsA("BasePart") then
            local cam = workspace.CurrentCamera
            local pos = button.Position
            local vec, onScreen = cam:WorldToScreenPoint(pos)
            if onScreen then
                VIM:SendMouseButtonEvent(vec.X, vec.Y, 0, true, game, 0)
                task.wait(0.05)
                VIM:SendMouseButtonEvent(vec.X, vec.Y, 0, false, game, 0)
            end
        elseif button:IsA("GuiButton") then
            button:Fire()
            button:Click()
        end
    end)
end

-- ============ AUTO FARM ============
local function autoFarm()
    while Settings.AutoFarm do
        -- Tìm tất cả nút có từ khóa "Collect", "Farm", "Harvest", "Claim"
        local buttons = findButtonsByText({"collect", "farm", "harvest", "claim", "thu", "hái", "nhận"})
        for _, btn in pairs(buttons) do
            clickButton(btn)
        end
        task.wait(Settings.ClickDelay)
    end
end

-- ============ AUTO UPGRADE ============
local function autoUpgrade()
    while Settings.AutoUpgrade do
        local buttons = findButtonsByText({"upgrade", "nâng cấp", "level", "buy", "mua"})
        for _, btn in pairs(buttons) do
            clickButton(btn)
        end
        task.wait(1)
    end
end

-- ============ AUTO CLICK (TAP) ============
local function autoClick()
    while Settings.AutoClick do
        local screenSize = workspace.CurrentCamera.ViewportSize
        local centerX = screenSize.X / 2
        local centerY = screenSize.Y / 2
        VIM:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
        task.wait(0.05)
        VIM:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
        task.wait(Settings.ClickDelay)
    end
end

-- ============ TẠO GUI ============
local function createGUI()
    local sg = Instance.new("ScreenGui")
    sg.Name = "AutoFarmGUI"
    sg.Parent = player.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 260)
    frame.Position = UDim2.new(0, 10, 0.5, -130)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = sg

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
    title.Text = "🚀 AUTO FARM"
    title.TextColor3 = Color3.fromRGB(0, 255, 200)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 25, 0, 25)
    close.Position = UDim2.new(1, -30, 0, 2)
    close.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
    close.Text = "✕"
    close.TextColor3 = Color3.fromRGB(255, 255, 255)
    close.TextScaled = true
    close.Font = Enum.Font.GothamBold
    close.Parent = frame
    close.MouseButton1Click:Connect(function() sg:Destroy() end)

    local toggles = {
        {"🔁 Auto Farm", "AutoFarm", 45},
        {"💰 Auto Collect", "AutoCollect", 85},
        {"⬆️ Auto Upgrade", "AutoUpgrade", 125},
        {"👆 Auto Click", "AutoClick", 165},
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
    status.Size = UDim2.new(1, 0, 0, 20)
    status.Position = UDim2.new(0, 0, 1, -22)
    status.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    status.BackgroundTransparency = 0.5
    status.Text = "🟢 RUNNING"
    status.TextColor3 = Color3.fromRGB(100, 255, 100)
    status.TextScaled = true
    status.Font = Enum.Font.Gotham
    status.Parent = frame
end

-- ============ KHỞI ĐỘNG ============
print("🚀 Script Auto Farm - Công Bùi")
print("📱 Đang quét game và tìm nút bấm...")

task.wait(2)

task.spawn(autoFarm)
task.spawn(autoUpgrade)
task.spawn(autoClick)

createGUI()

print("✅ Script đã sẵn sàng!")
print("🎯 Bật/tắt chức năng qua GUI")
