
--[[ Cheat Roblox - GUI com Aimbot, ESP, FOV, Speed Hack e Toggle por Tecla ]]
-- Funciona para PC e Celular (Mobile Support)
-- Salva configurações localmente

--// Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--// Configurações iniciais
local config = {
    Aimbot = false,
    ESP = false,
    SpeedHack = false,
    FOVRadius = 100,
    Smoothness = 0.2,
    ToggleKey = Enum.KeyCode.RightShift,
    SpeedValue = 50
}

--// Carregar configurações locais
pcall(function()
    local saved = readfile and readfile("cheat_config.json")
    if saved then
        local decoded = game:GetService("HttpService"):JSONDecode(saved)
        for k, v in pairs(decoded) do config[k] = v end
    end
end)

--// Salvar configurações
local function saveConfig()
    if writefile then
        writefile("cheat_config.json", game:GetService("HttpService"):JSONEncode(config))
    end
end

--// GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "CheatGui"
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 250)
Frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0

local UIList = Instance.new("UIListLayout", Frame)
UIList.Padding = UDim.new(0, 5)

local function createToggle(name, prop)
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.Position = UDim2.new(0, 5, 0, 0)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.new(1,1,1)
    Button.Text = name .. ": OFF"
    Button.MouseButton1Click:Connect(function()
        config[prop] = not config[prop]
        Button.Text = name .. ": " .. (config[prop] and "ON" or "OFF")
        saveConfig()
    end)
end

createToggle("Aimbot", "Aimbot")
createToggle("ESP", "ESP")
createToggle("Speed Hack", "SpeedHack")

--// FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Radius = config.FOVRadius
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Color = Color3.new(1, 1, 1)
FOVCircle.Transparency = 0.5

RunService.RenderStepped:Connect(function()
    local pos = UserInputService:GetMouseLocation()
    FOVCircle.Position = Vector2.new(pos.X, pos.Y)
    FOVCircle.Visible = config.Aimbot
end)

--// Aimbot função
local function getClosest()
    local closest, dist = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(plr.Character.Head.Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if mag < config.FOVRadius and mag < dist then
                    closest = plr
                    dist = mag
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if config.Aimbot then
        local target = getClosest()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos = target.Character.Head.Position
            local cam = workspace.CurrentCamera
            local direction = (headPos - cam.CFrame.Position).Unit
            local newCF = CFrame.new(cam.CFrame.Position, cam.CFrame.Position + direction:Lerp((headPos - cam.CFrame.Position).Unit, config.Smoothness))
            cam.CFrame = newCF
        end
    end
end)

--// ESP
local function createESP(player)
    local box = Drawing.new("Text")
    box.Size = 14
    box.Color = Color3.new(1, 1, 1)
    box.Outline = true
    box.Center = true

    local function update()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            box.Position = Vector2.new(pos.X, pos.Y)
            box.Visible = onScreen and config.ESP
            box.Text = player.Name
        else
            box.Visible = false
        end
    end

    RunService.RenderStepped:Connect(update)
end

Players.PlayerAdded:Connect(createESP)
for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        createESP(plr)
    end
end

--// Speed Hack
RunService.Stepped:Connect(function()
    if config.SpeedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = config.SpeedValue
    end
end)

--// Toggle visibilidade do menu
local minimized = false
UserInputService.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == config.ToggleKey then
        minimized = not minimized
        Frame.Visible = not minimized
    end
end)
