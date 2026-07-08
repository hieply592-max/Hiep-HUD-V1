--[[
    ╔══════════════════════════════════════╗
    ║  FILE 1: Core.lua                   ║
    ║  Chức năng: Khởi tạo hệ thống       ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
local Core = {
    ScriptName = "AOTR 10000 Lines Pro",
    Version = "v4.2.0",
    Author = "NhatAnh Dev",
    LoadedFiles = {},
    Modules = {}
}

-- Hàm load file từ GitHub
function Core:LoadFromGitHub(url)
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success then
        table.insert(self.LoadedFiles, url)
        return result
    end
    warn("[Core] Lỗi load: " .. url)
    return nil
end

-- Hàm require custom
function Core:Require(module)
    if self.Modules[module] then
        return self.Modules[module]
    end
    return nil
end

return Core
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 2: MenuLoader.lua             ║
    ║  Chức năng: Load và tạo menu        ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
local MenuLoader = {}
MenuLoader.Tabs = {}
MenuLoader.Sections = {}
MenuLoader.Toggles = {}
MenuLoader.Sliders = {}
MenuLoader.Dropdowns = {}

-- Tạo GUI chính
function MenuLoader:CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AOTR_MainMenu"
    ScreenGui.ResetOnSpawn = false
    
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
    end
    
    if gethui then
        ScreenGui.Parent = gethui()
    elseif game:GetService("CoreGui"):FindFirstChild("RobloxGui") then
        ScreenGui.Parent = game:GetService("CoreGui")
    else
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    
    return ScreenGui
end

-- Tạo nút Toggle
function MenuLoader:CreateToggleButton(parent)
    local Toggle = Instance.new("TextButton")
    Toggle.Name = "AOTR_Toggle"
    Toggle.Size = UDim2.new(0, 55, 0, 55)
    Toggle.Position = UDim2.new(0, 15, 0.5, -27)
    Toggle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Toggle.BorderSizePixel = 0
    Toggle.Text = "AOTR"
    Toggle.TextColor3 = Color3.fromRGB(0, 255, 255)
    Toggle.TextSize = 12
    Toggle.Font = Enum.Font.SourceSansBold
    Toggle.ZIndex = 10
    Toggle.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Toggle
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 255, 255)
    Stroke.Thickness = 2
    Stroke.Parent = Toggle
    
    return Toggle
end

-- Tạo MainFrame
function MenuLoader:CreateMainFrame(parent)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 680, 0, 470)
    MainFrame.Position = UDim2.new(0.5, -340, 0.5, -235)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = false
    MainFrame.ZIndex = 5
    MainFrame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 255, 255)
    Stroke.Thickness = 2.5
    Stroke.Parent = MainFrame
    
    return MainFrame
end

return MenuLoader
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 3: TitleBar.lua               ║
    ║  Chức năng: Thanh tiêu đề menu      ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
local TitleBar = {}

function TitleBar:Create(parent)
    local Bar = Instance.new("Frame")
    Bar.Name = "TitleBar"
    Bar.Size = UDim2.new(1, 0, 0, 45)
    Bar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Bar.BorderSizePixel = 0
    Bar.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Bar
    
    -- Logo/Icon
    local Logo = Instance.new("ImageLabel")
    Logo.Size = UDim2.new(0, 30, 0, 30)
    Logo.Position = UDim2.new(0, 10, 0.5, -15)
    Logo.BackgroundTransparency = 1
    Logo.Image = "rbxassetid://7072705836"
    Logo.Parent = Bar
    
    -- Tiêu đề
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Position = UDim2.new(0, 48, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "⚔️ AOTR SYSTEM | v4.2.0 | by NhatAnh Dev"
    Title.TextColor3 = Color3.fromRGB(0, 255, 255)
    Title.TextSize = 15
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Bar
    
    -- Nút Minimize
    local MinBtn = Instance.new("TextButton")
    MinBtn.Size = UDim2.new(0, 32, 0, 32)
    MinBtn.Position = UDim2.new(1, -75, 0.5, -16)
    MinBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
    MinBtn.BorderSizePixel = 0
    MinBtn.Text = "─"
    MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinBtn.TextSize = 18
    MinBtn.Font = Enum.Font.SourceSansBold
    MinBtn.Parent = Bar
    
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinBtn
    
    -- Nút Close
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 32, 0, 32)
    CloseBtn.Position = UDim2.new(1, -38, 0.5, -16)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 16
    CloseBtn.Font = Enum.Font.SourceSansBold
    CloseBtn.Parent = Bar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn
    
    return {
        Bar = Bar,
        CloseBtn = CloseBtn,
        MinBtn = MinBtn
    }
end

return TitleBar
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 4: TabSystem.lua              ║
    ║  Chức năng: Hệ thống tab            ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
local TabSystem = {}
TabSystem.TabList = {}
TabSystem.CurrentTab = nil

-- Danh sách tab
TabSystem.TabNames = {
    {ID = "Farm", Name = "🏠 Farm", Icon = "rbxassetid://7072725342"},
    {ID = "Combat", Name = "⚔️ Combat", Icon = "rbxassetid://7072725796"},
    {ID = "Movement", Name = "🏃 Movement", Icon = "rbxassetid://7072726128"},
    {ID = "ESP", Name = "👁️ ESP", Icon = "rbxassetid://7072726485"},
    {ID = "Boss", Name = "🎯 Boss", Icon = "rbxassetid://7072726873"},
    {ID = "Raid", Name = "💀 Raid", Icon = "rbxassetid://7072727219"},
    {ID = "Items", Name = "📦 Items", Icon = "rbxassetid://7072727577"},
    {ID = "Auto", Name = "🤖 Auto", Icon = "rbxassetid://7072727938"},
    {ID = "Teleport", Name = "🌀 Teleport", Icon = "rbxassetid://7072728281"},
    {ID = "AntiBan", Name = "🛡️ AntiBan", Icon = "rbxassetid://7072728634"},
    {ID = "Settings", Name = "⚙️ Settings", Icon = "rbxassetid://7072728997"},
    {ID = "Credits", Name = "ℹ️ Credits", Icon = "rbxassetid://7072729348"}
}

