---@class Squad
---@field name string
---@field people number
---@field peopleMin number
---@field peopleMax number
---@field transports table<TransportType, number>
---@field transportsMin table<TransportType, number>
---@field transportsMax table<TransportType, number>
---@field weapons table<WeaponType, number>
---@field weaponsMin table<WeaponType, number>
---@field weaponsMax table<WeaponType, number>
---@field ammo table<WeaponType, number>
---@field ammoMin table<WeaponType, number>
---@field ammoMax table<WeaponType, number>
---@field resources table<ResourceType, number>
---@field prio SquadPrio
---@field surface LuaSurface

local TransportType = require("Enums/transportType")
local WeaponType = require("Enums/weaponType")
local ResourceType = require("Enums/resourceType")
local SquadPrio = require("Enums/squadPrio")

local Squad = {}
Squad.__index = Squad

function Squad:new()
  local obj = setmetatable({}, self)

  obj.name = ""
  obj.people = 0
  obj.peopleMin = 0
  obj.peopleMax = 0
  obj.transports = {}
  obj.transportsMin = {}
  obj.transportsMax = {}
  obj.weapons = {}
  obj.weaponsMin = {}
  obj.weaponsMax = {}
  obj.ammo = {}
  obj.ammoMin = {}
  obj.ammoMax = {}
  obj.resources = {}
  obj.prio = SquadPrio.PRESERVE_RESOURCES
  obj.surface = nil

  return obj
end

return Squad