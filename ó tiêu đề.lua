local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MistHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,350,0,220)
Main.Position = UDim2.new(0.5,-175,0.5,-110)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.BorderSizePixel = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0,10)
UICorner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "MistHub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.new(1,1,1)

local Line = Instance.new("Frame")
Line.Parent = Main
Line.Size = UDim2.new(1,0,0,2)
Line.Position = UDim2.new(0,0,0,40)
Line.BackgroundColor3 = Color3.fromRGB(70,170,255)
Line.BorderSizePixel = 0

local Welcome = Instance.new("TextLabel")
Welcome.Parent = Main
Welcome.Size = UDim2.new(1,-20,0,40)
Welcome.Position = UDim2.new(0,10,0,60)
Welcome.BackgroundTransparency = 1
Welcome.Text = "Welcome to MistHub"
Welcome.Font = Enum.Font.Gotham
Welcome.TextSize = 18
Welcome.TextColor3 = Color3.new(1,1,1)

local Start = Instance.new("TextButton")
Start.Parent = Main
Start.Size = UDim2.new(0.8,0,0,40)
Start.Position = UDim2.new(0.1,0,0.7,0)
Start.Text = "Continue"
Start.Font = Enum.Font.GothamBold
Start.TextSize = 18
Start.BackgroundColor3 = Color3.fromRGB(70,170,255)
Start.TextColor3 = Color3.new(1,1,1)
local Corner2 = Instance.new("UICorner")
Corner2.CornerRadius = UDim.new(0,8)
Corner2.Parent = Start

Start.MouseButton1Click:Connect(function()
    print("Continue clicked!")
    -- Chỗ này sau này sẽ mở menu chính
end)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MistHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,350,0,220)
Main.Position = UDim2.new(0.5,-175,0.5,-110)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.BorderSizePixel = 0

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0,10)
UICorner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,40)
Title.BackgroundTransparency = 1
Title.Text = "MistHub"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.new(1,1,1)

local Line = Instance.new("Frame")
Line.Parent = Main
Line.Size = UDim2.new(1,0,0,2)
Line.Position = UDim2.new(0,0,0,40)
Line.BackgroundColor3 = Color3.fromRGB(70,170,255)
Line.BorderSizePixel = 0

local Welcome = Instance.new("TextLabel")
Welcome.Parent = Main
Welcome.Size = UDim2.new(1,-20,0,40)
Welcome.Position = UDim2.new(0,10,0,60)
Welcome.BackgroundTransparency = 1
Welcome.Text = "Welcome to MistHub"
Welcome.Font = Enum.Font.Gotham
Welcome.TextSize = 18
Welcome.TextColor3 = Color3.new(1,1,1)

local Start = Instance.new("TextButton")
Start.Parent = Main
Start.Size = UDim2.new(0.8,0,0,40)
Start.Position = UDim2.new(0.1,0,0.7,0)
Start.Text = "Continue"
Start.Font = Enum.Font.GothamBold
Start.TextSize = 18
Start.BackgroundColor3 = Color3.fromRGB(70,170,255)
Start.TextColor3 = Color3.new(1,1,1)

local Corner2 = Instance.new("UICorner")
Corner2.CornerRadius = UDim.new(0,8)
Corner2.Parent = Start

-- Tạo Menu chính (ẩn đi ban đầu)
local MainMenu = Instance.new("Frame")
MainMenu.Parent = ScreenGui
MainMenu.Size = UDim2.new(0,450,0,350)
MainMenu.Position = UDim2.new(0.5,-225,0.5,-175)
MainMenu.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainMenu.BorderSizePixel = 0
MainMenu.Visible = false -- Ẩn menu chính

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0,10)
MenuCorner.Parent = MainMenu

local MenuTitle = Instance.new("TextLabel")
MenuTitle.Parent = MainMenu
MenuTitle.Size = UDim2.new(1,0,0,40)
MenuTitle.BackgroundTransparency = 1
MenuTitle.Text = "MistHub Menu"
MenuTitle.Font = Enum.Font.GothamBold
MenuTitle.TextSize = 24
MenuTitle.TextColor3 = Color3.new(1,1,1)

local MenuLine = Instance.new("Frame")
MenuLine.Parent = MainMenu
MenuLine.Size = UDim2.new(1,0,0,2)
MenuLine.Position = UDim2.new(0,0,0,40)
MenuLine.BackgroundColor3 = Color3.fromRGB(70,170,255)
MenuLine.BorderSizePixel = 0

-- Nút đóng menu
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainMenu
CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Position = UDim2.new(1,-35,0,5)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
CloseBtn.TextColor3 = Color3.new(1,1,1)

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0,5)
CloseCorner.Parent = CloseBtn

-- Hàm tạo tab
local function CreateTab(parent, name, position)
    local tab = Instance.new("TextButton")
    tab.Parent = parent
    tab.Size = UDim2.new(0.3,0,0,40)
    tab.Position = UDim2.new(position,0,0,50)
    tab.Text = name
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 16
    tab.BackgroundColor3 = Color3.fromRGB(45,45,45)
    tab.TextColor3 = Color3.new(1,1,1)
    tab.BorderSizePixel = 0
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0,5)
    tabCorner.Parent = tab
    
    return tab
end

-- Tạo các tab
local Tab1 = CreateTab(MainMenu, "Player", 0.02)
local Tab2 = CreateTab(MainMenu, "Visual", 0.35)
local Tab3 = CreateTab(MainMenu, "Misc", 0.68)

