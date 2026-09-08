package.path = package.path
  .. ";Assets/?.lua"
  .. ";Classes/?.lua"
  .. ";Classes/Settlement?.lua"
  .. ";Classes/World?.lua"
  .. ";Enums/?.lua"
  .. ";Tests/?.lua"
  .. ";Tests/Classes/?.lua"

local testModule = require("Tests.allTests")
testModule.runAllTests()