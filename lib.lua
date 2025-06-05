local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()

-- Set high FPS cap for maximum performance
setfpscap(985532)

-- Blue UI theme
library:SetColor("main", Color3.fromRGB(0, 120, 215))
library:SetColor("background", Color3.fromRGB(30, 30, 45))
library:SetColor("outline", Color3.fromRGB(20, 20, 35))
library:SetColor("accent", Color3.fromRGB(0, 150, 255))

local Window = library:CreateWindow({
    Title = "rewuh lock | Premium Edition",
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local MainTab = Window:AddTab("Main")
local VisualsTab = Window:AddTab("Visuals")

-- Initialize settings
getgenv().Settings = {
    SilentAim = {
        Enabled = false,
        Key = "t",
        Prediction = 0.15,
        AutoPrediction = true,
        JumpOffset = 0,
        HitPart = "HumanoidRootPart"
    },
    CamLock = {
        Enabled = false,
        Key = "Q",
        Prediction = 0.15,
        Smoothness = 10,
        JumpOffset = 0,
        HitPart = "Head",
        ShowTarget = true
    },
    Visuals = {
        Box = true,
        Name = true,
        Distance = true,
        Tool = true,
        Flags = true,
        Skeleton = true,
        Trail = true,
        Highlight = true,
        FOV = true
    }
}

-- Left Groupbox (Silent Aim)
local SilentAimGroup = MainTab:AddLeftGroupbox("Silent Aim")

SilentAimGroup:AddToggle("SilentAimEnabled", {
    Text = "Enabled",
    Default = false,
    Callback = function(Value)
        Settings.SilentAim.Enabled = Value
    end
}):AddKeyPicker("SilentAimKeybind", {
    Default = "T",
    Mode = "Toggle",
    Text = "Silent Aim Key",
    Callback = function(Value)
        Settings.SilentAim.Key = string.lower(Value)
    end
})

SilentAimGroup:AddInput("PredictionValue", {
    Text = "Prediction",
    Default = "0.15",
    Numeric = true,
    Callback = function(Value)
        Settings.SilentAim.Prediction = tonumber(Value) or 0.15
    end
})

SilentAimGroup:AddInput("JumpOffset", {
    Text = "Jump Offset",
    Default = "0",
    Numeric = true,
    Callback = function(Value)
        Settings.SilentAim.JumpOffset = tonumber(Value) or 0
    end
})

SilentAimGroup:AddToggle("AutoPrediction", {
    Text = "Auto Prediction",
    Default = true,
    Tooltip = "Automatically adjusts prediction based on ping",
    Callback = function(Value)
        Settings.SilentAim.AutoPrediction = Value
    end
})

SilentAimGroup:AddDivider()

SilentAimGroup:AddDropdown("HitPart", {
    Text = "Hitpart",
    Default = "HumanoidRootPart",
    Values = {"HumanoidRootPart", "LowerTorso", "UpperTorso", "Head"},
    Callback = function(Value)
        Settings.SilentAim.HitPart = Value
    end
})

-- Right Groupbox (CamLock)
local CamLockGroup = MainTab:AddRightGroupbox("CamLock")

CamLockGroup:AddToggle("CamLockEnabled", {
    Text = "Enabled",
    Default = false,
    Callback = function(Value)
        Settings.CamLock.Enabled = Value
    end
}):AddKeyPicker("CamLockKeybind", {
    Default = "Q",
    Mode = "Hold",
    Text = "CamLock Key",
    Callback = function(Value)
        Settings.CamLock.Key = Value
    end
})

CamLockGroup:AddInput("CamLockPrediction", {
    Text = "Prediction",
    Default = "0.15",
    Numeric = true,
    Callback = function(Value)
        Settings.CamLock.Prediction = tonumber(Value) or 0.15
    end
})

CamLockGroup:AddInput("CamLockSmoothness", {
    Text = "Smoothness",
    Default = "10",
    Numeric = true,
    Callback = function(Value)
        Settings.CamLock.Smoothness = tonumber(Value) or 10
    end
})

CamLockGroup:AddInput("CamLockJumpOffset", {
    Text = "Jump Offset",
    Default = "0",
    Numeric = true,
    Callback = function(Value)
        Settings.CamLock.JumpOffset = tonumber(Value) or 0
    end
})

CamLockGroup:AddDivider()

CamLockGroup:AddDropdown("CamLockHitPart", {
    Text = "Hitpart",
    Default = "Head",
    Values = {"HumanoidRootPart", "LowerTorso", "UpperTorso", "Head"},
    Callback = function(Value)
        Settings.CamLock.HitPart = Value
    end
})

CamLockGroup:AddToggle("CamLockShowTarget", {
    Text = "Show Target",
    Default = true,
    Callback = function(Value)
        Settings.CamLock.ShowTarget = Value
    end
})

-- Visuals Groupbox
local VisualsGroup = VisualsTab:AddLeftGroupbox("Player ESP")
VisualsGroup:AddToggle("BoxESP", {
    Text = "2D Box",
    Default = true,
    Callback = function(Value)
        Settings.Visuals.Box = Value
    end
})

VisualsGroup:AddToggle("NameESP", {
    Text = "Player Name",
    Default = true,
    Callback = function(Value)
        Settings.Visuals.Name = Value
    end
})

VisualsGroup:AddToggle("DistanceESP", {
    Text = "Distance",
    Default = true,
    Callback = function(Value)
        Settings.Visuals.Distance = Value
    end
})

VisualsGroup:AddToggle("ToolESP", {
    Text = "Equipped Tool",
    Default = true,
    Callback = function(Value)
        Settings.Visuals.Tool = Value
    end
})

VisualsGroup:AddToggle("FlagsESP", {
    Text = "Movement Flags",
    Default = true,
    Callback = function(Value)
        Settings.Visuals.Flags = Value
    end
})

VisualsGroup:AddToggle("SkeletonESP", {
    Text = "Skeleton",
    Default = true,
    Callback = function(Value)
        Settings.Visuals.Skeleton = Value
    end
})

VisualsGroup:AddToggle("TrailESP", {
    Text = "Player Trail",
    Default = true,
    Callback = function(Value)
        Settings.Visuals.Trail = Value
    end
})

VisualsGroup:AddToggle("HighlightESP", {
    Text = "Player Highlight",
    Default = true,
    Callback = function(Value)
        Settings.Visuals.Highlight = Value
    end
})

VisualsGroup:AddToggle("FOVCircle", {
    Text = "FOV Circle",
    Default = true,
    Callback = function(Value)
        Settings.Visuals.FOV = Value
    end
})

-- Advanced Visuals Settings
local AdvancedVisuals = VisualsTab:AddRightGroupbox("Advanced Visuals")
AdvancedVisuals:AddSlider("SkeletonThickness", {
    Text = "Skeleton Thickness",
    Default = 1,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Callback = function(Value)
        ESP.SkeletonThickness = Value
    end
})

AdvancedVisuals:AddSlider("TrailThickness", {
    Text = "Trail Thickness",
    Default = 1,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Callback = function(Value)
        ESP.TrailThickness = Value
    end
})

AdvancedVisuals:AddSlider("BoxThickness", {
    Text = "Box Thickness",
    Default = 1,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Callback = function(Value)
        ESP.BoxThickness = Value
    end
})

AdvancedVisuals:AddColorPicker("BoxColor", {
    Text = "Box Color",
    Default = Color3.fromRGB(0, 150, 255),
    Callback = function(Value)
        ESP.BoxColor = Value
    end
})

AdvancedVisuals:AddColorPicker("SkeletonColor", {
    Text = "Skeleton Color",
    Default = Color3.fromRGB(0, 150, 255),
    Callback = function(Value)
        ESP.SkeletonColor = Value
    end
})

AdvancedVisuals:AddColorPicker("HighlightColor", {
    Text = "Highlight Color",
    Default = Color3.fromRGB(0, 150, 255),
    Callback = function(Value)
        ESP.HighlightColor = Value
    end
})

-- Initialize watermark
library:SetWatermark("rewuh lock | FPS: " .. math.floor(1 / wait()))

library:OnUnload(function()
    print("UI unloaded!")
    if ESP then ESP:Destroy() end
end)

-- ESP Module
local ESP = {}
ESP.BoxColor = Color3.fromRGB(0, 150, 255)
ESP.SkeletonColor = Color3.fromRGB(0, 150, 255)
ESP.HighlightColor = Color3.fromRGB(0, 150, 255)
ESP.BoxThickness = 1
ESP.SkeletonThickness = 1
ESP.TrailThickness = 1

function ESP:Init()
    self.Players = game:GetService("Players")
    self.LocalPlayer = self.Players.LocalPlayer
    self.RunService = game:GetService("RunService")
    self.Camera = workspace.CurrentCamera
    self.PlayerData = {}
    
    self.R6Connections = {
        {"Head", "Torso"},
        {"Torso", "Left Arm"},
        {"Torso", "Right Arm"},
        {"Torso", "Left Leg"},
        {"Torso", "Right Leg"}
    }
    
    self.R15Connections = {
        {"Head", "UpperTorso"},
        {"UpperTorso", "LowerTorso"},
        {"UpperTorso", "LeftUpperArm"},
        {"UpperTorso", "RightUpperArm"},
        {"LeftUpperArm", "LeftLowerArm"},
        {"LeftLowerArm", "LeftHand"},
        {"RightUpperArm", "RightLowerArm"},
        {"RightLowerArm", "RightHand"},
        {"LowerTorso", "LeftUpperLeg"},
        {"LowerTorso", "RightUpperLeg"},
        {"LeftUpperLeg", "LeftLowerLeg"},
        {"LeftLowerLeg", "LeftFoot"},
        {"RightUpperLeg", "RightLowerLeg"},
        {"RightLowerLeg", "RightFoot"}
    }
    
    self:SetupConnections()
end

function ESP:SetupConnections()
    self.Players.PlayerAdded:Connect(function(player)
        self:PlayerAdded(player)
    end)
    
    self.Players.PlayerRemoving:Connect(function(player)
        self:PlayerRemoved(player)
    end)
    
    for _, player in ipairs(self.Players:GetPlayers()) do
        if player ~= self.LocalPlayer then
            self:PlayerAdded(player)
        end
    end
    
    self.RunService.RenderStepped:Connect(function()
        self:Update()
    end)
end

function ESP:PlayerAdded(player)
    self.PlayerData[player] = {
        Drawings = {},
        Highlight = nil,
        Trail = nil
    }
    
    player.CharacterAdded:Connect(function(character)
        self:CharacterAdded(player, character)
    end)
    
    if player.Character then
        self:CharacterAdded(player, player.Character)
    end
end

function ESP:PlayerRemoved(player)
    if self.PlayerData[player] then
        for _, drawing in pairs(self.PlayerData[player].Drawings) do
            drawing:Remove()
        end
        
        if self.PlayerData[player].Highlight then
            self.PlayerData[player].Highlight:Destroy()
        end
        
        if self.PlayerData[player].Trail then
            self.PlayerData[player].Trail:Destroy()
        end
        
        self.PlayerData[player] = nil
    end
end

function ESP:CharacterAdded(player, character)
    if not self.PlayerData[player] then return end
    
    -- Clear previous drawings
    for _, drawing in pairs(self.PlayerData[player].Drawings) do
        drawing:Remove()
    end
    self.PlayerData[player].Drawings = {}
    
    -- Create highlight
    if Settings.Visuals.Highlight then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = self.HighlightColor
        highlight.OutlineColor = Color3.new(0, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = character
        self.PlayerData[player].Highlight = highlight
    end
    
    -- Create trail
    if Settings.Visuals.Trail and character:FindFirstChild("HumanoidRootPart") then
        local attachment0 = Instance.new("Attachment")
        attachment0.Position = Vector3.new(0, 0, 0)
        attachment0.Parent = character.HumanoidRootPart
        
        local attachment1 = Instance.new("Attachment")
        attachment1.Position = Vector3.new(0, 0, -0.5)
        attachment1.Parent = character.HumanoidRootPart
        
        local trail = Instance.new("Trail")
        trail.Attachment0 = attachment0
        trail.Attachment1 = attachment1
        trail.WidthScale = NumberSequence.new(self.TrailThickness)
        trail.Color = ColorSequence.new(Color3.new(0, 0.6, 1))
        trail.Parent = character.HumanoidRootPart
        self.PlayerData[player].Trail = trail
    end
    
    -- Create drawings for ESP
    self.PlayerData[player].Drawings = {
        BoxOutline = Drawing.new("Square"),
        Box = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        Tool = Drawing.new("Text"),
        Flags = Drawing.new("Text")
    }
    
    -- Configure drawings
    local drawings = self.PlayerData[player].Drawings
    drawings.BoxOutline.Thickness = self.BoxThickness + 1
    drawings.BoxOutline.Color = Color3.new(0, 0, 0)
    drawings.BoxOutline.Transparency = 1
    drawings.BoxOutline.Filled = false
    
    drawings.Box.Thickness = self.BoxThickness
    drawings.Box.Color = self.BoxColor
    drawings.Box.Transparency = 1
    drawings.Box.Filled = false
    
    for _, text in pairs({drawings.Name, drawings.Distance, drawings.Tool, drawings.Flags}) do
        text.Outline = true
        text.Font = 2
        text.Size = 13
        text.Color = Color3.new(1, 1, 1)
    end
end

function ESP:Update()
    local watermarkText = string.format("rewuh lock | FPS: %d | Ping: %d", 
        math.floor(1 / wait()), 
        game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    )
    library:SetWatermark(watermarkText)
    
    for player, data in pairs(self.PlayerData) do
        if player ~= self.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local character = player.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local hrp = character.HumanoidRootPart
            
            if humanoid and humanoid.Health > 0 then
                -- Update position
                local headPos, headOnScreen = self.Camera:WorldToViewportPoint(character.Head.Position)
                local footPos = self.Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                
                if headOnScreen then
                    -- Calculate box dimensions
                    local height = math.abs(footPos.Y - headPos.Y)
                    local width = height * 0.65
                    local x = headPos.X - width/2
                    local y = headPos.Y - height * 0.2
                    
                    -- Update box drawings
                    if Settings.Visuals.Box then
                        data.Drawings.BoxOutline.Visible = true
                        data.Drawings.Box.Visible = true
                        data.Drawings.BoxOutline.Size = Vector2.new(width, height)
                        data.Drawings.BoxOutline.Position = Vector2.new(x, y)
                        data.Drawings.Box.Size = Vector2.new(width, height)
                        data.Drawings.Box.Position = Vector2.new(x, y)
                        data.Drawings.Box.Color = self.BoxColor
                    else
                        data.Drawings.BoxOutline.Visible = false
                        data.Drawings.Box.Visible = false
                    end
                    
                    -- Update name
                    if Settings.Visuals.Name then
                        data.Drawings.Name.Visible = true
                        data.Drawings.Name.Text = player.Name
                        data.Drawings.Name.Position = Vector2.new(headPos.X, y - 20)
                        data.Drawings.Name.Center = true
                    else
                        data.Drawings.Name.Visible = false
                    end
                    
                    -- Update distance
                    if Settings.Visuals.Distance then
                        data.Drawings.Distance.Visible = true
                        local distance = math.floor((hrp.Position - self.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                        data.Drawings.Distance.Text = distance .. " studs"
                        data.Drawings.Distance.Position = Vector2.new(headPos.X, y + height + 5)
                        data.Drawings.Distance.Center = true
                    else
                        data.Drawings.Distance.Visible = false
                    end
                    
                    -- Update tool
                    if Settings.Visuals.Tool then
                        data.Drawings.Tool.Visible = true
                        local tool = "Fists"
                        for _, child in ipairs(character:GetChildren()) do
                            if child:IsA("Tool") then
                                tool = child.Name
                                break
                            end
                        end
                        data.Drawings.Tool.Text = "[" .. tool .. "]"
                        data.Drawings.Tool.Position = Vector2.new(headPos.X, y + height + 20)
                        data.Drawings.Tool.Center = true
                    else
                        data.Drawings.Tool.Visible = false
                    end
                    
                    -- Update flags
                    if Settings.Visuals.Flags then
                        data.Drawings.Flags.Visible = true
                        local state = "Idle"
                        if humanoid:GetState() == Enum.HumanoidStateType.Running then
                            state = "Running"
                        elseif humanoid:GetState() == Enum.HumanoidStateType.Jumping then
                            state = "Jumping"
                        elseif humanoid:GetState() == Enum.HumanoidStateType.FallingDown then
                            state = "Falling"
                        end
                        data.Drawings.Flags.Text = "[" .. state .. "]"
                        data.Drawings.Flags.Position = Vector2.new(headPos.X, y + height + 35)
                        data.Drawings.Flags.Center = true
                    else
                        data.Drawings.Flags.Visible = false
                    end
                    
                    -- Update skeleton
                    if Settings.Visuals.Skeleton then
                        self:DrawSkeleton(player, character)
                    end
                    
                    -- Update highlight
                    if data.Highlight then
                        data.Highlight.Enabled = Settings.Visuals.Highlight
                        data.Highlight.FillColor = self.HighlightColor
                    end
                    
                    -- Update trail
                    if data.Trail then
                        data.Trail.Enabled = Settings.Visuals.Trail
                    end
                else
                    for _, drawing in pairs(data.Drawings) do
                        drawing.Visible = false
                    end
                end
            else
                for _, drawing in pairs(data.Drawings) do
                    drawing.Visible = false
                end
            end
        end
    end
end

function ESP:DrawSkeleton(player, character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    local rigType = humanoid.RigType.Name
    local connections = rigType == "R6" and self.R6Connections or self.R15Connections
    
    for _, connection in ipairs(connections) do
        local part1 = character:FindFirstChild(connection[1])
        local part2 = character:FindFirstChild(connection[2])
        
        if part1 and part2 then
            local pos1 = self.Camera:WorldToViewportPoint(part1.Position)
            local pos2 = self.Camera:WorldToViewportPoint(part2.Position)
            
            if pos1 and pos2 then
                if not self.PlayerData[player].Drawings[connection[1]..connection[2]] then
                    self.PlayerData[player].Drawings[connection[1]..connection[2]] = Drawing.new("Line")
                    local line = self.PlayerData[player].Drawings[connection[1]..connection[2]]
                    line.Thickness = self.SkeletonThickness
                    line.Color = self.SkeletonColor
                end
                
                local line = self.PlayerData[player].Drawings[connection[1]..connection[2]]
                line.Visible = true
                line.From = Vector2.new(pos1.X, pos1.Y)
                line.To = Vector2.new(pos2.X, pos2.Y)
            end
        end
    end
end

function ESP:Destroy()
    for player, data in pairs(self.PlayerData) do
        for _, drawing in pairs(data.Drawings) do
            if drawing and drawing.Remove then
                drawing:Remove()
            end
        end
        
        if data.Highlight then
            data.Highlight:Destroy()
        end
        
        if data.Trail then
            data.Trail:Destroy()
        end
    end
    
    self.PlayerData = {}
end

-- Initialize ESP
ESP:Init()

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(0, 150, 255)
FOVCircle.Thickness = 1
FOVCircle.NumSides = 25
FOVCircle.Radius = 100
FOVCircle.Transparency = 0.7
FOVCircle.Visible = Settings.Visuals.FOV
FOVCircle.Filled = false

-- Initialize variables
local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local Runserv = game:GetService("RunService")
local CC = game:GetService("Workspace").CurrentCamera

Runserv.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(mouse.X, mouse.Y + 35)
    FOVCircle.Visible = Settings.Visuals.FOV
    FOVCircle.Color = ESP.BoxColor
end)

-- Secure hook
local mt = getrawmetatable(game)
local old_index = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(t, k)
    if checkcaller() then return old_index(t, k) end
    
    if Settings.SilentAim.Enabled and SilentAimEnabled and k == "UpdateMousePosI" then
        return SilentAimTarget.Character[Settings.SilentAim.HitPart].Position + 
               (SilentAimTarget.Character[Settings.SilentAim.HitPart].Velocity * Settings.SilentAim.Prediction)
    end
    
    return old_index(t, k)
end)

setreadonly(mt, true)

-- Target finding functions
local SilentAimTarget = nil
local SilentAimEnabled = false
local CamLockTarget = nil
local CamLockActive = false

function getClosestPlayerToCursor(FOV)
    local closestPlayer
    local shortestDistance = FOV or 100

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and 
           v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

-- Keybind handler
game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(k)
    -- Silent Aim Keybind
    if k:lower() == Settings.SilentAim.Key and Settings.SilentAim.Enabled then
        SilentAimEnabled = not SilentAimEnabled
        if SilentAimEnabled then
            SilentAimTarget = getClosestPlayerToCursor()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Silent Aim",
                Text = SilentAimTarget and "Locked: "..SilentAimTarget.Name or "No target found",
                Duration = 1
            })
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Silent Aim",
                Text = "Unlocked",
                Duration = 1
            })
        end
    end
    
    -- CamLock Keybind
    if k:lower() == Settings.CamLock.Key:lower() and Settings.CamLock.Enabled then
        CamLockActive = true
        CamLockTarget = getClosestPlayerToCursor()
        if Settings.CamLock.ShowTarget and CamLockTarget then
            game.StarterGui:SetCore("SendNotification", {
                Title = "CamLock",
                Text = "Locked: "..CamLockTarget.Name,
                Duration = 1
            })
        end
    end
