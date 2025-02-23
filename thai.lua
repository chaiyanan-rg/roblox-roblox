local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- สร้างหน้าหลัก
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 400, 0, 550)
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

-- ปุ่มเปิด/ปิดเมนู
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

-- ช่องค้นหาผู้เล่น
local searchBox = Instance.new("TextBox")
searchBox.Parent = mainFrame
searchBox.Size = UDim2.new(0.9, 0, 0, 30)
searchBox.Position = UDim2.new(0.05, 0, 0.1, 0)
searchBox.PlaceholderText = "🔍 ค้นหาผู้เล่น..."
searchBox.Text = ""
searchBox.TextSize = 14
searchBox.Font = Enum.Font.Gotham
searchBox.BackgroundColor3 = Color3.fromRGB(230, 230, 250)
searchBox.TextColor3 = Color3.fromRGB(100, 0, 150)

-- รายการผู้เล่น
local playerList = Instance.new("ScrollingFrame")
playerList.Parent = mainFrame
playerList.Size = UDim2.new(0.9, 0, 0.4, 0)
playerList.Position = UDim2.new(0.05, 0, 0.2, 0)
playerList.BackgroundColor3 = Color3.fromRGB(230, 230, 250)
playerList.CanvasSize = UDim2.new(0, 0, 1, 0)
playerList.ScrollBarThickness = 5

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = playerList
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 5)

local selectedPlayer = nil

-- เมนูตัวเลือก
local actionMenu = Instance.new("Frame")
actionMenu.Parent = mainFrame
actionMenu.Size = UDim2.new(0.9, 0, 0.35, 0)
actionMenu.Position = UDim2.new(0.05, 0, 0.65, 0)
actionMenu.BackgroundColor3 = Color3.fromRGB(240, 240, 255)
actionMenu.Visible = false

local actionLayout = Instance.new("UIListLayout")
actionLayout.Parent = actionMenu
actionLayout.SortOrder = Enum.SortOrder.LayoutOrder
actionLayout.Padding = UDim.new(0, 5)

-- รูปโปรไฟล์
local profileImage = Instance.new("ImageLabel")
profileImage.Parent = mainFrame
profileImage.Size = UDim2.new(0, 100, 0, 100)
profileImage.Position = UDim2.new(0.5, -50, 0.55, 0)
profileImage.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
profileImage.Visible = false

local profileCorner = Instance.new("UICorner")
profileCorner.Parent = profileImage
profileCorner.CornerRadius = UDim.new(1, 0)

-- ฟังก์ชันสร้างปุ่ม
local function createActionButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 16

    button.MouseButton1Click:Connect(callback)
    button.Parent = actionMenu
end

-- แสดง Action Menu พร้อมรูปโปรไฟล์
local function showActionMenu(player)
    selectedPlayer = player
    actionMenu:ClearAllChildren()

    -- ดึงรูปโปรไฟล์
    local userId = player.UserId
    local thumbnail, isReady = game.Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)

    if isReady then
        profileImage.Image = thumbnail
        profileImage.Visible = true
    end

    -- สร้างปุ่มต่าง ๆ
    createActionButton("🚶‍♂️ ไปหาผู้เล่น", function()
        if player.Character and player.Character.PrimaryPart then
            local myCharacter = game.Players.LocalPlayer.Character
            if myCharacter then
                myCharacter:MoveTo(player.Character.PrimaryPart.Position)
            end
        end
    end)

    createActionButton("🤲 ดึงผู้เล่นมา", function()
        if player.Character and player.Character.PrimaryPart then
            local myCharacter = game.Players.LocalPlayer.Character
            if myCharacter then
                player.Character:SetPrimaryPartCFrame(myCharacter.PrimaryPart.CFrame)
            end
        end
    end)

    createActionButton("💀 ฆ่าผู้เล่น", function()
        if player.Character then
            player.Character:BreakJoints()
        end
    end)

    createActionButton("👁️‍🗨️ ติดตามผู้เล่น", function()
        local camera = workspace.CurrentCamera
        camera.CameraSubject = player.Character
    end)

    createActionButton("↩️ กลับไปมุมมองตัวเอง", function()
        local camera = workspace.CurrentCamera
        camera.CameraSubject = game.Players.LocalPlayer.Character
    end)

    actionMenu.Visible = true
end

-- ฟังก์ชันอัปเดตรายชื่อผู้เล่น
local function updatePlayerList(searchTerm)
    playerList:ClearAllChildren()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if searchTerm == "" or string.find(string.lower(plr.Name), string.lower(searchTerm)) then
            local playerButton = Instance.new("TextButton")
            playerButton.Size = UDim2.new(1, 0, 0, 40)
            playerButton.BackgroundColor3 = Color3.fromRGB(200, 200, 250)
            playerButton.Text = "👤 " .. plr.Name
            playerButton.TextColor3 = Color3.fromRGB(100, 0, 150)
            playerButton.Font = Enum.Font.Gotham
            playerButton.TextSize = 14

            playerButton.MouseButton1Click:Connect(function()
                showActionMenu(plr)
            end)

            playerButton.Parent = playerList
        end
    end
    playerList.CanvasSize = UDim2.new(0, 0, 0, uiListLayout.AbsoluteContentSize.Y)
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updatePlayerList(searchBox.Text)
end)

updatePlayerList("")
