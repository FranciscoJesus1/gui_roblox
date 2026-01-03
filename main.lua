--[[
    MAIN SCRIPT - ORCHESTRATOR
    Carga todos los módulos e inicia la lógica
]]

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- SIMULACION DE REQUIRE (Para uso local, normalmente usarías loadstring)
-- Ajusta las rutas según tu ejecutor si es necesario.

local function LoadModule(path)
    -- En un entorno real de exploit, usarías: loadstring(game:HttpGet("url/"..path))()
    -- O readfile("scriptsguardados/gui_roblox/"..path)
    -- Aquí asumimos que se llamará desde un loader que pasa las tablas o usa require
    return loadstring(readfile(path))()
end

-- CARGA DE MODULOS
-- Ajustamos las rutas asumiendo que el script corre desde la carpeta raíz de scripts
local Config = LoadModule("gui_roblox/config.lua")
local Components = LoadModule("gui_roblox/ui/components.lua")
local Glass = LoadModule("gui_roblox/ui/glass.lua")
local ESP = LoadModule("gui_roblox/features/esp.lua")
local Aimbot = LoadModule("gui_roblox/features/aimbot.lua")
local Misc = LoadModule("gui_roblox/features/misc.lua")

-- ESTADO
local Running = true

-- INICIO GUI
local Content, ScreenGui, CloseBtn = Glass:CreateWindow("Synapse Modular v1", Config.Visuals.Theme)

-- SECCION VISUALS
Components:CreateSection(Content, "Visuals")
Components:CreateToggle(Content, "Enable ESP", Config.ESP.Enabled, Config.Visuals.Theme, function(val)
    Config.ESP.Enabled = val
    ESP:Toggle(val)
end)

-- SECCION COMBAT
Components:CreateSection(Content, "Combat")
Components:CreateToggle(Content, "Enable Aimbot", Config.Aimbot.Enabled, Config.Visuals.Theme, function(val)
    Config.Aimbot.Enabled = val
    Aimbot:Toggle(val)
end)

Components:CreateButton(Content, "Toggle Team Check", Config.Visuals.Theme.Accent, Config.Visuals.Theme, function()
    Config.Aimbot.TeamCheck = not Config.Aimbot.TeamCheck
    Config.ESP.TeamCheck = not Config.ESP.TeamCheck
    print("Team Check:", Config.Aimbot.TeamCheck)
end)

-- SECCION SETTINGS
Components:CreateSection(Content, "System")
Components:CreateButton(Content, "SHUTDOWN APP", Config.Visuals.Theme.Danger, Config.Visuals.Theme, function()
    Running = false
    Misc:Shutdown(ScreenGui, ESP, Aimbot)
end)

-- LOGIC LOOPS
RunService.RenderStepped:Connect(function()
    if not Running then return end
    
    local s, e = pcall(function()
        ESP:Update(Config.ESP)
        Aimbot:Run(Config.Aimbot)
    end)
    
    if not s then warn("Main Loop Error:", e) end
end)

-- INPUTS GLOBALES
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.L then
        Running = false
        Misc:Shutdown(ScreenGui, ESP, Aimbot)
    end
end)

-- INIT DEFAULT
ESP:Toggle(Config.ESP.Enabled)
Aimbot:Toggle(Config.Aimbot.Enabled)

print("Modular Script Loaded Successfully.")
