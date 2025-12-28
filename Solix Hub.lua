local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local LaunchBtn = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")

-- Setup
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Ana Panel (Smooth & Rounded)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true -- Paneli ekranda sürükleyebilirsin

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Kenarlık (Outline/Glow)
UIStroke.Parent = MainFrame
UIStroke.Thickness = 3
UIStroke.Color = Color3.fromRGB(150, 0, 255)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Arka Plan Renk Geçişi (Animated Purple Gradient)
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 0, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(110, 0, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 0, 80))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- Başlık
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0.4, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "FLY LOADER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- Buton (Fly GUI V3 Başlatıcı)
LaunchBtn.Name = "LaunchBtn"
LaunchBtn.Parent = MainFrame
LaunchBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LaunchBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
LaunchBtn.Size = UDim2.new(0.8, 0, 0.35, 0)
LaunchBtn.Font = Enum.Font.GothamSemibold
LaunchBtn.Text = "FLY V3 AC"
LaunchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LaunchBtn.TextSize = 14

UICorner_2.CornerRadius = UDim.new(0, 8)
UICorner_2.Parent = LaunchBtn

--- SCRIPTI CALISTIRMA FONKSIYONU ---
LaunchBtn.MouseButton1Click:Connect(function()
    LaunchBtn.Text = "YUKLENIYOR..."
    wait(1)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/Source"))()
    MainFrame.Visible = false -- Yüklendiğinde menüyü kapatır
end)

--- RENK ANIMASYONU (MOR DÖNGÜSÜ) ---
task.spawn(function()
    local offset = 0
    while true do
        UIGradient.Offset = Vector2.new(0, math.sin(offset))
        UIStroke.Color = Color3.fromHSV(0.78 + (math.sin(offset) * 0.05), 0.8, 1) -- Hafif renk değişimi
        offset = offset + 0.03
        task.wait(0.01)
    end
end)
