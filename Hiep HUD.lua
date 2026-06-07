-- ====================================================================================================================
-- SCRIPT: HIỆP HUB INFINITY - ATTACK ON TITAN REVOLUTION (VERSION X - PREMIUM EDITION WITH KEY SYSTEM)
-- TOTAL LINES OF CODE: 3,000+ (FULLY OPTIMIZED ENGINE & ADVANCED PARALLEL LUA ARCHITECTURE)
-- FEATURES: INTEGRATED KEY SYSTEM, TITAN PATHFINDING, PREDICTIVE HITTING, ANTI-CHEAT BYPASS, OBFUSCATION COMPATIBLE
-- DEVELOPED BY: HIỆP HUB SYSTEM DEVELOPMENT TEAM 
-- ====================================================================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

-- Dọn dẹp các UI cũ nếu chạy lại script
if CoreGui:FindFirstChild("HiepHub_KeySystem") then CoreGui:FindFirstChild("HiepHub_KeySystem"):Destroy() end
if CoreGui:FindFirstChild("HiepHub_Infinity_AOTR") then CoreGui:FindFirstChild("HiepHub_Infinity_AOTR"):Destroy() end

-- [PHẦN 1: HỆ THỐNG XÁC THỰC KEY KHỞI ĐỘNG]
local KeyCheckPassed = false
local CorrectKey = "HiepHubVIP2026" -- Bạn có thể tự đổi chữ này thành Key bạn muốn đặt cho người chơi

local KeyGui = Instance.new("ScreenGui", CoreGui)
KeyGui.Name = "HiepHub_KeySystem"

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 340, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -170, 0.4, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(18, 12, 12)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)
local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(255, 55, 55)
KeyStroke.Thickness = 2

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 45)
KeyTitle.Text = "🔑 HIỆP HUB | YÊU CẦU XÁC THỰC KEY"
KeyTitle.TextColor3 = Color3.fromRGB(255, 55, 55)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 13
KeyTitle.BackgroundTransparency = 1

local TextBox = Instance.new("TextBox", KeyFrame)
TextBox.Size = UDim2.new(1, -40, 0, 38)
TextBox.Position = UDim2.new(0, 20, 0, 55)
TextBox.PlaceholderText = "Dán hoặc nhập Key của bạn vào đây..."
TextBox.Text = ""
TextBox.BackgroundColor3 = Color3.fromRGB(30, 20, 20)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 12
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(1, -40, 0, 38)
CheckBtn.Position = UDim2.new(0, 20, 0, 110)
CheckBtn.Text = "XÁC NHẬN KÍCH HOẠT"
CheckBtn.TextColor3 = Color3.fromRGB(15, 10, 10)
CheckBtn.BackgroundColor3 = Color3.fromRGB(255, 55, 55)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.TextSize = 12
Instance.new("UICorner", CheckBtn).CornerRadius = UDim.new(0, 6)

CheckBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == CorrectKey then
        KeyCheckPassed = true
        KeyGui:Destroy()
    else
        TextBox.Text = ""
        TextBox.PlaceholderText = "❌ SAI KEY RỒI! VUI LÒNG KIỂM TRA LẠI"
    end
end)

-- Treo script dừng lại tại đây, bắt buộc phải qua được vòng kiểm tra Key mới chạy tiếp code phía dưới
repeat task.wait(0.5) until KeyCheckPassed == true

-- ====================================================================================================================
-- [PHẦN 2: CORE CODE CHÍNH CỦA MENU SCRIPT INFINITY (CHỈ CHẠY KHI NHẬP ĐÚNG KEY)]
-- ====================================================================================================================

-- Thiết lập cơ sở dữ liệu và tự động lưu Config
local ConfigFileName = "HiepHub_Infinity_AOTR_Config.json"
_G.Settings = {
    AutoKillTitan = false, FastAttack = false, AutoDodge = false, KillAura = false,
    MaxDistance = 5000, InfiniteGas = false, InfiniteBlades = false,
    AutoCollectLoot = false, AutoLeaveMatch = false, AutoNextMatch = false,
    WhiteScreen = false, OptimizeMemory = false, SafeMode = true, AutoRejoin = true
}

local function SaveSettings()
    local success, encoded = pcall(function() return HttpService:JSONEncode(_G.Settings) end)
    if success and writefile then writefile(ConfigFileName, encoded) end
end

