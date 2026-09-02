---@class EventQueue

local EventQueue = {}
local eventQueue = {}

function EventQueue:addEvent(tick, event, ...)
  for i = #eventQueue, 1, -1 do
    if tick < eventQueue[i].tick then
      table.insert(eventQueue, i, {tick = tick, event = event, args = {...}})
      return
    end
  end
  table.insert(eventQueue, 1, {tick = tick, event = event, args = {...}})
end

function EventQueue:runEvents(currentTick)  
  if #eventQueue == 0 then return end
  local event = eventQueue[#eventQueue];
  if currentTick >= event.tick then
     local ret = event.event(table.unpack(event.args))
    eventQueue[#eventQueue] = nil
    return ret
  end
end

return EventQueue