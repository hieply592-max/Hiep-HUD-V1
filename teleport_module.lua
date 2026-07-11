-- teleport_module.lua - Module Teleport cho AOT Revolution
local TeleportModule = {}
TeleportModule.__index = TeleportModule

function TeleportModule.new(memoryHandler)
    local self = setmetatable({}, TeleportModule)
    self.memory = memoryHandler
    self.enabled = false
    self.safetyCheck = true
    self.teleportSpeed = "Instant"
    self.waypoints = {}
    self.currentWaypointIndex = 1
    self.autoWaypoint = false
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.UserInputService = game:GetService("UserInputService")
    return self
end

function TeleportModule:initialize()
    print("[*] Teleport Module initialized")
    return true
end

function TeleportModule:setSafetyCheck(check)
    self.safetyCheck = check
end

function TeleportModule:teleportTo(position)
    local character = self.memory:getLocalCharacter()
    if not character then return false end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return false end
    if self.safetyCheck then
        local rayOrigin = position + Vector3.new(0, 50, 0)
        local rayDirection = Vector3.new(0, -100, 0)
        local raycastResult = workspace:Raycast(rayOrigin, rayDirection)
        if raycastResult then
            position = raycastResult.Position + Vector3.new(0, 3, 0)
        end
    end
    if self.teleportSpeed == "Instant" then
        rootPart.CFrame = CFrame.new(position)
    else
        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
        local tween = tweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(position)})
        tween:Play()
        tween.Completed:Wait()
    end
    return true
end

function TeleportModule:teleportToCursor()
    local mouseHit = self.memory:getMouseHit()
    if mouseHit then
        local success = self:teleportTo(mouseHit.Position)
        if success then
            print("[+] Teleported to cursor position")
        end
    end
end

function TeleportModule:teleportToPlayer(playerName)
    for _, playerData in ipairs(self.memory:getAllPlayers()) do
        if playerData.name and playerData.name:lower():find(playerName:lower()) then
            local pos = self.memory:getPosition(playerData)
            return self:teleportTo(pos)
        end
    end
    return false
end

function TeleportModule:teleportToNearestNPC()
    local npcs = self.memory:getNPCsInRadius(10000)
    if #npcs > 0 then
        local pos = self.memory:getPosition(npcs[1])
        return self:teleportTo(pos)
    end
    return false
end

function TeleportModule:addWaypoint(position)
    table.insert(self.waypoints, position)
    print("[+] Waypoint added at position")
end

function TeleportModule:clearWaypoints()
    self.waypoints = {}
    self.currentWaypointIndex = 1
    print("[+] Waypoints cleared")
end

function TeleportModule:startWaypointTeleport()
    if #self.waypoints == 0 then return end
    self.autoWaypoint = true
    self.currentWaypointIndex = 1
end

function TeleportModule:stopWaypointTeleport()
    self.autoWaypoint = false
end

function TeleportModule:update()
    if self.autoWaypoint and #self.waypoints > 0 then
        local targetPos = self.waypoints[self.currentWaypointIndex]
        local localRoot = self.memory:getLocalRootPart()
        if localRoot and targetPos then
            local distance = (localRoot.Position - targetPos).Magnitude
            if distance < 5 then
                self.currentWaypointIndex = self.currentWaypointIndex + 1
                if self.currentWaypointIndex > #self.waypoints then
                    self.currentWaypointIndex = 1
                end
            else
                self:teleportTo(targetPos)
            end
        end
    end
end

function TeleportModule:shutdown()
    self.autoWaypoint = false
    self.waypoints = {}
end

return TeleportModule