-- Akkio's Consume Helper - Tracker Module

if not Akkio_Consume_Helper_Shopping then
  Akkio_Consume_Helper_Shopping = {}
end

-- ============================================================================
-- MATS LOOKUP (by itemID)
-- ============================================================================

local itemMats = {
  -- Flasks
  [13510] = {"30x Golden Sansam", "10x Stonescale Oil", "1x Black Lotus", "1x Crystal Vial"},
  [13512] = {"30x Dreamfoil", "10x Mountain Silversage", "1x Black Lotus", "1x Crystal Vial"},
  [13511] = {"30x Sungrass", "10x Icecap", "1x Black Lotus", "1x Crystal Vial"},
  -- Elixirs & Concoctions
  [13452] = {"2x Mountain Silversage", "2x Plaguebloom", "1x Crystal Vial"},
  [3825]  = {"1x Wild Steelbloom", "1x Goldthorn", "1x Leaded Vial"},
  [9206]  = {"1x Sungrass", "1x Gromsblood", "1x Crystal Vial"},
  [13445] = {"2x Stonescale Oil", "1x Sungrass", "1x Crystal Vial"},
  [9179]  = {"1x Blindweed", "1x Khadgar's Whisker", "1x Crystal Vial"},
  [13447] = {"1x Dreamfoil", "2x Plaguebloom", "1x Crystal Vial"},
  [61224] = {"1x Dream Dust", "1x Small Dream Shard", "1x Crystal Vial"},
  [13454] = {"3x Dreamfoil", "1x Mountain Silversage", "1x Crystal Vial"},
  [9264]  = {"3x Ghost Mushroom", "1x Crystal Vial"},
  [21546] = {"3x Fire Oil", "3x Firebloom", "1x Crystal Vial"},
  [55048] = {"3x Purple Lotus", "1x Crystal Vial"},
  [17708] = {"2x Wintersbite", "1x Khadgar's Whisker", "1x Leaded Vial"},
  [50237] = {"3x Heart of the Wild", "1x Golden Sansam", "1x Sungrass", "1x Crystal Vial"},
  [47412] = {9206, 13454, "1x Imbued Vial"},
  [47414] = {12820, 61423, "1x Imbued Vial"},
  [47410] = {13452, 61224, "1x Imbued Vial"},
  -- Special Potions & Consumables
  [20079] = {"Quest: 1x Zandalar Honor Token"},
  [20007] = {"1x Dreamfoil", "2x Plaguebloom", "1x Crystal Vial"},
  [20004] = {"1x Gromsblood", "2x Plaguebloom", "1x Crystal Vial"},
  [8412]  = {"Quest: 1x Blasted Boar Lung", "2x Vulture Gizzard", "3x Scorpok Pincer"},
  [8410]  = {"Quest: 1x Scorpok Pincer", "2x Blasted Boar Lung", "3x Snickerfang Jowl"},
  [8423]  = {"Quest: 10x Basilisk Brain", "2x Vulture Gizzard"},
  [9088]  = {"1x Arthas' Tears", "1x Blindweed", "1x Crystal Vial"},
  [61423] = {"Quest: 1x Small Dream Shard"},
  [12820] = {"Drops from Furbolgs in Winterspring"},
  -- Weapon Enchants
  [12404] = {"1x Dense Stone"},
  [18262] = {"2x Elemental Earth", "3x Dense Stone"},
  [20748] = {"2x Large Brilliant Shard", "3x Purple Lotus", "1x Imbued Vial"},
  [20749] = {"2x Large Brilliant Shard", "3x Firebloom", "1x Imbued Vial"},
  [23123] = {"Quest: 8x Necrotic Rune"},
  [3829]  = {"4x Khadgar's Whisker", "2x Wintersbite", "1x Leaded Vial"},
  [23122] = {"Quest: 8x Necrotic Rune"},
  -- Juju
  [12460] = {"Quest: 3x Frostmaul E'ko (Kill Frostmaul Giants)"},
  [12451] = {"Quest: 3x Winterfall E'ko (Kill Furbolgs)"},
  [12450] = {"Quest: 3x Frostsaber E'ko (Kill Flying Chillwinds)"},
  -- Food & Drinks
  [20452] = {"1x Sandworm Meat", "1x Soothing Spices"},
  [13931] = {"1x Raw Nightfin Snapper", "1x Refreshing Spring Water"},
  [18254] = {"1x Runn Tum Tuber", "1x Soothing Spices"},
  [13933] = {"1x Darkclaw Lobster", "1x Refreshing Spring Water"},
  [21023] = {"1x Chimaerok Tenderloin", "1x Hot Spices", "1x Goblin Rocket Fuel", "1x Deeprock Salt"},
  [53015] = {"1x Tender Crocolisk Meat", "1x Tiger Meat", "2x Mystery Meat", "1x Hot Spices", "1x Soothing Spices"},
  [84040] = {"1x Raw Whitescale Salmon", "1x Soothing Spices", "1x Premium Chocolate", "1x Golden Sansam"},
  [51714] = {"Gardening: Mountain Berry Bush Seeds"},
  [51711] = {"Gardening: Mountain Berry Bush Seeds"},
  [60978] = {"1x Gargantuan Tel'Abim Banana", "1x Soothing Spices", "2x Golden Sansam"},
  [60976] = {"1x Gargantuan Tel'Abim Banana", "1x Soothing Spices", "1x Heart of the Wild"},
  [60977] = {"1x Gargantuan Tel'Abim Banana", "1x Soothing Spices", "1x Icecap"},
  [51717] = {"Gardening: Magic Mushroom Spores"},
  [51720] = {"Gardening: Magic Mushroom Spores"},
  -- Alcoholic Beverages
  [21151] = {"Diverse vendors"},
  [61174] = {"Looted from wine barrels in Lower Karazhan Halls"},
  [61175] = {"Looted from wine barrels in Lower Karazhan Halls"},
  [18269] = {"Bought from Stomper Kreeg after a Dire Maul Tribute run"},
  -- Resistance Potions
  [13457] = {"1x Elemental Fire", "1x Firebloom", "1x Crystal Vial"},
  [13456] = {"1x Elemental Water", "1x Icecap", "1x Crystal Vial"},
  [13458] = {"1x Elemental Earth", "1x Dreamfoil", "1x Crystal Vial"},
  [13459] = {"1x Shadow Oil", "2x Arthas' Tears", "1x Crystal Vial"},
  [13461] = {"1x Dream Dust", "1x Dreamfoil", "1x Crystal Vial"},
  [13460] = {"1x Elemental Air", "1x Golden Sansam", "1x Crystal Vial"},
  -- Combat Potions
  [61675] = {"Quest: 1x Small Dream Shard"},
  [61181] = {"1x Gromsblood", "2x Mountain Silversage", "1x Swiftness Potion"},
  [13442] = {"3x Gromsblood", "1x Crystal Vial"},
  [13455] = {"3x Stonescale Oil", "1x Thorium Ore", "1x Crystal Vial"},
}

