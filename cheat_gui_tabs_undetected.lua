--[[
Cheat Roblox com Menu por Abas - Aimbot + ESP
Compatível com Ronix
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Configurações iniciais
local config = {
    Aimbot = false,
    AimbotMobile = false,
    ESP = false,
    TeamCheck = true,
    ShowFOVMobile = false,
    FOVRadius = 120,
    Smoothness = 0.2,
    ToggleKey = Enum.KeyCode.RightShift,
    ESP_Name = true,
    ESP_HeadDot = false,
    ESP_Box = false,
    ESP_Tracer = false,
    ESP_Health = false,
    Example1 = false,
    Example2 = false,
}

-- GUI base
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CheatMenuGUI"
ScreenGui.Parent = game:GetService("CoreGui") -- Necessário executor externo
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 400, 0, 420)
Main.Position = UDim2.new(0.5, -200, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
Main.Visible = false

-- Título
local Title = Instance.new("TextLabel")
Title.Text = "menu criado no chat lgbt"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 0, 140)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = Main

-- Abas
local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(1, -20, 0, 40)
Tabs.Position = UDim2.new(0, 10, 0, 60)
Tabs.BackgroundTransparency = 1
Tabs.Parent = Main

local function createTabButton(name, pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.Position = UDim2.new(pos, 0, 0, 0)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.Parent = Tabs
    return btn
end

local AimbotTabBtn = createTabButton("Aimbot", 0)
local ESPTabBtn = createTabButton("ESP", 1/3)
local OtherTabBtn = createTabButton("Outros", 2/3)

local TabsContent = {}
for _, name in ipairs({"Aimbot", "ESP", "Outros"}) do
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 1, -160)
    frame.Position = UDim2.new(0, 10, 0, 110)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    frame.Parent = Main

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = frame

    local hdr = Instance.new("TextLabel")
    hdr.Size = UDim2.new(1, 0, 0, 30)
    hdr.Text = name.." Settings"
    hdr.TextColor3 = Color3.fromRGB(0, 255, 140)
    hdr.Font = Enum.Font.GothamBold
    hdr.TextScaled = true
    hdr.BackgroundTransparency = 1
    hdr.Parent = frame

    TabsContent[name] = frame
end

local function showTab(t)
    for n, f in pairs(TabsContent) do
        f.Visible = (n == t)
    end
end
showTab("Aimbot")

local selectedColor = Color3.fromRGB(0, 255, 140)
local defaultColor = Color3.fromRGB(30, 30, 30)
local buttons = {AimbotTabBtn, ESPTabBtn, OtherTabBtn}
local function updateTabs(active)
    for _, b in ipairs(buttons) do
        b.BackgroundColor3 = (b == active) and selectedColor or defaultColor
    end
end
AimbotTabBtn.MouseButton1Click:Connect(function()
    showTab("Aimbot")
    updateTabs(AimbotTabBtn)
end)
ESPTabBtn.MouseButton1Click:Connect(function()
    showTab("ESP")
    updateTabs(ESPTabBtn)
end)
OtherTabBtn.MouseButton1Click:Connect(function()
    showTab("Outros")
    updateTabs(OtherTabBtn)
end)
updateTabs(AimbotTabBtn)

-- Funções GUI
local function createToggle(parent, text, var)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = defaultColor
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Text = text..": OFF"
    Btn.Font = Enum.Font.Gotham; Btn.TextScaled = true
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.Parent = parent
    Btn.MouseButton1Click:Connect(function()
        config[var] = not config[var]
        Btn.Text = text..": "..(config[var] and "ON" or "OFF")
    end)
end

local function createSlider(parent, text, var, min, max)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1,0,0,50)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0,20)
    label.Text = text..": "..config[var]
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Font = Enum.Font.Gotham
    label.TextScaled = true
    label.BackgroundTransparency = 1
    label.Parent = container

    local sf = Instance.new("Frame")
    sf.Position = UDim2.new(0,0,0,25)
    sf.Size = UDim2.new(1,0,0,10)
    sf.BackgroundColor3 = Color3.fromRGB(50,50,50)
    sf.Parent = container
    Instance.new("UICorner", sf).CornerRadius = UDim.new(0,4)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new((config[var]-min)/(max-min),0,1,0)
    knob.BackgroundColor3 = selectedColor
    knob.Parent = sf
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0,4)

    local dragging=false
    knob.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end
    end)
    knob.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType==Enum.UserInputType.MouseMovement then
            local rel = math.clamp((inp.Position.X - sf.AbsolutePosition.X)/sf.AbsoluteSize.X,0,1)
            config[var] = math.floor(min + rel*(max-min))
            knob.Size = UDim2.new(rel,0,1,0)
            label.Text = text..": "..config[var]
        end
    end)
end

-- Preenche abas
local ab=TabsContent["Aimbot"]
createToggle(ab,"Aimbot (PC)","Aimbot")
createToggle(ab,"Aimbot (Mobile)","AimbotMobile")
createToggle(ab,"Team Check","TeamCheck")
createToggle(ab,"Mostrar FOV Mobile","ShowFOVMobile")
createSlider(ab,"FOV Radius","FOVRadius",0,360)

