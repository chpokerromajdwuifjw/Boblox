-- Executor (ImGui Style) — original by dnezero, restyled

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
		local length = math.random(10, 20)
		local array = {}
		for i = 1, length do array[i] = string.char(math.random(32, 126)) end
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

-- ─────────────────────────────────────────────
-- ImGui colour palette
-- ─────────────────────────────────────────────
local C = {
	WindowBg       = Color3.fromRGB(15,  15,  15),   -- outermost window
	TitleBg        = Color3.fromRGB(25,  25,  25),   -- title bar (unfocused-ish)
	TitleBgActive  = Color3.fromRGB(30,  30,  40),   -- title bar accent
	ChildBg        = Color3.fromRGB(20,  20,  20),   -- editor pane
	EditorBg       = Color3.fromRGB(13,  13,  18),   -- code area
	Border         = Color3.fromRGB(55,  55,  65),   -- frame borders
	SeparatorColor = Color3.fromRGB(55,  55,  65),
	Button         = Color3.fromRGB(45,  45,  55),
	ButtonHovered  = Color3.fromRGB(60,  60,  75),
	ButtonActive   = Color3.fromRGB(35,  80, 160),
	TextNormal     = Color3.fromRGB(210, 210, 220),
	TextDim        = Color3.fromRGB(130, 130, 145),
	TextTitle      = Color3.fromRGB(230, 230, 240),
	Accent         = Color3.fromRGB(80,  130, 220),
	LineNum        = Color3.fromRGB(90,  90, 110),
	-- Syntax
	SynKeyword     = Color3.fromRGB(210,  90, 110),
	SynGlobal      = Color3.fromRGB(100, 190, 255),
	SynString      = Color3.fromRGB(155, 225, 140),
	SynNumber      = Color3.fromRGB(255, 195,  60),
	SynComment     = Color3.fromRGB( 85, 170,  85),
	SynToken       = Color3.fromRGB(220, 220, 220),
	SynRemote      = Color3.fromRGB( 60, 160, 255),
	-- Caret/selection
	Caret          = Color3.fromRGB(220, 220, 255),
	Selection      = Color3.fromRGB( 50, 120, 220),
	LineHL         = Color3.fromRGB( 35,  35,  50),
	-- Dialog overlay
	ModalOverlay   = Color3.fromRGB(  0,   0,   0),
	ModalBg        = Color3.fromRGB(22,  22,  30),
	InputBg        = Color3.fromRGB(30,  30,  40),
}

local FONT_MONO   = Font.new("rbxasset://fonts/families/Inconsolata.json",  Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local FONT_UI     = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local FONT_UI_SB  = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)

local G = {}

-- ─────────────────────────────────────────────
-- Helper: make a UIStroke border
-- ─────────────────────────────────────────────
local function addBorder(parent, color, thickness)
	local s = Instance.new("UIStroke")
	s.Color     = color or C.Border
	s.Thickness = thickness or 1
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = parent
	return s
end

local function addCorner(parent, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius or 4)
	c.Parent = parent
	return c
end

local function addPadding(parent, t, b, l, r)
	local p = Instance.new("UIPadding")
	p.PaddingTop    = UDim.new(0, t or 4)
	p.PaddingBottom = UDim.new(0, b or 4)
	p.PaddingLeft   = UDim.new(0, l or 4)
	p.PaddingRight  = UDim.new(0, r or 4)
	p.Parent = parent
	return p
end

-- ─────────────────────────────────────────────
-- Root ScreenGui
-- ─────────────────────────────────────────────
G.Root = GuiParent()

-- ─────────────────────────────────────────────
-- Main window frame
-- ─────────────────────────────────────────────
local WIN_W, WIN_H = 500, 300

G.Window = Instance.new("Frame")
G.Window.Name             = "ImGuiExecutor"
G.Window.Size             = UDim2.new(0, WIN_W, 0, WIN_H)
G.Window.Position         = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
G.Window.BackgroundColor3 = C.WindowBg
G.Window.BorderSizePixel  = 0
G.Window.ClipsDescendants = true
G.Window.Parent           = G.Root
addCorner(G.Window, 6)
addBorder(G.Window, C.Border, 1)

