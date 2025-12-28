-- DELTA MOBIL PRO - ID DESTEKLI AVATAR MENU
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local OpenButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 300)
MainFrame.Active = true

-- MOBIL SURUKLEME (DRAG)
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ScrollingFrame.Parent = MainFrame
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 3, 0)
UIListLayout.Parent = ScrollingFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 8)

local function AddButton(text, color, func)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollingFrame
    btn.Text = text
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13
    btn.MouseButton1Click:Connect(func)
end

local lp = game.Players.LocalPlayer

-- PARÇA DEĞİŞTİRME FONKSİYONU (MESH DESTEKLİ)
local function SetMesh(partName, meshId)
    local char = lp.Character
    local part = char:FindFirstChild(partName)
    if part and part:FindFirstChildOfClass("CharacterMesh") then
        part:FindFirstChildOfClass("CharacterMesh").MeshId = meshId
    elseif part then
        local newMesh = Instance.new("CharacterMesh")
        newMesh.Parent = char
        newMesh.BodyPart = Enum.BodyPart[partName]
        newMesh.MeshId = meshId
    end
end

-- BUTONLAR VE SENİN ID'LERİN
AddButton("HEADLESS (YÜZSÜZ)", Color3.fromRGB(50, 50, 50), function()
    local h = lp.Character:FindFirstChild("Head")
    if h then h.Transparency = 1; if h:FindFirstChild("face") then h.face.Transparency = 1 end end
end)

AddButton("GERÇEK KORBLOX (SAĞ)", Color3.fromRGB(0, 80, 200), function()
    SetMesh("RightLeg", "139607718")
end)

AddButton("GERÇEK ZOMBİ SOL", Color3.fromRGB(0, 150, 0), function()
    SetMesh("LeftLeg", "37754710")
end)

AddButton("ZOMBİ GÖVDE", Color3.fromRGB(50, 100, 50), function()
    SetMesh("Torso", "37754511")
end)

AddButton("KASLI VÜCUT", Color3.fromRGB(150, 100, 0), function()
    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.BodyTypeScale.Value = 1.2 end -- ID yerine scale kullandım daha garanti
end)

AddButton("KADIN İNCE BEL", Color3.fromRGB(200, 50, 150), function()
    local hum = lp.Character:FindFirstChildOfClass("Humanoid")
    if hum then 
        hum.BodyWidthScale.Value = 0.6 
        hum.BodyDepthScale.Value = 0.7
    end
end)

AddButton("MENÜYÜ GİZLE", Color3.fromRGB(150, 0, 0), function()
    MainFrame.Visible = false; OpenButton.Visible = true
end)

OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.new(0, 100, 0, 30); OpenButton.Position = UDim2.new(0, 10, 0.4, 0)
OpenButton.Text = "AÇ"; OpenButton.Visible = false
OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = true; OpenButton.Visible = false end)
