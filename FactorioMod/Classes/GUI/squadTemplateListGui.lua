local Globals = require("Classes.globals")
local SquadTemplateGui = require("Classes.GUI.squadTemplateGui")
local GuiMaker = require("Classes.GUI.guiMaker")
local Globals = require("Classes.globals")

local SquadTemplateListGui = {}
local guiDefinition = {
  type = "frame", name = "squadTemplateListGui", direction = "vertical", caption = "Squad templates", auto_center = true,
  { type = "scroll-pane", name = "list", direction = "vertical" },
  {
    type = "flow", name = "buttons", direction = "horizontal",
    { type = "button", name = "new", caption = "New" },
    { type = "button", name = "close", caption = "Close" }
  }
}

local function close(player)
  local gui = player.gui.screen[guiDefinition.name]
  if gui and gui.valid then
    gui.destroy()
  end
end

function SquadTemplateListGui.open(player)
  close(player)
  local templates = Globals:get().squadTemplates
  local list = guiDefinition[1]
  if #templates == 0 then
    table.insert(list, { type = "label", caption = "No squad templates." })
  end
  for index, template in ipairs(templates) do
    local row = { type = "flow", direction = "horizontal" }
    table.insert(list, row)
    table.insert(row, { type = "label", caption = template.name })
    table.insert(row, { type = "button", name = "edit", caption = "Edit", tags = { template_index = index } })
    table.insert(row, { type = "button", name = "delete", caption = "Delete", tags = { template_index = index } })
  end
  local guiRoot = GuiMaker.getGui(player.gui.screen, guiDefinition)
end

function SquadTemplateListGui.handleClick(event)
  local element = event.element
  local root = GuiMaker.getRootGui(element, guiDefinition.name)
  if not root then
    return false
  end
  local player = game.get_player(event.player_index)
  if element.name == "close" then
    close(player)
    return true
  end
  if element.name == "new" then
    close(player)
    SquadTemplateGui.open(player)
    return true
  end
  local templateIndex = element.tags and element.tags.template_index
  if not templateIndex then
    return true
  end
  if element.name == "edit" then
    close(player)
    SquadTemplateGui.open(player, templateIndex)
    return true
  end
  if element.name == "delete" then
    Globals.deleteById(Globals:get().squadTemplates, templateIndex)
    SquadTemplateListGui.open(player)
    return true
  end
  return true
end

return SquadTemplateListGui