-- ─────────────────────────────────────────────
-- Title bar
-- ─────────────────────────────────────────────
G.TitleBar = Instance.new("Frame")
G.TitleBar.Name             = "TitleBar"
G.TitleBar.Size             = UDim2.new(1, 0, 0, 26)
G.TitleBar.BackgroundColor3 = C.TitleBgActive
G.TitleBar.BorderSizePixel  = 0
G.TitleBar.Parent           = G.Window

-- Title bar bottom separator
local TitleSep = Instance.new("Frame")
TitleSep.Size             = UDim2.new(1, 0, 0, 1)
TitleSep.Position         = UDim2.new(0, 0, 1, -1)
TitleSep.BackgroundColor3 = C.Border
TitleSep.BorderSizePixel  = 0
TitleSep.Parent           = G.TitleBar

-- Accent left stripe on title
local TitleAccent = Instance.new("Frame")
TitleAccent.Size             = UDim2.new(0, 3, 1, 0)
TitleAccent.BackgroundColor3 = C.Accent
TitleAccent.BorderSizePixel  = 0
TitleAccent.Parent           = G.TitleBar

-- Title text
G.TitleLabel = Instance.new("TextLabel")
G.TitleLabel.Size                = UDim2.new(1, -80, 1, 0)
G.TitleLabel.Position            = UDim2.new(0, 12, 0, 0)
G.TitleLabel.BackgroundTransparency = 1
G.TitleLabel.Text                = "Executor"
G.TitleLabel.FontFace            = FONT_UI_SB
G.TitleLabel.TextSize            = 14
G.TitleLabel.TextColor3          = C.TextTitle
G.TitleLabel.TextXAlignment      = Enum.TextXAlignment.Left
G.TitleLabel.Parent              = G.TitleBar

-- Title bar buttons (close + minimise) — ImGui style: X and _
local function makeTitleBtn(text, xPos, hoverColor)
	local btn = Instance.new("TextButton")
	btn.Size                = UDim2.new(0, 22, 0, 18)
	btn.Position            = UDim2.new(1, xPos, 0.5, -9)
	btn.BackgroundColor3    = Color3.fromRGB(50, 50, 60)
	btn.BorderSizePixel     = 0
	btn.Text                = text
	btn.FontFace            = FONT_UI_SB
	btn.TextSize            = 13
	btn.TextColor3          = C.TextNormal
	btn.Parent              = G.TitleBar
	addCorner(btn, 3)
	btn.MouseEnter:Connect(function() btn.BackgroundColor3 = hoverColor end)
	btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60) end)
	return btn
end

G.CloseBtn    = makeTitleBtn("✕", -28, Color3.fromRGB(180, 60, 60))
G.CollapseBtn = makeTitleBtn("─", -54, Color3.fromRGB(60, 60, 80))

-- ─────────────────────────────────────────────
-- Body (everything below title bar)
-- ─────────────────────────────────────────────
G.Body = Instance.new("Frame")
G.Body.Name             = "Body"
G.Body.Size             = UDim2.new(1, 0, 1, -26)
G.Body.Position         = UDim2.new(0, 0, 0, 26)
G.Body.BackgroundColor3 = C.WindowBg
G.Body.BorderSizePixel  = 0
G.Body.ClipsDescendants = true
G.Body.Parent           = G.Window

-- ─────────────────────────────────────────────
-- Editor area (line numbers + text box)
-- ─────────────────────────────────────────────
G.EditorFrame = Instance.new("Frame")
G.EditorFrame.Name             = "EditorFrame"
G.EditorFrame.Size             = UDim2.new(1, 0, 1, -32)  -- leave room for button bar
G.EditorFrame.BackgroundColor3 = C.EditorBg
G.EditorFrame.BorderSizePixel  = 0
G.EditorFrame.Parent           = G.Body

-- Bottom separator above button bar
local EditorSep = Instance.new("Frame")
EditorSep.Size             = UDim2.new(1, 0, 0, 1)
EditorSep.AnchorPoint      = Vector2.new(0, 1)
EditorSep.Position         = UDim2.new(0, 0, 1, 0)
EditorSep.BackgroundColor3 = C.Border
EditorSep.BorderSizePixel  = 0
EditorSep.Parent           = G.EditorFrame

