-- Services 
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local PhysicsService = game:GetService("PhysicsService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rep = ReplicatedStorage
local rs = ReplicatedStorage

local LocalPlayer = Players.LocalPlayer
local localPlayer = LocalPlayer
local player = LocalPlayer
local Player = LocalPlayer


local character = player.Character or player.CharacterAdded:Wait()
local hrp = character and character:FindFirstChild("HumanoidRootPart")

local Camera = workspace.CurrentCamera


local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpecterV5Fuctions/SpecterFuctionsV5/refs/heads/main/SpecterLibraly_V5"))()

local Window = redzlib:MakeWindow({
    Title = "SpecterX | Brookhaven",
    SubTitle = "By Specter",
    SaveFolder = "specterx"
})

Window:AddMinimizeButton({	
    Button = { Image = "rbxassetid://94800455817009", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(0, 5) },
})

local Tab1 = Window:MakeTab({"Main", "rocket"})

Tab1:AddDiscordInvite({
     Name = "SpecterX",
     Description = "Entre no nosso Discord e acompanhe todas as atualizações do SpecterX.",
     Logo = "rbxassetid://94800455817009",
     Invite = "https://discord.gg/hdTw8KGb4Y",
})

local Section = Tab1:AddSection({"Informaçao"})

local Info = Tab1:AddParagraph({
    "Hey, " .. LocalPlayer.Name .. "!"
})

local Info = Tab1:AddParagraph({
    "Todas as atualizações estão no Discord."
})

local PlayerCount = Tab1:AddParagraph({
    Title = "Jogadores online:",
    Desc = tostring(#Players:GetPlayers())
})

task.spawn(function()
    while true do
        PlayerCount:SetDesc(tostring(#Players:GetPlayers()))
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        PlayerCount:SetText("Jogadores online: " .. tostring(#Players:GetPlayers()))
        task.wait(0.5)
    end
end)

Players.PlayerAdded:Connect(function()
    PlayerCount:SetText("Jogadores online: " .. tostring(#Players:GetPlayers()))
end)

Players.PlayerRemoving:Connect(function()
    PlayerCount:SetText("Jogadores online: " .. tostring(#Players:GetPlayers()))
end)

local executorName = "Executor desconhecido"

if identifyexecutor then
    local success, result = pcall(identifyexecutor)
    if success and result then
        executorName = result
    end
end

local Info = Tab1:AddParagraph({
    "Executor: " .. executorName
})

local Tab2 = Window:MakeTab({"Player", "user"})

local velocidadePadrao = 16

local SectionSpeed = Tab2:AddSection({"Speed"})

local speedSlider = Tab2:AddSlider({
    Name = "Velocidade do player",
    Min = 1,
    Max = 1000,
    Increase = 1,
    Default = 16,
    Callback = function(Value)
        velocidadeAtual = Value
    end
})

local speedButton = Tab2:AddButton({"Ativar Velocidade",function()
        local character = LocalPlayer.Character
        if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = velocidadeAtual
        end
    end
end
})

local jumpPadrao = 50

local SectionJump = Tab2:AddSection({"Power Jump"})

local jumpSlider = Tab2:AddSlider({
    Name = "Altura do pulo",
    Min = 10,
    Max = 1000,
    Increase = 1,
    Default = 50,
    Callback = function(Value)
        jumpAtual = Value
    end
})

local jumpButton = Tab2:AddButton({"Ativar Pulo", function()
    local character = LocalPlayer.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        humanoid.JumpPower = jumpAtual
    end
end})

local SectionNoClip = Tab2:AddSection({"Player Information"})

local startTime = os.clock()

local playerTemp = Tab2:AddParagraph({
    Title = "Tempo de uso:",
    Desc = "00:00:00"
})

local playerFPS = Tab2:AddParagraph({
    Title = "FPS:",
    Desc = "FPS: 0"
})

task.spawn(function()
    while true do
        local elapsed = math.floor(os.clock() - startTime)

        local hours = math.floor(elapsed / 3600)
        local minutes = math.floor((elapsed % 3600) / 60)
        local seconds = elapsed % 60

        local formattedTime = string.format("%02d:%02d:%02d", hours, minutes, seconds)

        playerTemp:SetDesc(formattedTime)
        task.wait(1)
    end
end)

task.spawn(function()
    local lastTime = os.clock()
    local frames = 0

    RunService.RenderStepped:Connect(function()
        frames += 1
        local currentTime = os.clock()

        if currentTime - lastTime >= 1 then
            local fps = math.floor(frames / (currentTime - lastTime))
            playerFPS:SetDesc("FPS: " .. fps)

            frames = 0
            lastTime = currentTime
        end
    end)
end)

local SectionNoClip = Tab2:AddSection({"No Clip"})

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local noclipAtivo = false
local noclipConnection

-- Função aplicar noclip
local function aplicarNoClip(char)
    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.CanTouch = false
            v.CanQuery = false
        end
    end
end

-- Função remover noclip
local function removerNoClip(char)
    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = true
            v.CanTouch = true
            v.CanQuery = true
        end
    end
end

-- Quando o player morrer / respawnar
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    char:WaitForChild("Humanoid")

    if noclipAtivo then
        task.wait(0.1)
        aplicarNoClip(char)
    end
end)

-- Toggle UI
local noClipToggle = Tab2:AddToggle({
    Name = "Ativar No Clip",
    Default = false
})

noClipToggle:Callback(function(Value)
    noclipAtivo = Value

    if noclipAtivo then
        aplicarNoClip(Character)

        noclipConnection = RunService.Heartbeat:Connect(function()
            if Character then
                aplicarNoClip(Character)
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end

        if Character then
            removerNoClip(Character)
        end
    end
end)


local Section = Tab2:AddSection({"Invisibilidade"})

Tab2:AddButton({"Ativar Invisibilidade", function(Value)
    loadstring(game:HttpGet("https://pastebin.com/raw/gJEmRtab"))()
end})

Tab2:AddButton({"Voltar normal", function(Value)
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ResetCharacterAppearance"):FireServer()
end})

local Tab3 = Window:MakeTab({"Teleport", "map"})

Tab3:AddButton({"Prança", function(Value)
hrp.CFrame = CFrame.new(7.12, 3.30, 34.65)
end})

Tab3:AddButton({"Banco", function(Value)
hrp.CFrame = CFrame.new(2.44, 3.50, 255.11)
end})

Tab3:AddButton({"Piscina da praça", function(Value)
hrp.CFrame = CFrame.new(13.74, 3.87, 133.32)
end})

Tab3:AddButton({"Escola", function(Value)
hrp.CFrame = CFrame.new(-305.96, 3.60, 212.04)
end})

Tab3:AddButton({"Hospital", function(Value)
hrp.CFrame = CFrame.new(-304.59, 3.48, 24.01)
end})

Tab3:AddButton({"Delegancia", function(Value)
hrp.CFrame = CFrame.new(-118.83, 3.49, 7.80)
end})

Tab3:AddButton({"Hotel", function(Value)
hrp.CFrame = CFrame.new(249.18, 3.60, 215.39)
end})

Tab3:AddButton({"Lanchonete", function(Value)
hrp.CFrame = CFrame.new(166.70, 4.50, 35.89)
end})

Tab3:AddButton({"Shopping", function(Value)
hrp.CFrame = CFrame.new(161.21, 3.60, -168.92)
end})

Tab3:AddButton({"Crenche", function(Value)
hrp.CFrame = CFrame.new(-126.75, 3.60, 131.53)
end})

Tab3:AddButton({"Apartamento 1", function(Value)
hrp.CFrame = CFrame.new(-42.31, 3.50, -121.11)
end})

Tab3:AddButton({"Apartamento 2", function(Value)
hrp.CFrame = CFrame.new(-36.51, 19.00, -127.52)
end})

Tab3:AddButton({"Apartamento VIP", function(Value)
hrp.CFrame = CFrame.new(-34.78, 35.00, -134.67)
end})

Tab3:AddButton({"Fliperama Arcade", function(Value)
hrp.CFrame = CFrame.new(-168.92, 3.42, -125.58)
end})

Tab3:AddButton({"Prefeitura", function(Value)
hrp.CFrame = CFrame.new(-354.94, 7.40, -104.12)
end})

Tab3:AddButton({"Corpo de bombeiros", function(Value)
hrp.CFrame = CFrame.new(-447.41, 3.50, -144.22)
end})

Tab3:AddButton({"Fazenda", function(Value)
hrp.CFrame = CFrame.new(-846.09, 3.00, -438.49)
end})

local Section = Tab3:AddSection({"Lugares Secretos"})

Tab3:AddButton({"Passagem Subterranea", function(Value)
hrp.CFrame = CFrame.new(-92.76, -10.70, 263.66)
end})

Tab3:AddButton({"Sala das cameras", function(Value)
hrp.CFrame = CFrame.new(-117.42, -27.50, 235.92)
end})

Tab3:AddButton({"Passagem aquatica", function(Value)
hrp.CFrame = CFrame.new(10.67, -9.98, 187.02)
end})

Tab3:AddButton({"Passagem do banco", function(Value)
hrp.CFrame = CFrame.new(21.56, 25.90, 248.61)
end})

Tab3:AddButton({"Passagem do hospital", function(Value)
hrp.CFrame = CFrame.new(-340.49, 16.58, 70.68)
end})

Tab3:AddButton({"Casa abandonada", function(Value)
hrp.CFrame = CFrame.new(1035.85, 5.50, 54.20)
end})

local Tab4 = Window:MakeTab({"Esp", "eye"})

local Section = Tab4:AddSection({"ESP"})

local ESP_Enabled = false
local Box_Enabled = true
local currentColor = Color3.fromRGB(255, 255, 255) -- cor padrão: branco
local ESP_Objects = {}
-- Remove ESP de um personagem específico
local function removeESP(player)
    local character = player.Character
    if not character then return end
    local highlight = character:FindFirstChild("SimpleESP")
    if highlight then highlight:Destroy() end
    local espInfo = character:FindFirstChild("ESP_Info")
    if espInfo then espInfo:Destroy() end
    for i = #ESP_Objects, 1, -1 do
        local obj = ESP_Objects[i]
        if obj.Character == character then
            if obj.Connection then obj.Connection:Disconnect() end
            table.remove(ESP_Objects, i)
        end
    end
end
-- Cria ESP para um jogador (ou atualiza se já existir)
local function createESP(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart", 5)
    local humanoid = character:WaitForChild("Humanoid", 5)
    if not hrp or not humanoid then return end
    -- Se já existe ESP, remove antes
    removeESP(player)
    -- Criar Highlight (box)
    local highlight = Instance.new("Highlight")
    highlight.Name = "SimpleESP"
    highlight.Adornee = character
    highlight.FillColor = currentColor
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Enabled = Box_Enabled -- <- agora depende apenas do toggle de box
    highlight.Parent = character
    -- Criar BillboardGui com texto
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Info"
    billboard.Size = UDim2.new(0, 200, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = character
    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = currentColor
    label.TextStrokeTransparency = 0.5
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = false
    label.TextSize = 20
    label.Text = ""
    -- Atualiza o texto do ESP a cada frame
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not character or not character.Parent then
            conn:Disconnect()
            return
        end
        local distance = math.floor((localPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
        local sitting = humanoid.Sit and "Sim" or "Não"
        local age = player.AccountAge
        label.Text = string.format(
            "%s\nDistância: %d\nIdade: %d dias\nSentado: %s",
            player.Name,
            distance,
            age,
            sitting
        )
        -- Atualizar visibilidade e cor
        highlight.Enabled = Box_Enabled -- <- somente Box_Enabled agora
        label.TextColor3 = currentColor
        highlight.FillColor = currentColor
        billboard.Enabled = ESP_Enabled -- <- texto ainda depende de ESP geral
    end)
    table.insert(ESP_Objects, {
        Character = character,
        Highlight = highlight,
        Billboard = billboard,
        Connection = conn
    })
end
-- Atualiza ESP para todos jogadores
local function updateAllESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            -- Verifica se já existe ESP para esse jogador
            local found = false
            for _, obj in pairs(ESP_Objects) do
                if obj.Character == player.Character then
                    -- Atualiza cores e visibilidade
                    obj.Highlight.Enabled = Box_Enabled
                    obj.Highlight.FillColor = currentColor
                    obj.Billboard.TextLabel.TextColor3 = currentColor
                    obj.Billboard.Enabled = ESP_Enabled
                    found = true
                    break
                end
            end
            -- Se não encontrou ESP existente, cria novo
            if not found then
                createESP(player)
            end
        end
    end
end
-- Monitora novos jogadores
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        createESP(player)
    end)
end)
-- Monitora jogadores já presentes
for _, player in pairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function()
        wait(1)
        createESP(player)
    end)
end
-- Toggle: Ativar ESP (texto, etc.)
Tab4:AddToggle({
    Name = "Ativar ESP",
    Default = false,
    Callback = function(state)
        ESP_Enabled = state
        updateAllESP()
    end
})
-- Toggle: Mostrar Box (Highlight)
Tab4:AddToggle({
    Name = "Mostrar Box",
    Default = false,
    Callback = function(state)
        Box_Enabled = state
        updateAllESP()
    end
})      
-- Lista de cores para dropdown
local colorList = {
    ["Vermelho"] = Color3.fromRGB(255, 0, 0),
    ["Verde"] = Color3.fromRGB(0, 255, 0),
    ["Azul"] = Color3.fromRGB(0, 0, 255),
    ["Amarelo"] = Color3.fromRGB(255, 255, 0),
    ["Laranja"] = Color3.fromRGB(255, 165, 0),
    ["Roxo"] = Color3.fromRGB(128, 0, 128),
    ["Rosa"] = Color3.fromRGB(255, 105, 180),
    ["Branco"] = Color3.fromRGB(255, 255, 255),
    ["Preto"] = Color3.fromRGB(0, 0, 0),
    ["Cinza"] = Color3.fromRGB(128, 128, 128),
    ["Ciano"] = Color3.fromRGB(0, 255, 255),
    ["Magenta"] = Color3.fromRGB(255, 0, 255),
    ["Limão"] = Color3.fromRGB(191, 255, 0),
    ["Verde-azulado"] = Color3.fromRGB(0, 128, 128),
    ["Bordô"] = Color3.fromRGB(128, 0, 0),
    ["Azul-marinho"] = Color3.fromRGB(0, 0, 128),
    ["Dourado"] = Color3.fromRGB(255, 215, 0),
    ["Prata"] = Color3.fromRGB(192, 192, 192),
    ["Marrom"] = Color3.fromRGB(139, 69, 19),
    ["Azul-céu"] = Color3.fromRGB(135, 206, 235),
    ["Oliva"] = Color3.fromRGB(128, 128, 0),
    ["Turquesa"] = Color3.fromRGB(64, 224, 208),
    ["Carmesim"] = Color3.fromRGB(220, 20, 60),
    ["Índigo"] = Color3.fromRGB(75, 0, 130),
    ["Menta"] = Color3.fromRGB(189, 252, 201),
    ["Coral"] = Color3.fromRGB(255, 127, 80),
    ["Bege"] = Color3.fromRGB(245, 245, 220),
    ["Lavanda"] = Color3.fromRGB(230, 230, 250),
    ["Pêssego"] = Color3.fromRGB(255, 218, 185),
    ["Salmão"] = Color3.fromRGB(250, 128, 114),
    ["Marfim"] = Color3.fromRGB(255, 255, 240),
    ["Carvão"] = Color3.fromRGB(54, 69, 79),
    ["Areia"] = Color3.fromRGB(194, 178, 128),
    ["Vinho"] = Color3.fromRGB(114, 47, 55),
    ["Roxo escuro"] = Color3.fromRGB(48, 25, 52),
    ["Verde-musgo"] = Color3.fromRGB(111, 139, 61),
    ["Aqua"] = Color3.fromRGB(0, 255, 255),
    ["Bronze"] = Color3.fromRGB(205, 127, 50),
    ["Âmbar"] = Color3.fromRGB(255, 191, 0),
    ["Verde-neon"] = Color3.fromRGB(57, 255, 20),
    ["Azul-gelo"] = Color3.fromRGB(173, 216, 230),
    ["Creme"] = Color3.fromRGB(255, 253, 208),
    ["Caramelo"] = Color3.fromRGB(210, 105, 30),
    ["Lilás"] = Color3.fromRGB(200, 162, 200),
    ["Rosa-choque"] = Color3.fromRGB(255, 20, 147),
    ["Verde-floresta"] = Color3.fromRGB(34, 139, 34),
    ["Cinza claro"] = Color3.fromRGB(211, 211, 211),
    ["Cinza escuro"] = Color3.fromRGB(64, 64, 64),
}



local colorNames = {}
for name, _ in pairs(colorList) do
    table.insert(colorNames, name)
end

Tab4:AddDropdown({
    Name = "Cor do ESP",
    Options = colorNames,
    Default = "Branco",
    Flag = "ESPColor",
    Callback = function(selected)
        local color = colorList[selected]
        if color then
            currentColor = color
            updateAllESP()
        end
    end
})

-- Esp Car

local Section = Tab4:AddSection({"ESP Car"})

local ESPAtivado = false
local vehiclesFolder = workspace:WaitForChild("Vehicles")
local localPlayer = game.Players.LocalPlayer
local connection = nil
local corAtual = Color3.fromRGB(255, 255, 255) -- branco padrão

local colorcarlist = {
    ["Vermelho"] = Color3.fromRGB(255, 0, 0),
    ["Verde"] = Color3.fromRGB(0, 255, 0),
    ["Azul"] = Color3.fromRGB(0, 0, 255),
    ["Amarelo"] = Color3.fromRGB(255, 255, 0),
    ["Laranja"] = Color3.fromRGB(255, 165, 0),
    ["Roxo"] = Color3.fromRGB(128, 0, 128),
    ["Rosa"] = Color3.fromRGB(255, 105, 180),
    ["Branco"] = Color3.fromRGB(255, 255, 255),
    ["Preto"] = Color3.fromRGB(0, 0, 0),
    ["Cinza"] = Color3.fromRGB(128, 128, 128),
    ["Ciano"] = Color3.fromRGB(0, 255, 255),
    ["Magenta"] = Color3.fromRGB(255, 0, 255),
    ["Limão"] = Color3.fromRGB(191, 255, 0),
    ["Verde-azulado"] = Color3.fromRGB(0, 128, 128),
    ["Bordô"] = Color3.fromRGB(128, 0, 0),
    ["Azul-marinho"] = Color3.fromRGB(0, 0, 128),
    ["Dourado"] = Color3.fromRGB(255, 215, 0),
    ["Prata"] = Color3.fromRGB(192, 192, 192),
    ["Marrom"] = Color3.fromRGB(139, 69, 19),
    ["Azul-céu"] = Color3.fromRGB(135, 206, 235),
    ["Oliva"] = Color3.fromRGB(128, 128, 0),
    ["Turquesa"] = Color3.fromRGB(64, 224, 208),
    ["Carmesim"] = Color3.fromRGB(220, 20, 60),
    ["Índigo"] = Color3.fromRGB(75, 0, 130),
    ["Menta"] = Color3.fromRGB(189, 252, 201),
    ["Coral"] = Color3.fromRGB(255, 127, 80),
    ["Bege"] = Color3.fromRGB(245, 245, 220),
    ["Lavanda"] = Color3.fromRGB(230, 230, 250),
    ["Pêssego"] = Color3.fromRGB(255, 218, 185),
    ["Salmão"] = Color3.fromRGB(250, 128, 114),
    ["Marfim"] = Color3.fromRGB(255, 255, 240),
    ["Carvão"] = Color3.fromRGB(54, 69, 79),
    ["Areia"] = Color3.fromRGB(194, 178, 128),
    ["Vinho"] = Color3.fromRGB(114, 47, 55),
    ["Roxo escuro"] = Color3.fromRGB(48, 25, 52),
    ["Verde-musgo"] = Color3.fromRGB(111, 139, 61),
    ["Aqua"] = Color3.fromRGB(0, 255, 255),
    ["Bronze"] = Color3.fromRGB(205, 127, 50),
    ["Âmbar"] = Color3.fromRGB(255, 191, 0),
    ["Verde-neon"] = Color3.fromRGB(57, 255, 20),
    ["Azul-gelo"] = Color3.fromRGB(173, 216, 230),
    ["Creme"] = Color3.fromRGB(255, 253, 208),
    ["Caramelo"] = Color3.fromRGB(210, 105, 30),
    ["Lilás"] = Color3.fromRGB(200, 162, 200),
    ["Rosa-choque"] = Color3.fromRGB(255, 20, 147),
    ["Verde-floresta"] = Color3.fromRGB(34, 139, 34),
    ["Cinza claro"] = Color3.fromRGB(211, 211, 211),
    ["Cinza escuro"] = Color3.fromRGB(64, 64, 64),
}

local function extrairNomeJogador(nomeModelo)
    return nomeModelo:gsub("Car$", ""):gsub("Horse$", "")
end

local function criarHighlightEInfo(modelo)
    if not modelo:IsA("Model") then return end
    if modelo:FindFirstChild("CarESP") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "CarESP"
    highlight.FillColor = corAtual
    highlight.OutlineColor = corAtual
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Adornee = modelo
    highlight.Parent = modelo

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "InfoESP"
    billboard.Adornee = modelo.PrimaryPart or modelo:FindFirstChildWhichIsA("BasePart") or modelo:FindFirstChildWhichIsA("MeshPart")
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 150, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.Parent = modelo

    local nameLabel = Instance.new("TextLabel")
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = 20
    nameLabel.TextColor3 = corAtual
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextWrapped = false
    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
    nameLabel.TextYAlignment = Enum.TextYAlignment.Center
    nameLabel.Parent = billboard

    local distLabel = Instance.new("TextLabel")
    distLabel.BackgroundTransparency = 1
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.Font = Enum.Font.SourceSansBold
    distLabel.TextSize = 20
    distLabel.TextColor3 = corAtual
    distLabel.TextStrokeTransparency = 0.5
    distLabel.TextWrapped = false
    distLabel.TextXAlignment = Enum.TextXAlignment.Center
    distLabel.TextYAlignment = Enum.TextYAlignment.Center
    distLabel.Parent = billboard

    spawn(function()
        while ESPAtivado and modelo.Parent do
            local nomeJogador = extrairNomeJogador(modelo.Name)
            local distancia = 0
            if localPlayer.Character and localPlayer.Character.PrimaryPart and billboard.Adornee then
                distancia = math.floor((billboard.Adornee.Position - localPlayer.Character.PrimaryPart.Position).Magnitude)
            end
            nameLabel.Text = nomeJogador
            distLabel.Text = "Distância: " .. distancia
            task.wait(0.1)
        end
        if billboard and billboard.Parent then
            billboard:Destroy()
        end
    end)
end

local function ativarESP()
    for _, carro in pairs(vehiclesFolder:GetChildren()) do
        criarHighlightEInfo(carro)
    end

    connection = vehiclesFolder.ChildAdded:Connect(function(carro)
        task.wait(0.1)
        criarHighlightEInfo(carro)
    end)
end

local function desativarESP()
    if connection then
        connection:Disconnect()
        connection = nil
    end

    for _, carro in pairs(vehiclesFolder:GetChildren()) do
        local highlight = carro:FindFirstChild("CarESP")
        if highlight then highlight:Destroy() end

        local billboard = carro:FindFirstChild("InfoESP")
        if billboard then billboard:Destroy() end
    end
end

local function atualizarCoresESP(cor)
    for _, modelo in pairs(vehiclesFolder:GetChildren()) do
        if modelo:IsA("Model") then
            local highlight = modelo:FindFirstChild("CarESP")
            local billboard = modelo:FindFirstChild("InfoESP")
            if highlight then
                highlight.FillColor = cor
                highlight.OutlineColor = cor
            end
            if billboard then
                local textLabelName = billboard:FindFirstChildOfClass("TextLabel")
                if textLabelName then
                    textLabelName.TextColor3 = cor
                end
                for _, child in ipairs(billboard:GetChildren()) do
                    if child:IsA("TextLabel") and child ~= textLabelName then
                        child.TextColor3 = cor
                    end
                end
            end
        end
    end
end

-- Toggle para ativar/desativar ESP
Tab4:AddToggle({
    Name = "ESP de Carros",
    Default = false,
    Callback = function(valor)
        ESPAtivado = valor
        if ESPAtivado then
            ativarESP()
        else
            desativarESP()
        end
    end
})

-- Dropdown para selecionar a cor do ESP
local dropdownCores = Tab4:AddDropdown({
    Name = "Selecionar Cor do ESP",
    Options = (function()
        local lista = {}
        for nomeCor in pairs(colorcarlist) do
            table.insert(lista, nomeCor)
        end
        table.sort(lista)
        return lista
    end)(),
    Default = "Branco",
    Flag = "dropdown_cor_esp",
    Callback = function(valor)
        corAtual = colorcarlist[valor] or colorcarlist["Branco"]
        atualizarCoresESP(corAtual)
    end
})

-- Define ZIndex alto para o dropdown ficar na frente do ESP 3D
local function setDropdownZIndex(guiObj)
    if guiObj and guiObj:IsA("GuiObject") then
        guiObj.ZIndex = 10
        for _, child in pairs(guiObj:GetChildren()) do
            setDropdownZIndex(child)
        end
    end
end

if dropdownCores and dropdownCores.GuiObject then
    setDropdownZIndex(dropdownCores.GuiObject)
end

local Tab5 = Window:MakeTab({"Troll", "users"})

local Section = Tab5:AddSection({"View/Goto"})

local selectedPlayer = nil
local viewing = false
local viewConnection = nil

-- Função para buscar jogador por nome ou nickname (DisplayName)
local function FindPlayerByPartialName(partial)
    partial = partial:lower()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local name = player.Name:lower()
            local displayName = (player.DisplayName or ""):lower()
            if name:find(partial) or displayName:find(partial) then
                return player
            end
        end
    end
    return nil
end

-- Função para notificação com opção de ícone
local function Notify(text, icon)
    StarterGui:SetCore("SendNotification", {
        Title = "Sistema",
        Text = text,
        Duration = 3,
        Icon = icon or nil,
    })
end

-- Guardar referência do TextBox para limpar depois
local nomeTextBox

nomeTextBox = Tab5:AddTextBox({ 
    Name = "Nome do Jogador",  
    PlaceholderText = "Ex: Specter", 
    Callback = function(Value)
        local found = FindPlayerByPartialName(Value)
        if found then
            selectedPlayer = found
            
            local success, thumbnailUrl = pcall(function()
                return Players:GetUserThumbnailAsync(found.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
            end)
            
            Notify("Jogador selecionado: " .. found.DisplayName, success and thumbnailUrl or nil)
            
            -- Limpar o TextBox discretamente
            if nomeTextBox then
                if typeof(nomeTextBox.SetText) == "function" then
                    nomeTextBox:SetText("")
                elseif nomeTextBox.TextBox and typeof(nomeTextBox.TextBox.SetText) == "function" then
                    nomeTextBox.TextBox:SetText("")
                elseif nomeTextBox.TextBox then
                    nomeTextBox.TextBox.Text = ""
                end
            end
        else
            Notify("Jogador não encontrado.")
        end
    end
})

Tab5:AddToggle({ 
    Name = "View", 
    Default = false,
    Callback = function(v)
        viewing = v
        if v and selectedPlayer then
            Notify("Visualizando: " .. selectedPlayer.DisplayName)
            local function onPlayerRemoving(player)
                if player == selectedPlayer then
                    Notify(selectedPlayer.DisplayName .. " saiu do jogo.")
                    
                    -- Apenas desconecta a visualização, sem alterar o toggle ou viewing
                    if viewConnection then
                        viewConnection:Disconnect()
                        viewConnection = nil
                    end

                    -- Reseta a câmera para o jogador local
                    if LocalPlayer.Character then
                        Camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid") 
                                              or LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                        Camera.CameraType = Enum.CameraType.Custom
                    end
                end
            end

            if playerRemovingConnection then
                playerRemovingConnection:Disconnect()
                playerRemovingConnection = nil
            end
            playerRemovingConnection = Players.PlayerRemoving:Connect(onPlayerRemoving)
            
            viewConnection = RunService.RenderStepped:Connect(function()
                if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Head") then
                    Camera.CameraSubject = selectedPlayer.Character.Head
                    Camera.CameraType = Enum.CameraType.Custom
                end
            end)
        else
            if viewConnection then
                viewConnection:Disconnect()
                viewConnection = nil
            end
            if playerRemovingConnection then
                playerRemovingConnection:Disconnect()
                playerRemovingConnection = nil
            end
            if LocalPlayer.Character then
                Camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                Camera.CameraType = Enum.CameraType.Custom
            end
        end
    end
})


Tab5:AddButton({
    Name = "Goto",
    Callback = function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:PivotTo(selectedPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0))
            Notify("Teleportado para: " .. selectedPlayer.DisplayName)
        else
            Notify("Jogador inválido.")
        end
    end
})

local Section = Tab5:AddSection({"Fling Ball"})

local function FlingBall(target)
    local Workspace = game:GetService("Workspace")
    local ServerBalls = Workspace.WorkspaceCom:WaitForChild("001_SoccerBalls")
    local toolRemote = ReplicatedStorage.RE:FindFirstChild("1Too1l")

    local backpack = player:WaitForChild("Backpack")
    local starterGear = player:WaitForChild("StarterGear")

    local function HasBall()
        return backpack:FindFirstChild("SoccerBall") or starterGear:FindFirstChild("SoccerBall")
    end

    local function GetBall()
        if not HasBall() and toolRemote then
            toolRemote:InvokeServer("PickingTools", "SoccerBall")
        end
        -- espera até a bola aparecer no Backpack ou Character
        repeat task.wait() until HasBall() or character:FindFirstChild("SoccerBall")
        local ballTool = backpack:FindFirstChild("SoccerBall") or character:FindFirstChild("SoccerBall")
        ballTool.Parent = character

        -- espera até a bola do Workspace aparecer
        repeat task.wait() until ServerBalls:FindFirstChild("Soccer" .. player.Name)
        character.SoccerBall.Parent = backpack
        return ServerBalls:FindFirstChild("Soccer" .. player.Name)
    end

    local Ball = ServerBalls:FindFirstChild("Soccer" .. player.Name) or GetBall()
    Ball.CanCollide = false
    Ball.Massless = true
    Ball.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0)

    if target ~= player then
        local tchar = target.Character
        if tchar and tchar:FindFirstChild("HumanoidRootPart") and tchar:FindFirstChild("Humanoid") then
            local troot = tchar.HumanoidRootPart
            local thum = tchar.Humanoid

            if Ball:FindFirstChildWhichIsA("BodyVelocity") then
                Ball:FindFirstChildWhichIsA("BodyVelocity"):Destroy()
            end

            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlingPower"
            bv.Velocity = Vector3.new(9e8, 2e9, 9e8)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.P = 9e900
            bv.Parent = Ball

            repeat
                if troot.Velocity.Magnitude > 0 then
                    local pos = troot.Position + (troot.Velocity / 1.5)
                    Ball.CFrame = CFrame.new(pos)
                    Ball.Orientation += Vector3.new(45, 60, 30)
                else
                    for _, v in pairs(tchar:GetChildren()) do
                        if v:IsA("BasePart") and v.CanCollide and not v.Anchored then
                            Ball.CFrame = v.CFrame
                            task.wait(1/6000)
                        end
                    end
                end
                
                if troot.Velocity.Magnitude >= 760 then
                    task.wait(0.1)
                    if character:FindFirstChild("SoccerBall") then
                        character.SoccerBall.Parent = backpack
                    end
                    if toolRemote then
                        toolRemote:InvokeServer("PickingTools", "SoccerBall")
                    end
                    break
                end

                task.wait(1/6000)
            until thum.Health <= 0 or not tchar:IsDescendantOf(Workspace) or target.Parent ~= Players
        end
    end
end

Tab5:AddButton({
    Name = "Fling Ball",
    Callback = function()
        if not selectedPlayer or not selectedPlayer.Character then
            warn("Nenhum jogador selecionado ou jogador inválido.")
            return
        end
        FlingBall(selectedPlayer)
    end
})

local Section = Tab5:AddSection({"Counch"})

Tab5:AddButton({
Name = "Fling Counch",
Callback = function()
    if not selectedPlayer then
            warn("Nenhum jogador selecionado!")
            return
    end

    -- Coloque aqui o script de fling com referência ao selectedPlayer
    local Backpack = Player:WaitForChild("Backpack")
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")

    local function HasCouch()
        return (Backpack:FindFirstChild("Couch") ~= nil) or (Character:FindFirstChild("Couch") ~= nil)
    end

    local function EquipCouch()
        local couchTool = Backpack:FindFirstChild("Couch") or Character:FindFirstChild("Couch")
        if couchTool then
            Humanoid:EquipTool(couchTool)
            return true
        end
        return false
    end

    if not HasCouch() then
        local remote = ReplicatedStorage.RE:FindFirstChild("1Too1l")
        if not remote then
            warn("Remote 1Too1l não encontrado!")
            return
        end

        local args = {
            [1] = "PickingTools",
            [2] = "Couch"
        }

        local success, err = pcall(function()
            remote:InvokeServer(unpack(args))
        end)
        if not success then
            warn("Erro ao invocar remote para equipar Couch:", err)
            return
        end

        local timeout = 5
        local waited = 0
        while not HasCouch() and waited < timeout do
            task.wait(0.1)
            waited += 0.1
        end

        if not HasCouch() then
            warn("Couch não apareceu após tentativa de equipar via remote.")
            return
        end
    end

    local equipped = EquipCouch()
    if not equipped then
        warn("Falha ao equipar Couch.")
        return
    end

    task.wait(0.5)

    local RootPart = Character:WaitForChild("HumanoidRootPart")
    getgenv().AllowFling = true

    local TargetPlayer = selectedPlayer
    if not TargetPlayer or not TargetPlayer.Character then
        return warn("Alvo inválido ou personagem não encontrado.")
    end

    local TCharacter = TargetPlayer.Character
    local THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    local TRootPart = THumanoid and THumanoid.RootPart
    local THead = TCharacter:FindFirstChild("Head")
    local Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    local Handle = Accessory and Accessory:FindFirstChild("Handle")
    local Seat = TCharacter:FindFirstChildWhichIsA("Seat", true)

    local BasePart = Seat or TRootPart or THead or Handle
    if not BasePart then
        return warn("Nenhuma parte válida do alvo encontrada.")
    end

    workspace.FallenPartsDestroyHeight = 0/0
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

    local BV = Instance.new("BodyVelocity")
    BV.Name = "FlingForce"
    BV.Parent = RootPart
    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
    BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

    local function FPos(BasePart, Pos, Ang)
        if not getgenv().AllowFling then return end
        local cf = BasePart.CFrame * Pos * Ang
        RootPart.CFrame = cf
        Character:SetPrimaryPartCFrame(cf)
        RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
        RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
    end

    task.spawn(function()
        local Angle = 0
        while getgenv().AllowFling and TargetPlayer.Parent == Players and BasePart:IsDescendantOf(TCharacter) do
            Angle += 100
            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
            task.wait()
            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
            task.wait()
            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
            task.wait()
        end
    end)
end
})

Tab5:AddButton({ "Bring Couch", function()

    -- ================= CHECK PLAYER =================
    if not selectedPlayer or not selectedPlayer.Character then
        return warn("Nenhum jogador selecionado ou personagem não carregado.")
    end

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    local LocalPlayer = Players.LocalPlayer
    local Backpack = LocalPlayer:WaitForChild("Backpack")
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local RootPart = Character:WaitForChild("HumanoidRootPart")
    local cam = workspace.CurrentCamera

    local TCharacter = selectedPlayer.Character
    local THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    local TRootPart = TCharacter:FindFirstChild("HumanoidRootPart")

    if not THumanoid or not TRootPart then
        return warn("Humanoid ou RootPart do alvo não encontrados.")
    end

    -- ================= SAVE POS =================
    local OldPos = RootPart.CFrame

    -- ================= GET COUCH =================
    local toolRemote = ReplicatedStorage.RE:FindFirstChild("1Too1l")
    if toolRemote then
        toolRemote:InvokeServer("PickingTools", "Couch")
    end
    task.wait(0.3)

    local Couch = Backpack:FindFirstChild("Couch")
    if Couch then
        Humanoid:EquipTool(Couch)
    else
        return warn("Falha ao obter Couch.")
    end

    -- ================= USE TOOL =================
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.1)

    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    Humanoid.PlatformStand = false
    cam.CameraSubject = TCharacter:FindFirstChild("Head") or TRootPart

    -- ================= BODY POSITION =================
    local BP = Instance.new("BodyPosition")
    BP.Name = "BringPosition"
    BP.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    BP.P = 30000
    BP.D = 10
    BP.Position = RootPart.Position
    BP.Parent = TRootPart

    -- ================= BRING LOOP =================
    task.spawn(function()
        local angle = 0
        local start = tick()

        while tick() - start < 5 do
            if not THumanoid or THumanoid.Health <= 0 then break end
            if THumanoid.Sit then break end

            angle += 50
            local predicted = TRootPart.Position + (TRootPart.Velocity / 1.5)

            RootPart.CFrame =
                CFrame.new(predicted + Vector3.new(0, 2, 0)) *
                CFrame.Angles(math.rad(angle), 0, 0)

            BP.Position = RootPart.Position + Vector3.new(2, 0, 0)
            task.wait()
        end

        -- ================= FINISH =================
        BP:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        cam.CameraSubject = Humanoid

        for _, p in ipairs(Character:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Velocity = Vector3.zero
                p.RotVelocity = Vector3.zero
            end
        end

        -- ================= RETURN POSITION =================
        task.wait(0.1)
        RootPart.Anchored = true
        RootPart.CFrame = OldPos
        task.wait(0.01)
        RootPart.Anchored = false

        task.wait(0.85)

        -- ================= REMOVE COUCH =================
        local couch = Character:FindFirstChild("Couch")
        if couch then
            couch.Parent = Backpack
        end

        task.wait(0.1)
        if toolRemote then
            toolRemote:InvokeServer("PickingTools", "Couch")
        end
    end)
end })

Tab5:AddButton({
    Name = "Kill Couch",
    Callback = function()

        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local VirtualInputManager = game:GetService("VirtualInputManager")
        local cam = workspace.CurrentCamera

        local LocalPlayer = Players.LocalPlayer
        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        local RootPart = Character:WaitForChild("HumanoidRootPart")
        local Backpack = LocalPlayer:WaitForChild("Backpack")

        -- 🔹 Usa o sistema antigo de seleção
        local TargetPlayer = selectedPlayer
        if not TargetPlayer or not TargetPlayer.Character then
            warn("Alvo inválido.")
            return
        end

        local TCharacter = TargetPlayer.Character
        local THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
        local TRootPart = TCharacter:FindFirstChild("HumanoidRootPart")

        if not THumanoid or not TRootPart then
            warn("Humanoid ou Root do alvo não encontrado.")
            return
        end

        -- 🔹 Salva posição original
        local OldCFrame = RootPart.CFrame
        local SitCFrame = CFrame.new(145.51, -350.09, 21.58)

        task.wait(0.2)

        -- 🔹 Pega Couch
        local toolRemote = ReplicatedStorage.RE:FindFirstChild("1Too1l")
        if toolRemote then
            toolRemote:InvokeServer("PickingTools", "Couch")
        end
        task.wait(0.3)

        local Couch = Backpack:FindFirstChild("Couch")
        if Couch then
            Humanoid:EquipTool(Couch)
        else
            warn("Couch não encontrado.")
            return
        end

        -- 🔹 Força uso do tool
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
        task.wait(0.1)

        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        Humanoid.PlatformStand = false
        cam.CameraSubject = TCharacter:FindFirstChild("Head") or TRootPart

        -- 🔹 BodyPosition para puxar
        local BP = Instance.new("BodyPosition")
        BP.Name = "BringPosition"
        BP.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BP.P = 30000
        BP.D = 10
        BP.Position = RootPart.Position
        BP.Parent = TRootPart

        -- 🔹 Loop principal
        task.spawn(function()
            local angle = 0
            local start = tick()

            while tick() - start < 5 do
                if not THumanoid or THumanoid.Health <= 0 then break end
                if THumanoid.Sit then break end

                angle += 50
                local predictPos = TRootPart.Position + (TRootPart.Velocity / 1.5)

                RootPart.CFrame =
                    CFrame.new(predictPos + Vector3.new(0, 2, 0)) *
                    CFrame.Angles(math.rad(angle), 0, 0)

                BP.Position = RootPart.Position + Vector3.new(2, 0, 0)
                task.wait()
            end

            -- 🔹 Finalização
            BP:Destroy()
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            cam.CameraSubject = Humanoid

            for _, v in ipairs(Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Velocity = Vector3.zero
                    v.RotVelocity = Vector3.zero
                end
            end

            task.wait(0.1)
            RootPart.CFrame = SitCFrame
            task.wait(0.3)

            local couch = Character:FindFirstChild("Couch")
            if couch then
                couch.Parent = Backpack
            end

            task.wait(0.1)
            if toolRemote then
                toolRemote:InvokeServer("PickingTools", "Couch")
            end

            task.wait(0.2)
            RootPart.CFrame = OldCFrame
        end)
    end
})

local Section = Tab5:AddSection({ "Car" })

Tab5:AddButton({"Fling bus", function(Value) 
    if not selectedPlayer then
        print("Nenhum jogador selecionado para flingar.")
        return
    end

    local Player = game.Players.LocalPlayer
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Vehicles = workspace:FindFirstChild("Vehicles")
    local OldPos = RootPart and RootPart.CFrame

    if not Humanoid or not RootPart then return end

    local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
    if not PCar then
        RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
        task.wait(0.5)
        local Remote = game.ReplicatedStorage:FindFirstChild("RE") and game.ReplicatedStorage.RE:FindFirstChild("1Ca1r")
        if Remote then Remote:FireServer("PickingCar", "Bus") end
        task.wait(0.5)
        PCar = Vehicles:FindFirstChild(Player.Name.."Car")
    end

    local timeout = 5
    while timeout > 0 and not PCar do
        task.wait(0.25)
        PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        timeout -= 0.25
    end
    if not PCar then return end

    task.wait(0.5)
    if PCar and not Humanoid.Sit then
        local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
        if Seat then
            repeat task.wait()
                RootPart.CFrame = Seat.CFrame
            until Humanoid.Sit
        end
    end

    local attachment = nil
    local force = nil

    local function getTargetInfo()
        while true do
            local TargetPlayer = selectedPlayer
            if TargetPlayer then
                local TargetC = TargetPlayer.Character
                local TargetH = TargetC and TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC and TargetC:FindFirstChild("HumanoidRootPart")
                if TargetC and TargetH and TargetRP then
                    return TargetC, TargetH, TargetRP
                end
            end
            task.wait(0.2)
        end
    end

    local TargetC, TargetH, TargetRP = getTargetInfo()

    -- Ativando o body velocity no alvo
    attachment = Instance.new("Attachment", TargetRP)
    force = Instance.new("BodyVelocity")
    force.Velocity = Vector3.new(0, 999999999, 0)
    force.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    force.P = 500
    force.Parent = attachment

    -- Ativando força no carro
    for _, part in ipairs(PCar:GetDescendants()) do
        if part:IsA("BasePart") then
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(0, 99999999, 0)
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.P = 500
            bv.Parent = part
        end
    end

    local Angles = 0
    local YRotation = 0

    while PCar.Parent do
        task.wait()
        Angles += 100
        YRotation += 5000
        local Rotation = CFrame.Angles(math.rad(Angles), math.rad(YRotation), 0)

        -- Reconfirma alvo ativo
        if not (TargetC and TargetH and TargetRP and TargetRP.Parent) then
            TargetC, TargetH, TargetRP = getTargetInfo()
            if attachment then attachment:Destroy() end
            if force then force:Destroy() end
            attachment = Instance.new("Attachment", TargetRP)
            force = Instance.new("BodyVelocity")
            force.Velocity = Vector3.new(0, 99999999, 0)
            force.MaxForce = Vector3.new(0, math.huge, 0)
            force.P = 500
            force.Parent = attachment
        end

        local function flingAttack(offset)
            local newPos = TargetRP.Position + offset + (TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.1)
            local newCF = CFrame.new(newPos) * Rotation
            PCar:SetPrimaryPartCFrame(newCF)
        end

        flingAttack(Vector3.new(0, 1, 0))
        flingAttack(Vector3.new(0, -2.25, 5))
        flingAttack(Vector3.new(0, 2.25, 0.25))
        flingAttack(Vector3.new(-2.25, -1.5, 2.25))
        flingAttack(Vector3.new(0, 1.5, 0))
        flingAttack(Vector3.new(0, -1.5, 0))
    end

    if attachment then attachment:Destroy() end
    if force then force:Destroy() end
    Humanoid.Sit = false
    task.wait(0.1)
    if OldPos then RootPart.CFrame = OldPos end
end})

Tab5:AddButton({
    Name = "Kill bus",
    Callback = function()
        local Target = selectedPlayer and selectedPlayer.Name
        if not Target then
            Notify("Nenhum jogador selecionado para flingar.")
            return
        end

        getgenv().Target = Target 
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart.CFrame

        if not Target or not Humanoid then return end

        local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        if not PCar then
            RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
            task.wait(0.5)
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "Bus")
            task.wait(0.5)
            PCar = Vehicles:FindFirstChild(Player.Name.."Car")
            task.wait(0.5)
            local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
            if Seat then
                repeat task.wait()
                    RootPart.CFrame = Seat.CFrame
                until Humanoid.Sit
            end
        end

        task.wait(0.5)
        PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        if PCar and not Humanoid.Sit then
            local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
            if Seat then
                repeat task.wait()
                    RootPart.CFrame = Seat.CFrame
                until Humanoid.Sit
            end
        end

        local TargetPlayer = game.Players:FindFirstChild(Target)
        if TargetPlayer then
            local TargetC = TargetPlayer.Character
            local TargetH = TargetC and TargetC:FindFirstChildOfClass("Humanoid")
            local TargetRP = TargetC and TargetC:FindFirstChild("HumanoidRootPart")

            if TargetC and TargetH and TargetRP and not TargetH.Sit then
                local forward = true
                local amplitude = 10

                while not TargetH.Sit do
                    task.wait(0.05)

                    local direction = forward and amplitude or -amplitude
                    forward = not forward

                    local offset = TargetRP.CFrame.LookVector * direction
                    local targetPos = TargetRP.Position + offset + Vector3.new(0, 1, 0)
                    local newCFrame = CFrame.new(targetPos)

                    PCar:SetPrimaryPartCFrame(newCFrame)
                end

                task.wait(0.1)
                PCar:SetPrimaryPartCFrame(CFrame.new(0, -470, 0))
                task.wait(0.2)
                Humanoid.Sit = false
                task.wait(0.1)
                RootPart.CFrame = OldPos
            end
        end
    end
})  

Tab5:AddButton({"Bring bus", function()
    local Target = selectedPlayer and selectedPlayer.Name
    if not Target then
        print("Nenhum jogador selecionado para trazer o ônibus.")
        return
    end

    local Player = game.Players.LocalPlayer
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Vehicles = workspace:FindFirstChild("Vehicles")
    local OldPos = RootPart and RootPart.CFrame

    if not Target or not Humanoid or not RootPart or not Vehicles then return end

    local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
    if not PCar then
        RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
        task.wait(0.5)
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "Bus")
        task.wait(0.5)
        PCar = Vehicles:FindFirstChild(Player.Name.."Car")
        task.wait(0.5)
        local Seat = PCar and PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
        if Seat then
            repeat task.wait()
                RootPart.CFrame = Seat.CFrame
            until Humanoid.Sit
        end
    end

    task.wait(0.5)
    PCar = Vehicles:FindFirstChild(Player.Name.."Car")
    if PCar and not Humanoid.Sit then
        local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
        if Seat then
            repeat task.wait()
                RootPart.CFrame = Seat.CFrame
            until Humanoid.Sit
        end
    end

    local TargetPlayer = game.Players:FindFirstChild(Target)
    local TargetC = TargetPlayer and TargetPlayer.Character
    local TargetH = TargetC and TargetC:FindFirstChildOfClass("Humanoid")
    local TargetRP = TargetC and TargetC:FindFirstChild("HumanoidRootPart")

    if TargetC and TargetH and TargetRP and not TargetH.Sit then
        local forward = true
        local amplitude = 5

        while not TargetH.Sit do
            task.wait()
            local direction = forward and amplitude or -amplitude
            forward = not forward
            local offset = TargetRP.CFrame.LookVector * direction
            local targetPos = TargetRP.Position + offset + Vector3.new(0, 1, 0)
            PCar:SetPrimaryPartCFrame(CFrame.new(targetPos))
        end

        task.wait(0.1)
        PCar:SetPrimaryPartCFrame(OldPos)
        task.wait(0.2)
        Humanoid.Sit = false
        task.wait(0.1)
        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
    end
end})

local Tab6 = Window:MakeTab({"Avatar", "shirt"})

-- Serviços
local RemoteColor = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1RPNam1eColo1r")
local RemoteText = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1RPNam1eTex1t")

-- Estados
local runningName = false
local runningBio = false
local lastNameText = ""
local lastBioText = ""

-- Função para iniciar o loop RGB
local function startRGB(target)
    task.spawn(function()
        local h = 0
        while (target == "name" and runningName) or (target == "bio" and runningBio) do
            h = (h + 0.01) % 1
            local color = Color3.fromHSV(h, 1, 1)

            if target == "name" then
                RemoteColor:FireServer("PickingRPNameColor", color)
            elseif target == "bio" then
                RemoteColor:FireServer("PickingRPBioColor", color)
            end

            task.wait(0.05)
        end
    end)
end

-- Seção Nome RP
Tab6:AddSection({ "RP RGB" })

Tab6:AddTextBox({
    Name = "Nome RP",
    PlaceholderText = "Digite o nome do RP...",
    Callback = function(Value)
        if Value ~= lastNameText then
            lastNameText = Value
            RemoteText:FireServer("RolePlayName", Value)
        end
    end
})

Tab6:AddToggle({
    Name = "Ativar RGB Nome",
    Default = false,
    Callback = function(enabled)
        runningName = enabled
        if enabled then
            startRGB("name")
        end
    end
})

-- Seção Bio RP
Tab6:AddSection({ "Bio RGB" })

Tab6:AddTextBox({
    Name = "Bio RP",
    PlaceholderText = "Digite a bio do RP...",
    Callback = function(Value)
        if Value ~= lastBioText then
            lastBioText = Value
            RemoteText:FireServer("RolePlayBio", Value)
        end
    end
})

Tab6:AddToggle({
    Name = "Ativar RGB Bio",
    Default = false,
    Callback = function(enabled)
        runningBio = enabled
        if enabled then
            startRGB("bio")
        end
    end
})

local Remotes = Rep.Remotes

local selectedPlayer = nil
local lastValidTarget = nil
local copyType = "Brookhaven"
local Target = nil

-- Funções originais que você mandou

local function Wear(id)
    pcall(function()
        Remotes.Wear:InvokeServer(tonumber(id))
    end)
end

local function RESETBLOCK()
    local args = {
        [1] = {0, 0, 0, 0, 0, 0},
        [2] = "AllBlocky"
    }
    pcall(function()
        Remotes.ChangeCharacterBody:InvokeServer(unpack(args))
    end)
end

local function ApplySkinToneFromUserId(userId)
    pcall(function()
        local info = Players:GetCharacterAppearanceInfoAsync(userId)
        if info.bodyColors then
            local headColor = info.bodyColors.HeadColor
            if headColor then
                Remotes.ChangeBodyColor:FireServer(tostring(headColor))
            end
        end
    end)
end

local function CopyClothing(desc)
    local items = {desc.Shirt, desc.Pants, desc.GraphicTShirt, desc.Face}
    for _, id in ipairs(items) do
        if tonumber(id) and id ~= 0 then
            Wear(id)
            task.wait(0.1)
        end
    end
end

local function CopyAccessories(desc)
    pcall(function()
        for _, v in ipairs(desc:GetAccessories(true)) do
            if v.AssetId then
                Wear(v.AssetId)
                task.wait(0.1)
            end
        end
    end)
end

local function CopyBodyParts(desc, source)
    local args = {
        [1] = {
            tonumber(desc.Torso),
            tonumber(desc.RightArm),
            tonumber(desc.LeftArm),
            tonumber(desc.RightLeg),
            tonumber(desc.LeftLeg),
            tonumber(desc.Head)
        },
        [2] = source
    }
    pcall(function()
        Remotes.ChangeCharacterBody:InvokeServer(unpack(args))
    end)
end

local function CopyAnimations(desc)
    local anims = {
        desc.IdleAnimation,
        desc.WalkAnimation,
        desc.RunAnimation,
        desc.JumpAnimation,
        desc.FallAnimation,
        desc.SwimAnimation
    }
    for _, animId in ipairs(anims) do
        if tonumber(animId) and animId ~= 0 then
            Wear(animId)
            task.wait(0.1)
        end
    end
end

local function CopyBrookhaven(targetPlayer)
    local humanoid = targetPlayer.Character and targetPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local desc = humanoid:GetAppliedDescription()
    local bodyColors = targetPlayer.Character:FindFirstChildOfClass("BodyColors")
    if bodyColors then
        local headColor = bodyColors.HeadColor
        if headColor then
            Remotes.ChangeBodyColor:FireServer(tostring(headColor))
        end
    end
    pcall(function()
        CopyAccessories(LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetAppliedDescription())
        RESETBLOCK()
        CopyAccessories(desc)
        task.wait(0.1)
        CopyBodyParts(desc, "SpecterHub")
        CopyClothing(desc)
        CopyAnimations(desc)
    end)
end

local function CopyOriginalAvatar(userId)
    pcall(function()
        local desc = Players:GetHumanoidDescriptionFromUserId(userId)
        CopyAccessories(LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetAppliedDescription())
        RESETBLOCK()
        CopyAccessories(desc)
        task.wait(0.1)
        CopyBodyParts(desc, "SpecterHub")
        CopyClothing(desc)
        CopyAnimations(desc)
        ApplySkinToneFromUserId(userId)
    end)
end

local function findPlayerByName(partialName)
    if not partialName or partialName == "" then return nil end
    partialName = partialName:lower()
    local foundPlayers = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Name:lower():find(partialName, 1, true) then
            table.insert(foundPlayers, player)
        end
    end
    table.sort(foundPlayers, function(a, b)
        local aStart = a.Name:lower():sub(1, #partialName) == partialName
        local bStart = b.Name:lower():sub(1, #partialName) == partialName
        if aStart and not bStart then return true end
        if not aStart and bStart then return false end
        return #a.Name < #b.Name
    end)
    return foundPlayers[1]
end

local function notifyPlayer(player)
    if not player then return end
    StarterGui:SetCore("SendNotification", {
        Title = "Player Selecionado",
        Text = player.Name,
        Duration = 5,
        Icon = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=150&h=150"
    })
end

local function getClosestPlayer()
    local localPlayer = LocalPlayer
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local hrp = localPlayer.Character.HumanoidRootPart

    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < shortestDistance then
                shortestDistance = dist
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

local function getRandomPlayer()
    local players = Players:GetPlayers()
    local localPlayer = LocalPlayer
    local candidates = {}
    for _, p in pairs(players) do
        if p ~= localPlayer then
            table.insert(candidates, p)
        end
    end
    if #candidates == 0 then return nil end
    return candidates[math.random(1,#candidates)]
end

-- UI para Tab5 (mantendo sua estrutura original)

local Section = Tab6:AddSection({"Copy Avatar"})

local Players = game:GetService("Players")

local function findPlayerByName(namePart)
    namePart = namePart:lower()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name:lower():find(namePart) or player.DisplayName:lower():find(namePart) then
            return player
        end
    end
    return nil
end

Tab6:AddTextBox({
    Name = "Escreva o nome do player",
    Description = "Digite parte do nome ou nickname",
    PlaceholderText = "Ex: specter",
    Callback = function(value)
        if value == "" then
            if lastValidTarget then
                value = lastValidTarget
            else
                return
            end
        end
        local player = findPlayerByName(value)
        if player then
            Target = player
            selectedPlayer = player
            lastValidTarget = player.Name
            notifyPlayer(player)
        else
            selectedPlayer = nil
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Player não encontrado",
                Text = "Nenhum player com '"..value.."' foi encontrado",
                Duration = 5
            })
        end
    end
})


Tab6:AddDropdown({
    Name = "Copy Method",
    Description = "Escolha o método de cópia",
    Options = {"Brookhaven", "Original Avatar"},
    Callback = function(option)
        copyType = option
    end,
    Default = "Brookhaven"
})

Tab6:AddButton({
    Name = "Copiar avatar",
    Callback = function()
        if not selectedPlayer then
            StarterGui:SetCore("SendNotification", {
                Title = "Erro",
                Text = "Nenhum player selecionado",
                Duration = 5
            })
            return
        end
        if copyType == "Brookhaven" then
            CopyBrookhaven(selectedPlayer)
        else
            CopyOriginalAvatar(selectedPlayer.UserId)
        end
    end
})

Tab6:AddButton({
    Name = "Copiar avatar mais próximo",
    Callback = function()
        local player = getClosestPlayer()
        if player then
            notifyPlayer(player)
            if copyType == "Brookhaven" then
                CopyBrookhaven(player)
            else
                CopyOriginalAvatar(player.UserId)
            end
        else
            StarterGui:SetCore("SendNotification", {
                Title = "Erro",
                Text = "Nenhum player próximo encontrado",
                Duration = 5
            })
        end
    end
})

Tab6:AddButton({
    Name = "Copiar avatar aleatório",
    Callback = function()
        local player = getRandomPlayer()
        if player then
            notifyPlayer(player)
            if copyType == "Brookhaven" then
                CopyBrookhaven(player)
            else
                CopyOriginalAvatar(player.UserId)
            end
        else
            StarterGui:SetCore("SendNotification", {
                Title = "Erro",
                Text = "Nenhum player no servidor",
                Duration = 5
            })
        end
    end
})

local Section = Tab6:AddSection({"Catalogo"})

-- Marketplace
local MPS = game:GetService("MarketplaceService")
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")

-- BODY DATA
local body = {
    Torso = nil,
    RightArm = nil,
    LeftArm = nil,
    RightLeg = nil,
    LeftLeg = nil,
    Head = nil
}

local bodyMap = {
    [27] = "Torso",
    [28] = "RightArm",
    [29] = "LeftArm",
    [31] = "RightLeg",
    [30] = "LeftLeg",
    [17] = "Head"
}

local function trySendBody()
    for _, v in pairs(body) do
        if not v then return end
    end

    Remotes.ChangeCharacterBody:InvokeServer({
        body.Torso,
        body.RightArm,
        body.LeftArm,
        body.RightLeg,
        body.LeftLeg,
        body.Head
    })

    print("✅ Corpo aplicado!")
end

-- 💃 EMOTE (usa o humanoid que você já tem)
local function playEmote(id)
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. id

    local track = humanoid:LoadAnimation(anim)
    track:Play()

    print("💃 Emote tocando:", id)
end

-- APPLY
local function apply(id)
    local info
    pcall(function()
        info = MPS:GetProductInfo(id)
    end)
    if not info then return end

    local t = info.AssetTypeId
    local name = info.Name:lower()

    -- 👕 ROUPAS
    if t == 11 or t == 12 or name:find("shirt") or name:find("pants") then
        return Remotes.WearShirt:InvokeServer(id)
    end

    -- 🎩 ACESSÓRIOS
    if t == 8 or t == 41 or t == 42 or t == 43 then
        return Remotes.Wear:InvokeServer(id)
    end

    -- 🦴 CORPO
    local part = bodyMap[t]
    if part then
        body[part] = id
        print("🦴 Parte aplicada:", part, id)
        return trySendBody()
    end

    -- 💃 EMOTE (DETECÇÃO)
    if t == 61 or (t == 24 and (name:find("emote") or name:find("dance"))) then
        if Remotes:FindFirstChild("PlayEmote") then
            Remotes.PlayEmote:FireServer(id)
        else
            playEmote(id)
        end
        return
    end

    warn("❌ Tipo não reconhecido:", t, info.Name)
end

-- UI
local lastId

Tab6:AddTextBox({
    Name = "Digite o ID",
    PlaceholderText = "Ex: 123456789",
    Callback = function(v)
        lastId = tonumber(v)
    end
})

Tab6:AddButton({
    "Confirmar",
    function()
        if lastId then
            apply(lastId)
        end
    end
})


local Section = Tab6:AddSection({"Avatares"})

Tab6:AddButton({"Specter - Oficial", function(Value)
	loadstring(game:HttpGet("https://pastebin.com/raw/x2cyrRhQ"))()
end})

local Section = Tab6:AddSection({"Roleplay Names"})

Tab6:AddButton({"Specter - Oficial", function(Value)
loadstring(game:HttpGet("https://pastebin.com/raw/zE19LKjW"))()
end})

local Tab7 = Window:MakeTab({"House", "home"})

Tab7:AddSection({"House Manager"})

local playerImageLabel
local playerNameLabel
local selectedPlayer = nil

-- Verifica apenas pelo DisplayName (nickname)
local function getPlayerByDisplayName(input)
    input = input:lower()
    for _, plr in ipairs(game.Players:GetPlayers()) do
        local display = plr.DisplayName:lower()
        if display:find(input, 1, true) then
            return plr
        end
    end
    return nil
end

-- Notifica + imagem
local function showNotification(plr)
    local thumb = game.Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Jogador Selecionado",
        Text = plr.DisplayName,
        Icon = thumb,
        Duration = 5
    })

    if playerImageLabel then
        playerImageLabel:SetImage(thumb)
    else
        playerImageLabel = Tab6:AddImage(thumb)
    end

    if playerNameLabel then
        playerNameLabel:SetText("Selecionado: " .. plr.DisplayName)
    else
        playerNameLabel = Tab6:AddLabel("Selecionado: " .. plr.DisplayName)
    end
end

local localPlayer = game.Players.LocalPlayer

local function getPlayerHouse(player)
    -- Supondo que o nome da casa seja algo com o nome do player + "_House"
    -- Ajuste essa linha de acordo com a sua estrutura exata.
    local houseName = player.Name .. "House"
    
    local houseFolder = workspace:WaitForChild("001_Lots"):FindFirstChild(houseName)
    if houseFolder then
        local housePicked = houseFolder:FindFirstChild("HousePickedByPlayer")
        if housePicked then
            local houseModel = housePicked:FindFirstChild("HouseModel")
            return houseModel
        end
    end
    return nil
end

-- Banir
local function banPlayer(plr)
    if plr and plr ~= localPlayer and plr.Parent == game.Players then
        local house = getPlayerHouse(localPlayer)  -- Aqui pega a casa do localPlayer
        if house then
            house:WaitForChild("Permissions:Disallow"):FireServer(plr)
        end
    end
end

-- Desbanir
local function unbanPlayer(plr)
    if plr and plr.Parent == game.Players then
        local house = getPlayerHouse(localPlayer)  -- Aqui também pega a casa do localPlayer
        if house then
            house:WaitForChild("Permissions:Allow"):FireServer(plr)
        end
    end
end


-- TextBox para escolher jogador
Tab7:AddTextBox({
    Name = "Escreva o nome do jogador",
    PlaceholderText = "Ex: Specter",
    Callback = function(value)
        local plr = getPlayerByDisplayName(value)
        if plr then
            if plr == localPlayer then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Erro",
                    Text = "Você não pode se selecionar.",
                    Duration = 4
                })
                selectedPlayer = nil
                return
            end

            selectedPlayer = plr
            showNotification(plr)
            banPlayer(plr)
        else
            selectedPlayer = nil
        end
    end
})

Tab7:AddButton({
    "Banir o jogador",
    function()
        if selectedPlayer and selectedPlayer ~= localPlayer then
            banPlayer(selectedPlayer)
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Erro",
                Text = "Selecione outro jogador que não seja você.",
                Duration = 4
            })
        end
    end
})

Tab7:AddButton({
    "Desbanir o jogador",
    function()
        if selectedPlayer then
            unbanPlayer(selectedPlayer)
            game.StarterGui:SetCore("SendNotification", {
                Title = "Sucesso",
                Text = selectedPlayer.Name .. " foi desbanido.",
                Duration = 3
            })
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Erro",
                Text = "Nenhum jogador selecionado para desbanir.",
                Duration = 3
            })
        end
    end
})

Tab7:AddButton({
    "Banir todos da sua casa",
    function()
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr ~= localPlayer then
                banPlayer(plr)
            end
        end
    end
})

Tab7:AddButton({
    "Desbanir todos da sua casa",
    function()
        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr ~= localPlayer then
                unbanPlayer(plr)
            end
        end
    end
})

local looping = false
Tab7:AddToggle({
    Name = "Banir Todos jogadores em loop",
    Default = false,
    Callback = function(state)
        looping = state
        if looping then
            spawn(function()
                while looping do
                    for _, plr in ipairs(game.Players:GetPlayers()) do
                        if plr ~= localPlayer then
                            banPlayer(plr)
                        end
                    end
                    wait(1)
                end
            end)
        end
    end
})

local toggleActive = false
local connection

local function UnbanAll()
    local lotsFolder = workspace:FindFirstChild("001_Lots")
    if not lotsFolder then
        return
    end

    for _, house in pairs(lotsFolder:GetChildren()) do
        local housePicked = house:FindFirstChild("HousePickedByPlayer")
        if housePicked then
            local houseModel = housePicked:FindFirstChild("HouseModel")
            if houseModel then
                local bannedBlock = houseModel:FindFirstChild("BannedBlock")
                if bannedBlock then
                    for i = 1, 37 do
                        local propBlock = bannedBlock:FindFirstChild("PropBlocker" .. i)
                        if propBlock then
                            propBlock:Destroy()
                        end
                    end
                    bannedBlock:Destroy()
                end
            end
        end
    end
end

local Section = Tab7:AddSection({"Unban house"})

    
Tab7:AddToggle({
    Name = "Auto Desbanir",
    Default = false,
    Callback = function(v)
        toggleActive = v
        if toggleActive then
            connection = RunService.Heartbeat:Connect(function()
                UnbanAll()
            end)
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end
})

Tab7:AddButton({"Desbanir", function()
    UnbanAll()
end})

local Tab8 = Window:MakeTab({"Car", "car"})

local Section = Tab8:AddSection({"Modificar velocidade"})

local velocidade = nil
local turbo = nil

-- Função para pegar o veículo e tipo
local function getVehicleType(playerName)
    local vehicleCar = workspace.Vehicles:FindFirstChild(playerName .. "Car")
    if vehicleCar then
        return vehicleCar, "Car"
    end
    local vehicleHorse = workspace.Vehicles:FindFirstChild(playerName .. "Horse")
    if vehicleHorse then
        return vehicleHorse, "Horse"
    end
    return nil, nil
end

Tab8:AddTextBox({
    Name = "Escreva a velocidade",
    PlaceholderText = "Ex: 200",
    Callback = function(Value)
        local num = tonumber(Value)
        if num and num > 0 then
            velocidade = num
            print("Velocidade salva:", velocidade)
        else
            warn("Valor inválido para velocidade")
        end
    end
})

Tab8:AddTextBox({
    Name = "Escreva o turbo",
    PlaceholderText = "Ex: 20",
    Callback = function(Value)
        local num = tonumber(Value)
        if num and num > 0 then
            turbo = num
            print("Turbo salvo:", turbo)
        else
            warn("Valor inválido para turbo")
        end
    end
})

Tab8:AddButton({
    Name = "Aplicar Velocidade/Turbo",
    Callback = function()
        local vehicle, vType = getVehicleType(LocalPlayer.Name)
        if not vehicle then
            warn("Veículo não encontrado para o jogador: " .. LocalPlayer.Name)
            return
        end
        local seats = vehicle:FindFirstChild("Seats")
        if not seats then
            warn("Seats não encontrado!")
            return
        end
        local vehicleSeat = seats:FindFirstChild("VehicleSeat")
        if not vehicleSeat then
            warn("VehicleSeat não encontrado!")
            return
        end
        if velocidade then
            local maxSpeed = vehicleSeat:FindFirstChild("MaxSpeed")
            if maxSpeed then
                maxSpeed.Value = velocidade
                print("MaxSpeed (Velocidade) aplicada:", velocidade)
            else
                warn("MaxSpeed não encontrado!")
            end
        else
            warn("Velocidade não definida, não aplicando.")
        end
        if turbo then
            local turboObj = vehicleSeat:FindFirstChild("Turbo")
            if turboObj then
                turboObj.Value = turbo
                print("Turbo aplicado:", turbo)
            else
                warn("Turbo não encontrado!")
            end
        else
            warn("Turbo não definido, não aplicando.")
        end
    end
})

local Section = Tab8:AddSection({"Car Music (Gamepass)"})

local musicList = {
    ["ZUM ZUM"] = "92446612272052",
    ["Regador de Flor"] = "102705292327383",
    ["Balanço"] = "136093653466042",
    ["Passo bem solto"] = "114138177515042",
    ["La vida"] = "79889952866985",
    ["Sou forte"] = "121592654059575",
    ["Montagem Rugada"] = "120342836549924",
    ["Nova geraçao"] = "119293698405737",
    ["Vibe"] = "76016469551489",
}

local keys = {}
for name in pairs(musicList) do
    table.insert(keys, name)
end

table.sort(keys, function(a, b)
    return string.lower(a) < string.lower(b)
end)

for _, name in ipairs(keys) do
    local id = musicList[name]
end


local musicId = nil
local selectedSource = nil
local isPlaying = false

Tab8:AddDropdown({
    Name = "Músicas:",
    Options = (function()
        local keys = {}
        for name, _ in pairs(musicList) do
            table.insert(keys, name)
        end
        return keys
    end)(),
    Default = nil,
    Callback = function(Value)
        musicId = musicList[Value]
        selectedSource = "Dropdown"
        if isPlaying and musicId ~= "" then
            tocarMusica(musicId)
        end
    end
})

Tab8:AddTextBox({
    Name = "Escreva o ID",
    PlaceholderText = "Ex: 123456789",
    Callback = function(Value)
        musicId = Value
        selectedSource = "TextBox"
        if isPlaying and musicId ~= "" then
            tocarMusica(musicId)
        end
    end
})

Tab8:AddToggle({
    Name = "Tocar",
    Default = false,
    Callback = function(Value)
        isPlaying = Value
        if Value then
            if musicId and musicId ~= "" then
                tocarMusica(musicId)
            else
                warn("Você precisa inserir um ID da música.")
            end
        else
            pararMusica()
        end
    end
})

function tocarMusica(id)
    local argsCar = {
        "PickingCarMusicText",
        id
    }

    local argsVehicle = {
        "PickingVehicleMusicText",
        id,
        [4] = true
    }

    local argsScooter = {
        "PickingScooterMusicText",
        id
    }

    local argsTool = {
        "ToolMusicText",
        id,
        [4] = true
    }

    rs.RE["1Player1sCa1r"]:FireServer(unpack(argsCar))
    rs.RE["1Player1sCa1r"]:FireServer(unpack(argsVehicle))
    rs.RE["1NoMoto1rVehicle1s"]:FireServer(unpack(argsScooter))
    rs.RE["PlayerToolEvent"]:FireServer(unpack(argsTool))
end

function pararMusica()
    local argsStopCar = {
        "CarMusicStop",
        ""
    }

    local argsStopVehicle = {
        "PickingVehicleMusicText",
        "",
        [4] = true
    }

    local argsStopScooter = {
        "PickingScooterMusicStop",
        ""
    }

    local argsStopTool = {
        "ToolMusicText",
        "",
        [4] = true
    }

    rs.RE["1Player1sCa1r"]:FireServer(unpack(argsStopCar))
    rs.RE["1Player1sCa1r"]:FireServer(unpack(argsStopVehicle))
    rs.RE["1NoMoto1rVehicle1s"]:FireServer(unpack(argsStopScooter))
    rs.RE["PlayerToolEvent"]:FireServer(unpack(argsStopTool))
end

local Section = Tab8:AddSection({"Car Troll"})

local selecionado = nil

Tab8:AddTextBox({
    Name = "Escreva o nome do carro",
    PlaceholderText = "Ex: Specter",
    Callback = function(Value)
        local Vehicles = workspace:FindFirstChild("Vehicles")
        if not Vehicles then
            warn("⚠️ workspace.Vehicles não foi encontrado!")
            return
        end

        local input = string.lower(Value)
        local jogador = game.Players.LocalPlayer
        selecionado = nil

        -- Primeiro tenta encontrar veículo com nome do jogador
        for _, veiculo in pairs(Vehicles:GetChildren()) do
            local nome = string.lower(veiculo.Name)
            if nome:find(input) and nome:find(string.lower(jogador.Name)) then
                selecionado = veiculo
                break
            end
        end

        -- Se não encontrou com nome do jogador, tenta qualquer um que combine
        if not selecionado then
            for _, veiculo in pairs(Vehicles:GetChildren()) do
                local nome = string.lower(veiculo.Name)
                if nome:find(input) then
                    selecionado = veiculo
                    break
                end
            end
        end

        -- Notificação
        if selecionado then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Sistema",
                Text = 'Selecionado: "' .. selecionado.Name .. '" com sucesso',
                Duration = 5
            })
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Sistema",
                Text = "Nenhum veículo encontrado.",
                Duration = 5
            })
        end
    end
})

