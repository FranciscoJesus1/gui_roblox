--[[
    MISC MODULE
    Utilidades generales
]]

local Misc = {}

function Misc:Shutdown(gui, esp, aimbot)
    if gui then gui:Destroy() end
    if esp then esp:Cleanup() end
    if aimbot then aimbot:Toggle(false) end
    print("Script Shutdown Complete.")
end

return Misc
