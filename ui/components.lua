--[[
    COMPONENTES UI
    Botones, Toggles, Sliders
]]

local TweenService = game:GetService("TweenService")
local Components = {}

function Components:CreateTw(instance, props, info)
    local tween = TweenService:Create(instance, info or TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props)
    tween:Play()
    return tween
end

function Components:CreateSection(parent, text, theme)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.Text = "  " .. text:upper()
    Label.Font = Enum.Font.GothamBlack
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(150, 150, 150)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = parent
    return Label
end

function Components:CreateButton(parent, text, color, theme, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 40)
    Btn.BackgroundColor3 = color or theme.Accent
    Btn.Text = text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Parent = parent
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

function Components:CreateToggle(parent, text, default, theme, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.9, 0, 0, 45)
    Container.BackgroundColor3 = Color3.new(0,0,0)
    Container.BackgroundTransparency = 0.8
    Container.Parent = parent
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Text = text
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 14
    Label.TextColor3 = theme.Text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Container

    -- Switch
    local Switch = Instance.new("TextButton")
    Switch.Text = ""
    Switch.Size = UDim2.new(0, 44, 0, 24)
    Switch.Position = UDim2.new(1, -55, 0.5, -12)
    Switch.BackgroundColor3 = default and theme.ToggleOn or theme.ToggleOff
    Switch.Parent = Container
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = default and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    Knob.BackgroundColor3 = Color3.new(1,1,1)
    Knob.Parent = Switch
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local Enabled = default

    Switch.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        
        -- Animaciones
        if Enabled then
            Components:CreateTw(Switch, {BackgroundColor3 = theme.ToggleOn})
            Components:CreateTw(Knob, {Position = UDim2.new(1, -21, 0.5, -9)})
        else
            Components:CreateTw(Switch, {BackgroundColor3 = theme.ToggleOff})
            Components:CreateTw(Knob, {Position = UDim2.new(0, 3, 0.5, -9)})
        end
        
        callback(Enabled)
    end)
    return Container
end

return Components
