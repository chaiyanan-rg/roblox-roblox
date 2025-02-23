local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- สร้าง ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- สร้างปุ่มวงกลม (เมนูหลัก)
local mainButton = Instance.new("TextButton")
mainButton.Parent = screenGui
mainButton.Size = UDim2.new(0, 60, 0, 60)
mainButton.Position = UDim2.new(0.05, 0, 0.5, -30)
mainButton.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
mainButton.Text = "⚡"
mainButton.TextSize = 24
mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainButton.BorderSizePixel = 0
mainButton.Font = Enum.Font.GothamBold
mainButton.BackgroundTransparency = 0.2
mainButton.ClipsDescendants = true
mainButton.AutoButtonColor = true
mainButton.Visible = true
mainButton.ZIndex = 10

-- ปรับให้เป็นวงกลม
local corner = Instance.new("UICorner")
corner.Parent = mainButton
corner.CornerRadius = UDim.new(1, 0)

-- สร้างเมนูที่ 2
local menuFrame = Instance.new("Frame")
menuFrame.Parent = screenGui
menuFrame.Size = UDim2.new(0, 250, 0, 300)
menuFrame.Position = UDim2.new(0.2, 0, 0.3, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
menuFrame.BorderSizePixel = 2
menuFrame.BorderColor3 = Color3.fromRGB(100, 0, 150)
menuFrame.Visible = false
menuFrame.Active = true
menuFrame.Draggable = true

local menuCorner = Instance.new("UICorner")
menuCorner.Parent = menuFrame
menuCorner.CornerRadius = UDim.new(0.1, 0)

local dropDown = Instance.new("TextButton")
dropDown.Parent = menuFrame
dropDown.Size = UDim2.new(0.8, 0, 0, 30)
dropDown.Position = UDim2.new(0.1, 0, 0.05, 0)
dropDown.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
dropDown.Text = "เลือกผู้เล่น"
dropDown.TextColor3 = Color3.fromRGB(255, 255, 255)

local dropCorner = Instance.new("UICorner")
dropCorner.Parent = dropDown
dropCorner.CornerRadius = UDim.new(0.2, 0)

local playerList = Instance.new("ScrollingFrame")
playerList.Parent = menuFrame
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

local function createActionButton(icon, text, pos, action)
    local button = Instance.new("TextButton")
    button.Parent = menuFrame
    button.Size = UDim2.new(0.8, 0, 0, 30)
    button.Position = UDim2.new(0.1, 0, pos, 0)
    button.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
    button.Text = icon .. " " .. text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)

    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = button
    btnCorner.CornerRadius = UDim.new(0.2, 0)

    button.MouseButton1Click:Connect(function()
        if selectedPlayer then
            action(selectedPlayer)
        end
    end)
end

createActionButton("💀", "ฆ่าผู้เล่น", 0.4, function(target)
    if target.Character then
        target.Character:BreakJoints()
    end
end)

createActionButton("🚀", "ไปหาผู้เล่น", 0.55, function(target)
    if player.Character and target.Character then
        player.Character:MoveTo(target.Character:GetPrimaryPartCFrame().Position)
    end
end)

createActionButton("🌀", "ดึงผู้เล่นมา", 0.7, function(target)
    if target.Character and player.Character then
        target.Character:SetPrimaryPartCFrame(player.Character:GetPrimaryPartCFrame())
    end
end)

-- ปุ่มเปิด/ปิดเมนู
local isMenuOpen = false
mainButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    menuFrame.Visible = isMenuOpen
end)

