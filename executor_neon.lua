-- Executor (by csc(R)) | Neon Cyber Reskin

local cloneref = cloneref or function(o) return o end

local Services = Services or setmetatable({}, {
	__index = function(self, name)
		local success, cache = pcall(function()
			return cloneref(game:GetService(name))
		end)
		if success then
			rawset(self, name, cache)
			return cache
		end
	end
})

local function GuiParent()
	if PARENT then return PARENT end

	local CoreGui = Services.CoreGui or cloneref(Services.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui"))
	local MAX_DISPLAY_ORDER = 2147483647

	local function randomString()
		local length = math.random(10,20)
		local array = {}
		for i = 1, length do
			array[i] = string.char(math.random(32, 126))
		end
		return table.concat(array)
	end

	if get_hidden_gui or gethui then
		local hiddenUI = get_hidden_gui or gethui
		local Main = Instance.new("ScreenGui")
		Main.Name = randomString()
		Main.ResetOnSpawn = false
		Main.DisplayOrder = MAX_DISPLAY_ORDER
		Main.Parent = hiddenUI()
		CoreGui = Main
	elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
		local Main = Instance.new("ScreenGui")
		Main.Name = randomString()
		Main.ResetOnSpawn = false
		Main.DisplayOrder = MAX_DISPLAY_ORDER
		syn.protect_gui(Main)
		Main.Parent = CoreGui
		CoreGui = Main
	elseif CoreGui:FindFirstChild("RobloxGui") then
		CoreGui = CoreGui.RobloxGui
	else
		local Main = Instance.new("ScreenGui")
		Main.Name = randomString()
		Main.ResetOnSpawn = false
		Main.DisplayOrder = MAX_DISPLAY_ORDER
		Main.Parent = CoreGui
		CoreGui = Main
	end

	return CoreGui
end

-- ╔═══════════════════════════════════════╗
-- ║   NEON CYBER EXECUTOR  //  csc(R)   ║
-- ║   ██████╗██╗   ██╗██████╗ ███████╗   ║
-- ║  ██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝   ║
-- ║  ██║      ╚████╔╝ ██████╔╝█████╗     ║
-- ║  ██║       ╚██╔╝  ██╔══██╗██╔══╝     ║
-- ║  ╚██████╗   ██║   ██████╔╝███████╗   ║
-- ║   ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝   ║
-- ╚═══════════════════════════════════════╝

-- NEON CYBER PALETTE:
--   Background:  #0A0A12  (8, 8, 18)
--   Panel:       #0D0D1A  (13, 13, 26)
--   Topbar:      #10101F  (16, 16, 31)
--   Accent Cyan: #00FFFF  (0, 255, 255)
--   Accent Pink: #FF00AA  (255, 0, 170)
--   Neon Green:  #00FF7F  (0, 255, 127)
--   Neon Purple: #CC00FF  (204, 0, 255)
--   Neon Yellow: #FFEE00  (255, 238, 0)
--   Dim Text:    #4A4A6A  (74, 74, 106)
--   Button BG:   #1A1A2E  (26, 26, 46)
--   Border Glow: #00FFFF  (0, 255, 255)

local G2L = {}

G2L["1"] = GuiParent()

-- ── Topbar ──────────────────────────────────────────────────────────────────
G2L["2"] = Instance.new("Frame", G2L["1"])
G2L["2"]["BorderSizePixel"] = 0
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(10, 10, 20)       -- near-black cyber bg
G2L["2"]["Size"] = UDim2.new(0, 473, 0, 22)
G2L["2"]["Position"] = UDim2.new(0.3546, 0, 0.33567, 0)
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 255, 255)
G2L["2"]["Name"] = "Topbar"

-- Cyan top border stripe (neon glow effect)
local topGlow = Instance.new("Frame", G2L["2"])
topGlow.Name = "TopGlow"
topGlow.BorderSizePixel = 0
topGlow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
topGlow.Size = UDim2.new(1, 0, 0, 1)
topGlow.Position = UDim2.new(0, 0, 0, 0)

