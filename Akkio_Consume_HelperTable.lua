-- Akkio's Consume Helper

-- ============================================================================
-- VERSION & MIGRATION SYSTEM
-- ============================================================================

local ADDON_VERSION = "1.1.3"

-- ============================================================================
-- INITIALIZATION & SETTINGS
-- ============================================================================

if not Akkio_Consume_Helper_Settings then
  Akkio_Consume_Helper_Settings = {}
end

if not Akkio_Consume_Helper_Settings.enabledBuffs then
  Akkio_Consume_Helper_Settings.enabledBuffs = {}
end

-- ============================================================================
-- VERSION MIGRATION SYSTEM
-- ============================================================================

-- Emergency reset function for corrupt settings
local function ResetToDefaults()
  DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BEmergency reset:|r Resetting all settings to defaults due to corruption.")
  
  Akkio_Consume_Helper_Settings = {
    version = ADDON_VERSION,
    enabledBuffs = {},
    onlyForShopping = {},
    settings = {
      scale = 1.0,
      updateTimer = 1,
      iconsPerRow = 5,
      inCombat = false,
      pauseUpdatesInCombat = true,
      hideFrameInCombat = false,
      minimapAngle = 225,
      showTooltips = true,
      hoverToShow = false,
      lockFrame = false,
      splitByCategory = false,
      framePosition = {
        point = "CENTER",
        relativeTo = "UIParent",
        relativePoint = "CENTER",
        xOffset = 0,
        yOffset = 32
      }
    }
  }

  DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Settings reset completed.|r Please reconfigure your buff selections.")
end

local function MigrateSettings()
  -- Initialize version tracking if it doesn't exist
  if not Akkio_Consume_Helper_Settings.version then
    Akkio_Consume_Helper_Settings.version = "0.0.0" -- Assume old version if no version found
  end
  
  local savedVersion = Akkio_Consume_Helper_Settings.version
  local currentVersion = ADDON_VERSION
  
  -- Only run migration if we're updating from an older version
  if savedVersion ~= currentVersion then
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Akkio Consume Helper:|r Migrating settings from v" .. savedVersion .. " to v" .. currentVersion)
    
    -- Check if settings structure is completely corrupted
    if type(Akkio_Consume_Helper_Settings) ~= "table" then
      ResetToDefaults()
      return
    end
    
    -- Migration from pre-1.0.0 versions (any version without proper structure)
    if savedVersion == "0.0.0" then
      -- Reset corrupt or incomplete settings to defaults
      if not Akkio_Consume_Helper_Settings.settings or type(Akkio_Consume_Helper_Settings.settings) ~= "table" then
        DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BWarning:|r Old settings detected. Resetting to defaults for compatibility.")
        Akkio_Consume_Helper_Settings.settings = {}
      end
      
      -- Clean up old enabled buffs that might have invalid format
      if Akkio_Consume_Helper_Settings.enabledBuffs then
        if type(Akkio_Consume_Helper_Settings.enabledBuffs) ~= "table" then
          -- If enabledBuffs isn't a table, reset it
          Akkio_Consume_Helper_Settings.enabledBuffs = {}
        else
          local cleanedBuffs = {}
          for i, buff in ipairs(Akkio_Consume_Helper_Settings.enabledBuffs) do
            -- Only keep buffs that are strings and not empty
            if type(buff) == "string" and string.len(buff) > 0 then
              table.insert(cleanedBuffs, buff)
            end
          end
          Akkio_Consume_Helper_Settings.enabledBuffs = cleanedBuffs
        end
      else
        Akkio_Consume_Helper_Settings.enabledBuffs = {}
      end
    end
    
    -- Future migration points can be added here
    -- Example for future version 1.1.0:
    -- if savedVersion == "1.0.0" then
    --   -- Migration logic for 1.0.0 -> 1.1.0
    -- end
    
    -- Migration for framePosition setting (added in 1.0.4)
    if savedVersion ~= "0.0.0" and not Akkio_Consume_Helper_Settings.settings.framePosition then
      DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Akkio Consume Helper:|r Adding frame position persistence feature")
      Akkio_Consume_Helper_Settings.settings.framePosition = {
        point = "CENTER",
        relativeTo = "UIParent", 
        relativePoint = "CENTER",
        xOffset = 0,
        yOffset = 32
      }
    end
    
    -- Update version after successful migration
    Akkio_Consume_Helper_Settings.version = currentVersion
    DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Migration completed successfully!|r")
  end
end

if not Akkio_Consume_Helper_Settings.settings then 
  Akkio_Consume_Helper_Settings.settings = {
    scale = 1.0,
    updateTimer = 1,
    iconsPerRow = 5,
    inCombat = false,
    pauseUpdatesInCombat = true,
    hideFrameInCombat = false,
    minimapAngle = 225,
    showTooltips = true,
    hoverToShow = false,
    lockFrame = false,
    splitByCategory = false,
    framePosition = {
      point = "CENTER",
      relativeTo = "UIParent", 
      relativePoint = "CENTER",
      xOffset = 0,
      yOffset = 32
    }
  }
end

-- Ensure all settings have default values
if not Akkio_Consume_Helper_Settings.settings.scale then
  Akkio_Consume_Helper_Settings.settings.scale = 1.0
end
if not Akkio_Consume_Helper_Settings.settings.updateTimer then
  Akkio_Consume_Helper_Settings.settings.updateTimer = 1
end
if not Akkio_Consume_Helper_Settings.settings.iconsPerRow then
  Akkio_Consume_Helper_Settings.settings.iconsPerRow = 5
end
if Akkio_Consume_Helper_Settings.settings.inCombat == nil then
  Akkio_Consume_Helper_Settings.settings.inCombat = false
end
if Akkio_Consume_Helper_Settings.settings.pauseUpdatesInCombat == nil then
  Akkio_Consume_Helper_Settings.settings.pauseUpdatesInCombat = true
end
if Akkio_Consume_Helper_Settings.settings.hideFrameInCombat == nil then
  Akkio_Consume_Helper_Settings.settings.hideFrameInCombat = false
end
if not Akkio_Consume_Helper_Settings.settings.minimapAngle then
  Akkio_Consume_Helper_Settings.settings.minimapAngle = 225
end
if Akkio_Consume_Helper_Settings.settings.showTooltips == nil then
  Akkio_Consume_Helper_Settings.settings.showTooltips = true
end
if Akkio_Consume_Helper_Settings.settings.hoverToShow == nil then
  Akkio_Consume_Helper_Settings.settings.hoverToShow = false
end
if not Akkio_Consume_Helper_Settings.settings.iconSpacing then
  Akkio_Consume_Helper_Settings.settings.iconSpacing = 32
end
if Akkio_Consume_Helper_Settings.settings.lockFrame == nil then
  Akkio_Consume_Helper_Settings.settings.lockFrame = false
end
if Akkio_Consume_Helper_Settings.settings.splitByCategory == nil then
  Akkio_Consume_Helper_Settings.settings.splitByCategory = false
end
-- Frame position settings (default to CENTER)
if not Akkio_Consume_Helper_Settings.settings.framePosition then
  Akkio_Consume_Helper_Settings.settings.framePosition = {
    point = "CENTER",
    relativeTo = "UIParent", 
    relativePoint = "CENTER",
    xOffset = 0,
    yOffset = 32
  }
end
if not Akkio_Consume_Helper_Settings.onlyForShopping then
  Akkio_Consume_Helper_Settings.onlyForShopping = {}
end

-- ============================================================================
-- GLOBAL VARIABLES
-- ============================================================================

local enabledBuffs = {}
local updateTimer = Akkio_Consume_Helper_Settings.settings.updateTimer
local allBuffs = Akkio_Consume_Helper_Data.allBuffs

-- Frame references
local buffSelectFrame = nil
local settingsFrame = nil
local buffStatusFrame = nil
local resetConfirmFrame = nil

-- ============================================================================
-- BUFF TRACKER SYSTEM (Normal Buffs Only)
-- ============================================================================

-- Function to ensure buffTracker is properly initialized in saved variables
local function initializeBuffTracker()
  if not Akkio_Consume_Helper_Settings.buffTracker then
    Akkio_Consume_Helper_Settings.buffTracker = {}
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Akkio Consume Helper:|r Initialized buff tracker in saved variables")
  end
end

-- Initialize buff tracker (call this after saved variables are loaded)
initializeBuffTracker()
local buffTracker = Akkio_Consume_Helper_Settings.buffTracker

-- Function to get buff duration from the data table
local function getBuffDuration(buffTexture)
  -- Look up duration in the allBuffs data table by matching buffIcon
  for _, buff in ipairs(allBuffs) do
    if not buff.header and buff.buffIcon == buffTexture and buff.duration then
      return buff.duration
    end
  end
  
  -- Default duration for unknown buffs (30 minutes = 1800 seconds)
  return 1800
end

-- Function to update buff tracker for normal buffs
local function updateBuffTracker(buffName, buffTexture)
  if not buffName or not buffTexture then return end
  
  local now = GetTime()
  local duration = getBuffDuration(buffTexture)
  
  -- Ensure buffTracker is properly initialized
  if not buffTracker then
    initializeBuffTracker()
    buffTracker = Akkio_Consume_Helper_Settings.buffTracker
  end
  
  if not buffTracker[buffName] then
    -- Brand new buff - start tracking
    buffTracker[buffName] = {
      startTime = now,
      duration = duration,
      lastSeen = now,
      icon = buffTexture
    }
    
    -- Explicitly save to ensure persistence
    Akkio_Consume_Helper_Settings.buffTracker[buffName] = buffTracker[buffName]
  else
    -- Buff already being tracked and is still active
    local tracker = buffTracker[buffName]
    local elapsedTime = now - tracker.startTime
    
    -- Timer drift detection: if elapsed time significantly exceeds expected duration,
    -- the buff was likely reapplied/refreshed - reset the timer
    local driftThreshold = 60 -- 60 seconds tolerance
    if elapsedTime > (tracker.duration + driftThreshold) then
      -- Timer drift detected - reset startTime to current time
      buffTracker[buffName].startTime = now
      buffTracker[buffName].duration = duration
      buffTracker[buffName].lastSeen = now
      buffTracker[buffName].icon = buffTexture
    else
      -- Normal update - just refresh duration and last seen time
      buffTracker[buffName].duration = duration
      buffTracker[buffName].lastSeen = now
      buffTracker[buffName].icon = buffTexture
    end
    
    -- Explicitly save changes
    Akkio_Consume_Helper_Settings.buffTracker[buffName] = buffTracker[buffName]
  end
end

-- Function to check if a tracked buff is still valid based on timestamp
local function isBuffStillValid(buffName)
  if not buffTracker[buffName] then return false end
  
  local tracker = buffTracker[buffName]
  local now = GetTime()
  local elapsedTime = now - tracker.startTime
  
  return elapsedTime < tracker.duration
end

-- Function to get remaining time for a buff
local function getBuffRemainingTime(buffName)
  if not buffTracker[buffName] then return 0 end
  
  local tracker = buffTracker[buffName]
  local now = GetTime()
  local elapsedTime = now - tracker.startTime
  local remainingTime = tracker.duration - elapsedTime
  
  -- Drift detection: if the timer shows negative time (elapsed > duration),
  -- this indicates timer drift even without buff reapplication
  local driftThreshold = 60 -- 60 seconds tolerance for natural expiration
  if remainingTime < -driftThreshold then
    -- Significant negative time detected - timer has drifted
    -- Clear the tracker since the buff should have expired long ago
    buffTracker[buffName] = nil
    if Akkio_Consume_Helper_Settings.buffTracker then
      Akkio_Consume_Helper_Settings.buffTracker[buffName] = nil
    end
    return 0
  end
  
  return math.max(0, remainingTime)
end

-- Function to format time display
local function formatTimeRemaining(seconds)
  if seconds <= 0 then return "" end
  
  if seconds >= 60 then
    return math.ceil(seconds / 60) .. "m"
  else
    return math.floor(seconds) .. "s"
  end
end

-- Forward declarations for functions that reference each other
local BuildBuffSelectionUI
local BuildSettingsUI
local BuildMainFrame
local lastActiveTab = 1
local BuildBuffStatusUI
local CreateMinimapButton
local BuildResetConfirmationUI

-- Persistent main frame reference
local mainFrame = nil

-- ============================================================================
-- UTILITY FUNCTIONS
-- ============================================================================

local function wipeTable(tbl)
  for k in pairs(tbl) do
    tbl[k] = nil
  end
end

local function findItemInBagAndGetAmount(itemName)
  -- Cache bag scan results to avoid repeated scans during the same update cycle
  if not buffStatusFrame then
    -- If buffStatusFrame doesn't exist yet, do a simple scan
    local totalAmount = 0
    for bag = 0, 4 do -- 0 = backpack, 1–4 = bags
      local bagSlots = GetContainerNumSlots(bag)
      if bagSlots and bagSlots > 0 then
        for slot = 1, bagSlots do
          local itemLink = GetContainerItemLink(bag, slot)
          if itemLink then
            -- Extract item name from link, handling items with charges
            local _, _, linkItemName = string.find(itemLink, "%[(.-)%]")
            -- Remove charge information if present (e.g., "Brilliant Wizard Oil (5)" -> "Brilliant Wizard Oil")
            if linkItemName then
              linkItemName = string.gsub(linkItemName, " %(%d+%)$", "")
              if linkItemName == itemName then
                local _, itemCount = GetContainerItemInfo(bag, slot)
                -- Handle charged items (negative count) vs stacked items (positive count)
                if itemCount then
                  if itemCount < 0 then
                    -- Charged item: count represents charges remaining, convert to positive
                    totalAmount = totalAmount + math.abs(itemCount)
                  else
                    -- Regular stacked item: count represents stack size
                    totalAmount = totalAmount + itemCount
                  end
                end
              end
            end
          end
        end
      end
    end
    return totalAmount
  end
  
  if not buffStatusFrame.bagCache then
    buffStatusFrame.bagCache = {}
    buffStatusFrame.bagCacheTime = 0
  end
  
  local now = GetTime()
  -- Refresh cache every 2 seconds or when forced
  if now - buffStatusFrame.bagCacheTime > 2 then
    wipeTable(buffStatusFrame.bagCache)
    
    for bag = 0, 4 do -- 0 = backpack, 1–4 = bags
      local bagSlots = GetContainerNumSlots(bag)
      if bagSlots and bagSlots > 0 then
        for slot = 1, bagSlots do
          local itemLink = GetContainerItemLink(bag, slot)
          if itemLink then
            local _, itemCount = GetContainerItemInfo(bag, slot)
            -- Extract item name from link, handling items with charges
            local _, _, linkItemName = string.find(itemLink, "%[(.-)%]")
            if linkItemName then
              -- Remove charge information if present (e.g., "Brilliant Wizard Oil (5)" -> "Brilliant Wizard Oil")
              linkItemName = string.gsub(linkItemName, " %(%d+%)$", "")
              if linkItemName and itemCount then
                -- Handle charged items (negative count) vs stacked items (positive count)
                local actualCount = itemCount
                if itemCount < 0 then
                  -- Charged item: count represents charges remaining, convert to positive
                  actualCount = math.abs(itemCount)
                end
                buffStatusFrame.bagCache[linkItemName] = (buffStatusFrame.bagCache[linkItemName] or 0) + actualCount
              end
            end
          end
        end
      end
    end
    buffStatusFrame.bagCacheTime = now
  end
  
  return buffStatusFrame.bagCache[itemName] or 0
end

