local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI หลัก
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ปุ่มเมนูหลัก ⚡
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

-- วงกลม
local corner = Instance.new("UICorner")
corner.Parent = mainButton
corner.CornerRadius = UDim.new(1, 0)

-- เมนูหลัก
local menuFrame = Instance.new("Frame")
menuFrame.Parent = screenGui
menuFrame.Size = UDim2.new(0, 300, 0, 450) -- ปรับให้สูงขึ้น
menuFrame.Position = UDim2.new(0.2, 0, 0.25, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
menuFrame.BackgroundTransparency = 0.3 -- ทำให้โปร่งใส
menuFrame.BorderSizePixel = 2
menuFrame.BorderColor3 = Color3.fromRGB(100, 0, 150)
menuFrame.Visible = false
menuFrame.Active = true
menuFrame.Draggable = true

local menuCorner = Instance.new("UICorner")
menuCorner.Parent = menuFrame
menuCorner.CornerRadius = UDim.new(0.1, 0)

-- Layout สำหรับจัดปุ่มให้สวย
local listLayout = Instance.new("UIListLayout")
listLayout.Parent = menuFrame
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 10)

-- ช่องค้นหาผู้เล่น
local searchBox = Instance.new("TextBox")
searchBox.Parent = menuFrame
searchBox.Size = UDim2.new(0.8, 0, 0, 30)
searchBox.Position = UDim2.new(0.1, 0, 0.05, 0)
searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
searchBox.Text = "🔍 ค้นหาผู้เล่น..."
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.ClearTextOnFocus = true

local searchCorner = Instance.new("UICorner")
searchCorner.Parent = searchBox
searchCorner.CornerRadius = UDim.new(0.2, 0)

-- รายชื่อผู้เล่น
local playerList = Instance.new("ScrollingFrame")
playerList.Parent = menuFrame
playerList.Size = UDim2.new(0.8, 0, 0, 100)
playerList.Position = UDim2.new(0.1, 0, 0.15, 0)
playerList.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
playerList.Visible = false
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)

local selectedPlayer = nil

local function updatePlayerList()
    playerList:ClearAllChildren()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and (searchBox.Text == "🔍 ค้นหาผู้เล่น..." or string.find(plr.Name:lower(), searchBox.Text:lower())) then
            local button = Instance.new("TextButton")
            button.Parent = playerList
            button.Size = UDim2.new(1, 0, 0, 25)
            button.Text = plr.Name
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)

            button.MouseButton1Click:Connect(function()
                selectedPlayer = plr
                searchBox.Text = "เลือก: " .. plr.Name
                playerList.Visible = false
            end)
        end
    end
end

searchBox.Focused:Connect(function()
    playerList.Visible = true
    updatePlayerList()
end)

searchBox.Changed:Connect(updatePlayerList)

local function createActionButton(icon, text, action)
    local button = Instance.new("TextButton")
    button.Parent = menuFrame
    button.Size = UDim2.new(0.8, 0, 0, 30)
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

-- ฟังก์ชันดูมุมมองผู้เล่น
createActionButton("👀", "ดูมุมมอง", function(target)
    local camera = workspace.CurrentCamera
    if target.Character and target.Character:FindFirstChild("Head") then
        camera.CameraSubject = target.Character.Head
    end
end)

-- ฟังก์ชันฆ่าผู้เล่น
createActionButton("💀", "ฆ่าผู้เล่น", function(target)
    if target.Character then
        target.Character:BreakJoints()
    end
end)

-- ฟังก์ชันวาร์ปไปหาผู้เล่น
createActionButton("🚀", "ไปหาผู้เล่น", function(target)
    if player.Character and target.Character then
        player.Character:MoveTo(target.Character:GetPrimaryPartCFrame().Position)
    end
end)

-- ฟังก์ชันดึงผู้เล่นมาหาเรา
createActionButton("🌀", "ดึงผู้เล่นมา", function(target)
    if target.Character and player.Character then
        target.Character:SetPrimaryPartCFrame(player.Character:GetPrimaryPartCFrame())
    end
end)

-- ฟังก์ชันวาร์ปไปยังจุดเกิด
createActionButton("🏠", "วาร์ปไปจุดเกิด", function()
    local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
    if player.Character and spawn then
        player.Character:MoveTo(spawn.Position)
    end
end)

-- ปุ่มเปิด/ปิดเมนู
local isMenuOpen = false
mainButton.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    menuFrame.Visible = isMenuOpen
end)

