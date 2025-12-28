-- FAVORİ DEVELOPER: NEON ANIMATED FLY v3 (FINAL)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local OpenButton = Instance.new("TextButton")
local OpenCorner = Instance.new("UICorner")
local OpenStroke = Instance.new("UIStroke")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "FavoriFlyMenu"

-- ANA PANEL: NEON TASARIM
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(1, 1, 1) -- Gradient için
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Active = true
MainFrame.BorderSizePixel = 0

UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

-- NEON KENARLIK (Sürekli Renk Değiştiren)
UIStroke.Parent = MainFrame
UIStroke.Thickness = 3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- ARKA PLAN: HAREKETLİ DALGALANMA
UIGradient.Parent = MainFrame
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 15)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(45, 25, 65)), -- Derin mor dalga
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
})

-- RENK VE DÖNÜŞ ANİMASYONU
task.spawn(function()
    local t = 0
    while true do
        t = t + 0.02
        UIGradient.Rotation = math.sin(t) * 360
        UIStroke.Color = Color3.fromHSV(math.abs(math.sin(t/3)), 0.7, 1) -- Kenarlar akar
        task.wait(0.01)
    end
end)

-- BAŞLIK
Title.Parent = MainFrame
Title.Text = "★ FAVORİ FLY ★"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- İÇERİK LİSTESİ
ScrollingFrame.Parent = MainFrame
ScrollingFrame.Position = UDim2.new(0, 0, 0.2, 0)
ScrollingFrame.Size = UDim2.new(1, 0, 0.8, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 0
UIListLayout.Parent = ScrollingFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 12)

-- FLY SİSTEMİ
local flying = false
local flySpeed = 60
local lp = game.Players.LocalPlayer

local function AddButton(text, color, func)
    local btn = Instance.new("TextButton")
    local btnCorner = Instance.new("UICorner")
    btn.Parent = ScrollingFrame
    btn.Text = text
    btn.Size = UDim2.new(0.85, 0, 0, 45)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    btn.MouseButton1Click:Connect(func)
    return btn
end

-- BUTONLAR
local flyBtn = AddButton("DURUM: KAPALI", Color3.fromRGB(40, 40, 40), function() end)
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        flyBtn.Text = "DURUM: AKTİF"
        flyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
        local char = lp.Character
        local TNG = char:WaitForChild("HumanoidRootPart")
        local BV = Instance.new("BodyVelocity", TNG)
        local BG = Instance.new("BodyGyro", TNG)
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            while flying do
                task.wait()
                char.Humanoid.PlatformStand = true
                BV.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
                BG.CFrame = workspace.CurrentCamera.CFrame
            end
            BV:Destroy(); BG:Destroy()
            char.Humanoid.PlatformStand = false
        end)
    else
        flyBtn.Text = "DURUM: KAPALI"
        flyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

local speedText = Instance.new("TextLabel")
speedText.Parent = ScrollingFrame
speedText.Text = "HIZ: " .. flySpeed
speedText.Size = UDim2.new(1, 0, 0, 20)
speedText.TextColor3 = Color3.new(1, 1, 1)
speedText.BackgroundTransparency = 1
speedText.Font = Enum.Font.GothamBold

AddButton("HIZI ARTTIR (+)", Color3.fromRGB(0, 110, 230), function()
    flySpeed = flySpeed + 20
    speedText.Text = "HIZ: " .. flySpeed
end)

AddButton("HIZI AZALT (-)", Color3.fromRGB(0, 110, 230), function()
    if flySpeed > 20 then
        flySpeed = flySpeed - 20
        speedText.Text = "HIZ: " .. flySpeed
    end
end)

AddButton("MENÜYÜ SAKLA", Color3.fromRGB(150, 0, 0), function()
    MainFrame.Visible = false; OpenButton.Visible = true
end)

-- AÇMA BUTONU
OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 15, 0.45, 0)
OpenButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenButton.Text = "FLY"
OpenButton.TextColor3 = Color3.new(1, 1, 1)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.Visible = false
OpenCorner.CornerRadius = UDim.new(1, 0); OpenCorner.Parent = OpenButton
OpenStroke.Parent = OpenButton; OpenStroke.Thickness = 2; OpenStroke.Color = Color3.new(0, 1, 1)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true; OpenButton.Visible = false
end)

-- MOBİL SÜRÜKLEME (TOUCH DESTEKLİ)
local dragStart, startPos, dragging
MainFrame.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then dragging = true; dragStart = i.Position; startPos = MainFrame.Position end end)
game:GetService("UserInputService").InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.Touch then
    local d = i.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
end end)
MainFrame.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
