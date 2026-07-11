-- noclip_module.lua - Module NoClip cho AOT Revolution
local NoClipModule = {}
NoClipModule.__index = NoClipModule

function NoClipModule.new(memoryHandler)
    local self = setmetatable({}, NoClipModule)
    self.memory = memoryHandler
    self.enabled = false
    self.noclipConnection = nil
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    return self
end

function NoClipModule:initialize()
    print("[*] NoClip Module initialized")
    return true
end

function NoClipModule:setEnabled(enabled)
    if enabled ~= self.enabled then
        self:toggle()
    end
end

function NoClipModule:enableNoClip()
    self.noclipConnection = self.RunService.Stepped:Connect(function()
        local character = self.memory:getLocalCharacter()
        if not character then return end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end)
end

function NoClipModule:disableNoClip()
    if self.noclipConnection then
        self.noclipConnection:Disconnect()
        self.noclipConnection = nil
    end
    local character = self.memory:getLocalCharacter()
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

function NoClipModule:toggle()
    self.enabled = not self.enabled
    if self.enabled then
        self:enableNoClip()
    else
        self:disableNoClip()
    end
    print("[*] NoClip " .. (self.enabled and "enabled" or "disabled"))
end

function NoClipModule:update()
    if not self.enabled then return end
end

function NoClipModule:shutdown()
    self.enabled = false
    self:disableNoClip()
end

return NoClipModule