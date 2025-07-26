--// ReiHub GUI - Anime Final Strike // -- Auto Farm + Macro Recorder + UI Loader Friendly

local Players = game:GetService("Players") local HttpService = game:GetService("HttpService") local LocalPlayer = Players.LocalPlayer local UIS = game:GetService("UserInputService")

-- Macro Storage local macros = {} local recordedMacro = {} local isRecording = false local currentMacro = nil

-- UI Library local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "ReiHubGUI" ScreenGui.ResetOnSpawn = false ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame") MainFrame.Size = UDim2.new(0, 300, 0, 350) MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175) MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) MainFrame.BorderSizePixel = 0 MainFrame.Active = true MainFrame.Draggable = true MainFrame.Parent = ScreenGui

local UIStroke = Instance.new("UIStroke", MainFrame) UIStroke.Color = Color3.fromRGB(0, 170, 255) UIStroke.Thickness = 2

local UICorner = Instance.new("UICorner", MainFrame) UICorner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel") title.Size = UDim2.new(1, 0, 0, 40) title.BackgroundTransparency = 1 title.Text = "ReiHub | AFS GUI" title.TextColor3 = Color3.fromRGB(0, 170, 255) title.Font = Enum.Font.GothamBold title.TextSize = 20 title.Parent = MainFrame

-- Button Template local function CreateButton(name, order, callback) local button = Instance.new("TextButton") button.Size = UDim2.new(0.9, 0, 0, 30) button.Position = UDim2.new(0.05, 0, 0, 50 + ((order - 1) * 40)) button.BackgroundColor3 = Color3.fromRGB(50, 50, 50) button.TextColor3 = Color3.fromRGB(255, 255, 255) button.Text = name button.Font = Enum.Font.Gotham button.TextSize = 14 button.AutoButtonColor = true button.Parent = MainFrame

local corner = Instance.new("UICorner", button)
corner.CornerRadius = UDim.new(0, 6)

button.MouseButton1Click:Connect(callback)

end

-- Dropdown local function CreateDropdown(options, callback) local dropdown = Instance.new("TextButton") dropdown.Size = UDim2.new(0.9, 0, 0, 30) dropdown.Position = UDim2.new(0.05, 0, 0, 270) dropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70) dropdown.TextColor3 = Color3.fromRGB(255, 255, 255) dropdown.Font = Enum.Font.Gotham dropdown.TextSize = 14 dropdown.Text = "Select Macro" dropdown.Parent = MainFrame

local corner = Instance.new("UICorner", dropdown)
corner.CornerRadius = UDim.new(0, 6)

dropdown.MouseButton1Click:Connect(function()
    dropdown.Text = "Select Macro (click again to refresh)"
    for _, macro in pairs(options()) do
        print("[Macro]", macro)
    end
end)

end

-- Autofarm (example placeholder) local function AutoFarm() print("[ReiHub] Starting Auto Farm...") while true do task.wait(2) -- Your autofarm logic here (e.g., attack enemies, move to NPCs, etc.) print("[ReiHub] Farming...") end end

-- Macro Handling local function StartRecording() recordedMacro = {} isRecording = true print("[ReiHub] Macro recording started.") end

local function StopRecording() isRecording = false local name = "Macro_" .. tostring(os.time()) macros[name] = recordedMacro print("[ReiHub] Macro saved as:", name) end

local function PlayMacro(name) local macro = macros[name] if not macro then warn("[ReiHub] Macro not found.") return end print("[ReiHub] Playing macro:", name) for _, action in ipairs(macro) do task.wait(action.delay) print("Executing:", action.type, action.data) -- You can implement actual key presses or mouse movements end end

-- UI Button Actions CreateButton("Start AutoFarm", 1, AutoFarm) CreateButton("Record Macro", 2, StartRecording) CreateButton("Stop Recording", 3, StopRecording) CreateButton("Play Last Macro", 4, function() local last = next(macros) if last then PlayMacro(last) end end)

CreateDropdown(function() local keys = {} for k in pairs(macros) do table.insert(keys, k) end return keys end, function(selected) PlayMacro(selected) end)

print("[ReiHub] GUI Loaded.")