local esp=TabsContent["ESP"]
createToggle(esp,"ESP Ativo","ESP")
createToggle(esp,"Mostrar Nome","ESP_Name")
createToggle(esp,"Head Dot","ESP_HeadDot")
createToggle(esp,"Box","ESP_Box")
createToggle(esp,"Tracer","ESP_Tracer")
createToggle(esp,"Mostrar Vida","ESP_Health")

local ot=TabsContent["Outros"]
createToggle(ot,"Exemplo 1","Example1")
createToggle(ot,"Exemplo 2","Example2")

-- Verifica se Drawing está disponível (necessário executor externo)
local Drawing = Drawing
if not Drawing or not Drawing.new then
    warn("Drawing API não disponível. ESP e FOV Circle não funcionarão.")
end

-- FOV Circle
local FOVCircle
if Drawing and Drawing.new then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness=2
    FOVCircle.Filled=false
    FOVCircle.Color=Color3.new(1,1,0)
    FOVCircle.Transparency=0.5
    FOVCircle.Visible=false
end

-- Função para encontrar o jogador mais próximo no FOV
local function getClosest(isMobile)
    local closestPlayer = nil
    local closestDistance = config.FOVRadius
    local mousePos = isMobile and Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2) or UIS:GetMouseLocation()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            if not config.TeamCheck or player.Team ~= LocalPlayer.Team then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if dist < closestDistance then
                            closestDistance = dist
                            closestPlayer = player
                        end
                    end
                end
            end
        end
    end
    return closestPlayer
end

-- ESP Drawing tables
local ESPObjects = {}

local function createESP(player)
    if not Drawing or not Drawing.new then return end
    local espData = {}

    espData.Name = Drawing.new("Text")
    espData.Name.Center = true
    espData.Name.Outline = true
    espData.Name.Color = Color3.new(1, 1, 1)
    espData.Name.Text = player.Name

    espData.Box = Drawing.new("Square")
    espData.Box.Color = Color3.new(0, 1, 0)
    espData.Box.Thickness = 2
    espData.Box.Filled = false

    espData.Tracer = Drawing.new("Line")
    espData.Tracer.Color = Color3.new(1, 1, 1)
    espData.Tracer.Thickness = 1

    ESPObjects[player] = espData
end

local function removeESP(player)
    if ESPObjects[player] then
        for _, obj in pairs(ESPObjects[player]) do
            if obj and obj.Remove then
                obj:Remove()
            end
        end
        ESPObjects[player] = nil
    end
end

local function updateESP()
    if not Drawing or not Drawing.new then return end
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local head = player.Character:FindFirstChild("Head")
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if head and root then
                local espData = ESPObjects[player]
                if not espData then
                    createESP(player)
                    espData = ESPObjects[player]
                end

                local headPos, onScreenHead = Camera:WorldToViewportPoint(head.Position)
                local rootPos, onScreenRoot = Camera:WorldToViewportPoint(root.Position)

                if onScreenHead and onScreenRoot then
                    local height = math.abs(headPos.Y - rootPos.Y)
                    local width = height / 2

                    -- Caixa
                    espData.Box.Visible = config.ESP_Box
                    espData.Box.Size = Vector2.new(width, height)
                    espData.Box.Position = Vector2.new(rootPos.X - width / 2, rootPos.Y - height / 2)

                    -- Nome
                    espData.Name.Visible = config.ESP_Name
                    espData.Name.Position = Vector2.new(headPos.X, headPos.Y - 20)

                    -- Tracer
                    espData.Tracer.Visible = config.ESP_Tracer
                    espData.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    espData.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)

                else
                    -- Se estiver fora da tela, oculta
                    espData.Box.Visible = false
                    espData.Name.Visible = false
                    espData.Tracer.Visible = false
                end

                -- Cor por team check (verde se inimigo, cinza se time)
                local color = Color3.new(0, 1, 0)
                if config.TeamCheck and player.Team == LocalPlayer.Team then
                    color = Color3.new(0.5, 0.5, 0.5)
                end
                espData.Box.Color = color
                espData.Name.Color = color
                espData.Tracer.Color = color
            else
                removeESP(player)
            end
        else
            removeESP(player)
        end
    end
end

-- Toggle para mostrar/ocultar o menu com RightShift
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == config.ToggleKey then
        Main.Visible = not Main.Visible
    end
end)

-- Loop principal
RunService.RenderStepped:Connect(function()
    if not LocalPlayer.Character or not Camera then return end

    -- Aimbot
    if config.Aimbot then
        local target = getClosest(false)
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos = target.Character.Head.Position
            local camPos = Camera.CFrame.Position
            local direction = (headPos - camPos).Unit
            local currentCF = Camera.CFrame
            local newCF = CFrame.new(camPos, camPos + direction)
            Camera.CFrame = currentCF:Lerp(newCF, config.Smoothness)
        end
    end

    -- Círculo FOV
    if config.Aimbot and FOVCircle then
        FOVCircle.Visible = true
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        FOVCircle.Radius = config.FOVRadius
        FOVCircle.Color = Color3.new(1, 1, 0)
    elseif FOVCircle then
        FOVCircle.Visible = false
    end

    -- Atualiza ESP
    if config.ESP then
        updateESP()
    else
        -- Remove todos os desenhos quando ESP desligado
        for player, _ in pairs(ESPObjects) do
            removeESP(player)
        end
    end
end)