-- Line number gutter
G.Gutter = Instance.new("Frame")
G.Gutter.Name             = "Gutter"
G.Gutter.Size             = UDim2.new(0, 44, 1, 0)
G.Gutter.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
G.Gutter.BorderSizePixel  = 0
G.Gutter.Parent           = G.EditorFrame

-- Gutter right border
local GutterBorder = Instance.new("Frame")
GutterBorder.Size             = UDim2.new(0, 1, 1, 0)
GutterBorder.AnchorPoint      = Vector2.new(1, 0)
GutterBorder.Position         = UDim2.new(1, 0, 0, 0)
GutterBorder.BackgroundColor3 = C.Border
GutterBorder.BorderSizePixel  = 0
GutterBorder.Parent           = G.Gutter

G.Lines = Instance.new("TextLabel")
G.Lines.Name               = "Lines"
G.Lines.Size               = UDim2.new(1, -6, 1, 0)
G.Lines.Position           = UDim2.new(0, 0, 0, 4)
G.Lines.BackgroundTransparency = 1
G.Lines.Text               = "1"
G.Lines.FontFace           = FONT_MONO
G.Lines.TextSize           = 14
G.Lines.TextColor3         = C.LineNum
G.Lines.TextXAlignment     = Enum.TextXAlignment.Right
G.Lines.TextYAlignment     = Enum.TextYAlignment.Top
G.Lines.Parent             = G.Gutter

-- Scrolling frame for code
G.ScrollFrame = Instance.new("ScrollingFrame")
G.ScrollFrame.Name               = "ScrollFrame"
G.ScrollFrame.Size               = UDim2.new(1, -45, 1, 0)
G.ScrollFrame.Position           = UDim2.new(0, 45, 0, 0)
G.ScrollFrame.BackgroundTransparency = 1
G.ScrollFrame.BorderSizePixel    = 0
G.ScrollFrame.CanvasSize         = UDim2.new(1, 0, 1, 0)
G.ScrollFrame.ScrollBarThickness = 4
G.ScrollFrame.ScrollBarImageColor3 = C.Border
G.ScrollFrame.Parent             = G.EditorFrame

-- The actual code TextBox
G.CodeBox = Instance.new("TextBox")
G.CodeBox.Name               = "CodeBox"
G.CodeBox.Size               = UDim2.new(1, -8, 0, 0)  -- height set dynamically
G.CodeBox.Position           = UDim2.new(0, 8, 0, 4)
G.CodeBox.BackgroundTransparency = 1
G.CodeBox.BorderSizePixel    = 0
G.CodeBox.Text               = 'print("Hello world")'
G.CodeBox.FontFace           = FONT_MONO
G.CodeBox.TextSize           = 14
G.CodeBox.TextColor3         = Color3.fromRGB(0, 0, 0)
G.CodeBox.TextTransparency   = 1  -- hide base text; syntax overlay labels render all color
G.CodeBox.TextXAlignment     = Enum.TextXAlignment.Left
G.CodeBox.TextYAlignment     = Enum.TextYAlignment.Top
G.CodeBox.MultiLine          = true
G.CodeBox.ClearTextOnFocus   = false
G.CodeBox.Parent             = G.ScrollFrame

-- Syntax highlight overlay labels
local function makeSynLabel(name, color)
	local lbl = Instance.new("TextLabel")
	lbl.Name               = name
	lbl.Size               = UDim2.new(1, 0, 1, 0)
	lbl.Position           = UDim2.new(0, 0, 0, 0)  -- CodeBox is already offset; children must be 0,0
	lbl.BackgroundTransparency = 1
	lbl.BorderSizePixel    = 0
	lbl.Text               = ""
	lbl.FontFace           = FONT_MONO
	lbl.TextSize           = 14
	lbl.TextColor3         = color
	lbl.TextXAlignment     = Enum.TextXAlignment.Left
	lbl.TextYAlignment     = Enum.TextYAlignment.Top
	lbl.ZIndex             = 5
	lbl.Parent             = G.CodeBox
	return lbl
end