Tab8:AddButton({
    Name = "Teleportar para veículo",
    Callback = function()
        local jogador = game.Players.LocalPlayer
        local personagem = jogador.Character or jogador.CharacterAdded:Wait()

        if selecionado and selecionado.PrimaryPart then
            -- Teleporta o personagem para perto do veículo
            personagem:SetPrimaryPartCFrame(selecionado.PrimaryPart.CFrame * CFrame.new(0, 5, 0))

            game.StarterGui:SetCore("SendNotification", {
                Title = "Sistema",
                Text = "Teleportado para o veículo: " .. selecionado.Name,
                Duration = 5
            })
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Sistema",
                Text = "Nenhum veículo selecionado ou veículo inválido.",
                Duration = 5
            })
        end
    end
})

Tab8:AddButton({
    Name = "Destruir veiculo (BETA)",
    Callback = function()
        local jogador = game.Players.LocalPlayer
        local personagem = jogador.Character or jogador.CharacterAdded:Wait()
        local humanoide = personagem:FindFirstChildWhichIsA("Humanoid")
        local rootPart = personagem:FindFirstChild("HumanoidRootPart")

        if not (selecionado and selecionado.PrimaryPart and humanoide and rootPart) then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Sistema",
                Text = "Nenhum veículo selecionado ou personagem inválido.",
                Duration = 5
            })
            return
        end

        --------------------------------------------------------------------
        -- FUNÇÃO UNIVERSAL PARA ACHAR QUALQUER VehicleSeat NO VEÍCULO
        --------------------------------------------------------------------
        local function encontrarVehicleSeat(model)
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("VehicleSeat") then
                    return obj
                end
            end
            return nil
        end

        local assentoMotorista = encontrarVehicleSeat(selecionado)

        if not assentoMotorista then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Sistema",
                Text = "VehicleSeat não encontrado dentro do veículo.",
                Duration = 5
            })
            return
        end

        if assentoMotorista.Occupant then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Sistema",
                Text = "O veículo já está ocupado. Aguarde ele ficar livre.",
                Duration = 5
            })
            return
        end

        --------------------------------------------------------------------
        -- SALVA POSIÇÃO ORIGINAL DO VEÍCULO
        --------------------------------------------------------------------
        local posOriginalVeiculo = selecionado.PrimaryPart.CFrame

        task.wait(0.5)

        --------------------------------------------------------------------
        -- TENTAR AUTOMATICAMENTE SENTAR NO VEÍCULO
        --------------------------------------------------------------------
        local tempo = 0
        local timeout = 10
        local posAssento = assentoMotorista.CFrame * CFrame.new(0, 3, 0)

        repeat
            humanoide.Sit = true
            personagem:SetPrimaryPartCFrame(posAssento)
            task.wait(0.1)
            tempo = tempo + 0.1
        until humanoide.Sit or tempo >= timeout

        if not humanoide.Sit then
            game.StarterGui:SetCore("SendNotification", {
                Title = "Sistema",
                Text = "Não foi possível sentar automaticamente no VehicleSeat.",
                Duration = 5
            })
            return
        end

        --------------------------------------------------------------------
        -- TELEPORTA VEÍCULO E PERSONAGEM PARA O FIM DO MAPA
        --------------------------------------------------------------------
        local fimDoMapa = CFrame.new(-60.71, 3525.05, 55063)

        selecionado:SetPrimaryPartCFrame(fimDoMapa)
        personagem:SetPrimaryPartCFrame(fimDoMapa * CFrame.new(0, 5, 0))

        game.StarterGui:SetCore("SendNotification", {
            Title = "Sistema",
            Text = "Chegou ao fim do mapa! Saindo do veículo...",
            Duration = 5
        })

        --------------------------------------------------------------------
        -- FUNÇÃO PARA FORÇAR SAIR DO VEÍCULO
        --------------------------------------------------------------------
        local function forcarSair()
            if humanoide and humanoide.Parent then
                humanoide.Jump = true
                local foraDoVeiculo = fimDoMapa * CFrame.new(5, 5, 0)
                personagem:SetPrimaryPartCFrame(foraDoVeiculo)
            end
        end

        forcarSair()
        task.wait(1)

        local tempoSaida = 0
        while assentoMotorista.Occupant == humanoide and tempoSaida < 5 do
            forcarSair()
            task.wait(0.5)
            tempoSaida = tempoSaida + 0.5
        end

        --------------------------------------------------------------------
        -- RETORNAR PARA LOCAL ORIGINAL
        --------------------------------------------------------------------
        personagem:SetPrimaryPartCFrame(posOriginalVeiculo * CFrame.new(0, 3, 0))

        game.StarterGui:SetCore("SendNotification", {
            Title = "Sistema",
            Text = "Você foi retornado ao local original do veículo.",
            Duration = 5
        })
    end
})
  
