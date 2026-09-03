---@class Globals
---@field nextFreeSettlementId number

---This is a global static object, hence no "new" method and no metatable
local Globals = {
  nextFreeSettlementId = 1
}

return Globals