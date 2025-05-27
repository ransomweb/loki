--[[
    Loki.yf - Premium Silent Aim Suite
    Created by yufi (2025)
    UI Library: Gamesneeze
]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local Stats = game:GetService("Stats")

-- Local Player
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/matas3535/gamesneeze/main/Library.lua"))()

-- Main Window
local Window = Library:New({
    Name = "loki.yf", 
    Size = Vector2.new(500, 600),
    Accent = Color3.fromRGB(80, 80, 255)
})

-- Pages
local MainPage = Window:Page({Name = "Main"})
local VisualsPage = Window:Page({Name = "Visuals"})
local SettingsPage = Window:Page({Name = "Settings"})

-- Sections
local AimSection = MainPage:Section({
    Name = "Aim Settings",
    Fill = true,
    Side = "Left"
})

local MiscSection = MainPage:Section({
    Name = "Miscellaneous",
    Fill = true,
    Side = "Right"
})

local VisualsSection = VisualsPage:Section({
    Name = "Visual Settings",
    Fill = true,
    Side = "Left"
})

local SettingsSection = SettingsPage:Section({
    Name = "UI Settings",
    Fill = true,
    Side = "Left"
})

-- Variables
local Prediction = 0.136
local Target = nil
local Locked = false
local VisualsEnabled = true
local PredictionEnabled = true
local AirshotEnabled = false
local SelectedPart = "HumanoidRootPart"
local FOV = 120
local ShowFOV = false
local ShowTracer = true
local ShowHighlight = true
local HighlightColor = Color3.fromRGB(255, 50, 50)
local TracerColor = Color3.fromRGB(150, 150, 150)

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Radius = 120
FOVCircle.Thickness = 1
FOVCircle.Transparency = 1
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Filled = false
FOVCircle.NumSides = 64

-- Target Highlight
local Highlight = Instance.new("Highlight")
Highlight.Name = "loki.highlight"
Highlight.Enabled = false
Highlight.Adornee = nil
Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
Highlight.FillColor = HighlightColor
Highlight.FillTransparency = 0.5
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
Highlight.OutlineTransparency = 0
Highlight.Parent = game:GetService("CoreGui")

-- Tracer Part
local Tracer = Instance.new("Part")
Tracer.Name = "loki.tracer"
Tracer.Anchored = true
Tracer.CanCollide = false
Tracer.Transparency = 0.7
Tracer.Shape = Enum.PartType.Block
Tracer.Size = Vector3.new(8, 8, 8)
Tracer.Color = TracerColor
Tracer.Material = Enum.Material.Neon
Tracer.Parent = workspace

-- UI Elements
-- Aim Settings
local SilentAimToggle = AimSection:Toggle({
    Name = "Silent Aim",
    Default = true,
    Callback = function(v)
        getgenv().SilentAimEnabled = v
    end
}):Keybind({
    Name = "Silent Aim Keybind",
    Default = Enum.KeyCode.Q,
    KeybindName = "SilentAimKey",
    Mode = "Toggle",
    Callback = function(Input, State)
        Locked = State
        if Locked then
            Window:Notify("Locked onto "..(Target and Target.Name or "no target"))
        else
            Window:Notify("Unlocked")
            Highlight.Adornee = nil
        end
    end
})

AimSection:Slider({
    Name = "Field of View",
    Min = 0,
    Max = 500,
    Default = 120,
    Suffix = "°",
    Callback = function(v)
        FOV = v
        FOVCircle.Radius = v
    end
})

local FOVToggle = AimSection:Toggle({
    Name = "Show FOV",
    Default = false,
    Callback = function(v)
        ShowFOV = v
        FOVCircle.Visible = v
    end
})

AimSection:Dropdown({
    Name = "Hit Part",
    Default = "HumanoidRootPart",
    Options = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"},
    Callback = function(v)
        SelectedPart = v
    end
})

local AirshotToggle = AimSection:Toggle({
    Name = "Airshot Mode",
    Default = false,
    Callback = function(v)
        AirshotEnabled = v
    end
})

-- Visual Settings
local TracerToggle = VisualsSection:Toggle({
    Name = "Show Tracer",
    Default = true,
    Callback = function(v)
        ShowTracer = v
        Tracer.Transparency = v and 0.7 or 1
    end
}):Colorpicker({
    Name = "Tracer Color",
    Default = TracerColor,
    Callback = function(v)
        Tracer.Color = v
        TracerColor = v
    end
})

local HighlightToggle = VisualsSection:Toggle({
    Name = "Target Highlight",
    Default = true,
    Callback = function(v)
        ShowHighlight = v
        Highlight.Enabled = v
    end
}):Colorpicker({
    Name = "Highlight Color",
    Default = HighlightColor,
    Callback = function(v)
        Highlight.FillColor = v
        HighlightColor = v
    end
})

VisualsSection:Dropdown({
    Name = "Highlight Type",
    Default = "Full",
    Options = {"Box", "Outline", "Fill", "Full"},
    Callback = function(v)
        if v == "Box" then
            Highlight.FillTransparency = 1
            Highlight.OutlineTransparency = 0
        elseif v == "Outline" then
            Highlight.FillTransparency = 1
            Highlight.OutlineTransparency = 0
        elseif v == "Fill" then
            Highlight.FillTransparency = 0.5
            Highlight.OutlineTransparency = 1
        elseif v == "Full" then
            Highlight.FillTransparency = 0.5
            Highlight.OutlineTransparency = 0
        end
    end
})

-- UI Settings
SettingsSection:Keybind({
    Name = "Hide UI Keybind",
    Default = Enum.KeyCode.RightControl,
    KeybindName = "HideUIKey",
    Mode = "Toggle",
    Callback = function(Input, State)
        Window:Fade()
    end
})

SettingsSection:Label({
    Name = "loki.yf v1.0.0",
    Center = true
})

SettingsSection:Label({
    Name = "Created by yufi",
    Center = true
})

-- Functions
local function GetClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = FOV

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and 
           player.Character.Humanoid.Health > 0 and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
            
            if magnitude < shortestDistance then
                closestPlayer = player
                shortestDistance = magnitude
            end
        end
    end
    
    return closestPlayer
end

local function UpdatePing()
    local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    if ping < 50 then
        Prediction = 0.122
    elseif ping < 100 then
        Prediction = 0.131
    elseif ping < 150 then
        Prediction = 0.136
    elseif ping < 200 then
        Prediction = 0.142
    else
        Prediction = 0.15
    end
end

-- Main Loop
RunService.RenderStepped:Connect(function()
    -- Update FOV circle position
    FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + GuiService:GetGuiInset().Y)
    
    -- Update target
    Target = GetClosestPlayer()
    
    if Target then
        if ShowHighlight then
            Highlight.Adornee = Target.Character
        else
            Highlight.Adornee = nil
        end
        
        if Locked and Target.Character and Target.Character:FindFirstChild(SelectedPart) then
            -- Update tracer position
            if ShowTracer then
                Tracer.Position = Target.Character[SelectedPart].Position + (Target.Character[SelectedPart].Velocity * Prediction)
                Tracer.Orientation = Tracer.Orientation + Vector3.new(0, 1, 0)
            end
            
            -- Airshot logic
            if AirshotEnabled and Target.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                SelectedPart = "LeftFoot"
            else
                SelectedPart = "HumanoidRootPart"
            end
        end
    else
        Highlight.Adornee = nil
    end
    
    -- Update ping-based prediction
    UpdatePing()
end)