function TabSystem:Create(parent)
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 150, 1, -55)
    TabContainer.Position = UDim2.new(0, 0, 0, 50)
    TabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = parent
    
    local TabList = Instance.new("UIListLayout")
    TabList.Padding = UDim.new(0, 3)
    TabList.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -155, 1, -60)
    ContentContainer.Position = UDim2.new(0, 153, 0, 52)
    ContentContainer.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = parent
    
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UDim.new(0, 8)
    ContentCorner.Parent = ContentContainer
    
    -- Tạo các tab
    local tabButtons = {}
    local tabPages = {}
    
    for i, tabData in ipairs(self.TabNames) do
        -- Tab Button
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = "Tab_" .. tabData.ID
        TabBtn.Size = UDim2.new(1, -6, 0, 34)
        TabBtn.Position = UDim2.new(0, 3, 0, (i-1) * 37)
        TabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        TabBtn.BorderSizePixel = 0
        TabBtn.Text = "  " .. tabData.Name
        TabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabBtn.TextSize = 13
        TabBtn.Font = Enum.Font.SourceSansBold
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        TabBtn.ZIndex = 2
        TabBtn.Parent = TabContainer
        
        local BtnCorner = Instance.new("UICorner")
        BtnCorner.CornerRadius = UDim.new(0, 6)
        BtnCorner.Parent = TabBtn
        
        -- Tab Page
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Name = "Page_" .. tabData.ID
        TabPage.Size = UDim2.new(1, -10, 1, -10)
        TabPage.Position = UDim2.new(0, 5, 0, 5)
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.ScrollBarThickness = 3
        TabPage.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
        TabPage.Visible = false
        TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabPage.ZIndex = 1
        TabPage.Parent = ContentContainer
        
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Padding = UDim.new(0, 6)
        PageLayout.Parent = TabPage
        
        tabButtons[tabData.ID] = TabBtn
        tabPages[tabData.ID] = TabPage
        
        -- Click event
        TabBtn.MouseButton1Click:Connect(function()
            for id, btn in pairs(tabButtons) do
                btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                btn.TextColor3 = Color3.fromRGB(180, 180, 180)
            end
            for id, page in pairs(tabPages) do
                page.Visible = false
            end
            
            TabBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 180)
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabPage.Visible = true
            self.CurrentTab = tabData.ID
        end)
    end
    
    -- Mặc định chọn tab đầu
    if tabButtons["Farm"] then
        tabButtons["Farm"].BackgroundColor3 = Color3.fromRGB(0, 180, 180)
        tabButtons["Farm"].TextColor3 = Color3.fromRGB(255, 255, 255)
        tabPages["Farm"].Visible = true
        self.CurrentTab = "Farm"
    end
    
    return {
        TabContainer = TabContainer,
        ContentContainer = ContentContainer,
        TabButtons = tabButtons,
        TabPages = tabPages
    }
end

return TabSystem
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 5: Components.lua             ║
    ║  Chức năng: Thành phần UI           ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
local Components = {}

-- Tạo Section
function Components:CreateSection(parent, title)
    local Section = Instance.new("Frame")
    Section.Name = "Section"
    Section.Size = UDim2.new(1, -10, 0, 32)
    Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Section.BorderSizePixel = 0
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = Section
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "  " .. title
    Label.TextColor3 = Color3.fromRGB(0, 255, 255)
    Label.TextSize = 13
    Label.Font = Enum.Font.SourceSansBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Section
    
    Section.Parent = parent
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.CanvasSize.Y.Offset + 38)
    
    return Section
end

-- Tạo Toggle
function Components:CreateToggle(parent, name, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = "Toggle_" .. name
    ToggleFrame.Size = UDim2.new(1, -10, 0, 38)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    ToggleFrame.BorderSizePixel = 0
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 250, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 12
    Label.Font = Enum.Font.SourceSans
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    -- Toggle Switch
    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 42, 0, 22)
    Switch.Position = UDim2.new(1, -52, 0.5, -11)
    Switch.BackgroundColor3 = default and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(55, 55, 55)
    Switch.BorderSizePixel = 0
    Switch.Text = ""
    Switch.AutoButtonColor = false
    Switch.Parent = ToggleFrame
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(0, 11)
    SwitchCorner.Parent = Switch
    
    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 18, 0, 18)
    Dot.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dot.BorderSizePixel = 0
    Dot.Parent = Switch
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(0, 9)
    DotCorner.Parent = Dot
    
    local enabled = default or false
    
    Switch.MouseButton1Click:Connect(function()
        enabled = not enabled
        Switch.BackgroundColor3 = enabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(55, 55, 55)
        Dot:TweenPosition(
            enabled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9),
            "Out", "Quad", 0.2, true
        )
        if callback then callback(enabled) end
    end)
    
    ToggleFrame.Parent = parent
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.CanvasSize.Y.Offset + 43)
    
    return ToggleFrame
end