local viewCarToggleInitialized = false

Tab8:AddToggle({
    Name = "View Car",
    Default = false,
    Callback = function(v)
        if not viewCarToggleInitialized then
            viewCarToggleInitialized = true
            return
        end

        local jogador = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        local personagem = jogador.Character or jogador.CharacterAdded:Wait()

        if v then
            -- Ativar: seguir o carro
            if selecionado and selecionado.PrimaryPart then
                camera.CameraSubject = selecionado.PrimaryPart
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Sistema",
                    Text = "Visualizando o veículo.",
                    Duration = 4
                })
            else
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Sistema",
                    Text = "Nenhum veículo selecionado.",
                    Duration = 4
                })
            end
        else
            -- Desativar: voltar para o jogador
            local humanoide = personagem:FindFirstChildWhichIsA("Humanoid")
            if humanoide then
                camera.CameraSubject = humanoide
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Sistema",
                    Text = "Câmera voltou para o jogador.",
                    Duration = 4
                })
            end
        end
    end
})

local Tab10 = Window:MakeTab({"Misc", "menu"})

local Section = Tab10:AddSection({"Lag all (Funciona apenas em alguns executores)"})

local ClashType = "Iphone"

Tab10:AddDropdown({
    Name = "Tipo de clash",
    Options = {"Iphone", "Bomb"},
    Default = "Iphone",
    Callback = function(Value)
        ClashType = Value
    end
})

