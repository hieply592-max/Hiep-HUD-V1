-- main.lua - Trình khởi chạy chính AOT Revolution Hack
if not game:IsLoaded() then game.Loaded:Wait() end
getgenv().AOT_HACK_VERSION = "v3.0.0"
getgenv().AOT_HACK_LOADED = false
getgenv().AOT_HACK_MODULES = {}

local function loadModule(fileName)
    local success, result = pcall(function()
        return loadfile(fileName)()
    end)
    if success then
        print("[+] Module loaded: " .. fileName)
        return result
    else
        warn("[-] Module failed: " .. fileName .. " - " .. tostring(result))
        return nil
    end
end

local Modules = {}
local function loadAllModules()
    print("[*] Loading 24 hack modules...")
    Modules.MemoryHandler = loadModule("memory_handler.lua")
    Modules.BypassModule = loadModule("bypass_module.lua")
    Modules.InjectionModule = loadModule("injection_module.lua")
    Modules.ConfigManager = loadModule("config_manager.lua")
    Modules.GUIModule = loadModule("gui_module.lua")
    Modules.ScriptExecutor = loadModule("script_executor.lua")
    Modules.AimbotModule = loadModule("aimbot_module.lua")
    Modules.ESPModule = loadModule("esp_module.lua")
    Modules.SpeedModule = loadModule("speed_module.lua")
    Modules.InventoryModule = loadModule("inventory_module.lua")
    Modules.NetworkModule = loadModule("network_module.lua")
    Modules.ExploitModule = loadModule("exploit_module.lua")
    Modules.ProtectionModule = loadModule("protection_module.lua")
    Modules.TriggerbotModule = loadModule("triggerbot_module.lua")
    Modules.RadarModule = loadModule("radar_module.lua")
    Modules.TeleportModule = loadModule("teleport_module.lua")
    Modules.FlyModule = loadModule("fly_module.lua")
    Modules.NoClipModule = loadModule("noclip_module.lua")
    Modules.InfiniteSkills = loadModule("infinite_skills.lua")
    Modules.GodModeModule = loadModule("god_mode.lua")
    Modules.DamageMultiplier = loadModule("damage_multiplier.lua")
    Modules.AutoFarmModule = loadModule("auto_farm.lua")
    Modules.AntiAFKModule = loadModule("anti_afk.lua")
    Modules.CustomSkins = loadModule("custom_skins.lua")
    Modules.CameraHack = loadModule("camera_hack.lua")
    return Modules
end

local AttackOnTitanRevolutionHack = {}
AttackOnTitanRevolutionHack.__index = AttackOnTitanRevolutionHack

function AttackOnTitanRevolutionHack.new()
    local self = setmetatable({}, AttackOnTitanRevolutionHack)
    self.Config = Modules.ConfigManager and Modules.ConfigManager.new() or nil
    if self.Config then self.Config:loadConfig() end
    self.MemoryHandler = Modules.MemoryHandler and Modules.MemoryHandler.new() or nil
    self.BypassModule = Modules.BypassModule and Modules.BypassModule.new() or nil
    self.InjectionModule = Modules.InjectionModule and Modules.InjectionModule.new() or nil
    self.GUIModule = Modules.GUIModule and Modules.GUIModule.new(self) or nil
    self.ScriptExecutor = Modules.ScriptExecutor and Modules.ScriptExecutor.new() or nil
    self.AimbotModule = Modules.AimbotModule and Modules.AimbotModule.new(self.MemoryHandler) or nil
    self.ESPModule = Modules.ESPModule and Modules.ESPModule.new(self.MemoryHandler) or nil
    self.SpeedModule = Modules.SpeedModule and Modules.SpeedModule.new(self.MemoryHandler) or nil
    self.InventoryModule = Modules.InventoryModule and Modules.InventoryModule.new(self.MemoryHandler) or nil
    self.NetworkModule = Modules.NetworkModule and Modules.NetworkModule.new() or nil
    self.ExploitModule = Modules.ExploitModule and Modules.ExploitModule.new(self.MemoryHandler, self.NetworkModule) or nil
    self.ProtectionModule = Modules.ProtectionModule and Modules.ProtectionModule.new() or nil
    self.TriggerbotModule = Modules.TriggerbotModule and Modules.TriggerbotModule.new(self.MemoryHandler) or nil
    self.RadarModule = Modules.RadarModule and Modules.RadarModule.new(self.MemoryHandler) or nil
    self.TeleportModule = Modules.TeleportModule and Modules.TeleportModule.new(self.MemoryHandler) or nil
    self.FlyModule = Modules.FlyModule and Modules.FlyModule.new(self.MemoryHandler) or nil
    self.NoClipModule = Modules.NoClipModule and Modules.NoClipModule.new(self.MemoryHandler) or nil
    self.InfiniteSkills = Modules.InfiniteSkills and Modules.InfiniteSkills.new(self.MemoryHandler) or nil
    self.GodModeModule = Modules.GodModeModule and Modules.GodModeModule.new(self.MemoryHandler) or nil
    self.DamageMultiplier = Modules.DamageMultiplier and Modules.DamageMultiplier.new(self.MemoryHandler) or nil
    self.AutoFarmModule = Modules.AutoFarmModule and Modules.AutoFarmModule.new(self.MemoryHandler) or nil
    self.AntiAFKModule = Modules.AntiAFKModule and Modules.AntiAFKModule.new() or nil
    self.CustomSkins = Modules.CustomSkins and Modules.CustomSkins.new(self.MemoryHandler) or nil
    self.CameraHack = Modules.CameraHack and Modules.CameraHack.new(self.MemoryHandler) or nil
    self.isRunning = false
    self.LocalPlayer = game:GetService("Players").LocalPlayer
    return self
