-- NOVA SCRIPTOR v16.0 GENERATOR
-- Target Map: Pickaxe Tycoon
-- Script Name: Gamepass_Spoofer_X2_Money
-- Edition: CÔNG BÙI VIP - 3D Hologram (Delta iOS)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

print("[NOVA] V16.0 Executed! Hooking Gamepass API...")

local isBypassed = false
local oldNamecall

-- 1. THUẬT TOÁN ĐÁNH LỪA GAMEPASS (Hookmetamethod)
local function enableGamepassBypass()
    if not oldNamecall then
        pcall(function()
            oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
                local method = getnamecallmethod()
                
                -- Chặn các hàm kiểm tra Gamepass
                if method == "UserOwnsGamePassAsync" or method == "PlayerOwnsAsset" then
                    -- Nếu đang bật Bypass, luôn trả về TRUE (Đã mua)
                    if isBypassed then
                        return true
                    end
                end
                
                return oldNamecall(self, ...)
            end))
            print("[NOVA] Gamepass API Hooked Successfully.")
        end)
    end
end

-- Khởi chạy Hook ngầm ngay khi execute
enableGamepassBypass()

-- 2. Vòng lặp Hỗ trợ (Auto Thu Thập & Spam)
local farmLoop
local function startSupportFarm()
    if farmLoop then farmLoop:Disconnect() end
    farmLoop = RunService.RenderStepped:Connect(function()
        if isBypassed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            
            -- Spam nhặt quặng để x2 tiền nhảy liên tục
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                    local objName = string.lower(obj.Name)
                    if string.find(objName, "collect") or string.find(objName, "basket") or string.find(objName, "giver") or string.find(objName, "ore") then
                        firetouchinterest(hrp, obj, 0)
                        firetouchinterest(hrp, obj, 1)
                    end
                end
            end
        end
    end)
end

local function stopSupportFarm()
    if farmLoop then farmLoop:Disconnect() end
end

-- 3. Cấy UI 3D CÔNG BÙI lên đầu
local function createHologram(character)
    local head = character:WaitForChild("Head", 5)
    if not head then return end

    if character:FindFirstChild("CongBui_Gamepass") then
        character.CongBui_Gamepass:Destroy()
    end

    local bgui = Instance.new("BillboardGui")
    bgui.Name = "CongBui_Gamepass"
    bgui.Adornee = head
    bgui.Size = UDim2.new(0, 320, 0, 60)
    bgui.StudsOffset = Vector3.new(0, 3.5, 0)
    bgui.AlwaysOnTop = true
    bgui.Parent = character

    local textBtn = Instance.new("TextButton")
    textBtn.Size = UDim2.new(1, 0, 1, 0)
    textBtn.BackgroundTransparency = 1
    textBtn.Text = "💎 CÔNG BÙI\nX2 GAMEPASS: OFF"
    textBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    textBtn.TextStrokeTransparency = 0
    textBtn.Font = Enum.Font.GothamBlack
    textBtn.TextScaled = true
    textBtn.Parent = bgui

    textBtn.MouseButton1Click:Connect(function()
        isBypassed = not isBypassed
        if isBypassed then
            textBtn.Text = "💎 CÔNG BÙI\nX2 GAMEPASS: ON"
            textBtn.TextColor3 = Color3.fromRGB(0, 255, 150) -- Xanh ngọc VIP
            startSupportFarm()
            StarterGui:SetCore("SendNotification", {Title="CÔNG BÙI", Text="Đã kích hoạt X2 Tiền Ảo!", Duration=3})
        else
            textBtn.Text = "💎 CÔNG BÙI\nX2 GAMEPASS: OFF"
            textBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            stopSupportFarm()
        end
    end)
end

if LocalPlayer.Character then createHologram(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(createHologram)

print("[NOVA] 2x Money Spoofer Ready!")
