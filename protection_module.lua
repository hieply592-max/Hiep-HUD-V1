-- protection_module.lua - Module bảo vệ chống hack ngược cho AOT Revolution
local ProtectionModule = {}
ProtectionModule.__index = ProtectionModule

function ProtectionModule.new()
    local self = setmetatable({}, ProtectionModule)
    self.antiKick = true
    self.antiBan = true
    self.antiCrash = true
    self.antiTeleport = true
    self.antiForceField = true
    self.antiFling = true
    self.antiFreeze = true
    self.antiGrab = true
    self.antiInvisible = true
    self.antiLag = true
    self.blockedEvents = {}
    self.blockedFunctions = {}
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.UserInputService = game:GetService("UserInputService")
    self.StarterGui = game:GetService("StarterGui")
    return self
end

function ProtectionModule:initialize()
    print("[*] Protection Module initialized")
    self:setupProtections()
    return true
end

function ProtectionModule:setupProtections()
    if self.antiKick then
        local oldKick = self.Players.LocalPlayer.Kick
        self.Players.LocalPlayer.Kick = function(...) return nil end
        self.blockedFunctions["Kick"] = oldKick
    end
    if self.antiCrash then
        local connection
        connection = self.Players.LocalPlayer.CharacterAdded:Connect(function(character)
            local humanoid = character:WaitForChild("Humanoid")
            if humanoid then
                humanoid.Died:Connect(function()
                    task.wait(0.1)
                end)
            end
        end)
        self.blockedEvents["CharacterAdded"] = connection
    end
    if self.antiForceField then
        local connection
        connection = self.Players.LocalPlayer.CharacterAdded:Connect(function(character)
            local forceField = character:FindFirstChildOfClass("ForceField")
            if forceField then
                forceField:Destroy()
            end
            character.ChildAdded:Connect(function(child)
                if child:IsA("ForceField") then
                    task.wait(0.1)
                    child:Destroy()
                end
            end)
        end)
        self.blockedEvents["ForceField"] = connection
    end
    if self.antiFling then
        local connection
        connection = self.RunService.Stepped:Connect(function()
            local character = self.Players.LocalPlayer.Character
            if not character then return end
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not rootPart then return end
            local velocity = rootPart.Velocity
            local maxVelocity = 500
            if math.abs(velocity.X) > maxVelocity or math.abs(velocity.Y) > maxVelocity or math.abs(velocity.Z) > maxVelocity then
                rootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end)
        self.blockedEvents["Stepped"] = connection
    end
    if self.antiFreeze then
        local connection
        connection = self.RunService.Heartbeat:Connect(function()
            local character = self.Players.LocalPlayer.Character
            if not character then return end
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not rootPart then return end
            local lastPosition = self.lastPosition
            if lastPosition and (rootPart.Position - lastPosition).Magnitude < 0.001 then
                self.freezeCount = (self.freezeCount or 0) + 1
                if self.freezeCount > 10 then
                    rootPart.CFrame = rootPart.CFrame + Vector3.new(0, 0.1, 0)
                    self.freezeCount = 0
                end
            else
                self.freezeCount = 0
            end
            self.lastPosition = rootPart.Position
        end)
        self.blockedEvents["Heartbeat"] = connection
    end
    if self.antiGrab then
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" and tostring(self):find("Grab") then
                return nil
            end
            return oldNamecall(self, ...)
        end)
        self.blockedFunctions["Namecall"] = oldNamecall
    end
end

function ProtectionModule:toggleAntiKick()
    self.antiKick = not self.antiKick
    print("[*] Anti Kick " .. (self.antiKick and "enabled" or "disabled"))
end

function ProtectionModule:toggleAntiBan()
    self.antiBan = not self.antiBan
    print("[*] Anti Ban " .. (self.antiBan and "enabled" or "disabled"))
end

function ProtectionModule:update()
    if not self.antiFreeze then return end
end

function ProtectionModule:shutdown()
    for name, connection in pairs(self.blockedEvents) do
        pcall(function() connection:Disconnect() end)
    end
    self.blockedEvents = {}
    self.blockedFunctions = {}
end

return ProtectionModule