local function findItemChargesInBag(itemName)
  if not getglobal("ItemDataScanTooltip") then
    CreateFrame("GameTooltip", "ItemDataScanTooltip", UIParent, "GameTooltipTemplate")
  end
  local scanTip = getglobal("ItemDataScanTooltip")

  local totalCharges = 0
  for bag = 0, 4 do
    for slot = 1, GetContainerNumSlots(bag) do
      local itemLink = GetContainerItemLink(bag, slot)
      if itemLink then
        local _, _, linkItemName = string.find(itemLink, "%[(.-)%]")
        if linkItemName then
          local baseName = string.gsub(linkItemName, " %(%d+%)$", "")
          if baseName == itemName then
            scanTip:SetOwner(UIParent, "ANCHOR_NONE")
            scanTip:ClearLines()
            scanTip:SetBagItem(bag, slot)
            local charges = nil
            for i = 1, scanTip:NumLines() do
              local line = getglobal("ItemDataScanTooltipTextLeft" .. i)
              if line and line:GetText() then
                local _, _, chargesStr = string.find(line:GetText(), "(%d+) Charge")
                if chargesStr then
                  charges = tonumber(chargesStr)
                  break
                end
              end
            end
            if charges then
              totalCharges = totalCharges + charges
            else
              local _, itemCount = GetContainerItemInfo(bag, slot)
              if itemCount then
                totalCharges = totalCharges + math.abs(itemCount)
              end
            end
          end
        end
      end
    end
  end
  return totalCharges
end

local function checkWeaponEnchant(slot)
  -- Check if a weapon enchant is present on the specified slot
  -- Returns true if an enchant is detected, false otherwise
  
  if slot == "mainhand" then
    local hasMainHandEnchant, _, _, hasOffHandEnchant, _, _ = GetWeaponEnchantInfo()
    return hasMainHandEnchant
  elseif slot == "offhand" then
    local hasMainHandEnchant, _, _, hasOffHandEnchant, _, _ = GetWeaponEnchantInfo()
    return hasOffHandEnchant
  end
  
  return false
end

local function checkHasBuff(data)
  if data.checkInventory then
    return findItemInBagAndGetAmount(data.name) > 0
  elseif data.isWeaponEnchant then
    return checkWeaponEnchant(data.slot)
  else
    for i = 1, 40 do
      local buffTexture = UnitBuff("player", i)
      if not buffTexture then break end
      if buffTexture == data.buffIcon or buffTexture == data.raidbuffIcon then
        return true
      end
    end
    return false
  end
end

local function UpdateBuffStatusOnly()
  -- Fast update that only changes visual states without rebuilding UI
  if not buffStatusFrame or not buffStatusFrame.children then
    return
  end
  
  -- Check combat settings first
  if Akkio_Consume_Helper_Settings.settings.pauseUpdatesInCombat and 
     Akkio_Consume_Helper_Settings.settings.inCombat then
    return
  end
  
  -- First pass: scan active buffs and update tracker for normal buffs
  local activeBuffs = {}
  for i = 1, 40 do
    local buffTexture = UnitBuff("player", i)
    if not buffTexture then break end
    activeBuffs[buffTexture] = true
  end
  
  -- Only update existing icons instead of rebuilding entire UI
  for i = 1, table.getn(buffStatusFrame.children) do
    local icon = buffStatusFrame.children[i]
    if icon and icon.buffdata then
      local data = icon.buffdata
      local hasBuff = false
      
      -- Check buff status efficiently
      if data.checkInventory or data.isWeaponEnchant then
        hasBuff = checkHasBuff(data)
      else
        -- Enhanced buff checking for normal buffs with timestamp tracking
        local buffFound = false
        for buffTexture, _ in pairs(activeBuffs) do
          if buffTexture == data.buffIcon or buffTexture == data.raidbuffIcon then
            buffFound = true
            -- Update tracker when buff is found active (use data.name as consistent key)
            updateBuffTracker(data.name, buffTexture)
            break
          end
        end
        
        -- If buff not currently active, check if still valid based on timestamp
        if buffFound then
          hasBuff = true
        else
          -- Buff not found in active buffs - could be expired OR manually removed
          if isBuffStillValid(data.name) then
            -- Timestamp says it should still be active, but it's not found
            -- This means it was manually removed - clear the tracker
            if buffTracker and buffTracker[data.name] then
              buffTracker[data.name] = nil
              Akkio_Consume_Helper_Settings.buffTracker[data.name] = nil
            end
            hasBuff = false
          else
            -- Timestamp expired naturally - also clear the tracker
            if buffTracker and buffTracker[data.name] then
              buffTracker[data.name] = nil
              Akkio_Consume_Helper_Settings.buffTracker[data.name] = nil
            end
            hasBuff = false
          end
        end
      end
      
      -- Update icon color only if needed
      local iconTexture = icon:GetNormalTexture()
      if iconTexture then
        if hasBuff then
          iconTexture:SetVertexColor(1, 1, 1, 1)
        else
          iconTexture:SetVertexColor(1, 0, 0, 1)
        end
      end
      
      -- Update timer display for normal buffs (only if they have duration and timer label)
      if not data.isWeaponEnchant and data.duration and icon.timerLabel then
        local remainingTime = getBuffRemainingTime(data.name)
        icon.timerLabel:SetText(formatTimeRemaining(remainingTime))
      end
      
      -- Update timer display for weapon enchants using GetWeaponEnchantInfo
      if data.isWeaponEnchant and icon.timerLabel then
        if data.slot == "mainhand" then
          local hasMainHandEnchant, mainHandExpiration = GetWeaponEnchantInfo()
          if hasMainHandEnchant and mainHandExpiration then
            local remainingSeconds = mainHandExpiration / 1000 -- Convert milliseconds to seconds
            icon.timerLabel:SetText(formatTimeRemaining(remainingSeconds))
          else
            icon.timerLabel:SetText("")
          end
        elseif data.slot == "offhand" then
          local _, _, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
          if hasOffHandEnchant and offHandExpiration then
            local remainingSeconds = offHandExpiration / 1000 -- Convert milliseconds to seconds
            icon.timerLabel:SetText(formatTimeRemaining(remainingSeconds))
          else
            icon.timerLabel:SetText("")
          end
        end
      end
      
      -- Update item count if it has an amount label
      if icon.amountLabel then
        local itemAmount = data.isWeaponEnchant and findItemChargesInBag(data.name) or findItemInBagAndGetAmount(data.name)
        icon.amountLabel:SetText(itemAmount > 0 and itemAmount or "")
      end
    end
  end
end

-- Expose bag scan functions for use by other modules (e.g. Tracker tab)
Akkio_Consume_Helper_Tracker = {
  getAmount  = findItemInBagAndGetAmount,
  getCharges = findItemChargesInBag,
}

local function ForceRefreshBuffStatus()
  -- Force an immediate full rebuild and reset cache
  if buffStatusFrame then
    if buffStatusFrame.bagCache then
      wipeTable(buffStatusFrame.bagCache)
      buffStatusFrame.bagCacheTime = 0
    end
    if buffStatusFrame.ticker then
      buffStatusFrame.ticker.lastFullUpdate = GetTime() - 11 -- Force next update to rebuild
    end
    
    BuildBuffStatusUI()
  end
  if Akkio_Consume_Helper_Shopping and Akkio_Consume_Helper_Shopping.RefreshTracker then
    Akkio_Consume_Helper_Shopping.RefreshTracker()
  end
end

local function findAndUseItemByName(itemName)
  for bag = 0, 4 do -- 0 = backpack, 1–4 = bags
    for slot = 1, GetContainerNumSlots(bag) do
      local itemLink = GetContainerItemLink(bag, slot)
      if itemLink then
        -- Extract item name from link, handling items with charges
        local _, _, linkItemName = string.find(itemLink, "%[(.-)%]")
        if linkItemName then
          -- Remove charge information if present (e.g., "Brilliant Wizard Oil (5)" -> "Brilliant Wizard Oil")
          linkItemName = string.gsub(linkItemName, " %(%d+%)$", "")
          if linkItemName == itemName then
            UseContainerItem(bag, slot)
            return true -- stop once found and used
          end
        end
      end
    end
  end
  DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BItem '" .. itemName .. "' not found in bags.|r")
  return false
end

local function applyWeaponEnchant(itemName, slot)
  -- Find the weapon enchant item in bags and put it on cursor for manual application
  for bag = 0, 4 do -- 0 = backpack, 1–4 = bags
    for bagSlot = 1, GetContainerNumSlots(bag) do
      local itemLink = GetContainerItemLink(bag, bagSlot)
      if itemLink then
        -- Extract item name from link, handling items with charges
        local _, _, linkItemName = string.find(itemLink, "%[(.-)%]")
        if linkItemName then
          -- Remove charge information if present (e.g., "Brilliant Wizard Oil (5)" -> "Brilliant Wizard Oil")
          linkItemName = string.gsub(linkItemName, " %(%d+%)$", "")
          if linkItemName == itemName then
            if slot == "mainhand" then
              if not GetInventoryItemTexture("player", 16) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BNo weapon equipped in main hand slot.|r")
                return false
              end
              UseContainerItem(bag, bagSlot)
              PickupInventoryItem(16)
              ReplaceEnchant()
              ClearCursor()
              DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00" .. itemName .. " applied to main hand.|r")
            elseif slot == "offhand" then
              if not GetInventoryItemTexture("player", 17) then
                DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BNo weapon equipped in off hand slot.|r")
                return false
              end
              UseContainerItem(bag, bagSlot)
              PickupInventoryItem(17)
              ReplaceEnchant()
              ClearCursor()
              DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00" .. itemName .. " applied to off hand.|r")
            end
            return true
          end
        end
      end
    end
  end
  DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BItem '" .. itemName .. "' not found in bags.|r")
  return false
end

-- ============================================================================
-- MAIN TABBED FRAME
-- ============================================================================

BuildMainFrame = function(defaultTab)
  defaultTab = defaultTab or lastActiveTab

  if mainFrame then
    if mainFrame:IsShown() and defaultTab == mainFrame.activeTab then
      mainFrame:Hide()
      return
    end
    mainFrame:Show()
    mainFrame.showTab(defaultTab)
    return
  end

  local frameW = 620
  local frameH = 840

  mainFrame = CreateFrame("Frame", "AkkioMainFrame", UIParent)
  tinsert(UISpecialFrames, "AkkioMainFrame")
  mainFrame:SetWidth(frameW)
  mainFrame:SetHeight(frameH)
  mainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  mainFrame:SetFrameStrata("DIALOG")
  mainFrame:SetFrameLevel(50)
  mainFrame:SetMovable(true)
  mainFrame:EnableMouse(true)
  mainFrame:RegisterForDrag("LeftButton")
  mainFrame:SetScript("OnDragStart", function() mainFrame:StartMoving() end)
  mainFrame:SetScript("OnDragStop", function() mainFrame:StopMovingOrSizing() end)
  mainFrame:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 8, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
  })
  mainFrame:SetBackdropColor(0.1, 0.1, 0.2, 0.95)
  mainFrame:SetBackdropBorderColor(0.8, 0.8, 1, 1)

  -- Title
  local title = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("TOP", mainFrame, "TOP", 0, -16)
  title:SetText("Akkio's Consume Helper")

  -- Close X button
  local closeXButton = CreateFrame("Button", nil, mainFrame)
  closeXButton:SetWidth(30)
  closeXButton:SetHeight(30)
  closeXButton:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -15, -15)
  closeXButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
  closeXButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
  closeXButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
  closeXButton:SetScript("OnClick", function() mainFrame:Hide() end)

  -- Tab buttons
  local tabNames = { "Settings", "Select Buffs", "Shopping List" }
  local tabButtons = {}
  local contentPanels = {}
  local tabBuilt = {}
  mainFrame.activeTab = 0

  for i, name in ipairs(tabNames) do
    local btn = CreateFrame("Button", nil, mainFrame, "UIPanelButtonTemplate")
    btn:SetWidth(140)
    btn:SetHeight(26)
    btn:SetText(name)
    if i == 1 then
      btn:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 15, -42)
    else
      btn:SetPoint("LEFT", tabButtons[i - 1], "RIGHT", 5, 0)
    end
    tabButtons[i] = btn

    local panel = CreateFrame("Frame", nil, mainFrame)
    panel:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 10, -75)
    panel:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -10, 10)
    panel:Hide()
    contentPanels[i] = panel
  end

  -- Tab switching
  local function showTab(tabIndex)
    for i = 1, 3 do
      contentPanels[i]:Hide()
      tabButtons[i]:Enable()
    end
    contentPanels[tabIndex]:Show()
    tabButtons[tabIndex]:Disable()
    mainFrame.activeTab = tabIndex
    lastActiveTab = tabIndex
  end

  tabButtons[1]:SetScript("OnClick", function()
    if not tabBuilt[1] then
      BuildSettingsUI(contentPanels[1])
      tabBuilt[1] = true
    end
    showTab(1)
  end)

  tabButtons[2]:SetScript("OnClick", function()
    if not tabBuilt[2] then
      BuildBuffSelectionUI(contentPanels[2])
      tabBuilt[2] = true
    end
    showTab(2)
  end)

  tabButtons[3]:SetScript("OnClick", function()
    if not tabBuilt[3] then
      if Akkio_Consume_Helper_Shopping and Akkio_Consume_Helper_Shopping.BuildTrackerUI then
        Akkio_Consume_Helper_Shopping.BuildTrackerUI(contentPanels[3])
      end
      tabBuilt[3] = true
    end
    showTab(3)
  end)

  mainFrame.showTab = showTab
  mainFrame.tabBuilt = tabBuilt
  mainFrame.contentPanels = contentPanels

  -- Build and show the default tab
  if defaultTab == 1 then
    BuildSettingsUI(contentPanels[1])
    tabBuilt[1] = true
  elseif defaultTab == 2 then
    BuildBuffSelectionUI(contentPanels[2])
    tabBuilt[2] = true
  elseif defaultTab == 3 then
    if Akkio_Consume_Helper_Shopping and Akkio_Consume_Helper_Shopping.BuildTrackerUI then
      Akkio_Consume_Helper_Shopping.BuildTrackerUI(contentPanels[3])
    end
    tabBuilt[3] = true
  end
  showTab(defaultTab)

  mainFrame:Show()
end

-- ============================================================================
-- UI CREATION FUNCTIONS
-- ============================================================================

