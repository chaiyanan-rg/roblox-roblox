local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI หลัก
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.Size = UDim2.new(0, 250, 0, 300)
mainFrame.Position = UDim2.new(0.2, 0, 0.3, 0)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(100, 0, 150)
mainFrame.Active = true
mainFrame.Draggable = true

local toggleButton = Instance.new("TextButton")
toggleButton.Parent = mainFrame
toggleButton.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
toggleButton.Size = UDim2.new(1, 0, 0, 30)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "🔽 Menu"
toggleButton.TextSize = 18

local contentFrame = Instance.new("Frame")
contentFrame.Parent = mainFrame
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundTransparency = 1

local dropDown = Instance.new("TextButton")
dropDown.Parent = contentFrame
dropDown.Size = UDim2.new(0.8, 0, 0, 30)
dropDown.Position = UDim2.new(0.1, 0, 0.05, 0)
dropDown.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
dropDown.Text = "เลือกผู้เล่น"
dropDown.TextColor3 = Color3.fromRGB(255, 255, 255)

local playerList = Instance.new("ScrollingFrame")
playerList.Parent = contentFrame
playerList.Size = UDim2.new(0.8, 0, 0, 100)
playerList.Position = UDim2.new(0.1, 0, 0.2, 0)
playerList.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
playerList.Visible = false
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)

local selectedPlayer = nil

dropDown.MouseButton1Click:Connect(function()
    playerList.Visible = not playerList.Visible
    playerList:ClearAllChildren()
    
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player then
            local button = Instance.new("TextButton")
            button.Parent = playerList
            button.Size = UDim2.new(1, 0, 0, 25)
            button.Text = plr.Name
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)

            button.MouseButton1Click:Connect(function()
                selectedPlayer = plr
                dropDown.Text = "เลือก: " .. plr.Name
                playerList.Visible = false
            end)
        end
    end
end)

local function createActionButton(text, pos, action)
    local button = Instance.new("TextButton")
    button.Parent = contentFrame
    button.Size = UDim2.new(0.8, 0, 0, 30)
    button.Position = UDim2.new(0.1, 0, pos, 0)
    button.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    button.MouseButton1Click:Connect(function()
        if selectedPlayer then
            action(selectedPlayer)
        end
    end)
end

createActionButton("💀 ฆ่าผู้เล่น", 0.4, function(target)
    if target.Character then
        target.Character:BreakJoints()
    end
end)

createActionButton("🚀 ไปหาผู้เล่น", 0.55, function(target)
    if player.Character and target.Character then
        player.Character:MoveTo(target.Character:GetPrimaryPartCFrame().Position)
    end
end)

createActionButton("🌀 ดึงผู้เล่นมา", 0.7, function(target)
    if target.Character and player.Character then
        target.Character:SetPrimaryPartCFrame(player.Character:GetPrimaryPartCFrame())
    end
end)

local isMenuOpen = true
toggleButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    contentFrame.Visible = isMenuOpen
    toggleButton.Text = isMenuOpen and "🔽 Menu" or "🔼 Menu"
end)
