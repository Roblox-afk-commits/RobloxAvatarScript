local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Elite Hub V2 | Delta Mobile",
   LoadingTitle = "Yükleniyor...",
   LoadingSubtitle = "by Ozcan",
   ConfigurationSaving = { Enabled = true, FolderName = "EliteHubConfig" }
})

-- --- BROOKHAVEN SEKMESİ ---
local BH_Tab = Window:CreateTab("Brookhaven 🏡", 4483362458)

-- Kaliteli Fly GUI (Alternatif Çalışan Versiyon)
BH_Tab:CreateButton({
   Name = "Gelişmiş Fly GUI Aç",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
   end,
})

BH_Tab:CreateToggle({
   Name = "Infinite Jump (Sınırsız Zıplama)",
   CurrentValue = false,
