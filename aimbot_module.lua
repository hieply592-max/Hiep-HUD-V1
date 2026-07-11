-- aimbot_module.lua - Module Aimbot cho AOT Revolution
local AimbotModule = {}
AimbotModule.__index = AimbotModule

function AimbotModule.new(memoryHandler)
    local self = setmetatable({}, AimbotModule)
    self.memory = memoryHandler
    self.enabled = false
    self.aimSpeed = 5.0
    self.fov = 180
    self.targetBone = "Head"
    self.visibilityCheck = true
    self.teamCheck = true
    self.currentTarget = nil
    self.smoothing = 1.0
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.UserInputService = game:GetService("UserInputService")
    self.aimConnection = nil
    return self
end

function AimbotModule:initialize()
    print("[*] Aimbot Module initialized")
    return true
end

function AimbotModule:setAimSpeed(speed)
    self.aimSpeed = speed
end

function AimbotModule:setFOV(fov)
    self.fov = fov
end

function AimbotModule:setTargetBone(bone)
    self.targetBone = bone
end

function AimbotModule:setVisibilityCheck(check)
    self.visibilityCheck = check
end

function AimbotModule:setTeamCheck(check)
    self.teamCheck = check
end

function AimbotModule:getClosestTarget()
    local localPlayer = self.memory:getLocalPlayer()
    if not localPlayer then return nil end
    local localCharacter = self.memory:getLocalCharacter()
    if not localCharacter then return nil end
    local camera = workspace.CurrentCamera
    if not camera then return nil end
    local closestTarget = nil
    local closestAngle = math.huge
    local allEntities = self.memory:getAllEntities()
    for _, entity in ipairs(allEntities) do
        if entity.player ~= localPlayer then
            if not self.teamCheck or not self.memory:isSameTeam(
                {player = localPlayer, team = localPlayer.Team}, entity) then
                if self.memory:isAlive(entity) then
                    local headPos = self.memory:getHeadPosition(entity)
                    if headPos then
                        local screenPos, onScreen = self.memory:worldToScreen(headPos)
                        if onScreen then
                            local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
                            local screenDist = (screenPos - screenCenter).Magnitude
                            local maxScreenDist = (self.fov / 360) * camera.ViewportSize.X
                            if screenDist <= maxScreenDist then
                                if not self.visibilityCheck or self.memory:isVisible(headPos) then
                                    local angle = screenDist
                                    if angle < closestAngle then
                                        closestAngle = angle
                                        closestTarget = entity
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return closestTarget
end

function AimbotModule:aimAtTarget(target)
    if not target then return end
    local camera = workspace.CurrentCamera
    if not camera then return end
    local targetPos = nil
    if self.targetBone == "Head" then
        targetPos = self.memory:getHeadPosition(target)
    else
        targetPos = self.memory:getPosition(target)
    end
    if not targetPos then return end
    local lookAt = CFrame.new(camera.CFrame.Position, targetPos)
    local newCFrame = camera.CFrame:Lerp(lookAt, self.aimSpeed / 100)
    camera.CFrame = newCFrame
end

function AimbotModule:isAimKeyPressed()
    return self.UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
end

function AimbotModule:toggle()
    self.enabled = not self.enabled
    print("[*] Aimbot " .. (self.enabled and "enabled" or "disabled"))
end

function AimbotModule:update()
    if not self.enabled then return end
    if not self:isAimKeyPressed() then
        self.currentTarget = nil
        return
    end
    if not self.currentTarget or not self.memory:isAlive(self.currentTarget) then
        self.currentTarget = self:getClosestTarget()
    end
    if self.currentTarget then
        self:aimAtTarget(self.currentTarget)
    end
end

function AimbotModule:shutdown()
    self.enabled = false
    self.currentTarget = nil
end

return AimbotModule