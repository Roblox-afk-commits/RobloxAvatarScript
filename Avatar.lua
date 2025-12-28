-- DELTA SÜPER AVATAR MENÜSÜ
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- GUI ANA AYARLAR
ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Size = UDim2.new(1, 0, 0.9, 0)
ScrollingFrame.Position = UDim2.new(0, 0, 0.1, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
ScrollingFrame.ScrollBarThickness = 5

UIListLayout.Parent = ScrollingFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = Vector2.new(0, 10)

-- BUTON OLUŞTURMA FONKSİYONU
local function createBtn(name, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollingFrame
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(callback)
end

local lp = game.Players.LocalPlayer

-- 1. HEADLESS
createBtn("HEADLESS (BAŞSIZ)", Color3.fromRGB(50, 50, 50), function()
    local char = lp.Character
    if char:FindFirstChild("Head") then
        char.Head.Transparency = 1
        if char.Head:FindFirstChild("face") then char.Head.face.Transparency = 1 end
    end
end)

-- 2. KORBLOX (Sağ Bacak)
createBtn("KORBLOX", Color3.fromRGB(0, 102, 204), function()
    local char = lp.Character
    local p = {"RightLowerLeg", "RightUpperLeg", "RightFoot"}
    for _, v in pairs(p) do if char:FindFirstChild(v) then char[v]:Destroy() end end
end)

-- 3. İNCE BEL
createBtn("İNCE BEL", Color3.fromRGB(255, 105, 180), function()
    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:FindFirstChild("BodyWidthScale").Value = 0.8
        hum:FindFirstChild("BodyDepthScale").Value = 0.8
    end
end)

-- 4. KASLI VÜCUT
createBtn("KASLI VÜCUT", Color3.fromRGB(139, 69, 19), function()
    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:FindFirstChild("BodyProportionsScale").Value = 1
        hum:FindFirstChild("BodyTypeScale").Value = 1
        hum:FindFirstChild("BodyWidthScale").Value = 1.2
    end
end)

-- 5. İNCE VÜCUT (Thin)
createBtn("İNCE VÜCUT", Color3.fromRGB(200, 200, 200), function()
    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum:FindFirstChild("BodyWidthScale").Value = 0.5
        hum:FindFirstChild("BodyDepthScale").Value = 0.5
    end
end)

-- 6. ZOMBIE LEFT LEG
createBtn("ZOMBIE SOL BACAK", Color3.fromRGB(34, 139, 34), function()
    local char = lp.Character
    local parts = {"LeftLowerLeg", "LeftUpperLeg", "LeftFoot"}
    for _, v in pairs(parts) do 
        if char:FindFirstChild(v) then 
            char[v].Transparency = 0.5 -- Hafif hayaletimsi zombi efekti
            char[v].Color = Color3.fromRGB(100, 120, 100)
        end 
    end
end)

-- 7. ZOMBIE RIGHT LEG
createBtn("ZOMBIE SAĞ BACAK", Color3.fromRGB(34, 139, 34), function()
    local char = lp.Character
    local parts = {"RightLowerLeg", "RightUpperLeg", "RightFoot"}
    for _, v in pairs(parts) do 
        if char:FindFirstChild(v) then 
            char[v].Transparency = 0.5
            char[v].Color = Color3.fromRGB(100, 120, 100)
        end 
    end
end)

-- KAPATMA BUTONU
createBtn("MENÜYÜ SİL", Color3.fromRGB(150, 0, 0), function()
    ScreenGui:Destroy()
end)

print("Delta Karakter Scripti Yüklendi!")
