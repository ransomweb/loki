--[[
    Loki.yf - Premium Silent Aim
    Created by yufi (2025)
    UI Library: Abyss Lib
]]

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Stats = game:GetService("Stats")

-- Local Player
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/drillygzzly/Roblox-UI-Libs/main/Abyss%20Lib/Abyss%20Lib%20Source.lua"))()
local LoadTime = tick()

-- Loader
local Loader = Library.CreateLoader(
    "loki.yf", 
    Vector2.new(300, 300)
)

-- Main Window
local Window = Library.Window(
    "loki.yf | Silent Aim", 
    Vector2.new(500, 400)
)

-- Notifications
Window.SendNotification(
    "Normal",
    "Press RightShift to toggle menu",
    5
)

Window.Watermark("loki.yf | Premium")

-- Main Tab
local MainTab = Window:Tab("Main")
local AimSection = MainTab:Section("Aim Settings", "Left")
local ConfigSection = MainTab:Section("Configuration", "Right")

-- Variables
local Prediction = 0.136
local Target = nil
local Locked = false
local FOV = 120
local ShowFOV = true
local SelectedPart = "HumanoidRootPart"
local AutoPrediction = true

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = ShowFOV
FOVCircle.Radius = FOV
FOVCircle.Thickness = 1
FOVCircle.Transparency = 1
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Filled = false
FOVCircle.NumSides = 64

-- UI Elements
local SilentAimToggle = AimSection:Toggle({
    Title = "Silent Aim", 
    Flag = "SilentAimToggle",
    Type = "Dangerous",
    Callback = function(v)
        Locked = v
        if v then
            Window.SendNotification("Normal", "Silent Aim Enabled", 2)
        else
            Window.SendNotification("Normal", "Silent Aim Disabled", 2)
        end
    end
}):Keybind({
    Title = "Aim Keybind",
    Flag = "AimKeybind",
    Key = Enum.KeyCode.Q,
    StateType = "Toggle"
})

AimSection:Slider({
    Title = "FOV Size", 
    Flag = "FOVSlider",
    Symbol = "°",
    Default = 120,
    Min = 0,
    Max = 500,
    Decimals = 0,
    Callback = function(v)
        FOV = v
        FOVCircle.Radius = v
    end
})

AimSection:Toggle({
    Title = "Show FOV", 
    Flag = "ShowFOV",
    Callback = function(v)
        ShowFOV = v
        FOVCircle.Visible = v
    end
})

AimSection:Dropdown({
    Title = "Hit Part", 
    List = {"HumanoidRootPart", "Head", "UpperTorso", "LowerTorso"}, 
    Default = "HumanoidRootPart", 
    Flag = "HitPartDropdown",
    Callback = function(v)
        SelectedPart = v
    end
})

AimSection:Toggle({
    Title = "Auto Prediction", 
    Flag = "AutoPrediction",
    Default = true,
    Callback = function(v)
        AutoPrediction = v
    end
})

ConfigSection:TextBox({
    Title = "Manual Prediction", 
    Flag = "ManualPrediction",
    Placeholder = "Enter prediction value...",
    Callback = function(v)
        if tonumber(v) then
            Prediction = tonumber(v)
            if not AutoPrediction then
                Window.SendNotification("Normal", "Prediction set to: "..v, 2)
            end
        end
    end
})

ConfigSection:Keybind({
    Title = "Hide UI Keybind",
    Flag = "HideUIKeybind",
    Key = Enum.KeyCode.RightControl,
    StateType = "Toggle",
    Callback = function(Input, State)
        Window:Fade()
    end
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

local function UpdatePrediction()
    if AutoPrediction then
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
end

-- Main Loop
RunService.RenderStepped:Connect(function()
    -- Update FOV circle
    FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + GuiService:GetGuiInset().Y)
    
    -- Update target
    Target = GetClosestPlayer()
    
    -- Update prediction
    UpdatePrediction()
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

-- Initialize UI
Window:AddSettingsTab()
Window:SwitchTab(MainTab)
Window.ToggleAnime(false)
LoadTime = math.floor((tick() - LoadTime) * 1000)

-- Final notification
Window.SendNotification("Normal", "loki.yf loaded in "..LoadTime.."ms", 5)
