local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- Load Turtle-Lib
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()

-- Sound Effects
local function playSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

-- Play initial sound
playSound("2865227271")

-- Configuration table
local config = {
    radius = 50,
    height = 10,
    rotationSpeed = 10,
    attractionStrength = 1000,
}

-- ════════════════════════════════════════════
--              TURTLE-LIB GUI
-- ════════════════════════════════════════════

local window = library:Window("part ring remake by csc®")

-- Credits label (rainbow)
window:Label("0_0")

-- ─── Toggle ───────────────────────────────
local ringPartsEnabled = false

window:Toggle("Tornado Ring", false, function(bool)
    ringPartsEnabled = bool
    playSound("12221967")
end)

-- ─── Sliders ──────────────────────────────
window:Slider("Radius", 0, 1000, config.radius, function(value)
    config.radius = value
    saveConfig()
    playSound("12221967")
end)

window:Slider("Height", 0, 500, config.height, function(value)
    config.height = value
    saveConfig()
    playSound("12221967")
end)

window:Slider("Rotation Speed", 0, 100, config.rotationSpeed, function(value)
    config.rotationSpeed = value
    saveConfig()
    playSound("12221967")
end)

window:Slider("Attraction Strength", 0, 10000, config.attractionStrength, function(value)
    config.attractionStrength = value
    saveConfig()
    playSound("12221967")
end)

-- ─── Credit label ─────────────────────────
window:Label("made by csc® and claude", Color3.fromRGB(0, 204, 204))

-- ════════════════════════════════════════════
--          RING / TORNADO LOGIC
-- ════════════════════════════════════════════

local Workspace = game:GetService("Workspace")

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Network ownership claim
local Folder = Instance.new("Folder", Workspace)
local Part = Instance.new("Part", Folder)
local Attachment1 = Instance.new("Attachment", Part)
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1

if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    }

    Network.RetainPart = function(Part)
        if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
            table.insert(Network.BaseParts, Part)
            Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            Part.CanCollide = false
        end
    end

    local function EnablePartControl()
        LocalPlayer.ReplicationFocus = Workspace
        RunService.Heartbeat:Connect(function()
            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
            for _, p in pairs(Network.BaseParts) do
                if p:IsDescendantOf(Workspace) then
                    p.Velocity = Network.Velocity
                end
            end
        end)
    end

    EnablePartControl()
end

-- Part tracking
local function RetainPart(p)
    if p:IsA("BasePart") and not p.Anchored and p:IsDescendantOf(workspace) then
        if p.Parent == LocalPlayer.Character or p:IsDescendantOf(LocalPlayer.Character) then
            return false
        end
        p.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        p.CanCollide = false
        return true
    end
    return false
end

local parts = {}

local function addPart(part)
    if RetainPart(part) then
        if not table.find(parts, part) then
            table.insert(parts, part)
        end
    end
end

local function removePart(part)
    local index = table.find(parts, part)
    if index then
        table.remove(parts, index)
    end
end

for _, part in pairs(workspace:GetDescendants()) do
    addPart(part)
end

workspace.DescendantAdded:Connect(addPart)
workspace.DescendantRemoving:Connect(removePart)

-- Tornado heartbeat
RunService.Heartbeat:Connect(function()
    if not ringPartsEnabled then return end

    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local tornadoCenter = hrp.Position

    for _, part in pairs(parts) do
        if part and part.Parent and not part.Anchored then
            local pos = part.Position
            local angle = math.atan2(pos.Z - tornadoCenter.Z, pos.X - tornadoCenter.X)
            local newAngle = angle + math.rad(config.rotationSpeed)
            local distance = (Vector3.new(pos.X, tornadoCenter.Y, pos.Z) - tornadoCenter).Magnitude

            local targetPos = Vector3.new(
                tornadoCenter.X + math.cos(newAngle) * config.radius,
                tornadoCenter.Y + (config.height * math.abs(math.sin((pos.Y - tornadoCenter.Y) / math.max(config.height, 1)))),
                tornadoCenter.Z + math.sin(newAngle) * config.radius
            )

            local direction = (targetPos - pos).Unit
            part.Velocity = direction * config.attractionStrength
        end
    end
end)

-- Update HRP reference on respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)