-- Tạo Frame chứa nội dung cho từng tab
local function CreateContentFrame(parent, position)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(0.96,0,0,0.7)
    frame.Position = UDim2.new(0.02,0,position,0)
    frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Visible = false
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0,5)
    frameCorner.Parent = frame
    
    return frame
end

local Content1 = CreateContentFrame(MainMenu, 0.28) -- Player tab
local Content2 = CreateContentFrame(MainMenu, 0.28) -- Visual tab
local Content3 = CreateContentFrame(MainMenu, 0.28) -- Misc tab

-- Hiển thị tab đầu tiên
Content1.Visible = true
Content1.BackgroundTransparency = 0

-- Chức năng chuyển tab
local function SwitchTab(activeTab, contentToShow)
    -- Ẩn tất cả content
    Content1.Visible = false
    Content1.BackgroundTransparency = 1
    Content2.Visible = false
    Content2.BackgroundTransparency = 1
    Content3.Visible = false
    Content3.BackgroundTransparency = 1
    
    -- Reset màu các tab
    Tab1.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Tab2.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Tab3.BackgroundColor3 = Color3.fromRGB(45,45,45)
    
    -- Active tab và hiển thị content
    activeTab.BackgroundColor3 = Color3.fromRGB(70,170,255)
    contentToShow.Visible = true
    contentToShow.BackgroundTransparency = 0
end

-- Sự kiện click tab
Tab1.MouseButton1Click:Connect(function()
    SwitchTab(Tab1, Content1)
end)

Tab2.MouseButton1Click:Connect(function()
    SwitchTab(Tab2, Content2)
end)

Tab3.MouseButton1Click:Connect(function()
    SwitchTab(Tab3, Content3)
end)

-- Hàm tạo Toggle (nút bật/tắt)
local function CreateToggle(parent, text, position, defaultValue)
    local toggle = Instance.new("Frame")
    toggle.Parent = parent
    toggle.Size = UDim2.new(0.9,0,0,35)
    toggle.Position = UDim2.new(0.05,0,position,0)
    toggle.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = toggle
    label.Size = UDim2.new(0.6,0,1,0)
    label.Position = UDim2.new(0,0,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.new(1,1,1)
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local button = Instance.new("TextButton")
    button.Parent = toggle
    button.Size = UDim2.new(0,40,0,25)
    button.Position = UDim2.new(0.8,0,0.15,0)
    button.BackgroundColor3 = defaultValue and Color3.fromRGB(70,170,255) or Color3.fromRGB(100,100,100)
    button.Text = defaultValue and "ON" or "OFF"
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0,5)
    btnCorner.Parent = button
    
    local state = defaultValue or false
    
    button.MouseButton1Click:Connect(function()
        state = not state
        button.BackgroundColor3 = state and Color3.fromRGB(70,170,255) or Color3.fromRGB(100,100,100)
        button.Text = state and "ON" or "OFF"
    end)
    
    return {Toggle = toggle, State = function() return state end}
end

-- Hàm tạo Slider (thanh trượt)
local function CreateSlider(parent, text, position, min, max, default)
    local slider = Instance.new("Frame")
    slider.Parent = parent
    slider.Size = UDim2.new(0.9,0,0,50)
    slider.Position = UDim2.new(0.05,0,position,0)
    slider.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = slider
    label.Size = UDim2.new(1,0,0,20)
    label.Position = UDim2.new(0,0,0,0)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. tostring(default)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.new(1,1,1)
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local value = default or min
    
    local bar = Instance.new("Frame")
    bar.Parent = slider
    bar.Size = UDim2.new(0.8,0,0,6)
    bar.Position = UDim2.new(0,0,0.6,0)
    bar.BackgroundColor3 = Color3.fromRGB(60,60,60)
    bar.BorderSizePixel = 0
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0,3)
    barCorner.Parent = bar
    
    local fill = Instance.new("Frame")
    fill.Parent = bar
    fill.Size = UDim2.new((value - min) / (max - min),0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(70,170,255)
    fill.BorderSizePixel = 0
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0,3)
    fillCorner.Parent = fill
    
    local drag = Instance.new("TextButton")
    drag.Parent = bar
    drag.Size = UDim2.new(0,15,0,15)
    drag.Position = UDim2.new((value - min) / (max - min) - 0.03,0,-4.5,0)
    drag.BackgroundColor3 = Color3.fromRGB(70,170,255)
    drag.Text = ""
    drag.BorderSizePixel = 0
    
    local dragCorner = Instance.new("UICorner")
    dragCorner.CornerRadius = UDim.new(0,7.5)
    dragCorner.Parent = drag
    
    local function UpdateSlider(newValue)
        value = math.clamp(newValue, min, max)
        local percent = (value - min) / (max - min)
        fill.Size = UDim2.new(percent,0,1,0)
        drag.Position = UDim2.new(percent - 0.03,0,-4.5,0)
        label.Text = text .. ": " .. math.floor(value)
    end
    
    drag.MouseButton1Down:Connect(function()
        local mouse = game:GetService("UserInputService")
        local dragConnection
        local dragConnection2
        
        dragConnection = mouse.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local mousePos = input.Position.X
                local barPos = bar.AbsolutePosition.X
                local barSize = bar.AbsoluteSize.X
                local percent = math.clamp((mousePos - barPos) / barSize, 0, 1)
                local newValue = min + (max - min) * percent
                UpdateSlider(newValue)
            end
        end)
        
        dragConnection2 = mouse.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragConnection:Disconnect()
                dragConnection2:Disconnect()
            end
        end)
    end)
    
    return {Slider = slider, Value = function() return math.floor(value) end}