-- ============================================================================
-- ITEM NAME LOOKUP (built lazily from allBuffs)
-- ============================================================================

local itemNames = nil  -- itemID -> name

local function getItemName(itemID)
  if not itemNames then
    itemNames = {}
    local allBuffs = Akkio_Consume_Helper_Data and Akkio_Consume_Helper_Data.allBuffs or {}
    for _, data in ipairs(allBuffs) do
      if not data.header and data.itemID and data.name then
        itemNames[data.itemID] = data.name
      end
    end
  end
  return itemNames[itemID] or ("Item #" .. itemID)
end

-- Adds mats lines to GameTooltip recursively.
-- Integer mats are resolved to their name + sub-ingredients (indented).
local function addMatsLines(mats, indent)
  indent = indent or "  "
  for _, mat in ipairs(mats) do
    if type(mat) == "number" then
      local name = getItemName(mat)
      GameTooltip:AddLine(indent .. name .. ":", 0.9, 0.75, 0.2, 1)
      local subMats = itemMats[mat]
      if subMats then
        addMatsLines(subMats, indent .. "  ")
      end
    else
      GameTooltip:AddLine(indent .. mat, 0.4, 0.8, 1, 1)
    end
  end
end

-- ============================================================================
-- HELPERS
-- ============================================================================

