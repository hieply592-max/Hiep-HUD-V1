-- memory_handler.lua - Module xử lý bộ nhớ cho hack AOT Revolution
local MemoryHandler = {}
MemoryHandler.__index = MemoryHandler

function MemoryHandler.new()
    local self = setmetatable({}, MemoryHandler)
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.HttpService = game:GetService("HttpService")
    self.TeleportService = game:GetService("TeleportService")
    self.entityCache = {}
    self.playerCache = {}
    self.npcCache = {}
    self.objectCache = {}
    self.addressCache = {}
    self.pointerCache = {}
    self.maxCacheAge = 5
    self.lastCacheUpdate = 0
    self.offsets = {
        playerHealth = 0x120, playerMaxHealth = 0x124, playerPosition = 0x130,
        playerVelocity = 0x140, playerRotation = 0x150, playerTeam = 0x110,
        playerName = 0x100, playerAlive = 0x128, npcHealth = 0x200,
        npcMaxHealth = 0x204, npcPosition = 0x210, npcType = 0x1F0,
        npcTarget = 0x220, gameState = 0x500, currentWave = 0x504,
        totalWaves = 0x508, gameTime = 0x50C, inventoryStart = 0x600,
        inventorySize = 0x60, itemID = 0x00, itemAmount = 0x04,
        itemDurability = 0x08, skillCooldown = 0x700, skillLevel = 0x704,
        skillDamage = 0x708, cameraFOV = 0x800, cameraPosition = 0x810, cameraRotation = 0x820
    }
    return self
end

function MemoryHandler:initialize()
    print("[*] Memory Handler initialized")
    self:updateAllAddresses()
    return true
end

function MemoryHandler:updateAllAddresses()
    local LocalPlayer = self.Players.LocalPlayer
    if LocalPlayer then
        self.addressCache.localPlayer = LocalPlayer
        if LocalPlayer.Character then self:updateCharacterAddresses(LocalPlayer.Character) end
    end
    self:updateEntityList()
    self.lastCacheUpdate = tick()
end

function MemoryHandler:updateCharacterAddresses(character)
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart then self.addressCache.rootPart = rootPart end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then self.addressCache.humanoid = humanoid end
    local head = character:FindFirstChild("Head")
    if head then self.addressCache.head = head end
end

function MemoryHandler:updateEntityList()
    local workspace = game:GetService("Workspace")
    self.entityCache = {}
    self.playerCache = {}
    self.npcCache = {}
    for _, player in ipairs(self.Players:GetPlayers()) do
        if player ~= self.Players.LocalPlayer then
            local character = player.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if rootPart and humanoid and humanoid.Health > 0 then
                    table.insert(self.playerCache, {
                        player = player, character = character, rootPart = rootPart,
                        humanoid = humanoid, head = character:FindFirstChild("Head"),
                        team = player.Team, name = player.Name, displayName = player.DisplayName
                    })
                end
            end
        end
    end
    for _, object in ipairs(workspace:GetDescendants()) do
        if object:IsA("Model") and object:FindFirstChild("Humanoid") then
            local npcName = object.Name:lower()
            if npcName:find("titan") or npcName:find("npc") or npcName:find("enemy") or npcName:find("boss") then
                local humanoid = object:FindFirstChild("Humanoid")
                local rootPart = object:FindFirstChild("HumanoidRootPart")
                if humanoid and rootPart and humanoid.Health > 0 then
                    table.insert(self.npcCache, {
                        object = object, rootPart = rootPart, humanoid = humanoid,
                        head = object:FindFirstChild("Head"), name = object.Name,
                        health = humanoid.Health, maxHealth = humanoid.MaxHealth
                    })
                end
            end
        end
    end
end

function MemoryHandler:getLocalPlayer() return self.addressCache.localPlayer end
function MemoryHandler:getLocalCharacter()
    local player = self:getLocalPlayer()
    if player then return player.Character end
    return nil
end
function MemoryHandler:getLocalRootPart()
    local character = self:getLocalCharacter()
    if character then return character:FindFirstChild("HumanoidRootPart") end
    return nil
end
function MemoryHandler:getLocalHumanoid()
    local character = self:getLocalCharacter()
    if character then return character:FindFirstChildOfClass("Humanoid") end
    return nil
end
function MemoryHandler:getAllPlayers() return self.playerCache end
function MemoryHandler:getAllNPCs() return self.npcCache end
function MemoryHandler:getAllEntities()
    local entities = {}
    for _, player in ipairs(self.playerCache) do table.insert(entities, player) end
    for _, npc in ipairs(self.npcCache) do table.insert(entities, npc) end
    return entities
end
function MemoryHandler:getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    local localRoot = self:getLocalRootPart()
    if not localRoot then return nil end
    for _, playerData in ipairs(self.playerCache) do
        if playerData.rootPart then
            local distance = (playerData.rootPart.Position - localRoot.Position).Magnitude
            if distance < closestDistance then closestDistance = distance; closestPlayer = playerData end
        end
    end
    return closestPlayer
end
function MemoryHandler:getClosestNPC()
    local closestNPC = nil
    local closestDistance = math.huge
    local localRoot = self:getLocalRootPart()
    if not localRoot then return nil end
    for _, npcData in ipairs(self.npcCache) do
        if npcData.rootPart then
            local distance = (npcData.rootPart.Position - localRoot.Position).Magnitude
            if distance < closestDistance then closestDistance = distance; closestNPC = npcData end
        end
    end
    return closestNPC