end

-- Thêm các chức năng vào từng tab
-- Player Tab
CreateToggle(Content1, "Walk Speed", 0.05, false)
CreateSlider(Content1, "Speed", 0.2, 16, 50, 25)
CreateToggle(Content1, "Jump Power", 0.5, false)
CreateSlider(Content1, "Jump", 0.65, 50, 200, 100)

-- Visual Tab
CreateToggle(Content2, "ESP Box", 0.05, false)
CreateToggle(Content2, "ESP Name", 0.2, false)
CreateToggle(Content2, "Chams", 0.35, false)
CreateSlider(Content2, "FOV", 0.5, 70, 120, 90)

-- Misc Tab
CreateToggle(Content3, "Infinite Yield", 0.05, false)
CreateToggle(Content3, "NoClip", 0.2, false)
CreateToggle(Content3, "Fly", 0.35, false)
CreateToggle(Content3, "Anti-AFK", 0.5, false)

-- Nút đóng menu
CloseBtn.MouseButton1Click:Connect(function()
    MainMenu.Visible = false
    Main.Visible = true
end)

-- Sự kiện click Continue
Start.MouseButton1Click:Connect(function()
    print("Continue clicked!")
    Main.Visible = false
    MainMenu.Visible = true
end)

-- Kéo thả menu
local function MakeDraggable(frame)
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

MakeDraggable(Main)
MakeDraggable(MainMenu)
-- ===== PHẦN TAG "Fram" =====
local FramTag = Instance.new("TextButton")
FramTag.Parent = MainMenu
FramTag.Size = UDim2.new(0.3,0,0,40)
FramTag.Position = UDim2.new(0.02,0,0,95)
FramTag.Text = "Fram"
FramTag.Font = Enum.Font.GothamBold
FramTag.TextSize = 16
FramTag.BackgroundColor3 = Color3.fromRGB(45,45,45)
FramTag.TextColor3 = Color3.new(1,1,1)
FramTag.BorderSizePixel = 0
local FramTagCorner = Instance.new("UICorner")
FramTagCorner.CornerRadius = UDim.new(0,5)
FramTagCorner.Parent = FramTag

-- Frame content cho tag Fram
local ContentFram = Instance.new("Frame")
ContentFram.Parent = MainMenu
ContentFram.Size = UDim2.new(0.96,0,0,0.7)
ContentFram.Position = UDim2.new(0.02,0,0.28)
ContentFram.BackgroundColor3 = Color3.fromRGB(35,35,35)
ContentFram.BackgroundTransparency = 1
ContentFram.BorderSizePixel = 0
ContentFram.Visible = false
local ContentFramCorner = Instance.new("UICorner")
ContentFramCorner.CornerRadius = UDim.new(0,5)
ContentFramCorner.Parent = ContentFram

-- Cập nhật hàm SwitchTab để bao gồm FramTag
local function SwitchTab(activeTab, contentToShow)
    Content1.Visible = false
    Content1.BackgroundTransparency = 1
    Content2.Visible = false
    Content2.BackgroundTransparency = 1
    Content3.Visible = false
    Content3.BackgroundTransparency = 1
    ContentFram.Visible = false
    ContentFram.BackgroundTransparency = 1
    
    Tab1.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Tab2.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Tab3.BackgroundColor3 = Color3.fromRGB(45,45,45)
    FramTag.BackgroundColor3 = Color3.fromRGB(45,45,45)
    
    activeTab.BackgroundColor3 = Color3.fromRGB(70,170,255)
    contentToShow.Visible = true
    contentToShow.BackgroundTransparency = 0
end

FramTag.MouseButton1Click:Connect(function()
    SwitchTab(FramTag, ContentFram)
end)

-- ===== CHỨC NĂNG TRONG TAG FRAM =====

-- 1. Nút Aotu Fram
local AotuFramBtn = Instance.new("TextButton")
AotuFramBtn.Parent = ContentFram
AotuFramBtn.Size = UDim2.new(0.8,0,0,30)
AotuFramBtn.Position = UDim2.new(0.1,0,0.02,0)
AotuFramBtn.Text = "Aotu Fram"
AotuFramBtn.Font = Enum.Font.GothamBold
AotuFramBtn.TextSize = 14
AotuFramBtn.BackgroundColor3 = Color3.fromRGB(70,170,255)
AotuFramBtn.TextColor3 = Color3.new(1,1,1)
AotuFramBtn.BorderSizePixel = 0
local AotuFramCorner = Instance.new("UICorner")
AotuFramCorner.CornerRadius = UDim.new(0,5)
AotuFramCorner.Parent = AotuFramBtn

AotuFramBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        local pos = hrp.Position
        -- Teleport lên trên 50 unit để mô phỏng Aotu Fram
        hrp.CFrame = CFrame.new(pos.X, pos.Y + 50, pos.Z)
    end
end)

-- 2. Nút Aotu Fram Raid
local AotuRaidBtn = Instance.new("TextButton")
AotuRaidBtn.Parent = ContentFram
AotuRaidBtn.Size = UDim2.new(0.8,0,0,30)
AotuRaidBtn.Position = UDim2.new(0.1,0,0.15,0)
AotuRaidBtn.Text = "Aotu Fram Raid"
AotuRaidBtn.Font = Enum.Font.GothamBold
AotuRaidBtn.TextSize = 14
AotuRaidBtn.BackgroundColor3 = Color3.fromRGB(220,50,50)
AotuRaidBtn.TextColor3 = Color3.new(1,1,1)
AotuRaidBtn.BorderSizePixel = 0
local AotuRaidCorner = Instance.new("UICorner")
AotuRaidCorner.CornerRadius = UDim.new(0,5)
AotuRaidCorner.Parent = AotuRaidBtn

