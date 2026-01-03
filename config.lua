--[[
    CONFIGURACIÓN GLOBAL
    Aquí se definen todos los ajustes por defecto
]]

local Config = {
    Visuals = {
        Theme = {
            GlassColor = Color3.fromRGB(30, 30, 40),
            Transparency = 0.35,
            Accent = Color3.fromRGB(60, 150, 255),
            Text = Color3.new(1, 1, 1),
            Danger = Color3.fromRGB(200, 50, 50),
            ToggleOn = Color3.fromRGB(0, 200, 100),
            ToggleOff = Color3.fromRGB(180, 180, 180)
        }
    },
    
    ESP = {
        Enabled = true,
        Color = Color3.fromRGB(255, 50, 50),
        Transparency = 0.5,
        TeamCheck = true
    },
    
    Aimbot = {
        Enabled = true,
        Key = Enum.UserInputType.MouseButton2,
        Part = "Head",
        FOV = 150,
        Smoothness = 0.2, -- 0.1 (lento) - 1.0 (instantáneo)
        TeamCheck = true
    }
}

return Config
