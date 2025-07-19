-- Script para jumpscare em Roblox
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local jumpscareGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local image = Instance.new("ImageLabel", jumpscareGui)
local sound = Instance.new("Sound", player:WaitForChild("PlayerGui"))

-- Configura imagem
image.Size = UDim2.new(1,0,1,0)
image.Position = UDim2.new(0,0,0,0)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://ID_DA_SUA_IMAGEM_DE_SUSTO"
image.Visible = false

-- Configura som
sound.SoundId = "rbxassetid://ID_DO_SOM_DE_SUSTO"
sound.Volume = 10 -- volume máximo dentro do jogo

-- Função do susto
wait(5) -- espera 5 segundos antes do susto (pode mudar)
image.Visible = true
sound:Play()
wait(2)
image.Visible = false