BuildSettingsUI = function(panel)
  -- When called without a panel, open via the main tabbed frame
  if not panel then
    BuildMainFrame(1)
    return
  end

  local settingsFrame = panel

  -- Scale Slider Label
  local scaleLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  scaleLabel:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", 20, -15)
  scaleLabel:SetText("Buff Status UI Scale:")

  -- Scale Slider
  local scaleSlider = CreateFrame("Slider", nil, settingsFrame, "OptionsSliderTemplate")
  scaleSlider:SetWidth(180)
  scaleSlider:SetHeight(20)
  scaleSlider:SetPoint("TOPLEFT", scaleLabel, "BOTTOMLEFT", 0, -20)
  scaleSlider:SetMinMaxValues(0.5, 2.0)
  -- Use saved scale setting or default to 1.0
  local savedScale = 1.0
  if Akkio_Consume_Helper_Settings.settings and Akkio_Consume_Helper_Settings.settings.scale then
    savedScale = Akkio_Consume_Helper_Settings.settings.scale
  end
  scaleSlider:SetValue(savedScale)
  scaleSlider:SetValueStep(0.1)

  -- Scale Value Display
  local scaleValueText = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  scaleValueText:SetPoint("BOTTOM", scaleSlider, "TOP", 0, 5)
  scaleValueText:SetText(tostring(savedScale))

  scaleSlider:SetScript("OnValueChanged", function()
    local value = this:GetValue()
    scaleValueText:SetText(tostring(value))
  end)

  -- Layout Settings Section (Left side, under scale slider)
  local layoutLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  layoutLabel:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", 20, -100)
  layoutLabel:SetText("Layout Settings:")

  -- Timer Interval Label
  local timerLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  timerLabel:SetPoint("TOPLEFT", layoutLabel, "BOTTOMLEFT", 0, -15)
  timerLabel:SetText("Update Interval (seconds):")

  -- Timer Input Box
  local timerEditBox = CreateFrame("EditBox", "AkkioTimerEditBox", settingsFrame, "AkkioEditBoxTemplate")
  timerEditBox:SetPoint("TOPLEFT", timerLabel, "BOTTOMLEFT", 0, -10)
  timerEditBox:SetMaxLetters(3)
  -- Use saved timer setting or default to 1
  local savedTimer = 1
  if Akkio_Consume_Helper_Settings.settings and Akkio_Consume_Helper_Settings.settings.updateTimer then
    savedTimer = Akkio_Consume_Helper_Settings.settings.updateTimer
  end
  timerEditBox:SetText(tostring(savedTimer))

  timerEditBox:SetScript("OnEnterPressed", function()
    this:ClearFocus()
    local value = tonumber(this:GetText())
    if value and value > 0 then
      updateTimer = value
      DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Update interval set to:|r " .. value .. " seconds")
    else
      this:SetText("1")
      DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BInvalid value. Reset to 1 second.|r")
    end
  end)

  -- Icons Per Row Label
  local iconsPerRowLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  iconsPerRowLabel:SetPoint("TOPLEFT", timerEditBox, "BOTTOMLEFT", 0, -20)
  iconsPerRowLabel:SetText("Icons Per Row (1-10):")

  -- Icons Per Row Input Box
  local iconsPerRowEditBox = CreateFrame("EditBox", "AkkioIconsPerRowEditBox", settingsFrame, "AkkioEditBoxTemplate")
  iconsPerRowEditBox:SetPoint("TOPLEFT", iconsPerRowLabel, "BOTTOMLEFT", 0, -10)
  iconsPerRowEditBox:SetMaxLetters(2)
  -- Load saved value or default to 5
  local savedIconsPerRow = "5"
  if Akkio_Consume_Helper_Settings.settings and Akkio_Consume_Helper_Settings.settings.iconsPerRow then
    savedIconsPerRow = tostring(Akkio_Consume_Helper_Settings.settings.iconsPerRow)
  end
  iconsPerRowEditBox:SetText(savedIconsPerRow)
  
  iconsPerRowEditBox:SetScript("OnEnterPressed", function()
    this:ClearFocus()
    local value = tonumber(this:GetText())
    if value and value > 0 and value <= 10 then
      DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Icons per row set to:|r " .. value)
    else
      this:SetText("5")
      DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BInvalid value. Must be between 1-10. Reset to 5.|r")
    end
  end)

  -- Icon Spacing Label
  local iconSpacingLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  iconSpacingLabel:SetPoint("TOPLEFT", iconsPerRowEditBox, "BOTTOMLEFT", 0, -20)
  iconSpacingLabel:SetText("Icon Spacing (30-64 pixels):")

  -- Icon Spacing Input Box
  local iconSpacingEditBox = CreateFrame("EditBox", "AkkioIconSpacingEditBox", settingsFrame, "AkkioEditBoxTemplate")
  iconSpacingEditBox:SetPoint("TOPLEFT", iconSpacingLabel, "BOTTOMLEFT", 0, -10)
  iconSpacingEditBox:SetMaxLetters(2)
  -- Load saved value or default to 32
  local savedIconSpacing = "32"
  if Akkio_Consume_Helper_Settings.settings and Akkio_Consume_Helper_Settings.settings.iconSpacing then
    savedIconSpacing = tostring(Akkio_Consume_Helper_Settings.settings.iconSpacing)
  end
  iconSpacingEditBox:SetText(savedIconSpacing)
  
  iconSpacingEditBox:SetScript("OnEnterPressed", function()
    this:ClearFocus()
    local value = tonumber(this:GetText())
    if value and value >= 30 and value <= 64 then
      DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Icon spacing set to:|r " .. value .. " pixels")
    else
      this:SetText("32")
      DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BInvalid value. Must be between 30-64 pixels. Reset to 32.|r")
    end
  end)

  -- Split by Category Checkbox
  local splitByCategoryCheckbox = CreateFrame("CheckButton", "AkkioSplitByCategoryCheckbox", settingsFrame, "UICheckButtonTemplate")
  splitByCategoryCheckbox:SetWidth(20)
  splitByCategoryCheckbox:SetHeight(20)
  splitByCategoryCheckbox:SetPoint("TOPLEFT", iconSpacingEditBox, "BOTTOMLEFT", 0, -20)
  splitByCategoryCheckbox:SetChecked(Akkio_Consume_Helper_Settings.settings.splitByCategory)

  local splitByCategoryLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  splitByCategoryLabel:SetPoint("LEFT", splitByCategoryCheckbox, "RIGHT", 5, 0)
  splitByCategoryLabel:SetText("Split by category")

  -- Combat Settings Section (Left side, bottom)
  local combatLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  combatLabel:SetPoint("TOPLEFT", splitByCategoryCheckbox, "BOTTOMLEFT", 0, -20)
  combatLabel:SetText("Combat Settings:")

  -- Pause Updates in Combat Checkbox
  local pauseUpdatesCheckbox = CreateFrame("CheckButton", "AkkioPauseUpdatesCheckbox", settingsFrame, "UICheckButtonTemplate")
  pauseUpdatesCheckbox:SetWidth(20)
  pauseUpdatesCheckbox:SetHeight(20)
  pauseUpdatesCheckbox:SetPoint("TOPLEFT", combatLabel, "BOTTOMLEFT", 0, -15)
  pauseUpdatesCheckbox:SetChecked(Akkio_Consume_Helper_Settings.settings.pauseUpdatesInCombat)

  local pauseUpdatesLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  pauseUpdatesLabel:SetPoint("LEFT", pauseUpdatesCheckbox, "RIGHT", 5, 0)
  pauseUpdatesLabel:SetText("Pause UI updates during combat")

  -- Hide Frame in Combat Checkbox
  local hideFrameCheckbox = CreateFrame("CheckButton", "AkkioHideFrameCheckbox", settingsFrame, "UICheckButtonTemplate")
  hideFrameCheckbox:SetWidth(20)
  hideFrameCheckbox:SetHeight(20)
  hideFrameCheckbox:SetPoint("TOPLEFT", pauseUpdatesCheckbox, "BOTTOMLEFT", 0, -10)
  hideFrameCheckbox:SetChecked(Akkio_Consume_Helper_Settings.settings.hideFrameInCombat)

  local hideFrameLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  hideFrameLabel:SetPoint("LEFT", hideFrameCheckbox, "RIGHT", 5, 0)
  hideFrameLabel:SetText("Hide buff status frame during combat")

  -- Display Settings Section (Below combat settings)
  local displayLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  displayLabel:SetPoint("TOPLEFT", hideFrameCheckbox, "BOTTOMLEFT", 0, -40)
  displayLabel:SetText("Display Settings:")

  -- Show Tooltips Checkbox
  local showTooltipsCheckbox = CreateFrame("CheckButton", "AkkioShowTooltipsCheckbox", settingsFrame, "UICheckButtonTemplate")
  showTooltipsCheckbox:SetWidth(20)
  showTooltipsCheckbox:SetHeight(20)
  showTooltipsCheckbox:SetPoint("TOPLEFT", displayLabel, "BOTTOMLEFT", 0, -15)
  showTooltipsCheckbox:SetChecked(Akkio_Consume_Helper_Settings.settings.showTooltips)

  local showTooltipsLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  showTooltipsLabel:SetPoint("LEFT", showTooltipsCheckbox, "RIGHT", 5, 0)
  showTooltipsLabel:SetText("Show detailed tooltips on buff icons")

  -- Hover to Show Checkbox
  local hoverToShowCheckbox = CreateFrame("CheckButton", "AkkioHoverToShowCheckbox", settingsFrame, "UICheckButtonTemplate")
  hoverToShowCheckbox:SetWidth(20)
  hoverToShowCheckbox:SetHeight(20)
  hoverToShowCheckbox:SetPoint("TOPLEFT", showTooltipsCheckbox, "BOTTOMLEFT", 0, -10)
  hoverToShowCheckbox:SetChecked(Akkio_Consume_Helper_Settings.settings.hoverToShow)

  local hoverToShowLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  hoverToShowLabel:SetPoint("LEFT", hoverToShowCheckbox, "RIGHT", 5, 0)
  hoverToShowLabel:SetText("Show frame only when hovering buff icons")

  -- Lock Frame Checkbox
  local lockFrameCheckbox = CreateFrame("CheckButton", "AkkioLockFrameCheckbox", settingsFrame, "UICheckButtonTemplate")
  lockFrameCheckbox:SetWidth(20)
  lockFrameCheckbox:SetHeight(20)
  lockFrameCheckbox:SetPoint("TOPLEFT", hoverToShowCheckbox, "BOTTOMLEFT", 0, -10)
  lockFrameCheckbox:SetChecked(Akkio_Consume_Helper_Settings.settings.lockFrame or false)

  local lockFrameLabel = settingsFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  lockFrameLabel:SetPoint("LEFT", lockFrameCheckbox, "RIGHT", 5, 0)
  lockFrameLabel:SetText("Lock frame (hide background, prevent dragging)")

  -- Apply Button
  local applyButton = CreateFrame("Button", nil, settingsFrame, "UIPanelButtonTemplate")
  applyButton:SetWidth(80)
  applyButton:SetHeight(25)
  applyButton:SetPoint("BOTTOMLEFT", settingsFrame, "BOTTOMLEFT", 20, 20)
  applyButton:SetText("Apply")
  applyButton:SetScript("OnClick", function()
    -- Apply all settings
    local scaleValue = scaleSlider:GetValue()
    local timerValue = tonumber(timerEditBox:GetText()) or 1
    local iconsPerRowValue = tonumber(iconsPerRowEditBox:GetText()) or 5
    local iconSpacingValue = tonumber(iconSpacingEditBox:GetText()) or 32
    local pauseUpdatesValue = pauseUpdatesCheckbox:GetChecked() == 1
    local hideFrameValue = hideFrameCheckbox:GetChecked() == 1
    local showTooltipsValue = showTooltipsCheckbox:GetChecked() == 1
    local hoverToShowValue = hoverToShowCheckbox:GetChecked() == 1
    local lockFrameValue = lockFrameCheckbox:GetChecked() == 1
    local splitByCategoryValue = splitByCategoryCheckbox:GetChecked() == 1

    -- Validate timer value
    if timerValue < 1 or timerValue > 60 then
      timerValue = 1
      timerEditBox:SetText("1")
    end
    
    -- Validate icons per row value
    if iconsPerRowValue < 1 or iconsPerRowValue > 10 then
      iconsPerRowValue = 5
      iconsPerRowEditBox:SetText("5")
    end
    
    -- Validate icon spacing value
    if iconSpacingValue < 30 or iconSpacingValue > 64 then
      iconSpacingValue = 32
      iconSpacingEditBox:SetText("32")
    end
    
    -- Update global variable
    updateTimer = timerValue
    
    -- Store all settings
    Akkio_Consume_Helper_Settings.settings.scale = scaleValue
    Akkio_Consume_Helper_Settings.settings.updateTimer = timerValue
    Akkio_Consume_Helper_Settings.settings.iconsPerRow = iconsPerRowValue
    Akkio_Consume_Helper_Settings.settings.iconSpacing = iconSpacingValue
    Akkio_Consume_Helper_Settings.settings.pauseUpdatesInCombat = pauseUpdatesValue
    Akkio_Consume_Helper_Settings.settings.hideFrameInCombat = hideFrameValue
    Akkio_Consume_Helper_Settings.settings.showTooltips = showTooltipsValue
    Akkio_Consume_Helper_Settings.settings.hoverToShow = hoverToShowValue
    Akkio_Consume_Helper_Settings.settings.lockFrame = lockFrameValue
    Akkio_Consume_Helper_Settings.settings.splitByCategory = splitByCategoryValue

    if buffStatusFrame then
      buffStatusFrame:SetScale(scaleValue)
      
      -- Apply lock frame setting immediately
      if lockFrameValue then
        buffStatusFrame:SetMovable(false)
        buffStatusFrame:RegisterForDrag()
        if buffStatusFrame.bg then buffStatusFrame.bg:Hide() end
        if buffStatusFrame.titleBar then buffStatusFrame.titleBar:Hide() end
        if buffStatusFrame.title then buffStatusFrame.title:Hide() end
      else
        buffStatusFrame:SetMovable(true)
        buffStatusFrame:RegisterForDrag("LeftButton")
        if buffStatusFrame.bg then buffStatusFrame.bg:Show() end
        if buffStatusFrame.titleBar then buffStatusFrame.titleBar:Show() end
        if buffStatusFrame.title then buffStatusFrame.title:Show() end
      end
      
      -- Apply hover-to-show setting immediately
      if hoverToShowValue then
        buffStatusFrame.hoverCount = 0 -- Reset hover count FIRST
        -- Force immediate hide by rebuilding the UI which will respect the new setting
        BuildBuffStatusUI()
        -- THEN set alpha to completely hide the frame
        buffStatusFrame:SetAlpha(0.0) -- Completely transparent
      else
        buffStatusFrame:SetAlpha(1.0) -- Make it fully visible
        -- Force refresh to apply new settings efficiently
        ForceRefreshBuffStatus()
      end
    end
    
    DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Akkio Consume Helper:|r Settings applied successfully!")
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Scale:|r " .. tostring(scaleValue) .. " |cffFFFF00Timer:|r " .. timerValue .. "s |cffFFFF00Icons per row:|r " .. iconsPerRowValue .. " |cffFFFF00Icon spacing:|r " .. iconSpacingValue .. "px")
  end)

  -- Reset value button
  local cancelButton = CreateFrame("Button", nil, settingsFrame, "UIPanelButtonTemplate")
  cancelButton:SetWidth(90)
  cancelButton:SetHeight(25)
  cancelButton:SetPoint("LEFT", applyButton, "RIGHT", 10, 0)
  cancelButton:SetText("Reset values")
  cancelButton:SetScript("OnClick", function()
    -- Reset values to defaults
    scaleSlider:SetValue(1.0)
    scaleValueText:SetText("1.0")
    timerEditBox:SetText("1")
    iconsPerRowEditBox:SetText("5")
    iconSpacingEditBox:SetText("32")
    pauseUpdatesCheckbox:SetChecked(true)
    hideFrameCheckbox:SetChecked(false)
    showTooltipsCheckbox:SetChecked(true)
    hoverToShowCheckbox:SetChecked(false)
    lockFrameCheckbox:SetChecked(false)
    splitByCategoryCheckbox:SetChecked(false)

    -- Reset saved settings to defaults
    Akkio_Consume_Helper_Settings.settings.scale = 1.0
    Akkio_Consume_Helper_Settings.settings.updateTimer = 1
    Akkio_Consume_Helper_Settings.settings.iconsPerRow = 5
    Akkio_Consume_Helper_Settings.settings.iconSpacing = 32
    Akkio_Consume_Helper_Settings.settings.pauseUpdatesInCombat = true
    Akkio_Consume_Helper_Settings.settings.hideFrameInCombat = false
    Akkio_Consume_Helper_Settings.settings.showTooltips = true
    Akkio_Consume_Helper_Settings.settings.hoverToShow = false
    Akkio_Consume_Helper_Settings.settings.lockFrame = false
    Akkio_Consume_Helper_Settings.settings.splitByCategory = false

    -- Update global variable
    updateTimer = 1
    
    -- Apply default scale and rebuild UI
    if buffStatusFrame then
      buffStatusFrame:SetScale(1.0)
      buffStatusFrame:SetAlpha(1.0) -- Make sure it's fully visible
      -- Reset lock frame to unlocked
      buffStatusFrame:SetMovable(true)
      buffStatusFrame:RegisterForDrag("LeftButton")
      if buffStatusFrame.bg then buffStatusFrame.bg:Show() end
      if buffStatusFrame.titleBar then buffStatusFrame.titleBar:Show() end
      if buffStatusFrame.title then buffStatusFrame.title:Show() end
      ForceRefreshBuffStatus()
    end
    
    DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Akkio Consume Helper:|r Settings reset to defaults successfully!")
  end)

