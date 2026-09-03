local AllTests = {}
local EventQueueTest = require("Tests.Classes.eventQueueTest")
AllTests.runAllTests = function()
  EventQueueTest:testAddEvent()
end
return AllTests;