local isClash = false

local savedPos

Tab10:AddToggle({
    Name = "Ativar Clash",
    Default = false,
    Callback = function(v)
        isClash = v

        if v then
            savedPos = hrp.CFrame

            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0

            local targetCFrame
            local clickDetector

            -- IPHONE
            if ClashType == "Iphone" then
                targetCFrame = CFrame.new(
                    -116.97915649414062, 19.925275802612305, 254.1663055419922
                )

                clickDetector =
                    workspace.WorkspaceCom["001_CommercialStores"]
                    .CommercialStorage1.Store.Tools:GetChildren()[4].ClickDetector

            -- BOMB
            elseif ClashType == "Bomb" then
                targetCFrame = CFrame.new(
                    -141.4248809814453, -26.350610733032227, 243.15170288085938
                )

                clickDetector =
                    workspace.WorkspaceCom["001_CriminalWeapons"].GiveTools.Bomb.ClickDetector
            end

            hrp.CFrame = targetCFrame

            task.spawn(function()
                while isClash do
                    fireclickdetector(clickDetector)
                    task.wait(0.1)
                end
            end)

        else
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50

            if savedPos then
                hrp.CFrame = savedPos
            end
        end
    end
})

local Section = Tab10:AddSection({"Skybox"})

local EMOTE_ASSET_ID = 93224413172183

