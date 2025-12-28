-- SMX FLY HUB V1 (SERT KONTROL - ANLIK TEPKİ)
local lp = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local runService = game:GetService("RunService")

local flying = false
local speedLevel = 1
local speeds = {30, 50, 80, 110, 150, 200, 260, 330, 420, 550}

-- ANA PANEL
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

-- AÇMA BUTONU
local OpenBtn = Instance.new("TextButton", ScreenGui)
local OpenCorner = Instance.new("UICorner", OpenBtn)
local OpenStroke = Instance.new("UIStroke", OpenBtn)
local OpenGradient = Instance.new("UIGradient", OpenBtn)
OpenBtn.Size = UDim2.new(0, 60, 0, 35)
OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
OpenBtn.Text = "AÇ"; OpenBtn.TextColor3 = Color3.new(1, 1, 1); OpenBtn.Font = "GothamBold"; OpenBtn.BackgroundColor3 = Color3.new(1, 1, 1); OpenBtn.Visible = false
OpenCorner.CornerRadius = UDim.new(0, 10); OpenStroke.Thickness = 2; OpenGradient.Color = Gradient.Color

-- ANLIK TEPKİ VEREN FLY SİSTEMİ
local function startFly()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bv.Velocity = Vector3.new(0, 0, 0)
    
    local bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.D = 10 -- "Soft" olmayı engellemek için sönümlemeyi düşürdük
    bg.P = 500000 -- Tepki hızını maksimuma çıkardık
    bg.CFrame = hrp.CFrame

    task.spawn(function()
        while flying and char.Parent and hum.Health > 0 do
            runService.RenderStepped:Wait()
            hum.PlatformStand = true
            local cam = workspace.CurrentCamera
            
            -- HAREKET (Kamera nereye, karakter oraya)
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 then
                -- Bu kısım karakteri kameranın tam baktığı dikey açıda uçurur
                bv.Velocity = (cam.CFrame.LookVector * (moveDir.Z * -1) + cam.CFrame.RightVector * moveDir.X).Unit * speeds[speedLevel]
            else
                bv.Velocity = Vector3.new(0, 0, 0)
            end
            
            -- SERT DÖNÜŞ: Karakter kameranın dikey (yukarı/aşağı) ve yatay açısına kilitlenir
            bg.CFrame = cam.CFrame
        end
        
        -- SIFIRLAMA
        bv:Destroy()
        bg:Destroy()
        if hum then
            hum.PlatformStand = false
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end

-- MENÜ ELEMANLARI
local List = Instance.new("ScrollingFrame", MainFrame)
List.Size = UDim2.new(1, 0, 0.75, 0); List.Position = UDim2.new(0, 0, 0.22, 0); List.BackgroundTransparency = 1; List.ScrollBarThickness = 0
Instance.new("UIListLayout", List).HorizontalAlignment = "Center"

local function createMenuBtn(txt, func)
    local b = Instance.new("TextButton", List)
    b.Size = UDim2.new(0.85, 0, 0, 35); b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(30,30,30); b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamBold"
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    b.MouseButton1Click:Connect(function() func(b) end)
    return b
end

createMenuBtn("FLY: KAPALI", function(b)
    flying = not flying
    if flying then 
        b.Text = "FLY: AKTİF"; b.BackgroundColor3 = Color3.fromRGB(0, 150, 0); startFly()
    else 
        b.Text = "FLY: KAPALI"; b.BackgroundColor3 = Color3.fromRGB(30,30,30) 
    end
end)

local SpeedFrame = Instance.new("Frame", List)
SpeedFrame.Size = UDim2.new(0.85, 0, 0, 40); SpeedFrame.BackgroundTransparency = 1
local sLabel = Instance.new("TextLabel", SpeedFrame)
sLabel.Size = UDim2.new(0.4, 0, 1, 0); sLabel.Position = UDim2.new(0.3, 0, 0, 0); sLabel.Text = "HIZ: 1"; sLabel.TextColor3 = Color3.new(1,1,1); sLabel.Font = "GothamBold"; sLabel.BackgroundTransparency = 1

local function adjust(t, p, v)
    local b = Instance.new("TextButton", SpeedFrame)
    b.Size = UDim2.new(0.25, 0, 0.8, 0); b.Position = p; b.Text = t; b.BackgroundColor3 = Color3.fromRGB(50,50,50); b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() speedLevel = math.clamp(speedLevel + v, 1, 10); sLabel.Text = "HIZ: " .. speedLevel end)
end
adjust("-", UDim2.new(0,0,0.1,0), -1); adjust("+", UDim2.new(0.75,0,0.1,0), 1)

createMenuBtn("MENÜYÜ KAPAT", function() MainFrame.Visible = false; OpenBtn.Visible = true end)
createMenuBtn("SCRİPTİ SİL", function() ScreenGui:Destroy() end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; OpenBtn.Visible = false end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.2, 0); Title.Text = "SMX FLY HUB V1"; Title.TextColor3 = Color3.new(1, 1, 1); Title.Font = "GothamBold"; Title.BackgroundTransparency = 1

task.spawn(function()
    while true do
        Gradient.Rotation = Gradient.Rotation + 2; OpenGradient.Rotation = OpenGradient.Rotation + 2
        local rainbow = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Stroke.Color = rainbow; OpenStroke.Color = rainbow; task.wait()
    end
end)