G.SynComments = makeSynLabel("Comments_",      C.SynComment)
G.SynGlobals  = makeSynLabel("Globals_",       C.SynGlobal)
G.SynKeywords = makeSynLabel("Keywords_",      C.SynKeyword)
G.SynNumbers  = makeSynLabel("Numbers_",       C.SynNumber)
G.SynRemote   = makeSynLabel("RemoteHighlight_", C.SynRemote)
G.SynStrings  = makeSynLabel("Strings_",       C.SynString)
G.SynTokens   = makeSynLabel("Tokens_",        C.TextNormal)  -- fallback: plain identifiers & operators

-- Caret, line highlight, selection
G.LineHL = Instance.new("Frame")
G.LineHL.Name                = "LineHighlight"
G.LineHL.BackgroundColor3    = C.LineHL
G.LineHL.BackgroundTransparency = 0.4
G.LineHL.BorderSizePixel     = 0
G.LineHL.ZIndex              = 0
G.LineHL.Parent              = G.CodeBox

G.Caret = Instance.new("Frame")
G.Caret.Name             = "CustomCaret"
G.Caret.BackgroundColor3 = C.Caret
G.Caret.Size             = UDim2.new(0, 1, 0, 16)
G.Caret.ZIndex           = 6
G.Caret.Visible          = false
G.Caret.Parent           = G.CodeBox

G.SelHL = Instance.new("Frame")
G.SelHL.Name                = "SelectionHighlight"
G.SelHL.BackgroundColor3    = C.Selection
G.SelHL.BackgroundTransparency = 0.65
G.SelHL.BorderSizePixel     = 0
G.SelHL.ZIndex              = 2
G.SelHL.Visible             = false
G.SelHL.Parent              = G.CodeBox

-- ─────────────────────────────────────────────
-- Button bar (bottom of window)
-- ─────────────────────────────────────────────
G.ButtonBar = Instance.new("Frame")
G.ButtonBar.Name             = "ButtonBar"
G.ButtonBar.Size             = UDim2.new(1, 0, 0, 32)
G.ButtonBar.AnchorPoint      = Vector2.new(0, 1)
G.ButtonBar.Position         = UDim2.new(0, 0, 1, 0)
G.ButtonBar.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
G.ButtonBar.BorderSizePixel  = 0
G.ButtonBar.Parent           = G.Body

-- ImGui-style buttons
local BTN_PAD = 6
local BTN_H   = 22
local BTN_Y   = (32 - BTN_H) / 2

local function makeBtn(text, xOffset, width, accent)
	local btn = Instance.new("TextButton")
	btn.Size             = UDim2.new(0, width, 0, BTN_H)
	btn.Position         = UDim2.new(0, xOffset, 0, BTN_Y)
	btn.BackgroundColor3 = accent or C.Button
	btn.BorderSizePixel  = 0
	btn.Text             = text
	btn.FontFace         = FONT_UI_SB
	btn.TextSize         = 13
	btn.TextColor3       = C.TextNormal
	btn.Parent           = G.ButtonBar
	addCorner(btn, 4)
	addBorder(btn, C.Border, 1)
	local base = accent or C.Button
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = accent
			and Color3.fromRGB(accent.R*255+15, accent.G*255+10, accent.B*255+10)
			or C.ButtonHovered
	end)
	btn.MouseLeave:Connect(function() btn.BackgroundColor3 = base end)
	return btn
end

G.BtnOpen    = makeBtn("Open",    BTN_PAD,      72)
G.BtnSave    = makeBtn("Save",    BTN_PAD+78,   72)
G.BtnClear   = makeBtn("Clear",   BTN_PAD+156,  72)
G.BtnExecute = makeBtn("▶  Execute", WIN_W - BTN_PAD - 110, 106, Color3.fromRGB(35, 80, 160))

-- ─────────────────────────────────────────────
-- Modal overlay + dialogs (ImGui modal style)
-- ─────────────────────────────────────────────
G.ModalOverlay = Instance.new("Frame")
G.ModalOverlay.Name                = "ModalOverlay"
G.ModalOverlay.Size                = UDim2.new(1, 0, 1, 0)
G.ModalOverlay.BackgroundColor3    = C.ModalOverlay
G.ModalOverlay.BackgroundTransparency = 0.45
G.ModalOverlay.BorderSizePixel     = 0
G.ModalOverlay.Visible             = false
G.ModalOverlay.ZIndex              = 8
G.ModalOverlay.Parent              = G.Body