local SkyboxList = {
    ["Coolkid"] = 18512801325,
    ["Turbers"] = 16510932762
}

local SkyNames = {}
for name,_ in pairs(SkyboxList) do
    table.insert(SkyNames, name)
end

local SelectedSkyName = nil
local SelectedShirtID = nil

local OriginalProfile = nil
local SkyboxActive = false

local function WaitFullyLoadedCharacter(player)
    local character = player.Character or player.CharacterAdded:Wait()
    character:WaitForChild("Humanoid")
    character:WaitForChild("Head")
    character:WaitForChild("HumanoidRootPart")
    task.wait(0.2)
    return character, character.Humanoid
end

local function GetCurrentProfile()
    local Remotes = Rep:WaitForChild("Remotes")

    local ok, data = pcall(function()
        return Remotes.GetFullProfile:InvokeServer()
    end)

    if ok then
        return data
    else
        warn("⚠ Não foi possível obter o perfil original!")
        return {}
    end
end

local function RestoreOriginalProfile()
    if not OriginalProfile then return end

    local Rep = game:GetService("ReplicatedStorage")
    local Remotes = Rep:WaitForChild("Remotes")

    if OriginalProfile.Body then
        Remotes.ChangeCharacterBody:InvokeServer(unpack(OriginalProfile.Body))
    end

    if OriginalProfile.ShirtID then
        Remotes.WearShirt:InvokeServer(OriginalProfile.ShirtID)
    else
        Remotes.WearShirt:InvokeServer(0)
    end
