---@class SquadTemplateGui

local SquadTemplate = require("Classes.Squad.squadTemplate")
local TransportType = require("Enums.transportType")
local WeaponType = require("Enums.weaponType")
local SquadPrio = require("Enums.squadPrio")
local GuiMaker = require("Classes.GUI.guiMaker")
local Globals = require("Classes.globals")

local SquadTemplateGui = {}
local guiDefinition = {
  type = "frame", name = "squadTemplateGui", direction = "vertical", caption = "Edit squad template", auto_center = true,
  {
    type = "scroll-pane", name = "content", direction = "vertical",
    {
      type = "flow", name = "peopleRow", direction = "horizontal",
      { type = "label", caption = "Maximum people" },
      { type = "textfieldInt", name = "maxPeople"}
    },
    {
      type = "flow", name = "nameRow", direction = "horizontal",
      { type = "label", caption = "Name" },
      { type = "textfield", name = "templateName", text = "new template" }
    },
    { type = "label", caption = "Maximum transports" },
    {
      type = "flow", name = "maxBackpacksRow", direction = "horizontal",
      { type = "label", caption = "Backpacks"},
      { type = "textfieldInt", name = "maxBackpacks"}
    },
    {
      type = "flow", name = "maxHorsesRow", direction = "horizontal",
      { type = "label", caption = "Horses"},
      { type = "textfieldInt", name = "maxHorses"}
    },
    {
      type = "flow", name = "maxCarsRow", direction = "horizontal",
      { type = "label", caption = "Cars"},
      { type = "textfieldInt", name = "maxCars"}
    },
    {
      type = "flow", name = "maxTrucksRow", direction = "horizontal",
      { type = "label", caption = "Trucks"},
      { type = "textfieldInt", name = "maxTrucks"}
    },
    {
      type = "flow", name = "maxRoadTrainsRow", direction = "horizontal",
      { type = "label", caption = "Road Trains"},
      { type = "textfieldInt", name = "maxRoadTrains"}
    },
    { type = "label", caption = "Maximum weapons" },
    {
      type = "flow", name = "maxAxesRow", direction = "horizontal",
      { type = "label", caption = "Axes"},
      { type = "textfieldInt", name = "maxAxes"}
    },
    {
      type = "flow", name = "maxPistolsRow", direction = "horizontal",
      { type = "label", caption = "Pistols"},
      { type = "textfieldInt", name = "maxPistols"}
    },
    {
      type = "flow", name = "maxMachineGunsRow", direction = "horizontal",
      { type = "label", caption = "Machine Guns"},
      { type = "textfieldInt", name = "maxMachineGuns"}
    },
    {
      type = "flow", name = "maxFlameThrowersRow", direction = "horizontal",
      { type = "label", caption = "Flame Throwers"},
      { type = "textfieldInt", name = "maxFlameThrowers"}
    },
    {
      type = "flow", name = "maxPoisonThrowersRow", direction = "horizontal",
      { type = "label", caption = "Poison Throwers"},
      { type = "textfieldInt", name = "maxPoisonThrowers"}
    },
    {
      type = "flow", name = "maxLaserRiflesRow", direction = "horizontal",
      { type = "label", caption = "Laser Rifles"},
      { type = "textfieldInt", name = "maxLaserRifles"}
    },
    {
      type = "flow", name = "maxFreezeRaysRow", direction = "horizontal",
      { type = "label", caption = "Freeze Rays"},
      { type = "textfieldInt", name = "maxFreezeRays"}
    },
    {
      type = "flow", name = "maxRocketLaunchersRow", direction = "horizontal",
      { type = "label", caption = "Rocket Launchers"},
      { type = "textfieldInt", name = "maxRocketLaunchers"}
    },
    { type = "label", caption = "Maximum ammo" },
    {
      type = "flow", name = "maxPistolAmmoRow", direction = "horizontal",
      { type = "label", caption = "Pistol Ammo"},
      { type = "textfieldInt", name = "maxPistolAmmo"}
    },
    {
      type = "flow", name = "maxMachineGunAmmoRow", direction = "horizontal",
      { type = "label", caption = "Machine Gun Ammo"},
      { type = "textfieldInt", name = "maxMachineGunAmmo"}
    },
    {
      type = "flow", name = "maxFlameThrowerAmmoRow", direction = "horizontal",
      { type = "label", caption = "Flame Thrower Ammo"},
      { type = "textfieldInt", name = "maxFlameThrowerAmmo"}
    },
    {
      type = "flow", name = "maxPoisonThrowerAmmoRow", direction = "horizontal",
      { type = "label", caption = "Poison Thrower Ammo"},
      { type = "textfieldInt", name = "maxPoisonThrowerAmmo"}
    },
    {
      type = "flow", name = "maxLaserRifleAmmoRow", direction = "horizontal",
      { type = "label", caption = "Laser Rifle Ammo"},
      { type = "textfieldInt", name = "maxLaserRifleAmmo"}
    },
    {
      type = "flow", name = "maxFreezeRayAmmoRow", direction = "horizontal",
      { type = "label", caption = "Freeze Ray Ammo"},
      { type = "textfieldInt", name = "maxFreezeRayAmmo"}
    },
    {
      type = "flow", name = "maxRocketLauncherAmmoRow", direction = "horizontal",
      { type = "label", caption = "Rocket Launcher Ammo"},
      { type = "textfieldInt", name = "maxRocketLauncherAmmo"}
    },
    { type = "label", caption = "Priority" },
    { type = "drop-down", name = "priority", items = SquadPrio.ordered, selected_index = 1 }
  },
  {
    type = "flow", name = "buttonRow", direction = "horizontal",
    { type = "button", name = "save", caption = "Save" },
    { type = "button", name = "cancel", caption = "Cancel" }
  }
}