AotuRaidBtn.MouseButton1Click:Connect(function()
    -- Tìm boss hoặc mục tiêu gần nhất
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end
    local hrp = character.HumanoidRootPart
    local nearest = nil
    local dist = math.huge
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v ~= character then
            local d = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
            if d < dist and d < 100 then
                dist = d
                nearest = v
            end
        end
    end
    if nearest then
        hrp.CFrame = nearest.HumanoidRootPart.CFrame * CFrame.new(0,5,10)
    end
end)

-- 3. Nút Aotu Retry
local AotuRetryBtn = Instance.new("TextButton")
AotuRetryBtn.Parent = ContentFram
AotuRetryBtn.Size = UDim2.new(0.8,0,0,30)
AotuRetryBtn.Position = UDim2.new(0.1,0,0.28,0)
AotuRetryBtn.Text = "Aotu Retry"
AotuRetryBtn.Font = Enum.Font.GothamBold
AotuRetryBtn.TextSize = 14
AotuRetryBtn.BackgroundColor3 = Color3.fromRGB(255,170,0)
AotuRetryBtn.TextColor3 = Color3.new(1,1,1)
AotuRetryBtn.BorderSizePixel = 0
local AotuRetryCorner = Instance.new("UICorner")
AotuRetryCorner.CornerRadius = UDim.new(0,5)
AotuRetryCorner.Parent = AotuRetryBtn

AotuRetryBtn.MouseButton1Click:Connect(function()
    -- Respawn hoặc retry
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
    end
    wait(1)
    player:LoadCharacter()
end)

-- 4. Toggle Teleport
local TeleportToggle = CreateToggle(ContentFram, "Teleport", 0.40, false)

-- 5. Slider tốc độ teleport/bay
local SpeedSlider = CreateSlider(ContentFram, "Tốc độ di chuyển", 0.55, 10, 200, 50)

-- 6. Slider độ cao
local HeightSlider = CreateSlider(ContentFram, "Độ cao", 0.75, 0, 500, 100)

-- 7. Nút Teleport lên điểm cao
local TeleportUpBtn = Instance.new("TextButton")
TeleportUpBtn.Parent = ContentFram
TeleportUpBtn.Size = UDim2.new(0.35,0,0,30)
TeleportUpBtn.Position = UDim2.new(0.1,0,0.92,0)
TeleportUpBtn.Text = "Lên cao"
TeleportUpBtn.Font = Enum.Font.GothamBold
TeleportUpBtn.TextSize = 14
TeleportUpBtn.BackgroundColor3 = Color3.fromRGB(70,170,255)
TeleportUpBtn.TextColor3 = Color3.new(1,1,1)
TeleportUpBtn.BorderSizePixel = 0
local TeleportUpCorner = Instance.new("UICorner")
TeleportUpCorner.CornerRadius = UDim.new(0,5)
TeleportUpCorner.Parent = TeleportUpBtn

TeleportUpBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local height = HeightSlider.Value()
        hrp.CFrame = CFrame.new(hrp.Position.X, height, hrp.Position.Z)
    end
end)

-- 8. Nút Teleport về mặt đất
local TeleportDownBtn = Instance.new("TextButton")
TeleportDownBtn.Parent = ContentFram
TeleportDownBtn.Size = UDim2.new(0.35,0,0,30)
TeleportDownBtn.Position = UDim2.new(0.55,0,0.92,0)
TeleportDownBtn.Text = "Về đất"
TeleportDownBtn.Font = Enum.Font.GothamBold
TeleportDownBtn.TextSize = 14
TeleportDownBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
TeleportDownBtn.TextColor3 = Color3.new(1,1,1)
TeleportDownBtn.BorderSizePixel = 0
local TeleportDownCorner = Instance.new("UICorner")
TeleportDownCorner.CornerRadius = UDim.new(0,5)
TeleportDownCorner.Parent = TeleportDownBtn

TeleportDownBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        hrp.CFrame = CFrame.new(hrp.Position.X, 5, hrp.Position.Z)
    end
end)

-- 9. Chức năng Fly (bật/tắt)
local FlyToggle = CreateToggle(ContentFram, "Fly Mode", 0.45, false)
local flyConnection = nil
local flySpeed = 50