end

local ChangeBody = {
    {
        100839513065432,
        134162178631486,
        112132665744785,
        134568824619589,
        119032106683081,
        112098331348331
    }
}

local function PlayEmote(humanoid)
    task.delay(0.1, function()
        local ok, obj = pcall(function()
            return game:GetObjects("rbxassetid://" .. EMOTE_ASSET_ID)
        end)

        if ok and obj and obj[1] and obj[1]:IsA("Animation") then
            local track = humanoid:LoadAnimation(obj[1])
            track.Priority = Enum.AnimationPriority.Action4
            track.Looped = true
            track:Play()
            track:AdjustSpeed(0.001)
        end
    end)
end

local function ApplySkybox()
    local Rep = game:GetService("ReplicatedStorage")
    local Remotes = Rep:WaitForChild("Remotes")
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local character, humanoid = WaitFullyLoadedCharacter(player)

    if not SkyboxActive then
        OriginalProfile = GetCurrentProfile() 
    end

    Remotes.ChangeCharacterBody:InvokeServer(unpack(ChangeBody))
    Remotes.WearShirt:InvokeServer(SelectedShirtID)
    PlayEmote(humanoid)
end

local player = game:GetService("Players").LocalPlayer
player.CharacterAdded:Connect(function()
    task.wait(0.4)
    if SkyboxActive and SelectedShirtID then
        ApplySkybox()
    end
end)

