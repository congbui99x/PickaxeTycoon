-- NOVA SCRIPTOR v16.0 GENERATOR
-- CÔNG BÙI VIP - AUTO ON MODE (Bỏ qua nút bấm)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

-- Kích hoạt Gamepass Hook ngay lập tức
local old
old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "UserOwnsGamePassAsync" or method == "PlayerOwnsAsset" then
        return true
    end
    return old(self, ...)
end))

-- Tự động bật Auto Farm & Hút quặng
task.spawn(function()
    StarterGui:SetCore("SendNotification", {Title="CÔNG BÙI", Text="ĐÃ KÍCH HOẠT X2 & AUTO FARM!", Duration=5})
    
    while task.wait(0.1) do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                    local name = string.lower(obj.Name)
                    if string.find(name, "ore") or string.find(name, "collect") or string.find(name, "basket") then
                        firetouchinterest(hrp, obj, 0)
                        firetouchinterest(hrp, obj, 1)
                    end
                end
            end
            local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end
end)
