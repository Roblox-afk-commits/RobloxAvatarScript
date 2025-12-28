-- SMX FLY HUB V1 (KESİN ÇÖZÜM - TASARIM DÜZELTİLDİ)
local lp = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Gavathub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local flying = false
local speedLevel = 1
local speeds = {30, 50, 80, 115, 160, 210, 270, 340, 420, 550}

-- ANA PANEL (BEYAZLIK SORUNU GİDERİLDİ)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 280)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Bembeyaz olmasın diye koyu renk yapıldı
MainFrame.Active = true
MainFrame.Draggable = true

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 3
Stroke.ApplyStrokeMode = "Border"

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

-- AÇ BUTONU
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 80, 0, 40)
OpenBtn.Position = UDim2.new(0, 15, 0.5, -20)
OpenBtn.Text = "AÇ"
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenBtn.Visible = false
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 10)

-- FLY MOTORU (JOYSTICK ODAKLI)
local function startFly()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    local bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.P = 5000

    task.spawn(function()
        while flying and char.Parent and hum.Health > 0 do
            game:GetService("RunService").RenderStepped:Wait()
            local cam = workspace.CurrentCamera
            hum.PlatformStand = true
            
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 then
                -- Joystick ne tarafı gösterirse o yöne uç
                bv.Velocity = moveDir * speeds[speedLevel]
                bg.CFrame = cam.CFrame
            else
                bv.Velocity = Vector3.new(0, 0, 0)
                bg.CFrame = cam.CFrame
            end
        end
        bv:Destroy(); bg:Destroy()
        if hum then hum.PlatformStand = false; hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end)
end

-- LİSTE
local List = Instance.new("ScrollingFrame", MainFrame)
List.Size = UDim2.new(1, 0, 0.8, 0)
List.Position = UDim2.new(0, 0, 0.18, 0)
List.BackgroundTransparency = 1
List.ScrollBarThickness = 0
local layout = Instance.new("UIListLayout", List)
layout.HorizontalAlignment = "Center"
layout.Padding = UDim.new(0, 5)

local function createMenuBtn(txt, func)
    local b = Instance.new("TextButton", List)
    b.Size = UDim2.new(0.85, 0, 0, 35)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    b.MouseButton1Click:Connect(function() func(b) end)
end

createMenuBtn("FLY: KAPALI", function(b)
    flying = not flying
    if flying then 
        b.Text = "FLY: AKTİF"
        b.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        startFly()
    else 
        b.Text = "FLY: KAPALI"
        b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- HIZ AYARI
local SpeedFrame = Instance.new("Frame", List)
SpeedFrame.Size = UDim2.new(0.85, 0, 0, 40)
SpeedFrame.BackgroundTransparency = 1

local sLabel = Instance.new("TextLabel", SpeedFrame)
sLabel.Size = UDim2.new(0.4, 0, 1, 0)
sLabel.Position = UDim2.new(0.3, 0, 0, 0)
sLabel.Text = "HIZ: 1"
sLabel.TextColor3 = Color3.new(1, 1, 1)
sLabel.Font = Enum.Font.GothamBold
sLabel.BackgroundTransparency = 1

local function adjust(t, p, v)
    local b = Instance.new("TextButton", SpeedFrame)
    b.Size = UDim2.new(0.25, 0, 0.8, 0)
    b.Position = p
    b.Text = t
    b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    b.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() 
        speedLevel = math.clamp(speedLevel + v, 1, 10)
        sLabel.Text = "HIZ: " .. speedLevel 
    end)
end
adjust("-", UDim2.new(0, 0, 0.1, 0), -1)
adjust("+", UDim2.new(0.75, 0, 0.1, 0), 1)

createMenuBtn("MENÜYÜ KAPAT", function() MainFrame.Visible = false; OpenBtn.Visible = true end)
createMenuBtn("SCRİPTİ SİL", function() ScreenGui:Destroy() end)

OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; OpenBtn.Visible = false end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Text = "SMX FLY HUB V1"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

-- GÖKKUŞAĞI KENARLIK ANİMASYONU
task.spawn(function()
    while true do
        local rainbow = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Stroke.Color = rainbow
        task.wait()
    end
end)
