game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "🔫🗼";
	Text = "BY nimeA";
	Icon = "rbxassetid://76048685357353"})
Duration = 5;

workspace.Builds.GamepassPads:Destroy()

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Lib/main/source.lua"))()

local window = library:Window("weapon 🔫🔫🔫 tower 🗼")

window:Button("fly gui", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/chpokerromajdwuifjw/Boblox/refs/heads/main/Flyguinoad.lua"))()
end)
-- Name of button, callback
window:Button("slap all(hold slap)", function()
   for i,v in pairs(game.Players:GetPlayers()) do
   if v == game.Players.LocalPlayer then
    else
local args = {
	"slash",
	v.Character,
	vector.create(0.5428807139396667, -4.831209565736572e-08, 3.96298885345459)
}
game:GetService("Players").LocalPlayer.Character:WaitForChild("SlapHand"):WaitForChild("Event"):FireServer(unpack(args))
end
end
end)

window:Button("kill all(hold slap)", function()
   for i,v in pairs(game.Players:GetPlayers()) do
   if v == game.Players.LocalPlayer then
    else
local args = {
	"slash",
	v.Character,
	vector.create(0, -9e8, 0)
}
game:GetService("Players").LocalPlayer.Character:WaitForChild("SlapHand"):WaitForChild("Event"):FireServer(unpack(args))
end
end
end)

-- Name of the toggle, default state of the toggle, callback

local slapLoop = false -- глобальна змінна для контролю циклу

window:Toggle("slap all loop(hold slap)", false, function(state)
    slapLoop = state
    if state then
        task.spawn(function()
            while slapLoop do
                task.wait(0) -- невелика затримка щоб не заспамити сервер
                for i, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then
                        local args = {
                            "slash",
                            v.Character,
                            vector.create(0.5428807139396667, -4.831209565736572e-08, 3.96298885345459)
                        }
                        game:GetService("Players").LocalPlayer.Character:WaitForChild("SlapHand"):WaitForChild("Event"):FireServer(unpack(args))
                    end
                end
            end
        end)
    end
end)

window:Toggle("kill all loop(hold slap)", false, function(state1)
    slapLoop1 = state1
    if state1 then
        task.spawn(function()
            while slapLoop1 do
                task.wait(0) -- невелика затримка щоб не заспамити сервер
                for i, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer then
                        local args = {
                            "slash",
                            v.Character,
                            vector.create(0, -9e8, 0)
                        }
                        game:GetService("Players").LocalPlayer.Character:WaitForChild("SlapHand"):WaitForChild("Event"):FireServer(unpack(args))
                    end
                end
            end
        end)
    end
end)