local function makeDialog(title)
	local dlg = Instance.new("Frame")
	dlg.Size             = UDim2.new(0, 300, 0, 100)
	dlg.AnchorPoint      = Vector2.new(0.5, 0.5)
	dlg.Position         = UDim2.new(0.5, 0, 0.5, 0)
	dlg.BackgroundColor3 = C.ModalBg
	dlg.BorderSizePixel  = 0
	dlg.ZIndex           = 9
	dlg.Visible          = false
	dlg.Parent           = G.Body
	addCorner(dlg, 6)
	addBorder(dlg, C.Accent, 1)

	-- Dialog title
	local hdr = Instance.new("Frame")
	hdr.Size             = UDim2.new(1, 0, 0, 24)
	hdr.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
	hdr.BorderSizePixel  = 0
	hdr.ZIndex           = 9
	hdr.Parent           = dlg
	addCorner(hdr, 6)

	-- cover bottom corners of header
	local hdrCover = Instance.new("Frame")
	hdrCover.Size             = UDim2.new(1, 0, 0, 6)
	hdrCover.Position         = UDim2.new(0, 0, 1, -6)
	hdrCover.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
	hdrCover.BorderSizePixel  = 0
	hdrCover.ZIndex           = 9
	hdrCover.Parent           = hdr

	local hdrLabel = Instance.new("TextLabel")
	hdrLabel.Size                = UDim2.new(1, -10, 1, 0)
	hdrLabel.Position            = UDim2.new(0, 10, 0, 0)
	hdrLabel.BackgroundTransparency = 1
	hdrLabel.Text                = title
	hdrLabel.FontFace            = FONT_UI_SB
	hdrLabel.TextSize            = 13
	hdrLabel.TextColor3          = C.Accent
	hdrLabel.TextXAlignment      = Enum.TextXAlignment.Left
	hdrLabel.ZIndex              = 10
	hdrLabel.Parent              = hdr

	-- Input
	local input = Instance.new("TextBox")
	input.Size             = UDim2.new(1, -16, 0, 26)
	input.Position         = UDim2.new(0, 8, 0, 32)
	input.BackgroundColor3 = C.InputBg
	input.BorderSizePixel  = 0
	input.Text             = ""
	input.PlaceholderText  = "filename..."
	input.FontFace         = FONT_MONO
	input.TextSize         = 13
	input.TextColor3       = C.TextNormal
	input.PlaceholderColor3 = C.TextDim
	input.ClearTextOnFocus = false
	input.ZIndex           = 10
	input.Parent           = dlg
	addCorner(input, 4)
	addBorder(input, C.Border, 1)

	-- OK button
	local okBtn = Instance.new("TextButton")
	okBtn.Size             = UDim2.new(0, 90, 0, 22)
	okBtn.Position         = UDim2.new(1, -100, 1, -30)
	okBtn.BackgroundColor3 = Color3.fromRGB(35, 80, 160)
	okBtn.BorderSizePixel  = 0
	okBtn.Text             = title:match("^%S+") -- "Save" or "Open"
	okBtn.FontFace         = FONT_UI_SB
	okBtn.TextSize         = 13
	okBtn.TextColor3       = Color3.fromRGB(230, 230, 255)
	okBtn.ZIndex           = 10
	okBtn.Parent           = dlg
	addCorner(okBtn, 4)

	-- Cancel button
	local cancelBtn = Instance.new("TextButton")
	cancelBtn.Size             = UDim2.new(0, 70, 0, 22)
	cancelBtn.Position         = UDim2.new(1, -176, 1, -30)
	cancelBtn.BackgroundColor3 = C.Button
	cancelBtn.BorderSizePixel  = 0
	cancelBtn.Text             = "Cancel"
	cancelBtn.FontFace         = FONT_UI_SB
	cancelBtn.TextSize         = 13
	cancelBtn.TextColor3       = C.TextNormal
	cancelBtn.ZIndex           = 10
	cancelBtn.Parent           = dlg
	addCorner(cancelBtn, 4)
	addBorder(cancelBtn, C.Border, 1)

	return dlg, input, okBtn, cancelBtn