end)

game.Players.LocalPlayer:GetMouse().KeyUp:Connect(function(k)
    if k:lower() == Settings.CamLock.Key:lower() then
        CamLockActive = false
        if Settings.CamLock.ShowTarget then
            game.StarterGui:SetCore("SendNotification", {
                Title = "CamLock",
                Text = "Unlocked",
                Duration = 1
            })
        end
    end
end)

-- CamLock function
local function CamLock()
    if CamLockActive and CamLockTarget and CamLockTarget.Character and 
       CamLockTarget.Character:FindFirstChild(Settings.CamLock.HitPart) then
        
        local TargetPart = CamLockTarget.Character[Settings.CamLock.HitPart]
        local Camera = workspace.CurrentCamera
        
        -- Apply jump offset
        local offset = Vector3.new(0, Settings.CamLock.JumpOffset, 0)
        
        -- Calculate target position with prediction
        local TargetPosition = TargetPart.Position + offset + 
                              (TargetPart.Velocity * Settings.CamLock.Prediction)
        
        -- Smooth camera movement
        local CameraPosition = Camera.CFrame.Position
        local Direction = (TargetPosition - CameraPosition).Unit
        local LookAt = CFrame.new(CameraPosition, CameraPosition + Direction)
        
        Camera.CFrame = Camera.CFrame:Lerp(
            LookAt,
            1 / Settings.CamLock.Smoothness
        )
    end
end

-- Main loop
Runserv.RenderStepped:Connect(function()
    -- Update CamLock
    if Settings.CamLock.Enabled and CamLockActive then
        CamLock()
    end
    
    -- Update FOV Circle
    FOVCircle.Radius = 100
end)

-- Auto prediction adjustment
spawn(function()
    while wait(1) do
        if Settings.SilentAim.AutoPrediction then
            local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
            local split = string.split(pingvalue, '(')
            local ping = tonumber(split[1])
            
            -- Auto adjust prediction based on ping
            if ping < 50 then
                Settings.SilentAim.Prediction = 0.11
            elseif ping < 100 then
                Settings.SilentAim.Prediction = 0.13
            elseif ping < 150 then
                Settings.SilentAim.Prediction = 0.15
            else
                Settings.SilentAim.Prediction = 0.18
            end
        end
    end
end)
