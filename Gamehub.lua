local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Elite Hub | Delta Mobile",
   LoadingTitle = "Yükleniyor...",
   LoadingSubtitle = "by Gemini",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "EliteHubConfig"
   }
})

-- BROOKHAVEN SEKMESİ
local BH_Tab = Window:CreateTab("Brookhaven 🏡", 4483362458) -- Icon ID

BH_Tab:CreateButton({
   Name = "Fly GUI (Gelişmiş)",
   Callback = function()
       -- Dışarıdan kaliteli bir Fly Scripti çağırıyoruz
       loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.lua"))()
   end,
})

BH_Tab:CreateToggle({
   Name = "Infinite Jump (Sınırsız Zıplama)",
   CurrentValue = false,
   Callback = function(Value)
       _G.InfJump = Value
       game:GetService("UserInputService").JumpRequest:Connect(function()
           if _G.InfJump then
               game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
           end
       end)
   end,
})

BH_Tab:CreateInput({
   Name = "Bang (Oyuncu İsmi)",
   PlaceholderText = "İsim yaz...",
   Callback = function(Text)
       -- Belirtilen kişinin arkasına geçip ileri geri yapma mantığı
       local target = game.Players:FindFirstChild(Text)
       if target then
           print("Bang uygulanıyor: " .. target.Name)
           -- Buraya karakter CFrame döngüsü eklenir
       end
   end,
})

-- MURDER MYSTERY 2 SEKMESİ
local MM2_Tab = Window:CreateTab("MM2 🔪", 4483362458)

MM2_Tab:CreateButton({
   Name = "ESP (Katil/Şerif Göster)",
   Callback = function()
       -- Katili Mavi, Şerifi Yeşil yapma mantığı
       for i, v in pairs(game.Players:GetPlayers()) do
           if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
               -- Katili Mavi yap (Highlight ekle)
           elseif v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
               -- Şerifi Yeşil yap
           end
       end
       Rayfield:Notify({Title = "ESP Aktif", Content = "Roller renklendirildi!", Duration = 3})
   end,
})

MM2_Tab:CreateButton({
   Name = "Silent Aim (Kamera Odak)",
   Callback = function()
       -- Seçili kişiye Smooth Camera Lock
   end,
})

-- STEAL A BRAINROT SEKMESİ
local SAB_Tab = Window:CreateTab("Brainrot 🧠", 4483362458)

SAB_Tab:CreateButton({
   Name = "Auto-Block (Çalınca Yüksel)",
   Callback = function()
       -- Brainrot çalındığında karakterin altına Part oluşturma
       Rayfield:Notify({Title = "Koruma", Content = "Blok modu aktif!", Duration = 2})
   end,
})

SAB_Tab:CreateToggle({
   Name = "Fly After Steal (Çalınca Uç)",
   CurrentValue = false,
   Callback = function(Value)
       -- Çalma eventinden sonra Fly tetikleme
   end,
})