end

-- ============================================================================
-- RESET CONFIRMATION UI
-- ============================================================================

BuildResetConfirmationUI = function()
  if resetConfirmFrame then
    resetConfirmFrame:Show()
    return
  end

  local frame_width = 450
  local frame_height = 300

  resetConfirmFrame = CreateFrame("Frame", "AkkioResetConfirmFrame", UIParent)
  resetConfirmFrame:SetWidth(frame_width)
  resetConfirmFrame:SetHeight(frame_height)
  resetConfirmFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  resetConfirmFrame:SetFrameStrata("DIALOG")
  resetConfirmFrame:SetFrameLevel(100)
  resetConfirmFrame:SetMovable(true)
  resetConfirmFrame:EnableMouse(true)
  resetConfirmFrame:RegisterForDrag("LeftButton")
  resetConfirmFrame:SetScript("OnDragStart", function() resetConfirmFrame:StartMoving() end)
  resetConfirmFrame:SetScript("OnDragStop", function() resetConfirmFrame:StopMovingOrSizing() end)
  resetConfirmFrame:SetBackdrop({
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 8,
    edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
  })
  resetConfirmFrame:SetBackdropColor(0.2, 0.1, 0.1, 0.95) -- Dark red background
  resetConfirmFrame:SetBackdropBorderColor(1, 0.5, 0.5, 1) -- Red border

  -- Make the frame closable with Escape key
  resetConfirmFrame:SetScript("OnKeyDown", function()
    if arg1 == "ESCAPE" then
      resetConfirmFrame:Hide()
    end
  end)

  -- Title
  local title = resetConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("TOP", resetConfirmFrame, "TOP", 0, -20)
  title:SetText("⚠️ RESET CONFIRMATION ⚠️")
  title:SetTextColor(1, 0.5, 0.5, 1) -- Red color

  -- Warning message
  local warningText = resetConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  warningText:SetPoint("TOP", title, "BOTTOM", 0, -30)
  warningText:SetWidth(frame_width - 40)
  warningText:SetText("WARNING: This will reset ALL addon settings to defaults!")
  warningText:SetTextColor(1, 1, 0, 1) -- Yellow color
  warningText:SetJustifyH("CENTER")

  -- Details text
  local detailsText = resetConfirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  detailsText:SetPoint("TOP", warningText, "BOTTOM", 0, -20)
  detailsText:SetWidth(frame_width - 40)
  detailsText:SetText("This action will:\n\n• Reset all UI settings (scale, layout, etc.)\n• Reset combat settings\n• Reset minimap button position\n• Reset tooltip preferences\n• Clear all tracked buff selections\n\nYou will need to reconfigure everything!")
  detailsText:SetTextColor(0.9, 0.9, 0.9, 1) -- Light gray
  detailsText:SetJustifyH("LEFT")

  -- Confirm button (red and prominent)
  local confirmButton = CreateFrame("Button", nil, resetConfirmFrame, "UIPanelButtonTemplate")
  confirmButton:SetWidth(120)
  confirmButton:SetHeight(35)
  confirmButton:SetPoint("BOTTOM", resetConfirmFrame, "BOTTOM", -70, 25)
  confirmButton:SetText("RESET EVERYTHING")
  confirmButton:SetScript("OnClick", function()
    -- Show final confirmation in chat
    DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BPerforming emergency reset...|r")
    
    -- Call the reset function
    ResetToDefaults()
    
    -- Force refresh of all UI elements
    if buffStatusFrame then
      buffStatusFrame:SetScale(1.0)
      ForceRefreshBuffStatus()
    end
    
    -- Close the confirmation dialog
    resetConfirmFrame:Hide()
    
    DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Reset completed!|r Please reconfigure your settings.")
  end)

  -- Cancel button (safe option)
  local cancelButton = CreateFrame("Button", nil, resetConfirmFrame, "UIPanelButtonTemplate")
  cancelButton:SetWidth(80)
  cancelButton:SetHeight(35)
  cancelButton:SetPoint("BOTTOM", resetConfirmFrame, "BOTTOM", 70, 25)
  cancelButton:SetText("Cancel")
  cancelButton:SetScript("OnClick", function()
    resetConfirmFrame:Hide()
    DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Reset cancelled.|r Your settings are safe.")
  end)

  -- Close button (X) in top-right corner
  local closeXButton = CreateFrame("Button", nil, resetConfirmFrame)
  closeXButton:SetWidth(30)
  closeXButton:SetHeight(30)
  closeXButton:SetPoint("TOPRIGHT", resetConfirmFrame, "TOPRIGHT", -15, -15)
  closeXButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
  closeXButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
  closeXButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
  closeXButton:SetScript("OnClick", function()
    resetConfirmFrame:Hide()
  end)

  -- Add some visual emphasis to the confirm button
  confirmButton:SetScript("OnEnter", function()
    this:SetBackdropColor(0.5, 0.1, 0.1, 1) -- Darker red on hover
  end)
  confirmButton:SetScript("OnLeave", function()
    this:SetBackdropColor(0.3, 0.3, 0.3, 1) -- Back to normal
  end)
end

-- ============================================================================
-- UI CREATION FUNCTIONS
-- ============================================================================

BuildBuffSelectionUI = function(panel)
  -- When called without a panel, open via the main tabbed frame
  if not panel then
    BuildMainFrame(2)
    return
  end

  local tempTable = {}

  wipeTable(tempTable)

  for _, name in ipairs(Akkio_Consume_Helper_Settings.enabledBuffs) do
    -- Handle both old format (just name) and new format (name_slot for weapon enchants)
    local actualName = name
    local slot = nil

    -- Check if this is a weapon enchant with slot info
    if string.find(name, "_mainhand") then
      actualName = string.gsub(name, "_mainhand", "")
      slot = "mainhand"
    elseif string.find(name, "_offhand") then
      actualName = string.gsub(name, "_offhand", "")
      slot = "offhand"
    end

    if slot then
      tempTable[name] = true
    else
      tempTable[actualName] = true
    end
  end

  local checkboxHeight = 30

  local buffSelectFrame = panel

  -- ScrollFrame
  buffSelectFrame.scrollframe = CreateFrame("ScrollFrame", "AkkioBuffScrollFrame", buffSelectFrame)
  buffSelectFrame.scrollframe:SetPoint("TOPLEFT", buffSelectFrame, "TOPLEFT", 0, -5)
  buffSelectFrame.scrollframe:SetPoint("BOTTOMRIGHT", buffSelectFrame, "BOTTOMRIGHT", -22, 45)

  -- Create scroll bar manually for better compatibility
  buffSelectFrame.scrollbar = CreateFrame("Slider", "AkkioBuffScrollBar", buffSelectFrame.scrollframe, "UIPanelScrollBarTemplate")
  buffSelectFrame.scrollbar:SetPoint("TOPLEFT", buffSelectFrame.scrollframe, "TOPRIGHT", 4, -16)
  buffSelectFrame.scrollbar:SetPoint("BOTTOMLEFT", buffSelectFrame.scrollframe, "BOTTOMRIGHT", 4, 16)
  buffSelectFrame.scrollbar:SetMinMaxValues(1, 1)
  buffSelectFrame.scrollbar:SetValueStep(1)
  buffSelectFrame.scrollbar.scrollStep = 1
  buffSelectFrame.scrollbar:SetValue(0)
  buffSelectFrame.scrollbar:SetWidth(16)
  buffSelectFrame.scrollbar:SetScript("OnValueChanged", function()
    buffSelectFrame.scrollframe:SetVerticalScroll(this:GetValue())
  end)

  -- Enable mouse wheel scrolling with explicit event handling
  buffSelectFrame.scrollframe:EnableMouseWheel(true)
  buffSelectFrame.scrollframe:SetScript("OnMouseWheel", function()
    local scrollbar = buffSelectFrame.scrollbar
    local step = scrollbar.scrollStep or 20
    local value = scrollbar:GetValue()
    local minVal, maxVal = scrollbar:GetMinMaxValues()

    if arg1 > 0 then
      value = math.max(minVal, value - step)
    else
      value = math.min(maxVal, value + step)
    end

    scrollbar:SetValue(value)
  end)

  -- Content frame inside scroll frame
  buffSelectFrame.content = CreateFrame("Frame", nil, buffSelectFrame.scrollframe)
  buffSelectFrame.content:SetWidth(buffSelectFrame.scrollframe:GetWidth())
  buffSelectFrame.scrollframe:SetScrollChild(buffSelectFrame.content)

  local content = buffSelectFrame.content

  local currentYOffset = 0
  local currentCat = nil

  for i, buff in ipairs(allBuffs) do
    if buff.header then
      currentCat = buff.name
      local headerLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
      headerLabel:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -18 - currentYOffset)
      headerLabel:SetText(buff.name)
      currentYOffset = currentYOffset + 30
    else
      local cb = CreateFrame("CheckButton", "BuffCheckbox" .. i, content, "UICheckButtonTemplate")
      cb:SetWidth(20)
      cb:SetHeight(20)
      cb:SetPoint("TOPLEFT", content, "TOPLEFT", 10, -10 - currentYOffset)
      
      -- Check if this buff should be checked based on unique name for weapon enchants
      local checkName = buff.name
      if buff.isWeaponEnchant then
        checkName = buff.name .. "_" .. buff.slot
      end
      cb:SetChecked(tempTable[checkName] ~= nil)

      local icon = content:CreateTexture(nil, "ARTWORK")
      icon:SetWidth(20)
      icon:SetHeight(20)
      icon:SetPoint("LEFT", cb, "RIGHT", 5, 0)
      icon:SetTexture(buff.icon)

      -- Create invisible frame over the icon for tooltip functionality
      local iconFrame = CreateFrame("Frame", nil, content)
      iconFrame:SetWidth(20)
      iconFrame:SetHeight(20)
      iconFrame:SetPoint("LEFT", cb, "RIGHT", 5, 0)
      iconFrame:EnableMouse(true)
      
      -- Store buff data for tooltip
      local buffData = buff
      
      -- Add tooltip on hover
      iconFrame:SetScript("OnEnter", function()
        GameTooltip:SetOwner(iconFrame, "ANCHOR_RIGHT")
        
        local tooltipShown = false
        
        -- Method 1: Try to find the item in bags first (most reliable) - only for non-weapon enchants
        if not buffData.isWeaponEnchant then
          for bag = 0, 4 do
            for slot = 1, GetContainerNumSlots(bag) do
              local itemLink = GetContainerItemLink(bag, slot)
              if itemLink then
                local _, _, linkItemName = string.find(itemLink, "%[(.-)%]")
                if linkItemName then
                  linkItemName = string.gsub(linkItemName, " %(%d+%)$", "")
                  if linkItemName == buffData.name then
                    GameTooltip:SetBagItem(bag, slot)
                    tooltipShown = true
                    break
                  end
                end
              end
            end
            if tooltipShown then break end
          end
        end
        
        -- Method 2: If item not found in bags and we have an itemID, use it
        if not tooltipShown and buffData.itemID then
          -- SetHyperlink works with item IDs even if item not in inventory
          GameTooltip:SetHyperlink("item:" .. buffData.itemID)
          
          -- For weapon enchants, add additional slot information
          if buffData.isWeaponEnchant then
            local slotText = buffData.slot == "mainhand" and "Main Hand" or "Off Hand"
            GameTooltip:AddLine("Weapon enchant for: " .. slotText, 0.7, 0.7, 0.7, 1)
          end
          
          tooltipShown = true
        end
        
        -- Method 3: For spells (class buffs) or items without IDs, show enhanced custom tooltip
        if not tooltipShown then
          GameTooltip:AddLine(buffData.name, 1, 1, 1, 1)
          
          -- Add descriptions for class buffs
          if buffData.spellID then
            if buffData.spellID == 1243 then -- Power Word: Fortitude
              GameTooltip:AddLine("Increases Stamina by 3 for 30 min.", 1, 0.82, 0, 1)
              GameTooltip:AddLine("60 Mana - Instant cast", 0.7, 0.7, 0.7, 1)
            elseif buffData.spellID == 14752 then -- Divine Spirit
              GameTooltip:AddLine("Increases Spirit by 17 for 30 min.", 1, 0.82, 0, 1)
              GameTooltip:AddLine("285 Mana - Instant cast", 0.7, 0.7, 0.7, 1)
            elseif buffData.spellID == 1459 then -- Arcane Intellect
              GameTooltip:AddLine("Increases Intellect by 2 for 30 min.", 1, 0.82, 0, 1)
              GameTooltip:AddLine("60 Mana - Instant cast", 0.7, 0.7, 0.7, 1)
            elseif buffData.spellID == 1126 then -- Mark of the Wild
              GameTooltip:AddLine("Increases armor by 25 for 30 min.", 1, 0.82, 0, 1)
              GameTooltip:AddLine("20 Mana - Instant cast", 0.7, 0.7, 0.7, 1)
            elseif buffData.spellID == 1038 then -- Blessing of Salvation
              GameTooltip:AddLine("Reduces threat generated by 30% for 5 min.", 1, 0.82, 0, 1)
              GameTooltip:AddLine("8% of base mana - Instant cast", 0.7, 0.7, 0.7, 1)
            elseif buffData.spellID == 19740 then -- Blessing of Might
              GameTooltip:AddLine("Increases melee attack power by 20 for 5 min.", 1, 0.82, 0, 1)
              GameTooltip:AddLine("20 Mana - Instant cast", 0.7, 0.7, 0.7, 1)
            elseif buffData.spellID == 19742 then -- Blessing of Wisdom
              GameTooltip:AddLine("Restores 10 mana every 5 seconds for 5 min.", 1, 0.82, 0, 1)
              GameTooltip:AddLine("30 Mana - Instant cast", 0.7, 0.7, 0.7, 1)
            elseif buffData.spellID == 20217 then -- Blessing of Kings
              GameTooltip:AddLine("Increases total stats by 10% for 5 min.", 1, 0.82, 0, 1)
              GameTooltip:AddLine("8% of base mana - Instant cast", 0.7, 0.7, 0.7, 1)
            elseif buffData.spellID == 19977 then -- Blessing of Light
              GameTooltip:AddLine("Increases effects of Holy Light by up to 210", 1, 0.82, 0, 1)
              GameTooltip:AddLine("and Flash of Light by up to 60 for 5 min.", 1, 0.82, 0, 1)
              GameTooltip:AddLine("85 Mana - Instant cast", 0.7, 0.7, 0.7, 1)
            end
          end
          
          if buffData.isWeaponEnchant then
            local slotText = buffData.slot == "mainhand" and "Main Hand" or "Off Hand"
            GameTooltip:AddLine("Weapon enchant for: " .. slotText, 0.7, 0.7, 0.7, 1)
          end
          
          if buffData.duration then
            local minutes = math.floor(buffData.duration / 60)
            GameTooltip:AddLine("Duration: " .. minutes .. " minutes", 0.7, 0.7, 0.7, 1)
          end
          if buffData.raidBuffName and buffData.raidBuffName ~= buffData.name then
            GameTooltip:AddLine("Raid buff: " .. buffData.raidBuffName, 0.5, 0.8, 1, 1)
          end
          -- Add more detailed info if available
          if buffData.description then
            GameTooltip:AddLine(buffData.description, 0.8, 0.8, 0.8, 1)
          end
          if buffData.reagents then
            GameTooltip:AddLine("Reagents: " .. buffData.reagents, 0.6, 0.9, 0.6, 1)
          end
        end
        
        GameTooltip:Show()
      end)
      
      iconFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
      end)

      local tempIcon = content:CreateTexture(nil, "ARTWORK")
      tempIcon:SetPoint("LEFT", icon, "RIGHT", 5, 0)
      tempIcon:SetTexture(buff.buffIcon)
      tempIcon:Hide()

      local label = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
      label:SetPoint("LEFT", icon, "RIGHT", 5, 0)
      
      -- Store the necessary data as local variables BEFORE setting up the closure
      local isWeaponEnchant = buff.isWeaponEnchant
      local buffSlot = buff.slot
      local actualBuffName = buff.name
      
      -- For weapon enchants, show the slot information
      if isWeaponEnchant then
        local slotText = buffSlot == "mainhand" and " (MH)" or " (OH)"
        label:SetText(actualBuffName .. slotText)
      else
        label:SetText(actualBuffName)
      end

      -- "Only for shopping" inline checkbox — shown for Combat Potions and Utility
      if currentCat == "Combat Potions" or currentCat == "Utility" then
        local capturedCheckName = checkName
        -- Ensure table exists (may be nil if settings were reset)
        if not Akkio_Consume_Helper_Settings.onlyForShopping then
          Akkio_Consume_Helper_Settings.onlyForShopping = {}
        end
        -- Default to true (only for shopping) if not yet set
        if Akkio_Consume_Helper_Settings.onlyForShopping[capturedCheckName] == nil then
          Akkio_Consume_Helper_Settings.onlyForShopping[capturedCheckName] = true
        end

        local shopCb = CreateFrame("CheckButton", nil, content, "UICheckButtonTemplate")
        shopCb:SetWidth(20)
        shopCb:SetHeight(20)
        shopCb:SetPoint("LEFT", cb, "LEFT", 320, 0)
        shopCb:SetChecked(Akkio_Consume_Helper_Settings.onlyForShopping[capturedCheckName])

        local shopLabel = content:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        shopLabel:SetPoint("LEFT", shopCb, "RIGHT", 2, 0)
        shopLabel:SetText("Only shopping")
        shopLabel:SetTextColor(0.7, 0.7, 0.7)

        shopCb:SetScript("OnClick", function()
          if not Akkio_Consume_Helper_Settings.onlyForShopping then
            Akkio_Consume_Helper_Settings.onlyForShopping = {}
          end
          Akkio_Consume_Helper_Settings.onlyForShopping[capturedCheckName] = (this:GetChecked() == 1)
          ForceRefreshBuffStatus()
        end)
      end

      cb:SetScript("OnClick", function()
        local buffName = label:GetText()
        
        -- For weapon enchants, create a unique identifier that includes slot
        local uniqueName = buffName
        if isWeaponEnchant then
          uniqueName = actualBuffName .. "_" .. buffSlot
        end
        
        if this:GetChecked() == 1 then
          tempTable[uniqueName] = true
        else
          tempTable[uniqueName] = nil
        end
        -- Rebuild enabledBuffs in allBuffs order so position is always consistent
        Akkio_Consume_Helper_Settings.enabledBuffs = {}
        for _, buff in ipairs(allBuffs) do
          if not buff.header then
            local checkName = buff.name
            if buff.isWeaponEnchant then
              checkName = buff.name .. "_" .. buff.slot
            end
            if tempTable[checkName] then
              table.insert(Akkio_Consume_Helper_Settings.enabledBuffs, checkName)
            end
          end
        end
        ForceRefreshBuffStatus()
      end)
      currentYOffset = currentYOffset + checkboxHeight
    end
  end
  
  local totalHeight = currentYOffset + 20
  content:SetHeight(totalHeight)

  -- Update scroll range for our custom scroll bar
  local scrollFrameHeight = buffSelectFrame.scrollframe:GetHeight()
  local maxScroll = math.max(0, totalHeight - scrollFrameHeight)
  buffSelectFrame.scrollbar:SetMinMaxValues(0, maxScroll)
  buffSelectFrame.scrollbar.scrollStep = math.max(1, maxScroll / 10) -- 10% steps
