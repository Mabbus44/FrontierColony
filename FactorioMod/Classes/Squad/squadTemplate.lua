---@class SquadTemplate
---@field name string
---@field peopleMax number
---@field transportsMax table<TransportType, number>
---@field weaponsMax table<WeaponType, number>
---@field ammoMax table<WeaponType, number>
---@field prio SquadPrio

local TransportType = require("Enums/transportType")
local WeaponType = require("Enums/weaponType")
local ResourceType = require("Enums/resourceType")
local SquadPrio = require("Enums/squadPrio")

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

  return obj
end

return SquadTemplate