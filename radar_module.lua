-- radar_module.lua - Module Radar cho AOT Revolution
local RadarModule = {}
RadarModule.__index = RadarModule

function RadarModule.new(memoryHandler)
    local self = setmetatable({}, RadarModule)
    self.memory = memoryHandler
    self.enabled = false
    self.range = 500
    self.radarSize = 150
    self.radarPosition = Vector2.new(20, 20)
    self.radarContainer = nil
    self.radarDots = {}
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    return self
end

function RadarModule:initialize()
    print("[*] Radar Module initialized")
    self:createRadar()
    return true
end

function RadarModule:setRange(range)
    self.range = range
end

function RadarModule:createRadar()
    local player = self.Players.LocalPlayer
    if not player then return end
    local playerGui = player:WaitForChild("PlayerGui")
    if not playerGui then return end
    if self.radarContainer then self.radarContainer:Destroy() end
    self.radarContainer = Instance.new("ScreenGui")
    self.radarContainer.Name = "Radar_Container"
    self.radarContainer.ResetOnSpawn = false
    self.radarContainer.Parent = playerGui
    local radarFrame = Instance.new("Frame")
    radarFrame.Name = "RadarFrame"
    radarFrame.Size = UDim2.new(0, self.radarSize, 0, self.radarSize)
    radarFrame.Position = UDim2.new(0, self.radarPosition.X, 0, self.radarPosition.Y)
    radarFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    radarFrame.BackgroundTransparency = 0.3
    radarFrame.BorderSizePixel = 1
    radarFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    radarFrame.Parent = self.radarContainer
    local centerDot = Instance.new("Frame")
    centerDot.Name = "CenterDot"
    centerDot.Size = UDim2.new(0, 4, 0, 4)
    centerDot.Position = UDim2.new(0.5, -2, 0.5, -2)
    centerDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    centerDot.BorderSizePixel = 0
    centerDot.Parent = radarFrame
    self.radarFrame = radarFrame
    self.centerDot = centerDot
end

function RadarModule:worldToRadar(worldPosition)
    local localRoot = self.memory:getLocalRootPart()
    if not localRoot then return nil end
    local camera = workspace.CurrentCamera
    if not camera then return nil end
    local relativePos = worldPosition - localRoot.Position
    local forward = camera.CFrame.LookVector
    local right = camera.CFrame.RightVector
    local x = relativePos:Dot(right)
    local z = relativePos:Dot(forward)
    local scale = self.radarSize / (2 * self.range)
    local radarX = self.radarSize / 2 + x * scale
    local radarY = self.radarSize / 2 - z * scale
    if radarX < 0 or radarX > self.radarSize or radarY < 0 or radarY > self.radarSize then
        return nil
    end
    return Vector2.new(radarX, radarY)
end

function RadarModule:updateRadarDots()
    local allEntities = self.memory:getAllEntities()
    local activeEntities = {}
    for _, entity in ipairs(allEntities) do
        if self.memory:isAlive(entity) then
            local pos = self.memory:getPosition(entity)
            local radarPos = self:worldToRadar(pos)
            if radarPos then
                local entityKey = entity.name or entity.player and entity.player.Name or "Unknown"
                if not self.radarDots[entityKey] then
                    local dot = Instance.new("Frame")
                    dot.Size = UDim2.new(0, 3, 0, 3)
                    dot.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    dot.BorderSizePixel = 0
                    dot.Parent = self.radarFrame
                    self.radarDots[entityKey] = dot
                end
                local dot = self.radarDots[entityKey]
                dot.Position = UDim2.new(0, radarPos.X, 0, radarPos.Y)
                if entity.player then
                    local team = self.memory:getTeam(entity)
                    if team then
                        local teamColor = team.TeamColor
                        dot.BackgroundColor3 = Color3.fromRGB(teamColor.R * 255, teamColor.G * 255, teamColor.B * 255)
                    else
                        dot.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                    end
                else
                    dot.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
                end
                activeEntities[entityKey] = true
            end
        end
    end
    for key, dot in pairs(self.radarDots) do
        if not activeEntities[key] then
            dot:Destroy()
            self.radarDots[key] = nil
        end
    end
end

function RadarModule:toggle()
    self.enabled = not self.enabled
    if self.radarContainer then
        self.radarContainer.Enabled = self.enabled
    end
    print("[*] Radar " .. (self.enabled and "enabled" or "disabled"))
end

function RadarModule:update()
    if not self.enabled then return end
    if not self.radarContainer then self:createRadar() end
    self:updateRadarDots()
end

function RadarModule:shutdown()
    self.enabled = false
    if self.radarContainer then
        self.radarContainer:Destroy()
        self.radarContainer = nil
    end
    self.radarDots = {}
end

return RadarModule