end

BuildBuffStatusUI = function()
  local enabledBuffsList = {}

  wipeTable(enabledBuffsList)

  for _, name in ipairs(Akkio_Consume_Helper_Settings.enabledBuffs) do
    -- Handle both old format (just name) and new format (name_slot for weapon enchants)
    local actualName = name
    local slot = nil
    
    -- Check if this is a weapon enchant with slot info
    if string.find(name, "_mainhand") then
      actualName = string.gsub(name, "_mainhand", "")
      slot = "mainhand"
    elseif string.find(name, "_offhand") then
      actualName = string.gsub(name, "_offhand", "")  
      slot = "offhand"
    end
    
    -- Skip items marked as "only for shopping list" (not shown in status bar)
    local ofs = Akkio_Consume_Helper_Settings.onlyForShopping
    if not (ofs and ofs[name]) then
      -- Find the full buff data from allBuffs
      for _, buff in ipairs(allBuffs) do
        if buff.name == actualName then
          -- For weapon enchants, only add if slot matches or if it's not a weapon enchant
          if not buff.isWeaponEnchant or buff.slot == slot then
            table.insert(enabledBuffsList, buff)
            break
          end
        end
      end
    end
  end

  -- Calculate frame dimensions based on enabled buffs and icons per row
  local iconsPerRow = 5
  if Akkio_Consume_Helper_Settings.settings and Akkio_Consume_Helper_Settings.settings.iconsPerRow then
    iconsPerRow = Akkio_Consume_Helper_Settings.settings.iconsPerRow
  end
  
  -- Get icon spacing setting
  local iconSpacing = 32
  if Akkio_Consume_Helper_Settings.settings and Akkio_Consume_Helper_Settings.settings.iconSpacing then
    iconSpacing = Akkio_Consume_Helper_Settings.settings.iconSpacing
  end
  
  local splitByCategory = Akkio_Consume_Helper_Settings.settings.splitByCategory

  -- Build a map from buff reference -> category name
  local buffCategoryMap = {}
  local currentCategory = ""
  for _, buff in ipairs(allBuffs) do
    if buff.header then
      currentCategory = buff.name
    else
      buffCategoryMap[buff] = currentCategory
    end
  end

  -- Meta-category groupings for split-by-category layout
  local metaCategories = {
    ["Class Buffs"]                    = "Buffs",
    ["Flasks"]                         = "Elixirs",
    ["Elixirs & Concoctions"]          = "Elixirs",
    ["Juju"]                           = "Elixirs",
    ["Special Potions & Consumables"]  = "Elixirs",
    ["Weapon Enchants"]                = "Elixirs",
    ["Food & Drinks"]                  = "Food",
    ["Alcoholic Beverages"]            = "Food",
    ["Resistance Potions"]             = "Combat",
    ["Combat Potions"]                 = "Combat",
    ["Utility"]                        = "Combat",
  }
  local function getMetaCat(buff)
    local cat = buffCategoryMap[buff]
    return metaCategories[cat] or cat
  end

  -- Count enabled icons per meta-category
  local categoryIconCount = {}
  for _, buff in ipairs(enabledBuffsList) do
    local metaCat = getMetaCat(buff)
    categoryIconCount[metaCat] = (categoryIconCount[metaCat] or 0) + 1
  end

  -- Simulate layout to get accurate row count
  -- At a category boundary: fit next category on current line (with 1 gap) if it fits, else new line
  local numIcons = table.getn(enabledBuffsList)
  local simCol = 0
  local simRow = 0  -- 0-based row index
  local simCat = nil
  for _, buff in ipairs(enabledBuffsList) do
    local cat = getMetaCat(buff)
    if splitByCategory and simCat and cat ~= simCat and simCol > 0 then
      local nextCatSize = categoryIconCount[cat] or 0
      if nextCatSize <= (iconsPerRow - simCol - 1) then
        simCol = simCol + 1  -- gap slot
        if simCol >= iconsPerRow then
          simRow = simRow + 1
          simCol = 0
        end
      else
        simRow = simRow + 1
        simCol = 0
      end
    end
    simCat = cat
    simCol = simCol + 1
    if simCol >= iconsPerRow then
      simRow = simRow + 1
      simCol = 0
    end
  end
  -- simRow is 0-based; only count the last row if it has icons (simCol > 0)
  local numRows = (numIcons > 0) and ((simCol > 0) and (simRow + 1) or simRow) or 1
  local frameWidth = math.min(numIcons, iconsPerRow) * iconSpacing + 20 -- spacing per icon + padding
  local frameHeight = numRows * iconSpacing + 40 -- spacing per row + title space + padding

  if not buffStatusFrame then
    buffStatusFrame = CreateFrame("Frame", "BuffStatusFrame", UIParent)
    
    -- Ensure framePosition exists, create default if missing
    if not Akkio_Consume_Helper_Settings.settings.framePosition then
      Akkio_Consume_Helper_Settings.settings.framePosition = {
        point = "CENTER",
        relativeTo = "UIParent", 
        relativePoint = "CENTER",
        xOffset = 0,
        yOffset = 32
      }
    end
    
    -- Restore saved position or use default
    local pos = Akkio_Consume_Helper_Settings.settings.framePosition
    buffStatusFrame:SetPoint(pos.point, pos.relativeTo, pos.relativePoint, pos.xOffset, pos.yOffset)
    
    -- Use saved scale setting or default to 1.0
    local scale = 1.0
    if Akkio_Consume_Helper_Settings.settings and Akkio_Consume_Helper_Settings.settings.scale then
      scale = Akkio_Consume_Helper_Settings.settings.scale
    end
    buffStatusFrame:SetScale(scale)
    buffStatusFrame:EnableMouse(true)
    buffStatusFrame:SetMovable(true)
    buffStatusFrame:SetClampedToScreen(true)
    buffStatusFrame:RegisterForDrag("LeftButton")
    buffStatusFrame:SetScript("OnDragStart", function() buffStatusFrame:StartMoving() end)
    buffStatusFrame:SetScript("OnDragStop", function() 
      buffStatusFrame:StopMovingOrSizing()
      -- Save the new position to persistent storage
      local point, relativeTo, relativePoint, xOffset, yOffset = buffStatusFrame:GetPoint()
      Akkio_Consume_Helper_Settings.settings.framePosition = {
        point = point,
        relativeTo = "UIParent", -- Always relative to UIParent for consistency
        relativePoint = relativePoint,
        xOffset = xOffset,
        yOffset = yOffset
      }
    end)

    -- Add hover handlers to the frame itself for hover-to-show functionality
    buffStatusFrame:SetScript("OnEnter", function()
      if Akkio_Consume_Helper_Settings.settings.hoverToShow then
        -- Initialize hoverCount if it doesn't exist
        if not buffStatusFrame.hoverCount then
          buffStatusFrame.hoverCount = 0
        end
        
        buffStatusFrame.hoverCount = buffStatusFrame.hoverCount + 1
        -- Cancel any pending hide timer
        if buffStatusFrame.hideTimer then
          buffStatusFrame.hideTimer = nil
        end
        buffStatusFrame:SetAlpha(1.0) -- Make frame fully visible when hovering frame area
      end
    end)
    
    buffStatusFrame:SetScript("OnLeave", function()
      if Akkio_Consume_Helper_Settings.settings.hoverToShow then
        -- Initialize hoverCount if it doesn't exist
        if not buffStatusFrame.hoverCount then
          buffStatusFrame.hoverCount = 0
        end
        
        buffStatusFrame.hoverCount = math.max(0, buffStatusFrame.hoverCount - 1)
        if buffStatusFrame.hoverCount <= 0 then
          -- Ensure hoverCount doesn't go negative
          buffStatusFrame.hoverCount = 0
          -- Set a timer to hide after a short delay
          buffStatusFrame.hideTimer = GetTime() + 0.1 -- Hide after 100ms
        end
      end
    end)

    -- Set initial alpha based on hover-to-show setting
    if Akkio_Consume_Helper_Settings.settings.hoverToShow then
      buffStatusFrame:SetAlpha(0.0) -- Start completely transparent
      buffStatusFrame.hoverCount = 0 -- Track how many icons are being hovered
    else
      buffStatusFrame:SetAlpha(1.0) -- Start fully visible
    end

    -- Create a subtle background that's always visible (helps users see the frame area)
    local bg = buffStatusFrame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
    bg:SetVertexColor(0.1, 0.1, 0.1, 0.3) -- Dark with low alpha
    buffStatusFrame.bg = bg

    -- Create title bar that's always visible 
    local titleBar = buffStatusFrame:CreateTexture(nil, "BORDER")
    titleBar:SetHeight(18)
    titleBar:SetPoint("TOPLEFT", buffStatusFrame, "TOPLEFT", 2, -2)
    titleBar:SetPoint("TOPRIGHT", buffStatusFrame, "TOPRIGHT", -2, -2)
    titleBar:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
    titleBar:SetVertexColor(0.2, 0.4, 0.6, 0.7) -- Blue-ish with higher alpha
    buffStatusFrame.titleBar = titleBar

    local title = buffStatusFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    title:SetPoint("TOP", buffStatusFrame, "TOP", 0, -8)
    title:SetText("Buffs")
    title:SetTextColor(1, 1, 1, 1) -- White text
    buffStatusFrame.title = title
    buffStatusFrame.children = {} -- Create a table to track children
    
    -- Apply initial lock frame setting
    local lockFrame = Akkio_Consume_Helper_Settings.settings.lockFrame or false
    if lockFrame then
      buffStatusFrame:SetMovable(false)
      buffStatusFrame:RegisterForDrag()
      if buffStatusFrame.bg then buffStatusFrame.bg:Hide() end
      if buffStatusFrame.titleBar then buffStatusFrame.titleBar:Hide() end
      if buffStatusFrame.title then buffStatusFrame.title:Hide() end
    else
      buffStatusFrame:SetMovable(true)
      buffStatusFrame:RegisterForDrag("LeftButton")
      if buffStatusFrame.bg then buffStatusFrame.bg:Show() end
      if buffStatusFrame.titleBar then buffStatusFrame.titleBar:Show() end
      if buffStatusFrame.title then buffStatusFrame.title:Show() end
    end
  else
    -- Clean up old children
    if buffStatusFrame.children then
      for i = 1, table.getn(buffStatusFrame.children) do
        local child = buffStatusFrame.children[i]
        if child then
          child:Hide()
          child:SetParent(nil)
        end
      end
      wipeTable(buffStatusFrame.children)
    end
    
    -- Update frame size based on current enabled buffs
    buffStatusFrame:SetWidth(frameWidth)
    buffStatusFrame:SetHeight(frameHeight)
    
    -- Preserve alpha state during rebuild for hover-to-show
    if Akkio_Consume_Helper_Settings.settings.hoverToShow then
      -- Initialize hover tracking if it doesn't exist
      if buffStatusFrame.hoverCount == nil then
        buffStatusFrame.hoverCount = 0
      end
      
      -- Keep frame completely hidden when not hovering
      if buffStatusFrame.hoverCount > 0 then
        buffStatusFrame:SetAlpha(1.0) -- Keep fully visible while hovering
      else
        buffStatusFrame:SetAlpha(0.0) -- Completely hidden when not hovering
      end
    else
      -- Normal mode - always fully visible
      buffStatusFrame:SetAlpha(1.0)
    end
    
    -- Apply lock frame setting during rebuild
    local lockFrame = Akkio_Consume_Helper_Settings.settings.lockFrame or false
    if lockFrame then
      buffStatusFrame:SetMovable(false)
      buffStatusFrame:RegisterForDrag()
      if buffStatusFrame.bg then buffStatusFrame.bg:Hide() end
      if buffStatusFrame.titleBar then buffStatusFrame.titleBar:Hide() end
      if buffStatusFrame.title then buffStatusFrame.title:Hide() end
    else
      buffStatusFrame:SetMovable(true)
      buffStatusFrame:RegisterForDrag("LeftButton")
      if buffStatusFrame.bg then buffStatusFrame.bg:Show() end
      if buffStatusFrame.titleBar then buffStatusFrame.titleBar:Show() end
      if buffStatusFrame.title then buffStatusFrame.title:Show() end
    end
  end

  -- Set the final frame dimensions
  buffStatusFrame:SetWidth(frameWidth)
  buffStatusFrame:SetHeight(frameHeight)

  local xOffset = 10 -- Start closer to the edge for compact layout
  local yOffset = -22 -- Start below the title bar with 2px padding
  
  -- Get icons per row setting, default to 5 if not set
  local iconsPerRow = 5
  if Akkio_Consume_Helper_Settings.settings and Akkio_Consume_Helper_Settings.settings.iconsPerRow then
    iconsPerRow = Akkio_Consume_Helper_Settings.settings.iconsPerRow
  end
  
  -- Get icon spacing setting
  local iconSpacing = 32
  if Akkio_Consume_Helper_Settings.settings and Akkio_Consume_Helper_Settings.settings.iconSpacing then
    iconSpacing = Akkio_Consume_Helper_Settings.settings.iconSpacing
  end
  
  local currentRow = 0
  local currentCol = 0
  local currentCat = nil

  for _, data in ipairs(enabledBuffsList) do
    -- At a category boundary: fit on current line with 1 gap if possible, else new line
    if splitByCategory then
      local dataCat = getMetaCat(data)
      if currentCat and dataCat ~= currentCat and currentCol > 0 then
        local nextCatSize = categoryIconCount[dataCat] or 0
        if nextCatSize <= (iconsPerRow - currentCol - 1) then
          currentCol = currentCol + 1
          xOffset = xOffset + iconSpacing
        else
          currentCol = 0
          currentRow = currentRow + 1
          xOffset = 10
          yOffset = yOffset - iconSpacing
        end
      end
      currentCat = dataCat
    end
    local hasBuff = checkHasBuff(data)

    local icon = CreateFrame("Button", nil, buffStatusFrame, "UIPanelButtonTemplate")
    icon:SetWidth(30)
    icon:SetHeight(30)
    icon:SetPoint("TOPLEFT", buffStatusFrame, "TOPLEFT", xOffset, yOffset)

    local iconTexture = icon:CreateTexture(nil, "ARTWORK")
    iconTexture:SetAllPoints()
    iconTexture:SetTexture(data.icon)
    if hasBuff then
      iconTexture:SetVertexColor(1, 1, 1, 1)
    else
      iconTexture:SetVertexColor(1, 0, 0, 1)
    end

    icon:SetNormalTexture(iconTexture)
    icon:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")

    local iconAmountLabel = icon:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    iconAmountLabel:SetPoint("BOTTOM", icon, "BOTTOM", 10, 0)
    
    -- Show item amounts for all items; for weapon enchants show remaining charges
    local itemAmount = data.isWeaponEnchant and findItemChargesInBag(data.name) or findItemInBagAndGetAmount(data.name)
    iconAmountLabel:SetText(itemAmount > 0 and itemAmount or "")
    
    -- Store reference for fast updates
    icon.amountLabel = iconAmountLabel
    icon.buffdata = data

    -- Add timer label for normal buffs (not weapon enchants) and only if they have a duration
    if not data.isWeaponEnchant and data.duration then
      local timerLabel = icon:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
      timerLabel:SetPoint("TOP", icon, "TOP", 0, -8)
      timerLabel:SetTextColor(1, 1, 1, 1) -- White text for visibility
      
      -- Show remaining time if buff is tracked
      local remainingTime = getBuffRemainingTime(data.name)
      timerLabel:SetText(formatTimeRemaining(remainingTime))
      
      -- Store reference for fast updates
      icon.timerLabel = timerLabel
    end

    -- Add slot indicator and timer for weapon enchants
    if data.isWeaponEnchant then
      local slotIndicator = icon:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
      slotIndicator:SetPoint("TOP", icon, "TOP", 0, -2)
      slotIndicator:SetText(data.slot == "mainhand" and "MH" or "OH")
      slotIndicator:SetTextColor(1, 1, 0, 1) -- Yellow text for visibility
      
      -- Add timer label for weapon enchants using GetWeaponEnchantInfo
      local timerLabel = icon:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
      timerLabel:SetPoint("BOTTOM", icon, "BOTTOM", 0, 8)
      timerLabel:SetTextColor(1, 1, 1, 1) -- White text for visibility
      
      -- Get initial weapon enchant time
      if data.slot == "mainhand" then
        local hasMainHandEnchant, mainHandExpiration = GetWeaponEnchantInfo()
        if hasMainHandEnchant and mainHandExpiration then
          local remainingSeconds = mainHandExpiration / 1000 -- Convert milliseconds to seconds
          timerLabel:SetText(formatTimeRemaining(remainingSeconds))
        else
          timerLabel:SetText("")
        end
      elseif data.slot == "offhand" then
        local _, _, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
        if hasOffHandEnchant and offHandExpiration then
          local remainingSeconds = offHandExpiration / 1000 -- Convert milliseconds to seconds
          timerLabel:SetText(formatTimeRemaining(remainingSeconds))
        else
          timerLabel:SetText("")
        end
      end
      
      -- Store reference for fast updates
      icon.timerLabel = timerLabel
    end

    local label = buffStatusFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
    label:SetPoint("LEFT", icon, "RIGHT", 5, 0)
    
    -- For weapon enchants, show the slot information
    if data.isWeaponEnchant then
      local slotText = data.slot == "mainhand" and " (MH)" or " (OH)"
      label:SetText(data.name .. slotText)
    else
      label:SetText(data.name)
    end
    
    label:Hide()
    if hasBuff then
      label:SetTextColor(0, 1, 0)
    else
      label:SetTextColor(1, 0, 0)
    end
    icon:SetScript("OnClick", function()
      local buffName = label:GetText()
      local buffdata = this.buffdata

      -- Check current buff status dynamically
      local currentlyHasBuff = checkHasBuff(buffdata)

      -- Handle weapon enchants differently
      if buffdata.isWeaponEnchant then
        if currentlyHasBuff then
          DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Info:|r Your " .. buffdata.slot .. " weapon already has an enchant applied.")
        else
          -- Try to find and use the weapon enchant item
          if findItemInBagAndGetAmount(buffdata.name) > 0 then
            applyWeaponEnchant(buffdata.name, buffdata.slot)
          else
            DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6B" .. buffdata.name .. " not found in your bags.|r")
          end
        end
        return
      end

      -- Regular buff handling (for consumables)
      if currentlyHasBuff then
        DEFAULT_CHAT_FRAME:AddMessage("|cff98FB98You already have " .. buffName .. " buff active.|r")
      else
        if GetNumRaidMembers() > 0 then
          for i = 1, GetNumRaidMembers() do
            local name, _, subgroup, _, _, _, _, _, _, _ = GetRaidRosterInfo(i)
            if name == UnitName("player") and buffdata.canBeAnounced then
              SendChatMessage("|cffFF6B6BNeed " .. buffName .. "|r", "RAID")
            end
          end
        elseif GetNumPartyMembers() > 0 and buffdata.canBeAnounced then
          SendChatMessage("|cffFF6B6BNeed " .. buffName .. "|r", "PARTY")
        end
        --DEFAULT_CHAT_FRAME:AddMessage("I need " .. buffName)
        if buffdata.canBeAnounced == false and findItemInBagAndGetAmount(buffdata.name) > 0 then
          findAndUseItemByName(buffdata.name)
        end
      end
    end)

    -- Add tooltip functionality
    icon:SetScript("OnEnter", function()
      -- Apply hover-to-show functionality first
      if Akkio_Consume_Helper_Settings.settings.hoverToShow then
        -- Initialize hoverCount if it doesn't exist
        if not buffStatusFrame.hoverCount then
          buffStatusFrame.hoverCount = 0
        end
        
        buffStatusFrame.hoverCount = buffStatusFrame.hoverCount + 1
        -- Cancel any pending hide timer
        if buffStatusFrame.hideTimer then
          buffStatusFrame.hideTimer = nil
        end
        buffStatusFrame:SetAlpha(1.0) -- Make frame fully visible when hovering any icon
      end
      
      -- Check if tooltips are enabled
      if not Akkio_Consume_Helper_Settings.settings.showTooltips then
        return
      end
      
      GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
      
      local buffdata = this.buffdata
      local itemAmount = findItemInBagAndGetAmount(buffdata.name)
      
      -- Check current buff status dynamically for tooltip
      local tooltipHasBuff = checkHasBuff(buffdata)
      
      -- Main title with status color
      if tooltipHasBuff then
        GameTooltip:AddLine(buffdata.name, 0, 1, 0, 1) -- Green for active
      else
        GameTooltip:AddLine(buffdata.name, 1, 0, 0, 1) -- Red for missing
      end
      
      -- Status line
      if buffdata.isWeaponEnchant then
        local slotText = buffdata.slot == "mainhand" and "Main Hand" or "Off Hand"
        if tooltipHasBuff then
          GameTooltip:AddLine("Status: " .. slotText .. " enchanted", 0, 1, 0, 1)
          -- Show remaining time for weapon enchants
          if buffdata.slot == "mainhand" then
            local hasMainHandEnchant, mainHandExpiration = GetWeaponEnchantInfo()
            if hasMainHandEnchant and mainHandExpiration then
              local remainingSeconds = mainHandExpiration / 1000 -- Convert milliseconds to seconds
              GameTooltip:AddLine("Time remaining: " .. formatTimeRemaining(remainingSeconds), 1, 1, 0, 1)
            end
          elseif buffdata.slot == "offhand" then
            local _, _, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
            if hasOffHandEnchant and offHandExpiration then
              local remainingSeconds = offHandExpiration / 1000 -- Convert milliseconds to seconds
              GameTooltip:AddLine("Time remaining: " .. formatTimeRemaining(remainingSeconds), 1, 1, 0, 1)
            end
          end
        else
          GameTooltip:AddLine("Status: " .. slotText .. " not enchanted", 1, 0.5, 0, 1)
        end
      else
        if tooltipHasBuff then
          GameTooltip:AddLine("Status: Active", 0, 1, 0, 1)
          -- Show remaining time for normal buffs only if they have duration
          if buffdata.duration then
            local remainingTime = getBuffRemainingTime(buffdata.name)
            if remainingTime > 0 then
              GameTooltip:AddLine("Time remaining: " .. formatTimeRemaining(remainingTime), 1, 1, 0, 1)
            end
          end
        else
          GameTooltip:AddLine("Status: Missing", 1, 0.5, 0, 1)
        end
      end
      
      -- Item count
      if itemAmount > 0 then
        GameTooltip:AddLine("In bags: " .. itemAmount, 1, 1, 1, 1)
      else
        GameTooltip:AddLine("In bags: None", 0.7, 0.7, 0.7, 1)
      end
      
      -- Action hint
      GameTooltip:AddLine(" ", 1, 1, 1, 1) -- Empty line
      if buffdata.isWeaponEnchant then
        if tooltipHasBuff then
          GameTooltip:AddLine("Weapon enchant is active", 0.7, 0.7, 0.7, 1)
        else
          if itemAmount > 0 then
            GameTooltip:AddLine("Click to apply enchant", 1, 1, 0, 1)
          else
            GameTooltip:AddLine("No enchant items found", 0.7, 0.7, 0.7, 1)
          end
        end
      else
        if tooltipHasBuff then
          GameTooltip:AddLine("Buff is already active", 0.7, 0.7, 0.7, 1)
        else
          if buffdata.canBeAnounced then
            GameTooltip:AddLine("Click to announce need", 1, 1, 0, 1)
          else
            if itemAmount > 0 then
              GameTooltip:AddLine("Click to use item", 1, 1, 0, 1)
            else
              GameTooltip:AddLine("No items found", 0.7, 0.7, 0.7, 1)
            end
          end
        end
      end
      
      GameTooltip:Show()
    end)

    icon:SetScript("OnLeave", function()
      -- Apply hover-to-show functionality first
      if Akkio_Consume_Helper_Settings.settings.hoverToShow then
        -- Initialize hoverCount if it doesn't exist
        if not buffStatusFrame.hoverCount then
          buffStatusFrame.hoverCount = 0
        end
        
        buffStatusFrame.hoverCount = math.max(0, buffStatusFrame.hoverCount - 1)
        if buffStatusFrame.hoverCount <= 0 then
          -- Ensure hoverCount doesn't go negative
          buffStatusFrame.hoverCount = 0
          -- Don't hide immediately - set a timer to hide after a short delay
          -- This prevents flickering when moving between icons
          buffStatusFrame.hideTimer = GetTime() + 0.1 -- Hide after 100ms
        end
      end
      
      -- Only hide tooltip if tooltips are enabled (if they're disabled, tooltip won't be shown anyway)
      if Akkio_Consume_Helper_Settings.settings.showTooltips then
        GameTooltip:Hide()
      end
    end)

    -- Save these to the children table for cleanup later
    table.insert(buffStatusFrame.children, icon)
    table.insert(buffStatusFrame.children, label)

    -- Positioning logic for configurable icons per row
    currentCol = currentCol + 1
    if currentCol >= iconsPerRow then
      currentCol = 0
      currentRow = currentRow + 1
      xOffset = 10
      yOffset = yOffset - iconSpacing
    else
      xOffset = xOffset + iconSpacing
    end
  end

  -- Add ticker only once outside the buff loop
  if not buffStatusFrame.ticker then
    buffStatusFrame.ticker = CreateFrame("Frame")
    buffStatusFrame.ticker.lastUpdate = GetTime()
    buffStatusFrame.ticker.lastFullUpdate = GetTime()
    buffStatusFrame.ticker.lastCleanup = GetTime() -- Add cleanup timer
    buffStatusFrame.ticker:SetScript("OnUpdate", function()
      local now = GetTime()
      
      -- Check for delayed hide timer (for hover-to-show functionality)
      if buffStatusFrame.hideTimer and now >= buffStatusFrame.hideTimer then
        if Akkio_Consume_Helper_Settings.settings.hoverToShow then
          -- Force hide if timer has expired, regardless of hoverCount state
          -- This prevents the frame from getting stuck visible
          buffStatusFrame.hoverCount = 0 -- Reset hover count
          buffStatusFrame:SetAlpha(0.0) -- Hide the frame
        end
        buffStatusFrame.hideTimer = nil -- Clear the timer
      end
      
      -- Periodic cleanup of expired buff tracker entries (every 30 seconds)
      if (now - buffStatusFrame.ticker.lastCleanup) > 30 then
        if buffTracker and Akkio_Consume_Helper_Settings.buffTracker then
          for buffName, tracker in pairs(buffTracker) do
            local elapsedTime = now - tracker.startTime
            if elapsedTime >= tracker.duration then
              -- Only remove if the buff is no longer active
              local stillActive = false
              for i = 1, 40 do
                local tex = UnitBuff("player", i)
                if not tex then break end
                if tex == tracker.icon then
                  stillActive = true
                  break
                end
              end
              if not stillActive then
                buffTracker[buffName] = nil
                Akkio_Consume_Helper_Settings.buffTracker[buffName] = nil
              end
            end
          end
        end
        buffStatusFrame.ticker.lastCleanup = now
      end
      
      if (now - buffStatusFrame.ticker.lastUpdate) > updateTimer then
        -- Only do a quick update of buff status, not full UI rebuild
        UpdateBuffStatusOnly()
        this.lastUpdate = now
        
        -- Full UI rebuild only every 10 seconds or when settings change
        -- BUT skip automatic rebuilds when hover-to-show is enabled to prevent unwanted visibility
        if (now - this.lastFullUpdate) > 10 then
          -- Only do automatic rebuilds if hover-to-show is disabled OR if someone is currently hovering
          if not Akkio_Consume_Helper_Settings.settings.hoverToShow or 
             (buffStatusFrame.hoverCount and buffStatusFrame.hoverCount > 0) then
            BuildBuffStatusUI()
          end
          this.lastFullUpdate = now
        end
      end
    end)
  end
