-- infinite_skills.lua - Module Infinite Skills/No Cooldown cho AOT Revolution
local InfiniteSkillsModule = {}
InfiniteSkillsModule.__index = InfiniteSkillsModule

function InfiniteSkillsModule.new(memoryHandler)
    local self = setmetatable({}, InfiniteSkillsModule)
    self.memory = memoryHandler
    self.enabled = false
    self.noCooldown = true
    self.infiniteGas = true
    self.infiniteBlades = true
    self.maxSkillLevel = true
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.UserInputService = game:GetService("UserInputService")
    return self
end

function InfiniteSkillsModule:initialize()
    print("[*] Infinite Skills Module initialized")
    return true
end

function InfiniteSkillsModule:setNoCooldown(enabled)
    self.noCooldown = enabled
end

function InfiniteSkillsModule:applyInfiniteSkills()
    local character = self.memory:getLocalCharacter()
    if not character then return end
    if self.noCooldown then
        for _, child in ipairs(character:GetDescendants()) do
            if child:IsA("Script") or child:IsA("LocalScript") then
                pcall(function()
                    local cooldown = child:FindFirstChild("Cooldown") or child:FindFirstChild("cooldown")
                    if cooldown then
                        cooldown.Value = 0
                    end
                end)
            end
        end
        local player = self.Players.LocalPlayer
        if player then
            local playerScripts = player:FindFirstChild("PlayerScripts")
            if playerScripts then
                for _, script in ipairs(playerScripts:GetDescendants()) do
                    pcall(function()
                        local cooldown = script:FindFirstChild("Cooldown") or script:FindFirstChild("cooldown")
                        if cooldown then
                            cooldown.Value = 0
                        end
                    end)
                end
            end
        end
    end
    if self.infiniteGas then
        pcall(function()
            local gasValue = character:FindFirstChild("Gas") or character:FindFirstChild("gas")
            if not gasValue then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    gasValue = humanoid:FindFirstChild("Gas") or humanoid:FindFirstChild("gas")
                end
            end
            if gasValue and gasValue:IsA("NumberValue") or gasValue:IsA("IntValue") then
                gasValue.Value = gasValue:IsA("NumberValue") and 99999 or 100
            end
        end)
    end
    if self.infiniteBlades then
        pcall(function()
            local bladeDurability = character:FindFirstChild("BladeDurability") or character:FindFirstChild("bladeDurability")
            if bladeDurability and (bladeDurability:IsA("NumberValue") or bladeDurability:IsA("IntValue")) then
                bladeDurability.Value = bladeDurability:IsA("NumberValue") and 99999 or 100
            end
        end)
    end
    if self.maxSkillLevel then
        pcall(function()
            local player = self.Players.LocalPlayer
            if player then
                local skills = player:FindFirstChild("Skills") or player:FindFirstChild("skills")
                if skills then
                    for _, skill in ipairs(skills:GetChildren()) do
                        if skill:IsA("NumberValue") or skill:IsA("IntValue") then
                            skill.Value = 999
                        end
                    end
                end
            end
        end)
    end
end

function InfiniteSkillsModule:toggle()
    self.enabled = not self.enabled
    print("[*] Infinite Skills " .. (self.enabled and "enabled" or "disabled"))
end

function InfiniteSkillsModule:update()
    if not self.enabled then return end
    self:applyInfiniteSkills()
end

function InfiniteSkillsModule:shutdown()
    self.enabled = false
end

return InfiniteSkillsModule