end
function MemoryHandler:getPlayersInRadius(radius)
    local players = {}
    local localRoot = self:getLocalRootPart()
    if not localRoot then return players end
    for _, playerData in ipairs(self.playerCache) do
        if playerData.rootPart then
            local distance = (playerData.rootPart.Position - localRoot.Position).Magnitude
            if distance <= radius then playerData.distance = distance; table.insert(players, playerData) end
        end
    end
    return players
end
function MemoryHandler:getNPCsInRadius(radius)
    local npcs = {}
    local localRoot = self:getLocalRootPart()
    if not localRoot then return npcs end
    for _, npcData in ipairs(self.npcCache) do
        if npcData.rootPart then
            local distance = (npcData.rootPart.Position - localRoot.Position).Magnitude
            if distance <= radius then npcData.distance = distance; table.insert(npcs, npcData) end
        end
    end
    return npcs
end
function MemoryHandler:isAlive(entity)
    if not entity then return false end
    if entity.player then
        local character = entity.player.Character
        if not character then return false end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        return humanoid and humanoid.Health > 0
    end
    if entity.humanoid then return entity.humanoid.Health > 0 end
    return false
end
function MemoryHandler:getHealth(entity)
    if not entity then return 0 end
    if entity.humanoid then return entity.humanoid.Health end
    if entity.player and entity.player.Character then
        local humanoid = entity.player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then return humanoid.Health end
    end
    return 0
end
function MemoryHandler:getMaxHealth(entity)
    if not entity then return 0 end
    if entity.humanoid then return entity.humanoid.MaxHealth end
    if entity.player and entity.player.Character then
        local humanoid = entity.player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then return humanoid.MaxHealth end
    end
    return 0
end
function MemoryHandler:getPosition(entity)
    if not entity then return Vector3.zero end
    if entity.rootPart then return entity.rootPart.Position end
    if entity.character then
        local rootPart = entity.character:FindFirstChild("HumanoidRootPart")
        if rootPart then return rootPart.Position end
    end
    return Vector3.zero
end
function MemoryHandler:getHeadPosition(entity)
    if not entity then return Vector3.zero end
    if entity.head then return entity.head.Position end
    if entity.character then
        local head = entity.character:FindFirstChild("Head")
        if head then return head.Position end
    end
    return self:getPosition(entity) + Vector3.new(0, 2, 0)
end
function MemoryHandler:getVelocity(entity)
    if not entity then return Vector3.zero end
    if entity.rootPart then return entity.rootPart.Velocity end
    if entity.character then
        local rootPart = entity.character:FindFirstChild("HumanoidRootPart")
        if rootPart then return rootPart.Velocity end
    end
    return Vector3.zero
end
function MemoryHandler:getTeam(entity)
    if not entity then return nil end
    if entity.team then return entity.team end
    if entity.player then return entity.player.Team end
    return nil
end
function MemoryHandler:isSameTeam(entity1, entity2)
    if not entity1 or not entity2 then return false end
    local team1 = self:getTeam(entity1)
    local team2 = self:getTeam(entity2)
    return team1 and team2 and team1 == team2
end
function MemoryHandler:isVisible(targetPosition)
    local localRoot = self:getLocalRootPart()
    if not localRoot or not targetPosition then return false end
    local camera = workspace.CurrentCamera
    if not camera then return false end
    local rayOrigin = camera.CFrame.Position
    local rayDirection = (targetPosition - rayOrigin).Unit * 1000
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {self:getLocalCharacter()}
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    if raycastResult then
        local hitPosition = raycastResult.Position
        local targetDistance = (targetPosition - rayOrigin).Magnitude
        local hitDistance = (hitPosition - rayOrigin).Magnitude
        return hitDistance >= targetDistance - 1
    end
    return true
end
function MemoryHandler:getCameraCFrame()
    local camera = workspace.CurrentCamera
    if camera then return camera.CFrame end
    return CFrame.identity
end
function MemoryHandler:worldToScreen(worldPosition)
    local camera = workspace.CurrentCamera
    if not camera then return nil end
    local screenPosition, onScreen = camera:WorldToScreenPoint(worldPosition)
    return Vector2.new(screenPosition.X, screenPosition.Y), onScreen
end
function MemoryHandler:screenToWorld(screenPosition, depth)
    local camera = workspace.CurrentCamera
    if not camera then return nil end
    local ray = camera:ScreenPointToRay(screenPosition.X, screenPosition.Y, depth or 100)
    return ray.Origin + ray.Direction * (depth or 100)
end
function MemoryHandler:getMouseHit()
    local player = self.Players.LocalPlayer
    if not player then return nil end
    local mouse = player:GetMouse()
    if mouse then return mouse.Hit end
    return nil
end
function MemoryHandler:getMouseTarget()
    local player = self.Players.LocalPlayer
    if not player then return nil end
    local mouse = player:GetMouse()
    if mouse and mouse.Target then return mouse.Target end
    return nil
end
function MemoryHandler:update()
    if tick() - self.lastCacheUpdate > 1 then self:updateAllAddresses() end
end
function MemoryHandler:shutdown()
    self.entityCache = {}
    self.playerCache = {}
    self.npcCache = {}
    self.objectCache = {}
    self.addressCache = {}
end
return MemoryHandler