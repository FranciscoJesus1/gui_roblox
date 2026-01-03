--[[
    AIMBOT MODULE
    Sistema de apuntado automático
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Aimbot = {}
Aimbot.Running = false

function Aimbot:SafeCheck(player, config)
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

function Aimbot:GetTarget(config)
    local best = nil
    local shortestDist = config.FOV / 2 
    local mousePos = UserInputService:GetMouseLocation()
    
    for _, p in ipairs(Players:GetPlayers()) do
        if self:SafeCheck(p, config) then
            local char = p.Character
            local part = char:FindFirstChild(config.Part) or char:FindFirstChild("Head")
            if part then
                local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        best = part
                    end
                end
            end
        end
    end
    return best
end

function Aimbot:Run(config)
    if not self.Running then return end
    if not UserInputService:IsMouseButtonPressed(config.Key) then return end
    
    local target = self:GetTarget(config)
    if target then
        local current = Camera.CFrame
        local goal = CFrame.new(current.Position, target.Position)
        Camera.CFrame = current:Lerp(goal, config.Smoothness)
    end
end

function Aimbot:Toggle(state)
    self.Running = state
end

return Aimbot
