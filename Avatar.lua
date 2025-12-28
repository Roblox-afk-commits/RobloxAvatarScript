-- DELTA MOBİL ÖZEL - PC'DEN GÜNCELLENMİŞ VERSİYON
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 280) -- Mobilde ideal boy
MainFrame.Active = true
MainFrame.Draggable = true -- Parmağınla sürükleyebilirsin

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollingFrame.ScrollBarThickness = 3

UIListLayout.Parent = ScrollingFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 8)

local function AddButton(text, color, func)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollingFrame
    btn.Text = text
    btn.Size = UDim2.new(0.9, 0, 0, 45) -- Mobilde basması kolay büyük butonlar
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(func)
end

local lp = game.Players.LocalPlayer

-- ÖZELLİKLER (BROOKHAVEN R15 UYUMLU)
AddButton("HEADLESS", Color3.fromRGB(50, 50, 50), function()
    local char = lp.Character
    if char:FindFirstChild("Head") then
        char.Head.Transparency = 1
        if char.Head:FindFirstChild("face") then char.Head.face.Transparency = 1 end
    end
end)

AddButton("KORBLOX", Color3.fromRGB(0, 120, 255), function()
    local char = lp.Character
    local parts = {"RightLowerLeg", "RightUpperLeg", "RightFoot"}
    for _, v in pairs(parts) do if char:FindFirstChild(v) then char[v]:Destroy() end end
end)

AddButton("ZOMBİ SOL BACAK", Color3.fromRGB(60, 120, 60), function()
    local char = lp.Character
    local parts = {"LeftLowerLeg", "LeftUpperLeg", "LeftFoot"}
    for _, v in pairs(parts) do if char:FindFirstChild(v) then char[v]:Destroy() end end
end)

AddButton("İNCE BEL / VÜCUT", Color3.fromRGB(200, 80, 150), function()
    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum:FindFirstChild("BodyWidthScale") then hum.BodyWidthScale.Value = 0.6 end
        if hum:FindFirstChild("BodyDepthScale") then hum.BodyDepthScale.Value = 0.7 end
    end
end)

AddButton("KASLI VÜCUT", Color3.fromRGB(180, 100, 0), function()
    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum:FindFirstChild("BodyTypeScale") then hum.BodyTypeScale.Value = 1.1 end
    end
end)

AddButton("MENÜYÜ KAPAT", Color3.fromRGB(180, 0, 0), function()
    ScreenGui:Destroy()
end)
