---@class EventQueue

local EventQueue = {}
local localEventQueue = {}
local registrationsByName = {}
local namesByFunction = {}

local function getEventQueue()
  if storage then
    storage.frontier_colony = storage.frontier_colony or {}
    storage.frontier_colony.eventQueue = storage.frontier_colony.eventQueue or {}
    return storage.frontier_colony.eventQueue
  end

  return localEventQueue
end

function EventQueue:RegisterEvent(eventFunction, eventName, context)
  registrationsByName[eventName] = {
    eventFunction = eventFunction,
    context = context
  }
  namesByFunction[eventFunction] = eventName
end

function EventQueue:addEvent(tick, eventFunction, context, ...)
  local eventName = namesByFunction[eventFunction]
  assert(eventName, "Event function is not registered")

  local registration = registrationsByName[eventName]
  assert((registration.context == nil) ~= (context == nil), "Event context must be provided exactly once")

  local eventQueue = getEventQueue()
  local event = {tick = tick, eventName = eventName, args = {...}}
  -- Only save context if it is not a static class
  event.context = context

  for i = #eventQueue, 1, -1 do
    if tick < eventQueue[i].tick then
      table.insert(eventQueue, i, event)
      return
    end
  end
  table.insert(eventQueue, 1, event)
end

function EventQueue:runEvents(currentTick)  
  local eventQueue = getEventQueue()
  if #eventQueue == 0 then return end
  local event = eventQueue[#eventQueue];
  if currentTick >= event.tick then
    local registration = registrationsByName[event.eventName]
    assert(registration, "Event is not registered: " .. event.eventName)
    local context = registration.context
    if context == nil then
      context = event.context
    end
    local ret = registration.eventFunction(context, table.unpack(event.args))
    eventQueue[#eventQueue] = nil
    return ret
  end
end

return EventQueue