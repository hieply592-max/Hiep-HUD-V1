-- custom_skins.lua - Module Custom Skins cho AOT Revolution
local CustomSkinsModule = {}
CustomSkinsModule.__index = CustomSkinsModule

function CustomSkinsModule.new(memoryHandler)
    local self = setmetatable({}, CustomSkinsModule)
    self.memory = memoryHandler
    self.enabled = false
    self.currentSkinID = 0
    self.skinCache = {}
    self.availableSkins = {}
    self.Players = game:GetService("Players")
    self.RunService = game:GetService("RunService")
    self.ReplicatedStorage = game:GetService("ReplicatedStorage")
    return self
end

function CustomSkinsModule:initialize()
    print("[*] Custom Skins Module initialized")
    self:loadAvailableSkins()
    return true
end

function CustomSkinsModule:setSkin(skinID)
    self.currentSkinID = skinID
end

function CustomSkinsModule:loadAvailableSkins()
    self.availableSkins = {
        {id = 1, name = "Eren Yeager", rarity = "Common"},
        {id = 2, name = "Mikasa Ackerman", rarity = "Common"},
        {id = 3, name = "Armin Arlert", rarity = "Common"},
        {id = 4, name = "Levi Ackerman", rarity = "Legendary"},
        {id = 5, name = "Erwin Smith", rarity = "Epic"},
        {id = 6, name = "Hange Zoe", rarity = "Epic"},
        {id = 7, name = "Jean Kirstein", rarity = "Rare"},
        {id = 8, name = "Connie Springer", rarity = "Rare"},
        {id = 9, name = "Sasha Blouse", rarity = "Rare"},
        {id = 10, name = "Historia Reiss", rarity = "Epic"},
        {id = 11, name = "Ymir", rarity = "Epic"},
        {id = 12, name = "Reiner Braun", rarity = "Legendary"},
        {id = 13, name = "Bertholdt Hoover", rarity = "Legendary"},
        {id = 14, name = "Annie Leonhart", rarity = "Legendary"},
        {id = 15, name = "Zeke Yeager", rarity = "Legendary"}
    }
    print("[+] Loaded " .. #self.availableSkins .. " available skins")
end

function CustomSkinsModule:applySkin(skinID)
    local character = self.memory:getLocalCharacter()
    if not character then return false end
    local skinData = nil
    for _, skin in ipairs(self.availableSkins) do
        if skin.id == skinID then
            skinData = skin
            break
        end
    end
    if not skinData then return false end
    pcall(function()
        local args = {
            [1] = "EquipSkin",
            [2] = skinID,
            [3] = skinData.name
        }
        for _, remote in ipairs(self.ReplicatedStorage:GetDescendants()) do
            if remote:IsA("RemoteEvent") and remote.Name:find("Skin") then
                remote:FireServer(unpack(args))
                return true
            end
        end
    end)
    pcall(function()
        local skinFolder = character:FindFirstChild("SkinFolder") or character:FindFirstChild("Skins")
        if skinFolder then
            for _, part in ipairs(skinFolder:GetDescendants()) do
                if part:IsA("BasePart") then
                    if skinID == 1 then
                        part.BrickColor = BrickColor.new("Dark green")
                    elseif skinID == 2 then
                        part.BrickColor = BrickColor.new("Black")
                    elseif skinID == 4 then
                        part.BrickColor = BrickColor.new("White")
                    end
                end
            end
        end
    end)
    return true
end

function CustomSkinsModule:getCurrentSkin()
    return self.currentSkinID
end

function CustomSkinsModule:nextSkin()
    self.currentSkinID = self.currentSkinID + 1
    if self.currentSkinID > #self.availableSkins then
        self.currentSkinID = 1
    end
    if self.enabled then
        self:applySkin(self.currentSkinID)
    end
    local skinName = "None"
    for _, skin in ipairs(self.availableSkins) do
        if skin.id == self.currentSkinID then
            skinName = skin.name
            break
        end
    end
    print("[*] Selected skin: " .. skinName .. " (ID: " .. self.currentSkinID .. ")")
end

function CustomSkinsModule:previousSkin()
    self.currentSkinID = self.currentSkinID - 1
    if self.currentSkinID < 1 then
        self.currentSkinID = #self.availableSkins
    end
    if self.enabled then
        self:applySkin(self.currentSkinID)
    end
end

function CustomSkinsModule:toggle()
    self.enabled = not self.enabled
    if self.enabled then
        self:applySkin(self.currentSkinID)
    end
    print("[*] Custom Skins " .. (self.enabled and "enabled" or "disabled"))
end

function CustomSkinsModule:update()
    if not self.enabled then return end
end

function CustomSkinsModule:shutdown()
    self.enabled = false
end

return CustomSkinsModule