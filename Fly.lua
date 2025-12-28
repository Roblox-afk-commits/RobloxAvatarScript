-- SMX FLY HUB V1 (HIZ SORUNU ÇÖZÜLDÜ)
local lp = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local runService = game:GetService("RunService")

-- DEĞİŞKENLER
local flying = false
local speedLevel = 1
local speeds = {25, 45, 75, 110, 160, 220, 290, 380, 500, 750} -- Hızlar daha belirgin yapıldı

-- ANA MENÜ TASARIMI
local MainFrame = Instance.new("Frame", ScreenGui)
local Gradient = Instance.new("UIGradient", MainFrame)
local Stroke = Instance.new("UIStroke", MainFrame)
local Corner = Instance.new("UICorner", MainFrame)

MainFrame.Size = UDim2.new(0, 200, 0, 240)
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

-- YENİDEN AÇMA BUTONU
local OpenBtn = Instance.new("TextButton", ScreenGui)
local OpenCorner = Instance.new("UICorner", OpenBtn)
local OpenStroke = Instance.new("UIStroke", OpenBtn)
local OpenGradient = Instance.new("UIGradient", OpenBtn)

OpenBtn.Size = UDim2.new(0, 60, 0, 35)
OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
OpenBtn.Text = "AÇ"
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Font = "GothamBold"
OpenBtn.BackgroundColor3 = Color3.new(1, 1, 1)
OpenBtn.Visible = false

OpenCorner.CornerRadius = UDim.new(0, 10)
OpenStroke.Thickness = 2
OpenGradient.Color = Gradient.Color

-- FLY SİSTEMİ (HIZ ANLIK GÜNCELLENİR)
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
            if char:FindFirstChild("Humanoid") then
                char.Humanoid.PlatformStand = true
                
                local cam = workspace.CurrentCamera.CFrame
                local moveDir = char.Humanoid.MoveDirection 
                
                -- BURASI ÖNEMLİ: Hız her karede speeds[speedLevel] üzerinden okunur
                if moveDir.Magnitude > 0 then
                    bv.Velocity = moveDir * speeds[speedLevel]
                else
                    bv.Velocity = Vector3.new(0, 0, 0)
                end
                
                bg.CFrame = cam
            end
        end
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = false
        end
    end)
end

-- MENÜ BUTONLARI
local List = Instance.new("ScrollingFrame", MainFrame)
List.Size = UDim2.new(1, 0, 0.75, 0)
List.Position = UDim2.new(0, 0, 0.22, 0)
List.BackgroundTransparency = 1
List.ScrollBarThickness = 0
Instance.new("UIListLayout", List).HorizontalAlignment = "Center"

local function createMenuBtn(txt, func)
    local b = Instance.new("TextButton", List)
    b.Size = UDim2.new(0.85, 0, 0, 35)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(30,30,30)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = "GothamBold"
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

createMenuBtn("MENÜYÜ KAPAT", function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

createMenuBtn("SCRİPTİ SİL", function()
    ScreenGui:Destroy()
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

-- BAŞLIK
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Text = "SMX FLY HUB V1"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = "GothamBold"
Title.TextSize = 16

-- Animasyon
task.spawn(function()
    while true do
        Gradient.Rotation = Gradient.Rotation + 2
        OpenGradient.Rotation = OpenGradient.Rotation + 2
        local rainbow = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Stroke.Color = rainbow
        OpenStroke.Color = rainbow
        task.wait()
    end
end)
