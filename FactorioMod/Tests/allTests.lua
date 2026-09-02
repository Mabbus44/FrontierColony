local AllTests = {}
local EventQueueTest = require("Tests.Utils.eventQueueTest")
AllTests.runAllTests = function()
  EventQueueTest:testAddEvent()
end
return AllTests;