local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- ปุ่มเปิด/ปิด UI
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0.01, 0, 0.9, 0)
toggleButton.Text = "📋 เปิดเมนู"
toggleButton.TextSize = 16
toggleButton.Font = Enum.Font.GothamBold
toggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local toggleCorner = Instance.new("UICorner")
toggleCorner.Parent = toggleButton
toggleCorner.CornerRadius = UDim.new(0.2, 0)

-- หน้าหลัก (ล็อคกลางจอ)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false

local frameCorner = Instance.new("UICorner")
frameCorner.Parent = mainFrame
frameCorner.CornerRadius = UDim.new(0.05, 0)

-- แถบหัวข้อ
local header = Instance.new("TextLabel")
header.Parent = mainFrame
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
header.Text = "🎮 เมนูควบคุมผู้เล่น"
header.TextColor3 = Color3.fromRGB(255, 255, 255)
header.TextSize = 20
header.Font = Enum.Font.GothamBold

local headerCorner = Instance.new("UICorner")
headerCorner.Parent = header
headerCorner.CornerRadius = UDim.new(0.1, 0)

-- ช่องค้นหาผู้เล่น
local searchBox = Instance.new("TextBox")
searchBox.Parent = mainFrame
searchBox.Size = UDim2.new(0.9, 0, 0, 40)
searchBox.Position = UDim2.new(0.05, 0, 0.15, 0)
searchBox.PlaceholderText = "🔍 ค้นหาผู้เล่น..."
searchBox.Text = ""
searchBox.TextSize = 16
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
playerList.Position = UDim2.new(0.05, 0, 0.25, 0)
playerList.BackgroundColor3 = Color3.fromRGB(230, 230, 250)
playerList.BorderSizePixel = 0
playerList.CanvasSize = UDim2.new(0, 0, 5, 0)
playerList.ScrollBarThickness = 5
playerList.AutomaticCanvasSize = Enum.AutomaticSize.Y

local listCorner = Instance.new("UICorner")
listCorner.Parent = playerList
listCorner.CornerRadius = UDim.new(0.1, 0)

local selectedPlayer = nil

-- ฟังก์ชันอัปเดตรายชื่อผู้เล่น พร้อมรูปโปรไฟล์
local function updatePlayerList(searchTerm)
    playerList:ClearAllChildren()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if searchTerm == "" or string.find(string.lower(plr.Name), string.lower(searchTerm)) then
            local playerFrame = Instance.new("Frame")
            playerFrame.Parent = playerList
            playerFrame.Size = UDim2.new(1, 0, 0, 50)
            playerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            playerFrame.BackgroundTransparency = 0.2

            local frameCorner = Instance.new("UICorner")
            frameCorner.Parent = playerFrame
            frameCorner.CornerRadius = UDim.new(0.2, 0)

            -- รูปโปรไฟล์
            local avatar = Instance.new("ImageLabel")
            avatar.Parent = playerFrame
            avatar.Size = UDim2.new(0, 40, 0, 40)
            avatar.Position = UDim2.new(0.02, 0, 0.1, 0)
            avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..plr.UserId.."&width=100&height=100&format=png"
            avatar.BackgroundTransparency = 1

            -- ชื่อผู้เล่น
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = playerFrame
            nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
            nameLabel.Position = UDim2.new(0.2, 0, 0, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = plr.Name
            nameLabel.TextSize = 16
            nameLabel.Font = Enum.Font.Gotham
            nameLabel.TextColor3 = Color3.fromRGB(100, 0, 150)

            -- ปุ่มเลือก
            local selectButton = Instance.new("TextButton")
            selectButton.Parent = playerFrame
            selectButton.Size = UDim2.new(0, 100, 0, 30)
            selectButton.Position = UDim2.new(0.75, 0, 0.2, 0)
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
                showActionMenu(plr)
            end)
        end
    end
end

-- แสดงเมนูคำสั่ง (แนวนอน)
local function showActionMenu(plr)
    if not plr then return end

    local actionFrame = Instance.new("Frame")
    actionFrame.Parent = mainFrame
    actionFrame.Size = UDim2.new(0.9, 0, 0, 80)
    actionFrame.Position = UDim2.new(0.05, 0, 0.7, 0)
    actionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    actionFrame.BackgroundTransparency = 0.2

    local actionCorner = Instance.new("UICorner")
    actionCorner.Parent = actionFrame
    actionCorner.CornerRadius = UDim.new(0.1, 0)

    -- ปุ่มต่าง ๆ
    local buttons = {
        {Text = "🚶‍♂️ ไปหาผู้เล่น", Action = function() player.Character:MoveTo(plr.Character:GetPrimaryPartCFrame().Position) end},
        {Text = "🤲 ดึงผู้เล่นมา", Action = function() plr.Character:SetPrimaryPartCFrame(player.Character:GetPrimaryPartCFrame()) end},
        {Text = "💀 ฆ่าผู้เล่น", Action = function() plr.Character:BreakJoints() end},
        {Text = "👁️‍🗨️ ติดตามผู้เล่น", Action = function() game.Workspace.CurrentCamera.CameraSubject = plr.Character end},
        {Text = "↩️ กลับมุมมองตัวเอง", Action = function() game.Workspace.CurrentCamera.CameraSubject = player.Character end}
    }

    local buttonWidth = 1 / #buttons

    for i, btnData in ipairs(buttons) do
        local button = Instance.new("TextButton")
        button.Parent = actionFrame
        button.Size = UDim2.new(buttonWidth, -5, 1, 0)
        button.Position = UDim2.new((i - 1) * buttonWidth, 0, 0, 0)
        button.Text = btnData.Text
        button.TextSize = 14
        button.Font = Enum.Font.Gotham
        button.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.Parent = button
        buttonCorner.CornerRadius = UDim.new(0.2, 0)

        button.MouseButton1Click:Connect(btnData.Action)
    end
end

-- เปิด/ปิด UI
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    toggleButton.Text = mainFrame.Visible and "❌ ปิดเมนู" or "📋 เปิดเมนู"
end)

-- อัปเดตผู้เล่นเมื่อพิมพ์ในช่องค้นหา
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updatePlayerList(searchBox.Text)
end)

updatePlayerList("")