local function close(player)
  local gui = player.gui.screen[guiDefinition.name]
  if gui and gui.valid then
    gui.destroy()
  end
end

local function saveTemplate(guiRoot)
  if not guiRoot or not guiRoot.valid then
    log("Error: Tried to save template with invalid GUI root.")
    return false
  end
  local templates = Globals:get().squadTemplates
  local templateId = guiRoot.tags and guiRoot.tags.templateIndex
  local template = nil
  if templateId and templates[templateId] then
    template = templates[templateId]
  else
    template = SquadTemplate:new()
    table.insert(templates, template)
  end
  template.peopleMax = tonumber(guiRoot.content.peopleRow.maxPeople.text)
  template.name = guiRoot.content.nameRow.templateName.text
  template.transportsMax[TransportType.BACKPACK] = tonumber(guiRoot.content.maxBackpacksRow.maxBackpacks.text)
  template.transportsMax[TransportType.HORSE] = tonumber(guiRoot.content.maxHorsesRow.maxHorses.text)
  template.transportsMax[TransportType.CAR] = tonumber(guiRoot.content.maxCarsRow.maxCars.text)
  template.transportsMax[TransportType.TRUCK] = tonumber(guiRoot.content.maxTrucksRow.maxTrucks.text)
  template.transportsMax[TransportType.ROAD_TRAIN] = tonumber(guiRoot.content.maxRoadTrainsRow.maxRoadTrains.text)
  template.weaponsMax[WeaponType.AXE] = tonumber(guiRoot.content.maxAxesRow.maxAxes.text)
  template.weaponsMax[WeaponType.PISTOL] = tonumber(guiRoot.content.maxPistolsRow.maxPistols.text)
  template.weaponsMax[WeaponType.MACHINE_GUN] = tonumber(guiRoot.content.maxMachineGunsRow.maxMachineGuns.text)
  template.weaponsMax[WeaponType.FLAME_THROWER] = tonumber(guiRoot.content.maxFlameThrowersRow.maxFlameThrowers.text)
  template.weaponsMax[WeaponType.POISON_THROWER] = tonumber(guiRoot.content.maxPoisonThrowersRow.maxPoisonThrowers.text)
  template.weaponsMax[WeaponType.LASER_RIFLE] = tonumber(guiRoot.content.maxLaserRiflesRow.maxLaserRifles.text)
  template.weaponsMax[WeaponType.FREEZE_RAY] = tonumber(guiRoot.content.maxFreezeRaysRow.maxFreezeRays.text)
  template.weaponsMax[WeaponType.ROCKET_LAUNCHER] = tonumber(guiRoot.content.maxRocketLaunchersRow.maxRocketLaunchers.text)
  template.ammoMax[WeaponType.PISTOL] = tonumber(guiRoot.content.maxPistolAmmoRow.maxPistolAmmo.text)
  template.ammoMax[WeaponType.MACHINE_GUN] = tonumber(guiRoot.content.maxMachineGunAmmoRow.maxMachineGunAmmo.text)
  template.ammoMax[WeaponType.FLAME_THROWER] = tonumber(guiRoot.content.maxFlameThrowerAmmoRow.maxFlameThrowerAmmo.text)
  template.ammoMax[WeaponType.POISON_THROWER] = tonumber(guiRoot.content.maxPoisonThrowerAmmoRow.maxPoisonThrowerAmmo.text)
  template.ammoMax[WeaponType.LASER_RIFLE] = tonumber(guiRoot.content.maxLaserRifleAmmoRow.maxLaserRifleAmmo.text)
  template.ammoMax[WeaponType.FREEZE_RAY] = tonumber(guiRoot.content.maxFreezeRayAmmoRow.maxFreezeRayAmmo.text) 
  template.ammoMax[WeaponType.ROCKET_LAUNCHER] = tonumber(guiRoot.content.maxRocketLauncherAmmoRow.maxRocketLauncherAmmo.text)
  template.prio = SquadPrio.ordered[guiRoot.content.priority.selected_index]
  return true