end

G.SaveDlg, G.SaveInput, G.SaveOk, G.SaveCancel = makeDialog("Save File")
G.OpenDlg, G.OpenInput, G.OpenOk, G.OpenCancel = makeDialog("Open File")

-- ─────────────────────────────────────────────
-- Logic: Drag
-- ─────────────────────────────────────────────
do
	local dragging, dragInput, dragStart, startPos
	G.TitleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or
		   input.UserInputType == Enum.UserInputType.Touch then
			dragging  = true
			dragStart = input.Position
			startPos  = G.Window.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	G.TitleBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or
		   input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	Services.UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			G.Window.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

-- ─────────────────────────────────────────────
-- Logic: Close & Collapse
-- ─────────────────────────────────────────────
G.CloseBtn.MouseButton1Click:Connect(function()
	G.Window:Destroy()
end)

local collapsed = false
G.CollapseBtn.MouseButton1Click:Connect(function()
	collapsed = not collapsed
	G.Body.Visible = not collapsed
	G.Window.Size = collapsed
		and UDim2.new(0, WIN_W, 0, 26)
		or  UDim2.new(0, WIN_W, 0, WIN_H)
end)

-- ─────────────────────────────────────────────
-- Logic: Syntax highlighting
-- ─────────────────────────────────────────────
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
	"require","spawn","task","getgenv","getrenv","getsenv",
	"getgc","hookfunction","newcclosure","iscclosure","islclosure",
	"isexecutorclosure","readfile","writefile","listfiles",
	"isfile","isfolder","makefolder","loadfile","appendfile",
	"delfolder","delfile","gethui","getinstances","getnilinstances",
	"fireproximityprompt","firesignal","fireclickdetector",
	"decompile","getscriptbytecode","identifyexecutor",
	"WebSocket","Drawing","request","hookmetamethod","cloneref",
}

local TOKEN_SET = {
	["="]=1,["."] =1,[","]=1,["("]=1,[")"]=1,["["]=1,["]"]=1,
	["{"]=1,["}"]=1,[":"]=1,["*"]=1,["/"]=1,["+"]=1,["-"]=1,
	["%"]=1,[";"]=1,["~"]=1
}

local function mkKeywordSet(t)
	local s = {}
	for _, v in ipairs(t) do s[v] = true end
	return s
end

local KW_SET  = mkKeywordSet(lua_keywords)
local GL_SET  = mkKeywordSet(global_env)
local RM_SET  = mkKeywordSet({"FireServer","fireServer","InvokeServer","invokeServer"})