-- ── Topbar Label ────────────────────────────────────────────────────────────
G2L["4"] = Instance.new("TextLabel", G2L["2"])
G2L["4"]["TextWrapped"] = true
G2L["4"]["BorderSizePixel"] = 0
G2L["4"]["TextSize"] = 13
G2L["4"]["BackgroundTransparency"] = 1
G2L["4"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["4"]["TextColor3"] = Color3.fromRGB(0, 255, 255)            -- neon cyan title
G2L["4"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["4"]["Text"] = [[> EXEC // csc(R)]]

-- ── Close Button ────────────────────────────────────────────────────────────
G2L["5"] = Instance.new("ImageButton", G2L["2"])
G2L["5"]["BorderSizePixel"] = 0
G2L["5"]["BackgroundTransparency"] = 1
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["5"]["Image"] = [[rbxassetid://11293981586]]
G2L["5"]["Size"] = UDim2.new(0, 17, 0, 17)
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["5"]["Position"] = UDim2.new(0.95137, 0, 0.05, 0)
G2L["5"]["ImageColor3"] = Color3.fromRGB(255, 0, 100)           -- neon pink close icon

G2L["6"] = Instance.new("LocalScript", G2L["5"])

-- ── Minimize Button ─────────────────────────────────────────────────────────
G2L["7"] = Instance.new("ImageButton", G2L["2"])
G2L["7"]["BorderSizePixel"] = 0
G2L["7"]["BackgroundTransparency"] = 1
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["7"]["Image"] = [[rbxassetid://11421092947]]
G2L["7"]["Size"] = UDim2.new(0, 17, 0, 17)
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["7"]["Position"] = UDim2.new(0.89429, 0, 0.05, 0)
G2L["7"]["ImageColor3"] = Color3.fromRGB(0, 255, 200)           -- neon teal minimize icon

G2L["8"] = Instance.new("LocalScript", G2L["7"])

-- ── Main Panel ──────────────────────────────────────────────────────────────
G2L["9"] = Instance.new("Frame", G2L["2"])
G2L["9"]["BorderSizePixel"] = 0
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(8, 8, 18)         -- deep cyber dark
G2L["9"]["Size"] = UDim2.new(0, 473, 0, 241)
G2L["9"]["Position"] = UDim2.new(0, 0, 1, 0)
G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 255, 255)
G2L["9"]["Name"] = "MainStuff"

-- Cyan bottom/side border glow
local borderBottom = Instance.new("Frame", G2L["9"])
borderBottom.BorderSizePixel = 0
borderBottom.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
borderBottom.Size = UDim2.new(1, 0, 0, 1)
borderBottom.Position = UDim2.new(0, 0, 1, -1)

local borderLeft = Instance.new("Frame", G2L["9"])
borderLeft.BorderSizePixel = 0
borderLeft.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
borderLeft.Size = UDim2.new(0, 1, 1, 0)
borderLeft.Position = UDim2.new(0, 0, 0, 0)

local borderRight = Instance.new("Frame", G2L["9"])
borderRight.BorderSizePixel = 0
borderRight.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
borderRight.Size = UDim2.new(0, 1, 1, 0)
borderRight.Position = UDim2.new(1, -1, 0, 0)

-- ── Editor ScrollingFrame ────────────────────────────────────────────────────
G2L["a"] = Instance.new("ScrollingFrame", G2L["9"])
G2L["a"]["Active"] = true
G2L["a"]["BorderSizePixel"] = 0
G2L["a"]["CanvasSize"] = UDim2.new(1, 0, 1, 0)
G2L["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["a"]["Size"] = UDim2.new(1, 0, 0.86975, 0)
G2L["a"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 255, 255)  -- neon cyan scrollbar
G2L["a"]["Position"] = UDim2.new(0, 0, 0, 0)
G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["a"]["ScrollBarThickness"] = 2
G2L["a"]["BackgroundTransparency"] = 1

G2L["b"] = Instance.new("LocalScript", G2L["a"])
G2L["c"] = Instance.new("LocalScript", G2L["a"])
G2L["d"] = Instance.new("LocalScript", G2L["a"])

-- ── Line Numbers ─────────────────────────────────────────────────────────────
G2L["e"] = Instance.new("TextLabel", G2L["a"])
G2L["e"]["BorderSizePixel"] = 0
G2L["e"]["TextSize"] = 14
G2L["e"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["e"]["BackgroundColor3"] = Color3.fromRGB(8, 8, 18)
G2L["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["e"]["TextColor3"] = Color3.fromRGB(0, 180, 180)            -- dim cyan line numbers
G2L["e"]["BackgroundTransparency"] = 0.6
G2L["e"]["Size"] = UDim2.new(0, 40, 0, 239)
G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["e"]["Text"] = [[1\n]]
G2L["e"]["Name"] = "Lines"

G2L["f"] = Instance.new("LocalScript", G2L["e"])

-- ── Text Editor (ResponseLabel) ──────────────────────────────────────────────
G2L["10"] = Instance.new("TextBox", G2L["a"])
G2L["10"]["Name"] = "ResponseLabel"
G2L["10"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["10"]["BorderSizePixel"] = 0
G2L["10"]["TextSize"] = 14
G2L["10"]["TextColor3"] = Color3.fromRGB(220, 230, 255)         -- soft white-blue base text
G2L["10"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["10"]["BackgroundColor3"] = Color3.fromRGB(8, 8, 18)
G2L["10"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["10"]["MultiLine"] = true
G2L["10"]["ClearTextOnFocus"] = false
G2L["10"]["Size"] = UDim2.new(1, 0, 0, 239)
G2L["10"]["Position"] = UDim2.new(0, 50, 0, 0)
G2L["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["10"]["Text"] = [[print("Hello world")]]
G2L["10"]["BackgroundTransparency"] = 1

G2L["11"] = Instance.new("LocalScript", G2L["10"])

-- ── Syntax Highlight Layers ──────────────────────────────────────────────────

-- Comments  →  dim green
G2L["12"] = Instance.new("TextLabel", G2L["10"])
G2L["12"]["ZIndex"] = 5
G2L["12"]["TextSize"] = 14
G2L["12"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["12"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["12"]["BackgroundTransparency"] = 1
G2L["12"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["12"]["TextColor3"] = Color3.fromRGB(80, 200, 80)           -- muted neon green comments
G2L["12"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["12"]["Text"] = [[]]
G2L["12"]["Name"] = "Comments_"

-- Globals  →  electric cyan
G2L["13"] = Instance.new("TextLabel", G2L["10"])
G2L["13"]["ZIndex"] = 5
G2L["13"]["TextSize"] = 14
G2L["13"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["13"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["13"]["BackgroundTransparency"] = 1
G2L["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["13"]["TextColor3"] = Color3.fromRGB(0, 240, 255)           -- electric cyan globals
G2L["13"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["13"]["Text"] = [[]]
G2L["13"]["Name"] = "Globals_"

-- Keywords  →  hot magenta/pink
G2L["14"] = Instance.new("TextLabel", G2L["10"])
G2L["14"]["ZIndex"] = 5
G2L["14"]["TextSize"] = 14
G2L["14"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["14"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["14"]["BackgroundTransparency"] = 1
G2L["14"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["14"]["TextColor3"] = Color3.fromRGB(255, 50, 180)          -- hot neon pink keywords
G2L["14"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["14"]["Text"] = [[]]
G2L["14"]["Name"] = "Keywords_"

-- Numbers  →  neon yellow-gold
G2L["15"] = Instance.new("TextLabel", G2L["10"])
G2L["15"]["ZIndex"] = 4
G2L["15"]["TextSize"] = 14
G2L["15"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["15"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["15"]["BackgroundTransparency"] = 1
G2L["15"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["15"]["TextColor3"] = Color3.fromRGB(255, 220, 0)           -- neon yellow numbers
G2L["15"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["15"]["Text"] = [[]]
G2L["15"]["Name"] = "Numbers_"

-- Remote calls  →  vivid electric blue
G2L["16"] = Instance.new("TextLabel", G2L["10"])
G2L["16"]["ZIndex"] = 5
G2L["16"]["TextSize"] = 14
G2L["16"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["16"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["16"]["BackgroundTransparency"] = 1
G2L["16"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["16"]["TextColor3"] = Color3.fromRGB(50, 150, 255)          -- vivid blue remotes
G2L["16"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["16"]["Text"] = [[]]
G2L["16"]["Name"] = "RemoteHighlight_"

-- Strings  →  neon mint green
G2L["17"] = Instance.new("TextLabel", G2L["10"])
G2L["17"]["ZIndex"] = 5
G2L["17"]["TextSize"] = 14
G2L["17"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["17"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["17"]["BackgroundTransparency"] = 1
G2L["17"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["17"]["TextColor3"] = Color3.fromRGB(80, 255, 160)          -- neon mint strings
G2L["17"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["17"]["Text"] = [[]]
G2L["17"]["Name"] = "Strings_"

-- Tokens / operators  →  soft lavender white
G2L["18"] = Instance.new("TextLabel", G2L["10"])
G2L["18"]["ZIndex"] = 5
G2L["18"]["TextSize"] = 14
G2L["18"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["18"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["18"]["BackgroundTransparency"] = 1
G2L["18"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["18"]["TextColor3"] = Color3.fromRGB(200, 200, 255)         -- soft lavender tokens
G2L["18"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["18"]["Text"] = [[]]
G2L["18"]["Name"] = "Tokens_"

-- Line highlight  →  deep purple tint
G2L["19"] = Instance.new("Frame", G2L["10"])
G2L["19"]["ZIndex"] = 0
G2L["19"]["BorderSizePixel"] = 0
G2L["19"]["BackgroundColor3"] = Color3.fromRGB(60, 0, 100)      -- deep neon purple line hl
G2L["19"]["Name"] = "LineHighlight"
G2L["19"]["BackgroundTransparency"] = 0.6

-- Custom caret  →  hot pink pulse bar
G2L["1a"] = Instance.new("Frame", G2L["10"])
G2L["1a"]["Visible"] = false
G2L["1a"]["ZIndex"] = 2
G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 170)     -- hot pink caret
G2L["1a"]["Size"] = UDim2.new(0, 1, 0, 16)
G2L["1a"]["Name"] = "CustomCaret"

-- Selection highlight  →  cyan tint
G2L["1b"] = Instance.new("Frame", G2L["10"])
G2L["1b"]["Visible"] = false
G2L["1b"]["BorderSizePixel"] = 0
G2L["1b"]["BackgroundColor3"] = Color3.fromRGB(0, 200, 255)     -- cyan selection hl
G2L["1b"]["Name"] = "SelectionHighlight"
G2L["1b"]["BackgroundTransparency"] = 0.65

-- ── Bottom Buttons (helper to create styled buttons) ─────────────────────────
local function makeNeonButton(parent, text, posX, posY, accentColor)
	local btn = Instance.new("TextButton", parent)
	btn["BorderSizePixel"] = 1
	btn["TextSize"] = 13
	btn["TextColor3"] = accentColor
	btn["BackgroundColor3"] = Color3.fromRGB(13, 13, 26)
	btn["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	btn["Size"] = UDim2.new(0, 90, 0, 20)
	btn["BorderColor3"] = accentColor
	btn["Text"] = text
	btn["Position"] = UDim2.new(posX, 0, posY, 0)
	-- Hover glow effect via UIStroke
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = accentColor
	stroke.Thickness = 1
	stroke.Transparency = 0.4
	return btn
end

-- Execute  →  neon cyan
G2L["1c"] = makeNeonButton(G2L["9"], "> EXEC", 0.795, 0.895, Color3.fromRGB(0, 255, 255))
G2L["1d"] = Instance.new("LocalScript", G2L["1c"])

-- Clear  →  hot pink
G2L["1e"] = makeNeonButton(G2L["9"], "CLEAR", 0.58778, 0.895, Color3.fromRGB(255, 50, 150))
G2L["1f"] = Instance.new("LocalScript", G2L["1e"])

-- Save  →  neon green
G2L["20"] = makeNeonButton(G2L["9"], "SAVE", 0.38485, 0.895, Color3.fromRGB(0, 255, 127))
G2L["20"]["Size"] = UDim2.new(0, 89, 0, 20)
G2L["21"] = Instance.new("LocalScript", G2L["20"])

-- Open  →  neon purple
G2L["22"] = makeNeonButton(G2L["9"], "OPEN", 0.177, 0.895, Color3.fromRGB(180, 50, 255))
G2L["23"] = Instance.new("LocalScript", G2L["22"])

-- ── Open/Save Dialog Overlay ─────────────────────────────────────────────────
G2L["24"] = Instance.new("Frame", G2L["9"])
G2L["24"]["Visible"] = false
G2L["24"]["BorderSizePixel"] = 0
G2L["24"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
G2L["24"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["24"]["Name"] = "opensavedialog"
G2L["24"]["BackgroundTransparency"] = 0.35

local function makeDialogFrame(parent, name)
	local f = Instance.new("Frame", parent)
	f["Visible"] = false
	f["BorderSizePixel"] = 1
	f["BackgroundColor3"] = Color3.fromRGB(10, 10, 22)
	f["AnchorPoint"] = Vector2.new(0.5, 0.5)
	f["Size"] = UDim2.new(0, 327, 0, 76)
	f["Position"] = UDim2.new(0.5, 0, 0.5, 0)
	f["BorderColor3"] = Color3.fromRGB(0, 255, 255)
	f["Name"] = name
	-- Cyan border stroke
	local stroke = Instance.new("UIStroke", f)
	stroke.Color = Color3.fromRGB(0, 255, 255)
	stroke.Thickness = 1
	return f
end

local function makeDialogTextBox(parent)
	local tb = Instance.new("TextBox", parent)
	tb["BorderSizePixel"] = 1
	tb["TextWrapped"] = true
	tb["TextSize"] = 14
	tb["TextColor3"] = Color3.fromRGB(0, 255, 255)
	tb["BackgroundColor3"] = Color3.fromRGB(8, 8, 20)
	tb["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	tb["ClearTextOnFocus"] = false
	tb["PlaceholderText"] = [[filename...]]
	tb["Size"] = UDim2.new(0, 308, 0, 26)
	tb["Position"] = UDim2.new(0.03058, 0, 0.11368, 0)
	tb["BorderColor3"] = Color3.fromRGB(0, 255, 255)
	tb["Text"] = [[]]
	local stroke = Instance.new("UIStroke", tb)
	stroke.Color = Color3.fromRGB(0, 255, 255)
	stroke.Thickness = 1
	return tb
end

local function makeDialogButton(parent, text, posX, color)
	local btn = Instance.new("TextButton", parent)
	btn["BorderSizePixel"] = 1
	btn["TextSize"] = 14
	btn["TextColor3"] = color
	btn["BackgroundColor3"] = Color3.fromRGB(12, 12, 24)
	btn["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	btn["Size"] = UDim2.new(0, 100, 0, 22)
	btn["BorderColor3"] = color
	btn["Text"] = text
	btn["Position"] = UDim2.new(posX, 0, 0.57895, 0)
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = color
	stroke.Thickness = 1
	return btn
end

-- Save dialog
G2L["25"] = makeDialogFrame(G2L["24"], "save")
G2L["26"] = makeDialogTextBox(G2L["25"])
G2L["27"] = makeDialogButton(G2L["25"], "SAVE", 0.66667, Color3.fromRGB(0, 255, 127))
G2L["28"] = Instance.new("LocalScript", G2L["27"])
G2L["29"] = makeDialogButton(G2L["25"], "CANCEL", 0.34557, Color3.fromRGB(255, 50, 150))
G2L["2a"] = Instance.new("LocalScript", G2L["29"])

-- Open dialog
G2L["2b"] = makeDialogFrame(G2L["24"], "open")
G2L["2c"] = makeDialogTextBox(G2L["2b"])
G2L["2d"] = makeDialogButton(G2L["2b"], "OPEN", 0.66667, Color3.fromRGB(180, 50, 255))
G2L["2e"] = Instance.new("LocalScript", G2L["2d"])
G2L["2f"] = makeDialogButton(G2L["2b"], "CANCEL", 0.34557, Color3.fromRGB(255, 50, 150))
G2L["30"] = Instance.new("LocalScript", G2L["2f"])

-- ════════════════════════════════════════════════════════════════════════════
--  SCRIPT LOGIC  (unchanged from original, only UI refs updated above)
-- ════════════════════════════════════════════════════════════════════════════

-- Drag
local function C_3()
	local script = G2L["3"]
	local UserInputService = Services.UserInputService
	local gui = G2L["2"]
	local dragging, dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then update(input) end
	end)
end
task.spa.Position           = UDim2.new(posX, 0, 0, 224)
	btn.Text               = label
	btn.AutoButtonColor    = false
	round(btn, 8)
	addStroke(btn, accentColor, 1, 0.2)
	btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(24, 16, 48) end)
	btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(16, 10, 34) end)
	return btn
end

G2L["1c"] = makeBtn(G2L["9"], "> EXECUTE", 0.59, Color3.fromRGB(0, 240, 255))
G2L["1d"] = Instance.new("LocalScript", G2L["1c"])

G2L["1e"] = makeBtn(G2L["9"], "x CLEAR",   0.39, Color3.fromRGB(255, 60, 140))
G2L["1f"] = Instance.new("LocalScript", G2L["1e"])

G2L["20"] = makeBtn(G2L["9"], "v SAVE",    0.20, Color3.fromRGB(0, 255, 130))
G2L["21"] = Instance.new("LocalScript", G2L["20"])

G2L["22"] = makeBtn(G2L["9"], "^ OPEN",    0.01, Color3.fromRGB(170, 60, 255))
G2L["23"] = Instance.new("LocalScript", G2L["22"])

-- ═══════════════════════════════════════════
--  DIALOG OVERLAY
-- ═══════════════════════════════════════════
G2L["24"] = Instance.new("Frame", G2L["9"])
G2L["24"].Name               = "opensavedialog"
G2L["24"].Visible            = false
G2L["24"].BorderSizePixel    = 0
G2L["24"].BackgroundColor3   = Color3.fromRGB(0, 0, 0)
G2L["24"].BackgroundTransparency = 0.4
G2L["24"].Size               = UDim2.new(1, 0, 1, 0)
round(G2L["24"], 12)

local function makeDialog(parent, name)
	local f = Instance.new("Frame", parent)
	f.Name               = name
	f.Visible            = false
	f.BorderSizePixel    = 0
	f.BackgroundColor3   = Color3.fromRGB(11, 10, 26)
	f.AnchorPoint        = Vector2.new(0.5, 0.5)
	f.Size               = UDim2.new(0, 340, 0, 88)
	f.Position           = UDim2.new(0.5, 0, 0.5, 0)
	round(f, 14)
	addStroke(f, Color3.fromRGB(0, 220, 255), 1.5, 0)
	local g = Instance.new("UIGradient", f)
	g.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 8, 40)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 14, 28)),
	})
	g.Rotation = 120
	return f
end

local function makeDialogInput(parent)
	local tb = Instance.new("TextBox", parent)
	tb.BorderSizePixel      = 0
	tb.TextSize             = 14
	tb.TextColor3           = Color3.fromRGB(0, 240, 255)
	tb.BackgroundColor3     = Color3.fromRGB(7, 7, 20)
	tb.FontFace             = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	tb.ClearTextOnFocus     = false
	tb.PlaceholderText      = [[filename...]]
	tb.PlaceholderColor3    = Color3.fromRGB(0, 100, 120)
	tb.Size                 = UDim2.new(1, -24, 0, 30)
	tb.Position             = UDim2.new(0, 12, 0, 10)
	tb.Text                 = [[]]
	round(tb, 8)
	addStroke(tb, Color3.fromRGB(0, 200, 255), 1, 0.3)
	return tb
end

local function makeDialogBtn(parent, label, posX, color)
	local btn = Instance.new("TextButton", parent)
	btn.BorderSizePixel  = 0
	btn.TextSize         = 13
	btn.TextColor3       = color
	btn.BackgroundColor3 = Color3.fromRGB(14, 12, 30)
	btn.FontFace         = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	btn.Size             = UDim2.new(0, 108, 0, 24)
	btn.Position         = UDim2.new(posX, 0, 1, -32)
	btn.Text             = label
	btn.AutoButtonColor  = false
	round(btn, 8)
	addStroke(btn, color, 1, 0.2)
	btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(22, 16, 46) end)
	btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(14, 12, 30) end)
	return btn
end

-- Save dialog
G2L["25"] = makeDialog(G2L["24"], "save")
G2L["26"] = makeDialogInput(G2L["25"])
G2L["27"] = makeDialogBtn(G2L["25"], "v SAVE",   0.55, Color3.fromRGB(0, 255, 130))
G2L["28"] = Instance.new("LocalScript", G2L["27"])
G2L["29"] = makeDialogBtn(G2L["25"], "x CANCEL", 0.07, Color3.fromRGB(255, 60, 140))
G2L["2a"] = Instance.new("LocalScript", G2L["29"])

-- Open dialog
G2L["2b"] = makeDialog(G2L["24"], "open")
G2L["2c"] = makeDialogInput(G2L["2b"])
G2L["2d"] = makeDialogBtn(G2L["2b"], "^ OPEN",   0.55, Color3.fromRGB(170, 60, 255))
G2L["2e"] = Instance.new("LocalScript", G2L["2d"])
G2L["2f"] = makeDialogBtn(G2L["2b"], "x CANCEL", 0.07, Color3.fromRGB(255, 60, 140))
G2L["30"] = Instance.new("LocalScript", G2L["2f"])

-- ════════════════════════════════════════════════════════════════════════════
--  LOGIC
-- ════════════════════════════════════════════════════════════════════════════

-- Drag
local function C_3()
	local UIS = Services.UserInputService
	local gui = G2L["2"]
	local dragging, dragInput, dragStart, startPos

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			dragging  = true
			dragStart = input.Position
			startPos  = gui.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			gui.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end
task.spawn(C_3)

-- Close
local function C_6()
	G2L["5"].MouseButton1Click:Connect(function() G2L["2"]:Destroy() end)
end
task.spawn(C_6)

-- Minimize
local function C_8()
	G2L["7"].MouseButton1Click:Connect(function()
		G2L["9"].Visible = not G2L["9"].Visible
	end)
end
task.spawn(C_8)

-- Auto-scroll
local function C_b()
	local Tws = Services.TweenService
	local TS  = Services.TextService
	local sf  = G2L["a"]
	local tb  = sf:FindFirstChildOfClass("TextBox")
	if not tb then return end
	local ti  = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local function scroll()
		local ts = TS:GetTextSize(tb.Text, tb.TextSize, tb.Font, Vector2.new(tb.AbsoluteSize.X, 10000))
		sf.CanvasSize = UDim2.new(1, 0, 0, math.max(ts.Y + 10, tb.AbsoluteSize.Y))
		local maxY = math.max(0, sf.CanvasSize.Y.Offset - sf.AbsoluteSize.Y)
		Tws:Create(sf, ti, { CanvasPosition = Vector2.new(sf.CanvasPosition.X, maxY) }):Play()
	end

	tb:GetPropertyChangedSignal("Text"):Connect(scroll)
	tb:GetPropertyChangedSignal("AbsoluteSize"):Connect(scroll)
	sf:GetPropertyChangedSignal("AbsoluteSize"):Connect(scroll)
	task.defer(scroll)
end
task.spawn(C_b)

-- Scroll-to-caret
local function C_c()
	local TS = Services.TextService
	local sf = G2L["a"]

	local function caretLine(tb)
		local text = tb.Text
		local cp   = tb.CursorPosition - 1
		if cp < 0 then return 1 end
		local n = 1
		for i = 1, cp do if text:sub(i, i) == "\n" then n += 1 end end
		return n
	end

	local function update()
		local tb = sf:FindFirstChildOfClass("TextBox")
		if not tb then return end
		local pad = sf:FindFirstChildOfClass("UIPadding")
		local lp  = pad and pad.PaddingLeft.Offset or 0
		local avW = sf.AbsoluteSize.X - lp
		local b   = TS:GetTextSize(tb.Text, tb.TextSize, tb.Font, Vector2.new(avW, 99999))
		sf.CanvasSize = UDim2.new(1, 0, 0, math.max(sf.AbsoluteSize.Y, b.Y + 5))
		if tb:IsFocused() then
			local lh   = TS:GetTextSize("A", tb.TextSize, tb.Font, Vector2.new(0, 0)).Y
			local ln   = caretLine(tb)
			local tY   = (ln - 1) * lh
			local maxY = math.max(0, b.Y - sf.AbsoluteSize.Y)
			sf.CanvasPosition = Vector2.new(0, math.clamp(tY - sf.AbsoluteSize.Y / 2, 0, maxY))
		end
	end

	sf.ChildAdded:Connect(function(child)
		if not child:IsA("TextBox") then return end
		update()
		child:GetPropertyChangedSignal("Text"):Connect(update)
		child:GetPropertyChangedSignal("CursorPosition"):Connect(update)
		child.Focused:Connect(update); child.FocusLost:Connect(update)
	end)
	sf.ChildRemoved:Connect(update)
	for _, ch in ipairs(sf:GetChildren()) do
		if ch:IsA("TextBox") then
			ch:GetPropertyChangedSignal("Text"):Connect(update)
			ch:GetPropertyChangedSignal("CursorPosition"):Connect(update)
			ch.Focused:Connect(update); ch.FocusLost:Connect(update)
		end
	end
	update()
	sf:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)
end
task.spawn(C_c)

-- Syntax highlighting
local function C_d()
	local lua_keywords = {
		"and","break","do","else","elseif","end","false","for",
		"function","goto","if","in","local","nil","not","or",
		"repeat","return","then","true","until","while"
	}
	local global_env = {
		"getrawmetatable","game","workspace","script","math","string",
		"table","print","wait","BrickColor","Color3","next","pairs",
		"ipairs","select","unpack","Instance","Vector2","Vector3",
		"CFrame","Ray","UDim2","Enum","assert","error","warn",
		"tick","loadstring","_G","shared","getfenv","setfenv",
		"newproxy","setmetatable","getmetatable","os","debug","pcall",
		"ypcall","xpcall","rawequal","rawset","rawget","tonumber",
		"tostring","type","typeof","_VERSION","coroutine","delay",
		"require","spawn","LoadLibrary","settings","stats","time",
		"UserSettings","version","Axes","ColorSequence","Faces",
		"ColorSequenceKeypoint","NumberRange","NumberSequence",
		"NumberSequenceKeypoint","gcinfo","elapsedTime","collectgarbage",
		"PhysicalProperties","Rect","Region3","Region3int16","UDim",
		"Vector2int16","Vector3int16",
		"cache.invalidate","cache.iscached","cache.replace","cloneref",
		"compareinstances","base64_encode","base64_decode",
		"debug.getconstant","debug.getconstants","debug.getinfo",
		"debug.getproto","debug.getprotos","debug.getupvalue",
		"debug.getupvalues","debug.setconstant","getgc",
		"getloadedmodules","getrunningscripts","getscripts","getsenv",
		"hookmetamethod","iscclosure","isexecutorclosure","islclosure",
		"newcclosure","setreadonly","lz4compress","lz4decompress",
		"getscriptclosure","request","getcallbackvalue","listfiles",
		"writefile","isfolder","makefolder","appendfile","isfile",
		"delfolder","delfile","loadfile","gethui","isreadonly",
		"getnamecallmet-- ║   ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝   ║
-- ╚═══════════════════════════════════════╝

-- NEON CYBER PALETTE:
--   Background:  #0A0A12  (8, 8, 18)
--   Panel:       #0D0D1A  (13, 13, 26)
--   Topbar:      #10101F  (16, 16, 31)
--   Accent Cyan: #00FFFF  (0, 255, 255)
--   Accent Pink: #FF00AA  (255, 0, 170)
--   Neon Green:  #00FF7F  (0, 255, 127)
--   Neon Purple: #CC00FF  (204, 0, 255)
--   Neon Yellow: #FFEE00  (255, 238, 0)
--   Dim Text:    #4A4A6A  (74, 74, 106)
--   Button BG:   #1A1A2E  (26, 26, 46)
--   Border Glow: #00FFFF  (0, 255, 255)

local G2L = {}

G2L["1"] = GuiParent()

-- ── Topbar ──────────────────────────────────────────────────────────────────
G2L["2"] = Instance.new("Frame", G2L["1"])
G2L["2"]["BorderSizePixel"] = 0
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(10, 10, 20)       -- near-black cyber bg
G2L["2"]["Size"] = UDim2.new(0, 473, 0, 22)
G2L["2"]["Position"] = UDim2.new(0.3546, 0, 0.33567, 0)
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 255, 255)
G2L["2"]["Name"] = "Topbar"

-- Cyan top border stripe (neon glow effect)
local topGlow = Instance.new("Frame", G2L["2"])
topGlow.Name = "TopGlow"
topGlow.BorderSizePixel = 0
topGlow.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
topGlow.Size = UDim2.new(1, 0, 0, 1)
topGlow.Position = UDim2.new(0, 0, 0, 0)

-- ── Topbar Label ────────────────────────────────────────────────────────────
G2L["4"] = Instance.new("TextLabel", G2L["2"])
G2L["4"]["TextWrapped"] = true
G2L["4"]["BorderSizePixel"] = 0
G2L["4"]["TextSize"] = 13
G2L["4"]["BackgroundTransparency"] = 1
G2L["4"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["4"]["TextColor3"] = Color3.fromRGB(0, 255, 255)            -- neon cyan title
G2L["4"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["4"]["Text"] = [[> EXEC // dnezero]]

-- ── Close Button ────────────────────────────────────────────────────────────
G2L["5"] = Instance.new("ImageButton", G2L["2"])
G2L["5"]["BorderSizePixel"] = 0
G2L["5"]["BackgroundTransparency"] = 1
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["5"]["Image"] = [[rbxassetid://11293981586]]
G2L["5"]["Size"] = UDim2.new(0, 17, 0, 17)
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["5"]["Position"] = UDim2.new(0.95137, 0, 0.05, 0)
G2L["5"]["ImageColor3"] = Color3.fromRGB(255, 0, 100)           -- neon pink close icon

G2L["6"] = Instance.new("LocalScript", G2L["5"])

-- ── Minimize Button ─────────────────────────────────────────────────────────
G2L["7"] = Instance.new("ImageButton", G2L["2"])
G2L["7"]["BorderSizePixel"] = 0
G2L["7"]["BackgroundTransparency"] = 1
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["7"]["Image"] = [[rbxassetid://11421092947]]
G2L["7"]["Size"] = UDim2.new(0, 17, 0, 17)
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["7"]["Position"] = UDim2.new(0.89429, 0, 0.05, 0)
G2L["7"]["ImageColor3"] = Color3.fromRGB(0, 255, 200)           -- neon teal minimize icon

G2L["8"] = Instance.new("LocalScript", G2L["7"])

-- ── Main Panel ──────────────────────────────────────────────────────────────
G2L["9"] = Instance.new("Frame", G2L["2"])
G2L["9"]["BorderSizePixel"] = 0
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(8, 8, 18)         -- deep cyber dark
G2L["9"]["Size"] = UDim2.new(0, 473, 0, 241)
G2L["9"]["Position"] = UDim2.new(0, 0, 1, 0)
G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 255, 255)
G2L["9"]["Name"] = "MainStuff"

-- Cyan bottom/side border glow
local borderBottom = Instance.new("Frame", G2L["9"])
borderBottom.BorderSizePixel = 0
borderBottom.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
borderBottom.Size = UDim2.new(1, 0, 0, 1)
borderBottom.Position = UDim2.new(0, 0, 1, -1)

local borderLeft = Instance.new("Frame", G2L["9"])
borderLeft.BorderSizePixel = 0
borderLeft.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
borderLeft.Size = UDim2.new(0, 1, 1, 0)
borderLeft.Position = UDim2.new(0, 0, 0, 0)

local borderRight = Instance.new("Frame", G2L["9"])
borderRight.BorderSizePixel = 0
borderRight.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
borderRight.Size = UDim2.new(0, 1, 1, 0)
borderRight.Position = UDim2.new(1, -1, 0, 0)

-- ── Editor ScrollingFrame ────────────────────────────────────────────────────
G2L["a"] = Instance.new("ScrollingFrame", G2L["9"])
G2L["a"]["Active"] = true
G2L["a"]["BorderSizePixel"] = 0
G2L["a"]["CanvasSize"] = UDim2.new(1, 0, 1, 0)
G2L["a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["a"]["Size"] = UDim2.new(1, 0, 0.86975, 0)
G2L["a"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 255, 255)  -- neon cyan scrollbar
G2L["a"]["Position"] = UDim2.new(0, 0, 0, 0)
G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["a"]["ScrollBarThickness"] = 2
G2L["a"]["BackgroundTransparency"] = 1

G2L["b"] = Instance.new("LocalScript", G2L["a"])
G2L["c"] = Instance.new("LocalScript", G2L["a"])
G2L["d"] = Instance.new("LocalScript", G2L["a"])

-- ── Line Numbers ─────────────────────────────────────────────────────────────
G2L["e"] = Instance.new("TextLabel", G2L["a"])
G2L["e"]["BorderSizePixel"] = 0
G2L["e"]["TextSize"] = 14
G2L["e"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["e"]["BackgroundColor3"] = Color3.fromRGB(8, 8, 18)
G2L["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["e"]["TextColor3"] = Color3.fromRGB(0, 180, 180)            -- dim cyan line numbers
G2L["e"]["BackgroundTransparency"] = 0.6
G2L["e"]["Size"] = UDim2.new(0, 40, 0, 239)
G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["e"]["Text"] = [[1\n]]
G2L["e"]["Name"] = "Lines"

G2L["f"] = Instance.new("LocalScript", G2L["e"])

-- ── Text Editor (ResponseLabel) ──────────────────────────────────────────────
G2L["10"] = Instance.new("TextBox", G2L["a"])
G2L["10"]["Name"] = "ResponseLabel"
G2L["10"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["10"]["BorderSizePixel"] = 0
G2L["10"]["TextSize"] = 14
G2L["10"]["TextColor3"] = Color3.fromRGB(220, 230, 255)         -- soft white-blue base text
G2L["10"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["10"]["BackgroundColor3"] = Color3.fromRGB(8, 8, 18)
G2L["10"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["10"]["MultiLine"] = true
G2L["10"]["ClearTextOnFocus"] = false
G2L["10"]["Size"] = UDim2.new(1, 0, 0, 239)
G2L["10"]["Position"] = UDim2.new(0, 50, 0, 0)
G2L["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["10"]["Text"] = [[print("Hello world")]]
G2L["10"]["BackgroundTransparency"] = 1

G2L["11"] = Instance.new("LocalScript", G2L["10"])

-- ── Syntax Highlight Layers ──────────────────────────────────────────────────

-- Comments  →  dim green
G2L["12"] = Instance.new("TextLabel", G2L["10"])
G2L["12"]["ZIndex"] = 5
G2L["12"]["TextSize"] = 14
G2L["12"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["12"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["12"]["BackgroundTransparency"] = 1
G2L["12"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["12"]["TextColor3"] = Color3.fromRGB(80, 200, 80)           -- muted neon green comments
G2L["12"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["12"]["Text"] = [[]]
G2L["12"]["Name"] = "Comments_"

-- Globals  →  electric cyan
G2L["13"] = Instance.new("TextLabel", G2L["10"])
G2L["13"]["ZIndex"] = 5
G2L["13"]["TextSize"] = 14
G2L["13"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["13"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["13"]["BackgroundTransparency"] = 1
G2L["13"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["13"]["TextColor3"] = Color3.fromRGB(0, 240, 255)           -- electric cyan globals
G2L["13"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["13"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["13"]["Text"] = [[]]
G2L["13"]["Name"] = "Globals_"

-- Keywords  →  hot magenta/pink
G2L["14"] = Instance.new("TextLabel", G2L["10"])
G2L["14"]["ZIndex"] = 5
G2L["14"]["TextSize"] = 14
G2L["14"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["14"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["14"]["BackgroundTransparency"] = 1
G2L["14"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["14"]["TextColor3"] = Color3.fromRGB(255, 50, 180)          -- hot neon pink keywords
G2L["14"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["14"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["14"]["Text"] = [[]]
G2L["14"]["Name"] = "Keywords_"

-- Numbers  →  neon yellow-gold
G2L["15"] = Instance.new("TextLabel", G2L["10"])
G2L["15"]["ZIndex"] = 4
G2L["15"]["TextSize"] = 14
G2L["15"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["15"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["15"]["BackgroundTransparency"] = 1
G2L["15"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["15"]["TextColor3"] = Color3.fromRGB(255, 220, 0)           -- neon yellow numbers
G2L["15"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["15"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["15"]["Text"] = [[]]
G2L["15"]["Name"] = "Numbers_"

-- Remote calls  →  vivid electric blue
G2L["16"] = Instance.new("TextLabel", G2L["10"])
G2L["16"]["ZIndex"] = 5
G2L["16"]["TextSize"] = 14
G2L["16"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["16"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["16"]["BackgroundTransparency"] = 1
G2L["16"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["16"]["TextColor3"] = Color3.fromRGB(50, 150, 255)          -- vivid blue remotes
G2L["16"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["16"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["16"]["Text"] = [[]]
G2L["16"]["Name"] = "RemoteHighlight_"

-- Strings  →  neon mint green
G2L["17"] = Instance.new("TextLabel", G2L["10"])
G2L["17"]["ZIndex"] = 5
G2L["17"]["TextSize"] = 14
G2L["17"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["17"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["17"]["BackgroundTransparency"] = 1
G2L["17"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["17"]["TextColor3"] = Color3.fromRGB(80, 255, 160)          -- neon mint strings
G2L["17"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["17"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["17"]["Text"] = [[]]
G2L["17"]["Name"] = "Strings_"

-- Tokens / operators  →  soft lavender white
G2L["18"] = Instance.new("TextLabel", G2L["10"])
G2L["18"]["ZIndex"] = 5
G2L["18"]["TextSize"] = 14
G2L["18"]["TextXAlignment"] = Enum.TextXAlignment.Left
G2L["18"]["TextYAlignment"] = Enum.TextYAlignment.Top
G2L["18"]["BackgroundTransparency"] = 1
G2L["18"]["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
G2L["18"]["TextColor3"] = Color3.fromRGB(200, 200, 255)         -- soft lavender tokens
G2L["18"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["18"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["18"]["Text"] = [[]]
G2L["18"]["Name"] = "Tokens_"

-- Line highlight  →  deep purple tint
G2L["19"] = Instance.new("Frame", G2L["10"])
G2L["19"]["ZIndex"] = 0
G2L["19"]["BorderSizePixel"] = 0
G2L["19"]["BackgroundColor3"] = Color3.fromRGB(60, 0, 100)      -- deep neon purple line hl
G2L["19"]["Name"] = "LineHighlight"
G2L["19"]["BackgroundTransparency"] = 0.6

-- Custom caret  →  hot pink pulse bar
G2L["1a"] = Instance.new("Frame", G2L["10"])
G2L["1a"]["Visible"] = false
G2L["1a"]["ZIndex"] = 2
G2L["1a"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 170)     -- hot pink caret
G2L["1a"]["Size"] = UDim2.new(0, 1, 0, 16)
G2L["1a"]["Name"] = "CustomCaret"

-- Selection highlight  →  cyan tint
G2L["1b"] = Instance.new("Frame", G2L["10"])
G2L["1b"]["Visible"] = false
G2L["1b"]["BorderSizePixel"] = 0
G2L["1b"]["BackgroundColor3"] = Color3.fromRGB(0, 200, 255)     -- cyan selection hl
G2L["1b"]["Name"] = "SelectionHighlight"
G2L["1b"]["BackgroundTransparency"] = 0.65

-- ── Bottom Buttons (helper to create styled buttons) ─────────────────────────
local function makeNeonButton(parent, text, posX, posY, accentColor)
	local btn = Instance.new("TextButton", parent)
	btn["BorderSizePixel"] = 1
	btn["TextSize"] = 13
	btn["TextColor3"] = accentColor
	btn["BackgroundColor3"] = Color3.fromRGB(13, 13, 26)
	btn["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	btn["Size"] = UDim2.new(0, 90, 0, 20)
	btn["BorderColor3"] = accentColor
	btn["Text"] = text
	btn["Position"] = UDim2.new(posX, 0, posY, 0)
	-- Hover glow effect via UIStroke
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = accentColor
	stroke.Thickness = 1
	stroke.Transparency = 0.4
	return btn
end

-- Execute  →  neon cyan
G2L["1c"] = makeNeonButton(G2L["9"], "> EXEC", 0.795, 0.895, Color3.fromRGB(0, 255, 255))
G2L["1d"] = Instance.new("LocalScript", G2L["1c"])

-- Clear  →  hot pink
G2L["1e"] = makeNeonButton(G2L["9"], "CLEAR", 0.58778, 0.895, Color3.fromRGB(255, 50, 150))
G2L["1f"] = Instance.new("LocalScript", G2L["1e"])

-- Save  →  neon green
G2L["20"] = makeNeonButton(G2L["9"], "SAVE", 0.38485, 0.895, Color3.fromRGB(0, 255, 127))
G2L["20"]["Size"] = UDim2.new(0, 89, 0, 20)
G2L["21"] = Instance.new("LocalScript", G2L["20"])

-- Open  →  neon purple
G2L["22"] = makeNeonButton(G2L["9"], "OPEN", 0.177, 0.895, Color3.fromRGB(180, 50, 255))
G2L["23"] = Instance.new("LocalScript", G2L["22"])

-- ── Open/Save Dialog Overlay ─────────────────────────────────────────────────
G2L["24"] = Instance.new("Frame", G2L["9"])
G2L["24"]["Visible"] = false
G2L["24"]["BorderSizePixel"] = 0
G2L["24"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
G2L["24"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["24"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
G2L["24"]["Name"] = "opensavedialog"
G2L["24"]["BackgroundTransparency"] = 0.35

local function makeDialogFrame(parent, name)
	local f = Instance.new("Frame", parent)
	f["Visible"] = false
	f["BorderSizePixel"] = 1
	f["BackgroundColor3"] = Color3.fromRGB(10, 10, 22)
	f["AnchorPoint"] = Vector2.new(0.5, 0.5)
	f["Size"] = UDim2.new(0, 327, 0, 76)
	f["Position"] = UDim2.new(0.5, 0, 0.5, 0)
	f["BorderColor3"] = Color3.fromRGB(0, 255, 255)
	f["Name"] = name
	-- Cyan border stroke
	local stroke = Instance.new("UIStroke", f)
	stroke.Color = Color3.fromRGB(0, 255, 255)
	stroke.Thickness = 1
	return f
end

local function makeDialogTextBox(parent)
	local tb = Instance.new("TextBox", parent)
	tb["BorderSizePixel"] = 1
	tb["TextWrapped"] = true
	tb["TextSize"] = 14
	tb["TextColor3"] = Color3.fromRGB(0, 255, 255)
	tb["BackgroundColor3"] = Color3.fromRGB(8, 8, 20)
	tb["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	tb["ClearTextOnFocus"] = false
	tb["PlaceholderText"] = [[filename...]]
	tb["Size"] = UDim2.new(0, 308, 0, 26)
	tb["Position"] = UDim2.new(0.03058, 0, 0.11368, 0)
	tb["BorderColor3"] = Color3.fromRGB(0, 255, 255)
	tb["Text"] = [[]]
	local stroke = Instance.new("UIStroke", tb)
	stroke.Color = Color3.fromRGB(0, 255, 255)
	stroke.Thickness = 1
	return tb
end

local function makeDialogButton(parent, text, posX, color)
	local btn = Instance.new("TextButton", parent)
	btn["BorderSizePixel"] = 1
	btn["TextSize"] = 14
	btn["TextColor3"] = color
	btn["BackgroundColor3"] = Color3.fromRGB(12, 12, 24)
	btn["FontFace"] = Font.new([[rbxasset://fonts/families/Inconsolata.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	btn["Size"] = UDim2.new(0, 100, 0, 22)
	btn["BorderColor3"] = color
	btn["Text"] = text
	btn["Position"] = UDim2.new(posX, 0, 0.57895, 0)
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = color
	stroke.Thickness = 1
	return btn
end

-- Save dialog
G2L["25"] = makeDialogFrame(G2L["24"], "save")
G2L["26"] = makeDialogTextBox(G2L["25"])
G2L["27"] = makeDialogButton(G2L["25"], "SAVE", 0.66667, Color3.fromRGB(0, 255, 127))
G2L["28"] = Instance.new("LocalScript", G2L["27"])
G2L["29"] = makeDialogButton(G2L["25"], "CANCEL", 0.34557, Color3.fromRGB(255, 50, 150))
G2L["2a"] = Instance.new("LocalScript", G2L["29"])

-- Open dialog
G2L["2b"] = makeDialogFrame(G2L["24"], "open")
G2L["2c"] = makeDialogTextBox(G2L["2b"])
G2L["2d"] = makeDialogButton(G2L["2b"], "OPEN", 0.66667, Color3.fromRGB(180, 50, 255))
G2L["2e"] = Instance.new("LocalScript", G2L["2d"])
G2L["2f"] = makeDialogButton(G2L["2b"], "CANCEL", 0.34557, Color3.fromRGB(255, 50, 150))
G2L["30"] = Instance.new("LocalScript", G2L["2f"])

-- ════════════════════════════════════════════════════════════════════════════
--  SCRIPT LOGIC  (unchanged from original, only UI refs updated above)
-- ════════════════════════════════════════════════════════════════════════════

-- Drag
local function C_3()
	local script = G2L["3"]
	local UserInputService = Services.UserInputService
	local gui = G2L["2"]
	local dragging, dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then update(input) end
	end)
end
task.spawn(C_3)

-- Close
local function C_6()
	G2L["5"].MouseButton1Click:Connect(function()
		G2L["2"]:Destroy()
	end)
end
task.spawn(C_6)

-- Minimize
local function C_8()
	G2L["7"].MouseButton1Click:Connect(function()
		G2L["9"].Visible = not G2L["9"].Visible
	end)
end
task.spawn(C_8)

-- Auto-scroll to caret
local function C_b()
	local TweenService = Services.TweenService
	local TextService = Services.TextService
	local scrollingFrame = G2L["a"]
	local textBox = scrollingFrame:FindFirstChildOfClass("TextBox")
	if not textBox then return end

	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local function getRequiredCanvasSize()
		local textSize = TextService:GetTextSize(textBox.Text, textBox.TextSize, textBox.Font, Vector2.new(textBox.AbsoluteSize.X, 10000))
		return UDim2.new(1, 0, 0, math.max(textSize.Y + 10, textBox.AbsoluteSize.Y))
	end

	local function scrollToBottom()
		scrollingFrame.CanvasSize = getRequiredCanvasSize()
		local maxY = math.max(0, scrollingFrame.CanvasSize.Y.Offset - scrollingFrame.AbsoluteSize.Y)
		TweenService:Create(scrollingFrame, tweenInfo, { CanvasPosition = Vector2.new(scrollingFrame.CanvasPosition.X, maxY) }):Play()
	end

	textBox:GetPropertyChangedSignal("Text"):Connect(scrollToBottom)
	textBox:GetPropertyChangedSignal("AbsoluteSize"):Connect(scrollToBottom)
	scrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(scrollToBottom)
	task.defer(scrollToBottom)
end
task.spawn(C_b)

-- Scroll-to-caret
local function C_c()
	local RunService = Services.RunService
	local TextService = Services.TextService
	local scrollingFrame = G2L["a"]

	local function getCaretLineInfo(textBox)
		local text = textBox.Text
		local cursorPos = textBox.CursorPosition - 1
		if cursorPos < 0 then return 1 end
		local lineCount = 1
		for i = 1, cursorPos do
			if text:sub(i, i) == "\n" then lineCount = lineCount + 1 end
		end
		return lineCount
	end

	local function updateScrolling()
		local textBox = nil
		local padding = scrollingFrame:FindFirstChildOfClass("UIPadding")
		local leftPadding = padding and padding.PaddingLeft.Offset or 0
		for _, child in ipairs(scrollingFrame:GetChildren()) do
			if child:IsA("TextBox") then textBox = child; break end
		end
		if not textBox then return end

		local textSize = textBox.TextSize
		local font = textBox.Font
		local availableWidth = scrollingFrame.AbsoluteSize.X - leftPadding
		local textBounds = TextService:GetTextSize(textBox.Text, textSize, font, Vector2.new(availableWidth, 99999))
		local contentHeight = textBounds.Y
		scrollingFrame.CanvasSize = UDim2.new(1, 0, 0, math.max(scrollingFrame.AbsoluteSize.Y, contentHeight + 5))

		if textBox:IsFocused() then
			local lineNumber = getCaretLineInfo(textBox)
			local lineHeight = TextService:GetTextSize("A", textSize, font, Vector2.new(0, 0)).Y
			local targetY = (lineNumber - 1) * lineHeight
			local maxCanvasY = math.max(0, contentHeight - scrollingFrame.AbsoluteSize.Y)
			local newCanvasPositionY = math.clamp(targetY - (scrollingFrame.AbsoluteSize.Y / 2), 0, maxCanvasY)
			scrollingFrame.CanvasPosition = Vector2.new(0, newCanvasPositionY)
		end
	end

	scrollingFrame.ChildAdded:Connect(function(child)
		if child:IsA("TextBox") then
			updateScrolling()
			child:GetPropertyChangedSignal("Text"):Connect(updateScrolling)
			child:GetPropertyChangedSignal("CursorPosition"):Connect(updateScrolling)
			child.Focused:Connect(updateScrolling)
			child.FocusLost:Connect(updateScrolling)
		end
	end)
	scrollingFrame.ChildRemoved:Connect(updateScrolling)
	for _, child in ipairs(scrollingFrame:GetChildren()) do
		if child:IsA("TextBox") then
			child:GetPropertyChangedSignal("Text"):Connect(updateScrolling)
			child:GetPropertyChangedSignal("CursorPosition"):Connect(updateScrolling)
			child.Focused:Connect(updateScrolling)
			child.FocusLost:Connect(updateScrolling)
		end
	end
	updateScrolling()
	scrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScrolling)
end
task.spawn(C_c)

-- Syntax highlighting
local function C_d()
	local lua_keywords = {
		"and", "break", "do", "else", "elseif", "end", "false", "for",
		"function", "goto", "if", "in", "local", "nil", "not", "or",
		"repeat", "return", "then", "true", "until", "while"
	}

	local global_env = {
		"getrawmetatable", "game", "workspace", "script", "math", "string",
		"table", "print", "wait", "BrickColor", "Color3", "next", "pairs",
		"ipairs", "select", "unpack", "Instance", "Vector2", "Vector3",
		"CFrame", "Ray", "UDim2", "Enum", "assert", "error", "warn",
		"tick", "loadstring", "_G", "shared", "getfenv", "setfenv",
		"newproxy", "setmetatable", "getmetatable", "os", "debug", "pcall",
		"ypcall", "xpcall", "rawequal", "rawset", "rawget", "tonumber",
		"tostring", "type", "typeof", "_VERSION", "coroutine", "delay",
		"require", "spawn", "LoadLibrary", "settings", "stats", "time",
		"UserSettings", "version", "Axes", "ColorSequence", "Faces",
		"ColorSequenceKeypoint", "NumberRange", "NumberSequence",
		"NumberSequenceKeypoint", "gcinfo", "elapsedTime", "collectgarbage",
		"PhysicalProperties", "Rect", "Region3", "Region3int16", "UDim",
		"Vector2int16", "Vector3int16",
		"cache.invalidate", "cache.iscached", "cache.replace", "cloneref",
		"compareinstances", "base64_encode", "base64_decode", "debug.getconstant",
		"debug.getconstants", "debug.getinfo", "debug.getproto", "debug.getprotos",
		"debug.getupvalue", "debug.getupvalues", "debug.setconstant", "getgc",
		"getloadedmodules", "getrunningscripts", "getscripts", "getsenv",
		"hookmetamethod", "iscclosure", "isexecutorclosure", "islclosure",
		"newcclosure", "setreadonly", "lz4compress", "lz4decompress",
		"getscriptclosure", "request", "getcallbackvalue", "listfiles",
		"writefile", "isfolder", "makefolder", "appendfile", "isfile",
		"delfolder", "delfile", "loadfile", "gethui", "getrawmetatable",
		"isreadonly", "getnamecallmethod", "setscriptable", "isscriptable",
		"getinstances", "getnilinstances", "fireproximityprompt", "setrawmetatable",
		"getthreadidentity", "setthreadidentity", "getrenderproperty",
		"setrenderproperty", "Drawing.new", "Drawing.Fonts", "cleardrawcache",
		"loadstring", "debug.setupvalue", "readfile", "getscriptbytecode",
		"getcallingscript", "isrenderobj", "firesignal", "getscripthash",
		"identifyexecutor", "getfunctionhash", "gethiddenproperty", "debug.getstack",
		"firetouchinterest", "filtergc", "getrenv", "crypt.decrypt",
		"crypt.generatebytes", "crypt.generatekey", "getconnections",
		"checkcaller", "crypt.encrypt", "fireclickdetector", "debug.setstack",
		"decompile", "hookfunction", "restorefunction", "clonefunction",
		"getgenv", "getcustomasset", "sethiddenproperty", "WebSocket.connect",
		"replicatesignal", "crypt.hash",
	}

	local Source = G2L["10"]
	local Lines  = G2L["e"]

	local Token = {["="]=true,["."]=true,[","]=true,["("]=true,[")"]=true,["["]=true,["]"]=true,["{"]=true,["}"]=true,[":"]=true,["*"]=true,["/"]=true,["+"]=true,["-"]=true,["%"]=true,[";"]=true,["~"]=true}

	local function Highlight(str, keywords)
		local K = {}
		for _, v in pairs(keywords) do K[v] = true end
		local S = str:gsub(".", function(c) return Token[c] and "\32" or c end)
		return S:gsub("%S+", function(c) return K[c] and c or (" "):rep(#c) end)
	end

	local function hTokens(str)
		local A = ""
		str:gsub(".", function(c)
			if Token[c] then A = A..c
			elseif c=="\n" then A = A.."\n"
			elseif c=="\t" then A = A.."\t"
			else A = A.."\32" end
		end)
		return A
	end

	local function strings(str)
		local highlight, quote = "", false
		str:gsub(".", function(c)
			if not quote and c=='"' then quote=true
			elseif quote and c=='"' then quote=false end
			if not quote and c=='"' then highlight=highlight..'"'
			elseif c=="\n" then highlight=highlight.."\n"
			elseif c=="\t" then highlight=highlight.."\t"
			elseif quote then highlight=highlight..c
			else highlight=highlight.."\32" end
		end)
		return highlight
	end

	local function comments(str)
		local ret = ""
		str:gsub("[^\r\n]+", function(c)
			local comm, i = false, 0
			c:gsub(".", function(n)
				i = i+1
				if c:sub(i,i+1)=="--" then comm=true end
				ret = ret..(comm and n or "\32")
			end)
		end)
		return ret
	end

	local function numbers(str)
		local A = ""
		str:gsub(".", function(c)
			if tonumber(c) then A=A..c
			elseif c=="\n" then A=A.."\n"
			elseif c=="\t" then A=A.."\t"
			else A=A.."\32" end
		end)
		return A
	end

	local function highlight_source(t)
		if t == "Text" then
			Source.Text = Source.Text:gsub("\13",""):gsub("\t","      ")
			local s = Source.Text
			Source.Keywords_.Text       = Highlight(s, lua_keywords)
			Source.Globals_.Text        = Highlight(s, global_env)
			Source.RemoteHighlight_.Text= Highlight(s, {"FireServer","fireServer","InvokeServer","invokeServer"})
			Source.Tokens_.Text         = hTokens(s)
			Source.Numbers_.Text        = numbers(s)
			Source.Strings_.Text        = strings(s)
			local lin = 1
			s:gsub("\n", function() lin=lin+1 end)
			Lines.Text = ""
			for i=1,lin do Lines.Text = Lines.Text..i.."\n" end
		end
	end

	highlight_source("Text")
	Source.Changed:Connect(highlight_source)
end
task.spawn(C_d)

-- Lines sync
local function C_f()
	local textLabel = G2L["e"]
	local textBox   = G2L["10"]
	local function updateY()
		textLabel.Size = UDim2.new(textLabel.Size.X.Scale, textLabel.Size.X.Offset, 0, textBox.AbsoluteSize.Y)
	end
	textBox:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateY)
	updateY()
end
task.spawn(C_f)

-- Caret / line-highlight / selection
local function C_11()
	local TextBox        = G2L["10"]
	local ScrollingFrame = G2L["a"]
	local TextService    = Services.TextService
	local TweenService   = Services.TweenService

	local HighlightFrame  = G2L["19"]
	local CaretFrame      = G2L["1a"]
	local SelectionFrame  = G2L["1b"]

	local function getLineInfoAndCaretPosition()
		local text      = TextBox.Text
		local cursorPos = TextBox.CursorPosition - 1
		if cursorPos < 0 then return {1,0}, 0, 1 end
		local lines = {}
		local currentLine = 1
		lines[1] = 0
		for i=1,#text do
			if text:sub(i,i)=="\n" then currentLine+=1; lines[currentLine]=i end
		end
		lines[currentLine+1] = #text+1
		for i=1,#lines-1 do
			if cursorPos>=lines[i] and cursorPos<lines[i+1] then return lines, lines[i], i end
		end
		return lines, 0, 1
	end

	local function updateAll()
		local lines, lastNewlinePos, lineNumber = getLineInfoAndCaretPosition()
		if not lineNumber then return end
		local text         = TextBox.Text
		local textSize     = TextBox.TextSize
		local font         = TextBox.Font
		local sfSize       = ScrollingFrame.AbsoluteSize
		local cursorPos    = TextBox.CursorPosition - 1
		local selectionStart = TextBox.SelectionStart - 1
		local padding      = ScrollingFrame:FindFirstChildOfClass("UIPadding")
		local leftPadding  = padding and padding.PaddingLeft.Offset or 0
		local availW       = sfSize.X - leftPadding
		local lineHeight   = TextService:GetTextSize("A", textSize, font, Vector2.new(availW, 99999)).Y

		local textBeforeCursor = text:sub(lines[lineNumber]+1, cursorPos>=lines[lineNumber] and cursorPos or lines[lineNumber])
		local caretBounds = TextService:GetTextSize(textBeforeCursor, textSize, font, Vector2.new(availW, 99999))

		local lineText   = text:sub(lines[lineNumber]+1, lines[lineNumber+1]-1)
		local textBounds = TextService:GetTextSize(lineText, textSize, font, Vector2.new(availW, 99999))

		local tweenInfo = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		TweenService:Create(HighlightFrame, tweenInfo, {
			Size     = UDim2.new(1, -leftPadding, 0, textBounds.Y),
			Position = UDim2.new(0, leftPadding, 0, (lineNumber-1)*lineHeight)
		}):Play()

		TweenService:Create(CaretFrame, tweenInfo, {
			Position = UDim2.new(0, leftPadding+caretBounds.X, 0, (lineNumber-1)*lineHeight)
		}):Play()

		local isSelActive = selectionStart>=0 and cursorPos>=0 and selectionStart~=cursorPos
		if isSelActive then
			local selStart = math.min(selectionStart, cursorPos)
			local selEnd   = math.max(selectionStart, cursorPos)
			local startLine, endLine = 1, 1
			for i=1,#lines-1 do
				if selStart>=lines[i] and selStart<lines[i+1] then startLine=i end
				if selEnd  >=lines[i] and selEnd  <lines[i+1] then endLine=i   end
			end
			if startLine==endLine then
				local selText = text:sub(selStart+1, selEnd)
				local tbSel   = text:sub(lines[startLine]+1, selStart)
				local sStartB = TextService:GetTextSize(tbSel,    textSize, font, Vector2.new(availW,99999))
				local sB      = TextService:GetTextSize(selText,  textSize, font, Vector2.new(availW,99999))
				TweenService:Create(SelectionFrame, tweenInfo, {
					Size     = UDim2.new(0, sB.X, 0, sB.Y),
					Position = UDim2.new(0, leftPadding+sStartB.X, 0, (startLine-1)*lineHeight)
				}):Play()
			else
				TweenService:Create(SelectionFrame, tweenInfo, {
					Size     = UDim2.new(1, -leftPadding, 0, (endLine-startLine+1)*lineHeight),
					Position = UDim2.new(0, leftPadding, 0, (startLine-1)*lineHeight)
				}):Play()
			end
		end

		local focused = TextBox:IsFocused()
		HighlightFrame.Visible  = focused
		CaretFrame.Visible      = focused and not isSelActive
		SelectionFrame.Visible  = focused and isSelActive
	end

	local function updateSize()
		local text      = TextBox.Text
		local textSize  = TextBox.TextSize
		local font      = TextBox.Font
		local sfSize    = ScrollingFrame.AbsoluteSize
		local padding   = ScrollingFrame:FindFirstChildOfClass("UIPadding")
		local leftPadding = padding and padding.PaddingLeft.Offset or 0
		local availW    = sfSize.X - leftPadding
		local textBounds = TextService:GetTextSize(text, textSize, font, Vector2.new(availW, 99999))
		local newHeight = math.max(sfSize.Y, textBounds.Y + 5)
		TextBox.Size = UDim2.new(1, -leftPadding, 0, newHeight)
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, newHeight)
		updateAll()
	end

	TextBox:GetPropertyChangedSignal("Text"):Connect(updateSize)
	TextBox:GetPropertyChangedSignal("CursorPosition"):Connect(updateAll)
	TextBox:GetPropertyChangedSignal("SelectionStart"):Connect(updateAll)
	TextBox.Focused:Connect(function() updateAll(); CaretFrame.Visible=true end)
	TextBox.FocusLost:Connect(function()
		HighlightFrame.Visible=false; CaretFrame.Visible=false; SelectionFrame.Visible=false
	end)
	updateSize()
end
task.spawn(C_11)

-- Execute button
local function C_1d()
	G2L["1c"].MouseButton1Click:Connect(function()
		loadstring(G2L["10"].Text)()
	end)
end
task.spawn(C_1d)

-- Clear button
local function C_1f()
	G2L["1e"].MouseButton1Click:Connect(function()
		G2L["10"].Text = ""
	end)
end
task.spawn(C_1f)

-- Save button → show save dialog
local function C_21()
	G2L["20"].MouseButton1Click:Connect(function()
		G2L["24"].Visible = true
		G2L["25"].Visible = true
	end)
end
task.spawn(C_21)

-- Open button → show open dialog
local function C_23()
	G2L["22"].MouseButton1Click:Connect(function()
		G2L["24"].Visible = true
		G2L["2b"].Visible = true
	end)
end
task.spawn(C_23)

-- Save confirm
local function C_28()
	local button      = G2L["27"]
	local textbox     = G2L["26"]
	local responseLabel = G2L["10"]

	button.MouseButton1Click:Connect(function()
		local filename = textbox.Text
		if not filename or filename:match("^%s*$") then print("[System] Filename cannot be empty."); return end
		local safeFilename = filename:gsub("[/\\|%*:?\"<>]", "_")
		local success, err = pcall(function() writefile(safeFilename, responseLabel.Text) end)
		if success then print("[System] Saved: "..safeFilename)
		else print("[System] Save failed: "..tostring(err)) end
	end)
end
task.spawn(C_28)

-- Save cancel
local function C_2a()
	G2L["29"].MouseButton1Click:Connect(function()
		G2L["24"].Visible = false
		G2L["25"].Visible = false
	end)
end
task.spawn(C_2a)

-- Open confirm
local function C_2e()
	local openButton   = G2L["2d"]
	local fileNameInput= G2L["2c"]
	local outputDisplay= G2L["10"]

	local function attemptReadFile(filename)
		local ok, content = pcall(function() return readfile(filename) end)
		if ok then return ok, content end
		ok, content = pcall(function()
			if getfile then return getfile(filename)
			elseif isfile and isfile(filename) then return readfile(filename) end
			error("File access not available or file not found.")
		end)
		return ok, content
	end

	openButton.MouseButton1Click:Connect(function()
		local filename = fileNameInput.Text
		if not filename or filename:match("^%s*$") then print("[File Loader] Enter a filename."); return end
		local safeFilename = filename:gsub("[/\\|%*:?\"<>]", "_")
		local success, content = attemptReadFile(safeFilename)
		if success and type(content)=="string" then
			outputDisplay.Text = content
			print("[File Loader] Loaded: "..safeFilename)
		else
			outputDisplay.Text = "Error: Could not load file."
			print("[File Loader Error] "..tostring(content))
		end
	end)
end
task.spawn(C_2e)

-- Open cancel
local function C_30()
	G2L["2f"].MouseButton1Click:Connect(function()
		G2L["24"].Visible = false
		G2L["2b"].Visible = false
	end)
end
task.spawn(C_30)