end

function AttackOnTitanRevolutionHack:initialize()
    print("[*] Initializing AOT Revolution Hack System...")
    if not self.LocalPlayer then self.LocalPlayer = game:GetService("Players").LocalPlayer end
    if not self.LocalPlayer.Character then self.LocalPlayer.CharacterAdded:Wait() end
    if self.BypassModule then
        if not self.BypassModule:bypassAntiCheat() then warn("[-] Anti-cheat bypass failed") return false end
    end
    if self.InjectionModule then
        if not self.InjectionModule:injectHooks() then warn("[-] Hook injection failed") return false end
    end
    local initList = {
        {"ESP", self.ESPModule}, {"Aimbot", self.AimbotModule}, {"Speed", self.SpeedModule},
        {"Inventory", self.InventoryModule}, {"Exploit", self.ExploitModule}, {"Network", self.NetworkModule},
        {"Protection", self.ProtectionModule}, {"Triggerbot", self.TriggerbotModule}, {"Radar", self.RadarModule},
        {"Teleport", self.TeleportModule}, {"Fly", self.FlyModule}, {"NoClip", self.NoClipModule},
        {"InfiniteSkills", self.InfiniteSkills}, {"GodMode", self.GodModeModule}, {"DamageMultiplier", self.DamageMultiplier},
        {"AutoFarm", self.AutoFarmModule}, {"AntiAFK", self.AntiAFKModule}, {"CustomSkins", self.CustomSkins},
        {"CameraHack", self.CameraHack}
    }
    for _, moduleData in ipairs(initList) do
        local name, module = moduleData[1], moduleData[2]
        if module and module.initialize then
            local success, err = pcall(function() module:initialize() end)
            if success then print("[+] " .. name .. " initialized")
            else warn("[-] " .. name .. " init failed: " .. tostring(err)) end
        end
    end
    self:applySettings()
    print("[+] Hack system ready!")
    return true
end