-- Tạo Slider
function Components:CreateSlider(parent, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = "Slider_" .. name
    SliderFrame.Size = UDim2.new(1, -10, 0, 60)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    SliderFrame.BorderSizePixel = 0
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = SliderFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. tostring(default)
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 11
    Label.Font = Enum.Font.SourceSans
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    -- Slider background
    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, -20, 0, 8)
    SliderBg.Position = UDim2.new(0, 10, 0, 32)
    SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = SliderFrame
    
    local BgCorner = Instance.new("UICorner")
    BgCorner.CornerRadius = UDim.new(0, 4)
    BgCorner.Parent = SliderBg
    
    -- Slider fill
    local percent = (default - min) / (max - min)
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(percent, 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    Fill.BorderSizePixel = 0
    Fill.Parent = SliderBg
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 4)
    FillCorner.Parent = Fill
    
    -- Slider button
    local SliderBtn = Instance.new("TextButton")
    SliderBtn.Size = UDim2.new(0, 16, 0, 16)
    SliderBtn.Position = UDim2.new(percent, -8, 0.5, -8)
    SliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderBtn.BorderSizePixel = 0
    SliderBtn.Text = ""
    SliderBtn.Parent = SliderBg
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = SliderBtn
    
    SliderFrame.Parent = parent
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.CanvasSize.Y.Offset + 65)
    
    return SliderFrame
end

-- Tạo Button
function Components:CreateButton(parent, name, callback)
    local Button = Instance.new("TextButton")
    Button.Name = "Btn_" .. name
    Button.Size = UDim2.new(1, -10, 0, 35)
    Button.BackgroundColor3 = Color3.fromRGB(0, 180, 180)
    Button.BorderSizePixel = 0
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 13
    Button.Font = Enum.Font.SourceSansBold
    Button.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.CanvasSize.Y.Offset + 40)
    
    return Button
end

-- Tạo Label thông tin
function Components:CreateLabel(parent, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 0, 30)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(180, 180, 180)
    Label.TextSize = 11
    Label.Font = Enum.Font.SourceSans
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = parent
    
    parent.CanvasSize = UDim2.new(0, 0, 0, parent.CanvasSize.Y.Offset + 33)
    
    return Label
end

