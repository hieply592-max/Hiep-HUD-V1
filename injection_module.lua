-- injection_module.lua - Module inject hook cho AOT Revolution
local InjectionModule = {}
InjectionModule.__index = InjectionModule

function InjectionModule.new()
    local self = setmetatable({}, InjectionModule)
    self.injectedHooks = {}
    self.injectedFunctions = {}
    self.injectedConnections = {}
    self.injectionStatus = false
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.UserInputService = game:GetService("UserInputService")
    self.ReplicatedStorage = game:GetService("ReplicatedStorage")
    return self
end

function InjectionModule:injectHooks()
    print("[*] Injecting hooks...")
    local success1 = self:injectRenderHook()
    local success2 = self:injectSimulationHook()
    local success3 = self:injectCharacterHook()
    local success4 = self:injectRemoteHook()
    local success5 = self:injectCameraHook()
    local success6 = self:injectInputHook()
    local success7 = self:injectNetworkHook()
    local success8 = self:injectUIHook()
    if success1 and success2 and success3 and success4 and success5 and success6 and success7 and success8 then
        self.injectionStatus = true
        print("[+] Hook injection successful!")
        return true
    else
        warn("[-] Hook injection partially failed")
        return false
    end
end

function InjectionModule:injectRenderHook()
    local success, err = pcall(function()
        local oldRenderStep = self.RunService.RenderStepped
        self.injectedHooks["render"] = oldRenderStep
    end)
    return success
end

function InjectionModule:injectSimulationHook()
    local success, err = pcall(function()
        local oldHeartbeat = self.RunService.Heartbeat
        self.injectedHooks["heartbeat"] = oldHeartbeat
    end)
    return success
end

function InjectionModule:injectCharacterHook()
    local success, err = pcall(function()
        local connection
        connection = self.Players.LocalPlayer.CharacterAdded:Connect(function(character)
            self.injectedHooks["character"] = character
            local humanoid = character:WaitForChild("Humanoid")
            if humanoid then
                self.injectedHooks["humanoid"] = humanoid
            end
        end)
        self.injectedConnections["characterAdded"] = connection
    end)
    return success
end

function InjectionModule:injectRemoteHook()
    local success, err = pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "FireServer" then
                table.insert(self.injectedHooks, {
                    type = "FireServer",
                    remote = self,
                    args = args,
                    time = tick()
                })
            elseif method == "InvokeServer" then
                table.insert(self.injectedHooks, {
                    type = "InvokeServer",
                    remote = self,
                    args = args,
                    time = tick()
                })
            end
            return oldNamecall(self, ...)
        end)
        self.injectedFunctions["namecall"] = oldNamecall
    end)
    return success
end

function InjectionModule:injectCameraHook()
    local success, err = pcall(function()
        local camera = workspace.CurrentCamera
        if camera then
            self.injectedHooks["camera"] = camera
            self.injectedHooks["cameraCFrame"] = camera.CFrame
            self.injectedHooks["cameraFOV"] = camera.FieldOfView
        end
    end)
    return success
end

function InjectionModule:injectInputHook()
    local success, err = pcall(function()
        local connection
        connection = self.UserInputService.InputBegan:Connect(function(input, gameProcessed)
            table.insert(self.injectedHooks, {
                type = "InputBegan",
                input = input,
                gameProcessed = gameProcessed,
                time = tick()
            })
        end)
        self.injectedConnections["inputBegan"] = connection
        local connection2
        connection2 = self.UserInputService.InputEnded:Connect(function(input, gameProcessed)
            table.insert(self.injectedHooks, {
                type = "InputEnded",
                input = input,
                gameProcessed = gameProcessed,
                time = tick()
            })
        end)
        self.injectedConnections["inputEnded"] = connection2
    end)
    return success
end

function InjectionModule:injectNetworkHook()
    local success, err = pcall(function()
        local connection
        connection = self.ReplicatedStorage.ChildAdded:Connect(function(child)
            if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                table.insert(self.injectedHooks, {
                    type = "RemoteAdded",
                    remote = child,
                    time = tick()
                })
            end
        end)
        self.injectedConnections["remoteAdded"] = connection
    end)
    return success
end

function InjectionModule:injectUIHook()
    local success, err = pcall(function()
        local playerGui = self.Players.LocalPlayer:WaitForChild("PlayerGui")
        if playerGui then
            self.injectedHooks["playerGui"] = playerGui
            local connection
            connection = playerGui.ChildAdded:Connect(function(child)
                table.insert(self.injectedHooks, {
                    type = "GUIAdded",
                    gui = child,
                    time = tick()
                })
            end)
            self.injectedConnections["guiAdded"] = connection
        end
    end)
    return success
end

function InjectionModule:ejectHooks()
    if not self.injectionStatus then return end
    print("[*] Ejecting hooks...")
    for name, connection in pairs(self.injectedConnections) do
        pcall(function() connection:Disconnect() end)
    end
    if self.injectedFunctions["namecall"] then
        pcall(function()
            hookmetamethod(game, "__namecall", self.injectedFunctions["namecall"])
        end)
    end
    self.injectedHooks = {}
    self.injectedFunctions = {}
    self.injectedConnections = {}
    self.injectionStatus = false
    print("[+] Hooks ejected")
end

function InjectionModule:getInjectedHooks()
    return self.injectedHooks
end

function InjectionModule:update() end

function InjectionModule:shutdown()
    self:ejectHooks()
end

return InjectionModule