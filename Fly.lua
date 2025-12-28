-- Gavathub Universal Script
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("gavathub - Roblox Power", "Ocean")

-- ANA SEKME
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Karakter Özellikleri")

-- SPEED (Hız)
MainSection:NewSlider("Yürüme Hızı", "Hızını ayarlar", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

-- JUMP (Zıplama Gücü)
MainSection:NewSlider("Zıplama Gücü", "Zıplama yüksekliğini ayarlar", 500, 50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

-- INFINITE JUMP (Sınırsız Zıplama)
MainSection:NewToggle("Sınırsız Zıplama", "Havada zıplamanı sağlar", function(state)
    _G.infinjump = state
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.infinjump then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
        end
    end)
end)

-- FLY (Uçma)
MainSection:NewButton("Fly (Uçma - E Tuşu)", "E'ye basınca uçar", function()
    -- Basit Fly Script Entegresi
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
end)

-- ESP (Oyuncuları Görme)
local Visuals = Window:NewTab("Visuals")
local VisualsSection = Visuals:NewSection("Görünürlük")

VisualsSection:NewButton("ESP (Wallhack)", "Duvar arkasından oyuncuları görürsün", function()
    -- Basit ESP Scripti
    local function createESP(player)
        local highlight = Instance.new("Highlight")
        highlight.Name = "GavathubESP"
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
        highlight.Parent = player.Character
    end
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            createESP(v)
        end
    end
end)
