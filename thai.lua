local player = game.Players.LocalPlayer
local playerGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- สร้างหน้าหลัก
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 400, 0, 450)
mainFrame.Position = UDim2.new(0.5, -200, 0.35, 0) -- ล็อกเมนูกลางจอ
mainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 255)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false

local frameCorner = Instance.new("UICorner")
frameCorner.Parent = mainFrame
frameCorner.CornerRadius = UDim.new(0.05, 0)

-- สร้างแถบหัวข้อ
local header = Instance.new("TextLabel")
header.Parent = mainFrame
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
header.Text = "🕹️ เมนูควบคุมผู้เล่น"
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

            playerFrame.MouseButton1Click:Connect(function()
                selectedPlayer = plr
            end)
        end
    end
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updatePlayerList(searchBox.Text)
end)

mainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
    if mainFrame.Visible then
        updatePlayerList("")
    end
end)

-- ฟังก์ชันสร้างปุ่มคำสั่ง
local function createActionButton(emoji, text, pos, action)
    local button = Instance.new("TextButton")
    button.Parent = mainFrame
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, pos, 0)
    button.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    button.Text = emoji .. " " .. text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16

    local btnCorner = Instance.new("UICorner")
    btnCorner.Parent = button
    btnCorner.CornerRadius = UDim.new(0.2, 0)

    button.MouseButton1Click:Connect(function()
        if selectedPlayer then
            action(selectedPlayer)
        end
    end)
end

createActionButton("💀", "ฆ่าผู้เล่น", 0.65, function(target)
    if target.Character then
        target.Character:BreakJoints()
    end
end)

createActionButton("🚀", "ไปหาผู้เล่น", 0.75, function(target)
    if player.Character and target.Character then
        player.Character:MoveTo(target.Character:GetPrimaryPartCFrame().Position)
    end
end)

createActionButton("🔗", "ดึงผู้เล่นมา", 0.85, function(target)
    if target.Character and player.Character then
        target.Character:SetPrimaryPartCFrame(player.Character:GetPrimaryPartCFrame())
    end
end)

-- ปุ่มเปิดเมนู
local openButton = Instance.new("TextButton")
openButton.Parent = screenGui
openButton.Size = UDim2.new(0, 100, 0, 40)
openButton.Position = UDim2.new(0.5, -50, 0.1, 0)
openButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
openButton.Text = "📋 เปิดเมนู"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.Font = Enum.Font.GothamBold
openButton.TextSize = 14

openButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

