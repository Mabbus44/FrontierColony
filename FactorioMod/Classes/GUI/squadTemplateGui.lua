local SquadTemplate = require("Classes.Squad.squadTemplate")
local TransportType = require("Enums.transportType")
local WeaponType = require("Enums.weaponType")
local SquadPrio = require("Enums.squadPrio")

local SquadTemplateGui = {}

local ROOT_NAME = "frontier_colony_squad_template_gui"

local transportTypes = {
  TransportType.BACKPACK,
  TransportType.HORSE,
  TransportType.CAR,
  TransportType.TRUCK,
  TransportType.ROAD_TRAIN
}

local weaponTypes = {
  WeaponType.AXE,
  WeaponType.PISTOL,
  WeaponType.MACHINE_GUN,
  WeaponType.FLAME_THROWER,
  WeaponType.POISON_THROWER,
  WeaponType.LASER_RIFLE,
  WeaponType.FREEZE_RAY,
  WeaponType.ROCKET_LAUNCHER
}

local priorities = {
  SquadPrio.MAXIMIZE_RESOURCES,
  SquadPrio.PRESERVE_RESOURCES,
  SquadPrio.SPEED_OVER_RESOURCES,
  SquadPrio.SPEED_OVER_PEOPLE
}

local function findValue(values, value)
  for index, currentValue in ipairs(values) do
    if currentValue == value then
      return index
    end
  end

  return 1
end

local function close(player)
  local gui = player.gui.screen[ROOT_NAME]
  if gui and gui.valid then
    gui.destroy()
  end
end

local function addNumberField(parent, fieldName, caption, value)
  local row = parent.add {
    type = "flow",
    direction = "horizontal"
  }

  row.add {
    type = "label",
    caption = caption
  }

  row.add {
    type = "textfield",
    name = fieldName,
    text = tostring(value or 0),
    numeric_only = true,
    allow_decimal = false,
    allow_negative = false
  }
end

local function addEnumSection(parent, title, prefix, values, source)
  parent.add {
    type = "label",
    caption = title
  }

  for _, enumValue in ipairs(values) do
    local fieldName = prefix .. enumValue
    addNumberField(parent, fieldName, enumValue, source[enumValue] or 0)
  end
end

local function getNumber(root, fieldName, caption)
  local element = root[fieldName]
  local value = tonumber(element.text)

  if not value or value < 0 or value ~= math.floor(value) then
    return nil, caption .. " must be a non-negative whole number."
  end

  return value
end

local function readTemplate(root)
  local template = SquadTemplate:new()

  template.name = root.template_name.text

  if template.name == "" then
    return nil, "A template name is required."
  end

  local peopleMax, errorMessage = getNumber(root, "people_max", "Maximum people")
  if not peopleMax then
    return nil, errorMessage
  end
  template.peopleMax = peopleMax

  for _, transportType in ipairs(transportTypes) do
    local fieldName = "transport_" .. transportType
    local value, fieldError = getNumber(root, fieldName, transportType)

    if not value then
      return nil, fieldError
    end

    template.transportsMax[transportType] = value
  end

  for _, weaponType in ipairs(weaponTypes) do
    local weaponField = "weapon_" .. weaponType
    local ammoField = "ammo_" .. weaponType

    local weaponValue, weaponError =
      getNumber(root, weaponField, weaponType .. " maximum")

    if not weaponValue then
      return nil, weaponError
    end

    local ammoValue, ammoError =
      getNumber(root, ammoField, weaponType .. " ammunition maximum")

    if not ammoValue then
      return nil, ammoError
    end

    template.weaponsMax[weaponType] = weaponValue
    template.ammoMax[weaponType] = ammoValue
  end

  template.prio = priorities[root.priority.selected_index]

  return template
end

function SquadTemplateGui.open(player, templateIndex, onSaved)
  close(player)

  local templates = require("Classes.globals"):get().squadTemplates
  local template

  if templateIndex then
    template = table.deepcopy(templates[templateIndex])
  else
    template = SquadTemplate:new()
  end

  local root = player.gui.screen.add {
    type = "frame",
    name = ROOT_NAME,
    direction = "vertical",
    caption = templateIndex and "Edit squad template" or "New squad template"
  }

  root.auto_center = true

  local content = root.add {
    type = "scroll-pane",
    name = "content",
    direction = "vertical"
  }

  addNumberField(content, "people_max", "Maximum people", template.peopleMax)

  local nameRow = content.add {
    type = "flow",
    direction = "horizontal"
  }

  nameRow.add {
    type = "label",
    caption = "Name"
  }

  nameRow.add {
    type = "textfield",
    name = "template_name",
    text = template.name
  }

  addEnumSection(
    content,
    "Maximum transports",
    "transport_",
    transportTypes,
    template.transportsMax
  )

  addEnumSection(
    content,
    "Maximum weapons",
    "weapon_",
    weaponTypes,
    template.weaponsMax
  )

  addEnumSection(
    content,
    "Maximum ammunition",
    "ammo_",
    weaponTypes,
    template.ammoMax
  )

  content.add {
    type = "label",
    caption = "Priority"
  }

  content.add {
    type = "drop-down",
    name = "priority",
    items = priorities,
    selected_index = findValue(priorities, template.prio)
  }

  root.add {
    type = "label",
    name = "error",
    caption = ""
  }

  local buttons = root.add {
    type = "flow",
    direction = "horizontal"
  }

  buttons.add {
    type = "button",
    name = "save",
    caption = "Save"
  }

  buttons.add {
    type = "button",
    name = "cancel",
    caption = "Cancel"
  }

  root.tags = {
    template_index = templateIndex
  }
end

function SquadTemplateGui.handleClick(event)
  local element = event.element
  if not element or not element.valid then
    return false
  end

  local root = element
  while root and root.valid and root.name ~= ROOT_NAME do
    root = root.parent
  end

  if not root or not root.valid then
    return false
  end

  local player = game.get_player(event.player_index)

  if element.name == "cancel" then
    close(player)
    return true
  end

  if element.name == "save" then
    local template, errorMessage = readTemplate(root)

    if not template then
      root.error.caption = errorMessage
      return true
    end

    local globals = require("Classes.globals"):get()
    local templateIndex = root.tags.template_index

    if templateIndex then
      globals.squadTemplates[templateIndex] = template
    else
      table.insert(globals.squadTemplates, template)
    end

    close(player)
    return true
  end

  return true
end

return SquadTemplateGui