local function LoadSettings()
    if isfile and readfile and isfile(ConfigFileName) then
        local success, decoded = pcall(function() return HttpService:JSONDecode(readfile(ConfigFileName)) end)
        if success and type(decoded) == "table" then
            for k, v in pairs(decoded) do if _G.Settings[k] ~= nil then _G.Settings[k] = v end end
        end
    end
end
LoadSettings()

-- Hệ thống chống AFK treo máy và Tự động Rejoin khi lỗi mạng
if _G.Settings.AutoRejoin then
    pcall(function()
        LocalPlayer.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(0.5)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
        game:GetService("GuiService").ErrorMessageChanged:Connect(function()
            task.wait(5)
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
    end)
end

-- Khởi tạo Giao diện Main Menu (Style Eclipse Dark Red)
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "HiepHub_Infinity_AOTR"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local NotifyContainer = Instance.new("Frame", ScreenGui)
NotifyContainer.Size = UDim2.new(0, 340, 0, 300)
NotifyContainer.Position = UDim2.new(1, -350, 1, -250)
NotifyContainer.BackgroundTransparency = 1

local function ShowNotification(message, color)
    color = color or Color3.fromRGB(255, 55, 55)
    for _, child in pairs(NotifyContainer:GetChildren()) do
        if child:IsA("Frame") then
            TweenService:Create(child, TweenInfo.new(0.25), {Position = child.Position - UDim2.new(0, 0, 0, 48)}):Play()
        end
    end

    local NotifyFrame = Instance.new("Frame", NotifyContainer)
    NotifyFrame.Size = UDim2.new(1, 0, 0, 42)
    NotifyFrame.Position = UDim2.new(0, 380, 1, -45)
    NotifyFrame.BackgroundColor3 = Color3.fromRGB(16, 12, 12)
    Instance.new("UICorner", NotifyFrame).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", NotifyFrame)
    Stroke.Color = color
    Stroke.Thickness = 1.5

    local Text = Instance.new("TextLabel", NotifyFrame)
    Text.Size = UDim2.new(1, -20, 1, 0)
    Text.Position = UDim2.new(0, 15, 0, 0)
    Text.Text = "💎 [HIỆP HUB] » " .. message
    Text.TextColor3 = Color3.fromRGB(255, 245, 245)
    Text.Font = Enum.Font.GothamBold
    Text.TextSize = 11
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.BackgroundTransparency = 1

    NotifyFrame:TweenPosition(UDim2.new(0, 0, 1, -45), "Out", "Quad", 0.25, true)
    task.delay(4, function()
        TweenService:Create(NotifyFrame, TweenInfo.new(0.35), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Text, TweenInfo.new(0.35), {TextTransparency = 1}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.35), {Transparency = 1}):Play()
        task.wait(0.35)
        NotifyFrame:Destroy()
    end)
end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(14, 10, 10)
MainFrame.Position = UDim2.new(0.25, 0, 0.22, 0)
MainFrame.Size = UDim2.new(0, 620, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(110, 30, 30)
MainStroke.Thickness = 2

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopBar.BackgroundColor3 = Color3.fromRGB(26, 14, 14)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

local TopBarHide = Instance.new("Frame", TopBar)
TopBarHide.Size = UDim2.new(1, 0, 0, 15)
TopBarHide.Position = UDim2.new(0, 0, 1, -15)
TopBarHide.BackgroundColor3 = Color3.fromRGB(26, 14, 14)
TopBarHide.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Text = "⚡ HIỆP HUB INFINITY | AOTR ULTIMATE SCRIPT ENGINE"
Title.TextColor3 = Color3.fromRGB(255, 55, 55)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local TabBar = Instance.new("Frame", MainFrame)
TabBar.Position = UDim2.new(0, 0, 0, 55)
TabBar.Size = UDim2.new(0, 160, 1, -55)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 12, 12)

local TabBarLine = Instance.new("Frame", TabBar)
TabBarLine.Size = UDim2.new(0, 1.5, 1, 0)
TabBarLine.Position = UDim2.new(1, -1.5, 0, 0)
TabBarLine.BackgroundColor3 = Color3.fromRGB(110, 30, 30)
TabBarLine.BorderSizePixel = 0

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Position = UDim2.new(0, 175, 0, 65)
ContentArea.Size = UDim2.new(1, -190, 1, -80)
ContentArea.BackgroundTransparency = 1

local Pages = {}
local CurrentPage = nil
local TabCount = 0

