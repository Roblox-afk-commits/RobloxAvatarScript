-- Uçma Scripti Yükleyici (Delta Executor)
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- GUI Ayarları
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Buton Tasarımı
ToggleButton.Name = "FlyLoaderButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleButton.Position = UDim2.new(0.5, -50, 0.2, 0) -- Ekranın üst orta kısmında durur
ToggleButton.Size = UDim2.new(0, 100, 0, 45)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "FLY AÇ"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14.0
ToggleButton.Draggable = true -- Butonu ekranda istediğin yere sürükleyebilirsin

UICorner.Parent = ToggleButton

-- BUTONA BASILDIĞINDA ÇALIŞACAK KISIM
ToggleButton.MouseButton1Click:Connect(function()
    print("Fly Scripti Yukleniyor...")
    
    -- Buraya açılmasını istediğin scriptin kodunu koymalısın.
    -- Örnek olarak en popüler ve stabil olan fly scriptlerinden birini ekledim:
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()

    -- Script açıldıktan sonra butonun kapanmasını istiyorsan alttaki satırı bırak, istemiyorsan sil:
    ScreenGui:Destroy() 
end)
