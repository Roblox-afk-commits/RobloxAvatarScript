-- SMX FLY HUB V1 (BASİT VE SERT DÖNÜŞ - JOYSTICK ODAKLI)
local lp = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local runService = game:GetService("RunService")

local flying = false
local speedLevel = 1
local speeds = {30, 50, 80, 115, 160, 210, 270, 340, 420, 550}

-- ANA PANEL (TASARIM SABİT)
local MainFrame = Instance.new("Frame", ScreenGui)
local Gradient = Instance.new("UIGradient", MainFrame)
local Stroke = Instance.new("UIStroke", MainFrame)
MainFrame.Size = UDim2.new(0, 200, 0, 280)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
Stroke.Thickness = 3; Stroke.ApplyStrokeMode = "Border"
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(85, 0, 127)),
    ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
}

-- AÇ BUTONU
local OpenBtn = Instance.new("TextButton", ScreenGui)
local OpenStroke = Instance.new("UIStroke", OpenBtn)
local OpenGradient = Instance.new("UIGradient", OpenBtn)
OpenBtn.Size = UDim2.new(0, 80, 0, 40); OpenBtn.Position = UDim2.new(0, 15, 0.5, -20)
OpenBtn.Text = "AÇ"; OpenBtn.TextColor3 = Color3.new(1, 1, 1); OpenBtn.Font = "GothamBold"; OpenBtn.BackgroundColor3 = Color3.new(1, 1, 1); OpenBtn.Visible = false 
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 10)
OpenStroke.Thickness = 2; OpenGradient.Color = Gradient.Color

-- EN BASİT VE SERT FLY MOTORU
local function startFly()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    local bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    local bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.P = 100000 -- Dönüş gücünü fulledim (Küt diye döner)

    task.spawn(function()
        while flying and char.Parent and hum.Health > 0 do
            runService.RenderStepped:Wait()
            hum.PlatformStand = true
            local cam = workspace.CurrentCamera
            local moveDir = hum.MoveDirection
            
            if moveDir.Magnitude > 0 then
                -- EN BASİT MANTIK: Joystick nereye, itiş oraya
                -- Kamera nereye bakıyorsa "İleri" orasıdır.
                local direction = (cam.CFrame:VectorToWorldSpace(Vector3.new(moveDir.X, 0, moveDir.Z)).Unit)
                
                -- Eğer dikey kontrol (yukarı/aşağı) isteniyorsa:
                -- İleri-Geri joystick hareketini kameranın LookVector'ı ile çarpıyoruz
                local look = cam.CFrame.LookVector
                local right = cam.CFrame.RightVector
                bv.Velocity = (look * (moveDir.Z * -1) + right * moveDir.X).Unit * speeds[speedLevel]
            else
                bv.Velocity = Vector3.new(0, 0, 0)
            end
            
            -- Karakter kameraya kilitli kalsın ki joystick "ileri"si kameranın "ileri"si olsun
            bg.CFrame = cam.CFrame
        end
        bv:Destroy(); bg:Destroy()
        if hum then hum.PlatformStand = false; hum:ChangeState(11) end
    end)
end

-- BUTONLAR
local List = Instance.new("ScrollingFrame", MainFrame)
List.Size = UDim2.new(1, 0, 0.8, 0); List.Position = UDim2.new(0, 0, 0.18, 0); List.BackgroundTransparency = 1; List.ScrollBarThickness = 0
Instance.new("UIListLayout", List).HorizontalAlignment = "Center"

local function createMenuBtn(txt, func)
    local b = Instance.new("TextButton", List)
    b.Size = UDim2.new(0.85, 0, 0, 35); b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(30,30,30); b.TextColor3 = Color3.new(1,1,1); b.Font = "GothamBold"
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() func(b) end)
end

createMenuBtn("FLY: KAPALI", function(b)
    flying = not flying
    if flying then b.Text = "FLY: AKTİF"; b.BackgroundColor3 = Color3.fromRGB(0, 150, 0); startFly()
    else b.Text = "FLY: KAPALI"; b.BackgroundColor3 = Color3.fromRGB(30,30,30) end
end)

local function adjust(t, p, v)
    local SpeedFrame = Instance.new("Frame", List); SpeedFrame.Size = UDim2.new(0.85, 0, 0, 40); SpeedFrame.BackgroundTransparency = 1
    local sLabel = Instance.new("TextLabel", SpeedFrame); sLabel.Size = UDim2.new(1, 0, 1, 0); sLabel.Text = "HIZ AYARI"; sLabel.TextColor3 = Color3.new(1,1,1); sLabel.Font = "GothamBold"; sLabel.BackgroundTransparency = 1
    -- Hız butonlarını basitleştirdim
end

createMenuBtn("HIZI ARTIR (+)", function() speedLevel = math.clamp(speedLevel + 1, 1, 10) end)
createMenuBtn("HIZI AZALT (-)", function() speedLevel = math.clamp(speedLevel - 1, 1, 10) end)
createMenuBtn("MENÜYÜ KAPAT", function() MainFrame.Visible = false; OpenBtn.Visible = true end)
createMenuBtn("SCRİPTİ SİL", function() ScreenGui:Destroy() end)

OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; OpenBtn.Visible = false end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.15, 0); Title.Text = "SMX FLY HUB V1"; Title.TextColor3 = Color3.new(1, 1, 1); Title.Font = "GothamBold"; Title.BackgroundTransparency = 1

task.spawn(function()
    while true do
        Gradient.Rotation = Gradient.Rotation + 2; OpenGradient.Rotation = OpenGradient.Rotation + 2
        local rainbow = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Stroke.Color = rainbow; OpenStroke.Color = rainbow; task.wait()
    end
end)
