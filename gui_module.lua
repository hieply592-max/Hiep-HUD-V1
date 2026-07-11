-- gui_module.lua - Module GUI cho AOT Revolution hack
local GUIModule = {}
GUIModule.__index = GUIModule

function GUIModule.new(hackInstance)
    local self = setmetatable({}, GUIModule)
    self.hack = hackInstance
    self.screenGui = nil
    self.mainFrame = nil
    self.tabs = {}
    self.currentTab = nil
    self.elements = {}
    self.isVisible = true
    self.Players = game:GetService("Players")
    self.UserInputService = game:GetService("UserInputService")
    self.TweenService = game:GetService("TweenService")
    return self
end

function GUIModule:startGUI()
    local success, err = pcall(function()
        self.screenGui = Instance.new("ScreenGui")
        self.screenGui.Name = "AOT_Hack_GUI"
        self.screenGui.ResetOnSpawn = false
        self.screenGui.Parent = self.Players.LocalPlayer:WaitForChild("PlayerGui")
        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.Size = UDim2.new(0, 600, 0, 450)
        mainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
        mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        mainFrame.BorderSizePixel = 0
        mainFrame.Active = true
        mainFrame.Draggable = true
        mainFrame.Parent = self.screenGui
        local titleBar = Instance.new("Frame")
        titleBar.Name = "TitleBar"
        titleBar.Size = UDim2.new(1, 0, 0, 35)
        titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        titleBar.BorderSizePixel = 0
        titleBar.Parent = mainFrame
        local title = Instance.new("TextLabel")
        title.Name = "Title"
        title.Size = UDim2.new(1, -40, 1, 0)
        title.Position = UDim2.new(0, 10, 0, 0)
        title.BackgroundTransparency = 1
        title.Text = "AOT Revolution Hack v3.0"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 16
        title.Font = Enum.Font.GothamBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = titleBar
        local closeButton = Instance.new("TextButton")
        closeButton.Name = "CloseButton"
        closeButton.Size = UDim2.new(0, 30, 0, 30)
        closeButton.Position = UDim2.new(1, -35, 0, 2)
        closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        closeButton.BorderSizePixel = 0
        closeButton.Text = "X"
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.TextSize = 16
        closeButton.Font = Enum.Font.GothamBold
        closeButton.Parent = titleBar
        closeButton.MouseButton1Click:Connect(function()
            self.isVisible = not self.isVisible
            mainFrame.Visible = self.isVisible
        end)
        local tabBar = Instance.new("Frame")
        tabBar.Name = "TabBar"
        tabBar.Size = UDim2.new(0, 120, 1, -35)
        tabBar.Position = UDim2.new(0, 0, 0, 35)
        tabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        tabBar.BorderSizePixel = 0
        tabBar.Parent = mainFrame
        local contentFrame = Instance.new("Frame")
        contentFrame.Name = "ContentFrame"
        contentFrame.Size = UDim2.new(1, -120, 1, -35)
        contentFrame.Position = UDim2.new(0, 120, 0, 35)
        contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        contentFrame.BorderSizePixel = 0
        contentFrame.Parent = mainFrame
        self.mainFrame = mainFrame
        self.tabBar = tabBar
        self.contentFrame = contentFrame
        self:createTabs()
        print("[+] GUI created successfully")
    end)
    if not success then
        warn("[-] Failed to create GUI: " .. tostring(err))
    end
end

function GUIModule:createTabs()
    local tabs = {"Aimbot", "ESP", "Movement", "Combat", "Farm", "Misc", "Settings"}
    local yPos = 5
    for _, tabName in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName .. "Tab"
        tabButton.Size = UDim2.new(1, -10, 0, 30)
        tabButton.Position = UDim2.new(0, 5, 0, yPos)
        tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        tabButton.BorderSizePixel = 0
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.Gotham
        tabButton.Parent = self.tabBar
        tabButton.MouseButton1Click:Connect(function()
            self:switchTab(tabName)
        end)
        self.tabs[tabName] = tabButton
        yPos = yPos + 35
    end
    self:switchTab("Aimbot")
