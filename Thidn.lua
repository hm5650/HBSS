local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.__namecall
local oldIndex = mt.__index

mt.__namecall = newcclosure(function(self, ...)
    if tostring(getnamecallmethod()):lower() == "kick" then
        return task.wait(math.huge)
    end
    return oldNamecall(self, ...)
end)

mt.__index = newcclosure(function(self, key)
    if tostring(key):lower() == "kick" then
        return function()
            return task.wait(math.huge)
        end
    end
    return oldIndex(self, key)
end)

local oldLoadstring = loadstring or load

hookfunction(oldLoadstring, newcclosure(function(code, ...)
    local patched = code:gsub("while%s-(.-)%s-do%s*\n", function(cond)
        return string.format("while %s do\n\ttask.wait()\n", cond)
    end)
    return oldLoadstring(patched, ...)
end))
