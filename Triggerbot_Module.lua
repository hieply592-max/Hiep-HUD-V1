-- triggerbot_module.lua - Module Triggerbot cho AOT Revolution
local TriggerbotModule = {}
TriggerbotModule.__index = TriggerbotModule

function TriggerbotModule.new(memoryHandler)
    local self = setmetatable({}, TriggerbotModule)
    self.memory = memoryHandler
    self.enabled = false
    self.delay = 50
    self.lastFireTime = 0
    self.teamCheck = true
    self.visibilityCheck = true
    self.autoReload = true
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.UserInputService = game:GetService("UserInputService")
    return self
end

function TriggerbotModule:initialize()
    print("[*] Triggerbot Module initialized")
    return true
end

function TriggerbotModule:setDelay(delay)
    self.delay = delay
end

function TriggerbotModule:getCurrentTarget()
    local localPlayer = self.Players.LocalPlayer
    if not localPlayer then return nil end
    local mouse = localPlayer:GetMouse()
    if not mouse then return nil end
    local target = mouse.Target
    if not target then return nil end
    local character = target.Parent
    if not character then return nil end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return nil end
    local player = self.Players:GetPlayerFromCharacter(character)
    if player then
        if self.teamCheck and player.Team == localPlayer.Team then
            return nil
        end
        if self.visibilityCheck and not self.memory:isVisible(character:FindFirstChild("Head") and character.Head.Position) then
            return nil
        end
        return {type = "Player", character = character, humanoid = humanoid, player = player}
    end
    if character.Name:lower():find("titan") or character.Name:lower():find("npc") then
        return {type = "NPC", character = character, humanoid = humanoid}
    end
    return nil
end

function TriggerbotModule:fire()
    local localPlayer = self.Players.LocalPlayer
    if not localPlayer or not localPlayer.Character then return end
    local character = localPlayer.Character
    local tool = nil
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Tool") and child:FindFirstChild("Handle") then
            tool = child
            break
        end
    end
    if not tool then return end
    if tool:FindFirstChild("Remote") then
        pcall(function()
            tool.Remote:FireServer()
        end)
    elseif tool:FindFirstChild("Activate") then
        pcall(function()
            tool:Activate()
        end)
    else
        pcall(function()
            local args = {
                [1] = "Fire",
                [2] = character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.Position
            }
            game:GetService("ReplicatedStorage"):FindFirstChild("WeaponEvent"):FireServer(unpack(args))
        end)
    end
end

function TriggerbotModule:toggle()
    self.enabled = not self.enabled
    print("[*] Triggerbot " .. (self.enabled and "enabled" or "disabled"))
end

function TriggerbotModule:update()
    if not self.enabled then return end
    if tick() - self.lastFireTime < self.delay / 1000 then return end
    local target = self:getCurrentTarget()
    if target and self.UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        self:fire()
        self.lastFireTime = tick()
    end
end

function TriggerbotModule:shutdown()
    self.enabled = false
end

return TriggerbotModule