-- fly_module.lua - Module Fly cho AOT Revolution
local FlyModule = {}
FlyModule.__index = FlyModule

function FlyModule.new(memoryHandler)
    local self = setmetatable({}, FlyModule)
    self.memory = memoryHandler
    self.enabled = false
    self.speed = 10
    self.verticalSpeed = 0
    self.maxVerticalSpeed = 50
    self.bodyVelocity = nil
    self.bodyGyro = nil
    self.flyConnection = nil
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.UserInputService = game:GetService("UserInputService")
    return self
end

function FlyModule:initialize()
    print("[*] Fly Module initialized")
    return true
end

function FlyModule:setSpeed(speed)
    self.speed = speed
end

function FlyModule:startFlying()
    local character = self.memory:getLocalCharacter()
    if not character then return false end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    humanoid.PlatformStand = true
    if not rootPart:FindFirstChild("FlyVelocity") then
        self.bodyVelocity = Instance.new("BodyVelocity")
        self.bodyVelocity.Name = "FlyVelocity"
        self.bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
        self.bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        self.bodyVelocity.Parent = rootPart
    else
        self.bodyVelocity = rootPart:FindFirstChild("FlyVelocity")
    end
    if not rootPart:FindFirstChild("FlyGyro") then
        self.bodyGyro = Instance.new("BodyGyro")
        self.bodyGyro.Name = "FlyGyro"
        self.bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
        self.bodyGyro.CFrame = rootPart.CFrame
        self.bodyGyro.Parent = rootPart
    else
        self.bodyGyro = rootPart:FindFirstChild("FlyGyro")
    end
    self.flyConnection = self.RunService.Stepped:Connect(function()
        if not self.enabled then return end
        local camera = workspace.CurrentCamera
        if not camera then return end
        local moveDirection = Vector3.new(0, 0, 0)
        if self.UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + camera.CFrame.LookVector
        end
        if self.UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - camera.CFrame.LookVector
        end
        if self.UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - camera.CFrame.RightVector
        end
        if self.UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + camera.CFrame.RightVector
        end
        if self.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            self.verticalSpeed = math.min(self.verticalSpeed + 1, self.maxVerticalSpeed)
        elseif self.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            self.verticalSpeed = math.max(self.verticalSpeed - 1, -self.maxVerticalSpeed)
        else
            self.verticalSpeed = 0
        end
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
        end
        local horizontalVelocity = moveDirection * self.speed
        local verticalVelocity = Vector3.new(0, self.verticalSpeed, 0)
        if self.bodyVelocity then
            self.bodyVelocity.Velocity = horizontalVelocity + verticalVelocity
        end
        if self.bodyGyro then
            self.bodyGyro.CFrame = camera.CFrame
        end
    end)
    return true
end

function FlyModule:stopFlying()
    if self.flyConnection then
        self.flyConnection:Disconnect()
        self.flyConnection = nil
    end
    local character = self.memory:getLocalCharacter()
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            if rootPart:FindFirstChild("FlyVelocity") then
                rootPart.FlyVelocity:Destroy()
            end
            if rootPart:FindFirstChild("FlyGyro") then
                rootPart.FlyGyro:Destroy()
            end
        end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
    self.bodyVelocity = nil
    self.bodyGyro = nil
end

function FlyModule:toggle()
    self.enabled = not self.enabled
    if self.enabled then
        self:startFlying()
    else
        self:stopFlying()
    end
    print("[*] Fly " .. (self.enabled and "enabled" or "disabled"))
end

function FlyModule:update()
    if not self.enabled then return end
end

function FlyModule:shutdown()
    self.enabled = false
    self:stopFlying()
end

return FlyModule