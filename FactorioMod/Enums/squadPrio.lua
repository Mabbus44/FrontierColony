---@enum SquadPrio

local SquadPrio = {
  MAXIMIZE_RESOURCES = "MAXIMIZE_RESOURCES",      -- Maximize resouces. Vehicles will be packed with resources. People will walk and carry stuff. People will only ride the vehicles if they happend to fit.
  PRESERVE_RESOURCES = "PRESERVE_RESOURCES",      -- Dont throw away resources. Leave place for all people when vehicles are filled (unless people wont fit annyawy). If you lose vehicles on the road, let people walk and carry the resources (if they dont fit in remaning vehicles).
  SPEED_OVER_RESOURCES = "SPEED_OVER_RESOURCES",  -- Throw away resources if necessary. Leave place for all people when vehicles are filled (unless people wont fit annyway). If you lose vehicles on the road, throw away resources and does not fit.
  SPEED_OVER_PEOPLE = "SPEED_OVER_PEOPLE"         -- Leave people behind if necessary. Leave place for all people when vehicles are filled (uness people wont fit annyway). If you lose vehicles on the road, leave people behind if necessary.
}

return SquadPrio
