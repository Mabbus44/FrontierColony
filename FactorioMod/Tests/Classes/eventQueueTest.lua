local EventQueueTest = {}
local EventQueue = require("Classes.eventQueue")

function EventQueueTest:testAddEvent()
  local staticContext = {}
  local firstEvent = function(context) return context == staticContext and 1 end
  local secondEvent = function(context) return context == staticContext and 15 end
  local thirdEvent = function(context) return context == staticContext and "a" end
  local instanceEvent = function(instance, value) return instance.value + value end
  local instance = {value = 2}

  EventQueue:RegisterEvent(firstEvent, "Test:firstEvent", staticContext)
  EventQueue:RegisterEvent(secondEvent, "Test:secondEvent", staticContext)
  EventQueue:RegisterEvent(thirdEvent, "Test:thirdEvent", staticContext)
  EventQueue:RegisterEvent(instanceEvent, "Test:instanceEvent")

  EventQueue:addEvent(10, firstEvent, nil)
  EventQueue:addEvent(100, secondEvent, nil)
  EventQueue:addEvent(200, thirdEvent, nil)
  EventQueue:addEvent(300, instanceEvent, instance, 3)
  for i = 0, 400 do
    local ret = EventQueue:runEvents(i)
    if i == 10 then
      assert(ret == 1)
    elseif i == 100 then
      assert(ret == 15)
    elseif i == 200 then
      assert(ret == "a")
    elseif i == 300 then
      assert(ret == 5)
    else
      assert(ret == nil)
    end
  end
  print("EventQueueTest:testAddEvent passed")
end

return EventQueueTest