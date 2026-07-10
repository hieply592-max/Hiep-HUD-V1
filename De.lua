-- ==========================================
-- CẤU HÌNH THỜI GIAN VÀ KEY
-- ==========================================
-- Mốc thời gian bắt đầu (Tính từ lúc bạn chạy script này lần đầu)
local START_TIME = 1783658400 
local DURATION = 10 * 3600    -- Thời hạn 10 tiếng (tính bằng giây)

local KEY_1 = "11223344"
local KEY_2 = "556677"
local KEY_BACKUP = "99887766" -- Key dự phòng vô thời hạn

local FILE_NAME = "MistHub_KeyAuth.txt"

-- URL Script mới của bạn (Có thêm mã ngẫu nhiên để tránh bị lỗi load 20% do cache)
local MAIN_SCRIPT_URL = "https://raw.githubusercontent.com/hieply592-max/Hiep-HUD-V1/refs/heads/main/De.lua?" .. math.random(1, 99999)

-- ==========================================
-- HÀM KÍCH HOẠT SCRIPT CHÍNH & TỰ ĐỘNG LƯU KHI CHUYỂN SV
-- ==========================================
local function runMainScript()
    -- 1. Chạy script chính ở server hiện tại
    pcall(function()
        loadstring(game:HttpGet(MAIN_SCRIPT_URL, true))()
    end)
    
    -- 2. Tự động kích hoạt lại chính nó khi người chơi chuyển Server (Teleport)
    local queue_teleport = queue_on_teleport or (syn and syn.queue_on_teleport)
    if queue_teleport then
        local currentScriptContent = [[
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/hieply592-max/Hiep-HUD-V1/refs/heads/main/De.lua?" .. math.random(1, 99999), true))()
            end)
            
            -- Tiếp tục xếp hàng cho các lần đổi server tiếp theo (Vòng lặp vô hạn)
            local q = queue_on_teleport or (syn and syn.queue_on_teleport)
            if q then 
                q(string.format("loadstring(game:HttpGet('%s', true))()", "https://raw.githubusercontent.com/hieply592-max/Hiep-HUD-V1/refs/heads/main/De.lua")) 
            end
        ]]
        
        game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
            if State == Enum.TeleportState.Started or State == Enum.TeleportState.InProgress then
                queue_teleport(currentScriptContent)
            end
        end)
    end
end

-- ==========================================
-- HÀM KIỂM TRA KEY THEO THỜI GIAN
-- ==========================================
local function getCurrentKey()
    local currentTime = os.time()
    if currentTime - START_TIME < DURATION then
        return KEY_1
    else
        return KEY_2
    end
end

-- ==========================================
-- KIỂM TRA LƯU TRỮ (AUTO LOG-IN KHÔNG CẦN NHẬP LẠI)
-- ==========================================
if readfile and isfile and isfile(FILE_NAME) then
    local savedData = readfile(FILE_NAME)
    local currentKey = getCurrentKey()
    
    -- Nếu đã nhập đúng Key dự phòng HOẶC Key thường vẫn còn trong hạn 10 tiếng -> Tự chạy thẳng luôn
    if savedData == KEY_BACKUP or (savedData == currentKey and (os.time() - START_TIME) < DURATION) then
        runMainScript()
        return
    end
end

-- ==========================================
-- GIAO DIỆN NHẬP KEY (UI)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local Title = Instance.new("TextLabel")

ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

MainFrame.Name = "KeySystem"
MainFrame.Size = UDim2.new(0, 320, 0, 140)
MainFrame.Position = UDim2.new(0.5, -160, 0.4, -70)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local c1 = Instance.new("UICorner") c1.CornerRadius = UDim.new(0, 8) c1.Parent = MainFrame
local s1 = Instance.new("UIStroke") s1.Color = Color3.fromRGB(85, 170, 255) s1.Thickness = 1.5 s1.Parent = MainFrame

Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "MIST HUB - NHẬP KEY"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

TextBox.Size = UDim2.new(0.85, 0, 0, 40)
TextBox.Position = UDim2.new(0.075, 0, 0.5, -5)
TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Nhập Key vào đây rồi nhấn ENTER..."
TextBox.Font = Enum.Font.SourceSans
TextBox.TextSize = 16
TextBox.Text = ""
TextBox.Parent = MainFrame
local c2 = Instance.new("UICorner") c2.CornerRadius = UDim.new(0, 6) c2.Parent = TextBox

-- XỬ LÝ SỰ KIỆN NHẬP KEY
TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local userInput = TextBox.Text
        local currentKey = getCurrentKey()
        
        if userInput == currentKey or userInput == KEY_BACKUP then
            Title.Text = "KEY ĐÚNG! ĐANG TẢI SCRIPT..."
            Title.TextColor3 = Color3.fromRGB(0, 255, 127)
            
            if writefile then
                writefile(FILE_NAME, userInput)
            end
            
            task.wait(1)
            ScreenGui:Destroy()
            runMainScript()
        else
            Title.Text = "SAI KEY HOẶC KEY ĐÃ HẾT HẠN!"
            Title.TextColor3 = Color3.fromRGB(255, 65, 65)
            TextBox.Text = ""
            task.wait(2)
            Title.Text = "MIST HUB - NHẬP KEY"
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
end)