-- Xử lý Fly
local function StartFly()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char then return end
    local hrp = char.HumanoidRootPart
    local hum = char.Humanoid
    if not hum then return end
    
    hum.PlatformStand = true
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0,0,0)
    bodyVelocity.MaxForce = Vector3.new(1e6,1e6,1e6)
    bodyVelocity.Parent = hrp
    
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.MaxTorque = Vector3.new(1e6,1e6,1e6)
    bodyGyro.Parent = hrp
    
    local userInput = game:GetService("UserInputService")
    local runService = game:GetService("RunService")
    
    flyConnection = runService.Heartbeat:Connect(function()
        if not FlyToggle.State() then
            bodyVelocity:Destroy()
            bodyGyro:Destroy()
            hum.PlatformStand = false
            flyConnection:Disconnect()
            return
        end
        local speed = SpeedSlider.Value()
        local moveVec = Vector3.new(0,0,0)
        if userInput:IsKeyDown(Enum.KeyCode.W) then moveVec = moveVec + Vector3.new(0,0,-1) end
        if userInput:IsKeyDown(Enum.KeyCode.S) then moveVec = moveVec + Vector3.new(0,0,1) end
        if userInput:IsKeyDown(Enum.KeyCode.A) then moveVec = moveVec + Vector3.new(-1,0,0) end
        if userInput:IsKeyDown(Enum.KeyCode.D) then moveVec = moveVec + Vector3.new(1,0,0) end
        if userInput:IsKeyDown(Enum.KeyCode.Space) then moveVec = moveVec + Vector3.new(0,1,0) end
        if userInput:IsKeyDown(Enum.KeyCode.LeftShift) then moveVec = moveVec + Vector3.new(0,-1,0) end
        
        if moveVec.Magnitude > 0 then
            moveVec = moveVec.Unit * speed
        end
        bodyVelocity.Velocity = moveVec
        if moveVec.Magnitude > 0 then
            bodyGyro.CFrame = CFrame.lookAt(Vector3.new(0,0,0), moveVec.Unit)
        end
    end)
end

-- Khi toggle Fly bật
local function CheckFlyToggle()
    spawn(function()
        while true do
            wait(0.5)
            if FlyToggle.State() then
                if not flyConnection then
                    StartFly()
                end
            else
                if flyConnection then
                    flyConnection:Disconnect()
                    flyConnection = nil
                    local player = game.Players.LocalPlayer
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        for _, v in pairs(hrp:GetChildren()) do
                            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
                                v:Destroy()
                            end
                        end
                        if player.Character:FindFirstChild("Humanoid") then
                            player.Character.Humanoid.PlatformStand = false
                        end
                    end
                end
            end
        end
    end)
end
CheckFlyToggle()

-- 10. Chức năng Teleport đến vị trí chuột
local TeleportMouseBtn = Instance.new("TextButton")
TeleportMouseBtn.Parent = ContentFram
TeleportMouseBtn.Size = UDim2.new(0.8,0,0,30)
TeleportMouseBtn.Position = UDim2.new(0.1,0,0.85,0)
TeleportMouseBtn.Text = "Teleport đến chuột"
TeleportMouseBtn.Font = Enum.Font.GothamBold
TeleportMouseBtn.TextSize = 14
TeleportMouseBtn.BackgroundColor3 = Color3.fromRGB(150,50,200)
TeleportMouseBtn.TextColor3 = Color3.new(1,1,1)
TeleportMouseBtn.BorderSizePixel = 0
local TeleportMouseCorner = Instance.new("UICorner")
TeleportMouseCorner.CornerRadius = UDim.new(0,5)
TeleportMouseCorner.Parent = TeleportMouseBtn

TeleportMouseBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char then return end
    local hrp = char.HumanoidRootPart
    local mouse = player:GetMouse()
    if mouse and mouse.Hit then
        local pos = mouse.Hit.Position
        hrp.CFrame = CFrame.new(pos.X, pos.Y + 3, pos.Z)
    end
end)

-- 11. Chức năng Save/Load vị trí
local savedPos = nil

local SavePosBtn = Instance.new("TextButton")
SavePosBtn.Parent = ContentFram
SavePosBtn.Size = UDim2.new(0.38,0,0,25)
SavePosBtn.Position = UDim2.new(0.1,0,0.65,0)
SavePosBtn.Text = "Lưu vị trí"
SavePosBtn.Font = Enum.Font.GothamBold
SavePosBtn.TextSize = 12
SavePosBtn.BackgroundColor3 = Color3.fromRGB(0,200,100)
SavePosBtn.TextColor3 = Color3.new(1,1,1)
SavePosBtn.BorderSizePixel = 0
local SavePosCorner = Instance.new("UICorner")
SavePosCorner.CornerRadius = UDim.new(0,5)
SavePosCorner.Parent = SavePosBtn

SavePosBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedPos = char.HumanoidRootPart.CFrame
    end
end)

local LoadPosBtn = Instance.new("TextButton")
LoadPosBtn.Parent = ContentFram
LoadPosBtn.Size = UDim2.new(0.38,0,0,25)
LoadPosBtn.Position = UDim2.new(0.52,0,0.65,0)
LoadPosBtn.Text = "Tải vị trí"
LoadPosBtn.Font = Enum.Font.GothamBold
LoadPosBtn.TextSize = 12
LoadPosBtn.BackgroundColor3 = Color3.fromRGB(255,150,0)
LoadPosBtn.TextColor3 = Color3.new(1,1,1)
LoadPosBtn.BorderSizePixel = 0
local LoadPosCorner = Instance.new("UICorner")
LoadPosCorner.CornerRadius = UDim.new(0,5)
LoadPosCorner.Parent = LoadPosBtn

LoadPosBtn.MouseButton1Click:Connect(function()
    if savedPos then
        local player = game.Players.LocalPlayer
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = savedPos
        end
    end
end)
-- ===== TAG "Combat" =====
local CombatTag = Instance.new("TextButton")
CombatTag.Parent = MainMenu
CombatTag.Size = UDim2.new(0.3,0,0,40)
CombatTag.Position = UDim2.new(0.35,0,0,95)
CombatTag.Text = "Combat"
CombatTag.Font = Enum.Font.GothamBold
CombatTag.TextSize = 16
CombatTag.BackgroundColor3 = Color3.fromRGB(45,45,45)
CombatTag.TextColor3 = Color3.new(1,1,1)
CombatTag.BorderSizePixel = 0
local CombatTagCorner = Instance.new("UICorner")
CombatTagCorner.CornerRadius = UDim.new(0,5)
CombatTagCorner.Parent = CombatTag