end

function GUIModule:switchTab(tabName)
    for name, button in pairs(self.tabs) do
        if name == tabName then
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        else
            button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end
    end
    for _, child in ipairs(self.contentFrame:GetChildren()) do
        child:Destroy()
    end
    self.currentTab = tabName
    if tabName == "Aimbot" then self:createAimbotTab()
    elseif tabName == "ESP" then self:createESPTab()
    elseif tabName == "Movement" then self:createMovementTab()
    elseif tabName == "Combat" then self:createCombatTab()
    elseif tabName == "Farm" then self:createFarmTab()
    elseif tabName == "Misc" then self:createMiscTab()
    elseif tabName == "Settings" then self:createSettingsTab()
    end
end

function GUIModule:createToggle(text, position, callback, default)
    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(1, -20, 0, 25)
    toggle.Position = position
    toggle.BackgroundTransparency = 1
    toggle.Parent = self.contentFrame
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggle
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 40, 0, 20)
    button.Position = UDim2.new(1, -40, 0, 2)
    button.BackgroundColor3 = default and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    button.BorderSizePixel = 0
    button.Text = default and "ON" or "OFF"
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 11
    button.Font = Enum.Font.GothamBold
    button.Parent = toggle
    local isOn = default or false
    button.MouseButton1Click:Connect(function()
        isOn = not isOn
        button.Text = isOn and "ON" or "OFF"
        button.BackgroundColor3 = isOn and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        if callback then callback(isOn) end
    end)
    return toggle
end

function GUIModule:createSlider(text, position, min, max, default, callback)
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -20, 0, 50)
    slider.Position = position
    slider.BackgroundTransparency = 1
    slider.Parent = self.contentFrame
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = slider
    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, 0, 0, 10)
    sliderBar.Position = UDim2.new(0, 0, 0, 25)
    sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderBar.BorderSizePixel = 0
    sliderBar.Parent = slider
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBar
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 14, 0, 14)
    sliderButton.Position = UDim2.new((default - min) / (max - min), -7, 0, -2)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.BorderSizePixel = 0
    sliderButton.Text = ""
    sliderButton.Parent = sliderBar
    local value = default
    local function updateSlider(input)
        local pos = (input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X
        pos = math.clamp(pos, 0, 1)
        value = min + (max - min) * pos
        value = math.floor(value * 10 + 0.5) / 10
        label.Text = text .. ": " .. value
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        sliderButton.Position = UDim2.new(pos, -7, 0, -2)
        if callback then callback(value) end
    end
    sliderButton.MouseButton1Down:Connect(function()
        local connection
        connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                updateSlider(input)
            end
        end)
        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end)
    return slider
end

function GUIModule:createAimbotTab()
    self:createToggle("Enable Aimbot", UDim2.new(0, 10, 0, 10),
        function(val) self.hack.Config:setSetting("aimbotEnabled", val) end,
        self.hack.Config:getSetting("aimbotEnabled"))
    self:createSlider("Aim Speed", UDim2.new(0, 10, 0, 40), 1, 20,
        self.hack.Config:getSetting("aimbotSpeed"),
        function(val) self.hack.Config:setSetting("aimbotSpeed", val) end)
    self:createSlider("Aim FOV", UDim2.new(0, 10, 0, 95), 30, 360,
        self.hack.Config:getSetting("aimbotFOV"),
        function(val) self.hack.Config:setSetting("aimbotFOV", val) end)
    self:createToggle("Visibility Check", UDim2.new(0, 10, 0, 150),
        function(val) self.hack.Config:setSetting("aimbotVisCheck", val) end,
        self.hack.Config:getSetting("aimbotVisCheck"))
    self:createToggle("Team Check", UDim2.new(0, 10, 0, 180),
        function(val) self.hack.Config:setSetting("aimbotTeamCheck", val) end,
        self.hack.Config:getSetting("aimbotTeamCheck"))
