--// === GUI створення === \\--
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Name = "ESP_GUI"
ScreenGui.Parent = game.CoreGui

ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(1, -120, 0, 20) -- справа зверху
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "ESP: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 20

--// === Змінні === \\--
local espEnabled = false
local player = game.Players.LocalPlayer

--// === Функція перемикання ESP === \\--
local function toggleESP()
    espEnabled = not espEnabled
    ToggleButton.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    ToggleButton.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(30, 30, 30)
end

ToggleButton.MouseButton1Click:Connect(toggleESP)

--// === Функція створення ESP-боксу === \\--
local function createESP(model)
    if not model:FindFirstChild("Humanoid") then return end
    if model:FindFirstChild("EspBox") then return end
    if model == player.Character then return end

    local esp = Instance.new("BoxHandleAdornment")
    esp.Name = "EspBox"
    esp.Adornee = model
    esp.Size = Vector3.new(4, 5, 3)
    esp.Transparency = 0.25
    esp.Color3 = Color3.fromRGB(22, 100, 8)
    esp.AlwaysOnTop = true
    esp.ZIndex = 0
    esp.Parent = model
end

--// === Головний цикл ESP === \\--
task.spawn(function()
    while task.wait(0.5) do
        if espEnabled then
            for _, obj in ipairs(workspace:GetDescendants()) do
                createESP(obj)
            end
        else
            for _, obj in ipairs(workspace:GetDescendants()) do
                local esp = obj:FindFirstChild("EspBox")
                if esp then
                    esp:Destroy()
                end
            end
        end
    end
end)

--// === Перевірка на смерть/відродження === \\--
player.CharacterAdded:Connect(function()
    task.wait(2) -- невелика затримка, щоб персонаж повністю створився
    if espEnabled then
        for _, obj in ipairs(workspace:GetDescendants()) do
            createESP(obj)
        end
    end
end)