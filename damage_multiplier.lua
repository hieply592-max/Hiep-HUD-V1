-- damage_multiplier.lua - Module Damage Multiplier cho AOT Revolution
local DamageMultiplierModule = {}
DamageMultiplierModule.__index = DamageMultiplierModule

function DamageMultiplierModule.new(memoryHandler)
    local self = setmetatable({}, DamageMultiplierModule)
    self.memory = memoryHandler
    self.enabled = false
    self.multiplier = 1.0
    self.oneHitKill = false
    self.critChance = 0
    self.critMultiplier = 2.0
    self.ignoreDefense = false
    self.damageConnection = nil
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    return self
end

function DamageMultiplierModule:initialize()
    print("[*] Damage Multiplier Module initialized")
    self:setupDamageHook()
    return true
end

function DamageMultiplierModule:setMultiplier(mult)
    self.multiplier = math.max(0.1, math.min(mult, 1000))
end

function DamageMultiplierModule:setupDamageHook()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "TakeDamage" or method == "Damage" then
            if self.enabled then
                local damage = args[1] or 0
                if type(damage) == "number" then
                    if self.oneHitKill then
                        damage = 999999
                    else
                        damage = damage * self.multiplier
                    end
                    if self.critChance > 0 and math.random() < self.critChance then
                        damage = damage * self.critMultiplier
                    end
                end
                args[1] = damage
            end
        end
        if method == "FireServer" or method == "InvokeServer" then
            if self.enabled and tostring(self):find("Damage") then
                if self.oneHitKill then
                    args[1] = 999999
                elseif type(args[1]) == "number" then
                    args[1] = args[1] * self.multiplier
                end
            end
        end
        return oldNamecall(self, unpack(args))
    end)
    self.damageConnection = oldNamecall
end

function DamageMultiplierModule:setOneHitKill(enabled)
    self.oneHitKill = enabled
end

function DamageMultiplierModule:toggle()
    self.enabled = not self.enabled
    print("[*] Damage Multiplier " .. (self.enabled and "enabled" or "disabled"))
end

function DamageMultiplierModule:toggleOneHitKill()
    self.oneHitKill = not self.oneHitKill
    if self.oneHitKill then self.enabled = true end
    print("[*] One Hit Kill " .. (self.oneHitKill and "enabled" or "disabled"))
end

function DamageMultiplierModule:update()
    if not self.enabled then return end
end

function DamageMultiplierModule:shutdown()
    self.enabled = false
    self.oneHitKill = false
end

return DamageMultiplierModule