end

function GUIModule:createESPTab()
    self:createToggle("Enable ESP", UDim2.new(0, 10, 0, 10),
        function(val) self.hack.Config:setSetting("espEnabled", val) end,
        self.hack.Config:getSetting("espEnabled"))
    self:createToggle("Show Distance", UDim2.new(0, 10, 0, 40),
        function(val) self.hack.Config:setSetting("espDistance", val) end,
        self.hack.Config:getSetting("espDistance"))
    self:createToggle("Show Health", UDim2.new(0, 10, 0, 70),
        function(val) self.hack.Config:setSetting("espHealth", val) end,
        self.hack.Config:getSetting("espHealth"))
    self:createToggle("Show Name", UDim2.new(0, 10, 0, 100),
        function(val) self.hack.Config:setSetting("espName", val) end,
        self.hack.Config:getSetting("espName"))
    self:createToggle("Show Tracers", UDim2.new(0, 10, 0, 130),
        function(val) self.hack.Config:setSetting("espTracers", val) end,
        self.hack.Config:getSetting("espTracers"))
    self:createSlider("Max Distance", UDim2.new(0, 10, 0, 160), 100, 2000,
        self.hack.Config:getSetting("espMaxDist"),
        function(val) self.hack.Config:setSetting("espMaxDist", val) end)
end

function GUIModule:createMovementTab()
    self:createToggle("Speed Hack", UDim2.new(0, 10, 0, 10),
        function(val) self.hack.Config:setSetting("speedEnabled", val) end,
        self.hack.Config:getSetting("speedEnabled"))
    self:createSlider("Speed Multiplier", UDim2.new(0, 10, 0, 40), 1, 10,
        self.hack.Config:getSetting("speedMult"),
        function(val) self.hack.Config:setSetting("speedMult", val) end)
    self:createToggle("Fly Mode", UDim2.new(0, 10, 0, 95),
        function(val) self.hack.Config:setSetting("flyEnabled", val) end,
        self.hack.Config:getSetting("flyEnabled"))
    self:createSlider("Fly Speed", UDim2.new(0, 10, 0, 125), 5, 50,
        self.hack.Config:getSetting("flySpeed"),
        function(val) self.hack.Config:setSetting("flySpeed", val) end)
    self:createToggle("NoClip", UDim2.new(0, 10, 0, 180),
        function(val) self.hack.Config:setSetting("noclip", val) end,
        self.hack.Config:getSetting("noclip"))
end

function GUIModule:createCombatTab()
    self:createToggle("God Mode", UDim2.new(0, 10, 0, 10),
        function(val) self.hack.Config:setSetting("godMode", val) end,
        self.hack.Config:getSetting("godMode"))
    self:createSlider("Damage Multiplier", UDim2.new(0, 10, 0, 40), 1, 100,
        self.hack.Config:getSetting("dmgMult"),
        function(val) self.hack.Config:setSetting("dmgMult", val) end)
    self:createToggle("No Skill Cooldown", UDim2.new(0, 10, 0, 95),
        function(val) self.hack.Config:setSetting("noCooldown", val) end,
        self.hack.Config:getSetting("noCooldown"))
    self:createToggle("Triggerbot", UDim2.new(0, 10, 0, 125),
        function(val) self.hack.Config:setSetting("triggerEnabled", val) end,
        self.hack.Config:getSetting("triggerEnabled"))
    self:createSlider("Trigger Delay (ms)", UDim2.new(0, 10, 0, 155), 0, 500,
        self.hack.Config:getSetting("triggerDelay"),
        function(val) self.hack.Config:setSetting("triggerDelay", val) end)
end