function AttackOnTitanRevolutionHack:applySettings()
    if not self.Config then return end
    local settings = self.Config:getSettings()
    if self.AimbotModule then
        self.AimbotModule:setAimSpeed(settings.aimbotSpeed or 5.0)
        self.AimbotModule:setFOV(settings.aimbotFOV or 180)
        self.AimbotModule:setTargetBone(settings.aimbotBone or "Head")
        self.AimbotModule:setVisibilityCheck(settings.aimbotVisCheck or true)
        self.AimbotModule:setTeamCheck(settings.aimbotTeamCheck or true)
    end
    if self.ESPModule then
        self.ESPModule:setBoxType(settings.espBox or 1)
        self.ESPModule:setShowDistance(settings.espDistance or true)
        self.ESPModule:setShowHealth(settings.espHealth or true)
        self.ESPModule:setShowName(settings.espName or true)
        self.ESPModule:setMaxDistance(settings.espMaxDist or 500)
        self.ESPModule:setShowTracers(settings.espTracers or true)
    end
    if self.SpeedModule then self.SpeedModule:setMultiplier(settings.speedMult or 1.5) end
    if self.InventoryModule then
        self.InventoryModule:setAutoLoot(settings.autoLoot or true)
        self.InventoryModule:setLootRange(settings.lootRange or 50)
    end
    if self.NetworkModule then
        self.NetworkModule:setLagSwitch(settings.lagSwitch or false)
        self.NetworkModule:setPacketSpoof(settings.packetSpoof or true)
    end
    if self.TriggerbotModule then self.TriggerbotModule:setDelay(settings.triggerDelay or 50) end
    if self.RadarModule then self.RadarModule:setRange(settings.radarRange or 500) end
    if self.TeleportModule then self.TeleportModule:setSafetyCheck(settings.tpSafety or true) end
    if self.FlyModule then self.FlyModule:setSpeed(settings.flySpeed or 10) end
    if self.NoClipModule then self.NoClipModule:setEnabled(settings.noclip or false) end
    if self.InfiniteSkills then self.InfiniteSkills:setNoCooldown(settings.noCooldown or true) end
    if self.GodModeModule then self.GodModeModule:setInvincible(settings.godMode or false) end
    if self.DamageMultiplier then self.DamageMultiplier:setMultiplier(settings.dmgMult or 1.0) end
    if self.AutoFarmModule then self.AutoFarmModule:setFarmMode(settings.farmMode or "auto") end
    if self.AntiAFKModule then self.AntiAFKModule:setEnabled(settings.antiAFK or true) end
    if self.CustomSkins then self.CustomSkins:setSkin(settings.skinID or 0) end
    if self.CameraHack then self.CameraHack:setFOV(settings.cameraFOV or 90) end
end

function AttackOnTitanRevolutionHack:run()
    if not self:initialize() then warn("[-] Initialization failed. Exiting...") return end
    self.isRunning = true
    print("[!] Hack running. Press RightCtrl + END to exit.")
    if self.GUIModule then self.GUIModule:startGUI() end
    local function createLoop(module, name, interval)
        if not module or not module.update then return end
        task.spawn(function()
            while self.isRunning do
                local success, err = pcall(function() module:update() end)
                if not success then warn("[-] " .. name .. " update error: " .. tostring(err)) end
                task.wait(interval or 0.001)
            end
        end)
    end
    createLoop(self.ESPModule, "ESP", 0.01)
    createLoop(self.AimbotModule, "Aimbot", 0.001)
    createLoop(self.SpeedModule, "Speed", 0.1)
    createLoop(self.InventoryModule, "Inventory", 0.5)
    createLoop(self.ExploitModule, "Exploit", 0.1)
    createLoop(self.NetworkModule, "Network", 0.1)
    createLoop(self.ProtectionModule, "Protection", 1.0)
    createLoop(self.TriggerbotModule, "Triggerbot", 0.001)
    createLoop(self.RadarModule, "Radar", 0.1)
    createLoop(self.TeleportModule, "Teleport", 0.1)
    createLoop(self.FlyModule, "Fly", 0.01)
    createLoop(self.NoClipModule, "NoClip", 0.01)
    createLoop(self.InfiniteSkills, "InfiniteSkills", 1.0)
    createLoop(self.GodModeModule, "GodMode", 0.5)
    createLoop(self.DamageMultiplier, "DamageMultiplier", 0.1)
    createLoop(self.AutoFarmModule, "AutoFarm", 1.0)
    createLoop(self.AntiAFKModule, "AntiAFK", 60.0)
    createLoop(self.CustomSkins, "CustomSkins", 5.0)
    createLoop(self.CameraHack, "CameraHack", 0.1)
    task.spawn(function()
        local UIS = game:GetService("UserInputService")
        while self.isRunning do
            if UIS:IsKeyDown(Enum.KeyCode.RightControl) and UIS:IsKeyDown(Enum.KeyCode.End) then
                self:shutdown() break
            end
            if UIS:IsKeyDown(Enum.KeyCode.F1) and self.AimbotModule then self.AimbotModule:toggle() task.wait(0.3) end
            if UIS:IsKeyDown(Enum.KeyCode.F2) and self.ESPModule then self.ESPModule:toggle() task.wait(0.3) end
            if UIS:IsKeyDown(Enum.KeyCode.F3) and self.SpeedModule then self.SpeedModule:toggle() task.wait(0.3) end
            if UIS:IsKeyDown(Enum.KeyCode.F4) and self.InventoryModule then self.InventoryModule:toggleAutoLoot() task.wait(0.3) end
            if UIS:IsKeyDown(Enum.KeyCode.F5) and self.ExploitModule then self.ExploitModule:executeInstantKill() task.wait(0.5) end
            if UIS:IsKeyDown(Enum.KeyCode.F6) and self.NetworkModule then self.NetworkModule:toggleLagSwitch() task.wait(0.3) end
            if UIS:IsKeyDown(Enum.KeyCode.F7) and self.TeleportModule then self.TeleportModule:teleportToCursor() task.wait(0.5) end
            if UIS:IsKeyDown(Enum.KeyCode.F8) and self.GodModeModule then self.GodModeModule:toggle() task.wait(0.3) end
            if UIS:IsKeyDown(Enum.KeyCode.F9) and self.FlyModule then self.FlyModule:toggle() task.wait(0.3) end
            if UIS:IsKeyDown(Enum.KeyCode.F10) and self.NoClipModule then self.NoClipModule:toggle() task.wait(0.3) end
            task.wait(0.05)
        end
    end)
    while self.isRunning do
        if self.GUIModule then pcall(function() self.GUIModule:render() end) end
        if self.ScriptExecutor then pcall(function() self.ScriptExecutor:update() end) end
        task.wait(0.01)
    end
