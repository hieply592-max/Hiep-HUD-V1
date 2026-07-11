-- bypass_module.lua - Module bypass anti-cheat cho AOT Revolution
local BypassModule = {}
BypassModule.__index = BypassModule

function BypassModule.new()
    local self = setmetatable({}, BypassModule)
    self.bypassStatus = false
    self.hooksInstalled = {}
    self.originalFunctions = {}
    self.hookedConnections = {}
    self.antiCheatDetected = false
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.UserInputService = game:GetService("UserInputService")
    self.TeleportService = game:GetService("TeleportService")
    self.StarterGui = game:GetService("StarterGui")
    self.HttpService = game:GetService("HttpService")
    return self
end

function BypassModule:bypassAntiCheat()
    print("[*] Starting anti-cheat bypass...")
    local success1 = self:disableRemoteDetection()
    local success2 = self:bypassNamecallHooks()
    local success3 = self:spoofMetaMethodHooks()
    local success4 = self:disableIntegrityChecks()
    local success5 = self:bypassEnvironmentChecks()
    local success6 = self:spoofDebugInfo()
    local success7 = self:disableTeleportDetection()
    local success8 = self:setupErrorHandler()
    if success1 and success2 and success3 and success4 and success5 and success6 and success7 and success8 then
        self.bypassStatus = true
        print("[+] Anti-cheat bypass successful!")
        return true
    else
        warn("[-] Anti-cheat bypass partially failed")
        return false
    end
end

function BypassModule:disableRemoteDetection()
    local success, err = pcall(function()
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "FireServer" or method == "InvokeServer" then
                if tostring(self):find("Ban") or tostring(self):find("Kick") or tostring(self):find("Detect") or tostring(self):find("Report") then
                    return nil
                end
            end
            if method == "Kick" or method == "Remove" then
                return nil
            end
            return oldNamecall(self, ...)
        end)
        self.hooksInstalled["namecall"] = oldNamecall
    end)
    return success
end

function BypassModule:bypassNamecallHooks()
    local success, err = pcall(function()
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, key)
            if key == "Name" or key == "ClassName" then
                if self == game:GetService("ScriptContext") then
                    return "ScriptContext"
                end
            end
            if key == "HttpGet" or key == "HttpGetAsync" then
                return function(url)
                    if url:find("detect") or url:find("ban") or url:find("report") then
                        return "{}"
                    end
                    return game:HttpGet(url)
                end
            end
            return oldIndex(self, key)
        end)
        self.hooksInstalled["index"] = oldIndex
    end)
    return success
end

function BypassModule:spoofMetaMethodHooks()
    local success, err = pcall(function()
        local oldNewIndex
        oldNewIndex = hookmetamethod(game, "__newindex", function(self, key, value)
            if self == self.Players.LocalPlayer then
                if key == "UserId" or key == "Character" or key == "Backpack" then
                    return oldNewIndex(self, key, value)
                end
            end
            return oldNewIndex(self, key, value)
        end)
        self.hooksInstalled["newindex"] = oldNewIndex
    end)
    return success
end

function BypassModule:disableIntegrityChecks()
    local success, err = pcall(function()
        if getfenv then
            local oldEnv = getfenv()
            if oldEnv then
                local newEnv = {}
                setmetatable(newEnv, {__index = oldEnv})
                for k, v in pairs(oldEnv) do
                    newEnv[k] = v
                end
                newEnv.require = function(module)
                    if type(module) == "number" then
                        return nil
                    end
                    return require(module)
                end
                setfenv(2, newEnv)
            end
        end
        if getgenv then
            getgenv().__ANTI_CHEAT_BYPASS = true
        end
    end)
    return success
end

function BypassModule:bypassEnvironmentChecks()
    local success, err = pcall(function()
        local syn = getsyn and getsyn()
        if syn then
            syn.protect_gui = function() return true end
            syn.write_clipboard = function() return true end
        end
        local oldGetObjects
        oldGetObjects = hookfunction(game.GetObjects, function(assetId)
            return oldGetObjects(assetId)
        end)
        self.hooksInstalled["getobjects"] = oldGetObjects
    end)
    return success
end

function BypassModule:spoofDebugInfo()
    local success, err = pcall(function()
        if debug then
            local oldGetInfo = debug.getinfo
            debug.getinfo = function(thread, level)
                local info = oldGetInfo(thread, level)
                if info then
                    info.source = "=[C]"
                    info.short_src = "[C]"
                    info.what = "C"
                end
                return info
            end
            local oldGetRegistry = debug.getregistry
            debug.getregistry = function()
                return {}
            end
            local oldGetUpvalue = debug.getupvalue
            debug.getupvalue = function(f, idx)
                return nil
            end
        end
    end)
    return success
end

function BypassModule:disableTeleportDetection()
    local success, err = pcall(function()
        local oldTeleport = self.TeleportService.Teleport
        self.TeleportService.Teleport = function(...)
            return oldTeleport(self.TeleportService, ...)
        end
        self.Players.PlayerRemoving:Connect(function(player)
            if player == self.Players.LocalPlayer then
                self:restoreAntiCheat()
            end
        end)
    end)
    return success
end

function BypassModule:setupErrorHandler()
    local success, err = pcall(function()
        local oldErrorHandler = game:GetService("ScriptContext").Error
        local errorConnection
        errorConnection = game:GetService("ScriptContext").Error:Connect(function(message, stack, script)
            if message:find("detected") or message:find("banned") or message:find("exploit") then
                return
            end
        end)
        self.hookedConnections["error"] = errorConnection
    end)
    return success
end

function BypassModule:restoreAntiCheat()
    if not self.bypassStatus then return end
    print("[*] Restoring anti-cheat...")
    for name, hook in pairs(self.hooksInstalled) do
        pcall(function()
            if name == "namecall" then hookmetamethod(game, "__namecall", hook) end
            if name == "index" then hookmetamethod(game, "__index", hook) end
            if name == "newindex" then hookmetamethod(game, "__newindex", hook) end
        end)
    end
    for name, connection in pairs(self.hookedConnections) do
        pcall(function() connection:Disconnect() end)
    end
    self.bypassStatus = false
    self.hooksInstalled = {}
    self.hookedConnections = {}
    print("[+] Anti-cheat restored")
end

function BypassModule:update() end

function BypassModule:shutdown()
    self:restoreAntiCheat()
end

return BypassModule