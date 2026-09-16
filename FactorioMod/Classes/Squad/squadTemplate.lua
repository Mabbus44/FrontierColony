---@class SquadTemplate
---@field name string
---@field peopleMax number
---@field transportsMax table<TransportType, number>
---@field weaponsMax table<WeaponType, number>
---@field ammoMax table<WeaponType, number>
---@field prio SquadPrio
---@field id number

local TransportType = require("Enums.transportType")
local WeaponType = require("Enums.weaponType")
local SquadPrio = require("Enums.squadPrio")
local Globals = require("Classes.globals")

local SquadTemplate = {}
SquadTemplate.__index = SquadTemplate

function SquadTemplate:new()
  local obj = setmetatable({}, self)

  obj.name = ""
  obj.peopleMax = 0
  obj.transportsMax = {}
  obj.weaponsMax = {}
  obj.ammoMax = {}
  obj.prio = SquadPrio.PRESERVE_RESOURCES
  obj.id = Globals:get().nextFreeSquadTemplateId
  Globals:get().nextFreeSquadTemplateId = Globals:get().nextFreeSquadTemplateId + 1
  return obj
end

return SquadTemplate