end

-- ============================================================================
-- MINIMAP BUTTON
-- ============================================================================

CreateMinimapButton = function()
  local miniMapBtn = CreateFrame("Button", "AkkioMinimapButton", Minimap)
  miniMapBtn:SetWidth(33)
  miniMapBtn:SetHeight(33)
  miniMapBtn:SetFrameStrata("MEDIUM")
  miniMapBtn:SetFrameLevel(8)
  miniMapBtn:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

  -- Initialize position from saved settings or default
  local defaultAngle = 225 -- Bottom-left position
  if not Akkio_Consume_Helper_Settings.settings.minimapAngle then
    Akkio_Consume_Helper_Settings.settings.minimapAngle = defaultAngle
  end

  -- Create the icon texture first (bottom layer)
  miniMapBtn.icon = miniMapBtn:CreateTexture(nil, "BACKGROUND")
  miniMapBtn.icon:SetPoint("CENTER", miniMapBtn, "CENTER", 0, 0)
  miniMapBtn.icon:SetWidth(20)
  miniMapBtn.icon:SetHeight(20)
  miniMapBtn.icon:SetTexture("Interface\\Icons\\INV_Misc_Food_01")
  miniMapBtn.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

  -- Create the border texture (top layer)
  miniMapBtn.border = miniMapBtn:CreateTexture(nil, "OVERLAY")
  miniMapBtn.border:SetPoint("TOPLEFT", miniMapBtn, "TOPLEFT", 0, 0)
  miniMapBtn.border:SetWidth(53)
  miniMapBtn.border:SetHeight(53)
  miniMapBtn.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

  -- Position update function
  local function UpdateMinimapButtonPosition()
    local angle = Akkio_Consume_Helper_Settings.settings.minimapAngle
    local x, y
    local radius = 80 -- Distance from minimap center
    
    x = radius * cos(angle)
    y = radius * sin(angle)
    
    miniMapBtn:ClearAllPoints()
    miniMapBtn:SetPoint("CENTER", Minimap, "CENTER", x, y)
  end

  -- Dragging functionality
  miniMapBtn:RegisterForDrag("LeftButton")
  miniMapBtn:SetScript("OnDragStart", function()
    this:SetScript("OnUpdate", function()
      local mx, my = GetCursorPosition()
      local px, py = Minimap:GetCenter()
      local scale = Minimap:GetEffectiveScale()
      
      mx, my = mx / scale, my / scale
      
      local dx, dy = mx - px, my - py
      local angle = math.atan2(dy, dx)
      
      -- Convert to degrees and normalize
      local degrees = math.deg(angle)
      if degrees < 0 then
        degrees = degrees + 360
      end
      
      -- Store the new angle
      Akkio_Consume_Helper_Settings.settings.minimapAngle = degrees
      
      -- Update position
      UpdateMinimapButtonPosition()
    end)
  end)

  miniMapBtn:SetScript("OnDragStop", function()
    this:SetScript("OnUpdate", nil)
  end)

  -- Set initial position
  UpdateMinimapButtonPosition()

  miniMapBtn:SetScript("OnClick", function()
    BuildMainFrame()
  end)

  -- Tooltip for the minimap button
  miniMapBtn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(this, "ANCHOR_LEFT")
    GameTooltip:AddLine("Akkio's Consume Helper", 0, 1, 0, 1)
    GameTooltip:AddLine("Left-click: Open settings", 1, 1, 1, 1)
    GameTooltip:AddLine("Drag: Move button position", 1, 1, 0, 1)
    GameTooltip:AddLine("Tracks buffs and consumables", 0.7, 0.7, 0.7, 1)
    GameTooltip:Show()
  end)

  miniMapBtn:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end)