local function initTrackerSettings()
  if not Akkio_Consume_Helper_Settings.tracker then
    Akkio_Consume_Helper_Settings.tracker = {}
  end
  local t = Akkio_Consume_Helper_Settings.tracker
  if not t.thresholds   then t.thresholds   = {} end
  if not t.bank         then t.bank         = {} end
  if not t.mail         then t.mail         = {} end
end

local function getThreshold(itemName)
  initTrackerSettings()
  local v = Akkio_Consume_Helper_Settings.tracker.thresholds[itemName]
  if v then return v end
  return 10
end

local function setThreshold(itemName, value)
  initTrackerSettings()
  Akkio_Consume_Helper_Settings.tracker.thresholds[itemName] = value
end

local function getBagCount(data)
  if not Akkio_Consume_Helper_Tracker then return 0 end
  if data.isWeaponEnchant then
    return Akkio_Consume_Helper_Tracker.getCharges(data.name)
  end
  return Akkio_Consume_Helper_Tracker.getAmount(data.name)
end

local function getBankCount(itemName)
  initTrackerSettings()
  return Akkio_Consume_Helper_Settings.tracker.bank[itemName] or 0
end

local function getMailCount(itemName)
  initTrackerSettings()
  return Akkio_Consume_Helper_Settings.tracker.mail[itemName] or 0
end

local function formatCount(bags, bank, mail)
  local s = tostring(bags)
  if bank > 0 then s = s .. " +" .. bank end
  if mail  > 0 then s = s .. " +" .. mail  end
  return s
end

-- Items to skip: no itemID and not a weapon enchant (pure class spell buffs)
-- Also skip checkInventory items (e.g. Healthstone - consumed instantly, not a supply item)
local function shouldTrack(data)
  if data.checkInventory then return false end
  return data.itemID ~= nil or data.isWeaponEnchant
end

-- ============================================================================
-- INITIALIZE
-- ============================================================================

function Akkio_Consume_Helper_Shopping.Initialize()
  initTrackerSettings()
end

-- ============================================================================
-- TRACKER UI
-- ============================================================================

local trackerPanel = nil  -- reference to the panel frame
local trackerRows  = {}   -- list of row frames for refresh
local editMode     = false