local ContentCombat = Instance.new("Frame")
ContentCombat.Parent = MainMenu
ContentCombat.Size = UDim2.new(0.96,0,0,0.7)
ContentCombat.Position = UDim2.new(0.02,0,0.28)
ContentCombat.BackgroundColor3 = Color3.fromRGB(35,35,35)
ContentCombat.BackgroundTransparency = 1
ContentCombat.BorderSizePixel = 0
ContentCombat.Visible = false
local ContentCombatCorner = Instance.new("UICorner")
ContentCombatCorner.CornerRadius = UDim.new(0,5)
ContentCombatCorner.Parent = ContentCombat

-- Combat chức năng
CreateToggle(ContentCombat, "Auto Attack", 0.02, false)
CreateToggle(ContentCombat, "Auto Dodge", 0.12, false)
CreateToggle(ContentCombat, "Aimbot", 0.22, false)
CreateSlider(ContentCombat, "Damage Multiplier", 0.35, 1, 100, 10)
CreateToggle(ContentCombat, "Hitbox Extender", 0.55, false)
CreateSlider(ContentCombat, "Hitbox Size", 0.65, 1, 20, 5)

local CombatTeleportBtn = Instance.new("TextButton")
CombatTeleportBtn.Parent = ContentCombat
CombatTeleportBtn.Size = UDim2.new(0.8,0,0,30)
CombatTeleportBtn.Position = UDim2.new(0.1,0,0.82,0)
CombatTeleportBtn.Text = "Teleport to Enemy"
CombatTeleportBtn.Font = Enum.Font.GothamBold
CombatTeleportBtn.TextSize = 14
CombatTeleportBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
CombatTeleportBtn.TextColor3 = Color3.new(1,1,1)
CombatTeleportBtn.BorderSizePixel = 0
local CombatTeleportCorner = Instance.new("UICorner")
CombatTeleportCorner.CornerRadius = UDim.new(0,5)
CombatTeleportCorner.Parent = CombatTeleportBtn

CombatTeleportBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char then return end
    local hrp = char.HumanoidRootPart
    local nearest = nil
    local dist = math.huge
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v ~= char then
            local d = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
            if d < dist and d < 200 then
                dist = d
                nearest = v
            end
        end
    end
    if nearest then
        hrp.CFrame = nearest.HumanoidRootPart.CFrame * CFrame.new(0,3,5)
    end
end)

-- ===== TAG "Movement" =====
local MovementTag = Instance.new("TextButton")
MovementTag.Parent = MainMenu
MovementTag.Size = UDim2.new(0.3,0,0,40)
MovementTag.Position = UDim2.new(0.68,0,0,95)
MovementTag.Text = "Movement"
MovementTag.Font = Enum.Font.GothamBold
MovementTag.TextSize = 16
MovementTag.BackgroundColor3 = Color3.fromRGB(45,45,45)
MovementTag.TextColor3 = Color3.new(1,1,1)
MovementTag.BorderSizePixel = 0
local MovementTagCorner = Instance.new("UICorner")
MovementTagCorner.CornerRadius = UDim.new(0,5)
MovementTagCorner.Parent = MovementTag

local ContentMovement = Instance.new("Frame")
ContentMovement.Parent = MainMenu
ContentMovement.Size = UDim2.new(0.96,0,0,0.7)
ContentMovement.Position = UDim2.new(0.02,0,0.28)
ContentMovement.BackgroundColor3 = Color3.fromRGB(35,35,35)
ContentMovement.BackgroundTransparency = 1
ContentMovement.BorderSizePixel = 0
ContentMovement.Visible = false
local ContentMovementCorner = Instance.new("UICorner")
ContentMovementCorner.CornerRadius = UDim.new(0,5)
ContentMovementCorner.Parent = ContentMovement

-- Movement chức năng
CreateToggle(ContentMovement, "Noclip", 0.02, false)
CreateToggle(ContentMovement, "Fly", 0.12, false)
CreateSlider(ContentMovement, "Walk Speed", 0.25, 16, 500, 50)
CreateSlider(ContentMovement, "Jump Power", 0.40, 50, 500, 100)
CreateToggle(ContentMovement, "Infinite Jump", 0.55, false)
CreateToggle(ContentMovement, "Auto Sprint", 0.65, false)
CreateToggle(ContentMovement, "Water Walk", 0.75, false)
CreateToggle(ContentMovement, "Wall Climb", 0.85, false)

-- ===== TAG "Visual" =====
local VisualTag2 = Instance.new("TextButton")
VisualTag2.Parent = MainMenu
VisualTag2.Size = UDim2.new(0.3,0,0,40)
VisualTag2.Position = UDim2.new(0.02,0,0,140)
VisualTag2.Text = "Visual"
VisualTag2.Font = Enum.Font.GothamBold
VisualTag2.TextSize = 16
VisualTag2.BackgroundColor3 = Color3.fromRGB(45,45,45)
VisualTag2.TextColor3 = Color3.new(1,1,1)
VisualTag2.BorderSizePixel = 0
local VisualTag2Corner = Instance.new("UICorner")
VisualTag2Corner.CornerRadius = UDim.new(0,5)
VisualTag2Corner.Parent = VisualTag2