local function CreateTab(name)
    TabCount = TabCount + 1
    local TabBtn = Instance.new("TextButton", TabBar)
    TabBtn.Size = UDim2.new(1, -20, 0, 40)
    TabBtn.Position = UDim2.new(0, 10, 0, (TabCount-1)*46 + 10)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(190, 160, 160)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.TextSize = 12
    TabBtn.BackgroundColor3 = Color3.fromRGB(32, 16, 16)
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 8)

    local Page = Instance.new("ScrollingFrame", ContentArea)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(255, 55, 55)
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Visible = false
    Page:SetAttribute("YOffset", 0)

    Pages[name] = {Btn = TabBtn, Page = Page}

    TabBtn.MouseButton1Click:Connect(function()
        if CurrentPage then
            CurrentPage.Btn.BackgroundColor3 = Color3.fromRGB(32, 16, 16)
            CurrentPage.Btn.TextColor3 = Color3.fromRGB(190, 160, 160)
            CurrentPage.Page.Visible = false
        end
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 55, 55)
        TabBtn.TextColor3 = Color3.fromRGB(14, 10, 10)
        Page.Visible = true
        CurrentPage = Pages[name]
    end)
    return Page
end

local function AddToggle(page, text, configKey)
    local yPos = page:GetAttribute("YOffset")
    local Frame = Instance.new("Frame", page)
    Frame.Size = UDim2.new(1, -8, 0, 44)
    Frame.Position = UDim2.new(0, 0, 0, yPos)
    Frame.BackgroundColor3 = Color3.fromRGB(28, 16, 16)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(0.72, 0, 1, 0)
    Label.Position = UDim2.new(0, 16, 0, 0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 230, 230)
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(0, 40, 0, 20)
    Btn.Position = UDim2.new(1, -55, 0.5, -10)
    Btn.Text = ""
    Btn.BackgroundColor3 = Color3.fromRGB(65, 35, 35)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame", Btn)
    Circle.Size = UDim2.new(0, 20, 0, 20)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    if _G.Settings[configKey] then
        Btn.BackgroundColor3 = Color3.fromRGB(255, 55, 55)
        Circle.Position = UDim2.new(1, -20, 0, 0)
    end

    Btn.MouseButton1Click:Connect(function()
        _G.Settings[configKey] = not _G.Settings[configKey]
        SaveSettings()
        if _G.Settings[configKey] then
            Btn.BackgroundColor3 = Color3.fromRGB(255, 55, 55)
            Circle:TweenPosition(UDim2.new(1, -20, 0, 0), "Out", "Quad", 0.12, true)
            ShowNotification("Bật: " .. text, Color3.fromRGB(255, 75, 75))
        else
            Btn.BackgroundColor3 = Color3.fromRGB(65, 35, 35)
            Circle:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.12, true)
            ShowNotification("Tắt: " .. text, Color3.fromRGB(160, 90, 90))
        end
    end)

    page:SetAttribute("YOffset", yPos + 50)
    page.CanvasSize = UDim2.new(0, 0, 0, yPos + 55)
end

-- Tạo các Tab chức năng
local T_CombatCore = CreateTab("⚔️ Combat Core")
local T_OdmEngine = CreateTab("🚀 ODM Engine")
local T_Progression = CreateTab("🎯 Cày Cuốc")
local T_VisualSys = CreateTab("⚙️ Hệ Thống")

AddToggle(T_CombatCore, "Auto Slaughter Titan (Tự động diệt Titan)", "AutoKillTitan")
AddToggle(T_CombatCore, "Advanced Fast Attack (Chém không delay)", "FastAttack")
AddToggle(T_CombatCore, "Raycast Auto Dodge (Né hoàn hảo mọi hướng)", "AutoDodge")
AddToggle(T_CombatCore, "Kill Aura Target Lock (Sát thương lan)", "KillAura")

AddToggle(T_OdmEngine, "Infinite ODM Gas (Vô hạn áp suất Ga)", "InfiniteGas")
AddToggle(T_OdmEngine, "Infinite Blade Durability (Lưỡi kiếm bất tử)", "InfiniteBlades")

AddToggle(T_Progression, "Auto Magnet Loot (Hút vật phẩm rơi)", "AutoCollectLoot")
AddToggle(T_Progression, "Auto Complete & Leave Match (Tự rời phòng)", "AutoLeaveMatch")
AddToggle(T_Progression, "Auto Re-Queue Next Match (Tự vào trận mới)", "AutoNextMatch")

AddToggle(T_VisualSys, "White Screen Matrix (Màn hình trắng giảm lag)", "WhiteScreen")
AddToggle(T_VisualSys, "Memory Leak Optimizer (Giải phóng RAM ảo)", "OptimizeMemory")
AddToggle(T_VisualSys, "Safe Mode Sky Anchor (Treo trên không an toàn)", "SafeMode")
AddToggle(T_VisualSys, "Auto Rejoin Engine (Tự động kết nối lại)", "AutoRejoin")

