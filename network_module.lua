-- network_module.lua - Module Network Manipulation cho AOT Revolution
local NetworkModule = {}
NetworkModule.__index = NetworkModule

function NetworkModule.new()
    local self = setmetatable({}, NetworkModule)
    self.lagSwitch = false
    self.packetSpoof = true
    self.latencyModifier = 0
    self.blockedRemotes = {}
    self.modifiedRemotes = {}
    self.capturedPackets = {}
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.ReplicatedStorage = game:GetService("ReplicatedStorage")
    return self
end

function NetworkModule:initialize()
    print("[*] Network Module initialized")
    self:setupRemoteHooks()
    return true
end

function NetworkModule:setupRemoteHooks()
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "FireServer" or method == "InvokeServer" then
            for _, blockedName in ipairs(self.blockedRemotes) do
                if tostring(self):find(blockedName) then
                    return nil
                end
            end
            if self.lagSwitch then
                task.wait(self.latencyModifier / 1000)
            end
            if self.packetSpoof then
                table.insert(self.capturedPackets, {
                    remote = self,
                    method = method,
                    args = args,
                    time = tick()
                })
                if #self.capturedPackets > 1000 then
                    table.remove(self.capturedPackets, 1)
                end
            end
        end
        return oldNamecall(self, ...)
    end)
end

function NetworkModule:setLagSwitch(enabled)
    self.lagSwitch = enabled
end

function NetworkModule:setPacketSpoof(enabled)
    self.packetSpoof = enabled
end

function NetworkModule:setLatency(ms)
    self.latencyModifier = ms
end

function NetworkModule:blockRemote(remoteName)
    table.insert(self.blockedRemotes, remoteName)
end

function NetworkModule:unblockRemote(remoteName)
    for i, name in ipairs(self.blockedRemotes) do
        if name == remoteName then
            table.remove(self.blockedRemotes, i)
            break
        end
    end
end

function NetworkModule:sendFakePacket(remotePath, ...)
    local success, err = pcall(function()
        local remote = self.ReplicatedStorage:FindFirstChild(remotePath)
        if not remote then
            remote = self.Workspace:FindFirstChild(remotePath)
        end
        if remote and remote:IsA("RemoteEvent") then
            remote:FireServer(...)
            return true
        end
        return false
    end)
    return success
end

function NetworkModule:toggleLagSwitch()
    self.lagSwitch = not self.lagSwitch
    print("[*] Lag Switch " .. (self.lagSwitch and "enabled" or "disabled"))
end

function NetworkModule:update()
    if self.lagSwitch and self.latencyModifier > 0 then
        task.wait(self.latencyModifier / 1000)
    end
end

function NetworkModule:shutdown()
    self.lagSwitch = false
    self.blockedRemotes = {}
    self.capturedPackets = {}
end

return NetworkModule