-- camera_hack.lua - Module Camera Hack cho AOT Revolution
local CameraHackModule = {}
CameraHackModule.__index = CameraHackModule

function CameraHackModule.new(memoryHandler)
    local self = setmetatable({}, CameraHackModule)
    self.memory = memoryHandler
    self.enabled = false
    self.customFOV = 90
    self.defaultFOV = 70
    self.freecamEnabled = false
    self.freecamSpeed = 20
    self.freecamConnection = nil
    self.zoomEnabled = false
    self.zoomLevel = 1.0
    self.shakeEnabled = true
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.UserInputService = game:GetService("UserInputService")
    return self
end

function CameraHackModule:initialize()
    print("[*] Camera Hack Module initialized")
    local camera = workspace.CurrentCamera
    if camera then
        self.defaultFOV = camera.FieldOfView
    end
    return true
end

function CameraHackModule:setFOV(fov)
    self.customFOV = math.clamp(fov, 30, 150)
end

function CameraHackModule:applyFOV()
    local camera = workspace.CurrentCamera
    if not camera then return end
    if self.enabled then
        camera.FieldOfView = self.customFOV
    else
        camera.FieldOfView = self.defaultFOV
    end
end

function CameraHackModule:enableFreecam()
    local camera = workspace.CurrentCamera
    if not camera then return end
    local player = self.Players.LocalPlayer
    if not player then return end
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
        end
    end
    camera.CameraType = Enum.CameraType.Scriptable
    self.freecamConnection = self.RunService.RenderStepped:Connect(function(deltaTime)
        if not self.freecamEnabled then return end
        local moveVector = Vector3.new(0, 0, 0)
        if self.UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveVector = moveVector + camera.CFrame.LookVector
        end
        if self.UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveVector = moveVector - camera.CFrame.LookVector
        end
        if self.UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveVector = moveVector - camera.CFrame.RightVector
        end
        if self.UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveVector = moveVector + camera.CFrame.RightVector
        end
        if self.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveVector = moveVector + Vector3.new(0, 1, 0)
        end
        if self.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveVector = moveVector - Vector3.new(0, 1, 0)
        end
        if moveVector.Magnitude > 0 then
            moveVector = moveVector.Unit
        end
        camera.CFrame = camera.CFrame + (moveVector * self.freecamSpeed * deltaTime * 60)
        local mouseDelta = self.UserInputService:GetMouseDelta()
        if mouseDelta.Magnitude > 0 then
            local sensitivity = 0.5
            local rotationX = -mouseDelta.Y * sensitivity * deltaTime
            local rotationY = -mouseDelta.X * sensitivity * deltaTime
            camera.CFrame = camera.CFrame * CFrame.Angles(rotationX, rotationY, 0)
        end
    end)
end

function CameraHackModule:disableFreecam()
    if self.freecamConnection then
        self.freecamConnection:Disconnect()
        self.freecamConnection = nil
    end
    local camera = workspace.CurrentCamera
    if camera then
        camera.CameraType = Enum.CameraType.Custom
    end
    local player = self.Players.LocalPlayer
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
    end
end

function CameraHackModule:applyZoom()
    local camera = workspace.CurrentCamera
    if not camera then return end
    if self.zoomEnabled then
        local player = self.Players.LocalPlayer
        if player and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local zoomDirection = (head.Position - camera.CFrame.Position).Unit
                local zoomDistance = 10 / self.zoomLevel
                camera.CFrame = CFrame.new(head.Position - zoomDirection * zoomDistance, head.Position)
            end
        end
    end
end

function CameraHackModule:toggle()
    self.enabled = not self.enabled
    self:applyFOV()
    print("[*] Camera Hack " .. (self.enabled and "enabled" or "disabled"))
end

function CameraHackModule:toggleFreecam()
    self.freecamEnabled = not self.freecamEnabled
    if self.freecamEnabled then
        self:enableFreecam()
    else
        self:disableFreecam()
    end
    print("[*] Freecam " .. (self.freecamEnabled and "enabled" or "disabled"))
end

function CameraHackModule:toggleZoom()
    self.zoomEnabled = not self.zoomEnabled
    print("[*] Zoom " .. (self.zoomEnabled and "enabled" or "disabled"))
end

function CameraHackModule:update()
    if self.enabled then
        self:applyFOV()
    end
    if self.zoomEnabled then
        self:applyZoom()
    end
end

function CameraHackModule:shutdown()
    self.enabled = false
    self.freecamEnabled = false
    self.zoomEnabled = false
    self:applyFOV()
    self:disableFreecam()
end

return CameraHackModule