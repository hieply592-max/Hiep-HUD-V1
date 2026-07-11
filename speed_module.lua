-- speed_module.lua - Module Speed Hack cho AOT Revolution
local SpeedModule = {}
SpeedModule.__index = SpeedModule

function SpeedModule.new(memoryHandler)
    local self = setmetatable({}, SpeedModule)
    self.memory = memoryHandler
    self.enabled = false
    self.multiplier = 1.5
    self.defaultWalkSpeed = 16
    self.defaultJumpPower = 50
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    return self
end

function SpeedModule:initialize()
    print("[*] Speed Module initialized")
    local character = self.memory:getLocalCharacter()
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            self.defaultWalkSpeed = humanoid.WalkSpeed
            self.defaultJumpPower = humanoid.JumpPower
        end
    end
    return true
end

function SpeedModule:setMultiplier(mult)
    self.multiplier = math.max(1, math.min(mult, 50))
end

function SpeedModule:applySpeed()
    local character = self.memory:getLocalCharacter()
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    if self.enabled then
        humanoid.WalkSpeed = self.defaultWalkSpeed * self.multiplier
        humanoid.JumpPower = self.defaultJumpPower * self.multiplier
    else
        humanoid.WalkSpeed = self.defaultWalkSpeed
        humanoid.JumpPower = self.defaultJumpPower
    end
end

function SpeedModule:toggle()
    self.enabled = not self.enabled
    self:applySpeed()
    print("[*] Speed Hack " .. (self.enabled and "enabled" or "disabled"))
end

function SpeedModule:update()
    self:applySpeed()
end

function SpeedModule:shutdown()
    self.enabled = false
    self:applySpeed()
end

return SpeedModule