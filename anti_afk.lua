-- anti_afk.lua - Module Anti AFK cho AOT Revolution
local AntiAFKModule = {}
AntiAFKModule.__index = AntiAFKModule

function AntiAFKModule.new()
    local self = setmetatable({}, AntiAFKModule)
    self.enabled = false
    self.afkConnection = nil
    self.afkTimer = 0
    self.maxAfkTime = 1200
    self.lastActionTime = tick()
    self.antiAfkMethods = {
        "Jump",
        "Move",
        "Chat",
        "Camera"
    }
    self.currentMethod = "Jump"
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.UserInputService = game:GetService("UserInputService")
    self.VirtualUser = game:GetService("VirtualUser")
    return self
end

function AntiAFKModule:initialize()
    print("[*] Anti AFK Module initialized")
    self:setupAntiAFK()
    return true
end

function AntiAFKModule:setEnabled(enabled)
    if enabled ~= self.enabled then
        self:toggle()
    end
end

function AntiAFKModule:setupAntiAFK()
    self.Players.LocalPlayer.Idled:Connect(function()
        if self.enabled then
            self.VirtualUser:CaptureController()
            self.VirtualUser:ClickButton2(Vector2.new(0, 0))
        end
    end)
    self.afkConnection = self.RunService.Heartbeat:Connect(function()
        if not self.enabled then return end
        self.afkTimer = self.afkTimer + 0.1
        if self.afkTimer >= self.maxAfkTime then
            self.afkTimer = 0
            self:performAntiAFKAction()
        end
        local character = self.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local velocity = character.HumanoidRootPart.Velocity
            if velocity.Magnitude > 0.1 then
                self.lastActionTime = tick()
                self.afkTimer = 0
            end
        end
        if self.UserInputService:IsKeyDown(Enum.KeyCode.W) or
           self.UserInputService:IsKeyDown(Enum.KeyCode.A) or
           self.UserInputService:IsKeyDown(Enum.KeyCode.S) or
           self.UserInputService:IsKeyDown(Enum.KeyCode.D) or
           self.UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            self.lastActionTime = tick()
            self.afkTimer = 0
        end
    end)
end

function AntiAFKModule:performAntiAFKAction()
    local character = self.Players.LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    if self.currentMethod == "Jump" then
        humanoid.Jump = true
        task.wait(0.5)
        humanoid.Jump = false
        self.currentMethod = "Move"
    elseif self.currentMethod == "Move" then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local randomDirection = Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
            humanoid:MoveTo(rootPart.Position + randomDirection)
            task.wait(2)
            humanoid:MoveTo(rootPart.Position)
        end
        self.currentMethod = "Camera"
    elseif self.currentMethod == "Camera" then
        local camera = workspace.CurrentCamera
        if camera then
            local randomRotation = CFrame.Angles(0, math.random() * math.pi * 2, 0)
            local newLookAt = camera.CFrame * randomRotation
            camera.CFrame = camera.CFrame:Lerp(newLookAt, 0.5)
        end
        self.currentMethod = "Jump"
    end
end

function AntiAFKModule:toggle()
    self.enabled = not self.enabled
    print("[*] Anti AFK " .. (self.enabled and "enabled" or "disabled"))
end

function AntiAFKModule:update()
    if not self.enabled then return end
end

function AntiAFKModule:shutdown()
    self.enabled = false
    if self.afkConnection then
        self.afkConnection:Disconnect()
        self.afkConnection = nil
    end
end

return AntiAFKModule