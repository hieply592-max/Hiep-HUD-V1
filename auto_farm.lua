-- auto_farm.lua - Module Auto Farm cho AOT Revolution
local AutoFarmModule = {}
AutoFarmModule.__index = AutoFarmModule

function AutoFarmModule.new(memoryHandler)
    local self = setmetatable({}, AutoFarmModule)
    self.memory = memoryHandler
    self.enabled = false
    self.farmMode = "auto"
    self.farmRange = 500
    self.attackRange = 20
    self.farmDelay = 0.5
    self.lastFarmTime = 0
    self.killCount = 0
    self.goldCount = 0
    self.expCount = 0
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.Workspace = game:GetService("Workspace")
    return self
end

function AutoFarmModule:initialize()
    print("[*] Auto Farm Module initialized")
    return true
end

function AutoFarmModule:setFarmMode(mode)
    self.farmMode = mode
end

function AutoFarmModule:getNearestFarmTarget()
    local localRoot = self.memory:getLocalRootPart()
    if not localRoot then return nil end
    local nearest = nil
    local nearestDist = math.huge
    local npcs = self.memory:getNPCsInRadius(self.farmRange)
    for _, npc in ipairs(npcs) do
        if npc.humanoid and npc.humanoid.Health > 0 and npc.rootPart then
            local dist = (npc.rootPart.Position - localRoot.Position).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = npc
            end
        end
    end
    return nearest
end

function AutoFarmModule:attackTarget(target)
    if not target then return false end
    local character = self.memory:getLocalCharacter()
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    local tool = nil
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Tool") and child:FindFirstChild("Handle") then
            tool = child
            break
        end
    end
    if not tool then
        local backpack = self.Players.LocalPlayer:FindFirstChild("Backpack")
        if backpack then
            for _, child in ipairs(backpack:GetChildren()) do
                if child:IsA("Tool") and child:FindFirstChild("Handle") then
                    humanoid:EquipTool(child)
                    task.wait(0.2)
                    tool = child
                    break
                end
            end
        end
    end
    if not tool then return false end
    pcall(function()
        if tool:FindFirstChild("Remote") then
            tool.Remote:FireServer(target.rootPart.Position)
        elseif tool:FindFirstChild("Activate") then
            tool:Activate()
        else
            local args = {[1] = "Attack", [2] = target.rootPart.Position, [3] = target.humanoid}
            for _, remote in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if remote:IsA("RemoteEvent") and remote.Name:find("Attack") then
                    remote:FireServer(unpack(args))
                    break
                end
            end
        end
    end)
    return true
end

function AutoFarmModule:moveToTarget(target)
    local character = self.memory:getLocalCharacter()
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    if target and target.rootPart then
        local distance = (character.HumanoidRootPart.Position - target.rootPart.Position).Magnitude
        if distance > self.attackRange then
            humanoid:MoveTo(target.rootPart.Position)
            return true
        end
    end
    return false
end

function AutoFarmModule:collectLoot()
    local localRoot = self.memory:getLocalRootPart()
    if not localRoot then return end
    local items = {}
    for _, object in ipairs(self.Workspace:GetDescendants()) do
        if object:IsA("BasePart") and (object:GetAttribute("IsLootable") or object.Name:find("Gold") or object.Name:find("Coin")) then
            local dist = (object.Position - localRoot.Position).Magnitude
            if dist <= 50 then
                table.insert(items, object)
            end
        end
    end
    for _, item in ipairs(items) do
        pcall(function()
            firetouchinterest(localRoot, item, 0)
            task.wait(0.05)
            firetouchinterest(localRoot, item, 1)
        end)
    end
end

function AutoFarmModule:toggle()
    self.enabled = not self.enabled
    print("[*] Auto Farm " .. (self.enabled and "enabled" or "disabled"))
end

function AutoFarmModule:update()
    if not self.enabled then return end
    if tick() - self.lastFarmTime < self.farmDelay then return end
    self.lastFarmTime = tick()
    if self.farmMode == "auto" or self.farmMode == "combat" then
        local target = self:getNearestFarmTarget()
        if target then
            local distance = (self.memory:getLocalRootPart().Position - target.rootPart.Position).Magnitude
            if distance > self.attackRange then
                self:moveToTarget(target)
            else
                self:attackTarget(target)
            end
        end
    end
    if self.farmMode == "auto" or self.farmMode == "loot" then
        self:collectLoot()
    end
end

function AutoFarmModule:shutdown()
    self.enabled = false
end

return AutoFarmModule