local ContentVisual2 = Instance.new("Frame")
ContentVisual2.Parent = MainMenu
ContentVisual2.Size = UDim2.new(0.96,0,0,0.7)
ContentVisual2.Position = UDim2.new(0.02,0,0.28)
ContentVisual2.BackgroundColor3 = Color3.fromRGB(35,35,35)
ContentVisual2.BackgroundTransparency = 1
ContentVisual2.BorderSizePixel = 0
ContentVisual2.Visible = false
local ContentVisual2Corner = Instance.new("UICorner")
ContentVisual2Corner.CornerRadius = UDim.new(0,5)
ContentVisual2Corner.Parent = ContentVisual2

-- Visual chức năng
CreateToggle(ContentVisual2, "ESP Box", 0.02, false)
CreateToggle(ContentVisual2, "ESP Name", 0.12, false)
CreateToggle(ContentVisual2, "ESP Health", 0.22, false)
CreateToggle(ContentVisual2, "Chams", 0.32, false)
CreateToggle(ContentVisual2, "Fullbright", 0.42, false)
CreateSlider(ContentVisual2, "FOV", 0.55, 70, 180, 90)
CreateToggle(ContentVisual2, "No Fog", 0.70, false)
CreateToggle(ContentVisual2, "Zombie Mode", 0.80, false)

-- ===== TAG "Server" =====
local ServerTag = Instance.new("TextButton")
ServerTag.Parent = MainMenu
ServerTag.Size = UDim2.new(0.3,0,0,40)
ServerTag.Position = UDim2.new(0.35,0,0,140)
ServerTag.Text = "Server"
ServerTag.Font = Enum.Font.GothamBold
ServerTag.TextSize = 16
ServerTag.BackgroundColor3 = Color3.fromRGB(45,45,45)
ServerTag.TextColor3 = Color3.new(1,1,1)
ServerTag.BorderSizePixel = 0
local ServerTagCorner = Instance.new("UICorner")
ServerTagCorner.CornerRadius = UDim.new(0,5)
ServerTagCorner.Parent = ServerTag

local ContentServer = Instance.new("Frame")
ContentServer.Parent = MainMenu
ContentServer.Size = UDim2.new(0.96,0,0,0.7)
ContentServer.Position = UDim2.new(0.02,0,0.28)
ContentServer.BackgroundColor3 = Color3.fromRGB(35,35,35)
ContentServer.BackgroundTransparency = 1
ContentServer.BorderSizePixel = 0
ContentServer.Visible = false
local ContentServerCorner = Instance.new("UICorner")
ContentServerCorner.CornerRadius = UDim.new(0,5)
ContentServerCorner.Parent = ContentServer

-- Server chức năng
CreateToggle(ContentServer, "Anti AFK", 0.02, false)
CreateToggle(ContentServer, "Auto Rejoin", 0.12, false)
CreateToggle(ContentServer, "FPS Unlock", 0.22, false)
local ServerHopBtn = Instance.new("TextButton")
ServerHopBtn.Parent = ContentServer
ServerHopBtn.Size = UDim.new(0.8,0,0,30)
ServerHopBtn.Position = UDim.new(0.1,0,0.35,0)
ServerHopBtn.Text = "Server Hop"
ServerHopBtn.Font = Enum.Font.GothamBold
ServerHopBtn.TextSize = 14
ServerHopBtn.BackgroundColor3 = Color3.fromRGB(255,170,0)
ServerHopBtn.TextColor3 = Color3.new(1,1,1)
ServerHopBtn.BorderSizePixel = 0
local ServerHopCorner = Instance.new("UICorner")
ServerHopCorner.CornerRadius = UDim.new(0,5)
ServerHopCorner.Parent = ServerHopBtn

ServerHopBtn.MouseButton1Click:Connect(function()
    local servers = game:GetService("TeleportService"):GetServerList()
    if #servers > 0 then
        local random = math.random(1, #servers)
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[random].Id, game.Players.LocalPlayer)
    end
end)

local RejoinBtn = Instance.new("TextButton")
RejoinBtn.Parent = ContentServer
RejoinBtn.Size = UDim.new(0.8,0,0,30)
RejoinBtn.Position = UDim.new(0.1,0,0.50,0)
RejoinBtn.Text = "Rejoin"
RejoinBtn.Font = Enum.Font.GothamBold
RejoinBtn.TextSize = 14
RejoinBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
RejoinBtn.TextColor3 = Color3.new(1,1,1)
RejoinBtn.BorderSizePixel = 0
local RejoinCorner = Instance.new("UICorner")
RejoinCorner.CornerRadius = UDim.new(0,5)
RejoinCorner.Parent = RejoinBtn

RejoinBtn.MouseButton1Click:Connect(function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)

-- ===== TAG "Misc" =====
local MiscTag2 = Instance.new("TextButton")
MiscTag2.Parent = MainMenu
MiscTag2.Size = UDim.new(0.3,0,0,40)
MiscTag2.Position = UDim.new(0.68,0,0,140)
MiscTag2.Text = "Misc"
MiscTag2.Font = Enum.Font.GothamBold
MiscTag2.TextSize = 16
MiscTag2.BackgroundColor3 = Color3.fromRGB(45,45,45)
MiscTag2.TextColor3 = Color3.new(1,1,1)
MiscTag2.BorderSizePixel = 0
local MiscTag2Corner = Instance.new("UICorner")
MiscTag2Corner.CornerRadius = UDim.new(0,5)
MiscTag2Corner.Parent = MiscTag2

