-- SMX FLY HUB V1 (PURE JOYSTICK & CAMERA DIRECTION)
local lp = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local runService = game:GetService("RunService")

-- DEĞİŞKENLER
local flying = false
local speedLevel = 1
local speeds = {20, 45, 70, 100, 140, 190, 250, 320, 400, 600}

-- ANA MENÜ TASARIMI
local MainFrame = Instance.new("Frame", ScreenGui)
local Gradient = Instance.new("UIGradient", MainFrame)
local Stroke = Instance.new("UIStroke", MainFrame)
local Corner = Instance.new("UICorner", MainFrame)

MainFrame.Size = UDim2.new(0, 200, 0, 220)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
MainFrame.Active = true
MainFrame.Draggable = true

Corner.CornerRadius = UDim.new(0, 15)
Stroke.Thickness = 3
Stroke.ApplyStrokeMode = "Border"
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(85, 0, 127)), -- Mor Neon
    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
}

-- FLY SİSTEMİ (KAMERA + JOYSTICK)
local function startFly()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    local bv = Instance.new("BodyVelocity", hrp)
    local bg = Instance.new("BodyGyro", hrp)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    
    task.spawn(function()
        while flying do
            runService.RenderStepped:Wait()
            char.Humanoid.PlatformStand = true
            
            local cam = workspace.CurrentCamera.CFrame
            local moveDir = char.Humanoid.MoveDirection 
            
            -- Bakış yönüyle joystick yönünü birleştiriyoruz
            if moveDir.Magnitude > 0 then
                bv.Velocity = cam.LookVector * (moveDir.Magnitude * speeds[speedLevel])
            else
                bv.Velocity = Vector3.new(0, 0, 0) -- Havada asılı kalma
            end
            
            bg.CFrame = cam
        end
        bv:Destroy()
        bg:Destroy()
        char.Humanoid.PlatformStand = false
    end)
end

-- MENÜ BUTONLARI
local List = Instance.new("ScrollingFrame", MainFrame)
List.Size = UDim2.new(1, 0, 0.7, 0)
List.Position = UDim2.new(0, 0, 0.28, 0)
List.BackgroundTransparency = 1
List.ScrollBarThickness = 0
local UIList = Instance.new("UIListLayout", List)
UIList.HorizontalAlignment = "Center"
UIList.Padding = UDim.new(0, 10)

local function createMenuBtn(txt, func)
    local b = Instance.new("TextButton", List)
    b.Size = UDim2.new(0.85, 0, 0, 40)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(30,30,30)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = "GothamBold"
    b.TextSize = 14
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    b.MouseButton1Click:Connect(function() func(b) end)
    return b
end

createMenuBtn("FLY: KAPALI", function(b)
    flying = not flying
    if flying then
        b.Text = "FLY: AKTİF"
        b.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        startFly()
    else
        b.Text = "FLY: KAPALI"
        b.BackgroundColor3 = Color3.fromRGB(30,30,30)
    end
end)

local speedBtn = createMenuBtn("HIZ: Seviye 1", function(b)
    speedLevel = speedLevel + 1
    if speedLevel > 10 then speedLevel = 1 end
    b.Text = "HIZ: Seviye " .. speedLevel
end)

createMenuBtn("MENÜYÜ SİL", function() ScreenGui:Destroy() end)

-- BAŞLIK (SMX FLY HUB V1)
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.25, 0)
Title.Text = "SMX FLY HUB V1"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = "GothamBold"
Title.TextSize = 16

-- Rainbow Efekt
task.spawn(function()
    while true do
        Gradient.Rotation = Gradient.Rotation + 2
        Stroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        task.wait()
    end
end)
