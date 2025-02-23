local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- สร้างหน้าหลัก
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.35, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 255)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true

local frameCorner = Instance.new("UICorner")
frameCorner.Parent = mainFrame
frameCorner.CornerRadius = UDim.new(0.05, 0)

-- สร้างแถบหัวข้อ
local header = Instance.new("TextLabel")
header.Parent = mainFrame
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
header.Text = "🎮 เมนูควบคุมผู้เล่น"
header.TextColor3 = Color3.fromRGB(255, 255, 255)
header.TextSize = 18
header.Font = Enum.Font.GothamBold

local headerCorner = Instance.new("UICorner")
headerCorner.Parent = header
headerCorner.CornerRadius = UDim.new(0.1, 0)

-- ช่องค้นหาผู้เล่น
local searchBox = Instance.new("TextBox")
searchBox.Parent = mainFrame
searchBox.Size = UDim2.new(0.9, 0, 0, 30)
searchBox.Position = UDim2.new(0.05, 0, 0.12, 0)
searchBox.PlaceholderText = "🔍 ค้นหาผู้เล่น..."
searchBox.Text = ""
searchBox.TextSize = 14
searchBox.Font = Enum.Font.Gotham
searchBox.BackgroundColor3 = Color3.fromRGB(230, 230, 250)
searchBox.TextColor3 = Color3.fromRGB(100, 0, 150)

local searchCorner = Instance.new("UICorner")
searchCorner.Parent = searchBox
searchCorner.CornerRadius = UDim.new(0.1, 0)

-- รายการผู้เล่น
local playerList = Instance.new("ScrollingFrame")
playerList.Parent = mainFrame
playerList.Size = UDim2.new(0.9, 0, 0.4, 0)
playerList.Position = UDim2.new(0.05, 0, 0.2, 0)
playerList.BackgroundColor3 = Color3.fromRGB(230, 230, 250)
playerList.BorderSizePixel = 0
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)
playerList.ScrollBarThickness = 5
playerList.AutomaticCanvasSize = Enum.AutomaticSize.Y

local listCorner = Instance.new("UICorner")
listCorner.Parent = playerList
listCorner.CornerRadius = UDim.new(0.1, 0)

local selectedPlayer = nil