end

function SquadTemplateGui.open(player, templateIndex)
  close(player)
  local guiRoot = GuiMaker.getGui(player.gui.screen, guiDefinition)
  local templates = Globals:get().squadTemplates
  local template
  if templateIndex and templates[templateIndex] then
    template = templates[templateIndex]
    guiRoot.tags = { templateIndex = templateIndex }
  else
    template = SquadTemplate:new()
  end
  guiRoot.content.peopleRow.maxPeople.text = template.peopleMax or 0
  guiRoot.content.nameRow.templateName.text = template.name or "New squad template"
  guiRoot.content.maxBackpacksRow.maxBackpacks.text = template.transportsMax[TransportType.BACKPACK] or 0
  guiRoot.content.maxHorsesRow.maxHorses.text = template.transportsMax[TransportType.HORSE] or 0
  guiRoot.content.maxCarsRow.maxCars.text = template.transportsMax[TransportType.CAR] or 0
  guiRoot.content.maxTrucksRow.maxTrucks.text = template.transportsMax[TransportType.TRUCK] or 0
  guiRoot.content.maxRoadTrainsRow.maxRoadTrains.text = template.transportsMax[TransportType.ROAD_TRAIN] or 0
  guiRoot.content.maxAxesRow.maxAxes.text = template.weaponsMax[WeaponType.AXE] or 0
  guiRoot.content.maxPistolsRow.maxPistols.text = template.weaponsMax[WeaponType.PISTOL] or 0
  guiRoot.content.maxMachineGunsRow.maxMachineGuns.text = template.weaponsMax[WeaponType.MACHINE_GUN] or 0
  guiRoot.content.maxFlameThrowersRow.maxFlameThrowers.text = template.weaponsMax[WeaponType.FLAME_THROWER] or 0
  guiRoot.content.maxPoisonThrowersRow.maxPoisonThrowers.text = template.weaponsMax[WeaponType.POISON_THROWER] or 0
  guiRoot.content.maxLaserRiflesRow.maxLaserRifles.text = template.weaponsMax[WeaponType.LASER_RIFLE] or 0
  guiRoot.content.maxFreezeRaysRow.maxFreezeRays.text = template.weaponsMax[WeaponType.FREEZE_RAY] or 0
  guiRoot.content.maxRocketLaunchersRow.maxRocketLaunchers.text = template.weaponsMax[WeaponType.ROCKET_LAUNCHER] or 0
  guiRoot.content.maxPistolAmmoRow.maxPistolAmmo.text = template.ammoMax[WeaponType.PISTOL] or 0
  guiRoot.content.maxMachineGunAmmoRow.maxMachineGunAmmo.text = template.ammoMax[WeaponType.MACHINE_GUN] or 0
  guiRoot.content.maxFlameThrowerAmmoRow.maxFlameThrowerAmmo.text = template.ammoMax[WeaponType.FLAME_THROWER] or 0
  guiRoot.content.maxPoisonThrowerAmmoRow.maxPoisonThrowerAmmo.text = template.ammoMax[WeaponType.POISON_THROWER] or 0
  guiRoot.content.maxLaserRifleAmmoRow.maxLaserRifleAmmo.text = template.ammoMax[WeaponType.LASER_RIFLE] or 0
  guiRoot.content.maxFreezeRayAmmoRow.maxFreezeRayAmmo.text = template.ammoMax[WeaponType.FREEZE_RAY] or 0
  guiRoot.content.maxRocketLauncherAmmoRow.maxRocketLauncherAmmo.text = template.ammoMax[WeaponType.ROCKET_LAUNCHER] or 0
  guiRoot.content.priority.selected_index = Globals:getIndex(template.prio or SquadPrio.ordered[1], SquadPrio.ordered)
end

function SquadTemplateGui.handleClick(event)
  local root = event.element
  while root and root.valid and root.name ~= guiDefinition.name do
    root = root.parent
  end
  if not root or not root.valid or root.name ~= guiDefinition.name then
    return false
  end
  local player = game.get_player(event.player_index)
  local element = event.element
  if element.name == "cancel" then
    close(player)
    return true
  end
  if element.name == "save" then
    saveTemplate(root)
    close(player)
    return true
  end
  return true
end

return SquadTemplateGui