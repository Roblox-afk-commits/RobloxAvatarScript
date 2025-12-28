-- NEON FLY PRO (MANUEL KONTROL PANELİ)
local lp = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

-- DEĞİŞKENLER
local flying = false
local speed = 50
local ctrl = {f = 0, b = 0, l = 0, r = 0, u = 0, d = 0}

-- ANA MENÜ
local MainFrame = Instance.new("Frame", ScreenGui)
local Gradient = Instance.new("UIGradient", MainFrame)
local Stroke = Instance.new("UIStroke", MainFrame)
local Corner = Instance.new("UICorner", MainFrame)

MainFrame.Size = UDim2.new(0, 200, 0, 260)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
MainFrame.Active = true
MainFrame.Draggable = true

Corner.CornerRadius = UDim.new(0, 15)
Stroke.Thickness = 3
Stroke.ApplyStrokeMode = "Border"
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(85, 0, 127)),
    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
}

-- KONTROL PANELİ (SAĞ ALT)
local ControlFrame = Instance.new("Frame", ScreenGui)
ControlFrame.Size = UDim2.new(0, 150, 0, 150)
ControlFrame.Position = UDim2.new(1, -170, 1, -220)
ControlFrame.BackgroundTransparency = 1
ControlFrame.Visible = false

local function createControlBtn(txt, pos, press, release)
    local b = Instance.new("TextButton", ControlFrame)
    b.Size = UDim2.new(0, 45, 0, 45)
    b.Position = pos
    b.Text = txt
    b.BackgroundColor3 = Color3.new(0,0,0)
    b.BackgroundTransparency = 0.3
    b.TextColor3 = Color3.new(1,1,1)
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(1, 0)
    local s = Instance.new("UIStroke", b)
    s.Thickness = 2
    s.Color = Color3.fromRGB(85, 0, 127)
    
    b.MouseButton1Down:Connect(press)
    b.MouseButton1Up:Connect(release)
    return b
end

-- Butonları Yerleştir
createControlBtn("↑", UDim2.new(0.35, 0, 0, 0), function() ctrl.f = 1 end, function() ctrl.f = 0 end)
createControlBtn("↓", UDim2.new(0.35, 0, 0.7, 0), function() ctrl.b = -1 end, function() ctrl.b = 0 end)
createControlBtn("←", UDim2.new(0, 0, 0.35, 0), function() ctrl.l = -1 end, function() ctrl.l = 0 end)
createControlBtn("→", UDim2.new(0.7, 0, 0.35, 0), function() ctrl.r = 1 end, function() ctrl.r = 0 end)
createControlBtn("▲", UDim2.new(0.8, 0, -0.3, 0), function() ctrl.u = 1 end, function() ctrl.u = 0 end)
createControlBtn("▼", UDim2.new(0.8, 0, 1, 0), function() ctrl.d = -1 end, function() ctrl.d = 0 end)

-- FLY MANTIĞI
local function startFly()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local bv = Instance.new("BodyVelocity", hrp)
    local bg = Instance.new("BodyGyro", hrp)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    
    task.spawn(function()
        while flying do
            task.wait()
            char.Humanoid.PlatformStand = true
            local cam = workspace.CurrentCamera.CFrame
            bv.Velocity = (cam.LookVector * (ctrl.f + ctrl.b) + cam.RightVector * (ctrl.l + ctrl.r) + Vector3.new(0, ctrl.u + ctrl.d, 0)) * speed
            bg.CFrame = cam
        end
        bv:Destroy()
        bg:Destroy()
        char.Humanoid.PlatformStand = false
    end)
end

-- Menü Butonları
local List = Instance.new("ScrollingFrame", MainFrame)
List.Size = UDim2.new(1, 0, 0.7, 0)
List.Position = UDim2.new(0, 0, 0.25, 0)
List.BackgroundTransparency = 1
List.ScrollBarThickness = 0
local UIList = Instance.new("UIListLayout", List)
UIList.HorizontalAlignment = "Center"
UIList.Padding = UDim.new(0, 5)

local function createMenuBtn(txt, col, func)
    local b = Instance.new("TextButton", List)
    b.Size = UDim2.new(0.8, 0, 0, 35)
    b.Text = txt
    b.BackgroundColor3 = col
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = "GothamBold"
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(func)
end

createMenuBtn("FLY: KAPALI", Color3.fromRGB(40,40,40), function(self)
    flying = not flying
    if flying then
        self.Text = "FLY: AKTİF"
        self.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        ControlFrame.Visible = true
        startFly()
    else
        self.Text = "FLY: KAPALI"
        self.BackgroundColor3 = Color3.fromRGB(40,40,40)
        ControlFrame.Visible = false
    end
end)

createMenuBtn("HIZ (+)", Color3.fromRGB(0, 100, 200), function() speed = speed + 20 end)
createMenuBtn("HIZ (-)", Color3.fromRGB(200, 100, 0), function() speed = speed - 20 end)
createMenuBtn("KAPAT", Color3.fromRGB(150, 0, 0), function() ScreenGui:Destroy() end)

-- Rainbow Efekt
task.spawn(function()
    while true do
        Gradient.Rotation = Gradient.Rotation + 2
        Stroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        task.wait()
    end
end)