Tab10:AddDropdown({
    Name = "Selecionar Skybox:",
    Options = SkyNames,
    Callback = function(Value)
        SelectedSkyName = Value
        SelectedShirtID = SkyboxList[Value]
    end
})

--------------------------------------------------------------------
-- TOGGLE PRINCIPAL
--------------------------------------------------------------------
Tab10:AddToggle({
    Name = "Skybox",
	Description = "Recomendo Salvar o seu personagem antes de ligar.",
    Default = false,
    Callback = function(v)
        local Rep = game:GetService("ReplicatedStorage")
        local Remotes = Rep:WaitForChild("Remotes")

        if v then
            SkyboxActive = true
            ApplySkybox()
        else
            SkyboxActive = false

            -- parar animações
            local char = player.Character
            local hum = char and char:FindFirstChild("Humanoid")
            if hum then
                for _, t in ipairs(hum:GetPlayingAnimationTracks()) do
                    t:Stop()
                end
            end

            -- RESTAURAR PERFIL ORIGINAL
            RestoreOriginalProfile()
        end
    end
})

local ProtectionSection = Tab10:AddSection({"Protection"})

Tab10:AddToggle({
    Name = "Anti-Sit",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer

        local function apply(char)
            local hum = char:WaitForChild("Humanoid")

            if state then
                -- ATIVA ANTI-SIT
                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                hum.Sit = false -- caso esteja sentado
            else
                -- DESATIVA ANTI-SIT (volta ao normal)
                hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            end
        end

        -- aplicar no personagem atual
        local char = player.Character or player.CharacterAdded:Wait()
        apply(char)

        -- reaplicar ao respawn
        player.CharacterAdded:Connect(apply)
    end
})