function Akkio_Consume_Helper_Shopping.BuildTrackerUI(panel)
  trackerPanel = panel
  trackerRows  = {}
  editMode     = false

  initTrackerSettings()

  local allBuffs = Akkio_Consume_Helper_Data and Akkio_Consume_Helper_Data.allBuffs or {}

  -- ---- Top bar ------------------------------------------------
  local searchBox = CreateFrame("EditBox", "AkkioTrackerSearch", panel, "InputBoxTemplate")
  searchBox:SetWidth(230)
  searchBox:SetHeight(22)
  searchBox:SetPoint("TOPLEFT", panel, "TOPLEFT", 5, -5)
  searchBox:SetAutoFocus(false)
  searchBox:SetText("Search...")
  searchBox:SetTextColor(0.5, 0.5, 0.5)
  searchBox:SetScript("OnEditFocusGained", function()
    if this:GetText() == "Search..." then
      this:SetText("")
      this:SetTextColor(1, 1, 1)
    end
  end)
  searchBox:SetScript("OnEditFocusLost", function()
    if this:GetText() == "" then
      this:SetText("Search...")
      this:SetTextColor(0.5, 0.5, 0.5)
    end
  end)
  searchBox:SetScript("OnTextChanged", function()
    Akkio_Consume_Helper_Shopping.RefreshTracker()
  end)

  local editBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
  editBtn:SetWidth(110)
  editBtn:SetHeight(22)
  editBtn:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -30, -5)
  editBtn:SetText("Edit threshold")
  editBtn:SetScript("OnClick", function()
    editMode = not editMode
    this:SetText(editMode and "Done" or "Edit threshold")
    Akkio_Consume_Helper_Shopping.RefreshTracker()
  end)

  -- ---- Scroll frame -------------------------------------------
  local scrollFrame = CreateFrame("ScrollFrame", "AkkioTrackerScrollFrame", panel)
  scrollFrame:SetPoint("TOPLEFT",     panel, "TOPLEFT",     0,  -32)
  scrollFrame:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -20, 5)
  scrollFrame:EnableMouseWheel(true)

  local scrollChild = CreateFrame("Frame", nil, scrollFrame)
  scrollChild:SetWidth(scrollFrame:GetWidth() or 560)
  scrollChild:SetHeight(1)
  scrollFrame:SetScrollChild(scrollChild)

  local scrollBar = CreateFrame("Slider", "AkkioTrackerScrollBar", panel, "UIPanelScrollBarTemplate")
  scrollBar:SetPoint("TOPRIGHT",    panel, "TOPRIGHT",    -2, -32)
  scrollBar:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -2,  5)
  scrollBar:SetWidth(16)
  scrollBar:SetMinMaxValues(0, 0)
  scrollBar:SetValue(0)
  scrollBar:SetScript("OnValueChanged", function()
    scrollFrame:SetVerticalScroll(this:GetValue())
  end)
  scrollFrame:SetScript("OnMouseWheel", function()
    local cur = scrollFrame:GetVerticalScroll()
    local max = scrollBar:GetMaxValue() and scrollBar:GetMaxValue() or 0
    local new = math.max(0, math.min(cur - arg1 * 20, max))
    scrollFrame:SetVerticalScroll(new)
    scrollBar:SetValue(new)
  end)

  -- Store references for refresh
  panel.searchBox   = searchBox
  panel.scrollChild = scrollChild
  panel.scrollBar   = scrollBar
  panel.scrollFrame = scrollFrame
  panel.allBuffs    = allBuffs

  Akkio_Consume_Helper_Shopping.RefreshTracker()
end

-- ============================================================================
-- REFRESH (rebuilds visible rows)
-- ============================================================================

