local EventQueueTest = {}
local EventQueue = require("Classes.eventQueue")

function EventQueueTest:testAddEvent()
  EventQueue:addEvent(10, function() return 1 end)
  EventQueue:addEvent(100, function() return 15 end)
  EventQueue:addEvent(200, function() return "a" end)
  for i = 0, 200 do
    local ret = EventQueue:runEvents(i)
    if i == 10 then
      assert(ret == 1)
    elseif i == 100 then
      assert(ret == 15)
    elseif i == 200 then
      assert(ret == "a")
    else
      assert(ret == nil)
    end
  end
  print("EventQueueTest:testAddEvent passed")
end

return EventQueueTest