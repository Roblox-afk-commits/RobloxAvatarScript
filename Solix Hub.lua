-- [[ SANDER XY - MOBILE OPTIMIZED ]] --

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local SpeedBox = Instance.new("TextBox")
local ToggleFly = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local Credits = Instance.new("TextLabel")
local UIGradient = Instance.new("UIGradient")

-- UI Ayarları
ScreenGui.Name = "SanderXY"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Ana Panel (Sander XY Klasik Siyah/Transparan)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Position = UDim2.new(0.5, -90, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 240)
MainFrame.Active = true
MainFrame.Draggable = true -- Mobil için sürüklenebilir

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Neon Mor Kenarlık (Pürüzsüz & Parlayan)
UIStroke.Parent = MainFrame
UIStroke.Thickness = 2.5
UIStroke.Color = Color3.fromRGB(170, 0, 255)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Başlık
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0.05, 0)
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "SANDER XY"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22

-- Hız Giriş Bölümü
SpeedBox.Name = "SpeedBox"
SpeedBox.Parent = MainFrame
SpeedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedBox.Position = UDim2.new(0.1, 0, 0.3, 0)
SpeedBox.Size = UDim2.new(0.8, 0, 0.15, 0)
SpeedBox.Font = Enum.Font.Gotham
SpeedBox.Text = "50"
SpeedBox.PlaceholderText = "Speed..."
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.TextSize = 14
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0, 6)

-- Fly Butonu
ToggleFly.Name = "ToggleFly"
ToggleFly.Parent = MainFrame
ToggleFly.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
ToggleFly.Position = UDim2.new(0.1, 0, 0.55, 0)
ToggleFly.Size = UDim2.new(0.8, 0, 0.2, 0)
ToggleFly.Font = Enum.Font.GothamBold
ToggleFly.Text = "FLY: OFF"
ToggleFly.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleFly.TextSize = 16
Instance.new("UICorner", ToggleFly).CornerRadius = UDim.new(0, 6)

-- Bilgi Yazıları
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0.78, 0)
StatusLabel.Size = UDim2.new(1, 0, 0.1, 0)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 12

Credits.Parent = MainFrame
Credits.BackgroundTransparency = 1
Credits.Position = UDim2.new(0, 0, 0.9, 0)
Credits.Size = UDim2.new(1, 0, 0.1, 0)
Credits.Font = Enum.Font.GothamItalic
Credits.Text = "Modified for Delta"
Credits.TextColor3 = Color3.fromRGB(100, 100, 100)
Credits.TextSize = 10

-- ARKA PLAN MOR GEÇİŞİ
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 0, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
}
UIGradient.Rotation = 90
UIGradient.Parent = MainFrame

-- FLY MEKANİZMASI (Sander XY Logic)
local plr = game.Players.LocalPlayer
local flying = false
local speed = 50
local bv, bg

function startFlying()
    local char = plr.Character or plr.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    flying = true
    StatusLabel.Text = "Status: Flying"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    
    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e8, 1e8, 1e8)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = hrp
    
    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e8, 1e8, 1e8)
    bg.P = 10000
    bg.Parent = hrp
    
    task.spawn(function()
        while flying do
            task.wait()
            speed = tonumber(SpeedBox.Text) or 50
            char.Humanoid.PlatformStand = true
            
            bg.CFrame = workspace.CurrentCamera.CFrame
            local direction = workspace.CurrentCamera.CFrame.LookVector
            bv.Velocity = direction * speed
        end
    end)
end

function stopFlying()
    flying = false
    StatusLabel.Text = "Status: Idle"
    StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    
    if plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.PlatformStand = false
    end
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end

ToggleFly.MouseButton1Click:Connect(function()
    if not flying then
        startFlying()
        ToggleFly.Text = "FLY: ON"
        ToggleFly.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    else
        stopFlying()
        ToggleFly.Text = "FLY: OFF"
        ToggleFly.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
    end
end)

-- SÜREKLİ DÖNEN MOR ANİMASYON
task.spawn(function()
    while true do
        for i = 0, 360, 2 do
            UIGradient.Rotation = i
            UIStroke.Color = Color3.fromHSV(0.78, 0.8, 0.6 + (math.sin(tick() * 2) * 0.2))
            task.wait(0.05)
        end
    end
end)