end

function AttackOnTitanRevolutionHack:shutdown()
    print("[!] Shutting down hack system...")
    self.isRunning = false
    local shutdownList = {self.ESPModule, self.AimbotModule, self.SpeedModule, self.InventoryModule, self.ExploitModule, self.NetworkModule, self.ProtectionModule, self.TriggerbotModule, self.RadarModule, self.TeleportModule, self.FlyModule, self.NoClipModule, self.InfiniteSkills, self.GodModeModule, self.DamageMultiplier, self.AutoFarmModule, self.AntiAFKModule, self.CustomSkins, self.CameraHack}
    for _, module in ipairs(shutdownList) do
        if module and module.shutdown then pcall(function() module:shutdown() end) end
    end
    if self.InjectionModule then pcall(function() self.InjectionModule:ejectHooks() end) end
    if self.BypassModule then pcall(function() self.BypassModule:restoreAntiCheat() end) end
    if self.Config then pcall(function() self.Config:saveConfig() end) end
    if self.GUIModule then pcall(function() self.GUIModule:destroy() end) end
    getgenv().AOT_HACK_LOADED = false
    print("[+] Hack system shut down safely.")
end

local ScriptExecutor = {}
ScriptExecutor.__index = ScriptExecutor
function ScriptExecutor.new()
    local self = setmetatable({}, ScriptExecutor)
    self.scripts = {}
    self.currentScript = nil
    return self
end
function ScriptExecutor:initialize()
    print("[*] Script Executor initialized")
    self:loadScripts()
    return true
end
function ScriptExecutor:loadScripts()
    local scriptsFolder = "AOT_Scripts"
    if not isfolder(scriptsFolder) then makefolder(scriptsFolder) end
    local files = listfiles(scriptsFolder)
    for _, file in ipairs(files) do
        if file:endswith(".lua") then
            local scriptName = file:match("([^/]+)%.lua$")
            self.scripts[scriptName] = file
        end
    end
    print("[+] Loaded " .. #files .. " scripts")
end
function ScriptExecutor:executeScript(scriptName)
    if not self.scripts[scriptName] then warn("[-] Script not found: " .. scriptName) return false end
    local success, err = pcall(function()
        local scriptContent = readfile(self.scripts[scriptName])
        local func, loadErr = loadstring(scriptContent)
        if not func then error("Compile error: " .. loadErr) end
        self.currentScript = coroutine.create(func)
        coroutine.resume(self.currentScript)
    end)
    if success then print("[+] Executed script: " .. scriptName) return true
    else warn("[-] Script execution failed: " .. tostring(err)) return false end
end
function ScriptExecutor:executeString(code)
    local success, err = pcall(function()
        local func, loadErr = loadstring(code)
        if not func then error("Compile error: " .. loadErr) end
        func()
    end)
    if success then print("[+] Executed custom code") return true
    else warn("[-] Code execution failed: " .. tostring(err)) return false end
end
function ScriptExecutor:update() end
function ScriptExecutor:shutdown()
    self.scripts = {}
    self.currentScript = nil
end
Modules.ScriptExecutor = ScriptExecutor

print([[
============================================
   Attack on Titan Revolution Hack System   
   Delta X Edition - v3.0.0                
   Made for Roblox Executor                 
============================================
]])

loadAllModules()
local hack = AttackOnTitanRevolutionHack.new()
getgenv().AOT_HACK_MODULES = Modules
getgenv().AOT_HACK_LOADED = true
hack:run()