end

-- ============================================================================
-- SLASH COMMANDS
-- ============================================================================

SLASH_AKKIOCONSUME1 = "/act"
SlashCmdList["AKKIOCONSUME"] = function()
  BuildMainFrame(2)
end

SLASH_AKKIOSETTINGS1 = "/actsettings"
SlashCmdList["AKKIOSETTINGS"] = function()
  BuildMainFrame(1)
end

SLASH_AKKIOBUFFSTATUS1 = "/actbuffstatus"
SlashCmdList["AKKIOBUFFSTATUS"] = function()
  BuildBuffStatusUI()
end

SLASH_AKKIOWELCOME1 = "/actwelcome"
SlashCmdList["AKKIOWELCOME"] = function()
  local welcomeFrame = CreateWelcomeWindow()
  welcomeFrame:Show()
end

SLASH_AKKIORESET1 = "/actreset"
SlashCmdList["AKKIORESET"] = function()
  if not resetConfirmFrame then
    BuildResetConfirmationUI()
  end
  resetConfirmFrame:Show()
end

SLASH_AKKIODEBUG1 = "/actdebug"
SlashCmdList["AKKIODEBUG"] = function()
  DEFAULT_CHAT_FRAME:AddMessage("|cffADD8E6=== BUFF DEBUG SCAN ===|r")
  DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFFCurrently active buffs on player:|r")
  
  local buffCount = 0
  for i = 1, 40 do
    local buffTexture = UnitBuff("player", i)
    if buffTexture then
      buffCount = buffCount + 1
      DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Buff " .. i .. ":|r " .. buffTexture)
    else
      break
    end
  end
  
  if buffCount == 0 then
    DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BNo buffs currently active.|r")
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFFTotal active buffs: " .. buffCount .. "|r")
  end
  
  -- Check weapon enchants
  local hasMainHandEnchant, mainHandExpiration, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
  DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF=== WEAPON ENCHANTS ===|r")
  if hasMainHandEnchant then
    local remainingSeconds = mainHandExpiration and (mainHandExpiration / 1000) or 0
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFFMain Hand:|r |cff00FF00Enchanted|r (" .. formatTimeRemaining(remainingSeconds) .. " remaining)")
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFFMain Hand:|r |cffFF6B6BNot Enchanted|r")
  end
  
  if hasOffHandEnchant then
    local remainingSeconds = offHandExpiration and (offHandExpiration / 1000) or 0
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFFOff Hand:|r |cff00FF00Enchanted|r (" .. formatTimeRemaining(remainingSeconds) .. " remaining)")
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFFOff Hand:|r |cffFF6B6BNot Enchanted|r")
  end

  -- Show timestamp tracker information
  DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF=== BUFF TRACKER ===|r")
  local trackerCount = 0
  for buffName, tracker in pairs(buffTracker) do
    trackerCount = trackerCount + 1
    local remainingTime = getBuffRemainingTime(buffName)
    local timeText = formatTimeRemaining(remainingTime)
    local validText = isBuffStillValid(buffName) and "|cff00FF00Valid|r" or "|cffFF6B6BExpired|r"
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00" .. buffName .. ":|r " .. timeText .. " (" .. validText .. ")")
  end
  
  if trackerCount == 0 then
    DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BNo buffs currently tracked.|r")
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFFTotal tracked buffs: " .. trackerCount .. "|r")
  end

  -- HOVER-TO-SHOW DEBUG INFORMATION
  DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF=== HOVER-TO-SHOW DEBUG ===|r")
  if buffStatusFrame then
    local hoverEnabled = Akkio_Consume_Helper_Settings.settings.hoverToShow
    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Hover-to-show enabled:|r " .. (hoverEnabled and "|cff00FF00YES|r" or "|cffFF6B6BNO|r"))
    
    if hoverEnabled then
      local currentAlpha = buffStatusFrame:GetAlpha()
      local hoverCount = buffStatusFrame.hoverCount or "nil"
      local hideTimer = buffStatusFrame.hideTimer
      local currentTime = GetTime()
      
      DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Frame Alpha:|r " .. string.format("%.2f", currentAlpha))
      DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Hover Count:|r " .. tostring(hoverCount))
      DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Hide Timer:|r " .. (hideTimer and string.format("%.2f", hideTimer) or "nil"))
      DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Current Time:|r " .. string.format("%.2f", currentTime))
      
      if hideTimer then
        local timeUntilHide = hideTimer - currentTime
        DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Time until hide:|r " .. string.format("%.2f", timeUntilHide) .. "s")
      end
      
      -- Check expected vs actual state
      local expectedAlpha = (hoverCount and hoverCount > 0) and 1.0 or 0.0
      local stateMatch = math.abs(currentAlpha - expectedAlpha) < 0.01
      DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Expected Alpha:|r " .. string.format("%.2f", expectedAlpha))
      DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00State Match:|r " .. (stateMatch and "|cff00FF00YES|r" or "|cffFF6B6BMISMATCH!|r"))
      
      -- Check if frame is actually shown/hidden
      local frameShown = buffStatusFrame:IsShown()
      DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Frame IsShown:|r " .. (frameShown and "|cff00FF00YES|r" or "|cffFF6B6BNO|r"))
      
      -- Count child icons with hover handlers
      local iconCount = 0
      if buffStatusFrame.children then
        for i = 1, table.getn(buffStatusFrame.children) do
          local child = buffStatusFrame.children[i]
          if child and child.buffdata then
            iconCount = iconCount + 1
          end
        end
      end
      DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Active Icons:|r " .. iconCount)
      
      -- Provide troubleshooting suggestions
      if not stateMatch then
        DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6B=== ISSUE DETECTED ===|r")
        if currentAlpha > 0 and (not hoverCount or hoverCount <= 0) then
          DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BFrame stuck visible!|r Hover count suggests it should be hidden.")
          -- Check for expired timer specifically
          if hideTimer and currentTime >= hideTimer then
            local expiredTime = currentTime - hideTimer
            DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BHide timer expired " .. string.format("%.2f", expiredTime) .. "s ago but frame is still visible!|r")
          end
          DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Suggestion:|r Try /acthoverfix to reset hover state")
        elseif currentAlpha == 0 and hoverCount and hoverCount > 0 then
          DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BFrame stuck hidden!|r Hover count suggests it should be visible.")
          DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Suggestion:|r Try /acthoverfix to reset hover state")
        end
      end
    end
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BNo buff status frame exists.|r")
  end

  DEFAULT_CHAT_FRAME:AddMessage("|cffADD8E6=== END DEBUG SCAN ===|r")
end

SLASH_AKKIOCLEAR1 = "/actclear"
SlashCmdList["AKKIOCLEAR"] = function()
  -- Clear the buff tracker
  wipeTable(buffTracker)
  DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Akkio Consume Helper:|r Buff tracker cleared!")
  
  -- Force refresh to update UI
  if buffStatusFrame then
    ForceRefreshBuffStatus()
  end
end

SLASH_AKKIOHOVERFIX1 = "/acthoverfix"
SlashCmdList["AKKIOHOVERFIX"] = function()
  if not buffStatusFrame then
    DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BAkkio Consume Helper:|r No buff status frame exists.")
    return
  end
  
  if not Akkio_Consume_Helper_Settings.settings.hoverToShow then
    DEFAULT_CHAT_FRAME:AddMessage("|cffFF6B6BAkkio Consume Helper:|r Hover-to-show is not enabled.")
    return
  end
  
  DEFAULT_CHAT_FRAME:AddMessage("|cffFFFF00Akkio Consume Helper:|r Resetting hover-to-show state...")
  
  -- Reset all hover-related state
  buffStatusFrame.hoverCount = 0
  buffStatusFrame.hideTimer = nil
  
  -- Force frame to hidden state (since hoverCount is 0)
  buffStatusFrame:SetAlpha(0.0)
  
  -- Additional check for stuck timer issue
  local now = GetTime()
  DEFAULT_CHAT_FRAME:AddMessage("|cffADD8E6Current time: " .. string.format("%.2f", now) .. "|r")
  
  DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Akkio Consume Helper:|r Hover state reset successfully!")
  DEFAULT_CHAT_FRAME:AddMessage("|cffADD8E6Frame should now be hidden. Hover over buff icons to make it visible.|r")
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