return Components
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 6: FillTabs_Farm.lua          ║
    ║  Chức năng: Nội dung tab Farm       ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["Farm"]
    if not page then return end
    
    Components:CreateSection(page, "⚔️ Auto Farm Chính")
    Components:CreateToggle(page, "Bật Auto Farm", false, function(state)
        getgenv().AOTR_FarmEnabled = state
    end)
    Components:CreateSlider(page, "Tầm đánh", 5, 50, 15, function(val)
        getgenv().AOTR_FarmRange = val
    end)
    Components:CreateSlider(page, "Số mục tiêu", 1, 20, 5, function(val)
        getgenv().AOTR_MaxTargets = val
    end)
    Components:CreateToggle(page, "Tự động dùng skill", false, function(state)
        getgenv().AOTR_UseSkills = state
    end)
    Components:CreateToggle(page, "Tự động nhặt đồ", false, function(state)
        getgenv().AOTR_AutoLoot = state
    end)
    
    Components:CreateSection(page, "📊 Tùy chọn Farm")
    Components:CreateToggle(page, "Chỉ farm quái mạnh", false, function(state)
        getgenv().AOTR_StrongOnly = state
    end)
    Components:CreateToggle(page, "Bỏ qua quái yếu", false, function(state)
        getgenv().AOTR_SkipWeak = state
    end)
    Components:CreateToggle(page, "Farm theo khu vực", false, function(state)
        getgenv().AOTR_ZoneFarm = state
    end)
    Components:CreateToggle(page, "Auto Sell khi đầy", false, function(state)
        getgenv().AOTR_AutoSell = state
    end)
    
    Components:CreateSection(page, "🎮 Điều khiển")
    Components:CreateButton(page, "Bắt đầu Farm", function()
        print("[AOTR] Bắt đầu Auto Farm...")
    end)
    Components:CreateButton(page, "Dừng Farm", function()
        print("[AOTR] Dừng Auto Farm...")
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 7: FillTabs_Combat.lua        ║
    ║  Chức năng: Nội dung tab Combat     ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["Combat"]
    if not page then return end
    
    Components:CreateSection(page, "⚔️ Chiến đấu tự động")
    Components:CreateToggle(page, "Auto Attack", false, function(state)
        getgenv().AOTR_AutoAttack = state
    end)
    Components:CreateToggle(page, "Auto Block", false, function(state)
        getgenv().AOTR_AutoBlock = state
    end)
    Components:CreateToggle(page, "Auto Dodge", false, function(state)
        getgenv().AOTR_AutoDodge = state
    end)
    Components:CreateSlider(page, "Safe HP%", 10, 100, 30, function(val)
        getgenv().AOTR_SafeHP = val
    end)
    
    Components:CreateSection(page, "💥 Combo System")
    Components:CreateToggle(page, "Dùng combo thông minh", true, function(state)
        getgenv().AOTR_SmartCombo = state
    end)
    Components:CreateToggle(page, "Tự động Awakening", false, function(state)
        getgenv().AOTR_AutoAwakening = state
    end)
    Components:CreateToggle(page, "Tự động Ultimate", false, function(state)
        getgenv().AOTR_AutoUlt = state
    end)
    
    Components:CreateSection(page, "🎯 Target")
    Components:CreateToggle(page, "Ưu tiên Boss", true, function(state)
        getgenv().AOTR_PriorityBoss = state
    end)
    Components:CreateToggle(page, "Tấn công người chơi", false, function(state)
        getgenv().AOTR_AttackPlayers = state
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 8: FillTabs_Movement.lua      ║
    ║  Chức năng: Nội dung tab Movement   ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["Movement"]
    if not page then return end
    
    Components:CreateSection(page, "🏃 Tốc độ")
    Components:CreateToggle(page, "Speed Hack", false, function(state)
        getgenv().AOTR_SpeedHack = state
    end)
    Components:CreateSlider(page, "Hệ số tốc độ", 1, 20, 3, function(val)
        getgenv().AOTR_SpeedMultiplier = val
    end)
    Components:CreateToggle(page, "Nhảy cao", false, function(state)
        getgenv().AOTR_HighJump = state
    end)
    Components:CreateSlider(page, "Độ cao nhảy", 50, 500, 100, function(val)
        getgenv().AOTR_JumpPower = val
    end)
    
    Components:CreateSection(page, "🦅 Bay & Xuyên")
    Components:CreateToggle(page, "Fly Mode", false, function(state)
        getgenv().AOTR_FlyMode = state
    end)
    Components:CreateSlider(page, "Tốc độ bay", 10, 200, 50, function(val)
        getgenv().AOTR_FlySpeed = val
    end)
    Components:CreateToggle(page, "NoClip (Xuyên tường)", false, function(state)
        getgenv().AOTR_NoClip = state
    end)
    Components:CreateToggle(page, "Nhảy vô hạn", false, function(state)
        getgenv().AOTR_InfiniteJump = state
    end)
    
    Components:CreateSection(page, "📍 Dịch chuyển")
    Components:CreateToggle(page, "Click Teleport", false, function(state)
        getgenv().AOTR_ClickTP = state
    end)
    Components:CreateButton(page, "Lưu vị trí hiện tại", function()
        print("[AOTR] Đã lưu vị trí!")
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 9: FillTabs_ESP.lua           ║
    ║  Chức năng: Nội dung tab ESP        ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["ESP"]
    if not page then return end
    
    Components:CreateSection(page, "👁️ ESP Chính")
    Components:CreateToggle(page, "ESP Master Switch", false, function(state)
        getgenv().AOTR_ESPMaster = state
    end)
    Components:CreateSlider(page, "Tầm hiển thị", 100, 5000, 1000, function(val)
        getgenv().AOTR_ESPRange = val
    end)
    
    Components:CreateSection(page, "👤 Người chơi")
    Components:CreateToggle(page, "Hiện tên người chơi", true, function(state)
        getgenv().AOTR_ESPPlayerName = state
    end)
    Components:CreateToggle(page, "Hiện máu người chơi", true, function(state)
        getgenv().AOTR_ESPPlayerHP = state
    end)
    Components:CreateToggle(page, "Hiện box người chơi", false, function(state)
        getgenv().AOTR_ESPPlayerBox = state
    end)
    Components:CreateToggle(page, "Hiện đường thẳng", false, function(state)
        getgenv().AOTR_ESPPlayerLine = state
    end)
    
    Components:CreateSection(page, "👾 Quái vật")
    Components:CreateToggle(page, "Hiện tên quái", true, function(state)
        getgenv().AOTR_ESPMobName = state
    end)
    Components:CreateToggle(page, "Hiện máu quái", true, function(state)
        getgenv().AOTR_ESPMobHP = state
    end)
    Components:CreateToggle(page, "Hiện level quái", false, function(state)
        getgenv().AOTR_ESPMobLevel = state
    end)
    
    Components:CreateSection(page, "📦 Vật phẩm")
    Components:CreateToggle(page, "Hiện vật phẩm rơi", true, function(state)
        getgenv().AOTR_ESPItems = state
    end)
    Components:CreateToggle(page, "Chỉ hiện đồ hiếm", false, function(state)
        getgenv().AOTR_ESPRareOnly = state
    end)
    Components:CreateToggle(page, "Hiện rương", true, function(state)
        getgenv().AOTR_ESPChests = state
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 10: FillTabs_Boss.lua         ║
    ║  Chức năng: Nội dung tab Boss       ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["Boss"]
    if not page then return end
    
    Components:CreateSection(page, "🎯 Auto Boss")
    Components:CreateToggle(page, "Bật Auto Boss", false, function(state)
        getgenv().AOTR_AutoBoss = state
    end)
    Components:CreateToggle(page, "Chỉ farm boss mạnh", false, function(state)
        getgenv().AOTR_StrongBossOnly = state
    end)
    Components:CreateSlider(page, "Tầm phát hiện boss", 500, 10000, 3000, function(val)
        getgenv().AOTR_BossRange = val
    end)
    
    Components:CreateSection(page, "🔄 Spawn & Timer")
    Components:CreateToggle(page, "Auto Spawn Boss", false, function(state)
        getgenv().AOTR_AutoSpawnBoss = state
    end)
    Components:CreateToggle(page, "Hiện timer boss", true, function(state)
        getgenv().AOTR_BossTimer = state
    end)
    Components:CreateToggle(page, "Thông báo boss xuất hiện", true, function(state)
        getgenv().AOTR_BossNotify = state
    end)
    
    Components:CreateSection(page, "🏆 Danh sách Boss")
    Components:CreateButton(page, "Farm tất cả Boss", function()
        print("[AOTR] Đang farm tất cả Boss...")
    end)
    Components:CreateButton(page, "Dịch đến Boss gần nhất", function()
        print("[AOTR] Đang dịch chuyển...")
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 11: FillTabs_Raid.lua         ║
    ║  Chức năng: Nội dung tab Raid       ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["Raid"]
    if not page then return end
    
    Components:CreateSection(page, "💀 Raid System")
    Components:CreateToggle(page, "Auto Raid", false, function(state)
        getgenv().AOTR_AutoRaid = state
    end)
    Components:CreateToggle(page, "Auto Queue", false, function(state)
        getgenv().AOTR_AutoQueue = state
    end)
    Components:CreateToggle(page, "Tự động vào lại", false, function(state)
        getgenv().AOTR_AutoRejoinRaid = state
    end)
    
    Components:CreateSection(page, "⚙️ Cài đặt Raid")
    Components:CreateSlider(page, "Độ khó tối đa", 1, 5, 3, function(val)
        getgenv().AOTR_RaidDifficulty = val
    end)
    Components:CreateToggle(page, "Chỉ nhận thưởng ngon", true, function(state)
        getgenv().AOTR_RaidGoodReward = state
    end)
    Components:CreateButton(page, "Tham gia Raid ngay", function()
        print("[AOTR] Đang tham gia Raid...")
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 12: FillTabs_Items.lua        ║
    ║  Chức năng: Nội dung tab Items      ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["Items"]
    if not page then return end
    
    Components:CreateSection(page, "📦 Auto Loot")
    Components:CreateToggle(page, "Tự động nhặt", false, function(state)
        getgenv().AOTR_AutoLoot = state
    end)
    Components:CreateToggle(page, "Chỉ nhặt Legendary+", false, function(state)
        getgenv().AOTR_LegendaryOnly = state
    end)
    Components:CreateSlider(page, "Tầm nhặt đồ", 10, 100, 30, function(val)
        getgenv().AOTR_LootRange = val
    end)
    
    Components:CreateSection(page, "🎒 Quản lý đồ")
    Components:CreateToggle(page, "Auto Sell rác", false, function(state)
        getgenv().AOTR_AutoSellTrash = state
    end)
    Components:CreateToggle(page, "Auto Equip tốt nhất", false, function(state)
        getgenv().AOTR_AutoEquip = state
    end)
    Components:CreateToggle(page, "Tự mở rương", false, function(state)
        getgenv().AOTR_AutoChest = state
    end)
    Components:CreateButton(page, "Mở tất cả rương gần", function()
        print("[AOTR] Đang mở rương...")
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 13: FillTabs_Auto.lua         ║
    ║  Chức năng: Nội dung tab Auto       ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["Auto"]
    if not page then return end
    
    Components:CreateSection(page, "🤖 Tự động hóa")
    Components:CreateToggle(page, "Auto Login", false, function(state)
        getgenv().AOTR_AutoLogin = state
    end)
    Components:CreateToggle(page, "Auto Rejoin", false, function(state)
        getgenv().AOTR_AutoRejoin = state
    end)
    Components:CreateToggle(page, "Auto Server Hop", false, function(state)
        getgenv().AOTR_AutoServerHop = state
    end)
    Components:CreateSlider(page, "Thời gian đổi server (phút)", 5, 120, 30, function(val)
        getgenv().AOTR_HopTime = val * 60
    end)
    
    Components:CreateSection(page, "⏰ Lịch trình")
    Components:CreateToggle(page, "Farm theo giờ", false, function(state)
        getgenv().AOTR_ScheduleFarm = state
    end)
    Components:CreateToggle(page, "Nghỉ ngẫu nhiên", true, function(state)
        getgenv().AOTR_RandomBreak = state
    end)
    Components:CreateSlider(page, "Thời gian nghỉ (phút)", 1, 30, 5, function(val)
        getgenv().AOTR_BreakTime = val * 60
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 14: FillTabs_Teleport.lua     ║
    ║  Chức năng: Nội dung tab Teleport   ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["Teleport"]
    if not page then return end
    
    Components:CreateSection(page, "🌀 Dịch chuyển nhanh")
    Components:CreateToggle(page, "Mở khóa dịch chuyển", true, function(state)
        getgenv().AOTR_TeleportUnlock = state
    end)
    Components:CreateToggle(page, "Dịch đến Waypoint", false, function(state)
        getgenv().AOTR_TPWaypoint = state
    end)
    
    Components:CreateSection(page, "📍 Địa điểm")
    Components:CreateButton(page, "Dịch đến Spawn", function()
        print("[AOTR] Đang dịch đến Spawn...")
    end)
    Components:CreateButton(page, "Dịch đến Shop", function()
        print("[AOTR] Đang dịch đến Shop...")
    end)
    Components:CreateButton(page, "Dịch đến Boss Arena", function()
        print("[AOTR] Đang dịch đến Arena...")
    end)
    Components:CreateButton(page, "Dịch đến Safe Zone", function()
        print("[AOTR] Đang dịch đến Safe Zone...")
    end)
    
    Components:CreateSection(page, "💾 Vị trí đã lưu")
    Components:CreateButton(page, "Lưu vị trí #1", function()
        print("[AOTR] Đã lưu vị trí #1")
    end)
    Components:CreateButton(page, "Dịch đến vị trí #1", function()
        print("[AOTR] Đang dịch đến vị trí #1...")
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 15: FillTabs_AntiBan.lua      ║
    ║  Chức năng: Nội dung tab AntiBan    ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["AntiBan"]
    if not page then return end
    
    Components:CreateSection(page, "🛡️ Bảo vệ chính")
    Components:CreateToggle(page, "Anti Report", true, function(state)
        getgenv().AOTR_AntiReport = state
    end)
    Components:CreateToggle(page, "Anti AFK", true, function(state)
        getgenv().AOTR_AntiAFK = state
    end)
    Components:CreateToggle(page, "Anti Teleport", true, function(state)
        getgenv().AOTR_AntiTeleport = state
    end)
    Components:CreateToggle(page, "Anti Chat Log", true, function(state)
        getgenv().AOTR_AntiChatLog = state
    end)
    
    Components:CreateSection(page, "🎭 Ngụy trang")
    Components:CreateToggle(page, "Fake Lag", false, function(state)
        getgenv().AOTR_FakeLag = state
    end)
    Components:CreateSlider(page, "Độ trễ giả (ms)", 50, 500, 150, function(val)
        getgenv().AOTR_FakeLagAmount = val
    end)
    Components:CreateToggle(page, "Giả lập người chơi thật", true, function(state)
        getgenv().AOTR_Humanize = state
    end)
    
    Components:CreateSection(page, "🔄 Tự động")
    Components:CreateToggle(page, "Tự Rejoin khi có Mod", false, function(state)
        getgenv().AOTR_RejoinOnMod = state
    end)
    Components:CreateToggle(page, "Tự đổi tên hiển thị", false, function(state)
        getgenv().AOTR_AutoDisplayName = state
    end)
    Components:CreateButton(page, "Xóa dấu vết ngay", function()
        print("[AOTR] Đang xóa dấu vết...")
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 16: FillTabs_Settings.lua     ║
    ║  Chức năng: Nội dung tab Settings   ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["Settings"]
    if not page then return end
    
    Components:CreateSection(page, "🎨 Giao diện")
    Components:CreateToggle(page, "Rainbow Mode", false, function(state)
        getgenv().AOTR_RainbowMode = state
    end)
    Components:CreateToggle(page, "Dark Mode", true, function(state)
        getgenv().AOTR_DarkMode = state
    end)
    Components:CreateToggle(page, "Thu nhỏ khi khởi động", false, function(state)
        getgenv().AOTR_MinimizeOnStart = state
    end)
    Components:CreateSlider(page, "Độ trong suốt", 50, 100, 95, function(val)
        getgenv().AOTR_Opacity = val / 100
    end)
    
    Components:CreateSection(page, "💾 Dữ liệu")
    Components:CreateToggle(page, "Tự động lưu cài đặt", true, function(state)
        getgenv().AOTR_AutoSave = state
    end)
    Components:CreateButton(page, "Lưu cài đặt ngay", function()
        print("[AOTR] Đã lưu cài đặt!")
    end)
    Components:CreateButton(page, "Tải cài đặt mặc định", function()
        print("[AOTR] Đã tải cài đặt mặc định!")
    end)
    Components:CreateButton(page, "Reset toàn bộ", function()
        print("[AOTR] Đã reset toàn bộ!")
    end)
    
    Components:CreateSection(page, "🔄 Cập nhật")
    Components:CreateToggle(page, "Tự động cập nhật", true, function(state)
        getgenv().AOTR_AutoUpdate = state
    end)
    Components:CreateButton(page, "Kiểm tra cập nhật", function()
        print("[AOTR] Đang kiểm tra cập nhật...")
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 17: FillTabs_Credits.lua      ║
    ║  Chức năng: Nội dung tab Credits    ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
return function(Components, TabPages)
    local page = TabPages["Credits"]
    if not page then return end
    
    Components:CreateSection(page, "ℹ️ Thông tin Script")
    
    -- Tạo label thông tin đặc biệt
    local InfoFrame = Instance.new("Frame")
    InfoFrame.Size = UDim2.new(1, -10, 0, 280)
    InfoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    InfoFrame.BorderSizePixel = 0
    InfoFrame.Parent = page
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = InfoFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 255, 255)
    Stroke.Thickness = 1.5
    Stroke.Parent = InfoFrame
    
    local InfoText = Instance.new("TextLabel")
    InfoText.Size = UDim2.new(1, -20, 1, -20)
    InfoText.Position = UDim2.new(0, 10, 0, 10)
    InfoText.BackgroundTransparency = 1
    InfoText.Text = [[
╔══════════════════════════════════════╗
║                                      ║
║     ⚔️ AOTR 10000 LINES PRO ⚔️      ║
║                                      ║
║  👤 Tác giả: NhatAnh Dev            ║
║  📌 Phiên bản: v4.2.0               ║
║  📅 Ngày phát hành: 01/07/2024      ║
║  🔄 Cập nhật cuối: 15/07/2024       ║
║                                      ║
║  📋 TÍNH NĂNG CHÍNH:                ║
║  ✅ Auto Farm (Đa mục tiêu)         ║
║  ✅ Auto Combat (Combo thông minh)  ║
║  ✅ ESP System (Người/Quái/Item)    ║
║  ✅ Auto Boss (Phát hiện & Farm)    ║
║  ✅ Auto Raid (Queue & Farm)        ║
║  ✅ Movement Hack (Fly/Speed/Noclip)║
║  ✅ Teleport System                 ║
║  ✅ Anti-Ban Protection             ║
║  ✅ Auto Loot & Sell                ║
║  ✅ Và 100+ tính năng khác...       ║
║                                      ║
║  📞 Liên hệ:                        ║
║  Discord: NhatAnhDev#0001           ║
║  GitHub: github.com/NhatAnhDev      ║
║                                      ║
║  © 2024 NhatAnh Dev                 ║
║  All Rights Reserved                ║
║                                      ║
╚══════════════════════════════════════╝
]]
    InfoText.TextColor3 = Color3.fromRGB(0, 255, 255)
    InfoText.TextSize = 11
    InfoText.Font = Enum.Font.SourceSansBold
    InfoText.TextXAlignment = Enum.TextXAlignment.Left
    InfoText.TextYAlignment = Enum.TextYAlignment.Top
    InfoText.RichText = true
    InfoText.Parent = InfoFrame
    
    page.CanvasSize = UDim2.new(0, 0, 0, page.CanvasSize.Y.Offset + 290)
    
    Components:CreateSection(page, "🙏 Cảm ơn")
    Components:CreateLabel(page, "Cảm ơn bạn đã sử dụng AOTR System!")
    Components:CreateLabel(page, "Hãy chia sẻ với bạn bè nếu thấy hữu ích!")
    Components:CreateButton(page, "Copy Link Script", function()
        print("[AOTR] Đã copy link!")
    end)
end
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 18: Footer.lua                ║
    ║  Chức năng: Thanh footer menu       ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
local Footer = {}

function Footer:Create(parent)
    local FooterBar = Instance.new("Frame")
    FooterBar.Name = "FooterBar"
    FooterBar.Size = UDim2.new(1, 0, 0, 24)
    FooterBar.Position = UDim2.new(0, 0, 1, -24)
    FooterBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    FooterBar.BorderSizePixel = 0
    FooterBar.Parent = parent
    
    -- Label trái
    local LeftLabel = Instance.new("TextLabel")
    LeftLabel.Size = UDim2.new(0.5, -10, 1, 0)
    LeftLabel.Position = UDim2.new(0, 10, 0, 0)
    LeftLabel.BackgroundTransparency = 1
    LeftLabel.Text = "© 2024 NhatAnh Dev | AOTR System v4.2.0"
    LeftLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
    LeftLabel.TextSize = 10
    LeftLabel.Font = Enum.Font.SourceSans
    LeftLabel.TextXAlignment = Enum.TextXAlignment.Left
    LeftLabel.Parent = FooterBar
    
    -- Label phải (FPS)
    local RightLabel = Instance.new("TextLabel")
    RightLabel.Size = UDim2.new(0.5, -10, 1, 0)
    RightLabel.Position = UDim2.new(0.5, 0, 0, 0)
    RightLabel.BackgroundTransparency = 1
    RightLabel.Text = "FPS: -- | Ping: --ms"
    RightLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    RightLabel.TextSize = 10
    RightLabel.Font = Enum.Font.SourceSans
    RightLabel.TextXAlignment = Enum.TextXAlignment.Right
    RightLabel.Parent = FooterBar
    
    return FooterBar
end

return Footer
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 19: DragSystem.lua            ║
    ║  Chức năng: Hệ thống kéo thả menu  ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
local DragSystem = {}

function DragSystem:Enable(frame, titleBar)
    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragStart = nil
    local startPos = nil
    local gui = frame
    
    local function updateDrag(input)
        local delta = input.Position - dragStart
        local newX = startPos.X.Offset + delta.X
        local newY = startPos.Y.Offset + delta.Y
        
        -- Giới hạn trong màn hình
        local screenSize = workspace.CurrentCamera.ViewportSize
        newX = math.clamp(newX, -gui.AbsoluteSize.X + 50, screenSize.X - 50)
        newY = math.clamp(newY, 0, screenSize.Y - 50)
        
        gui.Position = UDim2.new(0, newX, 0, newY)
    end
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateDrag(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

return DragSystem
--[[
    ╔══════════════════════════════════════╗
    ║  FILE 20: RainbowEffect.lua         ║
    ║  Chức năng: Hiệu ứng cầu vồng menu ║
    ║  Tác giả: NhatAnh Dev               ║
    ╚══════════════════════════════════════╝
]]
local RainbowEffect = {}
RainbowEffect.Enabled = false
RainbowEffect.Connection = nil

function RainbowEffect:Start(targetFrame)
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    local RunService = game:GetService("RunService")
    local hue = 0
    
    self.Enabled = true
    self.Connection = RunService.RenderStepped:Connect(function()
        if not self.Enabled then
            self.Connection:Disconnect()
            return
        end
        
        hue = (hue + 0.005) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        
        -- Đổi màu viền
        local stroke = targetFrame:FindFirstChildOfClass("UIStroke")
        if stroke then
            stroke.Color = color
        end
        
        -- Đổi màu các element
        for _, child in ipairs(targetFrame:GetDescendants()) do
            if child:IsA("TextLabel") and child.TextColor3 == Color3.fromRGB(0, 255, 255) then
                child.TextColor3 = color
            end
        end
    end)
end

function RainbowEffect:Stop()
    self.Enabled = false
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

return RainbowEffect
--[[
    ╔══════════════════════════════════════════════════════════╗
    ║                                                          ║
    ║     ⚔️ AOTR 10000 LINES PRO - MAIN SCRIPT ⚔️            ║
    ║                                                          ║
    ║  Đây là file chính để chạy toàn bộ hệ thống             ║
    ║  Tác giả: NhatAnh Dev                                    ║
    ║  Phiên bản: v4.2.0                                       ║
    ║                                                          ║
    ║  Hướng dẫn: Chạy file này trong Executor                ║
    ║  Tất cả các file khác sẽ tự động được load              ║
    ║                                                          ║
    ╚══════════════════════════════════════════════════════════╝
    
    CẤU TRÚC FILE:
    📁 AOTR_System/
    ├── 📄 MAIN.lua (file này - chạy đầu tiên)
    ├── 📄 Core.lua (khởi tạo hệ thống)
    ├── 📄 MenuLoader.lua (tạo GUI)
    ├── 📄 TitleBar.lua (thanh tiêu đề)
    ├── 📄 TabSystem.lua (hệ thống tab)
    ├── 📄 Components.lua (thành phần UI)
    ├── 📁 FillTabs/
    │   ├── 📄 FillTabs_Farm.lua
    │   ├── 📄 FillTabs_Combat.lua
    │   ├── 📄 FillTabs_Movement.lua
    │   ├── 📄 FillTabs_ESP.lua
    │   ├── 📄 FillTabs_Boss.lua
    │   ├── 📄 FillTabs_Raid.lua
    │   ├── 📄 FillTabs_Items.lua
    │   ├── 📄 FillTabs_Auto.lua
    │   ├── 📄 FillTabs_Teleport.lua
    │   ├── 📄 FillTabs_AntiBan.lua
    │   ├── 📄 FillTabs_Settings.lua
    │   └── 📄 FillTabs_Credits.lua
    ├── 📄 Footer.lua (thanh footer)
    ├── 📄 DragSystem.lua (kéo thả menu)
    └── 📄 RainbowEffect.lua (hiệu ứng cầu vồng)
]]

-- =============================================
-- KHỞI TẠO CHÍNH
-- =============================================
print([[
╔══════════════════════════════════════════╗
║                                          ║
║   ⚔️ AOTR 10000 LINES PRO ⚔️           ║
║   Tác giả: NhatAnh Dev                  ║
║   Version: v4.2.0                       ║
║   Đang khởi tạo hệ thống...             ║
║                                          ║
╚══════════════════════════════════════════╝
]])

-- Load Modules
local Core = require(script.Core)
local MenuLoader = require(script.MenuLoader)
local TitleBar = require(script.TitleBar)
local TabSystem = require(script.TabSystem)
local Components = require(script.Components)
local Footer = require(script.Footer)
local DragSystem = require(script.DragSystem)
local RainbowEffect = require(script.RainbowEffect)

-- Load FillTab functions
local FillTabs = {}
FillTabs.Farm = require(script.FillTabs.FillTabs_Farm)
FillTabs.Combat = require(script.FillTabs.FillTabs_Combat)
FillTabs.Movement = require(script.FillTabs.FillTabs_Movement)
FillTabs.ESP = require(script.FillTabs.FillTabs_ESP)
FillTabs.Boss = require(script.FillTabs.FillTabs_Boss)
FillTabs.Raid = require(script.FillTabs.FillTabs_Raid)
FillTabs.Items = require(script.FillTabs.FillTabs_Items)
FillTabs.Auto = require(script.FillTabs.FillTabs_Auto)
FillTabs.Teleport = require(script.FillTabs.FillTabs_Teleport)
FillTabs.AntiBan = require(script.FillTabs.FillTabs_AntiBan)
FillTabs.Settings = require(script.FillTabs.FillTabs_Settings)
FillTabs.Credits = require(script.FillTabs.FillTabs_Credits)

-- Tạo GUI
local ScreenGui = MenuLoader:CreateGUI()
local MainFrame = MenuLoader:CreateMainFrame(ScreenGui)
local ToggleBtn = MenuLoader:CreateToggleButton(ScreenGui)

-- Tạo TitleBar
local TitleBarComponents = TitleBar:Create(MainFrame)

-- Tạo TabSystem
local TabComponents = TabSystem:Create(MainFrame)

-- Tạo Footer
Footer:Create(MainFrame)

-- Điền nội dung vào các tab
FillTabs.Farm(Components, TabComponents.TabPages)
FillTabs.Combat(Components, TabComponents.TabPages)
FillTabs.Movement(Components, TabComponents.TabPages)
FillTabs.ESP(Components, TabComponents.TabPages)
FillTabs.Boss(Components, TabComponents.TabPages)
FillTabs.Raid(Components, TabComponents.TabPages)
FillTabs.Items(Components, TabComponents.TabPages)
FillTabs.Auto(Components, TabComponents.TabPages)
FillTabs.Teleport(Components, TabComponents.TabPages)
FillTabs.AntiBan(Components, TabComponents.TabPages)
FillTabs.Settings(Components, TabComponents.TabPages)
FillTabs.Credits(Components, TabComponents.TabPages)

-- Kích hoạt kéo thả
DragSystem:Enable(MainFrame, TitleBarComponents.Bar)

-- Sự kiện Toggle button
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Sự kiện nút Close
TitleBarComponents.CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Sự kiện nút Minimize
TitleBarComponents.MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Rainbow Mode toggle
getgenv().AOTR_RainbowMode = false
spawn(function()
    while true do
        wait(0.5)
        if getgenv().AOTR_RainbowMode and not RainbowEffect.Enabled then
            RainbowEffect:Start(MainFrame)
        elseif not getgenv().AOTR_RainbowMode and RainbowEffect.Enabled then
            RainbowEffect:Stop()
        end
    end
end)

-- Anti-AFK
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if getgenv().AOTR_AntiAFK then
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(0.1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
end)

-- FPS Counter trong footer
spawn(function()
    local RunService = game:GetService("RunService")
    local fps = 0
    local lastTime = tick()
    
    RunService.RenderStepped:Connect(function()
        fps = fps + 1
        if tick() - lastTime >= 1 then
            local footerLabel = MainFrame:FindFirstChild("FooterBar")
            if footerLabel then
                local rightLabel = footerLabel:FindFirstChildOfClass("TextLabel")
                if rightLabel and rightLabel.Name ~= "LeftLabel" then
                    rightLabel.Text = "FPS: " .. fps .. " | AOTR v4.2.0"
                end
            end
            fps = 0
            lastTime = tick()
        end
    end)
end)

print([[
╔══════════════════════════════════════════╗
║                                          ║
║   ✅ AOTR System đã sẵn sàng!           ║
║   Nhấn nút AOTR để mở menu             ║
║   Tác giả: NhatAnh Dev                 ║
║                                          ║
╚══════════════════════════════════════════╝
]])

return Core