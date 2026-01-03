
local function LoadMain()
    local path = "gui_roblox/main.lua"
    if isfile(path) then
        loadstring(readfile(path))()
    else
        warn("No se encontró: " .. path)
        print("Asegúrate de que la carpeta gui_roblox está en la ubicación correcta.")
    end
end

LoadMain()