-- Create welcome window for first-time users
CreateWelcomeWindow = function()
  local welcome = CreateFrame("Frame", "AkkioWelcomeFrame", UIParent)
  welcome:SetWidth(600)
  welcome:SetHeight(400)
  welcome:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
  welcome:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
  })
  welcome:SetFrameStrata("DIALOG")
  welcome:SetFrameLevel(200)
  welcome:SetMovable(true)
  welcome:SetClampedToScreen(true)
  welcome:EnableMouse(true)
  welcome:RegisterForDrag("LeftButton")
  welcome:SetScript("OnDragStart", function() welcome:StartMoving() end)
  welcome:SetScript("OnDragStop", function() welcome:StopMovingOrSizing() end)
  
  -- Title
  local title = welcome:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("TOP", welcome, "TOP", 0, -20)
  title:SetText("|cff00FF00Welcome to Akkio's Consume Helper!|r")
  
  -- Version info
  local version = welcome:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  version:SetPoint("TOP", title, "BOTTOM", 0, -10)
  version:SetText("|cffFFFF00Version " .. ADDON_VERSION .. "|r")
  
  -- Welcome message
  local message = welcome:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  message:SetPoint("TOP", version, "BOTTOM", 0, -20)
  message:SetWidth(450)
  message:SetJustifyH("LEFT")
  message:SetText("|cffADD8E6Thank you for installing Akkio's Consume Helper!\n\n" ..
    "This addon helps you track your consumable buffs and manage your shopping list. " ..
    "Click the button below to open settings and get started:|r")
  
  -- Single settings button (centered)
  local settingsButton = CreateFrame("Button", nil, welcome, "UIPanelButtonTemplate")
  settingsButton:SetWidth(200)
  settingsButton:SetHeight(40)
  settingsButton:SetPoint("TOP", welcome, "TOP", 0, -180)
  settingsButton:SetText("Open Settings")
  settingsButton:SetScript("OnClick", function()
    BuildMainFrame(1)
    welcome:Hide()
  end)
  
  -- Button description
  local settingsDesc = welcome:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  settingsDesc:SetPoint("TOP", settingsButton, "BOTTOM", 0, -10)
  settingsDesc:SetText("|cffCCCCCCFrom settings you can configure buffs, view shopping list, and customize the addon|r")
  
  -- Features list
  local features = welcome:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  features:SetPoint("TOP", welcome, "TOP", 0, -240)
  features:SetWidth(450)
  features:SetJustifyH("LEFT")
  features:SetText("|cffFFD700Key Features:|r\n" ..
    "• Track consumable buff timers with visual indicators\n" ..
    "• Automatic shopping list generation\n" ..
    "• Minimap button for easy access\n" ..
    "• Hover-to-show and combat pause options\n")
  
  -- Close button
  local closeButton = CreateFrame("Button", nil, welcome, "UIPanelButtonTemplate")
  closeButton:SetWidth(100)
  closeButton:SetHeight(25)
  closeButton:SetPoint("BOTTOM", welcome, "BOTTOM", 0, 20)
  closeButton:SetText("Close")
  closeButton:SetScript("OnClick", function()
    welcome:Hide()
    -- Mark that user has seen welcome window
    Akkio_Consume_Helper_Settings.hasSeenWelcome = true
  end)
  
  -- Don't show again checkbox
  local checkbox = CreateFrame("CheckButton", "AkkioWelcomeCheckbox", welcome, "UICheckButtonTemplate")
  checkbox:SetPoint("BOTTOMLEFT", welcome, "BOTTOMLEFT", 20, 25)
  checkbox:SetWidth(20)
  checkbox:SetHeight(20)
  
  local checkboxText = welcome:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  checkboxText:SetPoint("LEFT", checkbox, "RIGHT", 5, 0)
  checkboxText:SetText("Don't show this again")
  
  checkbox:SetScript("OnClick", function()
    if checkbox:GetChecked() then
      Akkio_Consume_Helper_Settings.hasSeenWelcome = true
    else
      Akkio_Consume_Helper_Settings.hasSeenWelcome = false
    end
  end)
  
  return welcome
end

local function OnAddonLoaded()
  -- Run migration first to ensure settings are compatible
  MigrateSettings()
  
  -- Show welcome window for first-time users
  if not Akkio_Consume_Helper_Settings.hasSeenWelcome then
    local welcomeFrame = CreateWelcomeWindow()
    welcomeFrame:Show()
  end
  
  DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00Akkio's Consume Helper|r |cffFFFF00v" .. ADDON_VERSION .. "|r loaded successfully!")
  DEFAULT_CHAT_FRAME:AddMessage("|cffADD8E6Type|r |cffFFFF00/act|r |cffADD8E6to configure buffs|r")
  DEFAULT_CHAT_FRAME:AddMessage("|cffADD8E6Type|r |cffFFFF00/actshopping|r |cffADD8E6to view shopping list|r")
  if not buffStatusFrame then
    -- No need to set rebuild flag here since frame doesn't exist yet
    BuildBuffStatusUI()
  end
  CreateMinimapButton()
end

local function OnInCombat()
  -- Set combat state
  Akkio_Consume_Helper_Settings.settings.inCombat = true
  
  -- Stop the buff status UI updates during combat (if enabled)
  if Akkio_Consume_Helper_Settings.settings.pauseUpdatesInCombat and buffStatusFrame and buffStatusFrame.ticker then
    buffStatusFrame.ticker:SetScript("OnUpdate", nil)
    
    -- BUT keep essential functionality working by creating a minimal timer
    -- This handles hover-to-show AND timer display updates during combat pause
    buffStatusFrame.ticker:SetScript("OnUpdate", function()
      local now = GetTime()
      
      -- Handle hover-to-show timer during combat pause
      if buffStatusFrame.hideTimer and now >= buffStatusFrame.hideTimer then
        if Akkio_Consume_Helper_Settings.settings.hoverToShow then
          -- Force hide if timer has expired, regardless of hoverCount state
          buffStatusFrame.hoverCount = 0 -- Reset hover count
          buffStatusFrame:SetAlpha(0.0) -- Hide the frame
        end
        buffStatusFrame.hideTimer = nil -- Clear the timer
      end
      
      -- Update timer displays every second even during combat pause
      -- This keeps consumable and weapon enchant timers visually accurate
      if buffStatusFrame.children then
        for i = 1, table.getn(buffStatusFrame.children) do
          local icon = buffStatusFrame.children[i]
          if icon and icon.buffdata and icon.timerLabel then
            local data = icon.buffdata
            
            -- Update consumable timer displays
            if not data.isWeaponEnchant and data.duration then
              local remainingTime = getBuffRemainingTime(data.name)
              icon.timerLabel:SetText(formatTimeRemaining(remainingTime))
            end
            
            -- Update weapon enchant timer displays
            if data.isWeaponEnchant then
              if data.slot == "mainhand" then
                local hasMainHandEnchant, mainHandExpiration = GetWeaponEnchantInfo()
                if hasMainHandEnchant and mainHandExpiration then
                  local remainingSeconds = mainHandExpiration / 1000
                  icon.timerLabel:SetText(formatTimeRemaining(remainingSeconds))
                else
                  icon.timerLabel:SetText("")
                end
              elseif data.slot == "offhand" then
                local _, _, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
                if hasOffHandEnchant and offHandExpiration then
                  local remainingSeconds = offHandExpiration / 1000
                  icon.timerLabel:SetText(formatTimeRemaining(remainingSeconds))
                else
                  icon.timerLabel:SetText("")
                end
              end
            end
          end
        end
      end
    end)
  end
  
  -- Hide the buff status frame during combat (if enabled)
  if Akkio_Consume_Helper_Settings.settings.hideFrameInCombat and buffStatusFrame then
    buffStatusFrame:Hide()
  end
end

local function OnLeavingCombat()
  -- Set combat state
  Akkio_Consume_Helper_Settings.settings.inCombat = false
  
  -- Resume buff status UI updates after combat (if they were paused)
  if Akkio_Consume_Helper_Settings.settings.pauseUpdatesInCombat and buffStatusFrame and buffStatusFrame.ticker then
    buffStatusFrame.ticker.lastUpdate = GetTime() -- Reset the timer
    buffStatusFrame.ticker.lastFullUpdate = GetTime() -- Reset full update timer too
    buffStatusFrame.ticker.lastCleanup = GetTime() -- Reset cleanup timer too
    buffStatusFrame.ticker:SetScript("OnUpdate", function()
      local now = GetTime()
      
      -- CRITICAL: Include hover-to-show timer logic that was missing!
      if buffStatusFrame.hideTimer and now >= buffStatusFrame.hideTimer then
        if Akkio_Consume_Helper_Settings.settings.hoverToShow then
          -- Force hide if timer has expired, regardless of hoverCount state
          buffStatusFrame.hoverCount = 0 -- Reset hover count
          buffStatusFrame:SetAlpha(0.0) -- Hide the frame
        end
        buffStatusFrame.hideTimer = nil -- Clear the timer
      end
      
      -- Periodic cleanup of expired buff tracker entries (every 30 seconds)
      if (now - buffStatusFrame.ticker.lastCleanup) > 30 then
        if buffTracker and Akkio_Consume_Helper_Settings.buffTracker then
          for buffName, tracker in pairs(buffTracker) do
            local elapsedTime = now - tracker.startTime
            if elapsedTime >= tracker.duration then
              -- Only remove if the buff is no longer active
              local stillActive = false
              for i = 1, 40 do
                local tex = UnitBuff("player", i)
                if not tex then break end
                if tex == tracker.icon then
                  stillActive = true
                  break
                end
              end
              if not stillActive then
                buffTracker[buffName] = nil
                Akkio_Consume_Helper_Settings.buffTracker[buffName] = nil
              end
            end
          end
        end
        buffStatusFrame.ticker.lastCleanup = now
      end
      
      if (now - buffStatusFrame.ticker.lastUpdate) > updateTimer then
        -- Only do a quick update of buff status, not full UI rebuild
        UpdateBuffStatusOnly()
        buffStatusFrame.ticker.lastUpdate = now
        
        -- Full UI rebuild only every 10 seconds or when settings change
        -- BUT skip automatic rebuilds when hover-to-show is enabled to prevent unwanted visibility
        if (now - buffStatusFrame.ticker.lastFullUpdate) > 10 then
          -- Only do automatic rebuilds if hover-to-show is disabled OR if someone is currently hovering
          if not Akkio_Consume_Helper_Settings.settings.hoverToShow or 
             (buffStatusFrame.hoverCount and buffStatusFrame.hoverCount > 0) then
            BuildBuffStatusUI()
          end
          buffStatusFrame.ticker.lastFullUpdate = now
        end
      end
    end)
  end
  
  -- Show the buff status frame after combat (if it was hidden)
  if Akkio_Consume_Helper_Settings.settings.hideFrameInCombat and buffStatusFrame then
    buffStatusFrame:Show()
  end
end
-- Event handling
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("VARIABLES_LOADED")
initFrame:SetScript("OnEvent", OnAddonLoaded)

local inCombatFrame = CreateFrame("Frame")
inCombatFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
inCombatFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
inCombatFrame:SetScript("OnEvent", function()
  if event == "PLAYER_REGEN_DISABLED" then
    OnInCombat()
  elseif event == "PLAYER_REGEN_ENABLED" then
    OnLeavingCombat()
  end
end)

-- ============================================================================
-- BANK & MAIL SCANNING FOR TRACKER
-- ============================================================================

local isBankOpen = false
local isMailOpen = false

local function scanBankForTracker()
  if not isBankOpen then return end
  local store = Akkio_Consume_Helper_Settings.tracker
  if not store then return end
  store.bank = {}

  if not getglobal("ItemDataScanTooltip") then
    CreateFrame("GameTooltip", "ItemDataScanTooltip", UIParent, "GameTooltipTemplate")
  end
  local scanTip = getglobal("ItemDataScanTooltip")

  for bag = -1, 10 do
    if bag == -1 or (bag >= 5 and bag <= 10) then
      local numSlots = GetContainerNumSlots(bag)
      if numSlots then
        for slot = 1, numSlots do
          local itemLink = GetContainerItemLink(bag, slot)
          if itemLink then
            local _, _, linkName = string.find(itemLink, "%[(.-)%]")
            if linkName then
              local baseName = string.gsub(linkName, " %(%d+%)$", "")
              -- Use tooltip scanning to get charges for charged items (oils etc.)
              scanTip:SetOwner(UIParent, "ANCHOR_NONE")
              scanTip:ClearLines()
              scanTip:SetBagItem(bag, slot)
              local charges = nil
              for line = 1, scanTip:NumLines() do
                local lineFrame = getglobal("ItemDataScanTooltipTextLeft" .. line)
                if lineFrame and lineFrame:GetText() then
                  local _, _, chargesStr = string.find(lineFrame:GetText(), "(%d+) Charge")
                  if chargesStr then
                    charges = tonumber(chargesStr)
                    break
                  end
                end
              end
              if not charges then
                local _, itemCount = GetContainerItemInfo(bag, slot)
                if itemCount then charges = math.abs(itemCount) end
              end
              if charges and charges > 0 then
                store.bank[baseName] = (store.bank[baseName] or 0) + charges
              end
            end
          end
        end
      end
    end
  end
  if Akkio_Consume_Helper_Shopping and Akkio_Consume_Helper_Shopping.RefreshTracker then
    Akkio_Consume_Helper_Shopping.RefreshTracker()
  end
end

local function scanMailForTracker()
  if not isMailOpen then return end
  local store = Akkio_Consume_Helper_Settings.tracker
  if not store then return end
  store.mail = {}

  if not getglobal("ItemDataScanTooltip") then
    CreateFrame("GameTooltip", "ItemDataScanTooltip", UIParent, "GameTooltipTemplate")
  end
  local scanTip = getglobal("ItemDataScanTooltip")

  local numItems = GetInboxNumItems()
  if numItems and numItems > 0 then
    for i = 1, numItems do
      local itemName, _, itemCount = GetInboxItem(i)
      if itemName and itemCount and itemCount > 0 then
        -- Use tooltip scanning to get charges for charged items (oils etc.)
        scanTip:SetOwner(UIParent, "ANCHOR_NONE")
        scanTip:ClearLines()
        scanTip:SetInboxItem(i)
        local charges = nil
        for line = 1, scanTip:NumLines() do
          local lineFrame = getglobal("ItemDataScanTooltipTextLeft" .. line)
          if lineFrame and lineFrame:GetText() then
            local _, _, chargesStr = string.find(lineFrame:GetText(), "(%d+) Charge")
            if chargesStr then
              charges = tonumber(chargesStr)
              break
            end
          end
        end
        store.mail[itemName] = (store.mail[itemName] or 0) + (charges or itemCount)
      end
    end
  end
  if Akkio_Consume_Helper_Shopping and Akkio_Consume_Helper_Shopping.RefreshTracker then
    Akkio_Consume_Helper_Shopping.RefreshTracker()
  end
end

local bankDelayFrame = CreateFrame("Frame")
bankDelayFrame:Hide()
local bankDelayStart = 0
bankDelayFrame:SetScript("OnUpdate", function()
  if GetTime() - bankDelayStart >= 0.5 then
    bankDelayFrame:Hide()
    scanBankForTracker()
  end
end)

local mailDelayFrame = CreateFrame("Frame")
mailDelayFrame:Hide()
local mailDelayStart = 0
mailDelayFrame:SetScript("OnUpdate", function()
  if GetTime() - mailDelayStart >= 0.5 then
    mailDelayFrame:Hide()
    scanMailForTracker()
  end
end)

-- Ensure buff tracker data gets saved
local saveFrame = CreateFrame("Frame")
saveFrame:RegisterEvent("PLAYER_LOGOUT")
saveFrame:RegisterEvent("ADDON_LOADED")
saveFrame:RegisterEvent("BANKFRAME_OPENED")
saveFrame:RegisterEvent("BANKFRAME_CLOSED")
saveFrame:RegisterEvent("MAIL_SHOW")
saveFrame:RegisterEvent("MAIL_CLOSED")
saveFrame:RegisterEvent("MAIL_INBOX_UPDATE")
saveFrame:SetScript("OnEvent", function()
  if event == "ADDON_LOADED" and arg1 == "Akkio_Consume_Helper" then
    -- Reinitialize buffTracker reference after addon loads
    initializeBuffTracker()
    buffTracker = Akkio_Consume_Helper_Settings.buffTracker

    -- Initialize shopping list module if available
    if Akkio_Consume_Helper_Shopping and Akkio_Consume_Helper_Shopping.Initialize then
      Akkio_Consume_Helper_Shopping.Initialize()
    end
  elseif event == "PLAYER_LOGOUT" then
    -- Force save buff tracker data on logout
    if buffTracker then
      for buffName, data in pairs(buffTracker) do
        Akkio_Consume_Helper_Settings.buffTracker[buffName] = data
      end
    end
  elseif event == "BANKFRAME_OPENED" then
    isBankOpen = true
    bankDelayStart = GetTime()
    bankDelayFrame:Show()
  elseif event == "BANKFRAME_CLOSED" then
    isBankOpen = false
  elseif event == "MAIL_SHOW" then
    isMailOpen = true
    mailDelayStart = GetTime()
    mailDelayFrame:Show()
  elseif event == "MAIL_CLOSED" then
    isMailOpen = false
  elseif event == "MAIL_INBOX_UPDATE" then
    if isMailOpen then
      mailDelayStart = GetTime()
      mailDelayFrame:Show()
    end
  end
end)