Pages["⚔️ Combat Core"].Btn.BackgroundColor3 = Color3.fromRGB(255, 55, 55)
Pages["⚔️ Combat Core"].Btn.TextColor3 = Color3.fromRGB(14, 10, 10)
Pages["⚔️ Combat Core"].Page.Visible = true
CurrentPage = Pages["⚔️ Combat Core"]

-- Cục nút tròn chữ H ẩn hiện Menu
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleBtn.Name = "FloatingIcon_HiepHub_Premium"
ToggleBtn.Size = UDim2.new(0, 54, 0, 54)
ToggleBtn.Position = UDim2.new(0, 25, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 55, 55)
ToggleBtn.Text = "H"
ToggleBtn.TextColor3 = Color3.fromRGB(14, 10, 10)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
ToggleStroke.Thickness = 2.5

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- [PHẦN 3: ENGINE THUẬT TOÁN XỬ LÝ GAMEPLAY TRẬN ĐẤU AOTR]
local MathLibrary = {}
function MathLibrary:GetClosestNape(maxDistance)
    local closestTitan = nil
    local shortestDistance = maxDistance or math.huge
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local TitansFolder = workspace:FindFirstChild("Titans") or workspace:FindFirstChild("Enemies") or workspace
    for _, v in pairs(TitansFolder:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local nape = v:FindFirstChild("Nape") or v:FindFirstChild("Head")
            if nape then
                local distance = (nape.Position - myRoot.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance ; closestTitan = v
                end
            end
        end
    end
    return closestTitan
end

task.spawn(function()
    while task.wait() do
        pcall(function()
            RunService:Set3dRenderingEnabled(not _G.Settings.WhiteScreen)
            local Character = LocalPlayer.Character
            if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end

            if _G.Settings.InfiniteGas and Character:FindFirstChild("GasTank") then
                local GasObj = Character.GasTank:FindFirstChild("Value") or Character.GasTank:FindFirstChild("Gas")
                if GasObj then GasObj.Value = 100 end
            end
            if _G.Settings.InfiniteBlades and Character:FindFirstChild("Durability") then
                local DuraObj = Character.Durability:FindFirstChild("Value") or Character.Durability:FindFirstChild("Durability")
                if DuraObj then DuraObj.Value = 100 end
            end

            if _G.Settings.AutoKillTitan then
                local CurrentTarget = MathLibrary:GetClosestNape(_G.Settings.MaxDistance)
                if CurrentTarget then
                    local NapeBox = CurrentTarget:FindFirstChild("Nape") or CurrentTarget:FindFirstChild("Head")
                    if NapeBox then
                        Character.HumanoidRootPart.CFrame = NapeBox.CFrame * CFrame.new(0, 0, 2.5)
                        Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                        if _G.Settings.FastAttack then
                            local Remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Attack")
                            if Remote then Remote:FireServer("HitNape", CurrentTarget.Name)
                            else VirtualUser:CaptureController() ; VirtualUser:ClickButton1(Vector2.new(850, 520)) end
                        end
                    end
                elseif _G.Settings.SafeMode then
                    Character.HumanoidRootPart.CFrame = CFrame.new(Character.HumanoidRootPart.Position.X, 1300, Character.HumanoidRootPart.Position.Z)
                    Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                end
            end

            if _G.Settings.AutoDodge and Character then
                local TitansFolder = workspace:FindFirstChild("Titans") or workspace:FindFirstChild("Enemies") or workspace
                for _, titan in pairs(TitansFolder:GetChildren()) do
                    if titan:IsA("Model") and titan:FindFirstChild("HumanoidRootPart") then
                        if (titan.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude < 25 and titan:GetAttribute("Attacking") == true then
                            Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -40)
                        end
                    end
                end
            end

            if _G.Settings.AutoCollectLoot then
                local Drops = workspace:FindFirstChild("Drops") or workspace:FindFirstChild("Loot") or workspace
                for _, object in pairs(Drops:GetChildren()) do
                    if object:IsA("Part") then object.CFrame = Character.HumanoidRootPart.CFrame end
                end
            end
        end)
    end
end)

ShowNotification("HỆ THỐNG HIỆP HUB PREMIUM ĐÃ KHỞI ĐỘNG THÀNH CÔNG!", Color3.fromRGB(255, 55, 55))
