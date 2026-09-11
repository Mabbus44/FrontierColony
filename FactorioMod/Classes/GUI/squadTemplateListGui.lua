local Globals = require("Classes.globals")
local SquadTemplateGui = require("Classes.GUI.squadTemplateGui")

local SquadTemplateListGui = {}

local ROOT_NAME = "frontier_colony_squad_template_list_gui"

local function close(player)
  local gui = player.gui.screen[ROOT_NAME]
  if gui and gui.valid then
    gui.destroy()
  end
end

function SquadTemplateListGui.open(player)
  close(player)

  local root = player.gui.screen.add {
    type = "frame",
    name = ROOT_NAME,
    direction = "vertical",
    caption = "Squad templates"
  }

  root.auto_center = true

  local templates = Globals:get().squadTemplates

  local list = root.add {
    type = "scroll-pane",
    name = "list",
    direction = "vertical"
  }

  if #templates == 0 then
    list.add {
        type = "label",
        caption = "No squad templates."
    }
  end

  for index, template in ipairs(templates) do
    local row = list.add {
        type = "flow",
        direction = "horizontal"
    }

    row.add {
        type = "label",
        caption = template.name
    }

    local editButton = row.add {
        type = "button",
        name = "edit",
        caption = "Edit"
    }

    editButton.tags = {
        template_index = index
    }

    local deleteButton = row.add {
        type = "button",
        name = "delete",
        caption = "Delete"
    }

    deleteButton.tags = {
        template_index = index
    }
  end

  local buttons = root.add {
    type = "flow",
    direction = "horizontal"
  }

  buttons.add {
    type = "button",
    name = "new",
    caption = "New"
  }

  buttons.add {
    type = "button",
    name = "close",
    caption = "Close"
  }
end

function SquadTemplateListGui.handleClick(event)
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

  if element.name == "close" then
    close(player)
    return true
  end

  if element.name == "new" then
    SquadTemplateGui.open(player)
    return true
  end

  local templateIndex = element.tags.template_index
  if not templateIndex then
    return true
  end

  if element.name == "edit" then
    SquadTemplateGui.open(player, templateIndex)
    return true
  end

  if element.name == "delete" then
    table.remove(Globals:get().squadTemplates, templateIndex)
    SquadTemplateListGui.open(player)
    return true
  end

  return true
end

return SquadTemplateListGui