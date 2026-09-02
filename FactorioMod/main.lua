package.path = package.path
  .. ";Assets/?.lua"
  .. ";Enums/?.lua"
  .. ";GameObjects/?.lua"
  .. ";GameObjects/LocalArea?.lua"
  .. ";GameObjects/World?.lua"
  .. ";Tests/?.lua"
  .. ";Tests/Utils/?.lua"
  .. ";Utils/?.lua"


local testModule = require("Tests.allTests")
testModule.runAllTests()