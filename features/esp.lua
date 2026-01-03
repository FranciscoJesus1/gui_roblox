--[[
    ESP MODULE
    Controla el visualizador de enemigos (Wallhack)
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ESP = {}
ESP.Adornments = {}
ESP.Running = false

function ESP:SafeCheck(player, config)
    if not player or not player.Parent then return false end
    if player == LocalPlayer then return false end
    if not player.Character then return false end
    
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    local hum = player.Character:FindFirstChild("Humanoid")
    if not hrp or not hum then return false end
    if hum.Health <= 0 then return false end
    
    if config.TeamCheck and LocalPlayer.Team and player.Team then
        if player.Team == LocalPlayer.Team then return false end
    end
    
    return true
end

function ESP:Update(config)
    -- Limpieza
    for userId, box in pairs(self.Adornments) do
        local ply = Players:GetPlayerByUserId(userId)
        if not ply or not self.Running or not self:SafeCheck(ply, config) then
            box:Destroy()
            self.Adornments[userId] = nil
        end
    end

    if not self.Running then return end

    -- Creacion
    for _, p in ipairs(Players:GetPlayers()) do
        if self:SafeCheck(p, config) then
            local char = p.Character
            if not self.Adornments[p.UserId] then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "SynChams"
                box.Adornee = char.HumanoidRootPart
                box.Size = char.HumanoidRootPart.Size + Vector3.new(2, 4.5, 2)
                box.Transparency = config.Transparency
                box.Color3 = config.Color
                box.AlwaysOnTop = true
                box.ZIndex = 5
                box.Parent = char.HumanoidRootPart
                self.Adornments[p.UserId] = box
            else
                local box = self.Adornments[p.UserId]
                if box.Parent ~= char.HumanoidRootPart then
                    box.Parent = char.HumanoidRootPart
                    box.Adornee = char.HumanoidRootPart
                end
                -- Update visual props dynamically
                box.Transparency = config.Transparency
                box.Color3 = config.Color
            end
        end
    end
end

function ESP:Cleanup()
    for _, box in pairs(self.Adornments) do box:Destroy() end
    self.Adornments = {}
    self.Running = false
end

function ESP:Toggle(state)
    self.Running = state
    if not state then self:Cleanup() end
end

return ESP