function Akkio_Consume_Helper_Shopping.RefreshTracker()
  if not trackerPanel or not trackerPanel.scrollChild then return end

  local panel      = trackerPanel
  local scrollChild = panel.scrollChild
  local allBuffs   = panel.allBuffs or {}

  -- Destroy old rows
  for _, row in ipairs(trackerRows) do
    row:Hide()
  end
  trackerRows = {}

  -- Filter text
  local filterText = ""
  if panel.searchBox then
    filterText = string.lower(panel.searchBox:GetText() or "")
    if filterText == "search..." then filterText = "" end
  end

  -- Collect enabled items
  local enabledSet = {}
  for _, name in ipairs(Akkio_Consume_Helper_Settings.enabledBuffs) do
    enabledSet[name] = true
  end

  local lineH   = 26
  local yOffset = 0
  local rowW    = (scrollChild:GetWidth() or 560) - 10

  for _, data in ipairs(allBuffs) do
    if not data.header and shouldTrack(data) then
      -- Determine enabled key (weapon enchants include slot)
      local key = data.name
      if data.isWeaponEnchant then
        key = data.name .. "_" .. data.slot
      end

      if enabledSet[key] then
        -- Filter
        local nameMatch = filterText == "" or string.find(string.lower(data.name), filterText)
        if nameMatch then
          local bags   = getBagCount(data)
          local bank   = getBankCount(data.name)
          local mail   = getMailCount(data.name)
          local thresh = getThreshold(data.name)
          local total  = bags + bank + mail

          -- Row frame
          local row = CreateFrame("Frame", nil, scrollChild)
          row:SetWidth(rowW)
          row:SetHeight(lineH)
          row:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 5, -yOffset)
          row:EnableMouse(true)
          table.insert(trackerRows, row)

          -- Item icon
          local iconTex = row:CreateTexture(nil, "ARTWORK")
          iconTex:SetWidth(18)
          iconTex:SetHeight(18)
          iconTex:SetPoint("LEFT", row, "LEFT", 0, 0)
          iconTex:SetTexture(data.icon)

          -- Item name label
          local nameLabel = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
          nameLabel:SetPoint("LEFT", iconTex, "RIGHT", 4, 0)
          nameLabel:SetWidth(220)
          nameLabel:SetJustifyH("LEFT")
          local displayName = data.name
          if data.isWeaponEnchant then
            displayName = data.name .. " (" .. (data.slot == "mainhand" and "MH" or "OH") .. ")"
          end
          nameLabel:SetText(displayName)

          -- Count label — color logic:
          --   bags >= thresh           → green
          --   bags < thresh, total >= thresh → orange (bank/mail can cover it)
          --   bags < thresh, total < thresh  → red
          local countLabel = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
          countLabel:SetPoint("RIGHT", row, "RIGHT", editMode and -60 or -5, 0)
          countLabel:SetJustifyH("RIGHT")
          countLabel:SetText(formatCount(bags, bank, mail))
          if bags >= thresh then
            countLabel:SetTextColor(0, 1, 0)
          elseif total >= thresh then
            countLabel:SetTextColor(1, 0.5, 0)
          else
            countLabel:SetTextColor(1, 0, 0)
          end

          -- Edit mode: threshold editbox
          if editMode then
            local threshBox = CreateFrame("EditBox", nil, row, "AkkioEditBoxTemplate")
            threshBox:SetWidth(50)
            threshBox:SetHeight(16)
            threshBox:SetPoint("RIGHT", row, "RIGHT", -5, 0)
            threshBox:SetMaxLetters(4)
            threshBox:SetText(tostring(thresh))
            local capturedName = data.name
            threshBox:SetScript("OnEnterPressed", function()
              this:ClearFocus()
              local v = tonumber(this:GetText())
              if v and v >= 0 then
                setThreshold(capturedName, v)
              else
                this:SetText(tostring(getThreshold(capturedName)))
              end
              Akkio_Consume_Helper_Shopping.RefreshTracker()
            end)
            threshBox:SetScript("OnEscapePressed", function()
              this:ClearFocus()
              this:SetText(tostring(getThreshold(capturedName)))
            end)
          end

          -- Tooltip on hover
          local capturedData = data
          row:SetScript("OnEnter", function()
            if capturedData.itemID then
              GameTooltip:SetOwner(this, "ANCHOR_CURSOR")
              GameTooltip:SetHyperlink("item:" .. capturedData.itemID)
              -- Inventory / bank / mail breakdown
              local inv = getBagCount(capturedData)
              local b   = getBankCount(capturedData.name)
              local m   = getMailCount(capturedData.name)
              GameTooltip:AddLine(" ")
              GameTooltip:AddLine("Inventory: " .. inv, 1, 1, 1, 1)
              if b > 0 then
                GameTooltip:AddLine("Bank: " .. b, 0.7, 0.7, 1, 1)
              end
              if m > 0 then
                GameTooltip:AddLine("Mail: " .. m, 0.7, 1, 0.7, 1)
              end
              -- Ingredients / source
              local mats = itemMats[capturedData.itemID]
              if mats then
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("Materials:", 1, 0.82, 0, 1)
                addMatsLines(mats, "  ")
              end
              GameTooltip:Show()
            end
          end)
          row:SetScript("OnLeave", function()
            GameTooltip:Hide()
          end)

          yOffset = yOffset + lineH
        end
      end
    end
  end

  -- Resize scroll child
  scrollChild:SetHeight(math.max(yOffset, 1))

  -- Update scrollbar
  local visibleH  = panel.scrollFrame and panel.scrollFrame:GetHeight() or 700
  local maxScroll = math.max(0, yOffset - visibleH)
  panel.scrollBar:SetMinMaxValues(0, maxScroll)
  if maxScroll == 0 then
    panel.scrollBar:Hide()
  else
    panel.scrollBar:Show()
  end
end