function GUIModule:createFarmTab()
    self:createToggle("Auto Farm", UDim2.new(0, 10, 0, 10),
        function(val)
            if val then
                self.hack.Config:setSetting("farmMode", "auto")
            else
                self.hack.Config:setSetting("farmMode", "off")
            end
        end,
        self.hack.Config:getSetting("farmMode") == "auto")
    self:createToggle("Auto Loot", UDim2.new(0, 10, 0, 40),
        function(val) self.hack.Config:setSetting("autoLoot", val) end,
        self.hack.Config:getSetting("autoLoot"))
    self:createSlider("Loot Range", UDim2.new(0, 10, 0, 70), 10, 200,
        self.hack.Config:getSetting("lootRange"),
        function(val) self.hack.Config:setSetting("lootRange", val) end)
    self:createToggle("Anti AFK", UDim2.new(0, 10, 0, 125),
        function(val) self.hack.Config:setSetting("antiAFK", val) end,
        self.hack.Config:getSetting("antiAFK"))
end

function GUIModule:createMiscTab()
    self:createToggle("Radar", UDim2.new(0, 10, 0, 10),
        function(val) self.hack.Config:setSetting("radarEnabled", val) end,
        self.hack.Config:getSetting("radarEnabled"))
    self:createSlider("Radar Range", UDim2.new(0, 10, 0, 40), 100, 1000,
        self.hack.Config:getSetting("radarRange"),
        function(val) self.hack.Config:setSetting("radarRange", val) end)
    self:createToggle("Lag Switch", UDim2.new(0, 10, 0, 95),
        function(val) self.hack.Config:setSetting("lagSwitch", val) end,
        self.hack.Config:getSetting("lagSwitch"))
    self:createToggle("Packet Spoof", UDim2.new(0, 10, 0, 125),
        function(val) self.hack.Config:setSetting("packetSpoof", val) end,
        self.hack.Config:getSetting("packetSpoof"))
    self:createSlider("Camera FOV", UDim2.new(0, 10, 0, 155), 30, 150,
        self.hack.Config:getSetting("cameraFOV"),
        function(val) self.hack.Config:setSetting("cameraFOV", val) end)
end

function GUIModule:createSettingsTab()
    local resetButton = Instance.new("TextButton")
    resetButton.Size = UDim2.new(0, 150, 0, 30)
    resetButton.Position = UDim2.new(0, 10, 0, 10)
    resetButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    resetButton.BorderSizePixel = 0
    resetButton.Text = "Reset Settings"
    resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetButton.TextSize = 14
    resetButton.Font = Enum.Font.Gotham
    resetButton.Parent = self.contentFrame
    resetButton.MouseButton1Click:Connect(function()
        self.hack.Config:resetToDefault()
    end)
    local saveButton = Instance.new("TextButton")
    saveButton.Size = UDim2.new(0, 150, 0, 30)
    saveButton.Position = UDim2.new(0, 10, 0, 50)
    saveButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    saveButton.BorderSizePixel = 0
    saveButton.Text = "Save Settings"
    saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    saveButton.TextSize = 14
    saveButton.Font = Enum.Font.Gotham
    saveButton.Parent = self.contentFrame
    saveButton.MouseButton1Click:Connect(function()
        self.hack.Config:saveConfig()
    end)
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -20, 0, 200)
    infoLabel.Position = UDim2.new(0, 10, 0, 100)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "AOT Revolution Hack v3.0\nDelta X Edition\n\nMade for Roblox\n\nPress Insert to toggle menu\nPress End to unload hack"
    infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    infoLabel.TextSize = 12
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.TextYAlignment = Enum.TextYAlignment.Top
    infoLabel.Parent = self.contentFrame
end

function GUIModule:render()
    if not self.mainFrame then return end
    if self.UserInputService:IsKeyDown(Enum.KeyCode.Insert) then
        self.isVisible = not self.isVisible
        self.mainFrame.Visible = self.isVisible
        task.wait(0.3)
    end
end

function GUIModule:destroy()
    if self.screenGui then
        self.screenGui:Destroy()
        self.screenGui = nil
    end
end

function GUIModule:update() end

function GUIModule:shutdown()
    self:destroy()
end

return GUIModule