local function highlightKeywords(src, kset)
	local s = src:gsub(".", function(c) return TOKEN_SET[c] and " " or c end)
	return s:gsub("%S+", function(w) return kset[w] and w or (" "):rep(#w) end)
end

local function highlightTokens(src)
	local a = ""
	for c in src:gmatch(".") do
		if TOKEN_SET[c] then a = a .. c
		elseif c == "\n" then a = a .. "\n"
		elseif c == "\t" then a = a .. "\t"
		else a = a .. " " end
	end
	return a
end

local function highlightStrings(src)
	local out, inq = "", false
	for c in src:gmatch(".") do
		if not inq and c == '"' then inq = true; out = out .. '"'
		elseif inq and c == '"' then inq = false; out = out .. '"'
		elseif c == "\n" then out = out .. "\n"
		elseif c == "\t" then out = out .. "\t"
		elseif inq then out = out .. c
		else out = out .. " " end
	end
	return out
end

local function highlightComments(src)
	local out = ""
	for line in (src .. "\n"):gmatch("([^\r\n]*)\n") do
		local comm = false
		local i = 0
		for ch in line:gmatch(".") do
			i = i + 1
			if line:sub(i, i+1) == "--" then comm = true end
			out = out .. (comm and ch or " ")
		end
		out = out .. "\n"
	end
	return out
end

local function highlightNumbers(src)
	local a = ""
	for c in src:gmatch(".") do
		if tonumber(c) then a = a .. c
		elseif c == "\n" then a = a .. "\n"
		elseif c == "\t" then a = a .. "\t"
		else a = a .. " " end
	end
	return a
end

local _hlBusy = false
local function updateHighlighting()
	if _hlBusy then return end
	_hlBusy = true
	local s = G.CodeBox.Text:gsub("\13",""):gsub("\t","   ")
	if G.CodeBox.Text ~= s then G.CodeBox.Text = s end  -- normalise once

	G.SynKeywords.Text = highlightKeywords(s, KW_SET)
	G.SynGlobals.Text  = highlightKeywords(s, GL_SET)
	G.SynRemote.Text   = highlightKeywords(s, RM_SET)
	G.SynTokens.Text   = highlightTokens(s)
	G.SynNumbers.Text  = highlightNumbers(s)
	G.SynStrings.Text  = highlightStrings(s)
	G.SynComments.Text = highlightComments(s)

	-- Update line numbers
	local count = 1
	for _ in s:gmatch("\n") do count = count + 1 end
	local nums = {}
	for i = 1, count do nums[i] = tostring(i) end
	G.Lines.Text = table.concat(nums, "\n")
	_hlBusy = false
end

updateHighlighting()
G.CodeBox.Changed:Connect(function(prop)
	if prop == "Text" then updateHighlighting() end
end)

-- ─────────────────────────────────────────────
-- Logic: CodeBox size + scrolling
-- ─────────────────────────────────────────────
local TextService = Services.TextService
local TweenService = Services.TweenService

local function updateEditorSize()
	local avail = G.ScrollFrame.AbsoluteSize
	local bounds = TextService:GetTextSize(
		G.CodeBox.Text, G.CodeBox.TextSize, G.CodeBox.Font,
		Vector2.new(avail.X - 8, 9999)
	)
	local h = math.max(avail.Y, bounds.Y + 10)
	G.CodeBox.Size = UDim2.new(1, -8, 0, h)
	G.ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, h)
end

local function scrollToCaretLine()
	local text = G.CodeBox.Text
	local cur  = G.CodeBox.CursorPosition - 1
	if cur < 0 then return end
	local line = 1
	for i = 1, cur do if text:sub(i,i) == "\n" then line = line + 1 end end
	local lh = TextService:GetTextSize("A", G.CodeBox.TextSize, G.CodeBox.Font, Vector2.new(0,0)).Y
	local targetY = (line - 1) * lh
	local maxY = math.max(0, G.ScrollFrame.CanvasSize.Y.Offset - G.ScrollFrame.AbsoluteSize.Y)
	local newY = math.clamp(targetY - G.ScrollFrame.AbsoluteSize.Y / 2, 0, maxY)
	TweenService:Create(G.ScrollFrame, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{CanvasPosition = Vector2.new(0, newY)}):Play()
end

G.CodeBox:GetPropertyChangedSignal("Text"):Connect(function()
	updateEditorSize()
end)
G.CodeBox:GetPropertyChangedSignal("CursorPosition"):Connect(function()
	scrollToCaretLine()
end)
G.ScrollFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateEditorSize)
task.defer(updateEditorSize)

-- Keep Lines label same height as CodeBox
G.CodeBox:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	G.Lines.Size = UDim2.new(1, -6, 0, G.CodeBox.AbsoluteSize.Y)
end)

