local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()

local window = library:Window("Dance GUI")

local dances = {
    "4555808220",
    "10214311282",
    "10714010337",
}

local player = game.Players.LocalPlayer
local running = false
local currentIndex = 1
local currentTrack = nil
local currentConnection = nil

local function stopDance()
    if currentTrack then
        currentTrack:Stop()
        currentTrack:Destroy()
        currentTrack = nil
    end
    
    if currentConnection then
        currentConnection:Disconnect()
        currentConnection = nil
    end
end

local function playNextDance()
    if not running then return end

    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    stopDance()

    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://" .. dances[currentIndex]

    currentTrack = humanoid:LoadAnimation(animation)
    currentTrack.Looped = false
    currentTrack:Play()

    currentConnection = currentTrack.Stopped:Connect(function()
        if running then
            currentIndex = currentIndex % #dances + 1
            task.wait(0.15)
            playNextDance()
        end
    end)
end

window:Toggle("Loop Dances", false, function(state)
    running = state
    
    if running then
        currentIndex = 1
        playNextDance()
    else
        stopDance()
    end
end)
