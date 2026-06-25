-- NOVA SCRIPTOR V21.0: AOT REVOLUTION
-- Coder: Máy chơi game siêu hiện đại - CÔNG BÙI VIP
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- GUI SETUP (MacOS Style)
local ScreenGui = Instance.new("ScreenGui", (gethui and gethui()) or game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Tiêu đề
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "💎 AOT REVOLUTION | VIP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold

-- Toggle Logic (Auto Farm Nape & Inf Gas)
local Config = { AutoNape = false, InfGas = false }

local function CreateBtn(text, key)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = UDim2.new(0.1, 0, 0, 50 + (key * 50))
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        Config[text] = not Config[text]
        btn.BackgroundColor3 = Config[text] and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(40, 40, 50)
    end)
end

CreateBtn("AutoNape", 1)
CreateBtn("InfGas", 2)

-- LOGIC CHÍNH
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    -- Auto Nape (Khóa gáy Titan)
    if Config["AutoNape"] then
        for _, titan in pairs(Workspace.Titans:GetChildren()) do
            if titan:FindFirstChild("Nape") and titan.Nape:FindFirstChild("Hitbox") then
                local dist = (char.HumanoidRootPart.Position - titan.Nape.Hitbox.Position).Magnitude
                if dist < 300 then
                    char.HumanoidRootPart.CFrame = CFrame.new(titan.Nape.Hitbox.Position + Vector3.new(0, 2, 0), titan.Nape.Hitbox.Position)
                end
            end
        end
    end
    
    -- Infinite Gas (Hack thông số bình gas)
    if Config["InfGas"] then
        local odm = char:FindFirstChild("ODM") or char:FindFirstChildOfClass("Tool")
        if odm and odm:FindFirstChild("Gas") then
            odm.Gas.Value = 100
        end
    end
end)

