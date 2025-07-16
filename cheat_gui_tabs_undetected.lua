--[[
Cheat Roblox com Menu por Abas - Aimbot + ESP + Outros
Desenvolvido para testes de anticheat
]]

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Configurações
local config = {
    Aimbot = false,
    AimbotMobile = false,
    ESP = false,
    TeamCheck = true,            -- Toggle para checagem de time
    ShowFOVMobile = false,       -- Toggle para mostrar FOV no mobile
    FOVRadius = 120,
    Smoothness = 0.2,
    ToggleKey = Enum.KeyCode.RightShift
}

-- GUI base
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "CheatMenuGUI"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 350)
Main.Position = UDim2.new(0.5, -200, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- Título
local Title = Instance.new("TextLabel", Main)
Title.Text = "🎮 Roblox Cheat Menu"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 255, 140)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- Abas
local Tabs = Instance.new("Frame", Main)
Tabs.Size = UDim2.new(1, 0, 0, 35)
Tabs.Position = UDim2.new(0, 0, 0, 40)
Tabs.BackgroundTransparency = 1

local function createTabButton(name, pos)
    local btn = Instance.new("TextButton", Tabs)
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.Position = UDim2.new(0, pos, 0, 0)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local AimbotTabBtn = createTabButton("Aimbot", 10)
local ESPTabBtn = createTabButton("ESP", 140)
local OtherTabBtn = createTabButton("Outros", 270)

-- Conteúdo das Abas
local TabsContent = {}
for _, name in ipairs({"Aimbot", "ESP", "Outros"}) do
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(1, -20, 1, -85)
    frame.Position = UDim2.new(0, 10, 0, 80)
    frame.BackgroundTransparency = 1
    frame.Visible = false

    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    TabsContent[name] = frame
end

local function showTab(tabName)
    for name, frame in pairs(TabsContent) do
        frame.Visible = (name == tabName)
    end
end

AimbotTabBtn.MouseButton1Click:Connect(function() showTab("Aimbot") end)
ESPTabBtn.MouseButton1Click:Connect(function() showTab("ESP") end)
OtherTabBtn.MouseButton1Click:Connect(function() showTab("Outros") end)
showTab("Aimbot")

-- Criar Toggle
local function createToggle(parent, text, var)
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Text = text .. ": OFF"
    Btn.Font = Enum.Font.Gotham
    Btn.TextScaled = true
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(function()
        config[var] = not config[var]
        Btn.Text = text .. ": " .. (config[var] and "ON" or "OFF")
    end)
    return Btn
end

-- Criar Slider
local function createSlider(parent, text, var, min, max)
    local label = Instance.new("TextLabel", parent)
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Text = text .. ": " .. config[var]
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextScaled = true
    label.BackgroundTransparency = 1

    local sliderFrame = Instance.new("Frame", parent)
    sliderFrame.Size = UDim2.new(1, 0, 0, 10)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 4)

    local knob = Instance.new("Frame", sliderFrame)
    knob.Size = UDim2.new(0, 10, 1, 0)
    knob.Position = UDim2.new((config[var] - min) / (max - min), -5, 0, 0)
    knob.BackgroundColor3 = Color3.fromRGB(0, 255, 140)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local dragging = false
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    knob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
            config[var] = math.floor(min + rel * (max - min))
            knob.Position = UDim2.new(rel, -5, 0, 0)
            label.Text = text .. ": " .. config[var]
        end
    end)

    return label, knob
end

-- Adicionando toggles na aba Aimbot
createToggle(TabsContent["Aimbot"], "Aimbot (PC)", "Aimbot")
createToggle(TabsContent["Aimbot"], "Aimbot (Mobile)", "AimbotMobile")
createToggle(TabsContent["Aimbot"], "Team Check", "TeamCheck")
createToggle(TabsContent["Aimbot"], "Mostrar FOV Mobile", "ShowFOVMobile")

-- Slider de FOV (0 a 360)
createSlider(TabsContent["Aimbot"], "FOV Radius", "FOVRadius", 0, 360)

-- Toggle ESP na aba ESP
createToggle(TabsContent["ESP"], "ESP Ativo", "ESP")

-- Círculo de FOV para desenhar na tela
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Color = Color3.new(1, 1, 0)
FOVCircle.Transparency = 0.5

-- Função para encontrar o inimigo mais próximo dentro do FOV
local function getClosest(isMobile)
    local closest, dist = nil, config.FOVRadius
    local mousePos = isMobile and Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) or UIS:GetMouseLocation()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            if config.TeamCheck and plr.Team == LocalPlayer.Team then
                -- Ignorar se TeamCheck ativo e estiver no mesmo time
                continue
            end

            local pos, onScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if mag < dist then
                    closest = plr
                    dist = mag
                end
            end
        end
    end
    return closest
end

-- Loop principal do aimbot e desenho do FOV
RunService.RenderStepped:Connect(function()
    local shouldShowFOV = (config.Aimbot and not config.AimbotMobile) or (config.AimbotMobile and config.ShowFOVMobile)
    FOVCircle.Visible = shouldShowFOV
    FOVCircle.Position = config.AimbotMobile and Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) or UIS:GetMouseLocation()
    FOVCircle.Radius = config.FOVRadius

    if config.Aimbot or config.AimbotMobile then
        local target = getClosest(config.AimbotMobile)
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos = target.Character.Head.Position
            local dir = (headPos - Camera.CFrame.Position).Unit
            local newCF = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + dir), config.Smoothness)
            Camera.CFrame = newCF
        end
    end
end)

-- ESP
local function createESP(plr)
    local bb = Instance.new("BillboardGui")
    bb.Name = "ESP_" .. plr.Name
    bb.Size = UDim2.new(0, 100, 0, 20)
    bb.AlwaysOnTop = true

    local text = Instance.new("TextLabel", bb)
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.fromRGB(0, 255, 140)
    text.TextScaled = true
    text.Text = plr.Name
    text.Font = Enum.Font.GothamBold

    coroutine.wrap(function()
        while plr and plr.Parent and config.ESP do
            if plr.Character and plr.Character:FindFirstChild("Head") then
                bb.Adornee = plr.Character.Head
                bb.Parent = plr.Character.Head
            end
            wait(1)
        end
        bb:Destroy()
    end)()
end

Players.PlayerAdded:Connect(createESP)
for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
        createESP(plr)
    end
end

-- Toggle para abrir/fechar menu
UIS.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == config.ToggleKey then
        Main.Visible = not Main.Visible
    end
end)