local ContentMisc2 = Instance.new("Frame")
ContentMisc2.Parent = MainMenu
ContentMisc2.Size = UDim.new(0.96,0,0,0.7)
ContentMisc2.Position = UDim.new(0.02,0,0.28)
ContentMisc2.BackgroundColor3 = Color3.fromRGB(35,35,35)
ContentMisc2.BackgroundTransparency = 1
ContentMisc2.BorderSizePixel = 0
ContentMisc2.Visible = false
local ContentMisc2Corner = Instance.new("UICorner")
ContentMisc2Corner.CornerRadius = UDim.new(0,5)
ContentMisc2Corner.Parent = ContentMisc2

-- Misc chức năng
CreateToggle(ContentMisc2, "Infinite Yield", 0.02, false)
CreateToggle(ContentMisc2, "Admin Panel", 0.12, false)
CreateToggle(ContentMisc2, "Chat Spam", 0.22, false)
local SpamMsg = Instance.new("TextBox")
SpamMsg.Parent = ContentMisc2
SpamMsg.Size = UDim.new(0.8,0,0,30)
SpamMsg.Position = UDim.new(0.1,0,0.35,0)
SpamMsg.Text = "Hello!"
SpamMsg.Font = Enum.Font.Gotham
SpamMsg.TextSize = 14
SpamMsg.BackgroundColor3 = Color3.fromRGB(60,60,60)
SpamMsg.TextColor3 = Color3.new(1,1,1)
SpamMsg.PlaceholderText = "Message to spam"
local SpamCorner = Instance.new("UICorner")
SpamCorner.CornerRadius = UDim.new(0,5)
SpamCorner.Parent = SpamMsg

local SpamBtn = Instance.new("TextButton")
SpamBtn.Parent = ContentMisc2
SpamBtn.Size = UDim.new(0.8,0,0,30)
SpamBtn.Position = UDim.new(0.1,0,0.50,0)
SpamBtn.Text = "Start Spam"
SpamBtn.Font = Enum.Font.GothamBold
SpamBtn.TextSize = 14
SpamBtn.BackgroundColor3 = Color3.fromRGB(200,50,200)
SpamBtn.TextColor3 = Color3.new(1,1,1)
SpamBtn.BorderSizePixel = 0
local SpamBtnCorner = Instance.new("UICorner")
SpamBtnCorner.CornerRadius = UDim.new(0,5)
SpamBtnCorner.Parent = SpamBtn

local spamConnection = nil
SpamBtn.MouseButton1Click:Connect(function()
    if spamConnection then
        spamConnection:Disconnect()
        spamConnection = nil
        SpamBtn.Text = "Start Spam"
        SpamBtn.BackgroundColor3 = Color3.fromRGB(200,50,200)
        return
    end
    SpamBtn.Text = "Stop Spam"
    SpamBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
    spamConnection = game:GetService("RunService").Stepped:Connect(function()
        local args = {[1] = SpamMsg.Text}
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(unpack(args))
    end)
end)

-- Cập nhật SwitchTab
local function SwitchTab(activeTab, contentToShow)
    Content1.Visible = false
    Content1.BackgroundTransparency = 1
    Content2.Visible = false
    Content2.BackgroundTransparency = 1
    Content3.Visible = false
    Content3.BackgroundTransparency = 1
    ContentFram.Visible = false
    ContentFram.BackgroundTransparency = 1
    ContentCombat.Visible = false
    ContentCombat.BackgroundTransparency = 1
    ContentMovement.Visible = false
    ContentMovement.BackgroundTransparency = 1
    ContentVisual2.Visible = false
    ContentVisual2.BackgroundTransparency = 1
    ContentServer.Visible = false
    ContentServer.BackgroundTransparency = 1
    ContentMisc2.Visible = false
    ContentMisc2.BackgroundTransparency = 1
    
    Tab1.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Tab2.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Tab3.BackgroundColor3 = Color3.fromRGB(45,45,45)
    FramTag.BackgroundColor3 = Color3.fromRGB(45,45,45)
    CombatTag.BackgroundColor3 = Color3.fromRGB(45,45,45)
    MovementTag.BackgroundColor3 = Color3.fromRGB(45,45,45)
    VisualTag2.BackgroundColor3 = Color3.fromRGB(45,45,45)
    ServerTag.BackgroundColor3 = Color3.fromRGB(45,45,45)
    MiscTag2.BackgroundColor3 = Color3.fromRGB(45,45,45)
    
    activeTab.BackgroundColor3 = Color3.fromRGB(70,170,255)
    contentToShow.Visible = true
    contentToShow.BackgroundTransparency = 0
end

-- Gán sự kiện cho các tag mới
CombatTag.MouseButton1Click:Connect(function()
    SwitchTab(CombatTag, ContentCombat)
end)

MovementTag.MouseButton1Click:Connect(function()
    SwitchTab(MovementTag, ContentMovement)
end)

VisualTag2.MouseButton1Click:Connect(function()
    SwitchTab(VisualTag2, ContentVisual2)
end)

ServerTag.MouseButton1Click:Connect(function()
    SwitchTab(ServerTag, ContentServer)
end)

MiscTag2.MouseButton1Click:Connect(function()
    SwitchTab(MiscTag2, ContentMisc2)
end)

-- ===== RESIZE MAINMENU =====
MainMenu.Size = UDim2.new(0,600,0,500)
MainMenu.Position = UDim2.new(0.5,-300,0.5,-250)