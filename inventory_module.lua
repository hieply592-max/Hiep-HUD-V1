-- inventory_module.lua - Module Inventory/Item cho AOT Revolution
local InventoryModule = {}
InventoryModule.__index = InventoryModule

function InventoryModule.new(memoryHandler)
    local self = setmetatable({}, InventoryModule)
    self.memory = memoryHandler
    self.autoLoot = false
    self.lootRange = 50
    self.autoEquip = false
    self.autoSell = false
    self.whitelistItems = {}
    self.blacklistItems = {}
    self.lootCooldown = 0.5
    self.lastLootTime = 0
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.Workspace = game:GetService("Workspace")
    return self
end

function InventoryModule:initialize()
    print("[*] Inventory Module initialized")
    return true
end

function InventoryModule:setAutoLoot(enabled)
    self.autoLoot = enabled
end

function InventoryModule:setLootRange(range)
    self.lootRange = range
end

function InventoryModule:getNearbyItems()
    local items = {}
    local localRoot = self.memory:getLocalRootPart()
    if not localRoot then return items end
    for _, object in ipairs(self.Workspace:GetDescendants()) do
        if object:IsA("BasePart") and object:GetAttribute("IsLootable") then
            local distance = (object.Position - localRoot.Position).Magnitude
            if distance <= self.lootRange then
                table.insert(items, {
                    object = object,
                    position = object.Position,
                    distance = distance,
                    name = object.Name
                })
            end
        end
    end
    for _, object in ipairs(self.Workspace:GetDescendants()) do
        if object:IsA("Tool") or object:IsA("Model") then
            if object:FindFirstChild("Handle") then
                local handle = object.Handle
                local distance = (handle.Position - localRoot.Position).Magnitude
                if distance <= self.lootRange then
                    table.insert(items, {
                        object = object,
                        position = handle.Position,
                        distance = distance,
                        name = object.Name
                    })
                end
            end
        end
    end
    table.sort(items, function(a, b) return a.distance < b.distance end)
    return items
end

function InventoryModule:pickupItem(item)
    if not item or not item.object then return false end
    local localPlayer = self.Players.LocalPlayer
    if not localPlayer then return false end
    local character = localPlayer.Character
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    local success, err = pcall(function()
        if item.object:IsA("BasePart") then
            firetouchinterest(rootPart, item.object, 0)
            task.wait(0.05)
            firetouchinterest(rootPart, item.object, 1)
        elseif item.object:IsA("Tool") then
            item.object.Parent = character
        end
    end)
    return success
end

function InventoryModule:getInventory()
    local localPlayer = self.Players.LocalPlayer
    if not localPlayer then return {} end
    local inventory = {}
    local backpack = localPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            table.insert(inventory, {
                name = tool.Name,
                object = tool,
                type = "Tool",
                equipped = false
            })
        end
    end
    local character = localPlayer.Character
    if character then
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                table.insert(inventory, {
                    name = tool.Name,
                    object = tool,
                    type = "Tool",
                    equipped = true
                })
            end
        end
    end
    return inventory
end

function InventoryModule:equipBestTool()
    local inventory = self:getInventory()
    local bestTool = nil
    local bestDamage = 0
    for _, item in ipairs(inventory) do
        if item.type == "Tool" and not item.equipped then
            local damage = item.object:GetAttribute("Damage") or 0
            if damage > bestDamage then
                bestDamage = damage
                bestTool = item
            end
        end
    end
    if bestTool then
        local localPlayer = self.Players.LocalPlayer
        if localPlayer and localPlayer.Character then
            local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:EquipTool(bestTool.object)
                return true
            end
        end
    end
    return false
end

function InventoryModule:toggleAutoLoot()
    self.autoLoot = not self.autoLoot
    print("[*] Auto Loot " .. (self.autoLoot and "enabled" or "disabled"))
end

function InventoryModule:update()
    if not self.autoLoot then return end
    if tick() - self.lastLootTime < self.lootCooldown then return end
    self.lastLootTime = tick()
    local items = self:getNearbyItems()
    for _, item in ipairs(items) do
        local success = self:pickupItem(item)
        if success then break end
    end
end

function InventoryModule:shutdown()
    self.autoLoot = false
end

return InventoryModule