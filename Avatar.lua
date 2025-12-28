-- GARANTILI BROOKHAVEN AVATAR MENU
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- PANEL AYARLARI
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -150) -- Ekranın tam ortasında açılır
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1.2, 0)
ScrollingFrame.ScrollBarThickness = 5

UIListLayout.Parent = ScrollingFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 5) -- Butonlar arası boşluk

-- GARANTILI BUTON EKLEME FONKSIYONU
local function AddButton(text, color, func)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollingFrame
    btn.Text = text
    btn.Size = UDim2.new(0.9, 0, 0, 40) -- Butonlar daha belirgin
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.ZIndex = 5 -- En üstte görünmesi için
    btn.MouseButton1Click:Connect(func)
end

local lp = game.Players.LocalPlayer

-- BUTONLARI SIRAYLA EKLİYORUZ
AddButton("HEADLESS (BAŞSIZ)", Color3.fromRGB(50, 50, 50), function()
    if lp.Character:FindFirstChild("Head") then
        lp.Character.Head.Transparency = 1
        if lp.Character.Head:FindFirstChild("face") then lp.Character.Head.face.Transparency = 1 end
    end
end)

AddButton("KORBLOX (SAĞ BACAK)", Color3.fromRGB(0, 120, 255), function()
    local c = lp.Character
    local p = {"RightLowerLeg", "RightUpperLeg", "RightFoot"}
    for _, v in pairs(p) do if c:FindFirstChild(v) then c[v]:Destroy() end end
end)

AddButton("ZOMBIE SOL BACAK", Color3.fromRGB(60, 120, 60), function()
    local c = lp.Character
    local p = {"LeftLowerLeg", "LeftUpperLeg", "LeftFoot"}
    for _, v in pairs(p) do if c:FindFirstChild(v) then c[v]:Destroy() end end
end)

AddButton("İNCE BEL / VÜCUT", Color3.fromRGB(200, 80, 150), function()
    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if hum:FindFirstChild("BodyWidthScale") then hum.BodyWidthScale.Value = 0.6 end
        if hum:FindFirstChild("BodyDepthScale") then hum.BodyDepthScale.Value = 0.7 end
    end
end)

AddButton("MENÜYÜ KAPAT", Color3.fromRGB(200, 0, 0), function()
    ScreenGui:Destroy()
end)