-- ฟังก์ชันอัปเดตรายชื่อผู้เล่น
local function updatePlayerList(searchTerm)
    playerList:ClearAllChildren()
    
    for _, plr in pairs(game.Players:GetPlayers()) do
        if searchTerm == "" or string.find(string.lower(plr.Name), string.lower(searchTerm)) then
            local playerFrame = Instance.new("Frame")
            playerFrame.Parent = playerList
            playerFrame.Size = UDim2.new(1, 0, 0, 40)
            playerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local frameCorner = Instance.new("UICorner")
            frameCorner.Parent = playerFrame
            frameCorner.CornerRadius = UDim.new(0.2, 0)

            -- รูปโปรไฟล์
            local avatar = Instance.new("ImageLabel")
            avatar.Parent = playerFrame
            avatar.Size = UDim2.new(0, 30, 0, 30)
            avatar.Position = UDim2.new(0.02, 0, 0.1, 0)
            avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..plr.UserId.."&width=48&height=48&format=png"

            -- ชื่อผู้เล่น
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = playerFrame
            nameLabel.Size = UDim2.new(0.7, 0, 1, 0)
            nameLabel.Position = UDim2.new(0.2, 0, 0, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = plr.Name
            nameLabel.TextSize = 14
            nameLabel.Font = Enum.Font.Gotham
            nameLabel.TextColor3 = Color3.fromRGB(100, 0, 150)

            -- ปุ่มเลือกผู้เล่น
            local selectButton = Instance.new("TextButton")
            selectButton.Parent = playerFrame
            selectButton.Size = UDim2.new(0, 100, 0, 30)
            selectButton.Position = UDim2.new(0.8, 0, 0.25, 0)
            selectButton.Text = "เลือก"
            selectButton.TextSize = 14
            selectButton.Font = Enum.Font.Gotham
            selectButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
            selectButton.TextColor3 = Color3.fromRGB(255, 255, 255)

            local selectCorner = Instance.new("UICorner")
            selectCorner.Parent = selectButton
            selectCorner.CornerRadius = UDim.new(0.2, 0)

            -- เมื่อกดเลือกผู้เล่น
            selectButton.MouseButton1Click:Connect(function()
                selectedPlayer = plr
                -- แสดงข้อความว่าเลือกผู้เล่นแล้ว
                nameLabel.Text = "คุณเลือก: " .. plr.Name
                showActionMenu()
            end)
        end
    end
end

-- ฟังก์ชันแสดงเมนูตัวเลือก
local function showActionMenu()
    if not selectedPlayer then return end

    -- เมนูตัวเลือก
    local actionFrame = Instance.new("Frame")
    actionFrame.Parent = mainFrame
    actionFrame.Size = UDim2.new(0.9, 0, 0, 120)
    actionFrame.Position = UDim2.new(0.05, 0, 0.65, 0)
    actionFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 250)
    
    local actionCorner = Instance.new("UICorner")
    actionCorner.Parent = actionFrame
    actionCorner.CornerRadius = UDim.new(0.1, 0)

    -- ปุ่มไปหาผู้เล่น
    local moveButton = Instance.new("TextButton")
    moveButton.Parent = actionFrame
    moveButton.Size = UDim2.new(1, 0, 0, 40)
    moveButton.Position = UDim2.new(0, 0, 0.1, 0)
    moveButton.Text = "🚶‍♂️ ไปหาผู้เล่น"
    moveButton.TextSize = 16
    moveButton.Font = Enum.Font.Gotham
    moveButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    moveButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    moveButton.MouseButton1Click:Connect(function()
        if player.Character and selectedPlayer.Character then
            player.Character:MoveTo(selectedPlayer.Character:GetPrimaryPartCFrame().Position)
        end
    end)

    -- ปุ่มดึงผู้เล่นมา
    local pullButton = Instance.new("TextButton")
    pullButton.Parent = actionFrame
    pullButton.Size = UDim2.new(1, 0, 0, 40)
    pullButton.Position = UDim2.new(0, 0, 0.3, 0)
    pullButton.Text = "🤲 ดึงผู้เล่นมา"
    pullButton.TextSize = 16
    pullButton.Font = Enum.Font.Gotham
    pullButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    pullButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    pullButton.MouseButton1Click:Connect(function()
        if selectedPlayer.Character and player.Character then
            selectedPlayer.Character:SetPrimaryPartCFrame(player.Character:GetPrimaryPartCFrame())
        end
    end)

    -- ปุ่มฆ่าผู้เล่น
    local killButton = Instance.new("TextButton")
    killButton.Parent = actionFrame
    killButton.Size = UDim2.new(1, 0, 0, 40)
    killButton.Position = UDim2.new(0, 0, 0.5, 0)
    killButton.Text = "💀 ฆ่าผู้เล่น"
    killButton.TextSize = 16
    killButton.Font = Enum.Font.Gotham
    killButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    killButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    killButton.MouseButton1Click:Connect(function()
        if selectedPlayer.Character then
            selectedPlayer.Character:BreakJoints()
        end
    end)

    -- ฟังก์ชันปิดเมนู
    local closeButton = Instance.new("TextButton")
    closeButton.Parent = actionFrame
    closeButton.Size = UDim2.new(1, 0, 0, 40)
    closeButton.Position = UDim2.new(0, 0, 0.7, 0)
    closeButton.Text = "❌ ปิดเมนู"
    closeButton.TextSize = 16
    closeButton.Font = Enum.Font.Gotham
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    closeButton.MouseButton1Click:Connect(function()
        actionFrame:Destroy()
    end)
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updatePlayerList(searchBox.Text)
end)

mainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
    if mainFrame.Visible then
        updatePlayerList("")
    end
end)

-- ฟังก์ชันเปิด/ปิดเมนู
local openButton = Instance.new("TextButton")
openButton.Parent = screenGui
openButton.Size = UDim2.new(0, 100, 0, 40)
openButton.Position = UDim2.new(0.05, 0, 0.05, 0)
openButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
openButton.Text = "🔧 เปิดเมนู"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 14

openButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
