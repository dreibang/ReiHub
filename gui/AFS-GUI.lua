-- ReiHub GUI (v1.0)
-- AFS Script GUI with Macro Dropdown
-- By dreibang

local Gui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

Gui.Name = "ReiHubGui"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = game:GetService("CoreGui")

Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0, 50, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Parent = Gui

UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

-- Macro system
local isRecording = false
local currentMacro = {}
local macros = {}

local function CreateButton(text, order, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 30)
	btn.Position = UDim2.new(0, 5, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Text = text
	btn.LayoutOrder = order
	btn.Parent = Frame
	btn.MouseButton1Click:Connect(callback)
end

local function CreateDropdown(labelText, items, onSelect)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, -10, 0, 30)
	container.Position = UDim2.new(0, 5, 0, 0)
	container.BackgroundTransparency = 1
	container.LayoutOrder = 99
	container.Parent = Frame

	local label = Instance.new("TextLabel")
	label.Text = labelText
	label.Size = UDim2.new(0.4, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local dropdown = Instance.new("TextButton")
	dropdown.Size = UDim2.new(0.6, 0, 1, 0)
	dropdown.Position = UDim2.new(0.4, 0, 0, 0)
	dropdown.Text = "Select Macro"
	dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	dropdown.TextColor3 = Color3.new(1, 1, 1)
	dropdown.Parent = container

	dropdown.MouseButton1Click:Connect(function()
		local menu = Instance.new("Frame")
		menu.Position = UDim2.new(0, dropdown.AbsolutePosition.X, 0, dropdown.AbsolutePosition.Y + dropdown.AbsoluteSize.Y)
		menu.Size = UDim2.new(0, 200, 0, #items * 25)
		menu.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		menu.BorderSizePixel = 0
		menu.Parent = game:GetService("CoreGui")

		for _, item in ipairs(items) do
			local button = Instance.new("TextButton")
			button.Size = UDim2.new(1, 0, 0, 25)
			button.Text = item
			button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			button.TextColor3 = Color3.new(1, 1, 1)
			button.Parent = menu

			button.MouseButton1Click:Connect(function()
				dropdown.Text = item
				onSelect(item)
				menu:Destroy()
			end)
		end

		game:GetService("UserInputService").InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				if menu and menu.Parent then
					menu:Destroy()
				end
			end
		end)
	end)
end

local function RecordMacro()
	isRecording = true
	currentMacro = {}
	print("[ReiHub] Recording started...")
end

local function SaveMacro()
	isRecording = false
	local macroName = "Macro_" .. tostring(os.time())
	macros[macroName] = currentMacro
	print("[ReiHub] Macro saved as: " .. macroName)
end

local function PlayMacro(name)
	local macro = macros[name]
	if macro then
		print("[ReiHub] Playing macro: " .. name)
		for _, action in ipairs(macro) do
			-- Simulate actions (placeholder)
			print("Executing:", action)
			wait(0.3)
		end
	else
		warn("[ReiHub] No macro found with name:", name)
	end
end

-- Simulated key recording
game:GetService("UserInputService").InputBegan:Connect(function(input)
	if isRecording and input.UserInputType == Enum.UserInputType.Keyboard then
		table.insert(currentMacro, input.KeyCode.Name)
	end
end)

-- Buttons
CreateButton("🎥 Start Recording", 1, RecordMacro)
CreateButton("💾 Save Macro", 2, SaveMacro)
CreateButton("▶️ Play Last Saved", 3, function()
	local last = next(macros)
	if last then PlayMacro(last) end
end)

-- Dropdown for macro selection
CreateDropdown("Macros", {}, function(selected)
	PlayMacro(selected)
end)

-- Button to refresh dropdown
CreateButton("🔄 Refresh Dropdown", 4, function()
	local macroNames = {}
	for name in pairs(macros) do
		table.insert(macroNames, name)
	end
	CreateDropdown("Macros", macroNames, function(selected)
		PlayMacro(selected)
	end)
end)

print("✅ ReiHub UI Loaded!")