-- ─────────────────────────────────────────────
-- Logic: Caret, line highlight, selection
-- ─────────────────────────────────────────────
local function updateCaretUI()
	if not G.CodeBox:IsFocused() then
		G.LineHL.Visible = false
		G.Caret.Visible  = false
		G.SelHL.Visible  = false
		return
	end

	local text  = G.CodeBox.Text
	local cur   = G.CodeBox.CursorPosition - 1
	local tSize = G.CodeBox.TextSize
	local font  = G.CodeBox.Font
	local aW    = G.ScrollFrame.AbsoluteSize.X - 8

	-- line number of cursor
	local line = 1
	for i = 1, math.max(cur, 0) do
		if text:sub(i,i) == "\n" then line = line + 1 end
	end
	local lh = TextService:GetTextSize("A", tSize, font, Vector2.new(0, 0)).Y

	-- find start-of-line offset
	local lineStart = 1
	local lc = 0
	for i = 1, #text do
		if lc == line - 1 then lineStart = i; break end
		if text:sub(i,i) == "\n" then lc = lc + 1 end
	end

	local beforeCaret = text:sub(lineStart, cur)
	local cx = TextService:GetTextSize(beforeCaret, tSize, font, Vector2.new(aW, 9999)).X
	local cy = (line - 1) * lh

	G.LineHL.Size     = UDim2.new(1, 0, 0, lh)
	G.LineHL.Position = UDim2.new(0, 0, 0, cy)
	G.LineHL.Visible  = true

	G.Caret.Position = UDim2.new(0, cx, 0, cy)
	G.Caret.Size     = UDim2.new(0, 1, 0, lh)

	local ss = G.CodeBox.SelectionStart
	local hasSelection = ss > 0 and ss ~= G.CodeBox.CursorPosition
	G.SelHL.Visible = hasSelection
	G.Caret.Visible = not hasSelection

	if hasSelection then
		local selS = math.min(ss - 1, cur)
		local selE = math.max(ss - 1, cur)
		local selTxt = text:sub(selS + 1, selE)
		local preTxt  = text:sub(lineStart, selS)
		local preW    = TextService:GetTextSize(preTxt,  tSize, font, Vector2.new(aW, 9999)).X
		local selW    = TextService:GetTextSize(selTxt,  tSize, font, Vector2.new(aW, 9999)).X
		G.SelHL.Size     = UDim2.new(0, selW, 0, lh)
		G.SelHL.Position = UDim2.new(0, preW, 0, cy)
	end
end

G.CodeBox:GetPropertyChangedSignal("CursorPosition"):Connect(updateCaretUI)
G.CodeBox:GetPropertyChangedSignal("SelectionStart"):Connect(updateCaretUI)
G.CodeBox.Focused:Connect(updateCaretUI)
G.CodeBox.FocusLost:Connect(updateCaretUI)

-- ─────────────────────────────────────────────
-- Logic: Execute button
-- ─────────────────────────────────────────────
G.BtnExecute.MouseButton1Click:Connect(function()
	local ok, err = pcall(loadstring(G.CodeBox.Text))
	if not ok then
		warn("[Executor] " .. tostring(err))
	end
end)

-- ─────────────────────────────────────────────
-- Logic: Clear button
-- ─────────────────────────────────────────────
G.BtnClear.MouseButton1Click:Connect(function()
	G.CodeBox.Text = ""
end)

-- ─────────────────────────────────────────────
-- Logic: Save dialog
-- ─────────────────────────────────────────────
local function showModal(dlg)
	G.ModalOverlay.Visible = true
	dlg.Visible = true
end
local function hideModal(dlg)
	G.ModalOverlay.Visible = false
	dlg.Visible = false
end

G.BtnSave.MouseButton1Click:Connect(function()
	G.SaveInput.Text = ""
	showModal(G.SaveDlg)
end)

G.SaveOk.MouseButton1Click:Connect(function()
	local fn = G.SaveInput.Text:gsub("[/\\|%*:?\"<>]", "_")
	if fn:match("^%s*$") then return end
	local ok, err = pcall(writefile, fn, G.CodeBox.Text)
	if not ok then warn("[Executor] Save failed: " .. tostring(err)) end
	hideModal(G.SaveDlg)
end)

G.SaveCancel.MouseButton1Click:Connect(function()
	hideModal(G.SaveDlg)
end)

-- ─────────────────────────────────────────────
-- Logic: Open dialog
-- ─────────────────────────────────────────────
G.BtnOpen.MouseButton1Click:Connect(function()
	G.OpenInput.Text = ""
	showModal(G.OpenDlg)
end)

G.OpenOk.MouseButton1Click:Connect(function()
	local fn = G.OpenInput.Text:gsub("[/\\|%*:?\"<>]", "_")
	if fn:match("^%s*$") then return end
	local ok, content = pcall(readfile, fn)
	if ok and type(content) == "string" then
		G.CodeBox.Text = content
	else
		warn("[Executor] Open failed: " .. tostring(content))
	end
	hideModal(G.OpenDlg)
end)

G.OpenCancel.MouseButton1Click:Connect(function()
	hideModal(G.OpenDlg)
end)

-- Dismiss modal by clicking overlay
G.ModalOverlay.MouseButton1Click = nil  -- Frame, so no click event; handled via dialogs' cancel