--// ======================================
--// CONFIG - ANTI SOCCER
--// ======================================
local soccerModel = workspace
    :WaitForChild("WorkspaceCom")
    :WaitForChild("001_SoccerBalls")

local IGNORE_CONTAINER = "Dont Delete"
local SOCCER_SCAN_INTERVAL = 0.2

--// ======================================
--// CONFIG - ANTI COUCH
--// ======================================
local COUCH_NAME = "Couch"
local COUCH_SCAN_INTERVAL = 0.2

--// ======================================
--// VARIÁVEIS
--// ======================================
local antiHackEnabled = false

local soccerAddedConnection
local mainLoopConnection

local soccerElapsed = 0
local couchElapsed = 0

--// ======================================
--// FUNÇÕES AUXILIARES
--// ======================================

local function isInsideDontDelete(obj)
    local current = obj.Parent
    while current do
        if current.Name == IGNORE_CONTAINER then
            return true
        end
        current = current.Parent
    end
    return false
end

local function isLocalPlayerSoccer(obj)
    return obj.Name == ("Soccer" .. LocalPlayer.Name)
end

local function isLocalPlayerSoccerChild(obj)
    -- Checa se o objeto está dentro da bola do seu player
    local current = obj
    while current do
        if isLocalPlayerSoccer(current) then
            return true
        end
        current = current.Parent
    end
    return false
end

--// ======================================
--// LÓGICA PRINCIPAL (SOCCER + COUCH)
--// ======================================

local function mainLoop(dt)
    if not antiHackEnabled then return end

    -- ⚽ ANTI SOCCER
    soccerElapsed += dt
    if soccerElapsed >= SOCCER_SCAN_INTERVAL then
        soccerElapsed = 0

        for _, obj in ipairs(soccerModel:GetDescendants()) do
            if obj and obj.Parent then
                -- Nunca destruir "Dont Delete" nem nada dentro dele
                -- Nunca destruir a bola do seu player nem nada dentro dela
                if obj.Name ~= IGNORE_CONTAINER
                and not isInsideDontDelete(obj)
                and not isLocalPlayerSoccerChild(obj) then
                    obj:Destroy()
                    warn("[ANTI SOCCER] Removido:", obj:GetFullName())
                end
            end
        end
    end

    -- 🛋️ ANTI COUCH
    couchElapsed += dt
    if couchElapsed >= COUCH_SCAN_INTERVAL then
        couchElapsed = 0

        for _, player in ipairs(Players:GetPlayers()) do
            local character = player.Character
            if character then
                local couch = character:FindFirstChild(COUCH_NAME)
                if couch then
                    for _, obj in ipairs(couch:GetDescendants()) do
                        if obj:IsA("Seat") and (obj.Name == "Seat1" or obj.Name == "Seat2") then
                            if obj.Disabled ~= true then
                                obj.Disabled = true
                                warn("[ANTI COUCH] Seat desativado:", player.Name, obj.Name)
                            end
                        end
                    end
                end
            end
        end
    end
end

--// ======================================
--// ENABLE / DISABLE
--// ======================================

local function enableAntiHack()
    if antiHackEnabled then return end
    antiHackEnabled = true

    -- Evento instantâneo para soccer
    soccerAddedConnection = soccerModel.DescendantAdded:Connect(function(obj)
        if antiHackEnabled and obj and obj.Parent then
            if obj.Name ~= IGNORE_CONTAINER
            and not isInsideDontDelete(obj)
            and not isLocalPlayerSoccerChild(obj) then
                obj:Destroy()
                warn("[ANTI SOCCER] Removido (evento):", obj:GetFullName())
            end
        end
    end)

    -- Loop principal
    mainLoopConnection = RunService.Heartbeat:Connect(mainLoop)

    warn("[ANTI HACKER] ATIVADO")
end

local function disableAntiHack()
    antiHackEnabled = false

    if soccerAddedConnection then
        soccerAddedConnection:Disconnect()
        soccerAddedConnection = nil
    end

    if mainLoopConnection then
        mainLoopConnection:Disconnect()
        mainLoopConnection = nil
    end

    warn("[ANTI HACKER] DESATIVADO")
end

-- Toggle na interface
Tab10:AddToggle({
    Name = "Anti-Hacker",
    Default = false,
    Callback = function(v)
        if v then
            enableAntiHack()
        else
            disableAntiHack()
        end
    end
})


Tab10:AddToggle({
    Name = "Anti-AFK",
    Default = true,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        if _G._AntiAFK then
            _G._AntiAFK:Disconnect()
            _G._AntiAFK = nil
        end
        if state then
            _G._AntiAFK = game:GetService("RunService").Heartbeat:Connect(function()
                local char = player.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, 0.00001)
                    end
                end
            end)
        end
    end
})

local Tab11 = Window:MakeTab({"Scripts", "scroll"})

Tab11:AddButton({"Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
end})

Tab11:AddButton({"Dex", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
end})

Tab11:AddButton({"FE EMOTE", function(Value)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))()
end})

local SpecterSection = Tab11:AddSection({"Specter"})

Tab11:AddButton({"Black Hole - Specter", function(Value)
    loadstring(game:HttpGet("https://pastebin.com/raw/3L60nw07"))()
end})

Tab11:AddButton({"FreeCam - Specter ", function(Value)
    loadstring(game:HttpGet("https://pastebin.com/raw/fCpdfTqu"))()
end})

Tab11:AddButton({"ShiftLock - Specter", function(Value)
    loadstring(game:HttpGet("https://pastebin.com/raw/FLQ8735N"))()
end})



