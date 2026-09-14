---@class GuiMaker

local GuiMaker = {}

local function extractKeyVal(object)
  local ret = {}
  for key, value in pairs(object) do
    if type(key) ~= "number" then
      ret[key] = value
    end
  end
  return ret
end

local function buildGuiElement(parentGuiElement, guiDefinition)
  local keyVals = extractKeyVal(guiDefinition)
  if keyVals.type == "textfieldInt" then
    keyVals.type = "textfield"
    keyVals.text = keyVals.text or "0"
    keyVals.numeric_only = true
    keyVals.allow_decimal = false
    keyVals.allow_negative = false
  end
  local newGuiElement = parentGuiElement.add(keyVals)
  if not newGuiElement.type then
    log("Error: Gui element missing type " .. tostring(guiDefinition))
    return nil
  end
  for _, childDefinition in ipairs(guiDefinition) do
    buildGuiElement(newGuiElement, childDefinition)
  end
  return newGuiElement
end

function GuiMaker.getGui(guiRoot, guiDefinition)
  if guiDefinition.name == nil or guiDefinition.name == "" then
    log("Error: guiDefinition must have a valid name.")
    return nil
  end
  if guiRoot[guiDefinition.name] then
    return guiRoot[guiDefinition.name]
  end
  local guiElement = buildGuiElement(guiRoot, guiDefinition)
  return guiElement
end

return GuiMaker