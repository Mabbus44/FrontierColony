---@class Template
---@field prop1 number
---@field prop2 number

local Template = {}
Template.__index = Template

function Template:new()
    local obj = setmetatable({}, self)
    
    obj.prop1 = 0
    obj.prop2 = 0
    
    return obj
end

return Template