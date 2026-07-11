-- god_mode.lua - Module God Mode cho AOT Revolution
local GodModeModule = {}
GodModeModule.__index = GodModeModule

function GodModeModule.new(memoryHandler)
    local self = setmetatable({}, GodModeModule)
    self.memory = memoryHandler
    self.enabled = false
    self.invincible = false
    self.healthLock = 99999
    self.regenSpeed = 100
    self.regenEnabled = true
    self.godConnection = nil
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    return self
end

function GodModeModule:initialize()
    print("[*] God Mode Module initialized")
    return true
end

function GodModeModule:setInvincible(invincible)
    self.invincible = invincible
end

function GodModeModule:enableGodMode()
    self.godConnection = self.RunService.Heartbeat:Connect(function()
        local character = self.memory:getLocalCharacter()
        if not character then return end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        if self.invincible then
            humanoid.MaxHealth = self.healthLock
            humanoid.Health = self.healthLock
            humanoid.BreakJointsOnDeath = false
            humanoid.RequiresNeck = false
        end
        if self.regenEnabled then
            if humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = math.min(humanoid.Health + self.regenSpeed * 0.01, humanoid.MaxHealth)
            end
        end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                if part.Name == "Head" or part.Name == "HumanoidRootPart" or part.Name == "UpperTorso" then
                    if self.invincible then
                        part.CanCollide = false
                    end
                end
            end
        end
        if humanoid.Health <= 0 and self.invincible then
            humanoid.Health = self.healthLock
            humanoid.MaxHealth = self.healthLock
        end
    end)
end

function GodModeModule:disableGodMode()
    if self.godConnection then
        self.godConnection:Disconnect()
        self.godConnection = nil
    end
    local character = self.memory:getLocalCharacter()
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.BreakJointsOnDeath = true
            humanoid.RequiresNeck = true
        end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

function GodModeModule:toggle()
    self.enabled = not self.enabled
    if self.enabled then
        self.invincible = true
        self:enableGodMode()
    else
        self.invincible = false
        self:disableGodMode()
    end
    print("[*] God Mode " .. (self.enabled and "enabled" or "disabled"))
end

function GodModeModule:update()
    if not self.enabled then return end
end

function GodModeModule:shutdown()
    self.enabled = false
    self:disableGodMode()
end

return GodModeModule