-- Silent Aim Hook
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()
    
    if Locked and method == "FireServer" and args[2] == "UpdateMousePos" and Target and Target.Character and Target.Character:FindFirstChild(SelectedPart) then
        args[3] = Target.Character[SelectedPart].Position + (Target.Character[SelectedPart].Velocity * Prediction)
        return old(unpack(args))
    end
    
    return old(...)
end)

-- Mobile support
if UserInputService.TouchEnabled then
    local touchGui = Instance.new("ScreenGui")
    touchGui.Name = "loki.TouchControls"
    touchGui.Parent = game:GetService("CoreGui")
    
    local lockButton = Instance.new("TextButton")
    lockButton.Name = "LockButton"
    lockButton.Size = UDim2.new(0, 100, 0, 50)
    lockButton.Position = UDim2.new(0.8, 0, 0.7, 0)
    lockButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    lockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    lockButton.Text = "LOCK (Q)"
    lockButton.Font = Enum.Font.GothamBold
    lockButton.TextSize = 14
    lockButton.Parent = touchGui
    
    lockButton.Activated:Connect(function()
        Locked = not Locked
        
        if Locked then
            lockButton.Text = "UNLOCK (Q)"
            lockButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            Window:Notify("Locked onto "..(Target and Target.Name or "no target"))
        else
            lockButton.Text = "LOCK (Q)"
            lockButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Window:Notify("Unlocked")
            Highlight.Adornee = nil
        end
    end)
end

-- Initialize UI
Window:Initialize()

-- Initial notification
Window:Notify("loki.yf loaded successfully!\nPress RightControl to hide UI")
