-- GAVATHUB V1 (FLY + ESP + INF JUMP)
local lp = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local runService = game:GetService("RunService")

local flying = false
local speed = 50
local infJump = false

-- TASARIM (MOR NEON & KOYU TEMA)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Position = UDim2.new(0.5, -110, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(170, 0, 255)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Text = "GAVATHUB V1"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = "GothamBold"
Title.BackgroundTransparency = 1

-- SCROLLING LIST
local List = Instance.new("ScrollingFrame", MainFrame)
List.Size = UDim2.new(1, 0, 0.8, 0)
List.Position = UDim2.new(0, 0, 0.18, 0)
List.BackgroundTransparency = 1
List.ScrollBarThickness = 0
Instance.new("UIListLayout", List).HorizontalAlignment = "Center"

-- BUTON OLUŞTURUCU
local function createBtn(name, callback)
    local btn = Instance.new("TextButton", List)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = "GothamBold"
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
end

-- 1. FLY (TAM İSTEDİĞİN GİBİ: KAMERA NEREYE, JOYSTICK ORAYA)
createBtn("FLY: KAPALI", function(btn)
    flying = not flying
    if flying then
        btn.Text = "FLY: AKTİF"
        btn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
        task.spawn(function()
            local char = lp.Character or lp.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            local bv = Instance.new("BodyVelocity", hrp)
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            
            while flying do
                runService.RenderStepped:Wait()
                local cam = workspace.CurrentCamera
                local moveDir = char.Humanoid.MoveDirection
                
                if moveDir.Magnitude > 0 then
                    -- Kamera açısını uçuşa dahil et (Yukarı bakınca yukarı uçar)
                    local direction = (cam.CFrame.LookVector * (moveDir.Z * -1) + cam.CFrame.RightVector * moveDir.X)
                    bv.Velocity = direction.Unit * speed
                else
                    bv.Velocity = Vector3.new(0,0,0)
                end
                char.Humanoid.PlatformStand = true
            end
            bv:Destroy()
            char.Humanoid.PlatformStand = false
        end)
    else
        btn.Text = "FLY: KAPALI"
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
end)

-- 2. ESP (RAKİPLERİ GÖRME)
createBtn("ESP: AKTİF ET", function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local highlight = Instance.new("Highlight", p.Character)
            highlight.FillColor = Color3.new(1, 0, 0)
            highlight.OutlineColor = Color3.new(1, 1, 1)
        end
    end
end)

-- 3. INFINITE JUMP
createBtn("INF JUMP: KAPALI", function(btn)
    infJump = not infJump
    btn.Text = infJump and "INF JUMP: AKTİF" or "INF JUMP: KAPALI"
    btn.BackgroundColor3 = infJump and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(30, 30, 30)
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJump then
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- MENÜ KAPATMA
createBtn("SCRİPTİ SİL", function() ScreenGui:Destroy() end)

-- GÖKKUŞAĞI KENARLIK
task.spawn(function()
    while true do
        Stroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        task.wait()
    end
end)
