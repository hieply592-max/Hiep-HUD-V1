-- config_manager.lua - Module quản lý cấu hình cho AOT Revolution hack
local ConfigManager = {}
ConfigManager.__index = ConfigManager

function ConfigManager.new()
    local self = setmetatable({}, ConfigManager)
    self.configPath = "AOT_Hack_Config.json"
    self.defaultConfig = {
        aimbotEnabled = true,
        aimbotSpeed = 5.0,
        aimbotFOV = 180,
        aimbotBone = "Head",
        aimbotVisCheck = true,
        aimbotTeamCheck = true,
        aimbotKeybind = "RightMouseButton",
        espEnabled = true,
        espBox = 1,
        espDistance = true,
        espHealth = true,
        espName = true,
        espMaxDist = 500,
        espTracers = true,
        espColor = {255, 0, 0},
        speedEnabled = false,
        speedMult = 1.5,
        autoLoot = true,
        lootRange = 50,
        lagSwitch = false,
        packetSpoof = true,
        triggerDelay = 50,
        radarEnabled = true,
        radarRange = 500,
        tpSafety = true,
        flyEnabled = false,
        flySpeed = 10,
        noclip = false,
        noCooldown = true,
        godMode = false,
        dmgMult = 1.0,
        farmMode = "auto",
        antiAFK = true,
        skinID = 0,
        cameraFOV = 90,
        menuKeybind = "Insert",
        menuVisible = true
    }
    self.currentConfig = {}
    return self
end

function ConfigManager:loadConfig()
    local success, err = pcall(function()
        if isfile and isfile(self.configPath) then
            local content = readfile(self.configPath)
            local loadedConfig = game:GetService("HttpService"):JSONDecode(content)
            for k, v in pairs(self.defaultConfig) do
                if loadedConfig[k] ~= nil then
                    self.currentConfig[k] = loadedConfig[k]
                else
                    self.currentConfig[k] = v
                end
            end
            print("[+] Config loaded from file")
        else
            self.currentConfig = {}
            for k, v in pairs(self.defaultConfig) do
                self.currentConfig[k] = v
            end
            self:saveConfig()
            print("[+] Default config created")
        end
    end)
    if not success then
        warn("[-] Failed to load config: " .. tostring(err))
        self.currentConfig = {}
        for k, v in pairs(self.defaultConfig) do
            self.currentConfig[k] = v
        end
    end
end

function ConfigManager:saveConfig()
    local success, err = pcall(function()
        if writefile then
            local json = game:GetService("HttpService"):JSONEncode(self.currentConfig)
            writefile(self.configPath, json)
            print("[+] Config saved")
        end
    end)
    if not success then
        warn("[-] Failed to save config: " .. tostring(err))
    end
end

function ConfigManager:getSettings()
    return self.currentConfig
end

function ConfigManager:getSetting(key)
    return self.currentConfig[key] or self.defaultConfig[key]
end

function ConfigManager:setSetting(key, value)
    self.currentConfig[key] = value
    self:saveConfig()
end

function ConfigManager:resetToDefault()
    self.currentConfig = {}
    for k, v in pairs(self.defaultConfig) do
        self.currentConfig[k] = v
    end
    self:saveConfig()
    print("[+] Config reset to default")
end

function ConfigManager:update() end

function ConfigManager:shutdown()
    self:saveConfig()
end

return ConfigManager