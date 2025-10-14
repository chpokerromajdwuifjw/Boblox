-- Create GUI
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Make sure GUI stays after death
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UpRepeaterGUI"
ScreenGui.ResetOnSpawn = false -- <== keeps GUI after respawn
ScreenGui.Parent = PlayerGui

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 150, 0, 50)
Button.Position = UDim2.new(1, -160, 0, 10) -- top-right corner
Button.BackgroundColor3 = Color3.fromRGB(30, 200, 50)
Button.Text = "Start"
Button.TextScaled = true
Button.Parent = ScreenGui

-- Control variable
local running = false

-- Function to repeat action
local function repeatAction()
	for i = 1, 200 do
		if not running then
			break
		end

		local args = {"Up"}
		game:GetService("ReplicatedStorage")
			:WaitForChild("Honeypot")
			:WaitForChild("Internal")
			:WaitForChild("RemoteStorage")
			:WaitForChild("UIControl - RemoteEvent")
			:FireServer(unpack(args))
	end

	running = false
	Button.Text = "Start"
	Button.BackgroundColor3 = Color3.fromRGB(30, 200, 50)
end

-- Button On/Off
Button.MouseButton1Click:Connect(function()
	if not running then
		running = true
		Button.Text = "Running..."
		Button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		task.spawn(repeatAction)
	else
		running = false
		Button.Text = "Start"
		Button.BackgroundColor3 = Color3.fromRGB(30, 200, 50)
	end
end)
