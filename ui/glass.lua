--[[
    GLASS GUI BUILDER
    Crea la ventana principal
]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Glass = {}

function Glass:CreateWindow(title, theme)
    -- Limpieza previa
    if CoreGui:FindFirstChild("Glass_Hack_GUI") then
        CoreGui.Glass_Hack_GUI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Glass_Hack_GUI"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    
    -- Intento de protección
    if pcall(function() ScreenGui.Parent = CoreGui end) then
    else
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end

    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 360, 0, 450)
    Main.Position = UDim2.new(0.5, -180, 0.4, -225)
    Main.BackgroundColor3 = theme.GlassColor
    Main.BackgroundTransparency = theme.Transparency
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Main.Parent = ScreenGui

    -- Efectos Visuales
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = theme.Accent
    Stroke.Transparency = 0.6
    Stroke.Thickness = 1.5
    Stroke.Parent = Main

    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1
    Header.Parent = Main
    
    local Title = Instance.new("TextLabel")
    Title.Text = title
    Title.Size = UDim2.new(1, -50, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextColor3 = theme.Text
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Header
    
    -- Boton Cerrar
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Text = "×"
    CloseBtn.Size = UDim2.new(0, 40, 0, 40)
    CloseBtn.Position = UDim2.new(1, -40, 0, 0)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseBtn.TextSize = 24
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = Header
    
    -- Scroll Content
    local Content = Instance.new("ScrollingFrame")
    Content.Position = UDim2.new(0, 0, 0, 42)
    Content.Size = UDim2.new(1, 0, 1, -42)
    Content.BackgroundTransparency = 1
    Content.ScrollBarThickness = 4
    Content.BorderSizePixel = 0
    Content.Parent = Main
    
    local UIList = Instance.new("UIListLayout", Content)
    UIList.Padding = UDim.new(0, 8)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIList.SortOrder = Enum.SortOrder.LayoutOrder
    
    Instance.new("UIPadding", Content).PaddingTop = UDim.new(0, 10)

    -- Toggle Key Logic
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gp)
        if input.KeyCode == Enum.KeyCode.RightControl then
            ScreenGui.Enabled = not ScreenGui.Enabled
        end
    end)

    return Content, ScreenGui, CloseBtn
end

return Glass
