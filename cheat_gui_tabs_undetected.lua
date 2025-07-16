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
}

-- GUI base
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "CheatMenuGUI"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 420)
Main.Position = UDim2.new(0.5, -200, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
Main.Visible = false

-- Título
local Title = Instance.new("TextLabel", Main)
Title.Text = "menu criado no chat lgbt"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 0, 140)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

-- Abas
local Tabs = Instance.new("Frame", Main)
Tabs.Size = UDim2.new(1, -20, 0, 40)
Tabs.Position = UDim2.new(0, 10, 0, 60)
Tabs.BackgroundTransparency = 1

local function createTabButton(name, pos)
    local btn = Instance.new("TextButton", Tabs)
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.Position = UDim2.new(pos, 0, 0, 0)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local AimbotTabBtn = createTabButton("Aimbot", 0)
local ESPTabBtn = createTabButton("ESP", 1/3)
local OtherTabBtn = createTabButton("Outros", 2/3)

local TabsContent = {}
for _, name in ipairs({"Aimbot", "ESP", "Outros"}) do
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(1, -20, 1, -160)
    frame.Position = UDim2.new(0, 10, 0, 110)
    frame.BackgroundTransparency = 1
    frame.Visible = false
    local layout = Instance.new("UIListLayout", frame)
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsContent[name] = frame

    local hdr = Instance.new("TextLabel", frame)
    hdr.Size = UDim2.new(1, 0, 0, 30)
    hdr.Text = name.." Settings"
    hdr.TextColor3 = Color3.fromRGB(0, 255, 140)
    hdr.Font = Enum.Font.GothamBold
    hdr.TextScaled = true
    hdr.BackgroundTransparency = 1
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
    local Btn = Instance.new("TextButton", parent)
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = defaultColor
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.Text = text..": OFF"
    Btn.Font = Enum.Font.Gotham; Btn.TextScaled = true
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function()
        config[var] = not config[var]
        Btn.Text = text..": "..(config[var] and "ON" or "OFF")
    end)
end

local function createSlider(parent, text, var, min, max)
    local container = Instance.new("Frame", parent); container.Size = UDim2.new(1,0,0,50); container.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", container)
    label.Size = UDim2.new(1,0,0,20); label.Text = text..": "..config[var]
    label.TextColor3 = Color3.fromRGB(255,255,255); label.Font = Enum.Font.Gotham; label.TextScaled = true; label.BackgroundTransparency = 1
    local sf = Instance.new("Frame", container); sf.Position = UDim2.new(0,0,0,25); sf.Size = UDim2.new(1,0,0,10); sf.BackgroundColor3 = Color3.fromRGB(50,50,50); Instance.new("UICorner", sf).CornerRadius = UDim.new(0,4)
    local knob = Instance.new("Frame", sf); knob.Size = UDim2.new((config[var]-min)/(max-min),0,1,0); knob.BackgroundColor3 = selectedColor; Instance.new("UICorner", knob).CornerRadius = UDim.new(0,4)
    local dragging=false
    knob.InputBegan:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
    knob.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
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

-- FOV e Aimbot
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness=2
FOVCircle.Filled=false
FOVCircle.Color=Color3.new(1,1,0)
FOVCircle.Transparency=0.5
FOVCircle.Visible=false

local function getClosest(isMobile)
    local closestPlayer = nil
    local closestDistance = config.FOVRadius
    local mousePos = isMobile and Vector2.new(Camera.ViewportSize.X
        
