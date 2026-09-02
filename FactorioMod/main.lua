
package.path = package.path
  .. ";Tests/?.lua"
  .. ";Tests/Utils/?.lua"
  .. ";Utils/?.lua"


local testModule = require("Tests.allTests")
testModule.runAllTests()