-- 🔧 Локальний скрипт з GUI On/Off для атаки

-- === GUI ===
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "AttackToggleGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 100, 0, 40)
button.Position = UDim2.new(0.05, 0, 0.8, 0)
button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
button.Text = "OFF"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 24
button.Parent = gui

-- === ЛОГІКА ===
local enabled = false

local function setState(state)
	enabled = state
	if enabled then
		button.Text = "ON"
		button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
	else
		button.Text = "OFF"
		button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	end
end

button.MouseButton1Click:Connect(function()
	setState(not enabled)
end)

-- === АТАКА ===
task.spawn(function()
	while true do
		task.wait(0.1)
		if enabled then
			local Players = game:GetService("Players")
			local localPlayer = Players.LocalPlayer

			for _, v in pairs(Players:GetPlayers()) do
				if v ~= localPlayer and v.Name ~= "alredyinuse97" then
					local targetChar = v.Character
					local myChar = localPlayer and localPlayer.Character
					local slapHandEvent = myChar and myChar:FindFirstChild("SlapHand") and myChar.SlapHand:FindFirstChild("Event")

					if targetChar and slapHandEvent then
						local args = {
							"slash",
							targetChar,
							Vector3.new(2.578049421310425, -2.1729036348006048e-08, -3.058375597000122)
						}
						pcall(function()
							slapHandEvent:FireServer(unpack(args))
						end)
					end
				end
			end
		end
	end
end)
